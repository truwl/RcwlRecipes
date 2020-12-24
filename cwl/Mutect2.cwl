cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- Mutect2
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  nbam:
    type: File?
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  normal:
    type: string?
    inputBinding:
      prefix: -normal
      separate: true
  germline:
    type: File?
    secondaryFiles: .idx
    inputBinding:
      prefix: --germline-resource
      separate: true
  pon:
    type: File?
    secondaryFiles: .idx
    inputBinding:
      prefix: --panel-of-normals
      separate: true
  interval:
    type: File?
    inputBinding:
      prefix: -L
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -O
      separate: true
  f1r2:
    type: string?
    inputBinding:
      prefix: --f1r2-tar-gz
      separate: true
    default: f1r2.tar.gz
outputs:
  vout:
    type: File
    secondaryFiles:
    - .idx
    - .stats
    outputBinding:
      glob: $(inputs.out)
  F1r2:
    type: File
    outputBinding:
      glob: $(inputs.f1r2)
