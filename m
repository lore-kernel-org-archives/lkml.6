Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C065920868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="TZZk/jn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C065920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbeKOIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:33:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42832 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387528AbeKOIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:33:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id m5so28798513qka.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aPqfs/8UBLAjl1QVeO/d8i8u2f3v5JaYH9UHLvL7+S0=;
        b=TZZk/jn9JxECqscLqAhZ9LE8VUHDpN9xNl6Lc8g+InIcIUgffqLPk5W+l5kDhpwlzd
         6sUaiPJn7iigkQgwZp58SPAyrmUsgJvrRPcvtt1D5jJM7Gg1Uzom0XRX0K2+pQkXGJKc
         v1/qwWbz7FVkThvGWlWK6Cil65oxxMb6EqwP6DnSukQvI5hRVgiCXvjipnjWhI6rB6lS
         xGamGnI90PHxDJ0S1n4G+ht7CtWRia+YHSDgzb9jdGXcKHsMTot6w8lDz6woOQdw3eyy
         xLEF9pqsD1Yww9gtB8JpGOhJ1FGLEKgCAC+6p6ioxCwfXzO/a9RN18dTZLV7MMavg4hR
         nHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aPqfs/8UBLAjl1QVeO/d8i8u2f3v5JaYH9UHLvL7+S0=;
        b=QVjB+MTF45Sx71+mQkydZ1YCurhbSjOOUSFfpYVg4smtzkfqtbqsxLIb/4xV0PV6PL
         6rdATbisPeY7FV2H4XbeHVLYG4R5G23wOA3qm1D+jvs5/nZSKU4Fr3CESo2u6MhnwJ3J
         FF6QPPaURkZ4kMZORGlAof/9V3Tl+UPj/Viri6SSPa63yew/I/0bH8d2/LewzPB1QjBv
         Ch2vyi/0kCrkoeUzbnBUShvf7Y83lDZ/eUNQhva2jZqrrCgtdPY3ry8zm0ilb1vGj8hj
         l3JoDn1jqzu0hoaiWzC5o4+AKktIiBWvSmujEdVf729gZrMzENhU6yr42TcsXjDBpt65
         RpeQ==
X-Gm-Message-State: AGRZ1gI3xtBKO0XLvcN1BU2hTQgri59xGRBfFcYlvRbNgDt2z3m8i8h6
        lXsY/nKFzdeIirTv1rW8hSYpMw==
X-Google-Smtp-Source: AJdET5eJiXcfk55uwGHNssfs2Aq+EwjQz2lGArmwV4BrubjUb1C4wrPkp/bhLn/pzMW+wPCRV4fxKw==
X-Received: by 2002:ac8:3ae5:: with SMTP id x92mr3754170qte.370.1542234491449;
        Wed, 14 Nov 2018 14:28:11 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 24sm24067595qkp.65.2018.11.14.14.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:28:10 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU)
Subject: [PATCH 7/9] drm/msm: implement a2xx mmu
Date:   Wed, 14 Nov 2018 17:24:14 -0500
Message-Id: <20181114222418.15960-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222418.15960-1-jonathan@marek.ca>
References: <20181114222418.15960-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A2XX has its own very simple MMU.

Added a msm_use_mmu() function because we can't rely on iommu_present to
decide to use MMU or not.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/Makefile               |   3 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  57 +++++++++--
 drivers/gpu/drm/msm/adreno/adreno_device.c |   3 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  15 +++
 drivers/gpu/drm/msm/msm_drv.c              |  11 +-
 drivers/gpu/drm/msm/msm_drv.h              |   8 ++
 drivers/gpu/drm/msm/msm_gem.c              |   4 +-
 drivers/gpu/drm/msm/msm_gem_vma.c          |  23 +++++
 drivers/gpu/drm/msm/msm_gpu.c              |  26 +++--
 drivers/gpu/drm/msm/msm_gpummu.c           | 113 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h              |   3 +
 11 files changed, 243 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/msm_gpummu.c

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 0170766393ea..004574bc9bd3 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -91,7 +91,8 @@ msm-y := \
 	msm_perf.o \
 	msm_rd.o \
 	msm_ringbuffer.o \
