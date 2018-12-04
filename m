Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F20C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264AA208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="bnroYoWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264AA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbeLDPUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:20:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33524 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeLDPUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:20:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so18439356qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nMp+bo1u4Ju+AOZGqXFZCxG0+uZcT9bJyW5D89nvzhA=;
        b=bnroYoWz+6IhFU+kZR2ylCL+3f+FNjk2R1kSk9u41+xqICB3jANKhydHgSkXlB7OOw
         FMC97GpelrpdQPi1nWHZKn6TpwvI+jbBzhTygrLwl0E/kf4cGvlKwhGOY3zzmg8klgZ6
         lCndNO9BQY9LT2ZaXVtrYymil4XC4LDitFP7L/uFbHnlXBmEZw7n7z6T7wJ7YZ7tDKhY
         62wyC/He3mRw6bwPlEp7xGUBKAAluaRWqyZhWpFGN4ypChXtXEUxQfQeGVJd3wBi6Omz
         1onlZMS7S9XmXokAMhvh+9qh1DJZvpRsgKtV0FDKaOau/Rucz0Q5krDqkR8/9zk7pOxy
         8X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nMp+bo1u4Ju+AOZGqXFZCxG0+uZcT9bJyW5D89nvzhA=;
        b=r9D+8zugaCQ897prCnsrFMA71hokfRY8bMwFAgjoEwlP8tu1/matAbo1/bZHr80zaJ
         pUEs06MKpxnqhGO9fC58FLj9M9uCxm/GRoS9eq5VHrbMWFp5EGx5HS62wGrq0A4Zxfwb
         PaPyeAqa8q6jRJCLPlN0Z/6hM1dEc6zFbrvnoWQmGqS67jsW4Yw5Rc0BZP/f6lTBskZm
         UsvOLm2+YE4YiD9cUB3CjEzkMSqhdngOmRe8oCSvTqfZORYEJOOzwsk+fX5cub/3DMQ1
         /0vD+mlqrJkj7mB3/FgKyYoNTuwJEly/9OS5xN+cXePYdcfTGocLIDpmiAV0ouqxqc1O
         485Q==
X-Gm-Message-State: AA+aEWZ+5gU/U7VxAx65icVdO6oTyOIEOMmrFO3/kcNKyePwVj0Ztu9V
        gbFZtnEzBJwhsAs3/mTD1x7WmQ==
X-Google-Smtp-Source: AFSGD/XrhXUUQxKKYDsNVYFGGS3csqlgs2eKsRDSxOQR0wENgqH29CqDpis4KcEDxBDAsQ1HKuu08A==
X-Received: by 2002:aed:2603:: with SMTP id z3mr19638337qtc.120.1543936801994;
        Tue, 04 Dec 2018 07:20:01 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q17sm11053989qtc.19.2018.12.04.07.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 07:20:01 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU)
Subject: [PATCH v4 3/5] drm/msm: implement a2xx mmu
Date:   Tue,  4 Dec 2018 10:16:59 -0500
Message-Id: <20181204151702.8514-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204151702.8514-1-jonathan@marek.ca>
References: <20181204151702.8514-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A2XX has its own very simple MMU.

Added a msm_use_mmu() function because we can't rely on iommu_present to
decide to use MMU or not.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v3: rebased on msm-next-staging and moved is_a2xx initialization earlier

 drivers/gpu/drm/msm/Makefile               |   3 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c      |  50 ++++++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c |   3 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   3 +
 drivers/gpu/drm/msm/msm_drv.c              |  11 +-
 drivers/gpu/drm/msm/msm_drv.h              |   8 ++
 drivers/gpu/drm/msm/msm_gem.c              |   4 +-
 drivers/gpu/drm/msm/msm_gem_vma.c          |  23 ++++
 drivers/gpu/drm/msm/msm_gpu.c              |  31 ++++--
 drivers/gpu/drm/msm/msm_gpummu.c           | 122 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h              |   3 +
 11 files changed, 241 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/msm_gpummu.c

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 61e76f87a..1b26c4105 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -93,7 +93,8 @@ msm-y := \
 	msm_rd.o \
 	msm_ringbuffer.o \
 	msm_submitqueue.o \
-	msm_gpu_tracepoints.o
+	msm_gpu_tracepoints.o \
+	msm_gpummu.o
 
 msm-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
 			  disp/dpu1/dpu_dbg.o
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 5eddcf14e..1f83bc18d 100644
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
 
 	/* halt ME to avoid ucode upload issues on a20x */
@@ -80,9 +85,34 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 	/* note: kgsl uses 0x0000ffff for a20x */
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
@@ -109,9 +139,21 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 	/* note: gsl doesn't set this */
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
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 99e363c3d..714ed6505 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -308,6 +308,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	static struct adreno_platform_config config = {};
 	const struct adreno_info *info;
 	struct drm_device *drm = dev_get_drvdata(master);
+	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu *gpu;
 	int ret;
 
@@ -330,6 +331,8 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 	DBG("Found GPU: %u.%u.%u.%u", config.rev.core, config.rev.major,
 		config.rev.minor, config.rev.patchid);
 
