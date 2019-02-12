Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AFAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F92083E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHosnJhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfBLJwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:52:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40506 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBLJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:52:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so1912825wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TlffZxLvdcjO0bcylWUqNTqWSlWh12numlyskt6S9sk=;
        b=yHosnJhOgOx+kWupjuiawToEsqLZvRUlTh7wp0p4qXxTlY5apS4TM7qTCFOLE51bUX
         5AIKPW2h9coaabV4AFZjGUR3xECOYhMbdAfuts+yq60QvqFyen2zFwt28xjIEJI7kuPW
         yS2ass/V6B1V4wj0TuMKiPx1PBjpbZbiappZUKFnbyCFonr+3PYvGffxeM94eHGBV4O/
         BirOtdP+CZwGQCD5z7Ja8QP0d9Kt6E2sdHAftRiOvgBvr/o/YsGIoowiqNKV6wipff8i
         Uf6Fvgl/oN+Hbl1pwfuqeD/0wqNWMSl3ZkRHRCzpixSyzPRrKAhxY4JvyByqZkWUrR0n
         KBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TlffZxLvdcjO0bcylWUqNTqWSlWh12numlyskt6S9sk=;
        b=SY/Ksn8zMHDhUfLzOHCAjqgrPMPNCiKMLmBjjHP2GLH4CF606rbYOAyqIvaJzlVlOS
         qWXzMBu+5DhZJzZcw9P8UorUtRza5eIf6aFyBHW9BWy50hymV/VE6nzwtRX7H3cIj4KW
         wIoUw6rvRA3EHvrNtgeaxnqqMYA52Y02bYc8dohAmW+k8kkVE4iAKonSt5mupUB+l+FW
         tFbpSAXZDMjUA2V7h8mNrnO+IX5zxLIrHoWuZxECD1svCwQAYXJcoWWyxXhplvuz6G3j
         HVVo4T3+7W3p/zQp+4e57HMsPe8+rQ/Sgf8qZFqeyoEq9/ByhM6lW4sufJhypHOK91tj
         fEWg==
X-Gm-Message-State: AHQUAuaH6c9RPk5qXqLDrl0AGY007ZbSD5bXNBzUqJrIcV3bZRLf03SB
        Gg12p82syyt8iPPKUlT/hOktmg==
X-Google-Smtp-Source: AHgI3IZglbUCWZ4CPeYlUDhAhMhQ3MsIAtDkPZrHRZIEc7nAQR/W+XDZ+zrwTyjrpk1CuCh+TaYjmw==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr2211259wro.283.1549965161612;
        Tue, 12 Feb 2019 01:52:41 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z17sm8685561wrs.75.2019.02.12.01.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 01:52:40 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     jcrouse@codeaurora.org, robdclark@gmail.com, evgreen@chromium.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH] drm/msm/a6xx: Add support for an interconnect path
Date:   Tue, 12 Feb 2019 11:52:38 +0200
Message-Id: <20190212095238.12306-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Try to get the interconnect path for the GPU and vote for the maximum
bandwidth to support all frequencies. This is needed for performance.
Later we will want to scale the bandwidth based on the frequency to
also optimize for power but that will require some device tree
infrastructure that does not yet exist.

v6: use icc_set_bw() instead of icc_set()
v5: Remove hardcoded interconnect name and just use the default
v4: Don't use a port string at all to skip the need for names in the DT
v3: Use macros and change port string per Georgi Djakov

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Acked-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Hi Greg,

If not too late, could you please take this patch into char-misc-next.
It is adding the first consumer of the interconnect API. We are just
getting the code in place, without making it functional yet, as some
DT bits are still needed to actually enable it. We have Rob's Ack to
merge this together with the interconnect code. This patch has already
spent some time in linux-next without any issues.

Thanks,
Georgi

 drivers/gpu/drm/msm/Kconfig             |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  3 +++
 4 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index cf549f1ed403..78c9e5a5e793 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -5,6 +5,7 @@ config DRM_MSM
 	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
 	depends on OF && COMMON_CLK
 	depends on MMU
+	depends on INTERCONNECT || !INTERCONNECT
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ce1b3cc4bf6d..d1662a75c7ec 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2017-2018 The Linux Foundation. All rights reserved. */
 
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/pm_opp.h>
 #include <soc/qcom/cmd-db.h>
 
@@ -84,6 +85,9 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 
 static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	int ret;
 
 	gmu_write(gmu, REG_A6XX_GMU_DCVS_ACK_OPTION, 0);
@@ -106,6 +110,12 @@ static void __a6xx_gmu_set_freq(struct a6xx_gmu *gmu, int index)
 		dev_err(gmu->dev, "GMU set GPU frequency error: %d\n", ret);
 
 	gmu->freq = gmu->gpu_freqs[index];
+
+	/*
+	 * Eventually we will want to scale the path vote with the frequency but
+	 * for now leave it at max so that the performance is nominal.
+	 */
+	icc_set_bw(gpu->icc_path, 0, MBps_to_icc(7216));
 }
 
 void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
@@ -705,6 +715,8 @@ int a6xx_gmu_reset(struct a6xx_gpu *a6xx_gpu)
 
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	int status, ret;
 
@@ -720,6 +732,9 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	if (ret)
 		goto out;
 
+	/* Set the bus quota to a reasonable value for boot */
+	icc_set_bw(gpu->icc_path, 0, MBps_to_icc(3072));
+
 	a6xx_gmu_irq_enable(gmu);
 
 	/* Check to see if we are doing a cold or warm boot */
@@ -760,6 +775,8 @@ bool a6xx_gmu_isidle(struct a6xx_gmu *gmu)
 
 int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
@@ -806,6 +823,9 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 	/* Tell RPMh to power off the GPU */
 	a6xx_rpmh_stop(gmu);
 
+	/* Remove the bus vote */
+	icc_set_bw(gpu->icc_path, 0, 0);
+
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 
 	pm_runtime_put_sync(gmu->dev);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 2cfee1a4fe0b..27898475cdf4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/ascii85.h>
+#include <linux/interconnect.h>
 #include <linux/kernel.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
@@ -747,6 +748,11 @@ static int adreno_get_pwrlevels(struct device *dev,
 
 	DBG("fast_rate=%u, slow_rate=27000000", gpu->fast_rate);
 
+	/* Check for an interconnect path for the bus */
+	gpu->icc_path = of_icc_get(dev, NULL);
+	if (IS_ERR(gpu->icc_path))
+		gpu->icc_path = NULL;
+
 	return 0;
 }
 
@@ -787,10 +793,13 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 {
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	icc_put(gpu->icc_path);
+
 	msm_gpu_cleanup(&adreno_gpu->base);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index ca17086f72c9..6241986bab51 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -19,6 +19,7 @@
 #define __MSM_GPU_H__
 
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/regulator/consumer.h>
 
 #include "msm_drv.h"
@@ -118,6 +119,8 @@ struct msm_gpu {
 	struct clk *ebi1_clk, *core_clk, *rbbmtimer_clk;
 	uint32_t fast_rate;
 
+	struct icc_path *icc_path;
+
 	/* Hang and Inactivity Detection:
 	 */
 #define DRM_MSM_INACTIVE_PERIOD   66 /* in ms (roughly four frames) */
