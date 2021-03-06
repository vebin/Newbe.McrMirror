$config = Get-Content config-v2.json | ConvertFrom-Json
$tpl = Get-Content .\template.yml

$outDir = "../../.github/workflows"

$config.images | ForEach-Object {
    $sourceName = $_.source
    $targetName = $_.tag
    $filename = $targetName.Replace("/", "_").Replace(":", "_")
    $content = $tpl.Replace("[FILE_NAME]", $filename).Replace("[SOURCE_IMAGE_NAME]", $sourceName).Replace("[TARGET_IMAGE_NAME]", $targetName).Replace("[DOCKERHUB_USERNAME]", $config.dockerhub_name).Replace("[DOCKERHUB_NAMESPACE]", $config.dockerhub_namespace).Replace("[ALIYUN_USERNAME]", $config.aliyun_name).Replace("[ALIYUN_NAMESPACE]", $config.aliyun_namespace).Replace("[TENCENTYUN_USERNAME]", $config.tencentyun_name).Replace("[TENCENTYUN_NAMESPACE]", $config.tencentyun_namespace)
    $content | Out-File "$outDir/docker_$($filename).yml" -Encoding utf8NoBOM
}