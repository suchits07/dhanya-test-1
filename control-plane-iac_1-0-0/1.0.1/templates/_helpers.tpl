{{/*
Logical block name. MUST be unique per Devtron environment because every block
(dev, prod, ...) renders its CRs into the SAME namespace (flux-system), so the
object names must not collide. Set via `name` in the per-env override.
*/}}
{{- define "iac.name" -}}
{{- required "name is required (and must be unique per Devtron environment)" .Values.name -}}
{{- end -}}

{{/*
Name of the Flux GitRepository object. One per block (see README for why we do
not share a single GitRepository across Devtron releases).
*/}}
{{- define "iac.sourceName" -}}
{{ include "iac.name" . }}-source
{{- end -}}

{{/*
GCS state prefix. Defaults to infra-iac-poc/<name> so dev and prod never share
tfstate. Override explicitly per env if you want a different layout.
*/}}
{{- define "iac.backendPrefix" -}}
{{- if .Values.backend.prefix -}}
{{ .Values.backend.prefix }}
{{- else -}}
infra-iac-poc/{{ include "iac.name" . }}
{{- end -}}
{{- end -}}
