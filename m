Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AE820645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="WI8JvnOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AE820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403964AbeKVMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39742 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403925AbeKVMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so6045858qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UbtUU0uGb+4XkOIZVnR92WO7SEO1Om5+CdcV75IcPiY=;
        b=WI8JvnOzKC0bSw436edpOKFQ09EiCAr+g09dawFlnSlou9zgRATpOoCsm+KjCqo6wA
         TYglEYtIK2aMZS9SF5ENp8JVJrW9ugdXf9wlhQ8cfr+GJdEweVZoIl/ntmuxSk2pdiFR
         Wz3Tpl9f3asXx2Nhw2zmCbgCnp/baWIhl5aZIXiZFICZMq3GS7/b8F7dt2e30iGm5V31
         Yzl6/2amdXm65DKx8WCAd8CNO9MwO398Uiircx942i8aIrf/hnDsmYD4ZYJJbfcolprb
         v/HYyYmUOqoScacUyp38oBYS8HKwfKuZ9ahIwW+Ug8/qmIGCMDyugCE5yRk8OvtTzy/Z
         3o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UbtUU0uGb+4XkOIZVnR92WO7SEO1Om5+CdcV75IcPiY=;
        b=MeH4AROikPDW7PScFHmeAKykJ7ZaphzRNy0Gqt+6KWFfmnjTvS1ataamT6LL+5g7Uw
         wX22g1AnCds1As5pm2Xv7y06lJF7CDxcF15MSXzjFbdVKNtzkDJohD8QPOupIT5jDLPz
         GbQEk33XdWRsU+6ZPNv1RKLj6AnlKMyajx1wpClfiz4Me3Jpo5Lx9H+PvAs+jN6rc1r8
         dURJFaFX24IOo1LnwnSbpkVqlHRLJ2dQen+X1MmkJuOrv5oxPk1sULhhte9ZpnRGLNK5
         O3ss/OgchYBhNayz6VrIphXkjK7vEcnN1NutS9MbA9hkJ7VaNt+Tk9U87LcoOovzI4Js
         9L2A==
X-Gm-Message-State: AA+aEWZ+UGzYBmwXsG5+zc4h6cm1rNAp7D/PlG4zeCpxaYlXjtVJftdM
        gxyBzz6SuT+DWp6BLGt1dj6a/g==
X-Google-Smtp-Source: AFSGD/VjtX+Y21Yfpvt1q5N3jxrFD88M099ruUnVm1LRtEFxKMmpm7Gxr0f7e7oiTqgiis154ZHTEA==
X-Received: by 2002:a37:a288:: with SMTP id l130mr7836084qke.97.1542851733394;
        Wed, 21 Nov 2018 17:55:33 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:55:32 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/9] drm/msm: add headless gpu device (for imx5)
Date:   Wed, 21 Nov 2018 20:52:31 -0500
Message-Id: <20181122015237.14534-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows using drm/msm without qcom display hardware. This is
especially useful for iMX5 hardware, which has a a2xx GPU but uses the
imx-drm driver for display.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v2: added commit message and removed unnecessary comment

 drivers/gpu/drm/msm/Kconfig       |  4 ++--
 drivers/gpu/drm/msm/msm_debugfs.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c     | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 843a9d40c05e..cf549f1ed403 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -2,7 +2,7 @@
 config DRM_MSM
 	tristate "MSM DRM"
 	depends on DRM
-	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
+	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
 	depends on OF && COMMON_CLK
 	depends on MMU
 	select QCOM_MDT_LOADER if ARCH_QCOM
@@ -11,7 +11,7 @@ config DRM_MSM
 	select DRM_PANEL
 	select SHMEM
 	select TMPFS
-	select QCOM_SCM
+	select QCOM_SCM if ARCH_QCOM
 	select WANT_DEV_COREDUMP
 	select SND_SOC_HDMI_CODEC if SND_SOC
 	select SYNC_FILE
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f0da0d3c8a80..1ca99ca356a4 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -235,7 +235,7 @@ int msm_debugfs_init(struct drm_minor *minor)
 	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
 		dev, &msm_gpu_fops);
 
-	if (priv->kms->funcs->debugfs_init) {
+	if (priv->kms && priv->kms->funcs->debugfs_init) {
 		ret = priv->kms->funcs->debugfs_init(priv->kms, minor);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 9f219e02f3c7..3f35e57202ef 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -344,6 +344,7 @@ static int msm_drm_uninit(struct device *dev)
 	return 0;
 }
 
+#define KMS_HEADLESS 1
 #define KMS_MDP4 4
 #define KMS_MDP5 5
 #define KMS_DPU  3
@@ -495,6 +496,9 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	msm_gem_shrinker_init(ddev);
 
 	switch (get_mdp_ver(pdev)) {
+	case KMS_HEADLESS:
+		priv->kms = kms = NULL;
+		break;
 	case KMS_MDP4:
 		kms = mdp4_kms_init(ddev);
 		priv->kms = kms;
@@ -512,12 +516,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	}
 
 	if (IS_ERR(kms)) {
-		/*
-		 * NOTE: once we have GPU support, having no kms should not
-		 * be considered fatal.. ideally we would still support gpu
-		 * and (for example) use dmabuf/prime to share buffers with
-		 * imx drm driver on iMX5
-		 */
 		dev_err(dev, "failed to load kms\n");
 		ret = PTR_ERR(kms);
 		goto err_msm_uninit;
@@ -633,7 +631,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	drm_mode_config_reset(ddev);
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
-	if (fbdev)
+	if (kms && fbdev)
 		priv->fbdev = msm_fbdev_init(ddev);
 #endif
 
@@ -1315,9 +1313,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	int ret;
 
-	ret = add_display_components(&pdev->dev, &match);
-	if (ret)
-		return ret;
+	if (get_mdp_ver(pdev) != KMS_HEADLESS) {
+		ret = add_display_components(&pdev->dev, &match);
+		if (ret)
+			return ret;
+	}
 
 	ret = add_gpu_components(&pdev->dev, &match);
 	if (ret)
@@ -1342,6 +1342,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },
 	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
 	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
 	{ .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
-- 
2.17.1

