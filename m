Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79402082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="NiDVo+Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79402082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLDPUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:20:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45050 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLDPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:20:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so18379325qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ko4Y7Uyh13FJDGl/9r6xGDDp7+352wGvWojGv/9q9YQ=;
        b=NiDVo+Rf/QYBkRz6VRnN1B0oCjDHQKchT4tTOWajvyRLpwu47dmInhMlu6N1n0fKn+
         l9g8vw7hZVLARpNMWLL65w4k5qRtG/YmHurszXQyt65se9JdrTXEZY1HopZNKx+4XaOS
         FjmmwkmwzyP6QOAwqX7bhWrtS3ZMeRqVwmErhIDLff8eOMNdYH25TaGXl6m6dAAFKged
         GgWQGojkXJbCaN8uwFfUSX7F7KyE5m+71Q92WW6FevJhU0QpSkwQxySSZZoRp9rSzt5P
         Fcn3tMHyTD2YGUH/dxeR8WVHVaO7tEfK2wTz6bJ+Pi+o8MoItmn/Yvd1EjPw7nqcEYj+
         ytiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ko4Y7Uyh13FJDGl/9r6xGDDp7+352wGvWojGv/9q9YQ=;
        b=O/09yaUjRbrGCJ71lVcpTMq1Gqhi7PHqKtBB+q1wm2JRX4hNX0r7f+Q32BXCC17Cbq
         PuhhMbJaCn+gsLHJ8j7TFF8bq6dQzMmCTM6FiOeN6MHhOoYeQjBKeOHGmqZYVT8aNxdu
         vifGz8V5K6dXrB4u1dFqmSOaxYWgMyXZFIpQ3MDvZv10vt0bQsoq9tiuQ6Xkux/LBVMi
         meTB7zp5nt27qQ7TIPFpCeUER7HPepwuqSzvN/d3kVDFDNhMb7SuNSYU4xK8g/5oEVZ6
         y4b796oMVkfwpz8oiYYNTvblyy87bKh3xObzE8hkigywyGOXdueAf9rv8esykk5nncki
         Ee0g==
X-Gm-Message-State: AA+aEWavMLlj24XRsJG5eG/nW+uDQkttFaUySRF+uO2FS3pN2SijafUZ
        aJ9qSrgz+83jRhZ1x5kw4udGKQ==
X-Google-Smtp-Source: AFSGD/UErJBXBNLB3H5nDM4FLyRTcepdU4eI825gAncFLOTjiOTv4tK6K0ev5w9q4P4JDBG5Q6O47Q==
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr14305187qtj.365.1543936799841;
        Tue, 04 Dec 2018 07:19:59 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q17sm11053989qtc.19.2018.12.04.07.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:19:59 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/5] drm/msm: add headless gpu device for imx5
Date:   Tue,  4 Dec 2018 10:16:58 -0500
Message-Id: <20181204151702.8514-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204151702.8514-1-jonathan@marek.ca>
References: <20181204151702.8514-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows using drm/msm without qcom display hardware. It adds a
amd,imageon compatible, which is used instead of qcom,adreno, but does
not require a top level msm node.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v3: reworked to work with only a amd,imageon node

 drivers/gpu/drm/msm/Kconfig                |  4 +--
 drivers/gpu/drm/msm/adreno/adreno_device.c | 35 ++++++++++++++++++++--
 drivers/gpu/drm/msm/msm_debugfs.c          |  2 +-
 drivers/gpu/drm/msm/msm_drv.c              | 21 +++++++------
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 843a9d40c..cf549f1ed 100644
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
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index adc442f73..99e363c3d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -271,7 +271,8 @@ static int find_chipid(struct device *dev, struct adreno_rev *rev)
 	if (ret == 0) {
 		unsigned int r, patch;
 
-		if (sscanf(compat, "qcom,adreno-%u.%u", &r, &patch) == 2) {
+		if (sscanf(compat, "qcom,adreno-%u.%u", &r, &patch) == 2 ||
+		    sscanf(compat, "amd,imageon-%u.%u", &r, &patch) == 2) {
 			rev->core = r / 100;
 			r %= 100;
 			rev->major = r / 10;
@@ -356,9 +357,37 @@ static const struct component_ops a3xx_ops = {
 		.unbind = adreno_unbind,
 };
 
+static void adreno_device_register_headless(void)
+{
+	/* on imx5, we don't have a top-level mdp/dpu node
+	 * this creates a dummy node for the driver for that case
+	 */
+	struct platform_device_info dummy_info = {
+		.parent = NULL,
+		.name = "msm",
+		.id = -1,
+		.res = NULL,
+		.num_res = 0,
+		.data = NULL,
+		.size_data = 0,
+		.dma_mask = ~0,
+	};
+	platform_device_register_full(&dummy_info);
+}
+
 static int adreno_probe(struct platform_device *pdev)
 {
-	return component_add(&pdev->dev, &a3xx_ops);
+
+	int ret;
+
+	ret = component_add(&pdev->dev, &a3xx_ops);
+	if (ret)
+		return ret;
+
+	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon"))
+		adreno_device_register_headless();
+
+	return 0;
 }
 
 static int adreno_remove(struct platform_device *pdev)
@@ -370,6 +399,8 @@ static int adreno_remove(struct platform_device *pdev)
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,adreno-3xx" },
+	/* for compatibility with imx5 gpu: */
+	{ .compatible = "amd,imageon" },
 	/* for backwards compat w/ downstream kgsl DT files: */
 	{ .compatible = "qcom,kgsl-3d0" },
 	{}
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index 9a7cf9fe2..fb423d309 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -242,7 +242,7 @@ int msm_debugfs_init(struct drm_minor *minor)
 	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
 		dev, &msm_gpu_fops);
 
-	if (priv->kms->funcs->debugfs_init) {
+	if (priv->kms && priv->kms->funcs->debugfs_init) {
 		ret = priv->kms->funcs->debugfs_init(priv->kms, minor);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 81bfac744..7842518a9 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -510,17 +510,13 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 		priv->kms = kms;
 		break;
 	default:
-		kms = ERR_PTR(-ENODEV);
+		/* valid only for the dummy headless case, where of_node=NULL */
+		WARN_ON(dev->of_node);
+		kms = NULL;
 		break;
 	}
 
 	if (IS_ERR(kms)) {
-		/*
-		 * NOTE: once we have GPU support, having no kms should not
-		 * be considered fatal.. ideally we would still support gpu
-		 * and (for example) use dmabuf/prime to share buffers with
-		 * imx drm driver on iMX5
-		 */
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
 		ret = PTR_ERR(kms);
 		priv->kms = NULL;
@@ -620,7 +616,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	drm_mode_config_reset(ddev);
 
 #ifdef CONFIG_DRM_FBDEV_EMULATION
-	if (fbdev)
+	if (kms && fbdev)
 		priv->fbdev = msm_fbdev_init(ddev);
 #endif
 
@@ -1302,6 +1298,7 @@ static int add_display_components(struct device *dev,
 static const struct of_device_id msm_gpu_match[] = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,adreno-3xx" },
+	{ .compatible = "amd,imageon" },
 	{ .compatible = "qcom,kgsl-3d0" },
 	{ },
 };
@@ -1346,9 +1343,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	int ret;
 
-	ret = add_display_components(&pdev->dev, &match);
-	if (ret)
-		return ret;
+	if (get_mdp_ver(pdev)) {
+		ret = add_display_components(&pdev->dev, &match);
+		if (ret)
+			return ret;
+	}
 
 	ret = add_gpu_components(&pdev->dev, &match);
 	if (ret)
-- 
2.17.1