-	msm_submitqueue.o
+	msm_submitqueue.o \
+	msm_gpummu.o
 
 msm-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
 			  disp/dpu1/dpu_dbg.o
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 65b2352408fa..dd669f046389 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -2,6 +2,8 @@
 /* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
 
 #include "a2xx_gpu.h"
+#include "msm_gem.h"
+#include "msm_mmu.h"
 
 extern bool hang_debug;
 
@@ -58,9 +60,12 @@ static bool a2xx_me_init(struct msm_gpu *gpu)
 static int a2xx_hw_init(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	dma_addr_t pt_base, tran_error;
 	uint32_t *ptr, len;
 	int i, ret;
 
+	msm_gpummu_params(gpu->aspace->mmu, &pt_base, &tran_error);
+
 	DBG("%s", gpu->name);
 
 	gpu_write(gpu, REG_A2XX_RBBM_PM_OVERRIDE1, 0xfffffffe);
@@ -77,9 +82,34 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 	/* XXX kgsl uses 0x0000ffff for a20x */
 	gpu_write(gpu, REG_A2XX_RBBM_CNTL, 0x00004442);
 
-	gpu_write(gpu, REG_A2XX_MH_MMU_CONFIG, 0);
-	gpu_write(gpu, REG_A2XX_MH_MMU_MPU_BASE, 0);
+	/* MPU: physical range */
+	gpu_write(gpu, REG_A2XX_MH_MMU_MPU_BASE, 0x00000000);
 	gpu_write(gpu, REG_A2XX_MH_MMU_MPU_END, 0xfffff000);
