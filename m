Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D6FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3740620645
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="B9TjkzTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3740620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403975AbeKVMcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40601 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbeKVMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so6039403qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7tf1nz2tE7T1hOSrOQ/rB4kqPBMJuTHxuFF0XApVT5E=;
        b=B9TjkzTeZH5Mt4uL4es0/6dyPG7dFsOCgGLXIl2SOUyZ7oiUXYzZaunuGp/FhOxwI4
         UHluik67RnlftnJt3lXL8QeooVdxDVwSe/8UenjQOQpk5WCJ5Fhh9wmKqBb3W2nzrHxK
         X8lODoOeqyCYPJ2Tl/F1FvGjF7P2ic/WIJjG2u1n9W4178pJ+SXrBe4vfFMsonaEoUdr
         8Ty8drctZ+3ZeaTfbSEpw2BKWZ8qhMCPH7IjSt43tSunQjXrAeLsHFzcmxVWjyrGaQ7H
         7wDDlXhLfJtILsnNCcYu3NNRRZCoAksPmCKsal04yTCtekEb1F2Vz+RJGhUYeOMjeOoI
         QrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7tf1nz2tE7T1hOSrOQ/rB4kqPBMJuTHxuFF0XApVT5E=;
        b=eP6Hby6r9YCQtMEc1gG+Ju+9UMP4voAONnWM2VNZTr7p26he4Grl05OnW1P1PzKZJx
         o0VFebfvIWc40LhCVKkAgD5eM8hqqhtWKiySfFooIMGkKORzuFgm7tBWL9vUFt2TnLTl
         ZNnTG8xvdSGhxbPlrQNmkFdpXXgsXqChOmYGnyv4djDPvepDxDAMC36tkZPQvrvYbzK5
         WZ7IR48TwSdhy8ZpeDdhd1/DV9WudPLmD+KiUo5L8XXFRWB7BIu3PVKeYc/WS2nmuQqp
         s3SLbnttCCOk5DZtJx3J4U1pZdyLFsm2HpmO7TnFsxURwLIDYDi88mjlDStUT+FiwH7h
         UO8Q==
X-Gm-Message-State: AA+aEWYY1PQOb4kKxo9qqHGeDxkD0gpLnuV86Bhvda8KgEgnB3O+PCS3
        iXebVyKliRYj2FoiwwRN1i9dZw==
X-Google-Smtp-Source: AFSGD/U1JsMGHUKcwqF2CZpFYTSuBzHR1HBMP48Oqrt8t/ghNSnpd5gyH1uGYgo0Gt4wXeDnXXxDeA==
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr7983905qkg.147.1542851749455;
        Wed, 21 Nov 2018 17:55:49 -0800 (PST)
Received: from localhost.localdomain (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id q15sm25297721qkl.81.2018.11.21.17.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 17:55:48 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Chris.Healy@zii.aero, festevam@gmail.com,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Archit Taneja <architt@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU)
Subject: [PATCH v2 6/9] drm/msm/adreno: add a2xx
Date:   Wed, 21 Nov 2018 20:52:32 -0500
Message-Id: <20181122015237.14534-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015237.14534-1-jonathan@marek.ca>
References: <20181122015237.14534-1-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

derived from the a3xx driver and tested on the following hardware:
imx51-zii-rdu1 (a200 with 128kb gmem)
imx53-qsrb (a200)
msm8060-tenderloin (a220)

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
---
v2: 
-fail when MMU is not present (instead of just a warning, matches a3xx)
-removed whitespace and removed "XXX" in comments

 drivers/gpu/drm/msm/Makefile               |   1 +
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c      | 446 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a2xx_gpu.h      |  21 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |  33 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  27 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  15 +
 6 files changed, 535 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_gpu.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_gpu.h

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 19ab521d4c3a..0170766393ea 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -6,6 +6,7 @@ ccflags-$(CONFIG_DRM_MSM_DSI) += -Idrivers/gpu/drm/msm/dsi
 msm-y := \
 	adreno/adreno_device.o \
 	adreno/adreno_gpu.o \
