Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D52C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D33A20866
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="A4jHMD2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D33A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbeKOIcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34053 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389513AbeKOIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so28812075qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vK3k5i7adfxi/vPlBXMS1H9r3A7WHRxwZ+r5fGAERMs=;
        b=A4jHMD2WQj/jD5FJVavjmVMIOLUqjDlU9iRjwlD31lHGw/tlMEAvnsCNRZSFA/Ngl6
         X3gta/Wt+d6xUqFT6Uh3ulDgMTa5eorct2r2DKys8pq3bO+SCKWFjw+zzI9SxsEg01qp
         lzVghCHlgMgPQdPivU1w+SsY9VRsJr8hRJLzabtx7GldBElOkP7sG3FsRa5w3Q6bXcn6
         n5tCLUDrw0tCtjBDR9cAOqaqHeFH8a+sUcTb4+UEd6YhME9xE2qPI/WZ7Q63UiTbzTwz
         6FxxFIrNJJHt2kMgeniFr6/2hqXAOKIIyP8zuOhF8ZwJguryVnBk8qzH7x1KYmf2zSdW
         FB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vK3k5i7adfxi/vPlBXMS1H9r3A7WHRxwZ+r5fGAERMs=;
        b=JeQx+j3Q2/bb2GxKduPoqXCgYyDkxMpRJq4WLtMMOlNzatW4zgVAzn3C4VgJshky5f
         vhfaQ9wT4NE+vROJzOMSUBSUe3BnH5D4G97FGdHi8cb1Iu7YPho1bWjFkW36MNwl8Csx
         lYp7Hkb1QhRGzDDBNvzj59PEzeLWYdoxjqG45tLpu100R6g4SxHOrpQPd5Jb/cxMkMFb
         +RH9F9dn1THjH4J3O9wkCANJI3IDlU0oOLJ9tXojk4XSYZkj+4EbxTBQuw4X+BF4parL
         qLR6ioII80RYRg/5CF5iE3rOoYm6e6kuEPgdEoWaBQnOiGaGYVzV1My5RHbNoy8CvfDB
         9v4Q==
X-Gm-Message-State: AGRZ1gLRJC5iTkn7SVsa3ohb1ESp4XWLyRkq9kRZTwDF+iadYl3sBXNh
        lm8nBOrrV4XZzcAcMBKhKkNDjw==
X-Google-Smtp-Source: AJdET5cFE1J3Sf3SpKhk2CmFxAKgMYNbIGjeHMFa3IH7plsjFhB+YdObVZAj6gD/Ur0zTddKFTrcow==
X-Received: by 2002:a37:7e86:: with SMTP id z128mr3536676qkc.20.1542234462986;
        Wed, 14 Nov 2018 14:27:42 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.27.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:27:42 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/9] drm/msm: add headless gpu device (for imx5)
Date:   Wed, 14 Nov 2018 17:24:12 -0500
Message-Id: <20181114222418.15960-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/Kconfig       |  4 ++--
 drivers/gpu/drm/msm/msm_debugfs.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c     | 15 +++++++++++----
 include/linux/qcom_scm.h          |  3 +++
 4 files changed, 17 insertions(+), 7 deletions(-)

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
index 9f219e02f3c7..a10cc0298d38 100644
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
@@ -633,7 +637,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	drm_mode_config_reset(ddev);
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
-	if (fbdev)
+	if (kms && fbdev)
 		priv->fbdev = msm_fbdev_init(ddev);
 #endif
 
@@ -1315,9 +1319,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
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
@@ -1342,6 +1348,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },
 	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
 	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
 	{ .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 06996ad4f2bc..1637385bcc17 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -67,6 +67,9 @@ extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 #else
+
+#include <linux/errno.h>
+
 static inline
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
 {
-- 
2.17.1