+
+	gpu_write(gpu, REG_A2XX_MH_MMU_CONFIG, A2XX_MH_MMU_CONFIG_MMU_ENABLE |
+		A2XX_MH_MMU_CONFIG_RB_W_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_CP_W_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_CP_R0_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_CP_R1_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_CP_R2_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_CP_R3_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_CP_R4_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_VGT_R0_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_VGT_R1_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_TC_R_CLNT_BEHAVIOR(BEH_TRAN_RNG) |
+		A2XX_MH_MMU_CONFIG_PA_W_CLNT_BEHAVIOR(BEH_TRAN_RNG));
+
+	/* same as parameters in adreno_gpu */
+	gpu_write(gpu, REG_A2XX_MH_MMU_VA_RANGE, SZ_16M |
+		A2XX_MH_MMU_VA_RANGE_NUM_64KB_REGIONS(0xfff));
+
+	gpu_write(gpu, REG_A2XX_MH_MMU_PT_BASE, pt_base);
+	gpu_write(gpu, REG_A2XX_MH_MMU_TRAN_ERROR, tran_error);
+
+	gpu_write(gpu, REG_A2XX_MH_MMU_INVALIDATE,
+		A2XX_MH_MMU_INVALIDATE_INVALIDATE_ALL |
+		A2XX_MH_MMU_INVALIDATE_INVALIDATE_TC);
+
 	gpu_write(gpu, REG_A2XX_MH_ARBITER_CONFIG,
 		A2XX_MH_ARBITER_CONFIG_SAME_PAGE_LIMIT(16) |
 		A2XX_MH_ARBITER_CONFIG_L1_ARB_ENABLE |
@@ -106,9 +136,21 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 	/* XXX gsl doesn't set this */
 	gpu_write(gpu, REG_A2XX_RBBM_DEBUG, 0x00080000);
 
-	gpu_write(gpu, REG_A2XX_RBBM_INT_CNTL, 0);
-	gpu_write(gpu, REG_AXXX_CP_INT_CNTL, 0x80000000); /* RB INT */
+	gpu_write(gpu, REG_A2XX_RBBM_INT_CNTL,
+		A2XX_RBBM_INT_CNTL_RDERR_INT_MASK);
+	gpu_write(gpu, REG_AXXX_CP_INT_CNTL,
+		AXXX_CP_INT_CNTL_T0_PACKET_IN_IB_MASK |
+		AXXX_CP_INT_CNTL_OPCODE_ERROR_MASK |
+		AXXX_CP_INT_CNTL_PROTECTED_MODE_ERROR_MASK |
+		AXXX_CP_INT_CNTL_RESERVED_BIT_ERROR_MASK |
+		AXXX_CP_INT_CNTL_IB_ERROR_MASK |
+		AXXX_CP_INT_CNTL_IB1_INT_MASK |
+		AXXX_CP_INT_CNTL_RB_INT_MASK);
 	gpu_write(gpu, REG_A2XX_SQ_INT_CNTL, 0);
+	gpu_write(gpu, REG_A2XX_MH_INTERRUPT_MASK,
+		A2XX_MH_INTERRUPT_MASK_AXI_READ_ERROR |
+		A2XX_MH_INTERRUPT_MASK_AXI_WRITE_ERROR |
+		A2XX_MH_INTERRUPT_MASK_MMU_PAGE_FAULT);
 
 	for (i = 3; i <= 5; i++)
 		if ((SZ_16K << i) == adreno_gpu->gmem)
@@ -205,7 +247,6 @@ static bool a2xx_idle(struct msm_gpu *gpu)
 
 static irqreturn_t a2xx_irq(struct msm_gpu *gpu)
 {
-
 	uint32_t mstatus, status;
 
 	mstatus = gpu_read(gpu, REG_A2XX_MASTER_INT_SIGNAL);
@@ -216,6 +257,7 @@ static irqreturn_t a2xx_irq(struct msm_gpu *gpu)
 		dev_warn(gpu->dev->dev, "MH_INT: %08X\n", status);
 		dev_warn(gpu->dev->dev, "MMU_PAGE_FAULT: %08X\n",
 			gpu_read(gpu, REG_A2XX_MH_MMU_PAGE_FAULT));
+
 		gpu_write(gpu, REG_A2XX_MH_INTERRUPT_CLEAR, status);
 	}
 
@@ -430,11 +472,6 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	if (ret)
 		goto fail;
 
-	if (!gpu->aspace) {
-		/* MMU is not implemented...  */
-		dev_err(dev->dev, "No memory protection without MMU\n");
-	}
-
 	return gpu;
 
 fail:
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 6e3f78d4da5d..f651cd51449b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -307,6 +307,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	static struct adreno_platform_config config = {};
 	const struct adreno_info *info;
 	struct drm_device *drm = dev_get_drvdata(master);
+	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu *gpu;
 	int ret;
 
@@ -337,6 +338,8 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 
 	dev_set_drvdata(dev, gpu);
 
+	priv->is_a2xx = config.rev.core == 2;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index e09671324b05..18736637c933 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -24,6 +24,7 @@
 #include "adreno_gpu.h"
 #include "msm_gem.h"
 #include "msm_mmu.h"
+#include "a2xx_gpu.h"
 
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value)
 {
@@ -290,6 +291,17 @@ void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned i;
 
+	if (adreno_is_a2xx(adreno_gpu)) {
+		/* tlb flush for a2xx MMU. TODO: only do this when required */
+		OUT_PKT3(ring, CP_SET_PROTECTED_MODE, 1);
+		OUT_RING(ring, 0);
+		OUT_PKT0(ring, REG_A2XX_MH_MMU_INVALIDATE, 1);
+		OUT_RING(ring, A2XX_MH_MMU_INVALIDATE_INVALIDATE_ALL |
+			A2XX_MH_MMU_INVALIDATE_INVALIDATE_TC);
+		OUT_PKT3(ring, CP_SET_PROTECTED_MODE, 1);
+		OUT_RING(ring, 1);
+	}
+
 	for (i = 0; i < submit->nr_cmds; i++) {
 		switch (submit->cmd[i].type) {
 		case MSM_SUBMIT_CMD_IB_TARGET_BUF:
@@ -728,6 +740,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu_config.va_start = SZ_16M;
 	adreno_gpu_config.va_end = 0xffffffff;
+	/* maximum range of a2xx mmu */
+	if (adreno_is_a2xx(adreno_gpu))
+		adreno_gpu_config.va_end = SZ_16M + 0xfff * SZ_64K;
 
 	adreno_gpu_config.nr_rings = nr_rings;
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index a10cc0298d38..bda23011494d 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -25,6 +25,7 @@
 #include "msm_fence.h"
 #include "msm_gpu.h"
 #include "msm_kms.h"
+#include "adreno/adreno_gpu.h"
 
 
 /*
@@ -358,6 +359,14 @@ static int get_mdp_ver(struct platform_device *pdev)
 
 #include <linux/of_address.h>
 
+bool msm_use_mmu(struct drm_device *dev)
+{
+	struct msm_drm_private *priv = dev->dev_private;
+
+	/* a2xx comes with its own MMU */
+	return priv->is_a2xx || iommu_present(&platform_bus_type);
+}
+
 static int msm_init_vram(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -396,7 +405,7 @@ static int msm_init_vram(struct drm_device *dev)
 		 * Grab the entire CMA chunk carved out in early startup in
 		 * mach-msm:
 		 */
-	} else if (!iommu_present(&platform_bus_type)) {
+	} else if (!msm_use_mmu(dev)) {
 		DRM_INFO("using %s VRAM carveout\n", vram);
 		size = memparse(vram, NULL);
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9d11f321f5a9..99a37962e92b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -179,6 +179,8 @@ struct msm_drm_private {
 	/* when we have more than one 'msm_gpu' these need to be an array: */
 	struct msm_gpu *gpu;
 	struct msm_file_private *lastctx;
+	/* gpu is only set on open(), but we need this info earlier */
+	bool is_a2xx;
 
 	struct drm_fb_helper *fbdev;
 
@@ -252,9 +254,15 @@ struct msm_gem_address_space *
 msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 		const char *name);
 
+struct msm_gem_address_space *
+msm_gem_address_space_create_a2xx(struct device *dev, struct msm_gpu *gpu,
+		const char *name, uint64_t va_start, uint64_t va_end);
+
 int msm_register_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 void msm_unregister_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 
+bool msm_use_mmu(struct drm_device *dev);
+
 void msm_gem_submit_free(struct msm_gem_submit *submit);
 int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_file *file);
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 6657453a3a58..c1ef8780f686 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -912,7 +912,7 @@ static struct drm_gem_object *_msm_gem_new(struct drm_device *dev,
 
 	size = PAGE_ALIGN(size);
 
-	if (!iommu_present(&platform_bus_type))
+	if (!msm_use_mmu(dev))
 		use_vram = true;
 	else if ((flags & (MSM_BO_STOLEN | MSM_BO_SCANOUT)) && priv->vram.size)
 		use_vram = true;
@@ -991,7 +991,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	int ret, npages;
 
 	/* if we don't have IOMMU, don't bother pretending we can import: */
-	if (!iommu_present(&platform_bus_type)) {
+	if (!msm_use_mmu(dev)) {
 		dev_err(dev->dev, "cannot import without IOMMU\n");
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index ffbec224551b..8075fd699803 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -114,3 +114,26 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 
 	return aspace;
 }
+
+struct msm_gem_address_space *
+msm_gem_address_space_create_a2xx(struct device *dev, struct msm_gpu *gpu,
+		const char *name, uint64_t va_start, uint64_t va_end)
+{
+	struct msm_gem_address_space *aspace;
+	u64 size = va_end - va_start;
+
+	aspace = kzalloc(sizeof(*aspace), GFP_KERNEL);
+	if (!aspace)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&aspace->lock);
+	aspace->name = name;
+	aspace->mmu = msm_gpummu_new(dev, gpu);
+
+	drm_mm_init(&aspace->mm, (va_start >> PAGE_SHIFT),
+		size >> PAGE_SHIFT);
+
+	kref_init(&aspace->kref);
+
+	return aspace;
+}
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 11aac8337066..9af24a1a70a0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -19,6 +19,7 @@
 #include "msm_gem.h"
 #include "msm_mmu.h"
 #include "msm_fence.h"
+#include "adreno/adreno_gpu.h"
 
 #include <generated/utsrelease.h>
 #include <linux/string_helpers.h>
@@ -800,7 +801,7 @@ static struct msm_gem_address_space *
 msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 		uint64_t va_start, uint64_t va_end)
 {
-	struct iommu_domain *iommu;
+	struct iommu_domain *iommu = NULL;
 	struct msm_gem_address_space *aspace;
 	int ret;
 
@@ -809,20 +810,27 @@ msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 	 * and have separate page tables per context.  For now, to keep things
 	 * simple and to get something working, just use a single address space:
 	 */
-	iommu = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu)
-		return NULL;
+	if (!adreno_is_a2xx(to_adreno_gpu(gpu))) {
+		iommu = iommu_domain_alloc(&platform_bus_type);
+		if (!iommu)
+			return NULL;
 
-	iommu->geometry.aperture_start = va_start;
-	iommu->geometry.aperture_end = va_end;
+		iommu->geometry.aperture_start = va_start;
+		iommu->geometry.aperture_end = va_end;
 
-	dev_info(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
+		dev_info(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
+
+		aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
+	} else {
+		aspace = msm_gem_address_space_create_a2xx(&pdev->dev, gpu, "gpu",
+			va_start, va_end);
+	}
 
-	aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
 	if (IS_ERR(aspace)) {
 		dev_err(gpu->dev->dev, "failed to init iommu: %ld\n",
 			PTR_ERR(aspace));
-		iommu_domain_free(iommu);
+		if (iommu)
+			iommu_domain_free(iommu);
 		return ERR_CAST(aspace);
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
new file mode 100644
index 000000000000..f14cf7759c7f
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
+
+#include "msm_drv.h"
+#include "msm_mmu.h"
+
+struct msm_gpummu {
+	struct msm_mmu base;
+	struct msm_gpu *gpu;
+	dma_addr_t pt_base;
+	uint32_t *table;
+};
+#define to_msm_gpummu(x) container_of(x, struct msm_gpummu, base)
+
+#define VA_START SZ_16M
+#define VA_RANGE (0xfff * SZ_64K)
+#define MMU_PAGE_SIZE SZ_4K
+#define TABLE_SIZE (sizeof(uint32_t) * VA_RANGE / MMU_PAGE_SIZE)
+
+static int msm_gpummu_attach(struct msm_mmu *mmu, const char * const *names,
+		int cnt)
+{
+	return 0;
+}
+
+static void msm_gpummu_detach(struct msm_mmu *mmu, const char * const *names,
+		int cnt)
+{
+}
+
+static void update_pt(struct msm_mmu *mmu, uint64_t iova,
+		struct sg_table *sgt, unsigned len, unsigned prot)
+{
+	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
+	unsigned idx = (iova - VA_START) / MMU_PAGE_SIZE;
+	struct scatterlist *sg;
+	unsigned i, j;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		dma_addr_t addr = sg->dma_address;
+		for (j = 0; j < sg->length / MMU_PAGE_SIZE; j++, idx++) {
+			gpummu->table[idx] = prot ? addr | prot : 0;
+			addr += MMU_PAGE_SIZE;
+		}
+	}
+}
+
+static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
+		struct sg_table *sgt, unsigned len, int prot)
+{
+	unsigned prot_bits = 0;
+	if (prot & IOMMU_WRITE)
+		prot_bits |= 1;
+	if (prot & IOMMU_READ)
+		prot_bits |= 2;
+	update_pt(mmu, iova, sgt, len, prot_bits);
+	return 0;
+}
+
+static int msm_gpummu_unmap(struct msm_mmu *mmu, uint64_t iova,
+		struct sg_table *sgt, unsigned len)
+{
+	update_pt(mmu, iova, sgt, len, 0);
+	return 0;
+}
+
+static void msm_gpummu_destroy(struct msm_mmu *mmu)
+{
+	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
+
+	dma_free_attrs(mmu->dev, TABLE_SIZE, gpummu->table, gpummu->pt_base,
+		DMA_ATTR_FORCE_CONTIGUOUS);
+
+	kfree(gpummu);
+}
+
+static const struct msm_mmu_funcs funcs = {
+		.attach = msm_gpummu_attach,
+		.detach = msm_gpummu_detach,
+		.map = msm_gpummu_map,
+		.unmap = msm_gpummu_unmap,
+		.destroy = msm_gpummu_destroy,
+};
+
+struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
+{
+	struct msm_gpummu *gpummu;
+
+	gpummu = kzalloc(sizeof(*gpummu), GFP_KERNEL);
+	if (!gpummu)
+		return ERR_PTR(-ENOMEM);
+
+	gpummu->table = dma_alloc_attrs(dev, TABLE_SIZE + 32, &gpummu->pt_base,
+		GFP_KERNEL | __GFP_ZERO, DMA_ATTR_FORCE_CONTIGUOUS);
+	if (!gpummu->table) {
+		kfree(gpummu);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	gpummu->gpu = gpu;
+	msm_mmu_init(&gpummu->base, dev, &funcs);
+
+	return &gpummu->base;
+}
+
+void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
+		dma_addr_t *tran_error)
+{
+	dma_addr_t base = to_msm_gpummu(mmu)->pt_base;
+
+	*pt_base = base;
+	*tran_error = base + TABLE_SIZE; /* 32-byte aligned */
+}
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index aa2c5d4580c8..c5bbb49dc1be 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -54,4 +54,7 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 	mmu->handler = handler;
 }
 
+void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
+		dma_addr_t *tran_error);
+
 #endif /* __MSM_MMU_H__ */
-- 
2.17.1