+	adreno/a2xx_gpu.o \
 	adreno/a3xx_gpu.o \
 	adreno/a4xx_gpu.o \
 	adreno/a5xx_gpu.o \
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
new file mode 100644
index 000000000000..936242f69f08
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
+
+#include "a2xx_gpu.h"
+
+extern bool hang_debug;
+
+static void a2xx_dump(struct msm_gpu *gpu);
+static bool a2xx_idle(struct msm_gpu *gpu);
+
+static bool a2xx_me_init(struct msm_gpu *gpu)
+{
+	struct msm_ringbuffer *ring = gpu->rb[0];
+
+	OUT_PKT3(ring, CP_ME_INIT, 18);
+
+	/* All fields present (bits 9:0) */
+	OUT_RING(ring, 0x000003ff);
+	/* Disable/Enable Real-Time Stream processing (present but ignored) */
+	OUT_RING(ring, 0x00000000);
+	/* Enable (2D <-> 3D) implicit synchronization (present but ignored) */
+	OUT_RING(ring, 0x00000000);
+
+	OUT_RING(ring, REG_A2XX_RB_SURFACE_INFO - 0x2000);
+	OUT_RING(ring, REG_A2XX_PA_SC_WINDOW_OFFSET - 0x2000);
+	OUT_RING(ring, REG_A2XX_VGT_MAX_VTX_INDX - 0x2000);
+	OUT_RING(ring, REG_A2XX_SQ_PROGRAM_CNTL - 0x2000);
+	OUT_RING(ring, REG_A2XX_RB_DEPTHCONTROL - 0x2000);
+	OUT_RING(ring, REG_A2XX_PA_SU_POINT_SIZE - 0x2000);
+	OUT_RING(ring, REG_A2XX_PA_SC_LINE_CNTL - 0x2000);
+	OUT_RING(ring, REG_A2XX_PA_SU_POLY_OFFSET_FRONT_SCALE - 0x2000);
+
+	/* Vertex and Pixel Shader Start Addresses in instructions
+	 * (3 DWORDS per instruction) */
+	OUT_RING(ring, 0x80000180);
+	/* Maximum Contexts */
+	OUT_RING(ring, 0x00000001);
+	/* Write Confirm Interval and The CP will wait the
+	 * wait_interval * 16 clocks between polling  */
+	OUT_RING(ring, 0x00000000);
+	/* NQ and External Memory Swap */
+	OUT_RING(ring, 0x00000000);
+	/* protected mode error checking (0x1f2 is REG_AXXX_CP_INT_CNTL) */
+	OUT_RING(ring, 0x200001f2);
+	/* Disable header dumping and Header dump address */
+	OUT_RING(ring, 0x00000000);
+	/* Header dump size */
+	OUT_RING(ring, 0x00000000);
+
+	/* enable protected mode */
+	OUT_PKT3(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 1);
+
+	gpu->funcs->flush(gpu, ring);
+	return a2xx_idle(gpu);
+}
+
+static int a2xx_hw_init(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	uint32_t *ptr, len;
+	int i, ret;
+
+	DBG("%s", gpu->name);
+
+	gpu_write(gpu, REG_A2XX_RBBM_PM_OVERRIDE1, 0xfffffffe);
+	gpu_write(gpu, REG_A2XX_RBBM_PM_OVERRIDE2, 0xffffffff);
+
+	/* note: kgsl uses 0x00000001 after first reset on a22x */
+	gpu_write(gpu, REG_A2XX_RBBM_SOFT_RESET, 0xffffffff);
+	msleep(30);
+	gpu_write(gpu, REG_A2XX_RBBM_SOFT_RESET, 0x00000000);
+
+	if (adreno_is_a225(adreno_gpu))
+		gpu_write(gpu, REG_A2XX_SQ_FLOW_CONTROL, 0x18000000);
+
+	/* note: kgsl uses 0x0000ffff for a20x */
+	gpu_write(gpu, REG_A2XX_RBBM_CNTL, 0x00004442);
+
+	gpu_write(gpu, REG_A2XX_MH_MMU_CONFIG, 0);
+	gpu_write(gpu, REG_A2XX_MH_MMU_MPU_BASE, 0);
+	gpu_write(gpu, REG_A2XX_MH_MMU_MPU_END, 0xfffff000);
+	gpu_write(gpu, REG_A2XX_MH_ARBITER_CONFIG,
+		A2XX_MH_ARBITER_CONFIG_SAME_PAGE_LIMIT(16) |
+		A2XX_MH_ARBITER_CONFIG_L1_ARB_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_L1_ARB_HOLD_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_PAGE_SIZE(1) |
+		A2XX_MH_ARBITER_CONFIG_TC_REORDER_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_TC_ARB_HOLD_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_IN_FLIGHT_LIMIT_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_IN_FLIGHT_LIMIT(8) |
+		A2XX_MH_ARBITER_CONFIG_CP_CLNT_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_VGT_CLNT_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_TC_CLNT_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_RB_CLNT_ENABLE |
+		A2XX_MH_ARBITER_CONFIG_PA_CLNT_ENABLE);
+	if (!adreno_is_a20x(adreno_gpu))
+		gpu_write(gpu, REG_A2XX_MH_CLNT_INTF_CTRL_CONFIG1, 0x00032f07);
+
+	gpu_write(gpu, REG_A2XX_SQ_VS_PROGRAM, 0x00000000);
+	gpu_write(gpu, REG_A2XX_SQ_PS_PROGRAM, 0x00000000);
+
+	gpu_write(gpu, REG_A2XX_RBBM_PM_OVERRIDE1, 0); /* 0x200 for msm8960? */
+	gpu_write(gpu, REG_A2XX_RBBM_PM_OVERRIDE2, 0); /* 0x80/0x1a0 for a22x? */
+
+	/* note: gsl doesn't set this */
+	gpu_write(gpu, REG_A2XX_RBBM_DEBUG, 0x00080000);
+
+	gpu_write(gpu, REG_A2XX_RBBM_INT_CNTL, 0);
+	gpu_write(gpu, REG_AXXX_CP_INT_CNTL, 0x80000000); /* RB INT */
+	gpu_write(gpu, REG_A2XX_SQ_INT_CNTL, 0);
+
+	for (i = 3; i <= 5; i++)
+		if ((SZ_16K << i) == adreno_gpu->gmem)
+			break;
+	gpu_write(gpu, REG_A2XX_RB_EDRAM_INFO, i);
+
+	ret = adreno_hw_init(gpu);
+	if (ret)
+		return ret;
+
+	/* NOTE: PM4/micro-engine firmware registers look to be the same
+	 * for a2xx and a3xx.. we could possibly push that part down to
+	 * adreno_gpu base class.  Or push both PM4 and PFP but
+	 * parameterize the pfp ucode addr/data registers..
+	 */
+
+	/* Load PM4: */
+	ptr = (uint32_t *)(adreno_gpu->fw[ADRENO_FW_PM4]->data);
+	len = adreno_gpu->fw[ADRENO_FW_PM4]->size / 4;
+	DBG("loading PM4 ucode version: %x", ptr[1]);
+
+	gpu_write(gpu, REG_AXXX_CP_DEBUG, 0x02000000);
+	gpu_write(gpu, REG_AXXX_CP_ME_RAM_WADDR, 0);
+	for (i = 1; i < len; i++)
+		gpu_write(gpu, REG_AXXX_CP_ME_RAM_DATA, ptr[i]);
+
+	/* Load PFP: */
+	ptr = (uint32_t *)(adreno_gpu->fw[ADRENO_FW_PFP]->data);
+	len = adreno_gpu->fw[ADRENO_FW_PFP]->size / 4;
+	DBG("loading PFP ucode version: %x", ptr[5]);
+
+	gpu_write(gpu, REG_A2XX_CP_PFP_UCODE_ADDR, 0);
+	for (i = 1; i < len; i++)
+		gpu_write(gpu, REG_A2XX_CP_PFP_UCODE_DATA, ptr[i]);
+
+	gpu_write(gpu, REG_AXXX_CP_QUEUE_THRESHOLDS, 0x000C0804);
+
+	/* clear ME_HALT to start micro engine */
+	gpu_write(gpu, REG_AXXX_CP_ME_CNTL, 0);
+
+	return a2xx_me_init(gpu) ? 0 : -EINVAL;
+}
+
+static void a2xx_recover(struct msm_gpu *gpu)
+{
+	int i;
+
+	adreno_dump_info(gpu);
+
+	for (i = 0; i < 8; i++) {
+		printk("CP_SCRATCH_REG%d: %u\n", i,
+			gpu_read(gpu, REG_AXXX_CP_SCRATCH_REG0 + i));
+	}
+
+	/* dump registers before resetting gpu, if enabled: */
+	if (hang_debug)
+		a2xx_dump(gpu);
+
+	gpu_write(gpu, REG_A2XX_RBBM_SOFT_RESET, 1);
+	gpu_read(gpu, REG_A2XX_RBBM_SOFT_RESET);
+	gpu_write(gpu, REG_A2XX_RBBM_SOFT_RESET, 0);
+	adreno_recover(gpu);
+}
+
+static void a2xx_destroy(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a2xx_gpu *a2xx_gpu = to_a2xx_gpu(adreno_gpu);
+
+	DBG("%s", gpu->name);
+
+	adreno_gpu_cleanup(adreno_gpu);
+
+	kfree(a2xx_gpu);
+}
+
+static bool a2xx_idle(struct msm_gpu *gpu)
+{
+	/* wait for ringbuffer to drain: */
+	if (!adreno_idle(gpu, gpu->rb[0]))
+		return false;
+
+	/* then wait for GPU to finish: */
+	if (spin_until(!(gpu_read(gpu, REG_A2XX_RBBM_STATUS) &
+			A2XX_RBBM_STATUS_GUI_ACTIVE))) {
+		DRM_ERROR("%s: timeout waiting for GPU to idle!\n", gpu->name);
+
+		/* TODO maybe we need to reset GPU here to recover from hang? */
+		return false;
+	}
+
+	return true;
+}
+
+static irqreturn_t a2xx_irq(struct msm_gpu *gpu)
+{
+	uint32_t mstatus, status;
+
+	mstatus = gpu_read(gpu, REG_A2XX_MASTER_INT_SIGNAL);
+
+	if (mstatus & A2XX_MASTER_INT_SIGNAL_MH_INT_STAT) {
+		status = gpu_read(gpu, REG_A2XX_MH_INTERRUPT_STATUS);
+
+		dev_warn(gpu->dev->dev, "MH_INT: %08X\n", status);
+		dev_warn(gpu->dev->dev, "MMU_PAGE_FAULT: %08X\n",
+			gpu_read(gpu, REG_A2XX_MH_MMU_PAGE_FAULT));
+
+		gpu_write(gpu, REG_A2XX_MH_INTERRUPT_CLEAR, status);
+	}
+
+	if (mstatus & A2XX_MASTER_INT_SIGNAL_CP_INT_STAT) {
+		status = gpu_read(gpu, REG_AXXX_CP_INT_STATUS);
+
+		/* only RB_INT is expected */
+		if (status & ~AXXX_CP_INT_CNTL_RB_INT_MASK)
+			dev_warn(gpu->dev->dev, "CP_INT: %08X\n", status);
+
+		gpu_write(gpu, REG_AXXX_CP_INT_ACK, status);
+	}
+
+	if (mstatus & A2XX_MASTER_INT_SIGNAL_RBBM_INT_STAT) {
+		status = gpu_read(gpu, REG_A2XX_RBBM_INT_STATUS);
+
+		dev_warn(gpu->dev->dev, "RBBM_INT: %08X\n", status);
+
+		gpu_write(gpu, REG_A2XX_RBBM_INT_ACK, status);
+	}
+
+	msm_gpu_retire(gpu);
+
+	return IRQ_HANDLED;
+}
+
+static const unsigned int a200_registers[] = {
+	0x0000, 0x0002, 0x0004, 0x000B, 0x003B, 0x003D, 0x0040, 0x0044,
+	0x0046, 0x0047, 0x01C0, 0x01C1, 0x01C3, 0x01C8, 0x01D5, 0x01D9,
+	0x01DC, 0x01DD, 0x01EA, 0x01EA, 0x01EE, 0x01F3, 0x01F6, 0x01F7,
+	0x01FC, 0x01FF, 0x0391, 0x0392, 0x039B, 0x039E, 0x03B2, 0x03B5,
+	0x03B7, 0x03B7, 0x03F8, 0x03FB, 0x0440, 0x0440, 0x0443, 0x0444,
+	0x044B, 0x044B, 0x044D, 0x044F, 0x0452, 0x0452, 0x0454, 0x045B,
+	0x047F, 0x047F, 0x0578, 0x0587, 0x05C9, 0x05C9, 0x05D0, 0x05D0,
+	0x0601, 0x0604, 0x0606, 0x0609, 0x060B, 0x060E, 0x0613, 0x0614,
+	0x0A29, 0x0A2B, 0x0A2F, 0x0A31, 0x0A40, 0x0A43, 0x0A45, 0x0A45,
+	0x0A4E, 0x0A4F, 0x0C2C, 0x0C2C, 0x0C30, 0x0C30, 0x0C38, 0x0C3C,
+	0x0C40, 0x0C40, 0x0C44, 0x0C44, 0x0C80, 0x0C86, 0x0C88, 0x0C94,
+	0x0C99, 0x0C9A, 0x0CA4, 0x0CA5, 0x0D00, 0x0D03, 0x0D06, 0x0D06,
+	0x0D08, 0x0D0B, 0x0D34, 0x0D35, 0x0DAE, 0x0DC1, 0x0DC8, 0x0DD4,
+	0x0DD8, 0x0DD9, 0x0E00, 0x0E00, 0x0E02, 0x0E04, 0x0E17, 0x0E1E,
+	0x0EC0, 0x0EC9, 0x0ECB, 0x0ECC, 0x0ED0, 0x0ED0, 0x0ED4, 0x0ED7,
+	0x0EE0, 0x0EE2, 0x0F01, 0x0F02, 0x0F0C, 0x0F0C, 0x0F0E, 0x0F12,
+	0x0F26, 0x0F2A, 0x0F2C, 0x0F2C, 0x2000, 0x2002, 0x2006, 0x200F,
+	0x2080, 0x2082, 0x2100, 0x2109, 0x210C, 0x2114, 0x2180, 0x2184,
+	0x21F5, 0x21F7, 0x2200, 0x2208, 0x2280, 0x2283, 0x2293, 0x2294,
+	0x2300, 0x2308, 0x2312, 0x2312, 0x2316, 0x231D, 0x2324, 0x2326,
+	0x2380, 0x2383, 0x2400, 0x2402, 0x2406, 0x240F, 0x2480, 0x2482,
+	0x2500, 0x2509, 0x250C, 0x2514, 0x2580, 0x2584, 0x25F5, 0x25F7,
+	0x2600, 0x2608, 0x2680, 0x2683, 0x2693, 0x2694, 0x2700, 0x2708,
+	0x2712, 0x2712, 0x2716, 0x271D, 0x2724, 0x2726, 0x2780, 0x2783,
+	0x4000, 0x4003, 0x4800, 0x4805, 0x4900, 0x4900, 0x4908, 0x4908,
+	~0   /* sentinel */
+};
+
+static const unsigned int a220_registers[] = {
+	0x0000, 0x0002, 0x0004, 0x000B, 0x003B, 0x003D, 0x0040, 0x0044,
+	0x0046, 0x0047, 0x01C0, 0x01C1, 0x01C3, 0x01C8, 0x01D5, 0x01D9,
+	0x01DC, 0x01DD, 0x01EA, 0x01EA, 0x01EE, 0x01F3, 0x01F6, 0x01F7,
+	0x01FC, 0x01FF, 0x0391, 0x0392, 0x039B, 0x039E, 0x03B2, 0x03B5,
+	0x03B7, 0x03B7, 0x03F8, 0x03FB, 0x0440, 0x0440, 0x0443, 0x0444,
+	0x044B, 0x044B, 0x044D, 0x044F, 0x0452, 0x0452, 0x0454, 0x045B,
+	0x047F, 0x047F, 0x0578, 0x0587, 0x05C9, 0x05C9, 0x05D0, 0x05D0,
+	0x0601, 0x0604, 0x0606, 0x0609, 0x060B, 0x060E, 0x0613, 0x0614,
+	0x0A29, 0x0A2B, 0x0A2F, 0x0A31, 0x0A40, 0x0A40, 0x0A42, 0x0A43,
+	0x0A45, 0x0A45, 0x0A4E, 0x0A4F, 0x0C30, 0x0C30, 0x0C38, 0x0C39,
+	0x0C3C, 0x0C3C, 0x0C80, 0x0C81, 0x0C88, 0x0C93, 0x0D00, 0x0D03,
+	0x0D05, 0x0D06, 0x0D08, 0x0D0B, 0x0D34, 0x0D35, 0x0DAE, 0x0DC1,
+	0x0DC8, 0x0DD4, 0x0DD8, 0x0DD9, 0x0E00, 0x0E00, 0x0E02, 0x0E04,
+	0x0E17, 0x0E1E, 0x0EC0, 0x0EC9, 0x0ECB, 0x0ECC, 0x0ED0, 0x0ED0,
+	0x0ED4, 0x0ED7, 0x0EE0, 0x0EE2, 0x0F01, 0x0F02, 0x2000, 0x2002,
+	0x2006, 0x200F, 0x2080, 0x2082, 0x2100, 0x2102, 0x2104, 0x2109,
+	0x210C, 0x2114, 0x2180, 0x2184, 0x21F5, 0x21F7, 0x2200, 0x2202,
+	0x2204, 0x2204, 0x2208, 0x2208, 0x2280, 0x2282, 0x2294, 0x2294,
+	0x2300, 0x2308, 0x2309, 0x230A, 0x2312, 0x2312, 0x2316, 0x2316,
+	0x2318, 0x231D, 0x2324, 0x2326, 0x2380, 0x2383, 0x2400, 0x2402,
+	0x2406, 0x240F, 0x2480, 0x2482, 0x2500, 0x2502, 0x2504, 0x2509,
+	0x250C, 0x2514, 0x2580, 0x2584, 0x25F5, 0x25F7, 0x2600, 0x2602,
+	0x2604, 0x2606, 0x2608, 0x2608, 0x2680, 0x2682, 0x2694, 0x2694,
+	0x2700, 0x2708, 0x2712, 0x2712, 0x2716, 0x2716, 0x2718, 0x271D,
+	0x2724, 0x2726, 0x2780, 0x2783, 0x4000, 0x4003, 0x4800, 0x4805,
+	0x4900, 0x4900, 0x4908, 0x4908,
+	~0   /* sentinel */
+};
+
+static const unsigned int a225_registers[] = {
+	0x0000, 0x0002, 0x0004, 0x000B, 0x003B, 0x003D, 0x0040, 0x0044,
+	0x0046, 0x0047, 0x013C, 0x013C, 0x0140, 0x014F, 0x01C0, 0x01C1,
+	0x01C3, 0x01C8, 0x01D5, 0x01D9, 0x01DC, 0x01DD, 0x01EA, 0x01EA,
+	0x01EE, 0x01F3, 0x01F6, 0x01F7, 0x01FC, 0x01FF, 0x0391, 0x0392,
+	0x039B, 0x039E, 0x03B2, 0x03B5, 0x03B7, 0x03B7, 0x03F8, 0x03FB,
+	0x0440, 0x0440, 0x0443, 0x0444, 0x044B, 0x044B, 0x044D, 0x044F,
+	0x0452, 0x0452, 0x0454, 0x045B, 0x047F, 0x047F, 0x0578, 0x0587,
+	0x05C9, 0x05C9, 0x05D0, 0x05D0, 0x0601, 0x0604, 0x0606, 0x0609,
+	0x060B, 0x060E, 0x0613, 0x0614, 0x0A29, 0x0A2B, 0x0A2F, 0x0A31,
+	0x0A40, 0x0A40, 0x0A42, 0x0A43, 0x0A45, 0x0A45, 0x0A4E, 0x0A4F,
+	0x0C01, 0x0C1D, 0x0C30, 0x0C30, 0x0C38, 0x0C39, 0x0C3C, 0x0C3C,
+	0x0C80, 0x0C81, 0x0C88, 0x0C93, 0x0D00, 0x0D03, 0x0D05, 0x0D06,
+	0x0D08, 0x0D0B, 0x0D34, 0x0D35, 0x0DAE, 0x0DC1, 0x0DC8, 0x0DD4,
+	0x0DD8, 0x0DD9, 0x0E00, 0x0E00, 0x0E02, 0x0E04, 0x0E17, 0x0E1E,
+	0x0EC0, 0x0EC9, 0x0ECB, 0x0ECC, 0x0ED0, 0x0ED0, 0x0ED4, 0x0ED7,
+	0x0EE0, 0x0EE2, 0x0F01, 0x0F02, 0x2000, 0x200F, 0x2080, 0x2082,
+	0x2100, 0x2109, 0x210C, 0x2114, 0x2180, 0x2184, 0x21F5, 0x21F7,
+	0x2200, 0x2202, 0x2204, 0x2206, 0x2208, 0x2210, 0x2220, 0x2222,
+	0x2280, 0x2282, 0x2294, 0x2294, 0x2297, 0x2297, 0x2300, 0x230A,
+	0x2312, 0x2312, 0x2315, 0x2316, 0x2318, 0x231D, 0x2324, 0x2326,
+	0x2340, 0x2357, 0x2360, 0x2360, 0x2380, 0x2383, 0x2400, 0x240F,
+	0x2480, 0x2482, 0x2500, 0x2509, 0x250C, 0x2514, 0x2580, 0x2584,
+	0x25F5, 0x25F7, 0x2600, 0x2602, 0x2604, 0x2606, 0x2608, 0x2610,
+	0x2620, 0x2622, 0x2680, 0x2682, 0x2694, 0x2694, 0x2697, 0x2697,
+	0x2700, 0x270A, 0x2712, 0x2712, 0x2715, 0x2716, 0x2718, 0x271D,
+	0x2724, 0x2726, 0x2740, 0x2757, 0x2760, 0x2760, 0x2780, 0x2783,
+	0x4000, 0x4003, 0x4800, 0x4806, 0x4808, 0x4808, 0x4900, 0x4900,
+	0x4908, 0x4908,
+	~0   /* sentinel */
+};
+
+/* would be nice to not have to duplicate the _show() stuff with printk(): */
+static void a2xx_dump(struct msm_gpu *gpu)
+{
+	printk("status:   %08x\n",
+			gpu_read(gpu, REG_A2XX_RBBM_STATUS));
+	adreno_dump(gpu);
+}
+
+static struct msm_gpu_state *a2xx_gpu_state_get(struct msm_gpu *gpu)
+{
+	struct msm_gpu_state *state = kzalloc(sizeof(*state), GFP_KERNEL);
+
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	adreno_gpu_state_get(gpu, state);
+
+	state->rbbm_status = gpu_read(gpu, REG_A2XX_RBBM_STATUS);
+
+	return state;
+}
+
+/* Register offset defines for A2XX - copy of A3XX */
+static const unsigned int a2xx_register_offsets[REG_ADRENO_REGISTER_MAX] = {
+	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_BASE, REG_AXXX_CP_RB_BASE),
+	REG_ADRENO_SKIP(REG_ADRENO_CP_RB_BASE_HI),
+	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_RPTR_ADDR, REG_AXXX_CP_RB_RPTR_ADDR),
+	REG_ADRENO_SKIP(REG_ADRENO_CP_RB_RPTR_ADDR_HI),
+	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_RPTR, REG_AXXX_CP_RB_RPTR),
+	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_WPTR, REG_AXXX_CP_RB_WPTR),
+	REG_ADRENO_DEFINE(REG_ADRENO_CP_RB_CNTL, REG_AXXX_CP_RB_CNTL),
+};
+
+static const struct adreno_gpu_funcs funcs = {
+	.base = {
+		.get_param = adreno_get_param,
+		.hw_init = a2xx_hw_init,
+		.pm_suspend = msm_gpu_pm_suspend,
+		.pm_resume = msm_gpu_pm_resume,
+		.recover = a2xx_recover,
+		.submit = adreno_submit,
+		.flush = adreno_flush,
+		.active_ring = adreno_active_ring,
+		.irq = a2xx_irq,
+		.destroy = a2xx_destroy,
+#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
+		.show = adreno_show,
+#endif
+		.gpu_state_get = a2xx_gpu_state_get,
+		.gpu_state_put = adreno_gpu_state_put,
+	},
+};
+
+static const struct msm_gpu_perfcntr perfcntrs[] = {
+/* TODO */
+};
+
+struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
+{
+	struct a2xx_gpu *a2xx_gpu = NULL;
+	struct adreno_gpu *adreno_gpu;
+	struct msm_gpu *gpu;
+	struct msm_drm_private *priv = dev->dev_private;
+	struct platform_device *pdev = priv->gpu_pdev;
+	int ret;
+
+	if (!pdev) {
+		dev_err(dev->dev, "no a2xx device\n");
+		ret = -ENXIO;
+		goto fail;
+	}
+
+	a2xx_gpu = kzalloc(sizeof(*a2xx_gpu), GFP_KERNEL);
+	if (!a2xx_gpu) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	adreno_gpu = &a2xx_gpu->base;
+	gpu = &adreno_gpu->base;
+
+	gpu->perfcntrs = perfcntrs;
+	gpu->num_perfcntrs = ARRAY_SIZE(perfcntrs);
+
+	if (adreno_is_a20x(adreno_gpu))
+		adreno_gpu->registers = a200_registers;
+	else if (adreno_is_a225(adreno_gpu))
+		adreno_gpu->registers = a225_registers;
+	else
+		adreno_gpu->registers = a220_registers;
+
+	adreno_gpu->reg_offsets = a2xx_register_offsets;
+
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+	if (ret)
+		goto fail;
+
+	if (!gpu->aspace) {
+		dev_err(dev->dev, "No memory protection without MMU\n");
+		ret = -ENXIO;
+		goto fail;
+	}
+
+	return gpu;
+
+fail:
+	if (a2xx_gpu)
+		a2xx_destroy(&a2xx_gpu->base.base);
+
+	return ERR_PTR(ret);
+}
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.h b/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
new file mode 100644
index 000000000000..02fba2cb8932
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 The Linux Foundation. All rights reserved. */
+
+#ifndef __A2XX_GPU_H__
+#define __A2XX_GPU_H__
+
+#include "adreno_gpu.h"
+
+/* arrg, somehow fb.h is getting pulled in: */
+#undef ROP_COPY
+#undef ROP_XOR
+
+#include "a2xx.xml.h"
+
+struct a2xx_gpu {
+	struct adreno_gpu base;
+	bool pm_enabled;
+};
+#define to_a2xx_gpu(x) container_of(x, struct a2xx_gpu, base)
+
+#endif /* __A2XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 86abdb2b3a9c..6e3f78d4da5d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -27,6 +27,39 @@ module_param_named(hang_debug, hang_debug, bool, 0600);
 
 static const struct adreno_info gpulist[] = {
 	{
+		.rev   = ADRENO_REV(2, 0, 0, 0),
+		.revn  = 200,
+		.name  = "A200",
+		.fw = {
+			[ADRENO_FW_PM4] = "yamato_pm4.fw",
+			[ADRENO_FW_PFP] = "yamato_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, { /* a200 on i.mx51 has only 128kib gmem */
+		.rev   = ADRENO_REV(2, 0, 0, 1),
+		.revn  = 201,
+		.name  = "A200",
+		.fw = {
+			[ADRENO_FW_PM4] = "yamato_pm4.fw",
+			[ADRENO_FW_PFP] = "yamato_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, {
+		.rev   = ADRENO_REV(2, 2, 0, ANY_ID),
+		.revn  = 220,
+		.name  = "A220",
+		.fw = {
+			[ADRENO_FW_PM4] = "leia_pm4_470.fw",
+			[ADRENO_FW_PFP] = "leia_pfp_470.fw",
+		},
+		.gmem  = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, {
 		.rev   = ADRENO_REV(3, 0, 5, ANY_ID),
 		.revn  = 305,
 		.name  = "A305",
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 93d70f4a2154..e09671324b05 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -319,16 +319,27 @@ void adreno_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit,
 		 */
 		OUT_PKT3(ring, CP_EVENT_WRITE, 1);
 		OUT_RING(ring, HLSQ_FLUSH);
-
-		OUT_PKT3(ring, CP_WAIT_FOR_IDLE, 1);
-		OUT_RING(ring, 0x00000000);
 	}
 
-	/* BIT(31) of CACHE_FLUSH_TS triggers CACHE_FLUSH_TS IRQ from GPU */
-	OUT_PKT3(ring, CP_EVENT_WRITE, 3);
-	OUT_RING(ring, CACHE_FLUSH_TS | BIT(31));
-	OUT_RING(ring, rbmemptr(ring, fence));
-	OUT_RING(ring, submit->seqno);
+	/* wait for idle before cache flush/interrupt */
+	OUT_PKT3(ring, CP_WAIT_FOR_IDLE, 1);
+	OUT_RING(ring, 0x00000000);
+
+	if (!adreno_is_a2xx(adreno_gpu)) {
+		/* BIT(31) of CACHE_FLUSH_TS triggers CACHE_FLUSH_TS IRQ from GPU */
+		OUT_PKT3(ring, CP_EVENT_WRITE, 3);
+		OUT_RING(ring, CACHE_FLUSH_TS | BIT(31));
+		OUT_RING(ring, rbmemptr(ring, fence));
+		OUT_RING(ring, submit->seqno);
+	} else {
+		/* BIT(31) means something else on a2xx */
+		OUT_PKT3(ring, CP_EVENT_WRITE, 3);
+		OUT_RING(ring, CACHE_FLUSH_TS);
+		OUT_RING(ring, rbmemptr(ring, fence));
+		OUT_RING(ring, submit->seqno);
+		OUT_PKT3(ring, CP_INTERRUPT, 1);
+		OUT_RING(ring, 0x80000000);
+	}
 
 #if 0
 	if (adreno_is_a3xx(adreno_gpu)) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index de6e6ee42fba..4adc97a91e1d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -154,6 +154,20 @@ struct adreno_platform_config {
 	__ret;                                             \
 })
 
+static inline bool adreno_is_a2xx(struct adreno_gpu *gpu)
+{
+	return (gpu->revn < 300);
+}
+
+static inline bool adreno_is_a20x(struct adreno_gpu *gpu)
+{
+	return (gpu->revn < 210);
+}
+
+static inline bool adreno_is_a225(struct adreno_gpu *gpu)
+{
+	return gpu->revn == 225;
+}
 
 static inline bool adreno_is_a3xx(struct adreno_gpu *gpu)
 {
@@ -334,6 +348,7 @@ static inline void adreno_gpu_write(struct adreno_gpu *gpu,
 		gpu_write(&gpu->base, reg - 1, data);
 }
 
+struct msm_gpu *a2xx_gpu_init(struct drm_device *dev);
 struct msm_gpu *a3xx_gpu_init(struct drm_device *dev);
 struct msm_gpu *a4xx_gpu_init(struct drm_device *dev);
 struct msm_gpu *a5xx_gpu_init(struct drm_device *dev);
-- 
2.17.1