+	priv->is_a2xx = config.rev.core == 2;
+
 	gpu = info->init(drm);
 	if (IS_ERR(gpu)) {
 		dev_warn(drm->dev, "failed to load adreno gpu\n");
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 9ab67dd1b..2e4372ef1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -769,6 +769,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu_config.va_start = SZ_16M;
 	adreno_gpu_config.va_end = 0xffffffff;
+	/* maximum range of a2xx mmu */
+	if (adreno_is_a2xx(adreno_gpu))
+		adreno_gpu_config.va_end = SZ_16M + 0xfff * SZ_64K;
 
 	adreno_gpu_config.nr_rings = nr_rings;
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7842518a9..271f1df61 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -26,6 +26,7 @@
 #include "msm_gem.h"
 #include "msm_gpu.h"
 #include "msm_kms.h"
+#include "adreno/adreno_gpu.h"
 
 
 /*
@@ -360,6 +361,14 @@ static int get_mdp_ver(struct platform_device *pdev)
 
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
@@ -398,7 +407,7 @@ static int msm_init_vram(struct drm_device *dev)
 		 * Grab the entire CMA chunk carved out in early startup in
 		 * mach-msm:
 		 */
-	} else if (!iommu_present(&platform_bus_type)) {
+	} else if (!msm_use_mmu(dev)) {
 		DRM_INFO("using %s VRAM carveout\n", vram);
 		size = memparse(vram, NULL);
 	}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 71a03ce21..9cd6a96c6 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -179,6 +179,8 @@ struct msm_drm_private {
 	/* when we have more than one 'msm_gpu' these need to be an array: */
 	struct msm_gpu *gpu;
 	struct msm_file_private *lastctx;
+	/* gpu is only set on open(), but we need this info earlier */
+	bool is_a2xx;
 
 	struct drm_fb_helper *fbdev;
 
@@ -258,9 +260,15 @@ struct msm_gem_address_space *
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
index 38b7f4e9e..51a95da69 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -975,7 +975,7 @@ static struct drm_gem_object *_msm_gem_new(struct drm_device *dev,
 
 	size = PAGE_ALIGN(size);
 
-	if (!iommu_present(&platform_bus_type))
+	if (!msm_use_mmu(dev))
 		use_vram = true;
 	else if ((flags & (MSM_BO_STOLEN | MSM_BO_SCANOUT)) && priv->vram.size)
 		use_vram = true;
@@ -1052,7 +1052,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	int ret, npages;
 
 	/* if we don't have IOMMU, don't bother pretending we can import: */
-	if (!iommu_present(&platform_bus_type)) {
+	if (!msm_use_mmu(dev)) {
 		DRM_DEV_ERROR(dev->dev, "cannot import without IOMMU\n");
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index ee46d8321..557360788 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -159,3 +159,26 @@ msm_gem_address_space_create(struct device *dev, struct iommu_domain *domain,
 
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
index c1968d63b..5f3eff304 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -20,6 +20,7 @@
 #include "msm_mmu.h"
 #include "msm_fence.h"
 #include "msm_gpu_trace.h"
+#include "adreno/adreno_gpu.h"
 
 #include <generated/utsrelease.h>
 #include <linux/string_helpers.h>
@@ -825,7 +826,6 @@ static struct msm_gem_address_space *
 msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 		uint64_t va_start, uint64_t va_end)
 {
-	struct iommu_domain *iommu;
 	struct msm_gem_address_space *aspace;
 	int ret;
 
@@ -834,20 +834,27 @@ msm_gpu_create_address_space(struct msm_gpu *gpu, struct platform_device *pdev,
 	 * and have separate page tables per context.  For now, to keep things
 	 * simple and to get something working, just use a single address space:
 	 */
-	iommu = iommu_domain_alloc(&platform_bus_type);
-	if (!iommu)
-		return NULL;
-
-	iommu->geometry.aperture_start = va_start;
-	iommu->geometry.aperture_end = va_end;
-
-	DRM_DEV_INFO(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
+	if (!adreno_is_a2xx(to_adreno_gpu(gpu))) {
+		struct iommu_domain *iommu = iommu_domain_alloc(&platform_bus_type);
+		if (!iommu)
+			return NULL;
+
+		iommu->geometry.aperture_start = va_start;
+		iommu->geometry.aperture_end = va_end;
+
+		DRM_DEV_INFO(gpu->dev->dev, "%s: using IOMMU\n", gpu->name);
+
+		aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
+		if (IS_ERR(aspace))
+			iommu_domain_free(iommu);
+	} else {
+		aspace = msm_gem_address_space_create_a2xx(&pdev->dev, gpu, "gpu",
+			va_start, va_end);
+	}
 
-	aspace = msm_gem_address_space_create(&pdev->dev, iommu, "gpu");
 	if (IS_ERR(aspace)) {
-		DRM_DEV_ERROR(gpu->dev->dev, "failed to init iommu: %ld\n",
+		DRM_DEV_ERROR(gpu->dev->dev, "failed to init mmu: %ld\n",
 			PTR_ERR(aspace));
-		iommu_domain_free(iommu);
 		return ERR_CAST(aspace);
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
new file mode 100644
index 000000000..a04a64faa
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_gpummu.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
+
+#include "msm_drv.h"
+#include "msm_mmu.h"
+#include "adreno/adreno_gpu.h"
+#include "adreno/a2xx.xml.h"
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
+
+	/* flush the tlb everytime the page table is updated
+	 * we can probably do something smarter
+	 */
+	gpu_write(gpummu->gpu, REG_A2XX_MH_MMU_INVALIDATE,
+		A2XX_MH_MMU_INVALIDATE_INVALIDATE_ALL |
+		A2XX_MH_MMU_INVALIDATE_INVALIDATE_TC);
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
index 94c0b83d8..d21b26604 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -53,4 +53,7 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 	mmu->handler = handler;
 }
 
+void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
+		dma_addr_t *tran_error);
+
 #endif /* __MSM_MMU_H__ */
-- 
2.17.1

