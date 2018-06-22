Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0077C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026AD24534
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026AD24534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934174AbeFVPmP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:42:15 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:46354 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933930AbeFVPeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:34:02 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id AF92FCD39;
        Fri, 22 Jun 2018 18:33:58 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 04/32] media: Rename CAMSS driver path
Date:   Fri, 22 Jun 2018 18:33:13 +0300
Message-Id: <1529681621-9682-5-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
References: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for camera subsystem on QComm MSM8996/APQ8096 is to be added
so remove hardware version from CAMSS driver's path.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 MAINTAINERS                                        |    2 +-
 drivers/media/platform/Kconfig                     |    2 +-
 drivers/media/platform/Makefile                    |    2 +-
 drivers/media/platform/qcom/camss-8x16/Makefile    |   11 -
 .../media/platform/qcom/camss-8x16/camss-csid.c    | 1094 -------
 .../media/platform/qcom/camss-8x16/camss-csid.h    |   82 -
 .../media/platform/qcom/camss-8x16/camss-csiphy.c  |  893 ------
 .../media/platform/qcom/camss-8x16/camss-csiphy.h  |   77 -
 .../media/platform/qcom/camss-8x16/camss-ispif.c   | 1178 --------
 .../media/platform/qcom/camss-8x16/camss-ispif.h   |   85 -
 drivers/media/platform/qcom/camss-8x16/camss-vfe.c | 3093 --------------------
 drivers/media/platform/qcom/camss-8x16/camss-vfe.h |  123 -
 .../media/platform/qcom/camss-8x16/camss-video.c   |  859 ------
 .../media/platform/qcom/camss-8x16/camss-video.h   |   70 -
 drivers/media/platform/qcom/camss-8x16/camss.c     |  751 -----
 drivers/media/platform/qcom/camss-8x16/camss.h     |  106 -
 drivers/media/platform/qcom/camss/Makefile         |   11 +
 drivers/media/platform/qcom/camss/camss-csid.c     | 1094 +++++++
 drivers/media/platform/qcom/camss/camss-csid.h     |   82 +
 drivers/media/platform/qcom/camss/camss-csiphy.c   |  893 ++++++
 drivers/media/platform/qcom/camss/camss-csiphy.h   |   77 +
 drivers/media/platform/qcom/camss/camss-ispif.c    | 1178 ++++++++
 drivers/media/platform/qcom/camss/camss-ispif.h    |   85 +
 drivers/media/platform/qcom/camss/camss-vfe.c      | 3093 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.h      |  123 +
 drivers/media/platform/qcom/camss/camss-video.c    |  859 ++++++
 drivers/media/platform/qcom/camss/camss-video.h    |   70 +
 drivers/media/platform/qcom/camss/camss.c          |  751 +++++
 drivers/media/platform/qcom/camss/camss.h          |  106 +
 29 files changed, 8425 insertions(+), 8425 deletions(-)
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/Makefile
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-csid.c
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-csid.h
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-csiphy.c
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-csiphy.h
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-ispif.c
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-ispif.h
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-vfe.c
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-vfe.h
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-video.c
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss-video.h
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss.c
 delete mode 100644 drivers/media/platform/qcom/camss-8x16/camss.h
 create mode 100644 drivers/media/platform/qcom/camss/Makefile
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-csid.h
 create mode 100644 drivers/media/platform/qcom/camss/camss-csiphy.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-csiphy.h
 create mode 100644 drivers/media/platform/qcom/camss/camss-ispif.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-ispif.h
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-vfe.h
 create mode 100644 drivers/media/platform/qcom/camss/camss-video.c
 create mode 100644 drivers/media/platform/qcom/camss/camss-video.h
 create mode 100644 drivers/media/platform/qcom/camss/camss.c
 create mode 100644 drivers/media/platform/qcom/camss/camss.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fd5e88..ea3d450 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11796,7 +11796,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/qcom,camss.txt
 F:	Documentation/media/v4l-drivers/qcom_camss.rst
-F:	drivers/media/platform/qcom/camss-8x16/
+F:	drivers/media/platform/qcom/camss/
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:  Ilia Lin <ilia.lin@gmail.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2728376..a9765a2 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -90,7 +90,7 @@ config VIDEO_PXA27x
 	  This is a v4l2 driver for the PXA27x Quick Capture Interface
 
 config VIDEO_QCOM_CAMSS
-	tristate "Qualcomm 8x16 V4L2 Camera Subsystem driver"
+	tristate "Qualcomm V4L2 Camera Subsystem driver"
 	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
 	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
 	select VIDEOBUF2_DMA_SG
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 04bc150..20a7b64 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -88,7 +88,7 @@ obj-$(CONFIG_VIDEO_MEDIATEK_MDP)	+= mtk-mdp/
 
 obj-$(CONFIG_VIDEO_MEDIATEK_JPEG)	+= mtk-jpeg/
 
-obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss-8x16/
+obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
 
 obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
 
diff --git a/drivers/media/platform/qcom/camss-8x16/Makefile b/drivers/media/platform/qcom/camss-8x16/Makefile
deleted file mode 100644
index 3c4024f..0000000
--- a/drivers/media/platform/qcom/camss-8x16/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# Makefile for Qualcomm CAMSS driver
-
-qcom-camss-objs += \
-		camss.o \
-		camss-csid.o \
-		camss-csiphy.o \
-		camss-ispif.o \
-		camss-vfe.o \
-		camss-video.o \
-
-obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-csid.c b/drivers/media/platform/qcom/camss-8x16/camss-csid.c
deleted file mode 100644
index 226f36e..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-csid.c
+++ /dev/null
@@ -1,1094 +0,0 @@
-/*
- * camss-csid.c
- *
- * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
- *
- * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/clk.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/consumer.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-
-#include "camss-csid.h"
-#include "camss.h"
-
-#define MSM_CSID_NAME "msm_csid"
-
-#define CAMSS_CSID_HW_VERSION		0x0
-#define CAMSS_CSID_CORE_CTRL_0		0x004
-#define CAMSS_CSID_CORE_CTRL_1		0x008
-#define CAMSS_CSID_RST_CMD		0x00c
-#define CAMSS_CSID_CID_LUT_VC_n(n)	(0x010 + 0x4 * (n))
-#define CAMSS_CSID_CID_n_CFG(n)		(0x020 + 0x4 * (n))
-#define CAMSS_CSID_IRQ_CLEAR_CMD	0x060
-#define CAMSS_CSID_IRQ_MASK		0x064
-#define CAMSS_CSID_IRQ_STATUS		0x068
-#define CAMSS_CSID_TG_CTRL		0x0a0
-#define CAMSS_CSID_TG_CTRL_DISABLE	0xa06436
-#define CAMSS_CSID_TG_CTRL_ENABLE	0xa06437
-#define CAMSS_CSID_TG_VC_CFG		0x0a4
-#define CAMSS_CSID_TG_VC_CFG_H_BLANKING		0x3ff
-#define CAMSS_CSID_TG_VC_CFG_V_BLANKING		0x7f
-#define CAMSS_CSID_TG_DT_n_CGG_0(n)	(0x0ac + 0xc * (n))
-#define CAMSS_CSID_TG_DT_n_CGG_1(n)	(0x0b0 + 0xc * (n))
-#define CAMSS_CSID_TG_DT_n_CGG_2(n)	(0x0b4 + 0xc * (n))
-
-#define DATA_TYPE_EMBEDDED_DATA_8BIT	0x12
-#define DATA_TYPE_YUV422_8BIT		0x1e
-#define DATA_TYPE_RAW_6BIT		0x28
-#define DATA_TYPE_RAW_8BIT		0x2a
-#define DATA_TYPE_RAW_10BIT		0x2b
-#define DATA_TYPE_RAW_12BIT		0x2c
-
-#define DECODE_FORMAT_UNCOMPRESSED_6_BIT	0x0
-#define DECODE_FORMAT_UNCOMPRESSED_8_BIT	0x1
-#define DECODE_FORMAT_UNCOMPRESSED_10_BIT	0x2
-#define DECODE_FORMAT_UNCOMPRESSED_12_BIT	0x3
-
-#define CSID_RESET_TIMEOUT_MS 500
-
-struct csid_fmts {
-	u32 code;
-	u8 data_type;
-	u8 decode_format;
-	u8 bpp;
-	u8 spp; /* bus samples per pixel */
-};
-
-static const struct csid_fmts csid_input_fmts[] = {
-	{
-		MEDIA_BUS_FMT_UYVY8_2X8,
-		DATA_TYPE_YUV422_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		2,
-	},
-	{
-		MEDIA_BUS_FMT_VYUY8_2X8,
-		DATA_TYPE_YUV422_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		2,
-	},
-	{
-		MEDIA_BUS_FMT_YUYV8_2X8,
-		DATA_TYPE_YUV422_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		2,
-	},
-	{
-		MEDIA_BUS_FMT_YVYU8_2X8,
-		DATA_TYPE_YUV422_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		2,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR8_1X8,
-		DATA_TYPE_RAW_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG8_1X8,
-		DATA_TYPE_RAW_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG8_1X8,
-		DATA_TYPE_RAW_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB8_1X8,
-		DATA_TYPE_RAW_8BIT,
-		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
-		8,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR10_1X10,
-		DATA_TYPE_RAW_10BIT,
-		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
-		10,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG10_1X10,
-		DATA_TYPE_RAW_10BIT,
-		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
-		10,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG10_1X10,
-		DATA_TYPE_RAW_10BIT,
-		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
-		10,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB10_1X10,
-		DATA_TYPE_RAW_10BIT,
-		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
-		10,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR12_1X12,
-		DATA_TYPE_RAW_12BIT,
-		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
-		12,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG12_1X12,
-		DATA_TYPE_RAW_12BIT,
-		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
-		12,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG12_1X12,
-		DATA_TYPE_RAW_12BIT,
-		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
-		12,
-		1,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB12_1X12,
-		DATA_TYPE_RAW_12BIT,
-		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
-		12,
-		1,
-	}
-};
-
-static const struct csid_fmts *csid_get_fmt_entry(u32 code)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(csid_input_fmts); i++)
-		if (code == csid_input_fmts[i].code)
-			return &csid_input_fmts[i];
-
-	WARN(1, "Unknown format\n");
-
-	return &csid_input_fmts[0];
-}
-
-/*
- * csid_isr - CSID module interrupt handler
- * @irq: Interrupt line
- * @dev: CSID device
- *
- * Return IRQ_HANDLED on success
- */
-static irqreturn_t csid_isr(int irq, void *dev)
-{
-	struct csid_device *csid = dev;
-	u32 value;
-
-	value = readl_relaxed(csid->base + CAMSS_CSID_IRQ_STATUS);
-	writel_relaxed(value, csid->base + CAMSS_CSID_IRQ_CLEAR_CMD);
-
-	if ((value >> 11) & 0x1)
-		complete(&csid->reset_complete);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * csid_set_clock_rates - Calculate and set clock rates on CSID module
- * @csiphy: CSID device
- */
-static int csid_set_clock_rates(struct csid_device *csid)
-{
-	struct device *dev = to_device_index(csid, csid->id);
-	u32 pixel_clock;
-	int i, j;
-	int ret;
-
-	ret = camss_get_pixel_clock(&csid->subdev.entity, &pixel_clock);
-	if (ret)
-		pixel_clock = 0;
-
-	for (i = 0; i < csid->nclocks; i++) {
-		struct camss_clock *clock = &csid->clock[i];
-
-		if (!strcmp(clock->name, "csi0") ||
-			!strcmp(clock->name, "csi1")) {
-			u8 bpp = csid_get_fmt_entry(
-				csid->fmt[MSM_CSIPHY_PAD_SINK].code)->bpp;
-			u8 num_lanes = csid->phy.lane_cnt;
-			u64 min_rate = pixel_clock * bpp / (2 * num_lanes * 4);
-			long rate;
-
-			camss_add_clock_margin(&min_rate);
-
-			for (j = 0; j < clock->nfreqs; j++)
-				if (min_rate < clock->freq[j])
-					break;
-
-			if (j == clock->nfreqs) {
-				dev_err(dev,
-					"Pixel clock is too high for CSID\n");
-				return -EINVAL;
-			}
-
-			/* if sensor pixel clock is not available */
-			/* set highest possible CSID clock rate */
-			if (min_rate == 0)
-				j = clock->nfreqs - 1;
-
-			rate = clk_round_rate(clock->clk, clock->freq[j]);
-			if (rate < 0) {
-				dev_err(dev, "clk round rate failed: %ld\n",
-					rate);
-				return -EINVAL;
-			}
-
-			ret = clk_set_rate(clock->clk, rate);
-			if (ret < 0) {
-				dev_err(dev, "clk set rate failed: %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
-	return 0;
-}
-
-/*
- * csid_reset - Trigger reset on CSID module and wait to complete
- * @csid: CSID device
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csid_reset(struct csid_device *csid)
-{
-	unsigned long time;
-
-	reinit_completion(&csid->reset_complete);
-
-	writel_relaxed(0x7fff, csid->base + CAMSS_CSID_RST_CMD);
-
-	time = wait_for_completion_timeout(&csid->reset_complete,
-		msecs_to_jiffies(CSID_RESET_TIMEOUT_MS));
-	if (!time) {
-		dev_err(to_device_index(csid, csid->id),
-			"CSID reset timeout\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/*
- * csid_set_power - Power on/off CSID module
- * @sd: CSID V4L2 subdevice
- * @on: Requested power state
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csid_set_power(struct v4l2_subdev *sd, int on)
-{
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct device *dev = to_device_index(csid, csid->id);
-	int ret;
-
-	if (on) {
-		u32 hw_version;
-
-		ret = regulator_enable(csid->vdda);
-		if (ret < 0)
-			return ret;
-
-		ret = csid_set_clock_rates(csid);
-		if (ret < 0) {
-			regulator_disable(csid->vdda);
-			return ret;
-		}
-
-		ret = camss_enable_clocks(csid->nclocks, csid->clock, dev);
-		if (ret < 0) {
-			regulator_disable(csid->vdda);
-			return ret;
-		}
-
-		enable_irq(csid->irq);
-
-		ret = csid_reset(csid);
-		if (ret < 0) {
-			disable_irq(csid->irq);
-			camss_disable_clocks(csid->nclocks, csid->clock);
-			regulator_disable(csid->vdda);
-			return ret;
-		}
-
-		hw_version = readl_relaxed(csid->base + CAMSS_CSID_HW_VERSION);
-		dev_dbg(dev, "CSID HW Version = 0x%08x\n", hw_version);
-	} else {
-		disable_irq(csid->irq);
-		camss_disable_clocks(csid->nclocks, csid->clock);
-		ret = regulator_disable(csid->vdda);
-	}
-
-	return ret;
-}
-
-/*
- * csid_set_stream - Enable/disable streaming on CSID module
- * @sd: CSID V4L2 subdevice
- * @enable: Requested streaming state
- *
- * Main configuration of CSID module is also done here.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csid_set_stream(struct v4l2_subdev *sd, int enable)
-{
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct csid_testgen_config *tg = &csid->testgen;
-	u32 val;
-
-	if (enable) {
-		u8 vc = 0; /* Virtual Channel 0 */
-		u8 cid = vc * 4; /* id of Virtual Channel and Data Type set */
-		u8 dt, dt_shift, df;
-		int ret;
-
-		ret = v4l2_ctrl_handler_setup(&csid->ctrls);
-		if (ret < 0) {
-			dev_err(to_device_index(csid, csid->id),
-				"could not sync v4l2 controls: %d\n", ret);
-			return ret;
-		}
-
-		if (!tg->enabled &&
-		    !media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
-			return -ENOLINK;
-
-		dt = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SRC].code)->
-								data_type;
-
-		if (tg->enabled) {
-			/* Config Test Generator */
-			struct v4l2_mbus_framefmt *f =
-					&csid->fmt[MSM_CSID_PAD_SRC];
-			u8 bpp = csid_get_fmt_entry(f->code)->bpp;
-			u8 spp = csid_get_fmt_entry(f->code)->spp;
-			u32 num_bytes_per_line = f->width * bpp * spp / 8;
-			u32 num_lines = f->height;
-
-			/* 31:24 V blank, 23:13 H blank, 3:2 num of active DT */
-			/* 1:0 VC */
-			val = ((CAMSS_CSID_TG_VC_CFG_V_BLANKING & 0xff) << 24) |
-			      ((CAMSS_CSID_TG_VC_CFG_H_BLANKING & 0x7ff) << 13);
-			writel_relaxed(val, csid->base + CAMSS_CSID_TG_VC_CFG);
-
-			/* 28:16 bytes per lines, 12:0 num of lines */
-			val = ((num_bytes_per_line & 0x1fff) << 16) |
-			      (num_lines & 0x1fff);
-			writel_relaxed(val, csid->base +
-				       CAMSS_CSID_TG_DT_n_CGG_0(0));
-
-			/* 5:0 data type */
-			val = dt;
-			writel_relaxed(val, csid->base +
-				       CAMSS_CSID_TG_DT_n_CGG_1(0));
-
-			/* 2:0 output test pattern */
-			val = tg->payload_mode;
-			writel_relaxed(val, csid->base +
-				       CAMSS_CSID_TG_DT_n_CGG_2(0));
-		} else {
-			struct csid_phy_config *phy = &csid->phy;
-
-			val = phy->lane_cnt - 1;
-			val |= phy->lane_assign << 4;
-
-			writel_relaxed(val,
-				       csid->base + CAMSS_CSID_CORE_CTRL_0);
-
-			val = phy->csiphy_id << 17;
-			val |= 0x9;
-
-			writel_relaxed(val,
-				       csid->base + CAMSS_CSID_CORE_CTRL_1);
-		}
-
-		/* Config LUT */
-
-		dt_shift = (cid % 4) * 8;
-		df = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SINK].code)->
-								decode_format;
-
-		val = readl_relaxed(csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
-		val &= ~(0xff << dt_shift);
-		val |= dt << dt_shift;
-		writel_relaxed(val, csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
-
-		val = (df << 4) | 0x3;
-		writel_relaxed(val, csid->base + CAMSS_CSID_CID_n_CFG(cid));
-
-		if (tg->enabled) {
-			val = CAMSS_CSID_TG_CTRL_ENABLE;
-			writel_relaxed(val, csid->base + CAMSS_CSID_TG_CTRL);
-		}
-	} else {
-		if (tg->enabled) {
-			val = CAMSS_CSID_TG_CTRL_DISABLE;
-			writel_relaxed(val, csid->base + CAMSS_CSID_TG_CTRL);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * __csid_get_format - Get pointer to format structure
- * @csid: CSID device
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad from which format is requested
- * @which: TRY or ACTIVE format
- *
- * Return pointer to TRY or ACTIVE format structure
- */
-static struct v4l2_mbus_framefmt *
-__csid_get_format(struct csid_device *csid,
-		  struct v4l2_subdev_pad_config *cfg,
-		  unsigned int pad,
-		  enum v4l2_subdev_format_whence which)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_format(&csid->subdev, cfg, pad);
-
-	return &csid->fmt[pad];
-}
-
-/*
- * csid_try_format - Handle try format by pad subdev method
- * @csid: CSID device
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad on which format is requested
- * @fmt: pointer to v4l2 format structure
- * @which: wanted subdev format
- */
-static void csid_try_format(struct csid_device *csid,
-			    struct v4l2_subdev_pad_config *cfg,
-			    unsigned int pad,
-			    struct v4l2_mbus_framefmt *fmt,
-			    enum v4l2_subdev_format_whence which)
-{
-	unsigned int i;
-
-	switch (pad) {
-	case MSM_CSID_PAD_SINK:
-		/* Set format on sink pad */
-
-		for (i = 0; i < ARRAY_SIZE(csid_input_fmts); i++)
-			if (fmt->code == csid_input_fmts[i].code)
-				break;
-
-		/* If not found, use UYVY as default */
-		if (i >= ARRAY_SIZE(csid_input_fmts))
-			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-
-		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
-		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
-
-		fmt->field = V4L2_FIELD_NONE;
-		fmt->colorspace = V4L2_COLORSPACE_SRGB;
-
-		break;
-
-	case MSM_CSID_PAD_SRC:
-		if (csid->testgen_mode->cur.val == 0) {
-			/* Test generator is disabled, keep pad formats */
-			/* in sync - set and return a format same as sink pad */
-			struct v4l2_mbus_framefmt format;
-
-			format = *__csid_get_format(csid, cfg,
-						    MSM_CSID_PAD_SINK, which);
-			*fmt = format;
-		} else {
-			/* Test generator is enabled, set format on source*/
-			/* pad to allow test generator usage */
-
-			for (i = 0; i < ARRAY_SIZE(csid_input_fmts); i++)
-				if (csid_input_fmts[i].code == fmt->code)
-					break;
-
-			/* If not found, use UYVY as default */
-			if (i >= ARRAY_SIZE(csid_input_fmts))
-				fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-
-			fmt->width = clamp_t(u32, fmt->width, 1, 8191);
-			fmt->height = clamp_t(u32, fmt->height, 1, 8191);
-
-			fmt->field = V4L2_FIELD_NONE;
-		}
-		break;
-	}
-
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-}
-
-/*
- * csid_enum_mbus_code - Handle pixel format enumeration
- * @sd: CSID V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @code: pointer to v4l2_subdev_mbus_code_enum structure
- * return -EINVAL or zero on success
- */
-static int csid_enum_mbus_code(struct v4l2_subdev *sd,
-			       struct v4l2_subdev_pad_config *cfg,
-			       struct v4l2_subdev_mbus_code_enum *code)
-{
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	if (code->pad == MSM_CSID_PAD_SINK) {
-		if (code->index >= ARRAY_SIZE(csid_input_fmts))
-			return -EINVAL;
-
-		code->code = csid_input_fmts[code->index].code;
-	} else {
-		if (csid->testgen_mode->cur.val == 0) {
-			if (code->index > 0)
-				return -EINVAL;
-
-			format = __csid_get_format(csid, cfg, MSM_CSID_PAD_SINK,
-						   code->which);
-
-			code->code = format->code;
-		} else {
-			if (code->index >= ARRAY_SIZE(csid_input_fmts))
-				return -EINVAL;
-
-			code->code = csid_input_fmts[code->index].code;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * csid_enum_frame_size - Handle frame size enumeration
- * @sd: CSID V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fse: pointer to v4l2_subdev_frame_size_enum structure
- * return -EINVAL or zero on success
- */
-static int csid_enum_frame_size(struct v4l2_subdev *sd,
-				struct v4l2_subdev_pad_config *cfg,
-				struct v4l2_subdev_frame_size_enum *fse)
-{
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt format;
-
-	if (fse->index != 0)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = 1;
-	format.height = 1;
-	csid_try_format(csid, cfg, fse->pad, &format, fse->which);
-	fse->min_width = format.width;
-	fse->min_height = format.height;
-
-	if (format.code != fse->code)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = -1;
-	format.height = -1;
-	csid_try_format(csid, cfg, fse->pad, &format, fse->which);
-	fse->max_width = format.width;
-	fse->max_height = format.height;
-
-	return 0;
-}
-
-/*
- * csid_get_format - Handle get format by pads subdev method
- * @sd: CSID V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int csid_get_format(struct v4l2_subdev *sd,
-			   struct v4l2_subdev_pad_config *cfg,
-			   struct v4l2_subdev_format *fmt)
-{
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __csid_get_format(csid, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	fmt->format = *format;
-
-	return 0;
-}
-
-/*
- * csid_set_format - Handle set format by pads subdev method
- * @sd: CSID V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int csid_set_format(struct v4l2_subdev *sd,
-			   struct v4l2_subdev_pad_config *cfg,
-			   struct v4l2_subdev_format *fmt)
-{
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __csid_get_format(csid, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	csid_try_format(csid, cfg, fmt->pad, &fmt->format, fmt->which);
-	*format = fmt->format;
-
-	/* Propagate the format from sink to source */
-	if (fmt->pad == MSM_CSID_PAD_SINK) {
-		format = __csid_get_format(csid, cfg, MSM_CSID_PAD_SRC,
-					   fmt->which);
-
-		*format = fmt->format;
-		csid_try_format(csid, cfg, MSM_CSID_PAD_SRC, format,
-				fmt->which);
-	}
-
-	return 0;
-}
-
-/*
- * csid_init_formats - Initialize formats on all pads
- * @sd: CSID V4L2 subdevice
- * @fh: V4L2 subdev file handle
- *
- * Initialize all pad formats with default values.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csid_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
-{
-	struct v4l2_subdev_format format = {
-		.pad = MSM_CSID_PAD_SINK,
-		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
-			      V4L2_SUBDEV_FORMAT_ACTIVE,
-		.format = {
-			.code = MEDIA_BUS_FMT_UYVY8_2X8,
-			.width = 1920,
-			.height = 1080
-		}
-	};
-
-	return csid_set_format(sd, fh ? fh->pad : NULL, &format);
-}
-
-static const char * const csid_test_pattern_menu[] = {
-	"Disabled",
-	"Incrementing",
-	"Alternating 0x55/0xAA",
-	"All Zeros 0x00",
-	"All Ones 0xFF",
-	"Pseudo-random Data",
-};
-
-/*
- * csid_set_test_pattern - Set test generator's pattern mode
- * @csid: CSID device
- * @value: desired test pattern mode
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csid_set_test_pattern(struct csid_device *csid, s32 value)
-{
-	struct csid_testgen_config *tg = &csid->testgen;
-
-	/* If CSID is linked to CSIPHY, do not allow to enable test generator */
-	if (value && media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
-		return -EBUSY;
-
-	tg->enabled = !!value;
-
-	switch (value) {
-	case 1:
-		tg->payload_mode = CSID_PAYLOAD_MODE_INCREMENTING;
-		break;
-	case 2:
-		tg->payload_mode = CSID_PAYLOAD_MODE_ALTERNATING_55_AA;
-		break;
-	case 3:
-		tg->payload_mode = CSID_PAYLOAD_MODE_ALL_ZEROES;
-		break;
-	case 4:
-		tg->payload_mode = CSID_PAYLOAD_MODE_ALL_ONES;
-		break;
-	case 5:
-		tg->payload_mode = CSID_PAYLOAD_MODE_RANDOM;
-		break;
-	}
-
-	return 0;
-}
-
-/*
- * csid_s_ctrl - Handle set control subdev method
- * @ctrl: pointer to v4l2 control structure
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csid_s_ctrl(struct v4l2_ctrl *ctrl)
-{
-	struct csid_device *csid = container_of(ctrl->handler,
-						struct csid_device, ctrls);
-	int ret = -EINVAL;
-
-	switch (ctrl->id) {
-	case V4L2_CID_TEST_PATTERN:
-		ret = csid_set_test_pattern(csid, ctrl->val);
-		break;
-	}
-
-	return ret;
-}
-
-static const struct v4l2_ctrl_ops csid_ctrl_ops = {
-	.s_ctrl = csid_s_ctrl,
-};
-
-/*
- * msm_csid_subdev_init - Initialize CSID device structure and resources
- * @csid: CSID device
- * @res: CSID module resources table
- * @id: CSID module id
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_csid_subdev_init(struct csid_device *csid,
-			 const struct resources *res, u8 id)
-{
-	struct device *dev = to_device_index(csid, id);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *r;
-	int i, j;
-	int ret;
-
-	csid->id = id;
-
-	/* Memory */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
-	csid->base = devm_ioremap_resource(dev, r);
-	if (IS_ERR(csid->base)) {
-		dev_err(dev, "could not map memory\n");
-		return PTR_ERR(csid->base);
-	}
-
-	/* Interrupt */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					 res->interrupt[0]);
-	if (!r) {
-		dev_err(dev, "missing IRQ\n");
-		return -EINVAL;
-	}
-
-	csid->irq = r->start;
-	snprintf(csid->irq_name, sizeof(csid->irq_name), "%s_%s%d",
-		 dev_name(dev), MSM_CSID_NAME, csid->id);
-	ret = devm_request_irq(dev, csid->irq, csid_isr,
-		IRQF_TRIGGER_RISING, csid->irq_name, csid);
-	if (ret < 0) {
-		dev_err(dev, "request_irq failed: %d\n", ret);
-		return ret;
-	}
-
-	disable_irq(csid->irq);
-
-	/* Clocks */
-
-	csid->nclocks = 0;
-	while (res->clock[csid->nclocks])
-		csid->nclocks++;
-
-	csid->clock = devm_kcalloc(dev, csid->nclocks, sizeof(*csid->clock),
-				    GFP_KERNEL);
-	if (!csid->clock)
-		return -ENOMEM;
-
-	for (i = 0; i < csid->nclocks; i++) {
-		struct camss_clock *clock = &csid->clock[i];
-
-		clock->clk = devm_clk_get(dev, res->clock[i]);
-		if (IS_ERR(clock->clk))
-			return PTR_ERR(clock->clk);
-
-		clock->name = res->clock[i];
-
-		clock->nfreqs = 0;
-		while (res->clock_rate[i][clock->nfreqs])
-			clock->nfreqs++;
-
-		if (!clock->nfreqs) {
-			clock->freq = NULL;
-			continue;
-		}
-
-		clock->freq = devm_kcalloc(dev,
-					   clock->nfreqs,
-					   sizeof(*clock->freq),
-					   GFP_KERNEL);
-		if (!clock->freq)
-			return -ENOMEM;
-
-		for (j = 0; j < clock->nfreqs; j++)
-			clock->freq[j] = res->clock_rate[i][j];
-	}
-
-	/* Regulator */
-
-	csid->vdda = devm_regulator_get(dev, res->regulator[0]);
-	if (IS_ERR(csid->vdda)) {
-		dev_err(dev, "could not get regulator\n");
-		return PTR_ERR(csid->vdda);
-	}
-
-	init_completion(&csid->reset_complete);
-
-	return 0;
-}
-
-/*
- * msm_csid_get_csid_id - Get CSID HW module id
- * @entity: Pointer to CSID media entity structure
- * @id: Return CSID HW module id here
- */
-void msm_csid_get_csid_id(struct media_entity *entity, u8 *id)
-{
-	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
-	struct csid_device *csid = v4l2_get_subdevdata(sd);
-
-	*id = csid->id;
-}
-
-/*
- * csid_get_lane_assign - Calculate CSI2 lane assign configuration parameter
- * @lane_cfg - CSI2 lane configuration
- *
- * Return lane assign
- */
-static u32 csid_get_lane_assign(struct csiphy_lanes_cfg *lane_cfg)
-{
-	u32 lane_assign = 0;
-	int i;
-
-	for (i = 0; i < lane_cfg->num_data; i++)
-		lane_assign |= lane_cfg->data[i].pos << (i * 4);
-
-	return lane_assign;
-}
-
-/*
- * csid_link_setup - Setup CSID connections
- * @entity: Pointer to media entity structure
- * @local: Pointer to local pad
- * @remote: Pointer to remote pad
- * @flags: Link flags
- *
- * Return 0 on success
- */
-static int csid_link_setup(struct media_entity *entity,
-			   const struct media_pad *local,
-			   const struct media_pad *remote, u32 flags)
-{
-	if (flags & MEDIA_LNK_FL_ENABLED)
-		if (media_entity_remote_pad(local))
-			return -EBUSY;
-
-	if ((local->flags & MEDIA_PAD_FL_SINK) &&
-	    (flags & MEDIA_LNK_FL_ENABLED)) {
-		struct v4l2_subdev *sd;
-		struct csid_device *csid;
-		struct csiphy_device *csiphy;
-		struct csiphy_lanes_cfg *lane_cfg;
-		struct v4l2_subdev_format format = { 0 };
-
-		sd = media_entity_to_v4l2_subdev(entity);
-		csid = v4l2_get_subdevdata(sd);
-
-		/* If test generator is enabled */
-		/* do not allow a link from CSIPHY to CSID */
-		if (csid->testgen_mode->cur.val != 0)
-			return -EBUSY;
-
-		sd = media_entity_to_v4l2_subdev(remote->entity);
-		csiphy = v4l2_get_subdevdata(sd);
-
-		/* If a sensor is not linked to CSIPHY */
-		/* do no allow a link from CSIPHY to CSID */
-		if (!csiphy->cfg.csi2)
-			return -EPERM;
-
-		csid->phy.csiphy_id = csiphy->id;
-
-		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
-		csid->phy.lane_cnt = lane_cfg->num_data;
-		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
-
-		/* Reset format on source pad to sink pad format */
-		format.pad = MSM_CSID_PAD_SRC;
-		format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
-		csid_set_format(&csid->subdev, NULL, &format);
-	}
-
-	return 0;
-}
-
-static const struct v4l2_subdev_core_ops csid_core_ops = {
-	.s_power = csid_set_power,
-};
-
-static const struct v4l2_subdev_video_ops csid_video_ops = {
-	.s_stream = csid_set_stream,
-};
-
-static const struct v4l2_subdev_pad_ops csid_pad_ops = {
-	.enum_mbus_code = csid_enum_mbus_code,
-	.enum_frame_size = csid_enum_frame_size,
-	.get_fmt = csid_get_format,
-	.set_fmt = csid_set_format,
-};
-
-static const struct v4l2_subdev_ops csid_v4l2_ops = {
-	.core = &csid_core_ops,
-	.video = &csid_video_ops,
-	.pad = &csid_pad_ops,
-};
-
-static const struct v4l2_subdev_internal_ops csid_v4l2_internal_ops = {
-	.open = csid_init_formats,
-};
-
-static const struct media_entity_operations csid_media_ops = {
-	.link_setup = csid_link_setup,
-	.link_validate = v4l2_subdev_link_validate,
-};
-
-/*
- * msm_csid_register_entity - Register subdev node for CSID module
- * @csid: CSID device
- * @v4l2_dev: V4L2 device
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_csid_register_entity(struct csid_device *csid,
-			     struct v4l2_device *v4l2_dev)
-{
-	struct v4l2_subdev *sd = &csid->subdev;
-	struct media_pad *pads = csid->pads;
-	struct device *dev = to_device_index(csid, csid->id);
-	int ret;
-
-	v4l2_subdev_init(sd, &csid_v4l2_ops);
-	sd->internal_ops = &csid_v4l2_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
-		 MSM_CSID_NAME, csid->id);
-	v4l2_set_subdevdata(sd, csid);
-
-	ret = v4l2_ctrl_handler_init(&csid->ctrls, 1);
-	if (ret < 0) {
-		dev_err(dev, "Failed to init ctrl handler: %d\n", ret);
-		return ret;
-	}
-
-	csid->testgen_mode = v4l2_ctrl_new_std_menu_items(&csid->ctrls,
-				&csid_ctrl_ops, V4L2_CID_TEST_PATTERN,
-				ARRAY_SIZE(csid_test_pattern_menu) - 1, 0, 0,
-				csid_test_pattern_menu);
-
-	if (csid->ctrls.error) {
-		dev_err(dev, "Failed to init ctrl: %d\n", csid->ctrls.error);
-		ret = csid->ctrls.error;
-		goto free_ctrl;
-	}
-
-	csid->subdev.ctrl_handler = &csid->ctrls;
-
-	ret = csid_init_formats(sd, NULL);
-	if (ret < 0) {
-		dev_err(dev, "Failed to init format: %d\n", ret);
-		goto free_ctrl;
-	}
-
-	pads[MSM_CSID_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-	pads[MSM_CSID_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
-
-	sd->entity.function = MEDIA_ENT_F_IO_V4L;
-	sd->entity.ops = &csid_media_ops;
-	ret = media_entity_pads_init(&sd->entity, MSM_CSID_PADS_NUM, pads);
-	if (ret < 0) {
-		dev_err(dev, "Failed to init media entity: %d\n", ret);
-		goto free_ctrl;
-	}
-
-	ret = v4l2_device_register_subdev(v4l2_dev, sd);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register subdev: %d\n", ret);
-		goto media_cleanup;
-	}
-
-	return 0;
-
-media_cleanup:
-	media_entity_cleanup(&sd->entity);
-free_ctrl:
-	v4l2_ctrl_handler_free(&csid->ctrls);
-
-	return ret;
-}
-
-/*
- * msm_csid_unregister_entity - Unregister CSID module subdev node
- * @csid: CSID device
- */
-void msm_csid_unregister_entity(struct csid_device *csid)
-{
-	v4l2_device_unregister_subdev(&csid->subdev);
-	media_entity_cleanup(&csid->subdev.entity);
-	v4l2_ctrl_handler_free(&csid->ctrls);
-}
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-csid.h b/drivers/media/platform/qcom/camss-8x16/camss-csid.h
deleted file mode 100644
index 8682d30..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-csid.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * camss-csid.h
- *
- * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
- *
- * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef QC_MSM_CAMSS_CSID_H
-#define QC_MSM_CAMSS_CSID_H
-
-#include <linux/clk.h>
-#include <media/media-entity.h>
-#include <media/v4l2-ctrls.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-mediabus.h>
-#include <media/v4l2-subdev.h>
-
-#define MSM_CSID_PAD_SINK 0
-#define MSM_CSID_PAD_SRC 1
-#define MSM_CSID_PADS_NUM 2
-
-enum csid_payload_mode {
-	CSID_PAYLOAD_MODE_INCREMENTING = 0,
-	CSID_PAYLOAD_MODE_ALTERNATING_55_AA = 1,
-	CSID_PAYLOAD_MODE_ALL_ZEROES = 2,
-	CSID_PAYLOAD_MODE_ALL_ONES = 3,
-	CSID_PAYLOAD_MODE_RANDOM = 4,
-	CSID_PAYLOAD_MODE_USER_SPECIFIED = 5,
-};
-
-struct csid_testgen_config {
-	u8 enabled;
-	enum csid_payload_mode payload_mode;
-};
-
-struct csid_phy_config {
-	u8 csiphy_id;
-	u8 lane_cnt;
-	u32 lane_assign;
-};
-
-struct csid_device {
-	u8 id;
-	struct v4l2_subdev subdev;
-	struct media_pad pads[MSM_CSID_PADS_NUM];
-	void __iomem *base;
-	u32 irq;
-	char irq_name[30];
-	struct camss_clock *clock;
-	int nclocks;
-	struct regulator *vdda;
-	struct completion reset_complete;
-	struct csid_testgen_config testgen;
-	struct csid_phy_config phy;
-	struct v4l2_mbus_framefmt fmt[MSM_CSID_PADS_NUM];
-	struct v4l2_ctrl_handler ctrls;
-	struct v4l2_ctrl *testgen_mode;
-};
-
-struct resources;
-
-int msm_csid_subdev_init(struct csid_device *csid,
-			 const struct resources *res, u8 id);
-
-int msm_csid_register_entity(struct csid_device *csid,
-			     struct v4l2_device *v4l2_dev);
-
-void msm_csid_unregister_entity(struct csid_device *csid);
-
-void msm_csid_get_csid_id(struct media_entity *entity, u8 *id);
-
-#endif /* QC_MSM_CAMSS_CSID_H */
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-csiphy.c b/drivers/media/platform/qcom/camss-8x16/camss-csiphy.c
deleted file mode 100644
index 7e61cab..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-csiphy.c
+++ /dev/null
@@ -1,893 +0,0 @@
-/*
- * camss-csiphy.c
- *
- * Qualcomm MSM Camera Subsystem - CSIPHY Module
- *
- * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2016-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-
-#include "camss-csiphy.h"
-#include "camss.h"
-
-#define MSM_CSIPHY_NAME "msm_csiphy"
-
-#define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
-#define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
-#define CAMSS_CSI_PHY_GLBL_RESET		0x140
-#define CAMSS_CSI_PHY_GLBL_PWR_CFG		0x144
-#define CAMSS_CSI_PHY_GLBL_IRQ_CMD		0x164
-#define CAMSS_CSI_PHY_HW_VERSION		0x188
-#define CAMSS_CSI_PHY_INTERRUPT_STATUSn(n)	(0x18c + 0x4 * (n))
-#define CAMSS_CSI_PHY_INTERRUPT_MASKn(n)	(0x1ac + 0x4 * (n))
-#define CAMSS_CSI_PHY_INTERRUPT_CLEARn(n)	(0x1cc + 0x4 * (n))
-#define CAMSS_CSI_PHY_GLBL_T_INIT_CFG0		0x1ec
-#define CAMSS_CSI_PHY_T_WAKEUP_CFG0		0x1f4
-
-static const struct {
-	u32 code;
-	u8 bpp;
-} csiphy_formats[] = {
-	{
-		MEDIA_BUS_FMT_UYVY8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_VYUY8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_YUYV8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_YVYU8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR12_1X12,
-		12,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG12_1X12,
-		12,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG12_1X12,
-		12,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB12_1X12,
-		12,
-	}
-};
-
-/*
- * csiphy_get_bpp - map media bus format to bits per pixel
- * @code: media bus format code
- *
- * Return number of bits per pixel
- */
-static u8 csiphy_get_bpp(u32 code)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(csiphy_formats); i++)
-		if (code == csiphy_formats[i].code)
-			return csiphy_formats[i].bpp;
-
-	WARN(1, "Unknown format\n");
-
-	return csiphy_formats[0].bpp;
-}
-
-/*
- * csiphy_isr - CSIPHY module interrupt handler
- * @irq: Interrupt line
- * @dev: CSIPHY device
- *
- * Return IRQ_HANDLED on success
- */
-static irqreturn_t csiphy_isr(int irq, void *dev)
-{
-	struct csiphy_device *csiphy = dev;
-	u8 i;
-
-	for (i = 0; i < 8; i++) {
-		u8 val = readl_relaxed(csiphy->base +
-				       CAMSS_CSI_PHY_INTERRUPT_STATUSn(i));
-		writel_relaxed(val, csiphy->base +
-			       CAMSS_CSI_PHY_INTERRUPT_CLEARn(i));
-		writel_relaxed(0x1, csiphy->base + CAMSS_CSI_PHY_GLBL_IRQ_CMD);
-		writel_relaxed(0x0, csiphy->base + CAMSS_CSI_PHY_GLBL_IRQ_CMD);
-		writel_relaxed(0x0, csiphy->base +
-			       CAMSS_CSI_PHY_INTERRUPT_CLEARn(i));
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*
- * csiphy_set_clock_rates - Calculate and set clock rates on CSIPHY module
- * @csiphy: CSIPHY device
- */
-static int csiphy_set_clock_rates(struct csiphy_device *csiphy)
-{
-	struct device *dev = to_device_index(csiphy, csiphy->id);
-	u32 pixel_clock;
-	int i, j;
-	int ret;
-
-	ret = camss_get_pixel_clock(&csiphy->subdev.entity, &pixel_clock);
-	if (ret)
-		pixel_clock = 0;
-
-	for (i = 0; i < csiphy->nclocks; i++) {
-		struct camss_clock *clock = &csiphy->clock[i];
-
-		if (!strcmp(clock->name, "csiphy0_timer") ||
-			!strcmp(clock->name, "csiphy1_timer")) {
-			u8 bpp = csiphy_get_bpp(
-					csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
-			u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
-			u64 min_rate = pixel_clock * bpp / (2 * num_lanes * 4);
-			long round_rate;
-
-			camss_add_clock_margin(&min_rate);
-
-			for (j = 0; j < clock->nfreqs; j++)
-				if (min_rate < clock->freq[j])
-					break;
-
-			if (j == clock->nfreqs) {
-				dev_err(dev,
-					"Pixel clock is too high for CSIPHY\n");
-				return -EINVAL;
-			}
-
-			/* if sensor pixel clock is not available */
-			/* set highest possible CSIPHY clock rate */
-			if (min_rate == 0)
-				j = clock->nfreqs - 1;
-
-			round_rate = clk_round_rate(clock->clk, clock->freq[j]);
-			if (round_rate < 0) {
-				dev_err(dev, "clk round rate failed: %ld\n",
-					round_rate);
-				return -EINVAL;
-			}
-
-			csiphy->timer_clk_rate = round_rate;
-
-			ret = clk_set_rate(clock->clk, csiphy->timer_clk_rate);
-			if (ret < 0) {
-				dev_err(dev, "clk set rate failed: %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
-	return 0;
-}
-
-/*
- * csiphy_reset - Perform software reset on CSIPHY module
- * @csiphy: CSIPHY device
- */
-static void csiphy_reset(struct csiphy_device *csiphy)
-{
-	writel_relaxed(0x1, csiphy->base + CAMSS_CSI_PHY_GLBL_RESET);
-	usleep_range(5000, 8000);
-	writel_relaxed(0x0, csiphy->base + CAMSS_CSI_PHY_GLBL_RESET);
-}
-
-/*
- * csiphy_set_power - Power on/off CSIPHY module
- * @sd: CSIPHY V4L2 subdevice
- * @on: Requested power state
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csiphy_set_power(struct v4l2_subdev *sd, int on)
-{
-	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
-	struct device *dev = to_device_index(csiphy, csiphy->id);
-
-	if (on) {
-		u8 hw_version;
-		int ret;
-
-		ret = csiphy_set_clock_rates(csiphy);
-		if (ret < 0)
-			return ret;
-
-		ret = camss_enable_clocks(csiphy->nclocks, csiphy->clock, dev);
-		if (ret < 0)
-			return ret;
-
-		enable_irq(csiphy->irq);
-
-		csiphy_reset(csiphy);
-
-		hw_version = readl_relaxed(csiphy->base +
-					   CAMSS_CSI_PHY_HW_VERSION);
-		dev_dbg(dev, "CSIPHY HW Version = 0x%02x\n", hw_version);
-	} else {
-		disable_irq(csiphy->irq);
-
-		camss_disable_clocks(csiphy->nclocks, csiphy->clock);
-	}
-
-	return 0;
-}
-
-/*
- * csiphy_get_lane_mask - Calculate CSI2 lane mask configuration parameter
- * @lane_cfg - CSI2 lane configuration
- *
- * Return lane mask
- */
-static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
-{
-	u8 lane_mask;
-	int i;
-
-	lane_mask = 1 << lane_cfg->clk.pos;
-
-	for (i = 0; i < lane_cfg->num_data; i++)
-		lane_mask |= 1 << lane_cfg->data[i].pos;
-
-	return lane_mask;
-}
-
-/*
- * csiphy_settle_cnt_calc - Calculate settle count value
- * @csiphy: CSIPHY device
- *
- * Helper function to calculate settle count value. This is
- * based on the CSI2 T_hs_settle parameter which in turn
- * is calculated based on the CSI2 transmitter pixel clock
- * frequency.
- *
- * Return settle count value or 0 if the CSI2 pixel clock
- * frequency is not available
- */
-static u8 csiphy_settle_cnt_calc(struct csiphy_device *csiphy)
-{
-	u8 bpp = csiphy_get_bpp(
-			csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
-	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
-	u32 pixel_clock; /* Hz */
-	u32 mipi_clock; /* Hz */
-	u32 ui; /* ps */
-	u32 timer_period; /* ps */
-	u32 t_hs_prepare_max; /* ps */
-	u32 t_hs_prepare_zero_min; /* ps */
-	u32 t_hs_settle; /* ps */
-	u8 settle_cnt;
-	int ret;
-
-	ret = camss_get_pixel_clock(&csiphy->subdev.entity, &pixel_clock);
-	if (ret) {
-		dev_err(to_device_index(csiphy, csiphy->id),
-			"Cannot get CSI2 transmitter's pixel clock\n");
-		return 0;
-	}
-	if (!pixel_clock) {
-		dev_err(to_device_index(csiphy, csiphy->id),
-			"Got pixel clock == 0, cannot continue\n");
-		return 0;
-	}
-
-	mipi_clock = pixel_clock * bpp / (2 * num_lanes);
-	ui = div_u64(1000000000000LL, mipi_clock);
-	ui /= 2;
-	t_hs_prepare_max = 85000 + 6 * ui;
-	t_hs_prepare_zero_min = 145000 + 10 * ui;
-	t_hs_settle = (t_hs_prepare_max + t_hs_prepare_zero_min) / 2;
-
-	timer_period = div_u64(1000000000000LL, csiphy->timer_clk_rate);
-	settle_cnt = t_hs_settle / timer_period;
-
-	return settle_cnt;
-}
-
-/*
- * csiphy_stream_on - Enable streaming on CSIPHY module
- * @csiphy: CSIPHY device
- *
- * Helper function to enable streaming on CSIPHY module.
- * Main configuration of CSIPHY module is also done here.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csiphy_stream_on(struct csiphy_device *csiphy)
-{
-	struct csiphy_config *cfg = &csiphy->cfg;
-	u8 lane_mask = csiphy_get_lane_mask(&cfg->csi2->lane_cfg);
-	u8 settle_cnt;
-	u8 val;
-	int i = 0;
-
-	settle_cnt = csiphy_settle_cnt_calc(csiphy);
-	if (!settle_cnt)
-		return -EINVAL;
-
-	val = readl_relaxed(csiphy->base_clk_mux);
-	if (cfg->combo_mode && (lane_mask & 0x18) == 0x18) {
-		val &= ~0xf0;
-		val |= cfg->csid_id << 4;
-	} else {
-		val &= ~0xf;
-		val |= cfg->csid_id;
-	}
-	writel_relaxed(val, csiphy->base_clk_mux);
-
-	writel_relaxed(0x1, csiphy->base +
-		       CAMSS_CSI_PHY_GLBL_T_INIT_CFG0);
-	writel_relaxed(0x1, csiphy->base +
-		       CAMSS_CSI_PHY_T_WAKEUP_CFG0);
-
-	val = 0x1;
-	val |= lane_mask << 1;
-	writel_relaxed(val, csiphy->base + CAMSS_CSI_PHY_GLBL_PWR_CFG);
-
-	val = cfg->combo_mode << 4;
-	writel_relaxed(val, csiphy->base + CAMSS_CSI_PHY_GLBL_RESET);
-
-	while (lane_mask) {
-		if (lane_mask & 0x1) {
-			writel_relaxed(0x10, csiphy->base +
-				       CAMSS_CSI_PHY_LNn_CFG2(i));
-			writel_relaxed(settle_cnt, csiphy->base +
-				       CAMSS_CSI_PHY_LNn_CFG3(i));
-			writel_relaxed(0x3f, csiphy->base +
-				       CAMSS_CSI_PHY_INTERRUPT_MASKn(i));
-			writel_relaxed(0x3f, csiphy->base +
-				       CAMSS_CSI_PHY_INTERRUPT_CLEARn(i));
-		}
-
-		lane_mask >>= 1;
-		i++;
-	}
-
-	return 0;
-}
-
-/*
- * csiphy_stream_off - Disable streaming on CSIPHY module
- * @csiphy: CSIPHY device
- *
- * Helper function to disable streaming on CSIPHY module
- */
-static void csiphy_stream_off(struct csiphy_device *csiphy)
-{
-	u8 lane_mask = csiphy_get_lane_mask(&csiphy->cfg.csi2->lane_cfg);
-	int i = 0;
-
-	while (lane_mask) {
-		if (lane_mask & 0x1)
-			writel_relaxed(0x0, csiphy->base +
-				       CAMSS_CSI_PHY_LNn_CFG2(i));
-
-		lane_mask >>= 1;
-		i++;
-	}
-
-	writel_relaxed(0x0, csiphy->base + CAMSS_CSI_PHY_GLBL_PWR_CFG);
-}
-
-
-/*
- * csiphy_set_stream - Enable/disable streaming on CSIPHY module
- * @sd: CSIPHY V4L2 subdevice
- * @enable: Requested streaming state
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csiphy_set_stream(struct v4l2_subdev *sd, int enable)
-{
-	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
-	int ret = 0;
-
-	if (enable)
-		ret = csiphy_stream_on(csiphy);
-	else
-		csiphy_stream_off(csiphy);
-
-	return ret;
-}
-
-/*
- * __csiphy_get_format - Get pointer to format structure
- * @csiphy: CSIPHY device
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad from which format is requested
- * @which: TRY or ACTIVE format
- *
- * Return pointer to TRY or ACTIVE format structure
- */
-static struct v4l2_mbus_framefmt *
-__csiphy_get_format(struct csiphy_device *csiphy,
-		    struct v4l2_subdev_pad_config *cfg,
-		    unsigned int pad,
-		    enum v4l2_subdev_format_whence which)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_format(&csiphy->subdev, cfg, pad);
-
-	return &csiphy->fmt[pad];
-}
-
-/*
- * csiphy_try_format - Handle try format by pad subdev method
- * @csiphy: CSIPHY device
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad on which format is requested
- * @fmt: pointer to v4l2 format structure
- * @which: wanted subdev format
- */
-static void csiphy_try_format(struct csiphy_device *csiphy,
-			      struct v4l2_subdev_pad_config *cfg,
-			      unsigned int pad,
-			      struct v4l2_mbus_framefmt *fmt,
-			      enum v4l2_subdev_format_whence which)
-{
-	unsigned int i;
-
-	switch (pad) {
-	case MSM_CSIPHY_PAD_SINK:
-		/* Set format on sink pad */
-
-		for (i = 0; i < ARRAY_SIZE(csiphy_formats); i++)
-			if (fmt->code == csiphy_formats[i].code)
-				break;
-
-		/* If not found, use UYVY as default */
-		if (i >= ARRAY_SIZE(csiphy_formats))
-			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-
-		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
-		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
-
-		fmt->field = V4L2_FIELD_NONE;
-		fmt->colorspace = V4L2_COLORSPACE_SRGB;
-
-		break;
-
-	case MSM_CSIPHY_PAD_SRC:
-		/* Set and return a format same as sink pad */
-
-		*fmt = *__csiphy_get_format(csiphy, cfg, MSM_CSID_PAD_SINK,
-					    which);
-
-		break;
-	}
-}
-
-/*
- * csiphy_enum_mbus_code - Handle pixel format enumeration
- * @sd: CSIPHY V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @code: pointer to v4l2_subdev_mbus_code_enum structure
- * return -EINVAL or zero on success
- */
-static int csiphy_enum_mbus_code(struct v4l2_subdev *sd,
-				 struct v4l2_subdev_pad_config *cfg,
-				 struct v4l2_subdev_mbus_code_enum *code)
-{
-	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	if (code->pad == MSM_CSIPHY_PAD_SINK) {
-		if (code->index >= ARRAY_SIZE(csiphy_formats))
-			return -EINVAL;
-
-		code->code = csiphy_formats[code->index].code;
-	} else {
-		if (code->index > 0)
-			return -EINVAL;
-
-		format = __csiphy_get_format(csiphy, cfg, MSM_CSIPHY_PAD_SINK,
-					     code->which);
-
-		code->code = format->code;
-	}
-
-	return 0;
-}
-
-/*
- * csiphy_enum_frame_size - Handle frame size enumeration
- * @sd: CSIPHY V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fse: pointer to v4l2_subdev_frame_size_enum structure
- * return -EINVAL or zero on success
- */
-static int csiphy_enum_frame_size(struct v4l2_subdev *sd,
-				  struct v4l2_subdev_pad_config *cfg,
-				  struct v4l2_subdev_frame_size_enum *fse)
-{
-	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt format;
-
-	if (fse->index != 0)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = 1;
-	format.height = 1;
-	csiphy_try_format(csiphy, cfg, fse->pad, &format, fse->which);
-	fse->min_width = format.width;
-	fse->min_height = format.height;
-
-	if (format.code != fse->code)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = -1;
-	format.height = -1;
-	csiphy_try_format(csiphy, cfg, fse->pad, &format, fse->which);
-	fse->max_width = format.width;
-	fse->max_height = format.height;
-
-	return 0;
-}
-
-/*
- * csiphy_get_format - Handle get format by pads subdev method
- * @sd: CSIPHY V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int csiphy_get_format(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_pad_config *cfg,
-			     struct v4l2_subdev_format *fmt)
-{
-	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __csiphy_get_format(csiphy, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	fmt->format = *format;
-
-	return 0;
-}
-
-/*
- * csiphy_set_format - Handle set format by pads subdev method
- * @sd: CSIPHY V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int csiphy_set_format(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_pad_config *cfg,
-			     struct v4l2_subdev_format *fmt)
-{
-	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __csiphy_get_format(csiphy, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	csiphy_try_format(csiphy, cfg, fmt->pad, &fmt->format, fmt->which);
-	*format = fmt->format;
-
-	/* Propagate the format from sink to source */
-	if (fmt->pad == MSM_CSIPHY_PAD_SINK) {
-		format = __csiphy_get_format(csiphy, cfg, MSM_CSIPHY_PAD_SRC,
-					     fmt->which);
-
-		*format = fmt->format;
-		csiphy_try_format(csiphy, cfg, MSM_CSIPHY_PAD_SRC, format,
-				  fmt->which);
-	}
-
-	return 0;
-}
-
-/*
- * csiphy_init_formats - Initialize formats on all pads
- * @sd: CSIPHY V4L2 subdevice
- * @fh: V4L2 subdev file handle
- *
- * Initialize all pad formats with default values.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int csiphy_init_formats(struct v4l2_subdev *sd,
-			       struct v4l2_subdev_fh *fh)
-{
-	struct v4l2_subdev_format format = {
-		.pad = MSM_CSIPHY_PAD_SINK,
-		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
-			      V4L2_SUBDEV_FORMAT_ACTIVE,
-		.format = {
-			.code = MEDIA_BUS_FMT_UYVY8_2X8,
-			.width = 1920,
-			.height = 1080
-		}
-	};
-
-	return csiphy_set_format(sd, fh ? fh->pad : NULL, &format);
-}
-
-/*
- * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
- * @csiphy: CSIPHY device
- * @res: CSIPHY module resources table
- * @id: CSIPHY module id
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_csiphy_subdev_init(struct csiphy_device *csiphy,
-			   const struct resources *res, u8 id)
-{
-	struct device *dev = to_device_index(csiphy, id);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *r;
-	int i, j;
-	int ret;
-
-	csiphy->id = id;
-	csiphy->cfg.combo_mode = 0;
-
-	/* Memory */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
-	csiphy->base = devm_ioremap_resource(dev, r);
-	if (IS_ERR(csiphy->base)) {
-		dev_err(dev, "could not map memory\n");
-		return PTR_ERR(csiphy->base);
-	}
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[1]);
-	csiphy->base_clk_mux = devm_ioremap_resource(dev, r);
-	if (IS_ERR(csiphy->base_clk_mux)) {
-		dev_err(dev, "could not map memory\n");
-		return PTR_ERR(csiphy->base_clk_mux);
-	}
-
-	/* Interrupt */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					 res->interrupt[0]);
-	if (!r) {
-		dev_err(dev, "missing IRQ\n");
-		return -EINVAL;
-	}
-
-	csiphy->irq = r->start;
-	snprintf(csiphy->irq_name, sizeof(csiphy->irq_name), "%s_%s%d",
-		 dev_name(dev), MSM_CSIPHY_NAME, csiphy->id);
-	ret = devm_request_irq(dev, csiphy->irq, csiphy_isr,
-			       IRQF_TRIGGER_RISING, csiphy->irq_name, csiphy);
-	if (ret < 0) {
-		dev_err(dev, "request_irq failed: %d\n", ret);
-		return ret;
-	}
-
-	disable_irq(csiphy->irq);
-
-	/* Clocks */
-
-	csiphy->nclocks = 0;
-	while (res->clock[csiphy->nclocks])
-		csiphy->nclocks++;
-
-	csiphy->clock = devm_kcalloc(dev,
-				     csiphy->nclocks, sizeof(*csiphy->clock),
-				     GFP_KERNEL);
-	if (!csiphy->clock)
-		return -ENOMEM;
-
-	for (i = 0; i < csiphy->nclocks; i++) {
-		struct camss_clock *clock = &csiphy->clock[i];
-
-		clock->clk = devm_clk_get(dev, res->clock[i]);
-		if (IS_ERR(clock->clk))
-			return PTR_ERR(clock->clk);
-
-		clock->name = res->clock[i];
-
-		clock->nfreqs = 0;
-		while (res->clock_rate[i][clock->nfreqs])
-			clock->nfreqs++;
-
-		if (!clock->nfreqs) {
-			clock->freq = NULL;
-			continue;
-		}
-
-		clock->freq = devm_kcalloc(dev,
-					   clock->nfreqs,
-					   sizeof(*clock->freq),
-					   GFP_KERNEL);
-		if (!clock->freq)
-			return -ENOMEM;
-
-		for (j = 0; j < clock->nfreqs; j++)
-			clock->freq[j] = res->clock_rate[i][j];
-	}
-
-	return 0;
-}
-
-/*
- * csiphy_link_setup - Setup CSIPHY connections
- * @entity: Pointer to media entity structure
- * @local: Pointer to local pad
- * @remote: Pointer to remote pad
- * @flags: Link flags
- *
- * Rreturn 0 on success
- */
-static int csiphy_link_setup(struct media_entity *entity,
-			     const struct media_pad *local,
-			     const struct media_pad *remote, u32 flags)
-{
-	if ((local->flags & MEDIA_PAD_FL_SOURCE) &&
-	    (flags & MEDIA_LNK_FL_ENABLED)) {
-		struct v4l2_subdev *sd;
-		struct csiphy_device *csiphy;
-		struct csid_device *csid;
-
-		if (media_entity_remote_pad(local))
-			return -EBUSY;
-
-		sd = media_entity_to_v4l2_subdev(entity);
-		csiphy = v4l2_get_subdevdata(sd);
-
-		sd = media_entity_to_v4l2_subdev(remote->entity);
-		csid = v4l2_get_subdevdata(sd);
-
-		csiphy->cfg.csid_id = csid->id;
-	}
-
-	return 0;
-}
-
-static const struct v4l2_subdev_core_ops csiphy_core_ops = {
-	.s_power = csiphy_set_power,
-};
-
-static const struct v4l2_subdev_video_ops csiphy_video_ops = {
-	.s_stream = csiphy_set_stream,
-};
-
-static const struct v4l2_subdev_pad_ops csiphy_pad_ops = {
-	.enum_mbus_code = csiphy_enum_mbus_code,
-	.enum_frame_size = csiphy_enum_frame_size,
-	.get_fmt = csiphy_get_format,
-	.set_fmt = csiphy_set_format,
-};
-
-static const struct v4l2_subdev_ops csiphy_v4l2_ops = {
-	.core = &csiphy_core_ops,
-	.video = &csiphy_video_ops,
-	.pad = &csiphy_pad_ops,
-};
-
-static const struct v4l2_subdev_internal_ops csiphy_v4l2_internal_ops = {
-	.open = csiphy_init_formats,
-};
-
-static const struct media_entity_operations csiphy_media_ops = {
-	.link_setup = csiphy_link_setup,
-	.link_validate = v4l2_subdev_link_validate,
-};
-
-/*
- * msm_csiphy_register_entity - Register subdev node for CSIPHY module
- * @csiphy: CSIPHY device
- * @v4l2_dev: V4L2 device
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_csiphy_register_entity(struct csiphy_device *csiphy,
-			       struct v4l2_device *v4l2_dev)
-{
-	struct v4l2_subdev *sd = &csiphy->subdev;
-	struct media_pad *pads = csiphy->pads;
-	struct device *dev = to_device_index(csiphy, csiphy->id);
-	int ret;
-
-	v4l2_subdev_init(sd, &csiphy_v4l2_ops);
-	sd->internal_ops = &csiphy_v4l2_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
-		 MSM_CSIPHY_NAME, csiphy->id);
-	v4l2_set_subdevdata(sd, csiphy);
-
-	ret = csiphy_init_formats(sd, NULL);
-	if (ret < 0) {
-		dev_err(dev, "Failed to init format: %d\n", ret);
-		return ret;
-	}
-
-	pads[MSM_CSIPHY_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-	pads[MSM_CSIPHY_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
-
-	sd->entity.function = MEDIA_ENT_F_IO_V4L;
-	sd->entity.ops = &csiphy_media_ops;
-	ret = media_entity_pads_init(&sd->entity, MSM_CSIPHY_PADS_NUM, pads);
-	if (ret < 0) {
-		dev_err(dev, "Failed to init media entity: %d\n", ret);
-		return ret;
-	}
-
-	ret = v4l2_device_register_subdev(v4l2_dev, sd);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register subdev: %d\n", ret);
-		media_entity_cleanup(&sd->entity);
-	}
-
-	return ret;
-}
-
-/*
- * msm_csiphy_unregister_entity - Unregister CSIPHY module subdev node
- * @csiphy: CSIPHY device
- */
-void msm_csiphy_unregister_entity(struct csiphy_device *csiphy)
-{
-	v4l2_device_unregister_subdev(&csiphy->subdev);
-	media_entity_cleanup(&csiphy->subdev.entity);
-}
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-csiphy.h b/drivers/media/platform/qcom/camss-8x16/camss-csiphy.h
deleted file mode 100644
index ba87811..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-csiphy.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * camss-csiphy.h
- *
- * Qualcomm MSM Camera Subsystem - CSIPHY Module
- *
- * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2016-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef QC_MSM_CAMSS_CSIPHY_H
-#define QC_MSM_CAMSS_CSIPHY_H
-
-#include <linux/clk.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-mediabus.h>
-#include <media/v4l2-subdev.h>
-
-#define MSM_CSIPHY_PAD_SINK 0
-#define MSM_CSIPHY_PAD_SRC 1
-#define MSM_CSIPHY_PADS_NUM 2
-
-struct csiphy_lane {
-	u8 pos;
-	u8 pol;
-};
-
-struct csiphy_lanes_cfg {
-	int num_data;
-	struct csiphy_lane *data;
-	struct csiphy_lane clk;
-};
-
-struct csiphy_csi2_cfg {
-	struct csiphy_lanes_cfg lane_cfg;
-};
-
-struct csiphy_config {
-	u8 combo_mode;
-	u8 csid_id;
-	struct csiphy_csi2_cfg *csi2;
-};
-
-struct csiphy_device {
-	u8 id;
-	struct v4l2_subdev subdev;
-	struct media_pad pads[MSM_CSIPHY_PADS_NUM];
-	void __iomem *base;
-	void __iomem *base_clk_mux;
-	u32 irq;
-	char irq_name[30];
-	struct camss_clock *clock;
-	int nclocks;
-	u32 timer_clk_rate;
-	struct csiphy_config cfg;
-	struct v4l2_mbus_framefmt fmt[MSM_CSIPHY_PADS_NUM];
-};
-
-struct resources;
-
-int msm_csiphy_subdev_init(struct csiphy_device *csiphy,
-			   const struct resources *res, u8 id);
-
-int msm_csiphy_register_entity(struct csiphy_device *csiphy,
-			       struct v4l2_device *v4l2_dev);
-
-void msm_csiphy_unregister_entity(struct csiphy_device *csiphy);
-
-#endif /* QC_MSM_CAMSS_CSIPHY_H */
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-ispif.c b/drivers/media/platform/qcom/camss-8x16/camss-ispif.c
deleted file mode 100644
index 9d1af93..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-ispif.c
+++ /dev/null
@@ -1,1178 +0,0 @@
-/*
- * camss-ispif.c
- *
- * Qualcomm MSM Camera Subsystem - ISPIF (ISP Interface) Module
- *
- * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/clk.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-#include <linux/iopoll.h>
-#include <linux/kernel.h>
-#include <linux/mutex.h>
-#include <linux/platform_device.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-
-#include "camss-ispif.h"
-#include "camss.h"
-
-#define MSM_ISPIF_NAME "msm_ispif"
-
-#define ispif_line_array(ptr_line)	\
-	((const struct ispif_line (*)[]) &(ptr_line[-(ptr_line->id)]))
-
-#define to_ispif(ptr_line)	\
-	container_of(ispif_line_array(ptr_line), struct ispif_device, ptr_line)
-
-#define ISPIF_RST_CMD_0			0x008
-#define ISPIF_RST_CMD_0_STROBED_RST_EN		(1 << 0)
-#define ISPIF_RST_CMD_0_MISC_LOGIC_RST		(1 << 1)
-#define ISPIF_RST_CMD_0_SW_REG_RST		(1 << 2)
-#define ISPIF_RST_CMD_0_PIX_INTF_0_CSID_RST	(1 << 3)
-#define ISPIF_RST_CMD_0_PIX_INTF_0_VFE_RST	(1 << 4)
-#define ISPIF_RST_CMD_0_PIX_INTF_1_CSID_RST	(1 << 5)
-#define ISPIF_RST_CMD_0_PIX_INTF_1_VFE_RST	(1 << 6)
-#define ISPIF_RST_CMD_0_RDI_INTF_0_CSID_RST	(1 << 7)
-#define ISPIF_RST_CMD_0_RDI_INTF_0_VFE_RST	(1 << 8)
-#define ISPIF_RST_CMD_0_RDI_INTF_1_CSID_RST	(1 << 9)
-#define ISPIF_RST_CMD_0_RDI_INTF_1_VFE_RST	(1 << 10)
-#define ISPIF_RST_CMD_0_RDI_INTF_2_CSID_RST	(1 << 11)
-#define ISPIF_RST_CMD_0_RDI_INTF_2_VFE_RST	(1 << 12)
-#define ISPIF_RST_CMD_0_PIX_OUTPUT_0_MISR_RST	(1 << 16)
-#define ISPIF_RST_CMD_0_RDI_OUTPUT_0_MISR_RST	(1 << 17)
-#define ISPIF_RST_CMD_0_RDI_OUTPUT_1_MISR_RST	(1 << 18)
-#define ISPIF_RST_CMD_0_RDI_OUTPUT_2_MISR_RST	(1 << 19)
-#define ISPIF_IRQ_GLOBAL_CLEAR_CMD	0x01c
-#define ISPIF_VFE_m_CTRL_0(m)		(0x200 + 0x200 * (m))
-#define ISPIF_VFE_m_CTRL_0_PIX0_LINE_BUF_EN	(1 << 6)
-#define ISPIF_VFE_m_IRQ_MASK_0(m)	(0x208 + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_MASK_0_PIX0_ENABLE	0x00001249
-#define ISPIF_VFE_m_IRQ_MASK_0_PIX0_MASK	0x00001fff
-#define ISPIF_VFE_m_IRQ_MASK_0_RDI0_ENABLE	0x02492000
-#define ISPIF_VFE_m_IRQ_MASK_0_RDI0_MASK	0x03ffe000
-#define ISPIF_VFE_m_IRQ_MASK_1(m)	(0x20c + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_MASK_1_PIX1_ENABLE	0x00001249
-#define ISPIF_VFE_m_IRQ_MASK_1_PIX1_MASK	0x00001fff
-#define ISPIF_VFE_m_IRQ_MASK_1_RDI1_ENABLE	0x02492000
-#define ISPIF_VFE_m_IRQ_MASK_1_RDI1_MASK	0x03ffe000
-#define ISPIF_VFE_m_IRQ_MASK_2(m)	(0x210 + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_MASK_2_RDI2_ENABLE	0x00001249
-#define ISPIF_VFE_m_IRQ_MASK_2_RDI2_MASK	0x00001fff
-#define ISPIF_VFE_m_IRQ_STATUS_0(m)	(0x21c + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW	(1 << 12)
-#define ISPIF_VFE_m_IRQ_STATUS_0_RDI0_OVERFLOW	(1 << 25)
-#define ISPIF_VFE_m_IRQ_STATUS_1(m)	(0x220 + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_STATUS_1_PIX1_OVERFLOW	(1 << 12)
-#define ISPIF_VFE_m_IRQ_STATUS_1_RDI1_OVERFLOW	(1 << 25)
-#define ISPIF_VFE_m_IRQ_STATUS_2(m)	(0x224 + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_STATUS_2_RDI2_OVERFLOW	(1 << 12)
-#define ISPIF_VFE_m_IRQ_CLEAR_0(m)	(0x230 + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_CLEAR_1(m)	(0x234 + 0x200 * (m))
-#define ISPIF_VFE_m_IRQ_CLEAR_2(m)	(0x238 + 0x200 * (m))
-#define ISPIF_VFE_m_INTF_INPUT_SEL(m)	(0x244 + 0x200 * (m))
-#define ISPIF_VFE_m_INTF_CMD_0(m)	(0x248 + 0x200 * (m))
-#define ISPIF_VFE_m_INTF_CMD_1(m)	(0x24c + 0x200 * (m))
-#define ISPIF_VFE_m_PIX_INTF_n_CID_MASK(m, n)	\
-					(0x254 + 0x200 * (m) + 0x4 * (n))
-#define ISPIF_VFE_m_RDI_INTF_n_CID_MASK(m, n)	\
-					(0x264 + 0x200 * (m) + 0x4 * (n))
-#define ISPIF_VFE_m_PIX_INTF_n_STATUS(m, n)	\
-					(0x2c0 + 0x200 * (m) + 0x4 * (n))
-#define ISPIF_VFE_m_RDI_INTF_n_STATUS(m, n)	\
-					(0x2d0 + 0x200 * (m) + 0x4 * (n))
-
-#define CSI_PIX_CLK_MUX_SEL		0x000
-#define CSI_RDI_CLK_MUX_SEL		0x008
-
-#define ISPIF_TIMEOUT_SLEEP_US		1000
-#define ISPIF_TIMEOUT_ALL_US		1000000
-#define ISPIF_RESET_TIMEOUT_MS		500
-
-enum ispif_intf_cmd {
-	CMD_DISABLE_FRAME_BOUNDARY = 0x0,
-	CMD_ENABLE_FRAME_BOUNDARY = 0x1,
-	CMD_DISABLE_IMMEDIATELY = 0x2,
-	CMD_ALL_DISABLE_IMMEDIATELY = 0xaaaaaaaa,
-	CMD_ALL_NO_CHANGE = 0xffffffff,
-};
-
-static const u32 ispif_formats[] = {
-	MEDIA_BUS_FMT_UYVY8_2X8,
-	MEDIA_BUS_FMT_VYUY8_2X8,
-	MEDIA_BUS_FMT_YUYV8_2X8,
-	MEDIA_BUS_FMT_YVYU8_2X8,
-	MEDIA_BUS_FMT_SBGGR8_1X8,
-	MEDIA_BUS_FMT_SGBRG8_1X8,
-	MEDIA_BUS_FMT_SGRBG8_1X8,
-	MEDIA_BUS_FMT_SRGGB8_1X8,
-	MEDIA_BUS_FMT_SBGGR10_1X10,
-	MEDIA_BUS_FMT_SGBRG10_1X10,
-	MEDIA_BUS_FMT_SGRBG10_1X10,
-	MEDIA_BUS_FMT_SRGGB10_1X10,
-	MEDIA_BUS_FMT_SBGGR12_1X12,
-	MEDIA_BUS_FMT_SGBRG12_1X12,
-	MEDIA_BUS_FMT_SGRBG12_1X12,
-	MEDIA_BUS_FMT_SRGGB12_1X12,
-};
-
-/*
- * ispif_isr - ISPIF module interrupt handler
- * @irq: Interrupt line
- * @dev: ISPIF device
- *
- * Return IRQ_HANDLED on success
- */
-static irqreturn_t ispif_isr(int irq, void *dev)
-{
-	struct ispif_device *ispif = dev;
-	u32 value0, value1, value2;
-
-	value0 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_0(0));
-	value1 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_1(0));
-	value2 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_2(0));
-
-	writel_relaxed(value0, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(0));
-	writel_relaxed(value1, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(0));
-	writel_relaxed(value2, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_2(0));
-
-	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
-
-	if ((value0 >> 27) & 0x1)
-		complete(&ispif->reset_complete);
-
-	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW))
-		dev_err_ratelimited(to_device(ispif), "VFE0 pix0 overflow\n");
-
-	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_RDI0_OVERFLOW))
-		dev_err_ratelimited(to_device(ispif), "VFE0 rdi0 overflow\n");
-
-	if (unlikely(value1 & ISPIF_VFE_m_IRQ_STATUS_1_PIX1_OVERFLOW))
-		dev_err_ratelimited(to_device(ispif), "VFE0 pix1 overflow\n");
-
-	if (unlikely(value1 & ISPIF_VFE_m_IRQ_STATUS_1_RDI1_OVERFLOW))
-		dev_err_ratelimited(to_device(ispif), "VFE0 rdi1 overflow\n");
-
-	if (unlikely(value2 & ISPIF_VFE_m_IRQ_STATUS_2_RDI2_OVERFLOW))
-		dev_err_ratelimited(to_device(ispif), "VFE0 rdi2 overflow\n");
-
-	return IRQ_HANDLED;
-}
-
-/*
- * ispif_reset - Trigger reset on ISPIF module and wait to complete
- * @ispif: ISPIF device
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int ispif_reset(struct ispif_device *ispif)
-{
-	unsigned long time;
-	u32 val;
-	int ret;
-
-	ret = camss_enable_clocks(ispif->nclocks_for_reset,
-				  ispif->clock_for_reset,
-				  to_device(ispif));
-	if (ret < 0)
-		return ret;
-
-	reinit_completion(&ispif->reset_complete);
-
-	val = ISPIF_RST_CMD_0_STROBED_RST_EN |
-		ISPIF_RST_CMD_0_MISC_LOGIC_RST |
-		ISPIF_RST_CMD_0_SW_REG_RST |
-		ISPIF_RST_CMD_0_PIX_INTF_0_CSID_RST |
-		ISPIF_RST_CMD_0_PIX_INTF_0_VFE_RST |
-		ISPIF_RST_CMD_0_PIX_INTF_1_CSID_RST |
-		ISPIF_RST_CMD_0_PIX_INTF_1_VFE_RST |
-		ISPIF_RST_CMD_0_RDI_INTF_0_CSID_RST |
-		ISPIF_RST_CMD_0_RDI_INTF_0_VFE_RST |
-		ISPIF_RST_CMD_0_RDI_INTF_1_CSID_RST |
-		ISPIF_RST_CMD_0_RDI_INTF_1_VFE_RST |
-		ISPIF_RST_CMD_0_RDI_INTF_2_CSID_RST |
-		ISPIF_RST_CMD_0_RDI_INTF_2_VFE_RST |
-		ISPIF_RST_CMD_0_PIX_OUTPUT_0_MISR_RST |
-		ISPIF_RST_CMD_0_RDI_OUTPUT_0_MISR_RST |
-		ISPIF_RST_CMD_0_RDI_OUTPUT_1_MISR_RST |
-		ISPIF_RST_CMD_0_RDI_OUTPUT_2_MISR_RST;
-
-	writel_relaxed(val, ispif->base + ISPIF_RST_CMD_0);
-
-	time = wait_for_completion_timeout(&ispif->reset_complete,
-		msecs_to_jiffies(ISPIF_RESET_TIMEOUT_MS));
-	if (!time) {
-		dev_err(to_device(ispif), "ISPIF reset timeout\n");
-		return -EIO;
-	}
-
-	camss_disable_clocks(ispif->nclocks_for_reset, ispif->clock_for_reset);
-
-	return 0;
-}
-
-/*
- * ispif_set_power - Power on/off ISPIF module
- * @sd: ISPIF V4L2 subdevice
- * @on: Requested power state
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int ispif_set_power(struct v4l2_subdev *sd, int on)
-{
-	struct ispif_line *line = v4l2_get_subdevdata(sd);
-	struct ispif_device *ispif = to_ispif(line);
-	struct device *dev = to_device(ispif);
-	int ret = 0;
-
-	mutex_lock(&ispif->power_lock);
-
-	if (on) {
-		if (ispif->power_count) {
-			/* Power is already on */
-			ispif->power_count++;
-			goto exit;
-		}
-
-		ret = camss_enable_clocks(ispif->nclocks, ispif->clock, dev);
-		if (ret < 0)
-			goto exit;
-
-		ret = ispif_reset(ispif);
-		if (ret < 0) {
-			camss_disable_clocks(ispif->nclocks, ispif->clock);
-			goto exit;
-		}
-
-		ispif->intf_cmd[line->vfe_id].cmd_0 = CMD_ALL_NO_CHANGE;
-		ispif->intf_cmd[line->vfe_id].cmd_1 = CMD_ALL_NO_CHANGE;
-
-		ispif->power_count++;
-	} else {
-		if (ispif->power_count == 0) {
-			dev_err(dev, "ispif power off on power_count == 0\n");
-			goto exit;
-		} else if (ispif->power_count == 1) {
-			camss_disable_clocks(ispif->nclocks, ispif->clock);
-		}
-
-		ispif->power_count--;
-	}
-
-exit:
-	mutex_unlock(&ispif->power_lock);
-
-	return ret;
-}
-
-/*
- * ispif_select_clk_mux - Select clock for PIX/RDI interface
- * @ispif: ISPIF device
- * @intf: VFE interface
- * @csid: CSID HW module id
- * @vfe: VFE HW module id
- * @enable: enable or disable the selected clock
- */
-static void ispif_select_clk_mux(struct ispif_device *ispif,
-				 enum ispif_intf intf, u8 csid,
-				 u8 vfe, u8 enable)
-{
-	u32 val;
-
-	switch (intf) {
-	case PIX0:
-		val = readl_relaxed(ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
-		val &= ~(0xf << (vfe * 8));
-		if (enable)
-			val |= (csid << (vfe * 8));
-		writel_relaxed(val, ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
-		break;
-
-	case RDI0:
-		val = readl_relaxed(ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
-		val &= ~(0xf << (vfe * 12));
-		if (enable)
-			val |= (csid << (vfe * 12));
-		writel_relaxed(val, ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
-		break;
-
-	case PIX1:
-		val = readl_relaxed(ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
-		val &= ~(0xf << (4 + (vfe * 8)));
-		if (enable)
-			val |= (csid << (4 + (vfe * 8)));
-		writel_relaxed(val, ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
-		break;
-
-	case RDI1:
-		val = readl_relaxed(ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
-		val &= ~(0xf << (4 + (vfe * 12)));
-		if (enable)
-			val |= (csid << (4 + (vfe * 12)));
-		writel_relaxed(val, ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
-		break;
-
-	case RDI2:
-		val = readl_relaxed(ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
-		val &= ~(0xf << (8 + (vfe * 12)));
-		if (enable)
-			val |= (csid << (8 + (vfe * 12)));
-		writel_relaxed(val, ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
-		break;
-	}
-
-	mb();
-}
-
-/*
- * ispif_validate_intf_status - Validate current status of PIX/RDI interface
- * @ispif: ISPIF device
- * @intf: VFE interface
- * @vfe: VFE HW module id
- *
- * Return 0 when interface is idle or -EBUSY otherwise
- */
-static int ispif_validate_intf_status(struct ispif_device *ispif,
-				      enum ispif_intf intf, u8 vfe)
-{
-	int ret = 0;
-	u32 val = 0;
-
-	switch (intf) {
-	case PIX0:
-		val = readl_relaxed(ispif->base +
-			ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 0));
-		break;
-	case RDI0:
-		val = readl_relaxed(ispif->base +
-			ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 0));
-		break;
-	case PIX1:
-		val = readl_relaxed(ispif->base +
-			ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 1));
-		break;
-	case RDI1:
-		val = readl_relaxed(ispif->base +
-			ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 1));
-		break;
-	case RDI2:
-		val = readl_relaxed(ispif->base +
-			ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 2));
-		break;
-	}
-
-	if ((val & 0xf) != 0xf) {
-		dev_err(to_device(ispif), "%s: ispif is busy: 0x%x\n",
-			__func__, val);
-		ret = -EBUSY;
-	}
-
-	return ret;
-}
-
-/*
- * ispif_wait_for_stop - Wait for PIX/RDI interface to stop
- * @ispif: ISPIF device
- * @intf: VFE interface
- * @vfe: VFE HW module id
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int ispif_wait_for_stop(struct ispif_device *ispif,
-			       enum ispif_intf intf, u8 vfe)
-{
-	u32 addr = 0;
-	u32 stop_flag = 0;
-	int ret;
-
-	switch (intf) {
-	case PIX0:
-		addr = ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 0);
-		break;
-	case RDI0:
-		addr = ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 0);
-		break;
-	case PIX1:
-		addr = ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 1);
-		break;
-	case RDI1:
-		addr = ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 1);
-		break;
-	case RDI2:
-		addr = ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 2);
-		break;
-	}
-
-	ret = readl_poll_timeout(ispif->base + addr,
-				 stop_flag,
-				 (stop_flag & 0xf) == 0xf,
-				 ISPIF_TIMEOUT_SLEEP_US,
-				 ISPIF_TIMEOUT_ALL_US);
-	if (ret < 0)
-		dev_err(to_device(ispif), "%s: ispif stop timeout\n",
-			__func__);
-
-	return ret;
-}
-
-/*
- * ispif_select_csid - Select CSID HW module for input from
- * @ispif: ISPIF device
- * @intf: VFE interface
- * @csid: CSID HW module id
- * @vfe: VFE HW module id
- * @enable: enable or disable the selected input
- */
-static void ispif_select_csid(struct ispif_device *ispif, enum ispif_intf intf,
-			      u8 csid, u8 vfe, u8 enable)
-{
-	u32 val;
-
-	val = readl_relaxed(ispif->base + ISPIF_VFE_m_INTF_INPUT_SEL(vfe));
-	switch (intf) {
-	case PIX0:
-		val &= ~(BIT(1) | BIT(0));
-		if (enable)
-			val |= csid;
-		break;
-	case RDI0:
-		val &= ~(BIT(5) | BIT(4));
-		if (enable)
-			val |= (csid << 4);
-		break;
-	case PIX1:
-		val &= ~(BIT(9) | BIT(8));
-		if (enable)
-			val |= (csid << 8);
-		break;
-	case RDI1:
-		val &= ~(BIT(13) | BIT(12));
-		if (enable)
-			val |= (csid << 12);
-		break;
-	case RDI2:
-		val &= ~(BIT(21) | BIT(20));
-		if (enable)
-			val |= (csid << 20);
-		break;
-	}
-
-	writel(val, ispif->base + ISPIF_VFE_m_INTF_INPUT_SEL(vfe));
-}
-
-/*
- * ispif_select_cid - Enable/disable desired CID
- * @ispif: ISPIF device
- * @intf: VFE interface
- * @cid: desired CID to enable/disable
- * @vfe: VFE HW module id
- * @enable: enable or disable the desired CID
- */
-static void ispif_select_cid(struct ispif_device *ispif, enum ispif_intf intf,
-			     u8 cid, u8 vfe, u8 enable)
-{
-	u32 cid_mask = 1 << cid;
-	u32 addr = 0;
-	u32 val;
-
-	switch (intf) {
-	case PIX0:
-		addr = ISPIF_VFE_m_PIX_INTF_n_CID_MASK(vfe, 0);
-		break;
-	case RDI0:
-		addr = ISPIF_VFE_m_RDI_INTF_n_CID_MASK(vfe, 0);
-		break;
-	case PIX1:
-		addr = ISPIF_VFE_m_PIX_INTF_n_CID_MASK(vfe, 1);
-		break;
-	case RDI1:
-		addr = ISPIF_VFE_m_RDI_INTF_n_CID_MASK(vfe, 1);
-		break;
-	case RDI2:
-		addr = ISPIF_VFE_m_RDI_INTF_n_CID_MASK(vfe, 2);
-		break;
-	}
-
-	val = readl_relaxed(ispif->base + addr);
-	if (enable)
-		val |= cid_mask;
-	else
-		val &= ~cid_mask;
-
-	writel(val, ispif->base + addr);
-}
-
-/*
- * ispif_config_irq - Enable/disable interrupts for PIX/RDI interface
- * @ispif: ISPIF device
- * @intf: VFE interface
- * @vfe: VFE HW module id
- * @enable: enable or disable
- */
-static void ispif_config_irq(struct ispif_device *ispif, enum ispif_intf intf,
-			     u8 vfe, u8 enable)
-{
-	u32 val;
-
-	switch (intf) {
-	case PIX0:
-		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
-		val &= ~ISPIF_VFE_m_IRQ_MASK_0_PIX0_MASK;
-		if (enable)
-			val |= ISPIF_VFE_m_IRQ_MASK_0_PIX0_ENABLE;
-		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
-		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_0_PIX0_ENABLE,
-			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(vfe));
-		break;
-	case RDI0:
-		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
-		val &= ~ISPIF_VFE_m_IRQ_MASK_0_RDI0_MASK;
-		if (enable)
-			val |= ISPIF_VFE_m_IRQ_MASK_0_RDI0_ENABLE;
-		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
-		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_0_RDI0_ENABLE,
-			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(vfe));
-		break;
-	case PIX1:
-		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
-		val &= ~ISPIF_VFE_m_IRQ_MASK_1_PIX1_MASK;
-		if (enable)
-			val |= ISPIF_VFE_m_IRQ_MASK_1_PIX1_ENABLE;
-		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
-		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_1_PIX1_ENABLE,
-			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(vfe));
-		break;
-	case RDI1:
-		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
-		val &= ~ISPIF_VFE_m_IRQ_MASK_1_RDI1_MASK;
-		if (enable)
-			val |= ISPIF_VFE_m_IRQ_MASK_1_RDI1_ENABLE;
-		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
-		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_1_RDI1_ENABLE,
-			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(vfe));
-		break;
-	case RDI2:
-		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_2(vfe));
-		val &= ~ISPIF_VFE_m_IRQ_MASK_2_RDI2_MASK;
-		if (enable)
-			val |= ISPIF_VFE_m_IRQ_MASK_2_RDI2_ENABLE;
-		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_2(vfe));
-		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_2_RDI2_ENABLE,
-			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_2(vfe));
-		break;
-	}
-
-	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
-}
-
-/*
- * ispif_set_intf_cmd - Set command to enable/disable interface
- * @ispif: ISPIF device
- * @cmd: interface command
- * @intf: VFE interface
- * @vfe: VFE HW module id
- * @vc: virtual channel
- */
-static void ispif_set_intf_cmd(struct ispif_device *ispif, u8 cmd,
-			       enum ispif_intf intf, u8 vfe, u8 vc)
-{
-	u32 *val;
-
-	if (intf == RDI2) {
-		val = &ispif->intf_cmd[vfe].cmd_1;
-		*val &= ~(0x3 << (vc * 2 + 8));
-		*val |= (cmd << (vc * 2 + 8));
-		wmb();
-		writel_relaxed(*val, ispif->base + ISPIF_VFE_m_INTF_CMD_1(vfe));
-		wmb();
-	} else {
-		val = &ispif->intf_cmd[vfe].cmd_0;
-		*val &= ~(0x3 << (vc * 2 + intf * 8));
-		*val |= (cmd << (vc * 2 + intf * 8));
-		wmb();
-		writel_relaxed(*val, ispif->base + ISPIF_VFE_m_INTF_CMD_0(vfe));
-		wmb();
-	}
-}
-
-/*
- * ispif_set_stream - Enable/disable streaming on ISPIF module
- * @sd: ISPIF V4L2 subdevice
- * @enable: Requested streaming state
- *
- * Main configuration of ISPIF module is also done here.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int ispif_set_stream(struct v4l2_subdev *sd, int enable)
-{
-	struct ispif_line *line = v4l2_get_subdevdata(sd);
-	struct ispif_device *ispif = to_ispif(line);
-	enum ispif_intf intf = line->interface;
-	u8 csid = line->csid_id;
-	u8 vfe = line->vfe_id;
-	u8 vc = 0; /* Virtual Channel 0 */
-	u8 cid = vc * 4; /* id of Virtual Channel and Data Type set */
-	int ret;
-
-	if (enable) {
-		if (!media_entity_remote_pad(&line->pads[MSM_ISPIF_PAD_SINK]))
-			return -ENOLINK;
-
-		/* Config */
-
-		mutex_lock(&ispif->config_lock);
-		ispif_select_clk_mux(ispif, intf, csid, vfe, 1);
-
-		ret = ispif_validate_intf_status(ispif, intf, vfe);
-		if (ret < 0) {
-			mutex_unlock(&ispif->config_lock);
-			return ret;
-		}
-
-		ispif_select_csid(ispif, intf, csid, vfe, 1);
-		ispif_select_cid(ispif, intf, cid, vfe, 1);
-		ispif_config_irq(ispif, intf, vfe, 1);
-		ispif_set_intf_cmd(ispif, CMD_ENABLE_FRAME_BOUNDARY,
-				   intf, vfe, vc);
-	} else {
-		mutex_lock(&ispif->config_lock);
-		ispif_set_intf_cmd(ispif, CMD_DISABLE_FRAME_BOUNDARY,
-				   intf, vfe, vc);
-		mutex_unlock(&ispif->config_lock);
-
-		ret = ispif_wait_for_stop(ispif, intf, vfe);
-		if (ret < 0)
-			return ret;
-
-		mutex_lock(&ispif->config_lock);
-		ispif_config_irq(ispif, intf, vfe, 0);
-		ispif_select_cid(ispif, intf, cid, vfe, 0);
-		ispif_select_csid(ispif, intf, csid, vfe, 0);
-		ispif_select_clk_mux(ispif, intf, csid, vfe, 0);
-	}
-
-	mutex_unlock(&ispif->config_lock);
-
-	return 0;
-}
-
-/*
- * __ispif_get_format - Get pointer to format structure
- * @ispif: ISPIF line
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad from which format is requested
- * @which: TRY or ACTIVE format
- *
- * Return pointer to TRY or ACTIVE format structure
- */
-static struct v4l2_mbus_framefmt *
-__ispif_get_format(struct ispif_line *line,
-		   struct v4l2_subdev_pad_config *cfg,
-		   unsigned int pad,
-		   enum v4l2_subdev_format_whence which)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_format(&line->subdev, cfg, pad);
-
-	return &line->fmt[pad];
-}
-
-/*
- * ispif_try_format - Handle try format by pad subdev method
- * @ispif: ISPIF line
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad on which format is requested
- * @fmt: pointer to v4l2 format structure
- * @which: wanted subdev format
- */
-static void ispif_try_format(struct ispif_line *line,
-			     struct v4l2_subdev_pad_config *cfg,
-			     unsigned int pad,
-			     struct v4l2_mbus_framefmt *fmt,
-			     enum v4l2_subdev_format_whence which)
-{
-	unsigned int i;
-
-	switch (pad) {
-	case MSM_ISPIF_PAD_SINK:
-		/* Set format on sink pad */
-
-		for (i = 0; i < ARRAY_SIZE(ispif_formats); i++)
-			if (fmt->code == ispif_formats[i])
-				break;
-
-		/* If not found, use UYVY as default */
-		if (i >= ARRAY_SIZE(ispif_formats))
-			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-
-		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
-		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
-
-		fmt->field = V4L2_FIELD_NONE;
-		fmt->colorspace = V4L2_COLORSPACE_SRGB;
-
-		break;
-
-	case MSM_ISPIF_PAD_SRC:
-		/* Set and return a format same as sink pad */
-
-		*fmt = *__ispif_get_format(line, cfg, MSM_ISPIF_PAD_SINK,
-					   which);
-
-		break;
-	}
-
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-}
-
-/*
- * ispif_enum_mbus_code - Handle pixel format enumeration
- * @sd: ISPIF V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @code: pointer to v4l2_subdev_mbus_code_enum structure
- * return -EINVAL or zero on success
- */
-static int ispif_enum_mbus_code(struct v4l2_subdev *sd,
-				struct v4l2_subdev_pad_config *cfg,
-				struct v4l2_subdev_mbus_code_enum *code)
-{
-	struct ispif_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	if (code->pad == MSM_ISPIF_PAD_SINK) {
-		if (code->index >= ARRAY_SIZE(ispif_formats))
-			return -EINVAL;
-
-		code->code = ispif_formats[code->index];
-	} else {
-		if (code->index > 0)
-			return -EINVAL;
-
-		format = __ispif_get_format(line, cfg, MSM_ISPIF_PAD_SINK,
-					    code->which);
-
-		code->code = format->code;
-	}
-
-	return 0;
-}
-
-/*
- * ispif_enum_frame_size - Handle frame size enumeration
- * @sd: ISPIF V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fse: pointer to v4l2_subdev_frame_size_enum structure
- * return -EINVAL or zero on success
- */
-static int ispif_enum_frame_size(struct v4l2_subdev *sd,
-				 struct v4l2_subdev_pad_config *cfg,
-				 struct v4l2_subdev_frame_size_enum *fse)
-{
-	struct ispif_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt format;
-
-	if (fse->index != 0)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = 1;
-	format.height = 1;
-	ispif_try_format(line, cfg, fse->pad, &format, fse->which);
-	fse->min_width = format.width;
-	fse->min_height = format.height;
-
-	if (format.code != fse->code)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = -1;
-	format.height = -1;
-	ispif_try_format(line, cfg, fse->pad, &format, fse->which);
-	fse->max_width = format.width;
-	fse->max_height = format.height;
-
-	return 0;
-}
-
-/*
- * ispif_get_format - Handle get format by pads subdev method
- * @sd: ISPIF V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int ispif_get_format(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_pad_config *cfg,
-			    struct v4l2_subdev_format *fmt)
-{
-	struct ispif_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __ispif_get_format(line, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	fmt->format = *format;
-
-	return 0;
-}
-
-/*
- * ispif_set_format - Handle set format by pads subdev method
- * @sd: ISPIF V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int ispif_set_format(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_pad_config *cfg,
-			    struct v4l2_subdev_format *fmt)
-{
-	struct ispif_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __ispif_get_format(line, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	ispif_try_format(line, cfg, fmt->pad, &fmt->format, fmt->which);
-	*format = fmt->format;
-
-	/* Propagate the format from sink to source */
-	if (fmt->pad == MSM_ISPIF_PAD_SINK) {
-		format = __ispif_get_format(line, cfg, MSM_ISPIF_PAD_SRC,
-					    fmt->which);
-
-		*format = fmt->format;
-		ispif_try_format(line, cfg, MSM_ISPIF_PAD_SRC, format,
-				 fmt->which);
-	}
-
-	return 0;
-}
-
-/*
- * ispif_init_formats - Initialize formats on all pads
- * @sd: ISPIF V4L2 subdevice
- * @fh: V4L2 subdev file handle
- *
- * Initialize all pad formats with default values.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int ispif_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
-{
-	struct v4l2_subdev_format format = {
-		.pad = MSM_ISPIF_PAD_SINK,
-		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
-			      V4L2_SUBDEV_FORMAT_ACTIVE,
-		.format = {
-			.code = MEDIA_BUS_FMT_UYVY8_2X8,
-			.width = 1920,
-			.height = 1080
-		}
-	};
-
-	return ispif_set_format(sd, fh ? fh->pad : NULL, &format);
-}
-
-/*
- * msm_ispif_subdev_init - Initialize ISPIF device structure and resources
- * @ispif: ISPIF device
- * @res: ISPIF module resources table
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_ispif_subdev_init(struct ispif_device *ispif,
-			  const struct resources_ispif *res)
-{
-	struct device *dev = to_device(ispif);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *r;
-	int i;
-	int ret;
-
-	/* Memory */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
-	ispif->base = devm_ioremap_resource(dev, r);
-	if (IS_ERR(ispif->base)) {
-		dev_err(dev, "could not map memory\n");
-		return PTR_ERR(ispif->base);
-	}
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[1]);
-	ispif->base_clk_mux = devm_ioremap_resource(dev, r);
-	if (IS_ERR(ispif->base_clk_mux)) {
-		dev_err(dev, "could not map memory\n");
-		return PTR_ERR(ispif->base_clk_mux);
-	}
-
-	/* Interrupt */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res->interrupt);
-
-	if (!r) {
-		dev_err(dev, "missing IRQ\n");
-		return -EINVAL;
-	}
-
-	ispif->irq = r->start;
-	snprintf(ispif->irq_name, sizeof(ispif->irq_name), "%s_%s",
-		 dev_name(dev), MSM_ISPIF_NAME);
-	ret = devm_request_irq(dev, ispif->irq, ispif_isr,
-			       IRQF_TRIGGER_RISING, ispif->irq_name, ispif);
-	if (ret < 0) {
-		dev_err(dev, "request_irq failed: %d\n", ret);
-		return ret;
-	}
-
-	/* Clocks */
-
-	ispif->nclocks = 0;
-	while (res->clock[ispif->nclocks])
-		ispif->nclocks++;
-
-	ispif->clock = devm_kcalloc(dev,
-				    ispif->nclocks, sizeof(*ispif->clock),
-				    GFP_KERNEL);
-	if (!ispif->clock)
-		return -ENOMEM;
-
-	for (i = 0; i < ispif->nclocks; i++) {
-		struct camss_clock *clock = &ispif->clock[i];
-
-		clock->clk = devm_clk_get(dev, res->clock[i]);
-		if (IS_ERR(clock->clk))
-			return PTR_ERR(clock->clk);
-
-		clock->freq = NULL;
-		clock->nfreqs = 0;
-	}
-
-	ispif->nclocks_for_reset = 0;
-	while (res->clock_for_reset[ispif->nclocks_for_reset])
-		ispif->nclocks_for_reset++;
-
-	ispif->clock_for_reset = devm_kcalloc(dev,
-					      ispif->nclocks_for_reset,
-					      sizeof(*ispif->clock_for_reset),
-					      GFP_KERNEL);
-	if (!ispif->clock_for_reset)
-		return -ENOMEM;
-
-	for (i = 0; i < ispif->nclocks_for_reset; i++) {
-		struct camss_clock *clock = &ispif->clock_for_reset[i];
-
-		clock->clk = devm_clk_get(dev, res->clock_for_reset[i]);
-		if (IS_ERR(clock->clk))
-			return PTR_ERR(clock->clk);
-
-		clock->freq = NULL;
-		clock->nfreqs = 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(ispif->line); i++)
-		ispif->line[i].id = i;
-
-	mutex_init(&ispif->power_lock);
-	ispif->power_count = 0;
-
-	mutex_init(&ispif->config_lock);
-
-	init_completion(&ispif->reset_complete);
-
-	return 0;
-}
-
-/*
- * ispif_get_intf - Get ISPIF interface to use by VFE line id
- * @line_id: VFE line id that the ISPIF line is connected to
- *
- * Return ISPIF interface to use
- */
-static enum ispif_intf ispif_get_intf(enum vfe_line_id line_id)
-{
-	switch (line_id) {
-	case (VFE_LINE_RDI0):
-		return RDI0;
-	case (VFE_LINE_RDI1):
-		return RDI1;
-	case (VFE_LINE_RDI2):
-		return RDI2;
-	case (VFE_LINE_PIX):
-		return PIX0;
-	default:
-		return RDI0;
-	}
-}
-
-/*
- * ispif_link_setup - Setup ISPIF connections
- * @entity: Pointer to media entity structure
- * @local: Pointer to local pad
- * @remote: Pointer to remote pad
- * @flags: Link flags
- *
- * Return 0 on success
- */
-static int ispif_link_setup(struct media_entity *entity,
-			    const struct media_pad *local,
-			    const struct media_pad *remote, u32 flags)
-{
-	if (flags & MEDIA_LNK_FL_ENABLED) {
-		if (media_entity_remote_pad(local))
-			return -EBUSY;
-
-		if (local->flags & MEDIA_PAD_FL_SINK) {
-			struct v4l2_subdev *sd;
-			struct ispif_line *line;
-
-			sd = media_entity_to_v4l2_subdev(entity);
-			line = v4l2_get_subdevdata(sd);
-
-			msm_csid_get_csid_id(remote->entity, &line->csid_id);
-		} else { /* MEDIA_PAD_FL_SOURCE */
-			struct v4l2_subdev *sd;
-			struct ispif_line *line;
-			enum vfe_line_id id;
-
-			sd = media_entity_to_v4l2_subdev(entity);
-			line = v4l2_get_subdevdata(sd);
-
-			msm_vfe_get_vfe_id(remote->entity, &line->vfe_id);
-			msm_vfe_get_vfe_line_id(remote->entity, &id);
-			line->interface = ispif_get_intf(id);
-		}
-	}
-
-	return 0;
-}
-
-static const struct v4l2_subdev_core_ops ispif_core_ops = {
-	.s_power = ispif_set_power,
-};
-
-static const struct v4l2_subdev_video_ops ispif_video_ops = {
-	.s_stream = ispif_set_stream,
-};
-
-static const struct v4l2_subdev_pad_ops ispif_pad_ops = {
-	.enum_mbus_code = ispif_enum_mbus_code,
-	.enum_frame_size = ispif_enum_frame_size,
-	.get_fmt = ispif_get_format,
-	.set_fmt = ispif_set_format,
-};
-
-static const struct v4l2_subdev_ops ispif_v4l2_ops = {
-	.core = &ispif_core_ops,
-	.video = &ispif_video_ops,
-	.pad = &ispif_pad_ops,
-};
-
-static const struct v4l2_subdev_internal_ops ispif_v4l2_internal_ops = {
-	.open = ispif_init_formats,
-};
-
-static const struct media_entity_operations ispif_media_ops = {
-	.link_setup = ispif_link_setup,
-	.link_validate = v4l2_subdev_link_validate,
-};
-
-/*
- * msm_ispif_register_entities - Register subdev node for ISPIF module
- * @ispif: ISPIF device
- * @v4l2_dev: V4L2 device
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_ispif_register_entities(struct ispif_device *ispif,
-				struct v4l2_device *v4l2_dev)
-{
-	struct device *dev = to_device(ispif);
-	int ret;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ispif->line); i++) {
-		struct v4l2_subdev *sd = &ispif->line[i].subdev;
-		struct media_pad *pads = ispif->line[i].pads;
-
-		v4l2_subdev_init(sd, &ispif_v4l2_ops);
-		sd->internal_ops = &ispif_v4l2_internal_ops;
-		sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-		snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
-			 MSM_ISPIF_NAME, i);
-		v4l2_set_subdevdata(sd, &ispif->line[i]);
-
-		ret = ispif_init_formats(sd, NULL);
-		if (ret < 0) {
-			dev_err(dev, "Failed to init format: %d\n", ret);
-			goto error;
-		}
-
-		pads[MSM_ISPIF_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-		pads[MSM_ISPIF_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
-
-		sd->entity.function = MEDIA_ENT_F_IO_V4L;
-		sd->entity.ops = &ispif_media_ops;
-		ret = media_entity_pads_init(&sd->entity, MSM_ISPIF_PADS_NUM,
-					     pads);
-		if (ret < 0) {
-			dev_err(dev, "Failed to init media entity: %d\n", ret);
-			goto error;
-		}
-
-		ret = v4l2_device_register_subdev(v4l2_dev, sd);
-		if (ret < 0) {
-			dev_err(dev, "Failed to register subdev: %d\n", ret);
-			media_entity_cleanup(&sd->entity);
-			goto error;
-		}
-	}
-
-	return 0;
-
-error:
-	for (i--; i >= 0; i--) {
-		struct v4l2_subdev *sd = &ispif->line[i].subdev;
-
-		v4l2_device_unregister_subdev(sd);
-		media_entity_cleanup(&sd->entity);
-	}
-
-	return ret;
-}
-
-/*
- * msm_ispif_unregister_entities - Unregister ISPIF module subdev node
- * @ispif: ISPIF device
- */
-void msm_ispif_unregister_entities(struct ispif_device *ispif)
-{
-	int i;
-
-	mutex_destroy(&ispif->power_lock);
-	mutex_destroy(&ispif->config_lock);
-
-	for (i = 0; i < ARRAY_SIZE(ispif->line); i++) {
-		struct v4l2_subdev *sd = &ispif->line[i].subdev;
-
-		v4l2_device_unregister_subdev(sd);
-		media_entity_cleanup(&sd->entity);
-	}
-}
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-ispif.h b/drivers/media/platform/qcom/camss-8x16/camss-ispif.h
deleted file mode 100644
index f668306..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-ispif.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/*
- * camss-ispif.h
- *
- * Qualcomm MSM Camera Subsystem - ISPIF (ISP Interface) Module
- *
- * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef QC_MSM_CAMSS_ISPIF_H
-#define QC_MSM_CAMSS_ISPIF_H
-
-#include <linux/clk.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-
-/* Number of ISPIF lines - same as number of CSID hardware modules */
-#define MSM_ISPIF_LINE_NUM 2
-
-#define MSM_ISPIF_PAD_SINK 0
-#define MSM_ISPIF_PAD_SRC 1
-#define MSM_ISPIF_PADS_NUM 2
-
-#define MSM_ISPIF_VFE_NUM 1
-
-enum ispif_intf {
-	PIX0,
-	RDI0,
-	PIX1,
-	RDI1,
-	RDI2
-};
-
-struct ispif_intf_cmd_reg {
-	u32 cmd_0;
-	u32 cmd_1;
-};
-
-struct ispif_line {
-	u8 id;
-	u8 csid_id;
-	u8 vfe_id;
-	enum ispif_intf interface;
-	struct v4l2_subdev subdev;
-	struct media_pad pads[MSM_ISPIF_PADS_NUM];
-	struct v4l2_mbus_framefmt fmt[MSM_ISPIF_PADS_NUM];
-};
-
-struct ispif_device {
-	void __iomem *base;
-	void __iomem *base_clk_mux;
-	u32 irq;
-	char irq_name[30];
-	struct camss_clock *clock;
-	int nclocks;
-	struct camss_clock  *clock_for_reset;
-	int nclocks_for_reset;
-	struct completion reset_complete;
-	int power_count;
-	struct mutex power_lock;
-	struct ispif_intf_cmd_reg intf_cmd[MSM_ISPIF_VFE_NUM];
-	struct mutex config_lock;
-	struct ispif_line line[MSM_ISPIF_LINE_NUM];
-};
-
-struct resources_ispif;
-
-int msm_ispif_subdev_init(struct ispif_device *ispif,
-			  const struct resources_ispif *res);
-
-int msm_ispif_register_entities(struct ispif_device *ispif,
-				struct v4l2_device *v4l2_dev);
-
-void msm_ispif_unregister_entities(struct ispif_device *ispif);
-
-#endif /* QC_MSM_CAMSS_ISPIF_H */
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-vfe.c b/drivers/media/platform/qcom/camss-8x16/camss-vfe.c
deleted file mode 100644
index a6329a8..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-vfe.c
+++ /dev/null
@@ -1,3093 +0,0 @@
-/*
- * camss-vfe.c
- *
- * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module
- *
- * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/clk.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-#include <linux/iommu.h>
-#include <linux/iopoll.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock_types.h>
-#include <linux/spinlock.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-
-#include "camss-vfe.h"
-#include "camss.h"
-
-#define MSM_VFE_NAME "msm_vfe"
-
-#define vfe_line_array(ptr_line)	\
-	((const struct vfe_line (*)[]) &(ptr_line[-(ptr_line->id)]))
-
-#define to_vfe(ptr_line)	\
-	container_of(vfe_line_array(ptr_line), struct vfe_device, ptr_line)
-
-#define VFE_0_HW_VERSION		0x000
-
-#define VFE_0_GLOBAL_RESET_CMD		0x00c
-#define VFE_0_GLOBAL_RESET_CMD_CORE	(1 << 0)
-#define VFE_0_GLOBAL_RESET_CMD_CAMIF	(1 << 1)
-#define VFE_0_GLOBAL_RESET_CMD_BUS	(1 << 2)
-#define VFE_0_GLOBAL_RESET_CMD_BUS_BDG	(1 << 3)
-#define VFE_0_GLOBAL_RESET_CMD_REGISTER	(1 << 4)
-#define VFE_0_GLOBAL_RESET_CMD_TIMER	(1 << 5)
-#define VFE_0_GLOBAL_RESET_CMD_PM	(1 << 6)
-#define VFE_0_GLOBAL_RESET_CMD_BUS_MISR	(1 << 7)
-#define VFE_0_GLOBAL_RESET_CMD_TESTGEN	(1 << 8)
-
-#define VFE_0_MODULE_CFG		0x018
-#define VFE_0_MODULE_CFG_DEMUX			(1 << 2)
-#define VFE_0_MODULE_CFG_CHROMA_UPSAMPLE	(1 << 3)
-#define VFE_0_MODULE_CFG_SCALE_ENC		(1 << 23)
-#define VFE_0_MODULE_CFG_CROP_ENC		(1 << 27)
-
-#define VFE_0_CORE_CFG			0x01c
-#define VFE_0_CORE_CFG_PIXEL_PATTERN_YCBYCR	0x4
-#define VFE_0_CORE_CFG_PIXEL_PATTERN_YCRYCB	0x5
-#define VFE_0_CORE_CFG_PIXEL_PATTERN_CBYCRY	0x6
-#define VFE_0_CORE_CFG_PIXEL_PATTERN_CRYCBY	0x7
-
-#define VFE_0_IRQ_CMD			0x024
-#define VFE_0_IRQ_CMD_GLOBAL_CLEAR	(1 << 0)
-
-#define VFE_0_IRQ_MASK_0		0x028
-#define VFE_0_IRQ_MASK_0_CAMIF_SOF			(1 << 0)
-#define VFE_0_IRQ_MASK_0_CAMIF_EOF			(1 << 1)
-#define VFE_0_IRQ_MASK_0_RDIn_REG_UPDATE(n)		(1 << ((n) + 5))
-#define VFE_0_IRQ_MASK_0_line_n_REG_UPDATE(n)		\
-	((n) == VFE_LINE_PIX ? (1 << 4) : VFE_0_IRQ_MASK_0_RDIn_REG_UPDATE(n))
-#define VFE_0_IRQ_MASK_0_IMAGE_MASTER_n_PING_PONG(n)	(1 << ((n) + 8))
-#define VFE_0_IRQ_MASK_0_IMAGE_COMPOSITE_DONE_n(n)	(1 << ((n) + 25))
-#define VFE_0_IRQ_MASK_0_RESET_ACK			(1 << 31)
-#define VFE_0_IRQ_MASK_1		0x02c
-#define VFE_0_IRQ_MASK_1_CAMIF_ERROR			(1 << 0)
-#define VFE_0_IRQ_MASK_1_VIOLATION			(1 << 7)
-#define VFE_0_IRQ_MASK_1_BUS_BDG_HALT_ACK		(1 << 8)
-#define VFE_0_IRQ_MASK_1_IMAGE_MASTER_n_BUS_OVERFLOW(n)	(1 << ((n) + 9))
-#define VFE_0_IRQ_MASK_1_RDIn_SOF(n)			(1 << ((n) + 29))
-
-#define VFE_0_IRQ_CLEAR_0		0x030
-#define VFE_0_IRQ_CLEAR_1		0x034
-
-#define VFE_0_IRQ_STATUS_0		0x038
-#define VFE_0_IRQ_STATUS_0_CAMIF_SOF			(1 << 0)
-#define VFE_0_IRQ_STATUS_0_RDIn_REG_UPDATE(n)		(1 << ((n) + 5))
-#define VFE_0_IRQ_STATUS_0_line_n_REG_UPDATE(n)		\
-	((n) == VFE_LINE_PIX ? (1 << 4) : VFE_0_IRQ_STATUS_0_RDIn_REG_UPDATE(n))
-#define VFE_0_IRQ_STATUS_0_IMAGE_MASTER_n_PING_PONG(n)	(1 << ((n) + 8))
-#define VFE_0_IRQ_STATUS_0_IMAGE_COMPOSITE_DONE_n(n)	(1 << ((n) + 25))
-#define VFE_0_IRQ_STATUS_0_RESET_ACK			(1 << 31)
-#define VFE_0_IRQ_STATUS_1		0x03c
-#define VFE_0_IRQ_STATUS_1_VIOLATION			(1 << 7)
-#define VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK		(1 << 8)
-#define VFE_0_IRQ_STATUS_1_RDIn_SOF(n)			(1 << ((n) + 29))
-
-#define VFE_0_IRQ_COMPOSITE_MASK_0	0x40
-#define VFE_0_VIOLATION_STATUS		0x48
-
-#define VFE_0_BUS_CMD			0x4c
-#define VFE_0_BUS_CMD_Mx_RLD_CMD(x)	(1 << (x))
-
-#define VFE_0_BUS_CFG			0x050
-
-#define VFE_0_BUS_XBAR_CFG_x(x)		(0x58 + 0x4 * ((x) / 2))
-#define VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_EN			(1 << 1)
-#define VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_SWAP_INTER_INTRA	(0x3 << 4)
-#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT		8
-#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_LUMA		0
-#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI0	5
-#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI1	6
-#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI2	7
-
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(n)		(0x06c + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_WR_PATH_SHIFT	0
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_FRM_BASED_SHIFT	1
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_PING_ADDR(n)	(0x070 + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_PONG_ADDR(n)	(0x074 + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG(n)		(0x078 + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_SHIFT	2
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_MASK	(0x1F << 2)
-
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG(n)		(0x07c + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG_OFFSET_SHIFT	16
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_IMAGE_SIZE(n)	(0x080 + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_BUFFER_CFG(n)	(0x084 + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_FRAMEDROP_PATTERN(n)	\
-							(0x088 + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN(n)	\
-							(0x08c + 0x24 * (n))
-#define VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN_DEF	0xffffffff
-
-#define VFE_0_BUS_PING_PONG_STATUS	0x268
-
-#define VFE_0_BUS_BDG_CMD		0x2c0
-#define VFE_0_BUS_BDG_CMD_HALT_REQ	1
-
-#define VFE_0_BUS_BDG_QOS_CFG_0		0x2c4
-#define VFE_0_BUS_BDG_QOS_CFG_0_CFG	0xaaa5aaa5
-#define VFE_0_BUS_BDG_QOS_CFG_1		0x2c8
-#define VFE_0_BUS_BDG_QOS_CFG_2		0x2cc
-#define VFE_0_BUS_BDG_QOS_CFG_3		0x2d0
-#define VFE_0_BUS_BDG_QOS_CFG_4		0x2d4
-#define VFE_0_BUS_BDG_QOS_CFG_5		0x2d8
-#define VFE_0_BUS_BDG_QOS_CFG_6		0x2dc
-#define VFE_0_BUS_BDG_QOS_CFG_7		0x2e0
-#define VFE_0_BUS_BDG_QOS_CFG_7_CFG	0x0001aaa5
-
-#define VFE_0_RDI_CFG_x(x)		(0x2e8 + (0x4 * (x)))
-#define VFE_0_RDI_CFG_x_RDI_STREAM_SEL_SHIFT	28
-#define VFE_0_RDI_CFG_x_RDI_STREAM_SEL_MASK	(0xf << 28)
-#define VFE_0_RDI_CFG_x_RDI_M0_SEL_SHIFT	4
-#define VFE_0_RDI_CFG_x_RDI_M0_SEL_MASK		(0xf << 4)
-#define VFE_0_RDI_CFG_x_RDI_EN_BIT		(1 << 2)
-#define VFE_0_RDI_CFG_x_MIPI_EN_BITS		0x3
-#define VFE_0_RDI_CFG_x_RDI_Mr_FRAME_BASED_EN(r)	(1 << (16 + (r)))
-
-#define VFE_0_CAMIF_CMD				0x2f4
-#define VFE_0_CAMIF_CMD_DISABLE_FRAME_BOUNDARY	0
-#define VFE_0_CAMIF_CMD_ENABLE_FRAME_BOUNDARY	1
-#define VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS	(1 << 2)
-#define VFE_0_CAMIF_CFG				0x2f8
-#define VFE_0_CAMIF_CFG_VFE_OUTPUT_EN		(1 << 6)
-#define VFE_0_CAMIF_FRAME_CFG			0x300
-#define VFE_0_CAMIF_WINDOW_WIDTH_CFG		0x304
-#define VFE_0_CAMIF_WINDOW_HEIGHT_CFG		0x308
-#define VFE_0_CAMIF_SUBSAMPLE_CFG_0		0x30c
-#define VFE_0_CAMIF_IRQ_SUBSAMPLE_PATTERN	0x314
-#define VFE_0_CAMIF_STATUS			0x31c
-#define VFE_0_CAMIF_STATUS_HALT			(1 << 31)
-
-#define VFE_0_REG_UPDATE			0x378
-#define VFE_0_REG_UPDATE_RDIn(n)		(1 << (1 + (n)))
-#define VFE_0_REG_UPDATE_line_n(n)		\
-			((n) == VFE_LINE_PIX ? 1 : VFE_0_REG_UPDATE_RDIn(n))
-
-#define VFE_0_DEMUX_CFG				0x424
-#define VFE_0_DEMUX_CFG_PERIOD			0x3
-#define VFE_0_DEMUX_GAIN_0			0x428
-#define VFE_0_DEMUX_GAIN_0_CH0_EVEN		(0x80 << 0)
-#define VFE_0_DEMUX_GAIN_0_CH0_ODD		(0x80 << 16)
-#define VFE_0_DEMUX_GAIN_1			0x42c
-#define VFE_0_DEMUX_GAIN_1_CH1			(0x80 << 0)
-#define VFE_0_DEMUX_GAIN_1_CH2			(0x80 << 16)
-#define VFE_0_DEMUX_EVEN_CFG			0x438
-#define VFE_0_DEMUX_EVEN_CFG_PATTERN_YUYV	0x9cac
-#define VFE_0_DEMUX_EVEN_CFG_PATTERN_YVYU	0xac9c
-#define VFE_0_DEMUX_EVEN_CFG_PATTERN_UYVY	0xc9ca
-#define VFE_0_DEMUX_EVEN_CFG_PATTERN_VYUY	0xcac9
-#define VFE_0_DEMUX_ODD_CFG			0x43c
-#define VFE_0_DEMUX_ODD_CFG_PATTERN_YUYV	0x9cac
-#define VFE_0_DEMUX_ODD_CFG_PATTERN_YVYU	0xac9c
-#define VFE_0_DEMUX_ODD_CFG_PATTERN_UYVY	0xc9ca
-#define VFE_0_DEMUX_ODD_CFG_PATTERN_VYUY	0xcac9
-
-#define VFE_0_SCALE_ENC_Y_CFG			0x75c
-#define VFE_0_SCALE_ENC_Y_H_IMAGE_SIZE		0x760
-#define VFE_0_SCALE_ENC_Y_H_PHASE		0x764
-#define VFE_0_SCALE_ENC_Y_V_IMAGE_SIZE		0x76c
-#define VFE_0_SCALE_ENC_Y_V_PHASE		0x770
-#define VFE_0_SCALE_ENC_CBCR_CFG		0x778
-#define VFE_0_SCALE_ENC_CBCR_H_IMAGE_SIZE	0x77c
-#define VFE_0_SCALE_ENC_CBCR_H_PHASE		0x780
-#define VFE_0_SCALE_ENC_CBCR_V_IMAGE_SIZE	0x790
-#define VFE_0_SCALE_ENC_CBCR_V_PHASE		0x794
-
-#define VFE_0_CROP_ENC_Y_WIDTH			0x854
-#define VFE_0_CROP_ENC_Y_HEIGHT			0x858
-#define VFE_0_CROP_ENC_CBCR_WIDTH		0x85c
-#define VFE_0_CROP_ENC_CBCR_HEIGHT		0x860
-
-#define VFE_0_CLAMP_ENC_MAX_CFG			0x874
-#define VFE_0_CLAMP_ENC_MAX_CFG_CH0		(0xff << 0)
-#define VFE_0_CLAMP_ENC_MAX_CFG_CH1		(0xff << 8)
-#define VFE_0_CLAMP_ENC_MAX_CFG_CH2		(0xff << 16)
-#define VFE_0_CLAMP_ENC_MIN_CFG			0x878
-#define VFE_0_CLAMP_ENC_MIN_CFG_CH0		(0x0 << 0)
-#define VFE_0_CLAMP_ENC_MIN_CFG_CH1		(0x0 << 8)
-#define VFE_0_CLAMP_ENC_MIN_CFG_CH2		(0x0 << 16)
-
-#define VFE_0_CGC_OVERRIDE_1			0x974
-#define VFE_0_CGC_OVERRIDE_1_IMAGE_Mx_CGC_OVERRIDE(x)	(1 << (x))
-
-/* VFE reset timeout */
-#define VFE_RESET_TIMEOUT_MS 50
-/* VFE halt timeout */
-#define VFE_HALT_TIMEOUT_MS 100
-/* Max number of frame drop updates per frame */
-#define VFE_FRAME_DROP_UPDATES 5
-/* Frame drop value. NOTE: VAL + UPDATES should not exceed 31 */
-#define VFE_FRAME_DROP_VAL 20
-
-#define VFE_NEXT_SOF_MS 500
-
-#define CAMIF_TIMEOUT_SLEEP_US 1000
-#define CAMIF_TIMEOUT_ALL_US 1000000
-
-#define SCALER_RATIO_MAX 16
-
-static const struct {
-	u32 code;
-	u8 bpp;
-} vfe_formats[] = {
-	{
-		MEDIA_BUS_FMT_UYVY8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_VYUY8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_YUYV8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_YVYU8_2X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB8_1X8,
-		8,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB10_1X10,
-		10,
-	},
-	{
-		MEDIA_BUS_FMT_SBGGR12_1X12,
-		12,
-	},
-	{
-		MEDIA_BUS_FMT_SGBRG12_1X12,
-		12,
-	},
-	{
-		MEDIA_BUS_FMT_SGRBG12_1X12,
-		12,
-	},
-	{
-		MEDIA_BUS_FMT_SRGGB12_1X12,
-		12,
-	}
-};
-
-/*
- * vfe_get_bpp - map media bus format to bits per pixel
- * @code: media bus format code
- *
- * Return number of bits per pixel
- */
-static u8 vfe_get_bpp(u32 code)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe_formats); i++)
-		if (code == vfe_formats[i].code)
-			return vfe_formats[i].bpp;
-
-	WARN(1, "Unknown format\n");
-
-	return vfe_formats[0].bpp;
-}
-
-static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
-{
-	u32 bits = readl_relaxed(vfe->base + reg);
-
-	writel_relaxed(bits & ~clr_bits, vfe->base + reg);
-}
-
-static inline void vfe_reg_set(struct vfe_device *vfe, u32 reg, u32 set_bits)
-{
-	u32 bits = readl_relaxed(vfe->base + reg);
-
-	writel_relaxed(bits | set_bits, vfe->base + reg);
-}
-
-static void vfe_global_reset(struct vfe_device *vfe)
-{
-	u32 reset_bits = VFE_0_GLOBAL_RESET_CMD_TESTGEN		|
-			 VFE_0_GLOBAL_RESET_CMD_BUS_MISR	|
-			 VFE_0_GLOBAL_RESET_CMD_PM		|
-			 VFE_0_GLOBAL_RESET_CMD_TIMER		|
-			 VFE_0_GLOBAL_RESET_CMD_REGISTER	|
-			 VFE_0_GLOBAL_RESET_CMD_BUS_BDG		|
-			 VFE_0_GLOBAL_RESET_CMD_BUS		|
-			 VFE_0_GLOBAL_RESET_CMD_CAMIF		|
-			 VFE_0_GLOBAL_RESET_CMD_CORE;
-
-	writel_relaxed(reset_bits, vfe->base + VFE_0_GLOBAL_RESET_CMD);
-}
-
-static void vfe_wm_enable(struct vfe_device *vfe, u8 wm, u8 enable)
-{
-	if (enable)
-		vfe_reg_set(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
-			    1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_WR_PATH_SHIFT);
-	else
-		vfe_reg_clr(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
-			    1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_WR_PATH_SHIFT);
-}
-
-static void vfe_wm_frame_based(struct vfe_device *vfe, u8 wm, u8 enable)
-{
-	if (enable)
-		vfe_reg_set(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
-			1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_FRM_BASED_SHIFT);
-	else
-		vfe_reg_clr(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
-			1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_FRM_BASED_SHIFT);
-}
-
-#define CALC_WORD(width, M, N) (((width) * (M) + (N) - 1) / (N))
-
-static int vfe_word_per_line(uint32_t format, uint32_t pixel_per_line)
-{
-	int val = 0;
-
-	switch (format) {
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		val = CALC_WORD(pixel_per_line, 1, 8);
-		break;
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-		val = CALC_WORD(pixel_per_line, 2, 8);
-		break;
-	}
-
-	return val;
-}
-
-static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
-			     u16 *width, u16 *height, u16 *bytesperline)
-{
-	switch (pix->pixelformat) {
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-		*width = pix->width;
-		*height = pix->height;
-		*bytesperline = pix->plane_fmt[0].bytesperline;
-		if (plane == 1)
-			*height /= 2;
-		break;
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		*width = pix->width;
-		*height = pix->height;
-		*bytesperline = pix->plane_fmt[0].bytesperline;
-		break;
-	}
-}
-
-static void vfe_wm_line_based(struct vfe_device *vfe, u32 wm,
-			      struct v4l2_pix_format_mplane *pix,
-			      u8 plane, u32 enable)
-{
-	u32 reg;
-
-	if (enable) {
-		u16 width = 0, height = 0, bytesperline = 0, wpl;
-
-		vfe_get_wm_sizes(pix, plane, &width, &height, &bytesperline);
-
-		wpl = vfe_word_per_line(pix->pixelformat, width);
-
-		reg = height - 1;
-		reg |= ((wpl + 1) / 2 - 1) << 16;
-
-		writel_relaxed(reg, vfe->base +
-			       VFE_0_BUS_IMAGE_MASTER_n_WR_IMAGE_SIZE(wm));
-
-		wpl = vfe_word_per_line(pix->pixelformat, bytesperline);
-
-		reg = 0x3;
-		reg |= (height - 1) << 4;
-		reg |= wpl << 16;
-
-		writel_relaxed(reg, vfe->base +
-			       VFE_0_BUS_IMAGE_MASTER_n_WR_BUFFER_CFG(wm));
-	} else {
-		writel_relaxed(0, vfe->base +
-			       VFE_0_BUS_IMAGE_MASTER_n_WR_IMAGE_SIZE(wm));
-		writel_relaxed(0, vfe->base +
-			       VFE_0_BUS_IMAGE_MASTER_n_WR_BUFFER_CFG(wm));
-	}
-}
-
-static void vfe_wm_set_framedrop_period(struct vfe_device *vfe, u8 wm, u8 per)
-{
-	u32 reg;
-
-	reg = readl_relaxed(vfe->base +
-			    VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG(wm));
-
-	reg &= ~(VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_MASK);
-
-	reg |= (per << VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_SHIFT)
-		& VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_MASK;
-
-	writel_relaxed(reg,
-		       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG(wm));
-}
-
-static void vfe_wm_set_framedrop_pattern(struct vfe_device *vfe, u8 wm,
-					 u32 pattern)
-{
-	writel_relaxed(pattern,
-	       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_FRAMEDROP_PATTERN(wm));
-}
-
-static void vfe_wm_set_ub_cfg(struct vfe_device *vfe, u8 wm, u16 offset,
-			      u16 depth)
-{
-	u32 reg;
-
-	reg = (offset << VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG_OFFSET_SHIFT) |
-		depth;
-	writel_relaxed(reg, vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG(wm));
-}
-
-static void vfe_bus_reload_wm(struct vfe_device *vfe, u8 wm)
-{
-	wmb();
-	writel_relaxed(VFE_0_BUS_CMD_Mx_RLD_CMD(wm), vfe->base + VFE_0_BUS_CMD);
-	wmb();
-}
-
-static void vfe_wm_set_ping_addr(struct vfe_device *vfe, u8 wm, u32 addr)
-{
-	writel_relaxed(addr,
-		       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_PING_ADDR(wm));
-}
-
-static void vfe_wm_set_pong_addr(struct vfe_device *vfe, u8 wm, u32 addr)
-{
-	writel_relaxed(addr,
-		       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_PONG_ADDR(wm));
-}
-
-static int vfe_wm_get_ping_pong_status(struct vfe_device *vfe, u8 wm)
-{
-	u32 reg;
-
-	reg = readl_relaxed(vfe->base + VFE_0_BUS_PING_PONG_STATUS);
-
-	return (reg >> wm) & 0x1;
-}
-
-static void vfe_bus_enable_wr_if(struct vfe_device *vfe, u8 enable)
-{
-	if (enable)
-		writel_relaxed(0x10000009, vfe->base + VFE_0_BUS_CFG);
-	else
-		writel_relaxed(0, vfe->base + VFE_0_BUS_CFG);
-}
-
-static void vfe_bus_connect_wm_to_rdi(struct vfe_device *vfe, u8 wm,
-				      enum vfe_line_id id)
-{
-	u32 reg;
-
-	reg = VFE_0_RDI_CFG_x_MIPI_EN_BITS;
-	reg |= VFE_0_RDI_CFG_x_RDI_Mr_FRAME_BASED_EN(id);
-	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(0), reg);
-
-	reg = VFE_0_RDI_CFG_x_RDI_EN_BIT;
-	reg |= ((3 * id) << VFE_0_RDI_CFG_x_RDI_STREAM_SEL_SHIFT) &
-		VFE_0_RDI_CFG_x_RDI_STREAM_SEL_MASK;
-	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(id), reg);
-
-	switch (id) {
-	case VFE_LINE_RDI0:
-	default:
-		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI0 <<
-		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		break;
-	case VFE_LINE_RDI1:
-		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI1 <<
-		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		break;
-	case VFE_LINE_RDI2:
-		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI2 <<
-		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		break;
-	}
-
-	if (wm % 2 == 1)
-		reg <<= 16;
-
-	vfe_reg_set(vfe, VFE_0_BUS_XBAR_CFG_x(wm), reg);
-}
-
-static void vfe_wm_set_subsample(struct vfe_device *vfe, u8 wm)
-{
-	writel_relaxed(VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN_DEF,
-	       vfe->base +
-	       VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN(wm));
-}
-
-static void vfe_bus_disconnect_wm_from_rdi(struct vfe_device *vfe, u8 wm,
-					   enum vfe_line_id id)
-{
-	u32 reg;
-
-	reg = VFE_0_RDI_CFG_x_RDI_Mr_FRAME_BASED_EN(id);
-	vfe_reg_clr(vfe, VFE_0_RDI_CFG_x(0), reg);
-
-	reg = VFE_0_RDI_CFG_x_RDI_EN_BIT;
-	vfe_reg_clr(vfe, VFE_0_RDI_CFG_x(id), reg);
-
-	switch (id) {
-	case VFE_LINE_RDI0:
-	default:
-		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI0 <<
-		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		break;
-	case VFE_LINE_RDI1:
-		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI1 <<
-		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		break;
-	case VFE_LINE_RDI2:
-		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI2 <<
-		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		break;
-	}
-
-	if (wm % 2 == 1)
-		reg <<= 16;
-
-	vfe_reg_clr(vfe, VFE_0_BUS_XBAR_CFG_x(wm), reg);
-}
-
-static void vfe_set_xbar_cfg(struct vfe_device *vfe, struct vfe_output *output,
-			     u8 enable)
-{
-	struct vfe_line *line = container_of(output, struct vfe_line, output);
-	u32 p = line->video_out.active_fmt.fmt.pix_mp.pixelformat;
-	u32 reg;
-	unsigned int i;
-
-	for (i = 0; i < output->wm_num; i++) {
-		if (i == 0) {
-			reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_LUMA <<
-				VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
-		} else if (i == 1) {
-			reg = VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_EN;
-			if (p == V4L2_PIX_FMT_NV12 || p == V4L2_PIX_FMT_NV16)
-				reg |= VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_SWAP_INTER_INTRA;
-		} else {
-			/* On current devices output->wm_num is always <= 2 */
-			break;
-		}
-
-		if (output->wm_idx[i] % 2 == 1)
-			reg <<= 16;
-
-		if (enable)
-			vfe_reg_set(vfe,
-				    VFE_0_BUS_XBAR_CFG_x(output->wm_idx[i]),
-				    reg);
-		else
-			vfe_reg_clr(vfe,
-				    VFE_0_BUS_XBAR_CFG_x(output->wm_idx[i]),
-				    reg);
-	}
-}
-
-static void vfe_set_rdi_cid(struct vfe_device *vfe, enum vfe_line_id id, u8 cid)
-{
-	vfe_reg_clr(vfe, VFE_0_RDI_CFG_x(id),
-		    VFE_0_RDI_CFG_x_RDI_M0_SEL_MASK);
-
-	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(id),
-		    cid << VFE_0_RDI_CFG_x_RDI_M0_SEL_SHIFT);
-}
-
-static void vfe_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
-{
-	vfe->reg_update |= VFE_0_REG_UPDATE_line_n(line_id);
-	wmb();
-	writel_relaxed(vfe->reg_update, vfe->base + VFE_0_REG_UPDATE);
-	wmb();
-}
-
-static void vfe_enable_irq_wm_line(struct vfe_device *vfe, u8 wm,
-				   enum vfe_line_id line_id, u8 enable)
-{
-	u32 irq_en0 = VFE_0_IRQ_MASK_0_IMAGE_MASTER_n_PING_PONG(wm) |
-		      VFE_0_IRQ_MASK_0_line_n_REG_UPDATE(line_id);
-	u32 irq_en1 = VFE_0_IRQ_MASK_1_IMAGE_MASTER_n_BUS_OVERFLOW(wm) |
-		      VFE_0_IRQ_MASK_1_RDIn_SOF(line_id);
-
-	if (enable) {
-		vfe_reg_set(vfe, VFE_0_IRQ_MASK_0, irq_en0);
-		vfe_reg_set(vfe, VFE_0_IRQ_MASK_1, irq_en1);
-	} else {
-		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_0, irq_en0);
-		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_1, irq_en1);
-	}
-}
-
-static void vfe_enable_irq_pix_line(struct vfe_device *vfe, u8 comp,
-				    enum vfe_line_id line_id, u8 enable)
-{
-	struct vfe_output *output = &vfe->line[line_id].output;
-	unsigned int i;
-	u32 irq_en0;
-	u32 irq_en1;
-	u32 comp_mask = 0;
-
-	irq_en0 = VFE_0_IRQ_MASK_0_CAMIF_SOF;
-	irq_en0 |= VFE_0_IRQ_MASK_0_CAMIF_EOF;
-	irq_en0 |= VFE_0_IRQ_MASK_0_IMAGE_COMPOSITE_DONE_n(comp);
-	irq_en0 |= VFE_0_IRQ_MASK_0_line_n_REG_UPDATE(line_id);
-	irq_en1 = VFE_0_IRQ_MASK_1_CAMIF_ERROR;
-	for (i = 0; i < output->wm_num; i++) {
-		irq_en1 |= VFE_0_IRQ_MASK_1_IMAGE_MASTER_n_BUS_OVERFLOW(
-							output->wm_idx[i]);
-		comp_mask |= (1 << output->wm_idx[i]) << comp * 8;
-	}
-
-	if (enable) {
-		vfe_reg_set(vfe, VFE_0_IRQ_MASK_0, irq_en0);
-		vfe_reg_set(vfe, VFE_0_IRQ_MASK_1, irq_en1);
-		vfe_reg_set(vfe, VFE_0_IRQ_COMPOSITE_MASK_0, comp_mask);
-	} else {
-		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_0, irq_en0);
-		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_1, irq_en1);
-		vfe_reg_clr(vfe, VFE_0_IRQ_COMPOSITE_MASK_0, comp_mask);
-	}
-}
-
-static void vfe_enable_irq_common(struct vfe_device *vfe)
-{
-	u32 irq_en0 = VFE_0_IRQ_MASK_0_RESET_ACK;
-	u32 irq_en1 = VFE_0_IRQ_MASK_1_VIOLATION |
-		      VFE_0_IRQ_MASK_1_BUS_BDG_HALT_ACK;
-
-	vfe_reg_set(vfe, VFE_0_IRQ_MASK_0, irq_en0);
-	vfe_reg_set(vfe, VFE_0_IRQ_MASK_1, irq_en1);
-}
-
-static void vfe_set_demux_cfg(struct vfe_device *vfe, struct vfe_line *line)
-{
-	u32 val, even_cfg, odd_cfg;
-
-	writel_relaxed(VFE_0_DEMUX_CFG_PERIOD, vfe->base + VFE_0_DEMUX_CFG);
-
-	val = VFE_0_DEMUX_GAIN_0_CH0_EVEN | VFE_0_DEMUX_GAIN_0_CH0_ODD;
-	writel_relaxed(val, vfe->base + VFE_0_DEMUX_GAIN_0);
-
-	val = VFE_0_DEMUX_GAIN_1_CH1 | VFE_0_DEMUX_GAIN_1_CH2;
-	writel_relaxed(val, vfe->base + VFE_0_DEMUX_GAIN_1);
-
-	switch (line->fmt[MSM_VFE_PAD_SINK].code) {
-	case MEDIA_BUS_FMT_YUYV8_2X8:
-		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_YUYV;
-		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_YUYV;
-		break;
-	case MEDIA_BUS_FMT_YVYU8_2X8:
-		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_YVYU;
-		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_YVYU;
-		break;
-	case MEDIA_BUS_FMT_UYVY8_2X8:
-	default:
-		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_UYVY;
-		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_UYVY;
-		break;
-	case MEDIA_BUS_FMT_VYUY8_2X8:
-		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_VYUY;
-		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_VYUY;
-		break;
-	}
-
-	writel_relaxed(even_cfg, vfe->base + VFE_0_DEMUX_EVEN_CFG);
-	writel_relaxed(odd_cfg, vfe->base + VFE_0_DEMUX_ODD_CFG);
-}
-
-static inline u8 vfe_calc_interp_reso(u16 input, u16 output)
-{
-	if (input / output >= 16)
-		return 0;
-
-	if (input / output >= 8)
-		return 1;
-
-	if (input / output >= 4)
-		return 2;
-
-	return 3;
-}
-
-static void vfe_set_scale_cfg(struct vfe_device *vfe, struct vfe_line *line)
-{
-	u32 p = line->video_out.active_fmt.fmt.pix_mp.pixelformat;
-	u32 reg;
-	u16 input, output;
-	u8 interp_reso;
-	u32 phase_mult;
-
-	writel_relaxed(0x3, vfe->base + VFE_0_SCALE_ENC_Y_CFG);
-
-	input = line->fmt[MSM_VFE_PAD_SINK].width;
-	output = line->compose.width;
-	reg = (output << 16) | input;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_H_IMAGE_SIZE);
-
-	interp_reso = vfe_calc_interp_reso(input, output);
-	phase_mult = input * (1 << (13 + interp_reso)) / output;
-	reg = (interp_reso << 20) | phase_mult;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_H_PHASE);
-
-	input = line->fmt[MSM_VFE_PAD_SINK].height;
-	output = line->compose.height;
-	reg = (output << 16) | input;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_V_IMAGE_SIZE);
-
-	interp_reso = vfe_calc_interp_reso(input, output);
-	phase_mult = input * (1 << (13 + interp_reso)) / output;
-	reg = (interp_reso << 20) | phase_mult;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_V_PHASE);
-
-	writel_relaxed(0x3, vfe->base + VFE_0_SCALE_ENC_CBCR_CFG);
-
-	input = line->fmt[MSM_VFE_PAD_SINK].width;
-	output = line->compose.width / 2;
-	reg = (output << 16) | input;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_H_IMAGE_SIZE);
-
-	interp_reso = vfe_calc_interp_reso(input, output);
-	phase_mult = input * (1 << (13 + interp_reso)) / output;
-	reg = (interp_reso << 20) | phase_mult;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_H_PHASE);
-
-	input = line->fmt[MSM_VFE_PAD_SINK].height;
-	output = line->compose.height;
-	if (p == V4L2_PIX_FMT_NV12 || p == V4L2_PIX_FMT_NV21)
-		output = line->compose.height / 2;
-	reg = (output << 16) | input;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_V_IMAGE_SIZE);
-
-	interp_reso = vfe_calc_interp_reso(input, output);
-	phase_mult = input * (1 << (13 + interp_reso)) / output;
-	reg = (interp_reso << 20) | phase_mult;
-	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_V_PHASE);
-}
-
-static void vfe_set_crop_cfg(struct vfe_device *vfe, struct vfe_line *line)
-{
-	u32 p = line->video_out.active_fmt.fmt.pix_mp.pixelformat;
-	u32 reg;
-	u16 first, last;
-
-	first = line->crop.left;
-	last = line->crop.left + line->crop.width - 1;
-	reg = (first << 16) | last;
-	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_Y_WIDTH);
-
-	first = line->crop.top;
-	last = line->crop.top + line->crop.height - 1;
-	reg = (first << 16) | last;
-	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_Y_HEIGHT);
-
-	first = line->crop.left / 2;
-	last = line->crop.left / 2 + line->crop.width / 2 - 1;
-	reg = (first << 16) | last;
-	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_CBCR_WIDTH);
-
-	first = line->crop.top;
-	last = line->crop.top + line->crop.height - 1;
-	if (p == V4L2_PIX_FMT_NV12 || p == V4L2_PIX_FMT_NV21) {
-		first = line->crop.top / 2;
-		last = line->crop.top / 2 + line->crop.height / 2 - 1;
-	}
-	reg = (first << 16) | last;
-	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_CBCR_HEIGHT);
-}
-
-static void vfe_set_clamp_cfg(struct vfe_device *vfe)
-{
-	u32 val = VFE_0_CLAMP_ENC_MAX_CFG_CH0 |
-		VFE_0_CLAMP_ENC_MAX_CFG_CH1 |
-		VFE_0_CLAMP_ENC_MAX_CFG_CH2;
-
-	writel_relaxed(val, vfe->base + VFE_0_CLAMP_ENC_MAX_CFG);
-
-	val = VFE_0_CLAMP_ENC_MIN_CFG_CH0 |
-		VFE_0_CLAMP_ENC_MIN_CFG_CH1 |
-		VFE_0_CLAMP_ENC_MIN_CFG_CH2;
-
-	writel_relaxed(val, vfe->base + VFE_0_CLAMP_ENC_MIN_CFG);
-}
-
-/*
- * vfe_reset - Trigger reset on VFE module and wait to complete
- * @vfe: VFE device
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_reset(struct vfe_device *vfe)
-{
-	unsigned long time;
-
-	reinit_completion(&vfe->reset_complete);
-
-	vfe_global_reset(vfe);
-
-	time = wait_for_completion_timeout(&vfe->reset_complete,
-		msecs_to_jiffies(VFE_RESET_TIMEOUT_MS));
-	if (!time) {
-		dev_err(to_device(vfe), "VFE reset timeout\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/*
- * vfe_halt - Trigger halt on VFE module and wait to complete
- * @vfe: VFE device
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_halt(struct vfe_device *vfe)
-{
-	unsigned long time;
-
-	reinit_completion(&vfe->halt_complete);
-
-	writel_relaxed(VFE_0_BUS_BDG_CMD_HALT_REQ,
-		       vfe->base + VFE_0_BUS_BDG_CMD);
-
-	time = wait_for_completion_timeout(&vfe->halt_complete,
-		msecs_to_jiffies(VFE_HALT_TIMEOUT_MS));
-	if (!time) {
-		dev_err(to_device(vfe), "VFE halt timeout\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static void vfe_init_outputs(struct vfe_device *vfe)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe->line); i++) {
-		struct vfe_output *output = &vfe->line[i].output;
-
-		output->state = VFE_OUTPUT_OFF;
-		output->buf[0] = NULL;
-		output->buf[1] = NULL;
-		INIT_LIST_HEAD(&output->pending_bufs);
-
-		output->wm_num = 1;
-		if (vfe->line[i].id == VFE_LINE_PIX)
-			output->wm_num = 2;
-	}
-}
-
-static void vfe_reset_output_maps(struct vfe_device *vfe)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe->wm_output_map); i++)
-		vfe->wm_output_map[i] = VFE_LINE_NONE;
-}
-
-static void vfe_set_qos(struct vfe_device *vfe)
-{
-	u32 val = VFE_0_BUS_BDG_QOS_CFG_0_CFG;
-	u32 val7 = VFE_0_BUS_BDG_QOS_CFG_7_CFG;
-
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_0);
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_1);
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_2);
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_3);
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_4);
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_5);
-	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_6);
-	writel_relaxed(val7, vfe->base + VFE_0_BUS_BDG_QOS_CFG_7);
-}
-
-static void vfe_set_cgc_override(struct vfe_device *vfe, u8 wm, u8 enable)
-{
-	u32 val = VFE_0_CGC_OVERRIDE_1_IMAGE_Mx_CGC_OVERRIDE(wm);
-
-	if (enable)
-		vfe_reg_set(vfe, VFE_0_CGC_OVERRIDE_1, val);
-	else
-		vfe_reg_clr(vfe, VFE_0_CGC_OVERRIDE_1, val);
-
-	wmb();
-}
-
-static void vfe_set_module_cfg(struct vfe_device *vfe, u8 enable)
-{
-	u32 val = VFE_0_MODULE_CFG_DEMUX |
-		  VFE_0_MODULE_CFG_CHROMA_UPSAMPLE |
-		  VFE_0_MODULE_CFG_SCALE_ENC |
-		  VFE_0_MODULE_CFG_CROP_ENC;
-
-	if (enable)
-		writel_relaxed(val, vfe->base + VFE_0_MODULE_CFG);
-	else
-		writel_relaxed(0x0, vfe->base + VFE_0_MODULE_CFG);
-}
-
-static void vfe_set_camif_cfg(struct vfe_device *vfe, struct vfe_line *line)
-{
-	u32 val;
-
-	switch (line->fmt[MSM_VFE_PAD_SINK].code) {
-	case MEDIA_BUS_FMT_YUYV8_2X8:
-		val = VFE_0_CORE_CFG_PIXEL_PATTERN_YCBYCR;
-		break;
-	case MEDIA_BUS_FMT_YVYU8_2X8:
-		val = VFE_0_CORE_CFG_PIXEL_PATTERN_YCRYCB;
-		break;
-	case MEDIA_BUS_FMT_UYVY8_2X8:
-	default:
-		val = VFE_0_CORE_CFG_PIXEL_PATTERN_CBYCRY;
-		break;
-	case MEDIA_BUS_FMT_VYUY8_2X8:
-		val = VFE_0_CORE_CFG_PIXEL_PATTERN_CRYCBY;
-		break;
-	}
-
-	writel_relaxed(val, vfe->base + VFE_0_CORE_CFG);
-
-	val = line->fmt[MSM_VFE_PAD_SINK].width * 2;
-	val |= line->fmt[MSM_VFE_PAD_SINK].height << 16;
-	writel_relaxed(val, vfe->base + VFE_0_CAMIF_FRAME_CFG);
-
-	val = line->fmt[MSM_VFE_PAD_SINK].width * 2 - 1;
-	writel_relaxed(val, vfe->base + VFE_0_CAMIF_WINDOW_WIDTH_CFG);
-
-	val = line->fmt[MSM_VFE_PAD_SINK].height - 1;
-	writel_relaxed(val, vfe->base + VFE_0_CAMIF_WINDOW_HEIGHT_CFG);
-
-	val = 0xffffffff;
-	writel_relaxed(val, vfe->base + VFE_0_CAMIF_SUBSAMPLE_CFG_0);
-
-	val = 0xffffffff;
-	writel_relaxed(val, vfe->base + VFE_0_CAMIF_IRQ_SUBSAMPLE_PATTERN);
-
-	val = VFE_0_RDI_CFG_x_MIPI_EN_BITS;
-	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(0), val);
-
-	val = VFE_0_CAMIF_CFG_VFE_OUTPUT_EN;
-	writel_relaxed(val, vfe->base + VFE_0_CAMIF_CFG);
-}
-
-static void vfe_set_camif_cmd(struct vfe_device *vfe, u32 cmd)
-{
-	writel_relaxed(VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS,
-		       vfe->base + VFE_0_CAMIF_CMD);
-
-	writel_relaxed(cmd, vfe->base + VFE_0_CAMIF_CMD);
-}
-
-static int vfe_camif_wait_for_stop(struct vfe_device *vfe)
-{
-	u32 val;
-	int ret;
-
-	ret = readl_poll_timeout(vfe->base + VFE_0_CAMIF_STATUS,
-				 val,
-				 (val & VFE_0_CAMIF_STATUS_HALT),
-				 CAMIF_TIMEOUT_SLEEP_US,
-				 CAMIF_TIMEOUT_ALL_US);
-	if (ret < 0)
-		dev_err(to_device(vfe), "%s: camif stop timeout\n", __func__);
-
-	return ret;
-}
-
-static void vfe_output_init_addrs(struct vfe_device *vfe,
-				  struct vfe_output *output, u8 sync)
-{
-	u32 ping_addr;
-	u32 pong_addr;
-	unsigned int i;
-
-	output->active_buf = 0;
-
-	for (i = 0; i < output->wm_num; i++) {
-		if (output->buf[0])
-			ping_addr = output->buf[0]->addr[i];
-		else
-			ping_addr = 0;
-
-		if (output->buf[1])
-			pong_addr = output->buf[1]->addr[i];
-		else
-			pong_addr = ping_addr;
-
-		vfe_wm_set_ping_addr(vfe, output->wm_idx[i], ping_addr);
-		vfe_wm_set_pong_addr(vfe, output->wm_idx[i], pong_addr);
-		if (sync)
-			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
-	}
-}
-
-static void vfe_output_update_ping_addr(struct vfe_device *vfe,
-					struct vfe_output *output, u8 sync)
-{
-	u32 addr;
-	unsigned int i;
-
-	for (i = 0; i < output->wm_num; i++) {
-		if (output->buf[0])
-			addr = output->buf[0]->addr[i];
-		else
-			addr = 0;
-
-		vfe_wm_set_ping_addr(vfe, output->wm_idx[i], addr);
-		if (sync)
-			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
-	}
-}
-
-static void vfe_output_update_pong_addr(struct vfe_device *vfe,
-					struct vfe_output *output, u8 sync)
-{
-	u32 addr;
-	unsigned int i;
-
-	for (i = 0; i < output->wm_num; i++) {
-		if (output->buf[1])
-			addr = output->buf[1]->addr[i];
-		else
-			addr = 0;
-
-		vfe_wm_set_pong_addr(vfe, output->wm_idx[i], addr);
-		if (sync)
-			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
-	}
-
-}
-
-static int vfe_reserve_wm(struct vfe_device *vfe, enum vfe_line_id line_id)
-{
-	int ret = -EBUSY;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe->wm_output_map); i++) {
-		if (vfe->wm_output_map[i] == VFE_LINE_NONE) {
-			vfe->wm_output_map[i] = line_id;
-			ret = i;
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static int vfe_release_wm(struct vfe_device *vfe, u8 wm)
-{
-	if (wm >= ARRAY_SIZE(vfe->wm_output_map))
-		return -EINVAL;
-
-	vfe->wm_output_map[wm] = VFE_LINE_NONE;
-
-	return 0;
-}
-
-static void vfe_output_frame_drop(struct vfe_device *vfe,
-				  struct vfe_output *output,
-				  u32 drop_pattern)
-{
-	u8 drop_period;
-	unsigned int i;
-
-	/* We need to toggle update period to be valid on next frame */
-	output->drop_update_idx++;
-	output->drop_update_idx %= VFE_FRAME_DROP_UPDATES;
-	drop_period = VFE_FRAME_DROP_VAL + output->drop_update_idx;
-
-	for (i = 0; i < output->wm_num; i++) {
-		vfe_wm_set_framedrop_period(vfe, output->wm_idx[i],
-					    drop_period);
-		vfe_wm_set_framedrop_pattern(vfe, output->wm_idx[i],
-					     drop_pattern);
-	}
-	vfe_reg_update(vfe, container_of(output, struct vfe_line, output)->id);
-}
-
-static struct camss_buffer *vfe_buf_get_pending(struct vfe_output *output)
-{
-	struct camss_buffer *buffer = NULL;
-
-	if (!list_empty(&output->pending_bufs)) {
-		buffer = list_first_entry(&output->pending_bufs,
-					  struct camss_buffer,
-					  queue);
-		list_del(&buffer->queue);
-	}
-
-	return buffer;
-}
-
-/*
- * vfe_buf_add_pending - Add output buffer to list of pending
- * @output: VFE output
- * @buffer: Video buffer
- */
-static void vfe_buf_add_pending(struct vfe_output *output,
-				struct camss_buffer *buffer)
-{
-	INIT_LIST_HEAD(&buffer->queue);
-	list_add_tail(&buffer->queue, &output->pending_bufs);
-}
-
-/*
- * vfe_buf_flush_pending - Flush all pending buffers.
- * @output: VFE output
- * @state: vb2 buffer state
- */
-static void vfe_buf_flush_pending(struct vfe_output *output,
-				  enum vb2_buffer_state state)
-{
-	struct camss_buffer *buf;
-	struct camss_buffer *t;
-
-	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
-		vb2_buffer_done(&buf->vb.vb2_buf, state);
-		list_del(&buf->queue);
-	}
-}
-
-static void vfe_buf_update_wm_on_next(struct vfe_device *vfe,
-				      struct vfe_output *output)
-{
-	switch (output->state) {
-	case VFE_OUTPUT_CONTINUOUS:
-		vfe_output_frame_drop(vfe, output, 3);
-		break;
-	case VFE_OUTPUT_SINGLE:
-	default:
-		dev_err_ratelimited(to_device(vfe),
-				    "Next buf in wrong state! %d\n",
-				    output->state);
-		break;
-	}
-}
-
-static void vfe_buf_update_wm_on_last(struct vfe_device *vfe,
-				      struct vfe_output *output)
-{
-	switch (output->state) {
-	case VFE_OUTPUT_CONTINUOUS:
-		output->state = VFE_OUTPUT_SINGLE;
-		vfe_output_frame_drop(vfe, output, 1);
-		break;
-	case VFE_OUTPUT_SINGLE:
-		output->state = VFE_OUTPUT_STOPPING;
-		vfe_output_frame_drop(vfe, output, 0);
-		break;
-	default:
-		dev_err_ratelimited(to_device(vfe),
-				    "Last buff in wrong state! %d\n",
-				    output->state);
-		break;
-	}
-}
-
-static void vfe_buf_update_wm_on_new(struct vfe_device *vfe,
-				     struct vfe_output *output,
-				     struct camss_buffer *new_buf)
-{
-	int inactive_idx;
-
-	switch (output->state) {
-	case VFE_OUTPUT_SINGLE:
-		inactive_idx = !output->active_buf;
-
-		if (!output->buf[inactive_idx]) {
-			output->buf[inactive_idx] = new_buf;
-
-			if (inactive_idx)
-				vfe_output_update_pong_addr(vfe, output, 0);
-			else
-				vfe_output_update_ping_addr(vfe, output, 0);
-
-			vfe_output_frame_drop(vfe, output, 3);
-			output->state = VFE_OUTPUT_CONTINUOUS;
-		} else {
-			vfe_buf_add_pending(output, new_buf);
-			dev_err_ratelimited(to_device(vfe),
-					    "Inactive buffer is busy\n");
-		}
-		break;
-
-	case VFE_OUTPUT_IDLE:
-		if (!output->buf[0]) {
-			output->buf[0] = new_buf;
-
-			vfe_output_init_addrs(vfe, output, 1);
-
-			vfe_output_frame_drop(vfe, output, 1);
-			output->state = VFE_OUTPUT_SINGLE;
-		} else {
-			vfe_buf_add_pending(output, new_buf);
-			dev_err_ratelimited(to_device(vfe),
-					    "Output idle with buffer set!\n");
-		}
-		break;
-
-	case VFE_OUTPUT_CONTINUOUS:
-	default:
-		vfe_buf_add_pending(output, new_buf);
-		break;
-	}
-}
-
-static int vfe_get_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output;
-	unsigned long flags;
-	int i;
-	int wm_idx;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	output = &line->output;
-	if (output->state != VFE_OUTPUT_OFF) {
-		dev_err(to_device(vfe), "Output is running\n");
-		goto error;
-	}
-	output->state = VFE_OUTPUT_RESERVED;
-
-	output->active_buf = 0;
-
-	for (i = 0; i < output->wm_num; i++) {
-		wm_idx = vfe_reserve_wm(vfe, line->id);
-		if (wm_idx < 0) {
-			dev_err(to_device(vfe), "Can not reserve wm\n");
-			goto error_get_wm;
-		}
-		output->wm_idx[i] = wm_idx;
-	}
-
-	output->drop_update_idx = 0;
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return 0;
-
-error_get_wm:
-	for (i--; i >= 0; i--)
-		vfe_release_wm(vfe, output->wm_idx[i]);
-	output->state = VFE_OUTPUT_OFF;
-error:
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return -EINVAL;
-}
-
-static int vfe_put_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output = &line->output;
-	unsigned long flags;
-	unsigned int i;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	for (i = 0; i < output->wm_num; i++)
-		vfe_release_wm(vfe, output->wm_idx[i]);
-
-	output->state = VFE_OUTPUT_OFF;
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-	return 0;
-}
-
-static int vfe_enable_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output = &line->output;
-	unsigned long flags;
-	unsigned int i;
-	u16 ub_size;
-
-	switch (vfe->id) {
-	case 0:
-		ub_size = MSM_VFE_VFE0_UB_SIZE_RDI;
-		break;
-	case 1:
-		ub_size = MSM_VFE_VFE1_UB_SIZE_RDI;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	vfe->reg_update &= ~VFE_0_REG_UPDATE_line_n(line->id);
-
-	if (output->state != VFE_OUTPUT_RESERVED) {
-		dev_err(to_device(vfe), "Output is not in reserved state %d\n",
-			output->state);
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-		return -EINVAL;
-	}
-	output->state = VFE_OUTPUT_IDLE;
-
-	output->buf[0] = vfe_buf_get_pending(output);
-	output->buf[1] = vfe_buf_get_pending(output);
-
-	if (!output->buf[0] && output->buf[1]) {
-		output->buf[0] = output->buf[1];
-		output->buf[1] = NULL;
-	}
-
-	if (output->buf[0])
-		output->state = VFE_OUTPUT_SINGLE;
-
-	if (output->buf[1])
-		output->state = VFE_OUTPUT_CONTINUOUS;
-
-	switch (output->state) {
-	case VFE_OUTPUT_SINGLE:
-		vfe_output_frame_drop(vfe, output, 1);
-		break;
-	case VFE_OUTPUT_CONTINUOUS:
-		vfe_output_frame_drop(vfe, output, 3);
-		break;
-	default:
-		vfe_output_frame_drop(vfe, output, 0);
-		break;
-	}
-
-	output->sequence = 0;
-	output->wait_sof = 0;
-	output->wait_reg_update = 0;
-	reinit_completion(&output->sof);
-	reinit_completion(&output->reg_update);
-
-	vfe_output_init_addrs(vfe, output, 0);
-
-	if (line->id != VFE_LINE_PIX) {
-		vfe_set_cgc_override(vfe, output->wm_idx[0], 1);
-		vfe_enable_irq_wm_line(vfe, output->wm_idx[0], line->id, 1);
-		vfe_bus_connect_wm_to_rdi(vfe, output->wm_idx[0], line->id);
-		vfe_wm_set_subsample(vfe, output->wm_idx[0]);
-		vfe_set_rdi_cid(vfe, line->id, 0);
-		vfe_wm_set_ub_cfg(vfe, output->wm_idx[0],
-				  (ub_size + 1) * output->wm_idx[0], ub_size);
-		vfe_wm_frame_based(vfe, output->wm_idx[0], 1);
-		vfe_wm_enable(vfe, output->wm_idx[0], 1);
-		vfe_bus_reload_wm(vfe, output->wm_idx[0]);
-	} else {
-		ub_size /= output->wm_num;
-		for (i = 0; i < output->wm_num; i++) {
-			vfe_set_cgc_override(vfe, output->wm_idx[i], 1);
-			vfe_wm_set_subsample(vfe, output->wm_idx[i]);
-			vfe_wm_set_ub_cfg(vfe, output->wm_idx[i],
-					  (ub_size + 1) * output->wm_idx[i],
-					  ub_size);
-			vfe_wm_line_based(vfe, output->wm_idx[i],
-					&line->video_out.active_fmt.fmt.pix_mp,
-					i, 1);
-			vfe_wm_enable(vfe, output->wm_idx[i], 1);
-			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
-		}
-		vfe_enable_irq_pix_line(vfe, 0, line->id, 1);
-		vfe_set_module_cfg(vfe, 1);
-		vfe_set_camif_cfg(vfe, line);
-		vfe_set_xbar_cfg(vfe, output, 1);
-		vfe_set_demux_cfg(vfe, line);
-		vfe_set_scale_cfg(vfe, line);
-		vfe_set_crop_cfg(vfe, line);
-		vfe_set_clamp_cfg(vfe);
-		vfe_set_camif_cmd(vfe, VFE_0_CAMIF_CMD_ENABLE_FRAME_BOUNDARY);
-	}
-
-	vfe_reg_update(vfe, line->id);
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return 0;
-}
-
-static int vfe_disable_output(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	struct vfe_output *output = &line->output;
-	unsigned long flags;
-	unsigned long time;
-	unsigned int i;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	output->wait_sof = 1;
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	time = wait_for_completion_timeout(&output->sof,
-					   msecs_to_jiffies(VFE_NEXT_SOF_MS));
-	if (!time)
-		dev_err(to_device(vfe), "VFE sof timeout\n");
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-	for (i = 0; i < output->wm_num; i++)
-		vfe_wm_enable(vfe, output->wm_idx[i], 0);
-
-	vfe_reg_update(vfe, line->id);
-	output->wait_reg_update = 1;
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	time = wait_for_completion_timeout(&output->reg_update,
-					   msecs_to_jiffies(VFE_NEXT_SOF_MS));
-	if (!time)
-		dev_err(to_device(vfe), "VFE reg update timeout\n");
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	if (line->id != VFE_LINE_PIX) {
-		vfe_wm_frame_based(vfe, output->wm_idx[0], 0);
-		vfe_bus_disconnect_wm_from_rdi(vfe, output->wm_idx[0], line->id);
-		vfe_enable_irq_wm_line(vfe, output->wm_idx[0], line->id, 0);
-		vfe_set_cgc_override(vfe, output->wm_idx[0], 0);
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-	} else {
-		for (i = 0; i < output->wm_num; i++) {
-			vfe_wm_line_based(vfe, output->wm_idx[i], NULL, i, 0);
-			vfe_set_cgc_override(vfe, output->wm_idx[i], 0);
-		}
-
-		vfe_enable_irq_pix_line(vfe, 0, line->id, 0);
-		vfe_set_module_cfg(vfe, 0);
-		vfe_set_xbar_cfg(vfe, output, 0);
-
-		vfe_set_camif_cmd(vfe, VFE_0_CAMIF_CMD_DISABLE_FRAME_BOUNDARY);
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-		vfe_camif_wait_for_stop(vfe);
-	}
-
-	return 0;
-}
-
-/*
- * vfe_enable - Enable streaming on VFE line
- * @line: VFE line
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_enable(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-	int ret;
-
-	mutex_lock(&vfe->stream_lock);
-
-	if (!vfe->stream_count) {
-		vfe_enable_irq_common(vfe);
-
-		vfe_bus_enable_wr_if(vfe, 1);
-
-		vfe_set_qos(vfe);
-	}
-
-	vfe->stream_count++;
-
-	mutex_unlock(&vfe->stream_lock);
-
-	ret = vfe_get_output(line);
-	if (ret < 0)
-		goto error_get_output;
-
-	ret = vfe_enable_output(line);
-	if (ret < 0)
-		goto error_enable_output;
-
-	vfe->was_streaming = 1;
-
-	return 0;
-
-
-error_enable_output:
-	vfe_put_output(line);
-
-error_get_output:
-	mutex_lock(&vfe->stream_lock);
-
-	if (vfe->stream_count == 1)
-		vfe_bus_enable_wr_if(vfe, 0);
-
-	vfe->stream_count--;
-
-	mutex_unlock(&vfe->stream_lock);
-
-	return ret;
-}
-
-/*
- * vfe_disable - Disable streaming on VFE line
- * @line: VFE line
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_disable(struct vfe_line *line)
-{
-	struct vfe_device *vfe = to_vfe(line);
-
-	vfe_disable_output(line);
-
-	vfe_put_output(line);
-
-	mutex_lock(&vfe->stream_lock);
-
-	if (vfe->stream_count == 1)
-		vfe_bus_enable_wr_if(vfe, 0);
-
-	vfe->stream_count--;
-
-	mutex_unlock(&vfe->stream_lock);
-
-	return 0;
-}
-
-/*
- * vfe_isr_sof - Process start of frame interrupt
- * @vfe: VFE Device
- * @line_id: VFE line
- */
-static void vfe_isr_sof(struct vfe_device *vfe, enum vfe_line_id line_id)
-{
-	struct vfe_output *output;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-	output = &vfe->line[line_id].output;
-	if (output->wait_sof) {
-		output->wait_sof = 0;
-		complete(&output->sof);
-	}
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-}
-
-/*
- * vfe_isr_reg_update - Process reg update interrupt
- * @vfe: VFE Device
- * @line_id: VFE line
- */
-static void vfe_isr_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
-{
-	struct vfe_output *output;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-	vfe->reg_update &= ~VFE_0_REG_UPDATE_line_n(line_id);
-
-	output = &vfe->line[line_id].output;
-
-	if (output->wait_reg_update) {
-		output->wait_reg_update = 0;
-		complete(&output->reg_update);
-		spin_unlock_irqrestore(&vfe->output_lock, flags);
-		return;
-	}
-
-	if (output->state == VFE_OUTPUT_STOPPING) {
-		/* Release last buffer when hw is idle */
-		if (output->last_buffer) {
-			vb2_buffer_done(&output->last_buffer->vb.vb2_buf,
-					VB2_BUF_STATE_DONE);
-			output->last_buffer = NULL;
-		}
-		output->state = VFE_OUTPUT_IDLE;
-
-		/* Buffers received in stopping state are queued in */
-		/* dma pending queue, start next capture here */
-
-		output->buf[0] = vfe_buf_get_pending(output);
-		output->buf[1] = vfe_buf_get_pending(output);
-
-		if (!output->buf[0] && output->buf[1]) {
-			output->buf[0] = output->buf[1];
-			output->buf[1] = NULL;
-		}
-
-		if (output->buf[0])
-			output->state = VFE_OUTPUT_SINGLE;
-
-		if (output->buf[1])
-			output->state = VFE_OUTPUT_CONTINUOUS;
-
-		switch (output->state) {
-		case VFE_OUTPUT_SINGLE:
-			vfe_output_frame_drop(vfe, output, 2);
-			break;
-		case VFE_OUTPUT_CONTINUOUS:
-			vfe_output_frame_drop(vfe, output, 3);
-			break;
-		default:
-			vfe_output_frame_drop(vfe, output, 0);
-			break;
-		}
-
-		vfe_output_init_addrs(vfe, output, 1);
-	}
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-}
-
-/*
- * vfe_isr_wm_done - Process write master done interrupt
- * @vfe: VFE Device
- * @wm: Write master id
- */
-static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
-{
-	struct camss_buffer *ready_buf;
-	struct vfe_output *output;
-	dma_addr_t *new_addr;
-	unsigned long flags;
-	u32 active_index;
-	u64 ts = ktime_get_ns();
-	unsigned int i;
-
-	active_index = vfe_wm_get_ping_pong_status(vfe, wm);
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	if (vfe->wm_output_map[wm] == VFE_LINE_NONE) {
-		dev_err_ratelimited(to_device(vfe),
-				    "Received wm done for unmapped index\n");
-		goto out_unlock;
-	}
-	output = &vfe->line[vfe->wm_output_map[wm]].output;
-
-	if (output->active_buf == active_index) {
-		dev_err_ratelimited(to_device(vfe),
-				    "Active buffer mismatch!\n");
-		goto out_unlock;
-	}
-	output->active_buf = active_index;
-
-	ready_buf = output->buf[!active_index];
-	if (!ready_buf) {
-		dev_err_ratelimited(to_device(vfe),
-				    "Missing ready buf %d %d!\n",
-				    !active_index, output->state);
-		goto out_unlock;
-	}
-
-	ready_buf->vb.vb2_buf.timestamp = ts;
-	ready_buf->vb.sequence = output->sequence++;
-
-	/* Get next buffer */
-	output->buf[!active_index] = vfe_buf_get_pending(output);
-	if (!output->buf[!active_index]) {
-		/* No next buffer - set same address */
-		new_addr = ready_buf->addr;
-		vfe_buf_update_wm_on_last(vfe, output);
-	} else {
-		new_addr = output->buf[!active_index]->addr;
-		vfe_buf_update_wm_on_next(vfe, output);
-	}
-
-	if (active_index)
-		for (i = 0; i < output->wm_num; i++)
-			vfe_wm_set_ping_addr(vfe, output->wm_idx[i],
-					     new_addr[i]);
-	else
-		for (i = 0; i < output->wm_num; i++)
-			vfe_wm_set_pong_addr(vfe, output->wm_idx[i],
-					     new_addr[i]);
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	if (output->state == VFE_OUTPUT_STOPPING)
-		output->last_buffer = ready_buf;
-	else
-		vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
-
-	return;
-
-out_unlock:
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-}
-
-/*
- * vfe_isr_wm_done - Process composite image done interrupt
- * @vfe: VFE Device
- * @comp: Composite image id
- */
-static void vfe_isr_comp_done(struct vfe_device *vfe, u8 comp)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe->wm_output_map); i++)
-		if (vfe->wm_output_map[i] == VFE_LINE_PIX) {
-			vfe_isr_wm_done(vfe, i);
-			break;
-		}
-}
-
-/*
- * vfe_isr - ISPIF module interrupt handler
- * @irq: Interrupt line
- * @dev: VFE device
- *
- * Return IRQ_HANDLED on success
- */
-static irqreturn_t vfe_isr(int irq, void *dev)
-{
-	struct vfe_device *vfe = dev;
-	u32 value0, value1;
-	u32 violation;
-	int i, j;
-
-	value0 = readl_relaxed(vfe->base + VFE_0_IRQ_STATUS_0);
-	value1 = readl_relaxed(vfe->base + VFE_0_IRQ_STATUS_1);
-
-	writel_relaxed(value0, vfe->base + VFE_0_IRQ_CLEAR_0);
-	writel_relaxed(value1, vfe->base + VFE_0_IRQ_CLEAR_1);
-
-	wmb();
-	writel_relaxed(VFE_0_IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_0_IRQ_CMD);
-
-	if (value0 & VFE_0_IRQ_STATUS_0_RESET_ACK)
-		complete(&vfe->reset_complete);
-
-	if (value1 & VFE_0_IRQ_STATUS_1_VIOLATION) {
-		violation = readl_relaxed(vfe->base + VFE_0_VIOLATION_STATUS);
-		dev_err_ratelimited(to_device(vfe),
-				    "VFE: violation = 0x%08x\n", violation);
-	}
-
-	if (value1 & VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK) {
-		complete(&vfe->halt_complete);
-		writel_relaxed(0x0, vfe->base + VFE_0_BUS_BDG_CMD);
-	}
-
-	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++)
-		if (value0 & VFE_0_IRQ_STATUS_0_line_n_REG_UPDATE(i))
-			vfe_isr_reg_update(vfe, i);
-
-	if (value0 & VFE_0_IRQ_STATUS_0_CAMIF_SOF)
-		vfe_isr_sof(vfe, VFE_LINE_PIX);
-
-	for (i = VFE_LINE_RDI0; i <= VFE_LINE_RDI2; i++)
-		if (value1 & VFE_0_IRQ_STATUS_1_RDIn_SOF(i))
-			vfe_isr_sof(vfe, i);
-
-	for (i = 0; i < MSM_VFE_COMPOSITE_IRQ_NUM; i++)
-		if (value0 & VFE_0_IRQ_STATUS_0_IMAGE_COMPOSITE_DONE_n(i)) {
-			vfe_isr_comp_done(vfe, i);
-			for (j = 0; j < ARRAY_SIZE(vfe->wm_output_map); j++)
-				if (vfe->wm_output_map[j] == VFE_LINE_PIX)
-					value0 &= ~VFE_0_IRQ_MASK_0_IMAGE_MASTER_n_PING_PONG(j);
-		}
-
-	for (i = 0; i < MSM_VFE_IMAGE_MASTERS_NUM; i++)
-		if (value0 & VFE_0_IRQ_STATUS_0_IMAGE_MASTER_n_PING_PONG(i))
-			vfe_isr_wm_done(vfe, i);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * vfe_set_clock_rates - Calculate and set clock rates on VFE module
- * @vfe: VFE device
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_set_clock_rates(struct vfe_device *vfe)
-{
-	struct device *dev = to_device(vfe);
-	u32 pixel_clock[MSM_VFE_LINE_NUM];
-	int i, j;
-	int ret;
-
-	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++) {
-		ret = camss_get_pixel_clock(&vfe->line[i].subdev.entity,
-					    &pixel_clock[i]);
-		if (ret)
-			pixel_clock[i] = 0;
-	}
-
-	for (i = 0; i < vfe->nclocks; i++) {
-		struct camss_clock *clock = &vfe->clock[i];
-
-		if (!strcmp(clock->name, "camss_vfe_vfe")) {
-			u64 min_rate = 0;
-			long rate;
-
-			for (j = VFE_LINE_RDI0; j <= VFE_LINE_PIX; j++) {
-				u32 tmp;
-				u8 bpp;
-
-				if (j == VFE_LINE_PIX) {
-					tmp = pixel_clock[j];
-				} else {
-					bpp = vfe_get_bpp(vfe->line[j].
-						fmt[MSM_VFE_PAD_SINK].code);
-					tmp = pixel_clock[j] * bpp / 64;
-				}
-
-				if (min_rate < tmp)
-					min_rate = tmp;
-			}
-
-			camss_add_clock_margin(&min_rate);
-
-			for (j = 0; j < clock->nfreqs; j++)
-				if (min_rate < clock->freq[j])
-					break;
-
-			if (j == clock->nfreqs) {
-				dev_err(dev,
-					"Pixel clock is too high for VFE");
-				return -EINVAL;
-			}
-
-			/* if sensor pixel clock is not available */
-			/* set highest possible VFE clock rate */
-			if (min_rate == 0)
-				j = clock->nfreqs - 1;
-
-			rate = clk_round_rate(clock->clk, clock->freq[j]);
-			if (rate < 0) {
-				dev_err(dev, "clk round rate failed: %ld\n",
-					rate);
-				return -EINVAL;
-			}
-
-			ret = clk_set_rate(clock->clk, rate);
-			if (ret < 0) {
-				dev_err(dev, "clk set rate failed: %d\n", ret);
-				return ret;
-			}
-		}
-	}
-
-	return 0;
-}
-
-/*
- * vfe_check_clock_rates - Check current clock rates on VFE module
- * @vfe: VFE device
- *
- * Return 0 if current clock rates are suitable for a new pipeline
- * or a negative error code otherwise
- */
-static int vfe_check_clock_rates(struct vfe_device *vfe)
-{
-	u32 pixel_clock[MSM_VFE_LINE_NUM];
-	int i, j;
-	int ret;
-
-	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++) {
-		ret = camss_get_pixel_clock(&vfe->line[i].subdev.entity,
-					    &pixel_clock[i]);
-		if (ret)
-			pixel_clock[i] = 0;
-	}
-
-	for (i = 0; i < vfe->nclocks; i++) {
-		struct camss_clock *clock = &vfe->clock[i];
-
-		if (!strcmp(clock->name, "camss_vfe_vfe")) {
-			u64 min_rate = 0;
-			unsigned long rate;
-
-			for (j = VFE_LINE_RDI0; j <= VFE_LINE_PIX; j++) {
-				u32 tmp;
-				u8 bpp;
-
-				if (j == VFE_LINE_PIX) {
-					tmp = pixel_clock[j];
-				} else {
-					bpp = vfe_get_bpp(vfe->line[j].
-						fmt[MSM_VFE_PAD_SINK].code);
-					tmp = pixel_clock[j] * bpp / 64;
-				}
-
-				if (min_rate < tmp)
-					min_rate = tmp;
-			}
-
-			camss_add_clock_margin(&min_rate);
-
-			rate = clk_get_rate(clock->clk);
-			if (rate < min_rate)
-				return -EBUSY;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * vfe_get - Power up and reset VFE module
- * @vfe: VFE Device
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_get(struct vfe_device *vfe)
-{
-	int ret;
-
-	mutex_lock(&vfe->power_lock);
-
-	if (vfe->power_count == 0) {
-		ret = vfe_set_clock_rates(vfe);
-		if (ret < 0)
-			goto error_clocks;
-
-		ret = camss_enable_clocks(vfe->nclocks, vfe->clock,
-					  to_device(vfe));
-		if (ret < 0)
-			goto error_clocks;
-
-		ret = vfe_reset(vfe);
-		if (ret < 0)
-			goto error_reset;
-
-		vfe_reset_output_maps(vfe);
-
-		vfe_init_outputs(vfe);
-	} else {
-		ret = vfe_check_clock_rates(vfe);
-		if (ret < 0)
-			goto error_clocks;
-	}
-	vfe->power_count++;
-
-	mutex_unlock(&vfe->power_lock);
-
-	return 0;
-
-error_reset:
-	camss_disable_clocks(vfe->nclocks, vfe->clock);
-
-error_clocks:
-	mutex_unlock(&vfe->power_lock);
-
-	return ret;
-}
-
-/*
- * vfe_put - Power down VFE module
- * @vfe: VFE Device
- */
-static void vfe_put(struct vfe_device *vfe)
-{
-	mutex_lock(&vfe->power_lock);
-
-	if (vfe->power_count == 0) {
-		dev_err(to_device(vfe), "vfe power off on power_count == 0\n");
-		goto exit;
-	} else if (vfe->power_count == 1) {
-		if (vfe->was_streaming) {
-			vfe->was_streaming = 0;
-			vfe_halt(vfe);
-		}
-		camss_disable_clocks(vfe->nclocks, vfe->clock);
-	}
-
-	vfe->power_count--;
-
-exit:
-	mutex_unlock(&vfe->power_lock);
-}
-
-/*
- * vfe_video_pad_to_line - Get pointer to VFE line by media pad
- * @pad: Media pad
- *
- * Return pointer to vfe line structure
- */
-static struct vfe_line *vfe_video_pad_to_line(struct media_pad *pad)
-{
-	struct media_pad *vfe_pad;
-	struct v4l2_subdev *subdev;
-
-	vfe_pad = media_entity_remote_pad(pad);
-	if (vfe_pad == NULL)
-		return NULL;
-
-	subdev = media_entity_to_v4l2_subdev(vfe_pad->entity);
-
-	return container_of(subdev, struct vfe_line, subdev);
-}
-
-/*
- * vfe_queue_buffer - Add empty buffer
- * @vid: Video device structure
- * @buf: Buffer to be enqueued
- *
- * Add an empty buffer - depending on the current number of buffers it will be
- * put in pending buffer queue or directly given to the hardware to be filled.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_queue_buffer(struct camss_video *vid,
-			    struct camss_buffer *buf)
-{
-	struct vfe_device *vfe = &vid->camss->vfe;
-	struct vfe_line *line;
-	struct vfe_output *output;
-	unsigned long flags;
-
-	line = vfe_video_pad_to_line(&vid->pad);
-	if (!line) {
-		dev_err(to_device(vfe), "Can not queue buffer\n");
-		return -1;
-	}
-	output = &line->output;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	vfe_buf_update_wm_on_new(vfe, output, buf);
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return 0;
-}
-
-/*
- * vfe_flush_buffers - Return all vb2 buffers
- * @vid: Video device structure
- * @state: vb2 buffer state of the returned buffers
- *
- * Return all buffers to vb2. This includes queued pending buffers (still
- * unused) and any buffers given to the hardware but again still not used.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_flush_buffers(struct camss_video *vid,
-			     enum vb2_buffer_state state)
-{
-	struct vfe_device *vfe = &vid->camss->vfe;
-	struct vfe_line *line;
-	struct vfe_output *output;
-	unsigned long flags;
-
-	line = vfe_video_pad_to_line(&vid->pad);
-	if (!line) {
-		dev_err(to_device(vfe),	"Can not flush buffers\n");
-		return -1;
-	}
-	output = &line->output;
-
-	spin_lock_irqsave(&vfe->output_lock, flags);
-
-	vfe_buf_flush_pending(output, state);
-
-	if (output->buf[0])
-		vb2_buffer_done(&output->buf[0]->vb.vb2_buf, state);
-
-	if (output->buf[1])
-		vb2_buffer_done(&output->buf[1]->vb.vb2_buf, state);
-
-	if (output->last_buffer) {
-		vb2_buffer_done(&output->last_buffer->vb.vb2_buf, state);
-		output->last_buffer = NULL;
-	}
-
-	spin_unlock_irqrestore(&vfe->output_lock, flags);
-
-	return 0;
-}
-
-/*
- * vfe_set_power - Power on/off VFE module
- * @sd: VFE V4L2 subdevice
- * @on: Requested power state
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_set_power(struct v4l2_subdev *sd, int on)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct vfe_device *vfe = to_vfe(line);
-	int ret;
-
-	if (on) {
-		u32 hw_version;
-
-		ret = vfe_get(vfe);
-		if (ret < 0)
-			return ret;
-
-		hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
-		dev_dbg(to_device(vfe),
-			"VFE HW Version = 0x%08x\n", hw_version);
-	} else {
-		vfe_put(vfe);
-	}
-
-	return 0;
-}
-
-/*
- * vfe_set_stream - Enable/disable streaming on VFE module
- * @sd: VFE V4L2 subdevice
- * @enable: Requested streaming state
- *
- * Main configuration of VFE module is triggered here.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_set_stream(struct v4l2_subdev *sd, int enable)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct vfe_device *vfe = to_vfe(line);
-	int ret;
-
-	if (enable) {
-		ret = vfe_enable(line);
-		if (ret < 0)
-			dev_err(to_device(vfe),
-				"Failed to enable vfe outputs\n");
-	} else {
-		ret = vfe_disable(line);
-		if (ret < 0)
-			dev_err(to_device(vfe),
-				"Failed to disable vfe outputs\n");
-	}
-
-	return ret;
-}
-
-/*
- * __vfe_get_format - Get pointer to format structure
- * @line: VFE line
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad from which format is requested
- * @which: TRY or ACTIVE format
- *
- * Return pointer to TRY or ACTIVE format structure
- */
-static struct v4l2_mbus_framefmt *
-__vfe_get_format(struct vfe_line *line,
-		 struct v4l2_subdev_pad_config *cfg,
-		 unsigned int pad,
-		 enum v4l2_subdev_format_whence which)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_format(&line->subdev, cfg, pad);
-
-	return &line->fmt[pad];
-}
-
-/*
- * __vfe_get_compose - Get pointer to compose selection structure
- * @line: VFE line
- * @cfg: V4L2 subdev pad configuration
- * @which: TRY or ACTIVE format
- *
- * Return pointer to TRY or ACTIVE compose rectangle structure
- */
-static struct v4l2_rect *
-__vfe_get_compose(struct vfe_line *line,
-		  struct v4l2_subdev_pad_config *cfg,
-		  enum v4l2_subdev_format_whence which)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_compose(&line->subdev, cfg,
-						   MSM_VFE_PAD_SINK);
-
-	return &line->compose;
-}
-
-/*
- * __vfe_get_crop - Get pointer to crop selection structure
- * @line: VFE line
- * @cfg: V4L2 subdev pad configuration
- * @which: TRY or ACTIVE format
- *
- * Return pointer to TRY or ACTIVE crop rectangle structure
- */
-static struct v4l2_rect *
-__vfe_get_crop(struct vfe_line *line,
-	       struct v4l2_subdev_pad_config *cfg,
-	       enum v4l2_subdev_format_whence which)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_crop(&line->subdev, cfg,
-						MSM_VFE_PAD_SRC);
-
-	return &line->crop;
-}
-
-/*
- * vfe_try_format - Handle try format by pad subdev method
- * @line: VFE line
- * @cfg: V4L2 subdev pad configuration
- * @pad: pad on which format is requested
- * @fmt: pointer to v4l2 format structure
- * @which: wanted subdev format
- */
-static void vfe_try_format(struct vfe_line *line,
-			   struct v4l2_subdev_pad_config *cfg,
-			   unsigned int pad,
-			   struct v4l2_mbus_framefmt *fmt,
-			   enum v4l2_subdev_format_whence which)
-{
-	unsigned int i;
-	u32 code;
-
-	switch (pad) {
-	case MSM_VFE_PAD_SINK:
-		/* Set format on sink pad */
-
-		for (i = 0; i < ARRAY_SIZE(vfe_formats); i++)
-			if (fmt->code == vfe_formats[i].code)
-				break;
-
-		/* If not found, use UYVY as default */
-		if (i >= ARRAY_SIZE(vfe_formats))
-			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-
-		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
-		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
-
-		fmt->field = V4L2_FIELD_NONE;
-		fmt->colorspace = V4L2_COLORSPACE_SRGB;
-
-		break;
-
-	case MSM_VFE_PAD_SRC:
-		/* Set and return a format same as sink pad */
-
-		code = fmt->code;
-
-		*fmt = *__vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
-					 which);
-
-		if (line->id == VFE_LINE_PIX) {
-			struct v4l2_rect *rect;
-
-			rect = __vfe_get_crop(line, cfg, which);
-
-			fmt->width = rect->width;
-			fmt->height = rect->height;
-
-			switch (fmt->code) {
-			case MEDIA_BUS_FMT_YUYV8_2X8:
-				if (code == MEDIA_BUS_FMT_YUYV8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_YUYV8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_YUYV8_2X8;
-				break;
-			case MEDIA_BUS_FMT_YVYU8_2X8:
-				if (code == MEDIA_BUS_FMT_YVYU8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_YVYU8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_YVYU8_2X8;
-				break;
-			case MEDIA_BUS_FMT_UYVY8_2X8:
-			default:
-				if (code == MEDIA_BUS_FMT_UYVY8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_UYVY8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
-				break;
-			case MEDIA_BUS_FMT_VYUY8_2X8:
-				if (code == MEDIA_BUS_FMT_VYUY8_1_5X8)
-					fmt->code = MEDIA_BUS_FMT_VYUY8_1_5X8;
-				else
-					fmt->code = MEDIA_BUS_FMT_VYUY8_2X8;
-				break;
-			}
-		}
-
-		break;
-	}
-
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-}
-
-/*
- * vfe_try_compose - Handle try compose selection by pad subdev method
- * @line: VFE line
- * @cfg: V4L2 subdev pad configuration
- * @rect: pointer to v4l2 rect structure
- * @which: wanted subdev format
- */
-static void vfe_try_compose(struct vfe_line *line,
-			    struct v4l2_subdev_pad_config *cfg,
-			    struct v4l2_rect *rect,
-			    enum v4l2_subdev_format_whence which)
-{
-	struct v4l2_mbus_framefmt *fmt;
-
-	fmt = __vfe_get_format(line, cfg, MSM_VFE_PAD_SINK, which);
-
-	if (rect->width > fmt->width)
-		rect->width = fmt->width;
-
-	if (rect->height > fmt->height)
-		rect->height = fmt->height;
-
-	if (fmt->width > rect->width * SCALER_RATIO_MAX)
-		rect->width = (fmt->width + SCALER_RATIO_MAX - 1) /
-							SCALER_RATIO_MAX;
-
-	rect->width &= ~0x1;
-
-	if (fmt->height > rect->height * SCALER_RATIO_MAX)
-		rect->height = (fmt->height + SCALER_RATIO_MAX - 1) /
-							SCALER_RATIO_MAX;
-
-	if (rect->width < 16)
-		rect->width = 16;
-
-	if (rect->height < 4)
-		rect->height = 4;
-}
-
-/*
- * vfe_try_crop - Handle try crop selection by pad subdev method
- * @line: VFE line
- * @cfg: V4L2 subdev pad configuration
- * @rect: pointer to v4l2 rect structure
- * @which: wanted subdev format
- */
-static void vfe_try_crop(struct vfe_line *line,
-			 struct v4l2_subdev_pad_config *cfg,
-			 struct v4l2_rect *rect,
-			 enum v4l2_subdev_format_whence which)
-{
-	struct v4l2_rect *compose;
-
-	compose = __vfe_get_compose(line, cfg, which);
-
-	if (rect->width > compose->width)
-		rect->width = compose->width;
-
-	if (rect->width + rect->left > compose->width)
-		rect->left = compose->width - rect->width;
-
-	if (rect->height > compose->height)
-		rect->height = compose->height;
-
-	if (rect->height + rect->top > compose->height)
-		rect->top = compose->height - rect->height;
-
-	/* wm in line based mode writes multiple of 16 horizontally */
-	rect->left += (rect->width & 0xf) >> 1;
-	rect->width &= ~0xf;
-
-	if (rect->width < 16) {
-		rect->left = 0;
-		rect->width = 16;
-	}
-
-	if (rect->height < 4) {
-		rect->top = 0;
-		rect->height = 4;
-	}
-}
-
-/*
- * vfe_enum_mbus_code - Handle pixel format enumeration
- * @sd: VFE V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @code: pointer to v4l2_subdev_mbus_code_enum structure
- *
- * return -EINVAL or zero on success
- */
-static int vfe_enum_mbus_code(struct v4l2_subdev *sd,
-			      struct v4l2_subdev_pad_config *cfg,
-			      struct v4l2_subdev_mbus_code_enum *code)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	if (code->pad == MSM_VFE_PAD_SINK) {
-		if (code->index >= ARRAY_SIZE(vfe_formats))
-			return -EINVAL;
-
-		code->code = vfe_formats[code->index].code;
-	} else {
-		if (code->index > 0)
-			return -EINVAL;
-
-		format = __vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
-					  code->which);
-
-		code->code = format->code;
-	}
-
-	return 0;
-}
-
-/*
- * vfe_enum_frame_size - Handle frame size enumeration
- * @sd: VFE V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fse: pointer to v4l2_subdev_frame_size_enum structure
- *
- * Return -EINVAL or zero on success
- */
-static int vfe_enum_frame_size(struct v4l2_subdev *sd,
-			       struct v4l2_subdev_pad_config *cfg,
-			       struct v4l2_subdev_frame_size_enum *fse)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt format;
-
-	if (fse->index != 0)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = 1;
-	format.height = 1;
-	vfe_try_format(line, cfg, fse->pad, &format, fse->which);
-	fse->min_width = format.width;
-	fse->min_height = format.height;
-
-	if (format.code != fse->code)
-		return -EINVAL;
-
-	format.code = fse->code;
-	format.width = -1;
-	format.height = -1;
-	vfe_try_format(line, cfg, fse->pad, &format, fse->which);
-	fse->max_width = format.width;
-	fse->max_height = format.height;
-
-	return 0;
-}
-
-/*
- * vfe_get_format - Handle get format by pads subdev method
- * @sd: VFE V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int vfe_get_format(struct v4l2_subdev *sd,
-			  struct v4l2_subdev_pad_config *cfg,
-			  struct v4l2_subdev_format *fmt)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __vfe_get_format(line, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	fmt->format = *format;
-
-	return 0;
-}
-
-static int vfe_set_selection(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_pad_config *cfg,
-			     struct v4l2_subdev_selection *sel);
-
-/*
- * vfe_set_format - Handle set format by pads subdev method
- * @sd: VFE V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @fmt: pointer to v4l2 subdev format structure
- *
- * Return -EINVAL or zero on success
- */
-static int vfe_set_format(struct v4l2_subdev *sd,
-			  struct v4l2_subdev_pad_config *cfg,
-			  struct v4l2_subdev_format *fmt)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_mbus_framefmt *format;
-
-	format = __vfe_get_format(line, cfg, fmt->pad, fmt->which);
-	if (format == NULL)
-		return -EINVAL;
-
-	vfe_try_format(line, cfg, fmt->pad, &fmt->format, fmt->which);
-	*format = fmt->format;
-
-	if (fmt->pad == MSM_VFE_PAD_SINK) {
-		struct v4l2_subdev_selection sel = { 0 };
-		int ret;
-
-		/* Propagate the format from sink to source */
-		format = __vfe_get_format(line, cfg, MSM_VFE_PAD_SRC,
-					  fmt->which);
-
-		*format = fmt->format;
-		vfe_try_format(line, cfg, MSM_VFE_PAD_SRC, format,
-			       fmt->which);
-
-		if (line->id != VFE_LINE_PIX)
-			return 0;
-
-		/* Reset sink pad compose selection */
-		sel.which = fmt->which;
-		sel.pad = MSM_VFE_PAD_SINK;
-		sel.target = V4L2_SEL_TGT_COMPOSE;
-		sel.r.width = fmt->format.width;
-		sel.r.height = fmt->format.height;
-		ret = vfe_set_selection(sd, cfg, &sel);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-/*
- * vfe_get_selection - Handle get selection by pads subdev method
- * @sd: VFE V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @sel: pointer to v4l2 subdev selection structure
- *
- * Return -EINVAL or zero on success
- */
-static int vfe_get_selection(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_pad_config *cfg,
-			     struct v4l2_subdev_selection *sel)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_subdev_format fmt = { 0 };
-	struct v4l2_rect *rect;
-	int ret;
-
-	if (line->id != VFE_LINE_PIX)
-		return -EINVAL;
-
-	if (sel->pad == MSM_VFE_PAD_SINK)
-		switch (sel->target) {
-		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
-			fmt.pad = sel->pad;
-			fmt.which = sel->which;
-			ret = vfe_get_format(sd, cfg, &fmt);
-			if (ret < 0)
-				return ret;
-
-			sel->r.left = 0;
-			sel->r.top = 0;
-			sel->r.width = fmt.format.width;
-			sel->r.height = fmt.format.height;
-			break;
-		case V4L2_SEL_TGT_COMPOSE:
-			rect = __vfe_get_compose(line, cfg, sel->which);
-			if (rect == NULL)
-				return -EINVAL;
-
-			sel->r = *rect;
-			break;
-		default:
-			return -EINVAL;
-		}
-	else if (sel->pad == MSM_VFE_PAD_SRC)
-		switch (sel->target) {
-		case V4L2_SEL_TGT_CROP_BOUNDS:
-			rect = __vfe_get_compose(line, cfg, sel->which);
-			if (rect == NULL)
-				return -EINVAL;
-
-			sel->r.left = rect->left;
-			sel->r.top = rect->top;
-			sel->r.width = rect->width;
-			sel->r.height = rect->height;
-			break;
-		case V4L2_SEL_TGT_CROP:
-			rect = __vfe_get_crop(line, cfg, sel->which);
-			if (rect == NULL)
-				return -EINVAL;
-
-			sel->r = *rect;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-	return 0;
-}
-
-/*
- * vfe_set_selection - Handle set selection by pads subdev method
- * @sd: VFE V4L2 subdevice
- * @cfg: V4L2 subdev pad configuration
- * @sel: pointer to v4l2 subdev selection structure
- *
- * Return -EINVAL or zero on success
- */
-static int vfe_set_selection(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_pad_config *cfg,
-			     struct v4l2_subdev_selection *sel)
-{
-	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_rect *rect;
-	int ret;
-
-	if (line->id != VFE_LINE_PIX)
-		return -EINVAL;
-
-	if (sel->target == V4L2_SEL_TGT_COMPOSE &&
-		sel->pad == MSM_VFE_PAD_SINK) {
-		struct v4l2_subdev_selection crop = { 0 };
-
-		rect = __vfe_get_compose(line, cfg, sel->which);
-		if (rect == NULL)
-			return -EINVAL;
-
-		vfe_try_compose(line, cfg, &sel->r, sel->which);
-		*rect = sel->r;
-
-		/* Reset source crop selection */
-		crop.which = sel->which;
-		crop.pad = MSM_VFE_PAD_SRC;
-		crop.target = V4L2_SEL_TGT_CROP;
-		crop.r = *rect;
-		ret = vfe_set_selection(sd, cfg, &crop);
-	} else if (sel->target == V4L2_SEL_TGT_CROP &&
-		sel->pad == MSM_VFE_PAD_SRC) {
-		struct v4l2_subdev_format fmt = { 0 };
-
-		rect = __vfe_get_crop(line, cfg, sel->which);
-		if (rect == NULL)
-			return -EINVAL;
-
-		vfe_try_crop(line, cfg, &sel->r, sel->which);
-		*rect = sel->r;
-
-		/* Reset source pad format width and height */
-		fmt.which = sel->which;
-		fmt.pad = MSM_VFE_PAD_SRC;
-		ret = vfe_get_format(sd, cfg, &fmt);
-		if (ret < 0)
-			return ret;
-
-		fmt.format.width = rect->width;
-		fmt.format.height = rect->height;
-		ret = vfe_set_format(sd, cfg, &fmt);
-	} else {
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-/*
- * vfe_init_formats - Initialize formats on all pads
- * @sd: VFE V4L2 subdevice
- * @fh: V4L2 subdev file handle
- *
- * Initialize all pad formats with default values.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int vfe_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
-{
-	struct v4l2_subdev_format format = {
-		.pad = MSM_VFE_PAD_SINK,
-		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
-			      V4L2_SUBDEV_FORMAT_ACTIVE,
-		.format = {
-			.code = MEDIA_BUS_FMT_UYVY8_2X8,
-			.width = 1920,
-			.height = 1080
-		}
-	};
-
-	return vfe_set_format(sd, fh ? fh->pad : NULL, &format);
-}
-
-/*
- * msm_vfe_subdev_init - Initialize VFE device structure and resources
- * @vfe: VFE device
- * @res: VFE module resources table
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_vfe_subdev_init(struct vfe_device *vfe, const struct resources *res)
-{
-	struct device *dev = to_device(vfe);
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *r;
-	struct camss *camss = to_camss(vfe);
-	int i, j;
-	int ret;
-
-	/* Memory */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
-	vfe->base = devm_ioremap_resource(dev, r);
-	if (IS_ERR(vfe->base)) {
-		dev_err(dev, "could not map memory\n");
-		return PTR_ERR(vfe->base);
-	}
-
-	/* Interrupt */
-
-	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
-					 res->interrupt[0]);
-	if (!r) {
-		dev_err(dev, "missing IRQ\n");
-		return -EINVAL;
-	}
-
-	vfe->irq = r->start;
-	snprintf(vfe->irq_name, sizeof(vfe->irq_name), "%s_%s%d",
-		 dev_name(dev), MSM_VFE_NAME, vfe->id);
-	ret = devm_request_irq(dev, vfe->irq, vfe_isr,
-			       IRQF_TRIGGER_RISING, vfe->irq_name, vfe);
-	if (ret < 0) {
-		dev_err(dev, "request_irq failed: %d\n", ret);
-		return ret;
-	}
-
-	/* Clocks */
-
-	vfe->nclocks = 0;
-	while (res->clock[vfe->nclocks])
-		vfe->nclocks++;
-
-	vfe->clock = devm_kcalloc(dev, vfe->nclocks, sizeof(*vfe->clock),
-				  GFP_KERNEL);
-	if (!vfe->clock)
-		return -ENOMEM;
-
-	for (i = 0; i < vfe->nclocks; i++) {
-		struct camss_clock *clock = &vfe->clock[i];
-
-		clock->clk = devm_clk_get(dev, res->clock[i]);
-		if (IS_ERR(clock->clk))
-			return PTR_ERR(clock->clk);
-
-		clock->name = res->clock[i];
-
-		clock->nfreqs = 0;
-		while (res->clock_rate[i][clock->nfreqs])
-			clock->nfreqs++;
-
-		if (!clock->nfreqs) {
-			clock->freq = NULL;
-			continue;
-		}
-
-		clock->freq = devm_kcalloc(dev,
-					   clock->nfreqs,
-					   sizeof(*clock->freq),
-					   GFP_KERNEL);
-		if (!clock->freq)
-			return -ENOMEM;
-
-		for (j = 0; j < clock->nfreqs; j++)
-			clock->freq[j] = res->clock_rate[i][j];
-	}
-
-	mutex_init(&vfe->power_lock);
-	vfe->power_count = 0;
-
-	mutex_init(&vfe->stream_lock);
-	vfe->stream_count = 0;
-
-	spin_lock_init(&vfe->output_lock);
-
-	vfe->id = 0;
-	vfe->reg_update = 0;
-
-	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++) {
-		vfe->line[i].video_out.type =
-					V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-		vfe->line[i].video_out.camss = camss;
-		vfe->line[i].id = i;
-		init_completion(&vfe->line[i].output.sof);
-		init_completion(&vfe->line[i].output.reg_update);
-	}
-
-	init_completion(&vfe->reset_complete);
-	init_completion(&vfe->halt_complete);
-
-	return 0;
-}
-
-/*
- * msm_vfe_get_vfe_id - Get VFE HW module id
- * @entity: Pointer to VFE media entity structure
- * @id: Return CSID HW module id here
- */
-void msm_vfe_get_vfe_id(struct media_entity *entity, u8 *id)
-{
-	struct v4l2_subdev *sd;
-	struct vfe_line *line;
-	struct vfe_device *vfe;
-
-	sd = media_entity_to_v4l2_subdev(entity);
-	line = v4l2_get_subdevdata(sd);
-	vfe = to_vfe(line);
-
-	*id = vfe->id;
-}
-
-/*
- * msm_vfe_get_vfe_line_id - Get VFE line id by media entity
- * @entity: Pointer to VFE media entity structure
- * @id: Return VFE line id here
- */
-void msm_vfe_get_vfe_line_id(struct media_entity *entity, enum vfe_line_id *id)
-{
-	struct v4l2_subdev *sd;
-	struct vfe_line *line;
-
-	sd = media_entity_to_v4l2_subdev(entity);
-	line = v4l2_get_subdevdata(sd);
-
-	*id = line->id;
-}
-
-/*
- * vfe_link_setup - Setup VFE connections
- * @entity: Pointer to media entity structure
- * @local: Pointer to local pad
- * @remote: Pointer to remote pad
- * @flags: Link flags
- *
- * Return 0 on success
- */
-static int vfe_link_setup(struct media_entity *entity,
-			  const struct media_pad *local,
-			  const struct media_pad *remote, u32 flags)
-{
-	if (flags & MEDIA_LNK_FL_ENABLED)
-		if (media_entity_remote_pad(local))
-			return -EBUSY;
-
-	return 0;
-}
-
-static const struct v4l2_subdev_core_ops vfe_core_ops = {
-	.s_power = vfe_set_power,
-};
-
-static const struct v4l2_subdev_video_ops vfe_video_ops = {
-	.s_stream = vfe_set_stream,
-};
-
-static const struct v4l2_subdev_pad_ops vfe_pad_ops = {
-	.enum_mbus_code = vfe_enum_mbus_code,
-	.enum_frame_size = vfe_enum_frame_size,
-	.get_fmt = vfe_get_format,
-	.set_fmt = vfe_set_format,
-	.get_selection = vfe_get_selection,
-	.set_selection = vfe_set_selection,
-};
-
-static const struct v4l2_subdev_ops vfe_v4l2_ops = {
-	.core = &vfe_core_ops,
-	.video = &vfe_video_ops,
-	.pad = &vfe_pad_ops,
-};
-
-static const struct v4l2_subdev_internal_ops vfe_v4l2_internal_ops = {
-	.open = vfe_init_formats,
-};
-
-static const struct media_entity_operations vfe_media_ops = {
-	.link_setup = vfe_link_setup,
-	.link_validate = v4l2_subdev_link_validate,
-};
-
-static const struct camss_video_ops camss_vfe_video_ops = {
-	.queue_buffer = vfe_queue_buffer,
-	.flush_buffers = vfe_flush_buffers,
-};
-
-void msm_vfe_stop_streaming(struct vfe_device *vfe)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe->line); i++)
-		msm_video_stop_streaming(&vfe->line[i].video_out);
-}
-
-/*
- * msm_vfe_register_entities - Register subdev node for VFE module
- * @vfe: VFE device
- * @v4l2_dev: V4L2 device
- *
- * Initialize and register a subdev node for the VFE module. Then
- * call msm_video_register() to register the video device node which
- * will be connected to this subdev node. Then actually create the
- * media link between them.
- *
- * Return 0 on success or a negative error code otherwise
- */
-int msm_vfe_register_entities(struct vfe_device *vfe,
-			      struct v4l2_device *v4l2_dev)
-{
-	struct device *dev = to_device(vfe);
-	struct v4l2_subdev *sd;
-	struct media_pad *pads;
-	struct camss_video *video_out;
-	int ret;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(vfe->line); i++) {
-		char name[32];
-
-		sd = &vfe->line[i].subdev;
-		pads = vfe->line[i].pads;
-		video_out = &vfe->line[i].video_out;
-
-		v4l2_subdev_init(sd, &vfe_v4l2_ops);
-		sd->internal_ops = &vfe_v4l2_internal_ops;
-		sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-		if (i == VFE_LINE_PIX)
-			snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d_%s",
-				 MSM_VFE_NAME, vfe->id, "pix");
-		else
-			snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d_%s%d",
-				 MSM_VFE_NAME, vfe->id, "rdi", i);
-
-		v4l2_set_subdevdata(sd, &vfe->line[i]);
-
-		ret = vfe_init_formats(sd, NULL);
-		if (ret < 0) {
-			dev_err(dev, "Failed to init format: %d\n", ret);
-			goto error_init;
-		}
-
-		pads[MSM_VFE_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
-		pads[MSM_VFE_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
-
-		sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
-		sd->entity.ops = &vfe_media_ops;
-		ret = media_entity_pads_init(&sd->entity, MSM_VFE_PADS_NUM,
-					     pads);
-		if (ret < 0) {
-			dev_err(dev, "Failed to init media entity: %d\n", ret);
-			goto error_init;
-		}
-
-		ret = v4l2_device_register_subdev(v4l2_dev, sd);
-		if (ret < 0) {
-			dev_err(dev, "Failed to register subdev: %d\n", ret);
-			goto error_reg_subdev;
-		}
-
-		video_out->ops = &camss_vfe_video_ops;
-		video_out->bpl_alignment = 8;
-		video_out->line_based = 0;
-		if (i == VFE_LINE_PIX) {
-			video_out->bpl_alignment = 16;
-			video_out->line_based = 1;
-		}
-		snprintf(name, ARRAY_SIZE(name), "%s%d_%s%d",
-			 MSM_VFE_NAME, vfe->id, "video", i);
-		ret = msm_video_register(video_out, v4l2_dev, name,
-					 i == VFE_LINE_PIX ? 1 : 0);
-		if (ret < 0) {
-			dev_err(dev, "Failed to register video node: %d\n",
-				ret);
-			goto error_reg_video;
-		}
-
-		ret = media_create_pad_link(
-				&sd->entity, MSM_VFE_PAD_SRC,
-				&video_out->vdev.entity, 0,
-				MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
-		if (ret < 0) {
-			dev_err(dev, "Failed to link %s->%s entities: %d\n",
-				sd->entity.name, video_out->vdev.entity.name,
-				ret);
-			goto error_link;
-		}
-	}
-
-	return 0;
-
-error_link:
-	msm_video_unregister(video_out);
-
-error_reg_video:
-	v4l2_device_unregister_subdev(sd);
-
-error_reg_subdev:
-	media_entity_cleanup(&sd->entity);
-
-error_init:
-	for (i--; i >= 0; i--) {
-		sd = &vfe->line[i].subdev;
-		video_out = &vfe->line[i].video_out;
-
-		msm_video_unregister(video_out);
-		v4l2_device_unregister_subdev(sd);
-		media_entity_cleanup(&sd->entity);
-	}
-
-	return ret;
-}
-
-/*
- * msm_vfe_unregister_entities - Unregister VFE module subdev node
- * @vfe: VFE device
- */
-void msm_vfe_unregister_entities(struct vfe_device *vfe)
-{
-	int i;
-
-	mutex_destroy(&vfe->power_lock);
-	mutex_destroy(&vfe->stream_lock);
-
-	for (i = 0; i < ARRAY_SIZE(vfe->line); i++) {
-		struct v4l2_subdev *sd = &vfe->line[i].subdev;
-		struct camss_video *video_out = &vfe->line[i].video_out;
-
-		msm_video_unregister(video_out);
-		v4l2_device_unregister_subdev(sd);
-		media_entity_cleanup(&sd->entity);
-	}
-}
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-vfe.h b/drivers/media/platform/qcom/camss-8x16/camss-vfe.h
deleted file mode 100644
index 53d5b66..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-vfe.h
+++ /dev/null
@@ -1,123 +0,0 @@
-/*
- * camss-vfe.h
- *
- * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module
- *
- * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef QC_MSM_CAMSS_VFE_H
-#define QC_MSM_CAMSS_VFE_H
-
-#include <linux/clk.h>
-#include <linux/spinlock_types.h>
-#include <media/media-entity.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-
-#include "camss-video.h"
-
-#define MSM_VFE_PAD_SINK 0
-#define MSM_VFE_PAD_SRC 1
-#define MSM_VFE_PADS_NUM 2
-
-#define MSM_VFE_LINE_NUM 4
-#define MSM_VFE_IMAGE_MASTERS_NUM 7
-#define MSM_VFE_COMPOSITE_IRQ_NUM 4
-
-#define MSM_VFE_VFE0_UB_SIZE 1023
-#define MSM_VFE_VFE0_UB_SIZE_RDI (MSM_VFE_VFE0_UB_SIZE / 3)
-#define MSM_VFE_VFE1_UB_SIZE 1535
-#define MSM_VFE_VFE1_UB_SIZE_RDI (MSM_VFE_VFE1_UB_SIZE / 3)
-
-enum vfe_output_state {
-	VFE_OUTPUT_OFF,
-	VFE_OUTPUT_RESERVED,
-	VFE_OUTPUT_SINGLE,
-	VFE_OUTPUT_CONTINUOUS,
-	VFE_OUTPUT_IDLE,
-	VFE_OUTPUT_STOPPING
-};
-
-enum vfe_line_id {
-	VFE_LINE_NONE = -1,
-	VFE_LINE_RDI0 = 0,
-	VFE_LINE_RDI1 = 1,
-	VFE_LINE_RDI2 = 2,
-	VFE_LINE_PIX = 3
-};
-
-struct vfe_output {
-	u8 wm_num;
-	u8 wm_idx[3];
-
-	int active_buf;
-	struct camss_buffer *buf[2];
-	struct camss_buffer *last_buffer;
-	struct list_head pending_bufs;
-
-	unsigned int drop_update_idx;
-
-	enum vfe_output_state state;
-	unsigned int sequence;
-	int wait_sof;
-	int wait_reg_update;
-	struct completion sof;
-	struct completion reg_update;
-};
-
-struct vfe_line {
-	enum vfe_line_id id;
-	struct v4l2_subdev subdev;
-	struct media_pad pads[MSM_VFE_PADS_NUM];
-	struct v4l2_mbus_framefmt fmt[MSM_VFE_PADS_NUM];
-	struct v4l2_rect compose;
-	struct v4l2_rect crop;
-	struct camss_video video_out;
-	struct vfe_output output;
-};
-
-struct vfe_device {
-	u8 id;
-	void __iomem *base;
-	u32 irq;
-	char irq_name[30];
-	struct camss_clock *clock;
-	int nclocks;
-	struct completion reset_complete;
-	struct completion halt_complete;
-	struct mutex power_lock;
-	int power_count;
-	struct mutex stream_lock;
-	int stream_count;
-	spinlock_t output_lock;
-	enum vfe_line_id wm_output_map[MSM_VFE_IMAGE_MASTERS_NUM];
-	struct vfe_line line[MSM_VFE_LINE_NUM];
-	u32 reg_update;
-	u8 was_streaming;
-};
-
-struct resources;
-
-int msm_vfe_subdev_init(struct vfe_device *vfe, const struct resources *res);
-
-int msm_vfe_register_entities(struct vfe_device *vfe,
-			      struct v4l2_device *v4l2_dev);
-
-void msm_vfe_unregister_entities(struct vfe_device *vfe);
-
-void msm_vfe_get_vfe_id(struct media_entity *entity, u8 *id);
-void msm_vfe_get_vfe_line_id(struct media_entity *entity, enum vfe_line_id *id);
-
-void msm_vfe_stop_streaming(struct vfe_device *vfe);
-
-#endif /* QC_MSM_CAMSS_VFE_H */
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-video.c b/drivers/media/platform/qcom/camss-8x16/camss-video.c
deleted file mode 100644
index ffaa284..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-video.c
+++ /dev/null
@@ -1,859 +0,0 @@
-/*
- * camss-video.c
- *
- * Qualcomm MSM Camera Subsystem - V4L2 device node
- *
- * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/slab.h>
-#include <media/media-entity.h>
-#include <media/v4l2-dev.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-ioctl.h>
-#include <media/v4l2-mc.h>
-#include <media/videobuf2-dma-sg.h>
-
-#include "camss-video.h"
-#include "camss.h"
-
-struct fract {
-	u8 numerator;
-	u8 denominator;
-};
-
-/*
- * struct camss_format_info - ISP media bus format information
- * @code: V4L2 media bus format code
- * @pixelformat: V4L2 pixel format FCC identifier
- * @planes: Number of planes
- * @hsub: Horizontal subsampling (for each plane)
- * @vsub: Vertical subsampling (for each plane)
- * @bpp: Bits per pixel when stored in memory (for each plane)
- */
-struct camss_format_info {
-	u32 code;
-	u32 pixelformat;
-	u8 planes;
-	struct fract hsub[3];
-	struct fract vsub[3];
-	unsigned int bpp[3];
-};
-
-static const struct camss_format_info formats_rdi[] = {
-	{ MEDIA_BUS_FMT_UYVY8_2X8, V4L2_PIX_FMT_UYVY, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
-	{ MEDIA_BUS_FMT_VYUY8_2X8, V4L2_PIX_FMT_VYUY, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
-	{ MEDIA_BUS_FMT_YUYV8_2X8, V4L2_PIX_FMT_YUYV, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
-	{ MEDIA_BUS_FMT_YVYU8_2X8, V4L2_PIX_FMT_YVYU, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
-	{ MEDIA_BUS_FMT_SBGGR8_1X8, V4L2_PIX_FMT_SBGGR8, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
-	{ MEDIA_BUS_FMT_SGBRG8_1X8, V4L2_PIX_FMT_SGBRG8, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
-	{ MEDIA_BUS_FMT_SGRBG8_1X8, V4L2_PIX_FMT_SGRBG8, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
-	{ MEDIA_BUS_FMT_SRGGB8_1X8, V4L2_PIX_FMT_SRGGB8, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
-	{ MEDIA_BUS_FMT_SBGGR10_1X10, V4L2_PIX_FMT_SBGGR10P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
-	{ MEDIA_BUS_FMT_SGBRG10_1X10, V4L2_PIX_FMT_SGBRG10P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
-	{ MEDIA_BUS_FMT_SGRBG10_1X10, V4L2_PIX_FMT_SGRBG10P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
-	{ MEDIA_BUS_FMT_SRGGB10_1X10, V4L2_PIX_FMT_SRGGB10P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
-	{ MEDIA_BUS_FMT_SBGGR12_1X12, V4L2_PIX_FMT_SBGGR12P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
-	{ MEDIA_BUS_FMT_SGBRG12_1X12, V4L2_PIX_FMT_SGBRG12P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
-	{ MEDIA_BUS_FMT_SGRBG12_1X12, V4L2_PIX_FMT_SGRBG12P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
-	{ MEDIA_BUS_FMT_SRGGB12_1X12, V4L2_PIX_FMT_SRGGB12P, 1,
-	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
-};
-
-static const struct camss_format_info formats_pix[] = {
-	{ MEDIA_BUS_FMT_YUYV8_1_5X8, V4L2_PIX_FMT_NV12, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YVYU8_1_5X8, V4L2_PIX_FMT_NV12, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_UYVY8_1_5X8, V4L2_PIX_FMT_NV12, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_VYUY8_1_5X8, V4L2_PIX_FMT_NV12, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YUYV8_1_5X8, V4L2_PIX_FMT_NV21, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YVYU8_1_5X8, V4L2_PIX_FMT_NV21, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_UYVY8_1_5X8, V4L2_PIX_FMT_NV21, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_VYUY8_1_5X8, V4L2_PIX_FMT_NV21, 1,
-	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YUYV8_2X8, V4L2_PIX_FMT_NV16, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YVYU8_2X8, V4L2_PIX_FMT_NV16, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_UYVY8_2X8, V4L2_PIX_FMT_NV16, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_VYUY8_2X8, V4L2_PIX_FMT_NV16, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YUYV8_2X8, V4L2_PIX_FMT_NV61, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_YVYU8_2X8, V4L2_PIX_FMT_NV61, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_UYVY8_2X8, V4L2_PIX_FMT_NV61, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-	{ MEDIA_BUS_FMT_VYUY8_2X8, V4L2_PIX_FMT_NV61, 1,
-	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
-};
-
-/* -----------------------------------------------------------------------------
- * Helper functions
- */
-
-static int video_find_format(u32 code, u32 pixelformat,
-			     const struct camss_format_info *formats,
-			     unsigned int nformats)
-{
-	int i;
-
-	for (i = 0; i < nformats; i++) {
-		if (formats[i].code == code &&
-		    formats[i].pixelformat == pixelformat)
-			return i;
-	}
-
-	for (i = 0; i < nformats; i++)
-		if (formats[i].code == code)
-			return i;
-
-	WARN_ON(1);
-
-	return -EINVAL;
-}
-
-/*
- * video_mbus_to_pix_mp - Convert v4l2_mbus_framefmt to v4l2_pix_format_mplane
- * @mbus: v4l2_mbus_framefmt format (input)
- * @pix: v4l2_pix_format_mplane format (output)
- * @f: a pointer to formats array element to be used for the conversion
- * @alignment: bytesperline alignment value
- *
- * Fill the output pix structure with information from the input mbus format.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int video_mbus_to_pix_mp(const struct v4l2_mbus_framefmt *mbus,
-				struct v4l2_pix_format_mplane *pix,
-				const struct camss_format_info *f,
-				unsigned int alignment)
-{
-	unsigned int i;
-	u32 bytesperline;
-
-	memset(pix, 0, sizeof(*pix));
-	v4l2_fill_pix_format_mplane(pix, mbus);
-	pix->pixelformat = f->pixelformat;
-	pix->num_planes = f->planes;
-	for (i = 0; i < pix->num_planes; i++) {
-		bytesperline = pix->width / f->hsub[i].numerator *
-			f->hsub[i].denominator * f->bpp[i] / 8;
-		bytesperline = ALIGN(bytesperline, alignment);
-		pix->plane_fmt[i].bytesperline = bytesperline;
-		pix->plane_fmt[i].sizeimage = pix->height /
-				f->vsub[i].numerator * f->vsub[i].denominator *
-				bytesperline;
-	}
-
-	return 0;
-}
-
-static struct v4l2_subdev *video_remote_subdev(struct camss_video *video,
-					       u32 *pad)
-{
-	struct media_pad *remote;
-
-	remote = media_entity_remote_pad(&video->pad);
-
-	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
-		return NULL;
-
-	if (pad)
-		*pad = remote->index;
-
-	return media_entity_to_v4l2_subdev(remote->entity);
-}
-
-static int video_get_subdev_format(struct camss_video *video,
-				   struct v4l2_format *format)
-{
-	struct v4l2_subdev_format fmt;
-	struct v4l2_subdev *subdev;
-	u32 pad;
-	int ret;
-
-	subdev = video_remote_subdev(video, &pad);
-	if (subdev == NULL)
-		return -EPIPE;
-
-	fmt.pad = pad;
-	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
-
-	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
-	if (ret)
-		return ret;
-
-	ret = video_find_format(fmt.format.code,
-				format->fmt.pix_mp.pixelformat,
-				video->formats, video->nformats);
-	if (ret < 0)
-		return ret;
-
-	format->type = video->type;
-
-	return video_mbus_to_pix_mp(&fmt.format, &format->fmt.pix_mp,
-				    &video->formats[ret], video->bpl_alignment);
-}
-
-/* -----------------------------------------------------------------------------
- * Video queue operations
- */
-
-static int video_queue_setup(struct vb2_queue *q,
-	unsigned int *num_buffers, unsigned int *num_planes,
-	unsigned int sizes[], struct device *alloc_devs[])
-{
-	struct camss_video *video = vb2_get_drv_priv(q);
-	const struct v4l2_pix_format_mplane *format =
-						&video->active_fmt.fmt.pix_mp;
-	unsigned int i;
-
-	if (*num_planes) {
-		if (*num_planes != format->num_planes)
-			return -EINVAL;
-
-		for (i = 0; i < *num_planes; i++)
-			if (sizes[i] < format->plane_fmt[i].sizeimage)
-				return -EINVAL;
-
-		return 0;
-	}
-
-	*num_planes = format->num_planes;
-
-	for (i = 0; i < *num_planes; i++)
-		sizes[i] = format->plane_fmt[i].sizeimage;
-
-	return 0;
-}
-
-static int video_buf_init(struct vb2_buffer *vb)
-{
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct camss_video *video = vb2_get_drv_priv(vb->vb2_queue);
-	struct camss_buffer *buffer = container_of(vbuf, struct camss_buffer,
-						   vb);
-	const struct v4l2_pix_format_mplane *format =
-						&video->active_fmt.fmt.pix_mp;
-	struct sg_table *sgt;
-	unsigned int i;
-
-	for (i = 0; i < format->num_planes; i++) {
-		sgt = vb2_dma_sg_plane_desc(vb, i);
-		if (!sgt)
-			return -EFAULT;
-
-		buffer->addr[i] = sg_dma_address(sgt->sgl);
-	}
-
-	if (format->pixelformat == V4L2_PIX_FMT_NV12 ||
-			format->pixelformat == V4L2_PIX_FMT_NV21 ||
-			format->pixelformat == V4L2_PIX_FMT_NV16 ||
-			format->pixelformat == V4L2_PIX_FMT_NV61)
-		buffer->addr[1] = buffer->addr[0] +
-				format->plane_fmt[0].bytesperline *
-				format->height;
-
-	return 0;
-}
-
-static int video_buf_prepare(struct vb2_buffer *vb)
-{
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct camss_video *video = vb2_get_drv_priv(vb->vb2_queue);
-	const struct v4l2_pix_format_mplane *format =
-						&video->active_fmt.fmt.pix_mp;
-	unsigned int i;
-
-	for (i = 0; i < format->num_planes; i++) {
-		if (format->plane_fmt[i].sizeimage > vb2_plane_size(vb, i))
-			return -EINVAL;
-
-		vb2_set_plane_payload(vb, i, format->plane_fmt[i].sizeimage);
-	}
-
-	vbuf->field = V4L2_FIELD_NONE;
-
-	return 0;
-}
-
-static void video_buf_queue(struct vb2_buffer *vb)
-{
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct camss_video *video = vb2_get_drv_priv(vb->vb2_queue);
-	struct camss_buffer *buffer = container_of(vbuf, struct camss_buffer,
-						   vb);
-
-	video->ops->queue_buffer(video, buffer);
-}
-
-static int video_check_format(struct camss_video *video)
-{
-	struct v4l2_pix_format_mplane *pix = &video->active_fmt.fmt.pix_mp;
-	struct v4l2_format format;
-	struct v4l2_pix_format_mplane *sd_pix = &format.fmt.pix_mp;
-	int ret;
-
-	sd_pix->pixelformat = pix->pixelformat;
-	ret = video_get_subdev_format(video, &format);
-	if (ret < 0)
-		return ret;
-
-	if (pix->pixelformat != sd_pix->pixelformat ||
-	    pix->height != sd_pix->height ||
-	    pix->width != sd_pix->width ||
-	    pix->num_planes != sd_pix->num_planes ||
-	    pix->field != format.fmt.pix_mp.field)
-		return -EPIPE;
-
-	return 0;
-}
-
-static int video_start_streaming(struct vb2_queue *q, unsigned int count)
-{
-	struct camss_video *video = vb2_get_drv_priv(q);
-	struct video_device *vdev = &video->vdev;
-	struct media_entity *entity;
-	struct media_pad *pad;
-	struct v4l2_subdev *subdev;
-	int ret;
-
-	ret = media_pipeline_start(&vdev->entity, &video->pipe);
-	if (ret < 0)
-		return ret;
-
-	ret = video_check_format(video);
-	if (ret < 0)
-		goto error;
-
-	entity = &vdev->entity;
-	while (1) {
-		pad = &entity->pads[0];
-		if (!(pad->flags & MEDIA_PAD_FL_SINK))
-			break;
-
-		pad = media_entity_remote_pad(pad);
-		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
-			break;
-
-		entity = pad->entity;
-		subdev = media_entity_to_v4l2_subdev(entity);
-
-		ret = v4l2_subdev_call(subdev, video, s_stream, 1);
-		if (ret < 0 && ret != -ENOIOCTLCMD)
-			goto error;
-	}
-
-	return 0;
-
-error:
-	media_pipeline_stop(&vdev->entity);
-
-	video->ops->flush_buffers(video, VB2_BUF_STATE_QUEUED);
-
-	return ret;
-}
-
-static void video_stop_streaming(struct vb2_queue *q)
-{
-	struct camss_video *video = vb2_get_drv_priv(q);
-	struct video_device *vdev = &video->vdev;
-	struct media_entity *entity;
-	struct media_pad *pad;
-	struct v4l2_subdev *subdev;
-
-	entity = &vdev->entity;
-	while (1) {
-		pad = &entity->pads[0];
-		if (!(pad->flags & MEDIA_PAD_FL_SINK))
-			break;
-
-		pad = media_entity_remote_pad(pad);
-		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
-			break;
-
-		entity = pad->entity;
-		subdev = media_entity_to_v4l2_subdev(entity);
-
-		v4l2_subdev_call(subdev, video, s_stream, 0);
-	}
-
-	media_pipeline_stop(&vdev->entity);
-
-	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
-}
-
-static const struct vb2_ops msm_video_vb2_q_ops = {
-	.queue_setup     = video_queue_setup,
-	.wait_prepare    = vb2_ops_wait_prepare,
-	.wait_finish     = vb2_ops_wait_finish,
-	.buf_init        = video_buf_init,
-	.buf_prepare     = video_buf_prepare,
-	.buf_queue       = video_buf_queue,
-	.start_streaming = video_start_streaming,
-	.stop_streaming  = video_stop_streaming,
-};
-
-/* -----------------------------------------------------------------------------
- * V4L2 ioctls
- */
-
-static int video_querycap(struct file *file, void *fh,
-			  struct v4l2_capability *cap)
-{
-	struct camss_video *video = video_drvdata(file);
-
-	strlcpy(cap->driver, "qcom-camss", sizeof(cap->driver));
-	strlcpy(cap->card, "Qualcomm Camera Subsystem", sizeof(cap->card));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
-		 dev_name(video->camss->dev));
-
-	return 0;
-}
-
-static int video_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
-{
-	struct camss_video *video = video_drvdata(file);
-	int i, j, k;
-
-	if (f->type != video->type)
-		return -EINVAL;
-
-	if (f->index >= video->nformats)
-		return -EINVAL;
-
-	/* find index "i" of "k"th unique pixelformat in formats array */
-	k = -1;
-	for (i = 0; i < video->nformats; i++) {
-		for (j = 0; j < i; j++) {
-			if (video->formats[i].pixelformat ==
-					video->formats[j].pixelformat)
-				break;
-		}
-
-		if (j == i)
-			k++;
-
-		if (k == f->index)
-			break;
-	}
-
-	if (k < f->index)
-		return -EINVAL;
-
-	f->pixelformat = video->formats[i].pixelformat;
-
-	return 0;
-}
-
-static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
-{
-	struct camss_video *video = video_drvdata(file);
-
-	*f = video->active_fmt;
-
-	return 0;
-}
-
-static int __video_try_fmt(struct camss_video *video, struct v4l2_format *f)
-{
-	struct v4l2_pix_format_mplane *pix_mp;
-	const struct camss_format_info *fi;
-	struct v4l2_plane_pix_format *p;
-	u32 bytesperline[3] = { 0 };
-	u32 sizeimage[3] = { 0 };
-	u32 width, height;
-	u32 bpl, lines;
-	int i, j;
-
-	pix_mp = &f->fmt.pix_mp;
-
-	if (video->line_based)
-		for (i = 0; i < pix_mp->num_planes && i < 3; i++) {
-			p = &pix_mp->plane_fmt[i];
-			bytesperline[i] = clamp_t(u32, p->bytesperline,
-						  1, 65528);
-			sizeimage[i] = clamp_t(u32, p->sizeimage,
-					       bytesperline[i],
-					       bytesperline[i] * 4096);
-		}
-
-	for (j = 0; j < video->nformats; j++)
-		if (pix_mp->pixelformat == video->formats[j].pixelformat)
-			break;
-
-	if (j == video->nformats)
-		j = 0; /* default format */
-
-	fi = &video->formats[j];
-	width = pix_mp->width;
-	height = pix_mp->height;
-
-	memset(pix_mp, 0, sizeof(*pix_mp));
-
-	pix_mp->pixelformat = fi->pixelformat;
-	pix_mp->width = clamp_t(u32, width, 1, 8191);
-	pix_mp->height = clamp_t(u32, height, 1, 8191);
-	pix_mp->num_planes = fi->planes;
-	for (i = 0; i < pix_mp->num_planes; i++) {
-		bpl = pix_mp->width / fi->hsub[i].numerator *
-			fi->hsub[i].denominator * fi->bpp[i] / 8;
-		bpl = ALIGN(bpl, video->bpl_alignment);
-		pix_mp->plane_fmt[i].bytesperline = bpl;
-		pix_mp->plane_fmt[i].sizeimage = pix_mp->height /
-			fi->vsub[i].numerator * fi->vsub[i].denominator * bpl;
-	}
-
-	pix_mp->field = V4L2_FIELD_NONE;
-	pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
-	pix_mp->flags = 0;
-	pix_mp->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(pix_mp->colorspace);
-	pix_mp->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
-					pix_mp->colorspace, pix_mp->ycbcr_enc);
-	pix_mp->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix_mp->colorspace);
-
-	if (video->line_based)
-		for (i = 0; i < pix_mp->num_planes; i++) {
-			p = &pix_mp->plane_fmt[i];
-			p->bytesperline = clamp_t(u32, p->bytesperline,
-						  1, 65528);
-			p->sizeimage = clamp_t(u32, p->sizeimage,
-					       p->bytesperline,
-					       p->bytesperline * 4096);
-			lines = p->sizeimage / p->bytesperline;
-
-			if (p->bytesperline < bytesperline[i])
-				p->bytesperline = ALIGN(bytesperline[i], 8);
-
-			if (p->sizeimage < p->bytesperline * lines)
-				p->sizeimage = p->bytesperline * lines;
-
-			if (p->sizeimage < sizeimage[i])
-				p->sizeimage = sizeimage[i];
-		}
-
-	return 0;
-}
-
-static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
-{
-	struct camss_video *video = video_drvdata(file);
-
-	return __video_try_fmt(video, f);
-}
-
-static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
-{
-	struct camss_video *video = video_drvdata(file);
-	int ret;
-
-	if (vb2_is_busy(&video->vb2_q))
-		return -EBUSY;
-
-	ret = __video_try_fmt(video, f);
-	if (ret < 0)
-		return ret;
-
-	video->active_fmt = *f;
-
-	return 0;
-}
-
-static int video_enum_input(struct file *file, void *fh,
-			    struct v4l2_input *input)
-{
-	if (input->index > 0)
-		return -EINVAL;
-
-	strlcpy(input->name, "camera", sizeof(input->name));
-	input->type = V4L2_INPUT_TYPE_CAMERA;
-
-	return 0;
-}
-
-static int video_g_input(struct file *file, void *fh, unsigned int *input)
-{
-	*input = 0;
-
-	return 0;
-}
-
-static int video_s_input(struct file *file, void *fh, unsigned int input)
-{
-	return input == 0 ? 0 : -EINVAL;
-}
-
-static const struct v4l2_ioctl_ops msm_vid_ioctl_ops = {
-	.vidioc_querycap		= video_querycap,
-	.vidioc_enum_fmt_vid_cap_mplane	= video_enum_fmt,
-	.vidioc_g_fmt_vid_cap_mplane	= video_g_fmt,
-	.vidioc_s_fmt_vid_cap_mplane	= video_s_fmt,
-	.vidioc_try_fmt_vid_cap_mplane	= video_try_fmt,
-	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
-	.vidioc_querybuf		= vb2_ioctl_querybuf,
-	.vidioc_qbuf			= vb2_ioctl_qbuf,
-	.vidioc_expbuf			= vb2_ioctl_expbuf,
-	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
-	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
-	.vidioc_streamon		= vb2_ioctl_streamon,
-	.vidioc_streamoff		= vb2_ioctl_streamoff,
-	.vidioc_enum_input		= video_enum_input,
-	.vidioc_g_input			= video_g_input,
-	.vidioc_s_input			= video_s_input,
-};
-
-/* -----------------------------------------------------------------------------
- * V4L2 file operations
- */
-
-static int video_open(struct file *file)
-{
-	struct video_device *vdev = video_devdata(file);
-	struct camss_video *video = video_drvdata(file);
-	struct v4l2_fh *vfh;
-	int ret;
-
-	mutex_lock(&video->lock);
-
-	vfh = kzalloc(sizeof(*vfh), GFP_KERNEL);
-	if (vfh == NULL) {
-		ret = -ENOMEM;
-		goto error_alloc;
-	}
-
-	v4l2_fh_init(vfh, vdev);
-	v4l2_fh_add(vfh);
-
-	file->private_data = vfh;
-
-	ret = v4l2_pipeline_pm_use(&vdev->entity, 1);
-	if (ret < 0) {
-		dev_err(video->camss->dev, "Failed to power up pipeline: %d\n",
-			ret);
-		goto error_pm_use;
-	}
-
-	mutex_unlock(&video->lock);
-
-	return 0;
-
-error_pm_use:
-	v4l2_fh_release(file);
-
-error_alloc:
-	mutex_unlock(&video->lock);
-
-	return ret;
-}
-
-static int video_release(struct file *file)
-{
-	struct video_device *vdev = video_devdata(file);
-
-	vb2_fop_release(file);
-
-	v4l2_pipeline_pm_use(&vdev->entity, 0);
-
-	file->private_data = NULL;
-
-	return 0;
-}
-
-static const struct v4l2_file_operations msm_vid_fops = {
-	.owner          = THIS_MODULE,
-	.unlocked_ioctl = video_ioctl2,
-	.open           = video_open,
-	.release        = video_release,
-	.poll           = vb2_fop_poll,
-	.mmap		= vb2_fop_mmap,
-	.read		= vb2_fop_read,
-};
-
-/* -----------------------------------------------------------------------------
- * CAMSS video core
- */
-
-static void msm_video_release(struct video_device *vdev)
-{
-	struct camss_video *video = video_get_drvdata(vdev);
-
-	media_entity_cleanup(&vdev->entity);
-
-	mutex_destroy(&video->q_lock);
-	mutex_destroy(&video->lock);
-
-	if (atomic_dec_and_test(&video->camss->ref_count))
-		camss_delete(video->camss);
-}
-
-/*
- * msm_video_init_format - Helper function to initialize format
- * @video: struct camss_video
- *
- * Initialize pad format with default value.
- *
- * Return 0 on success or a negative error code otherwise
- */
-static int msm_video_init_format(struct camss_video *video)
-{
-	int ret;
-	struct v4l2_format format = {
-		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
-		.fmt.pix_mp = {
-			.width = 1920,
-			.height = 1080,
-			.pixelformat = video->formats[0].pixelformat,
-		},
-	};
-
-	ret = __video_try_fmt(video, &format);
-	if (ret < 0)
-		return ret;
-
-	video->active_fmt = format;
-
-	return 0;
-}
-
-/*
- * msm_video_register - Register a video device node
- * @video: struct camss_video
- * @v4l2_dev: V4L2 device
- * @name: name to be used for the video device node
- *
- * Initialize and register a video device node to a V4L2 device. Also
- * initialize the vb2 queue.
- *
- * Return 0 on success or a negative error code otherwise
- */
-
-int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
-		       const char *name, int is_pix)
-{
-	struct media_pad *pad = &video->pad;
-	struct video_device *vdev;
-	struct vb2_queue *q;
-	int ret;
-
-	vdev = &video->vdev;
-
-	mutex_init(&video->q_lock);
-
-	q = &video->vb2_q;
-	q->drv_priv = video;
-	q->mem_ops = &vb2_dma_sg_memops;
-	q->ops = &msm_video_vb2_q_ops;
-	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	q->io_modes = VB2_DMABUF | VB2_MMAP | VB2_READ;
-	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->buf_struct_size = sizeof(struct camss_buffer);
-	q->dev = video->camss->dev;
-	q->lock = &video->q_lock;
-	ret = vb2_queue_init(q);
-	if (ret < 0) {
-		dev_err(v4l2_dev->dev, "Failed to init vb2 queue: %d\n", ret);
-		goto error_vb2_init;
-	}
-
-	pad->flags = MEDIA_PAD_FL_SINK;
-	ret = media_entity_pads_init(&vdev->entity, 1, pad);
-	if (ret < 0) {
-		dev_err(v4l2_dev->dev, "Failed to init video entity: %d\n",
-			ret);
-		goto error_media_init;
-	}
-
-	mutex_init(&video->lock);
-
-	video->formats = formats_rdi;
-	video->nformats = ARRAY_SIZE(formats_rdi);
-	if (is_pix) {
-		video->formats = formats_pix;
-		video->nformats = ARRAY_SIZE(formats_pix);
-	}
-
-	ret = msm_video_init_format(video);
-	if (ret < 0) {
-		dev_err(v4l2_dev->dev, "Failed to init format: %d\n", ret);
-		goto error_video_register;
-	}
-
-	vdev->fops = &msm_vid_fops;
-	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING |
-							V4L2_CAP_READWRITE;
-	vdev->ioctl_ops = &msm_vid_ioctl_ops;
-	vdev->release = msm_video_release;
-	vdev->v4l2_dev = v4l2_dev;
-	vdev->vfl_dir = VFL_DIR_RX;
-	vdev->queue = &video->vb2_q;
-	vdev->lock = &video->lock;
-	strlcpy(vdev->name, name, sizeof(vdev->name));
-
-	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
-	if (ret < 0) {
-		dev_err(v4l2_dev->dev, "Failed to register video device: %d\n",
-			ret);
-		goto error_video_register;
-	}
-
-	video_set_drvdata(vdev, video);
-	atomic_inc(&video->camss->ref_count);
-
-	return 0;
-
-error_video_register:
-	media_entity_cleanup(&vdev->entity);
-	mutex_destroy(&video->lock);
-error_media_init:
-	vb2_queue_release(&video->vb2_q);
-error_vb2_init:
-	mutex_destroy(&video->q_lock);
-
-	return ret;
-}
-
-void msm_video_stop_streaming(struct camss_video *video)
-{
-	if (vb2_is_streaming(&video->vb2_q))
-		vb2_queue_release(&video->vb2_q);
-}
-
-void msm_video_unregister(struct camss_video *video)
-{
-	atomic_inc(&video->camss->ref_count);
-	video_unregister_device(&video->vdev);
-	atomic_dec(&video->camss->ref_count);
-}
diff --git a/drivers/media/platform/qcom/camss-8x16/camss-video.h b/drivers/media/platform/qcom/camss-8x16/camss-video.h
deleted file mode 100644
index 38bd1f2..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss-video.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/*
- * camss-video.h
- *
- * Qualcomm MSM Camera Subsystem - V4L2 device node
- *
- * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef QC_MSM_CAMSS_VIDEO_H
-#define QC_MSM_CAMSS_VIDEO_H
-
-#include <linux/mutex.h>
-#include <linux/videodev2.h>
-#include <media/media-entity.h>
-#include <media/v4l2-dev.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-fh.h>
-#include <media/v4l2-mediabus.h>
-#include <media/videobuf2-v4l2.h>
-
-struct camss_buffer {
-	struct vb2_v4l2_buffer vb;
-	dma_addr_t addr[3];
-	struct list_head queue;
-};
-
-struct camss_video;
-
-struct camss_video_ops {
-	int (*queue_buffer)(struct camss_video *vid, struct camss_buffer *buf);
-	int (*flush_buffers)(struct camss_video *vid,
-			     enum vb2_buffer_state state);
-};
-
-struct camss_format_info;
-
-struct camss_video {
-	struct camss *camss;
-	struct vb2_queue vb2_q;
-	struct video_device vdev;
-	struct media_pad pad;
-	struct v4l2_format active_fmt;
-	enum v4l2_buf_type type;
-	struct media_pipeline pipe;
-	const struct camss_video_ops *ops;
-	struct mutex lock;
-	struct mutex q_lock;
-	unsigned int bpl_alignment;
-	unsigned int line_based;
-	const struct camss_format_info *formats;
-	unsigned int nformats;
-};
-
-void msm_video_stop_streaming(struct camss_video *video);
-
-int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
-		       const char *name, int is_pix);
-
-void msm_video_unregister(struct camss_video *video);
-
-#endif /* QC_MSM_CAMSS_VIDEO_H */
diff --git a/drivers/media/platform/qcom/camss-8x16/camss.c b/drivers/media/platform/qcom/camss-8x16/camss.c
deleted file mode 100644
index 23fda62..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss.c
+++ /dev/null
@@ -1,751 +0,0 @@
-/*
- * camss.c
- *
- * Qualcomm MSM Camera Subsystem - Core
- *
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/clk.h>
-#include <linux/media-bus-format.h>
-#include <linux/media.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_graph.h>
-#include <linux/slab.h>
-#include <linux/videodev2.h>
-
-#include <media/media-device.h>
-#include <media/v4l2-async.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-mc.h>
-#include <media/v4l2-fwnode.h>
-
-#include "camss.h"
-
-#define CAMSS_CLOCK_MARGIN_NUMERATOR 105
-#define CAMSS_CLOCK_MARGIN_DENOMINATOR 100
-
-static const struct resources csiphy_res[] = {
-	/* CSIPHY0 */
-	{
-		.regulator = { NULL },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "camss_ahb", "csiphy0_timer" },
-		.clock_rate = { { 0 },
-				{ 0 },
-				{ 0 },
-				{ 100000000, 200000000 } },
-		.reg = { "csiphy0", "csiphy0_clk_mux" },
-		.interrupt = { "csiphy0" }
-	},
-
-	/* CSIPHY1 */
-	{
-		.regulator = { NULL },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "camss_ahb", "csiphy1_timer" },
-		.clock_rate = { { 0 },
-				{ 0 },
-				{ 0 },
-				{ 100000000, 200000000 } },
-		.reg = { "csiphy1", "csiphy1_clk_mux" },
-		.interrupt = { "csiphy1" }
-	}
-};
-
-static const struct resources csid_res[] = {
-	/* CSID0 */
-	{
-		.regulator = { "vdda" },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "csi0_ahb", "camss_ahb",
-			   "csi0", "csi0_phy", "csi0_pix", "csi0_rdi" },
-		.clock_rate = { { 0 },
-				{ 0 },
-				{ 0 },
-				{ 0 },
-				{ 100000000, 200000000 },
-				{ 0 },
-				{ 0 },
-				{ 0 } },
-		.reg = { "csid0" },
-		.interrupt = { "csid0" }
-	},
-
-	/* CSID1 */
-	{
-		.regulator = { "vdda" },
-		.clock = { "camss_top_ahb", "ispif_ahb",
-			   "csi1_ahb", "camss_ahb",
-			   "csi1", "csi1_phy", "csi1_pix", "csi1_rdi" },
-		.clock_rate = { { 0 },
-				{ 0 },
-				{ 0 },
-				{ 0 },
-				{ 100000000, 200000000 },
-				{ 0 },
-				{ 0 },
-				{ 0 } },
-		.reg = { "csid1" },
-		.interrupt = { "csid1" }
-	},
-};
-
-static const struct resources_ispif ispif_res = {
-	/* ISPIF */
-	.clock = { "camss_top_ahb", "camss_ahb", "ispif_ahb",
-		   "csi0", "csi0_pix", "csi0_rdi",
-		   "csi1", "csi1_pix", "csi1_rdi" },
-	.clock_for_reset = { "camss_vfe_vfe", "camss_csi_vfe" },
-	.reg = { "ispif", "csi_clk_mux" },
-	.interrupt = "ispif"
-
-};
-
-static const struct resources vfe_res = {
-	/* VFE0 */
-	.regulator = { NULL },
-	.clock = { "camss_top_ahb", "camss_vfe_vfe", "camss_csi_vfe",
-		   "iface", "bus", "camss_ahb" },
-	.clock_rate = { { 0 },
-			{ 50000000, 80000000, 100000000, 160000000,
-			  177780000, 200000000, 266670000, 320000000,
-			  400000000, 465000000 },
-			{ 0 },
-			{ 0 },
-			{ 0 },
-			{ 0 },
-			{ 0 },
-			{ 0 },
-			{ 0 } },
-	.reg = { "vfe0" },
-	.interrupt = { "vfe0" }
-};
-
-/*
- * camss_add_clock_margin - Add margin to clock frequency rate
- * @rate: Clock frequency rate
- *
- * When making calculations with physical clock frequency values
- * some safety margin must be added. Add it.
- */
-inline void camss_add_clock_margin(u64 *rate)
-{
-	*rate *= CAMSS_CLOCK_MARGIN_NUMERATOR;
-	*rate = div_u64(*rate, CAMSS_CLOCK_MARGIN_DENOMINATOR);
-}
-
-/*
- * camss_enable_clocks - Enable multiple clocks
- * @nclocks: Number of clocks in clock array
- * @clock: Clock array
- * @dev: Device
- *
- * Return 0 on success or a negative error code otherwise
- */
-int camss_enable_clocks(int nclocks, struct camss_clock *clock,
-			struct device *dev)
-{
-	int ret;
-	int i;
-
-	for (i = 0; i < nclocks; i++) {
-		ret = clk_prepare_enable(clock[i].clk);
-		if (ret) {
-			dev_err(dev, "clock enable failed: %d\n", ret);
-			goto error;
-		}
-	}
-
-	return 0;
-
-error:
-	for (i--; i >= 0; i--)
-		clk_disable_unprepare(clock[i].clk);
-
-	return ret;
-}
-
-/*
- * camss_disable_clocks - Disable multiple clocks
- * @nclocks: Number of clocks in clock array
- * @clock: Clock array
- */
-void camss_disable_clocks(int nclocks, struct camss_clock *clock)
-{
-	int i;
-
-	for (i = nclocks - 1; i >= 0; i--)
-		clk_disable_unprepare(clock[i].clk);
-}
-
-/*
- * camss_find_sensor - Find a linked media entity which represents a sensor
- * @entity: Media entity to start searching from
- *
- * Return a pointer to sensor media entity or NULL if not found
- */
-static struct media_entity *camss_find_sensor(struct media_entity *entity)
-{
-	struct media_pad *pad;
-
-	while (1) {
-		pad = &entity->pads[0];
-		if (!(pad->flags & MEDIA_PAD_FL_SINK))
-			return NULL;
-
-		pad = media_entity_remote_pad(pad);
-		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
-			return NULL;
-
-		entity = pad->entity;
-
-		if (entity->function == MEDIA_ENT_F_CAM_SENSOR)
-			return entity;
-	}
-}
-
-/*
- * camss_get_pixel_clock - Get pixel clock rate from sensor
- * @entity: Media entity in the current pipeline
- * @pixel_clock: Received pixel clock value
- *
- * Return 0 on success or a negative error code otherwise
- */
-int camss_get_pixel_clock(struct media_entity *entity, u32 *pixel_clock)
-{
-	struct media_entity *sensor;
-	struct v4l2_subdev *subdev;
-	struct v4l2_ctrl *ctrl;
-
-	sensor = camss_find_sensor(entity);
-	if (!sensor)
-		return -ENODEV;
-
-	subdev = media_entity_to_v4l2_subdev(sensor);
-
-	ctrl = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
-
-	if (!ctrl)
-		return -EINVAL;
-
-	*pixel_clock = v4l2_ctrl_g_ctrl_int64(ctrl);
-
-	return 0;
-}
-
-/*
- * camss_of_parse_endpoint_node - Parse port endpoint node
- * @dev: Device
- * @node: Device node to be parsed
- * @csd: Parsed data from port endpoint node
- *
- * Return 0 on success or a negative error code on failure
- */
-static int camss_of_parse_endpoint_node(struct device *dev,
-					struct device_node *node,
-					struct camss_async_subdev *csd)
-{
-	struct csiphy_lanes_cfg *lncfg = &csd->interface.csi2.lane_cfg;
-	struct v4l2_fwnode_bus_mipi_csi2 *mipi_csi2;
-	struct v4l2_fwnode_endpoint vep = { { 0 } };
-	unsigned int i;
-
-	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
-
-	csd->interface.csiphy_id = vep.base.port;
-
-	mipi_csi2 = &vep.bus.mipi_csi2;
-	lncfg->clk.pos = mipi_csi2->clock_lane;
-	lncfg->clk.pol = mipi_csi2->lane_polarities[0];
-	lncfg->num_data = mipi_csi2->num_data_lanes;
-
-	lncfg->data = devm_kcalloc(dev,
-				   lncfg->num_data, sizeof(*lncfg->data),
-				   GFP_KERNEL);
-	if (!lncfg->data)
-		return -ENOMEM;
-
-	for (i = 0; i < lncfg->num_data; i++) {
-		lncfg->data[i].pos = mipi_csi2->data_lanes[i];
-		lncfg->data[i].pol = mipi_csi2->lane_polarities[i + 1];
-	}
-
-	return 0;
-}
-
-/*
- * camss_of_parse_ports - Parse ports node
- * @dev: Device
- * @notifier: v4l2_device notifier data
- *
- * Return number of "port" nodes found in "ports" node
- */
-static int camss_of_parse_ports(struct device *dev,
-				struct v4l2_async_notifier *notifier)
-{
-	struct device_node *node = NULL;
-	struct device_node *remote = NULL;
-	unsigned int size, i;
-	int ret;
-
-	while ((node = of_graph_get_next_endpoint(dev->of_node, node)))
-		if (of_device_is_available(node))
-			notifier->num_subdevs++;
-
-	size = sizeof(*notifier->subdevs) * notifier->num_subdevs;
-	notifier->subdevs = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (!notifier->subdevs) {
-		dev_err(dev, "Failed to allocate memory\n");
-		return -ENOMEM;
-	}
-
-	i = 0;
-	while ((node = of_graph_get_next_endpoint(dev->of_node, node))) {
-		struct camss_async_subdev *csd;
-
-		if (!of_device_is_available(node))
-			continue;
-
-		csd = devm_kzalloc(dev, sizeof(*csd), GFP_KERNEL);
-		if (!csd) {
-			of_node_put(node);
-			dev_err(dev, "Failed to allocate memory\n");
-			return -ENOMEM;
-		}
-
-		notifier->subdevs[i++] = &csd->asd;
-
-		ret = camss_of_parse_endpoint_node(dev, node, csd);
-		if (ret < 0) {
-			of_node_put(node);
-			return ret;
-		}
-
-		remote = of_graph_get_remote_port_parent(node);
-		of_node_put(node);
-
-		if (!remote) {
-			dev_err(dev, "Cannot get remote parent\n");
-			return -EINVAL;
-		}
-
-		csd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
-		csd->asd.match.fwnode = of_fwnode_handle(remote);
-	}
-
-	return notifier->num_subdevs;
-}
-
-/*
- * camss_init_subdevices - Initialize subdev structures and resources
- * @camss: CAMSS device
- *
- * Return 0 on success or a negative error code on failure
- */
-static int camss_init_subdevices(struct camss *camss)
-{
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++) {
-		ret = msm_csiphy_subdev_init(&camss->csiphy[i],
-					     &csiphy_res[i], i);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to init csiphy%d sub-device: %d\n",
-				i, ret);
-			return ret;
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(camss->csid); i++) {
-		ret = msm_csid_subdev_init(&camss->csid[i],
-					   &csid_res[i], i);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to init csid%d sub-device: %d\n",
-				i, ret);
-			return ret;
-		}
-	}
-
-	ret = msm_ispif_subdev_init(&camss->ispif, &ispif_res);
-	if (ret < 0) {
-		dev_err(camss->dev, "Failed to init ispif sub-device: %d\n",
-			ret);
-		return ret;
-	}
-
-	ret = msm_vfe_subdev_init(&camss->vfe, &vfe_res);
-	if (ret < 0) {
-		dev_err(camss->dev, "Fail to init vfe sub-device: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-/*
- * camss_register_entities - Register subdev nodes and create links
- * @camss: CAMSS device
- *
- * Return 0 on success or a negative error code on failure
- */
-static int camss_register_entities(struct camss *camss)
-{
-	int i, j;
-	int ret;
-
-	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++) {
-		ret = msm_csiphy_register_entity(&camss->csiphy[i],
-						 &camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register csiphy%d entity: %d\n",
-				i, ret);
-			goto err_reg_csiphy;
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(camss->csid); i++) {
-		ret = msm_csid_register_entity(&camss->csid[i],
-					       &camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(camss->dev,
-				"Failed to register csid%d entity: %d\n",
-				i, ret);
-			goto err_reg_csid;
-		}
-	}
-
-	ret = msm_ispif_register_entities(&camss->ispif, &camss->v4l2_dev);
-	if (ret < 0) {
-		dev_err(camss->dev, "Failed to register ispif entities: %d\n",
-			ret);
-		goto err_reg_ispif;
-	}
-
-	ret = msm_vfe_register_entities(&camss->vfe, &camss->v4l2_dev);
-	if (ret < 0) {
-		dev_err(camss->dev, "Failed to register vfe entities: %d\n",
-			ret);
-		goto err_reg_vfe;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++) {
-		for (j = 0; j < ARRAY_SIZE(camss->csid); j++) {
-			ret = media_create_pad_link(
-				&camss->csiphy[i].subdev.entity,
-				MSM_CSIPHY_PAD_SRC,
-				&camss->csid[j].subdev.entity,
-				MSM_CSID_PAD_SINK,
-				0);
-			if (ret < 0) {
-				dev_err(camss->dev,
-					"Failed to link %s->%s entities: %d\n",
-					camss->csiphy[i].subdev.entity.name,
-					camss->csid[j].subdev.entity.name,
-					ret);
-				goto err_link;
-			}
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(camss->csid); i++) {
-		for (j = 0; j < ARRAY_SIZE(camss->ispif.line); j++) {
-			ret = media_create_pad_link(
-				&camss->csid[i].subdev.entity,
-				MSM_CSID_PAD_SRC,
-				&camss->ispif.line[j].subdev.entity,
-				MSM_ISPIF_PAD_SINK,
-				0);
-			if (ret < 0) {
-				dev_err(camss->dev,
-					"Failed to link %s->%s entities: %d\n",
-					camss->csid[i].subdev.entity.name,
-					camss->ispif.line[j].subdev.entity.name,
-					ret);
-				goto err_link;
-			}
-		}
-	}
-
-	for (i = 0; i < ARRAY_SIZE(camss->ispif.line); i++) {
-		for (j = 0; j < ARRAY_SIZE(camss->vfe.line); j++) {
-			ret = media_create_pad_link(
-				&camss->ispif.line[i].subdev.entity,
-				MSM_ISPIF_PAD_SRC,
-				&camss->vfe.line[j].subdev.entity,
-				MSM_VFE_PAD_SINK,
-				0);
-			if (ret < 0) {
-				dev_err(camss->dev,
-					"Failed to link %s->%s entities: %d\n",
-					camss->ispif.line[i].subdev.entity.name,
-					camss->vfe.line[j].subdev.entity.name,
-					ret);
-				goto err_link;
-			}
-		}
-	}
-
-	return 0;
-
-err_link:
-	msm_vfe_unregister_entities(&camss->vfe);
-err_reg_vfe:
-	msm_ispif_unregister_entities(&camss->ispif);
-err_reg_ispif:
-
-	i = ARRAY_SIZE(camss->csid);
-err_reg_csid:
-	for (i--; i >= 0; i--)
-		msm_csid_unregister_entity(&camss->csid[i]);
-
-	i = ARRAY_SIZE(camss->csiphy);
-err_reg_csiphy:
-	for (i--; i >= 0; i--)
-		msm_csiphy_unregister_entity(&camss->csiphy[i]);
-
-	return ret;
-}
-
-/*
- * camss_unregister_entities - Unregister subdev nodes
- * @camss: CAMSS device
- *
- * Return 0 on success or a negative error code on failure
- */
-static void camss_unregister_entities(struct camss *camss)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++)
-		msm_csiphy_unregister_entity(&camss->csiphy[i]);
-
-	for (i = 0; i < ARRAY_SIZE(camss->csid); i++)
-		msm_csid_unregister_entity(&camss->csid[i]);
-
-	msm_ispif_unregister_entities(&camss->ispif);
-	msm_vfe_unregister_entities(&camss->vfe);
-}
-
-static int camss_subdev_notifier_bound(struct v4l2_async_notifier *async,
-				       struct v4l2_subdev *subdev,
-				       struct v4l2_async_subdev *asd)
-{
-	struct camss *camss = container_of(async, struct camss, notifier);
-	struct camss_async_subdev *csd =
-		container_of(asd, struct camss_async_subdev, asd);
-	u8 id = csd->interface.csiphy_id;
-	struct csiphy_device *csiphy = &camss->csiphy[id];
-
-	csiphy->cfg.csi2 = &csd->interface.csi2;
-	subdev->host_priv = csiphy;
-
-	return 0;
-}
-
-static int camss_subdev_notifier_complete(struct v4l2_async_notifier *async)
-{
-	struct camss *camss = container_of(async, struct camss, notifier);
-	struct v4l2_device *v4l2_dev = &camss->v4l2_dev;
-	struct v4l2_subdev *sd;
-	int ret;
-
-	list_for_each_entry(sd, &v4l2_dev->subdevs, list) {
-		if (sd->host_priv) {
-			struct media_entity *sensor = &sd->entity;
-			struct csiphy_device *csiphy =
-					(struct csiphy_device *) sd->host_priv;
-			struct media_entity *input = &csiphy->subdev.entity;
-			unsigned int i;
-
-			for (i = 0; i < sensor->num_pads; i++) {
-				if (sensor->pads[i].flags & MEDIA_PAD_FL_SOURCE)
-					break;
-			}
-			if (i == sensor->num_pads) {
-				dev_err(camss->dev,
-					"No source pad in external entity\n");
-				return -EINVAL;
-			}
-
-			ret = media_create_pad_link(sensor, i,
-				input, MSM_CSIPHY_PAD_SINK,
-				MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
-			if (ret < 0) {
-				dev_err(camss->dev,
-					"Failed to link %s->%s entities: %d\n",
-					sensor->name, input->name, ret);
-				return ret;
-			}
-		}
-	}
-
-	ret = v4l2_device_register_subdev_nodes(&camss->v4l2_dev);
-	if (ret < 0)
-		return ret;
-
-	return media_device_register(&camss->media_dev);
-}
-
-static const struct v4l2_async_notifier_operations camss_subdev_notifier_ops = {
-	.bound = camss_subdev_notifier_bound,
-	.complete = camss_subdev_notifier_complete,
-};
-
-static const struct media_device_ops camss_media_ops = {
-	.link_notify = v4l2_pipeline_link_notify,
-};
-
-/*
- * camss_probe - Probe CAMSS platform device
- * @pdev: Pointer to CAMSS platform device
- *
- * Return 0 on success or a negative error code on failure
- */
-static int camss_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct camss *camss;
-	int ret;
-
-	camss = kzalloc(sizeof(*camss), GFP_KERNEL);
-	if (!camss)
-		return -ENOMEM;
-
-	atomic_set(&camss->ref_count, 0);
-	camss->dev = dev;
-	platform_set_drvdata(pdev, camss);
-
-	ret = camss_of_parse_ports(dev, &camss->notifier);
-	if (ret < 0)
-		return ret;
-
-	ret = camss_init_subdevices(camss);
-	if (ret < 0)
-		return ret;
-
-	ret = dma_set_mask_and_coherent(dev, 0xffffffff);
-	if (ret)
-		return ret;
-
-	camss->media_dev.dev = camss->dev;
-	strlcpy(camss->media_dev.model, "Qualcomm Camera Subsystem",
-		sizeof(camss->media_dev.model));
-	camss->media_dev.ops = &camss_media_ops;
-	media_device_init(&camss->media_dev);
-
-	camss->v4l2_dev.mdev = &camss->media_dev;
-	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		return ret;
-	}
-
-	ret = camss_register_entities(camss);
-	if (ret < 0)
-		goto err_register_entities;
-
-	if (camss->notifier.num_subdevs) {
-		camss->notifier.ops = &camss_subdev_notifier_ops;
-
-		ret = v4l2_async_notifier_register(&camss->v4l2_dev,
-						   &camss->notifier);
-		if (ret) {
-			dev_err(dev,
-				"Failed to register async subdev nodes: %d\n",
-				ret);
-			goto err_register_subdevs;
-		}
-	} else {
-		ret = v4l2_device_register_subdev_nodes(&camss->v4l2_dev);
-		if (ret < 0) {
-			dev_err(dev, "Failed to register subdev nodes: %d\n",
-				ret);
-			goto err_register_subdevs;
-		}
-
-		ret = media_device_register(&camss->media_dev);
-		if (ret < 0) {
-			dev_err(dev, "Failed to register media device: %d\n",
-				ret);
-			goto err_register_subdevs;
-		}
-	}
-
-	return 0;
-
-err_register_subdevs:
-	camss_unregister_entities(camss);
-err_register_entities:
-	v4l2_device_unregister(&camss->v4l2_dev);
-
-	return ret;
-}
-
-void camss_delete(struct camss *camss)
-{
-	v4l2_device_unregister(&camss->v4l2_dev);
-	media_device_unregister(&camss->media_dev);
-	media_device_cleanup(&camss->media_dev);
-
-	kfree(camss);
-}
-
-/*
- * camss_remove - Remove CAMSS platform device
- * @pdev: Pointer to CAMSS platform device
- *
- * Always returns 0.
- */
-static int camss_remove(struct platform_device *pdev)
-{
-	struct camss *camss = platform_get_drvdata(pdev);
-
-	msm_vfe_stop_streaming(&camss->vfe);
-
-	v4l2_async_notifier_unregister(&camss->notifier);
-	camss_unregister_entities(camss);
-
-	if (atomic_read(&camss->ref_count) == 0)
-		camss_delete(camss);
-
-	return 0;
-}
-
-static const struct of_device_id camss_dt_match[] = {
-	{ .compatible = "qcom,msm8916-camss" },
-	{ }
-};
-
-MODULE_DEVICE_TABLE(of, camss_dt_match);
-
-static struct platform_driver qcom_camss_driver = {
-	.probe = camss_probe,
-	.remove = camss_remove,
-	.driver = {
-		.name = "qcom-camss",
-		.of_match_table = camss_dt_match,
-	},
-};
-
-module_platform_driver(qcom_camss_driver);
-
-MODULE_ALIAS("platform:qcom-camss");
-MODULE_DESCRIPTION("Qualcomm Camera Subsystem driver");
-MODULE_AUTHOR("Todor Tomov <todor.tomov@linaro.org>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/qcom/camss-8x16/camss.h b/drivers/media/platform/qcom/camss-8x16/camss.h
deleted file mode 100644
index 4ad2234..0000000
--- a/drivers/media/platform/qcom/camss-8x16/camss.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * camss.h
- *
- * Qualcomm MSM Camera Subsystem - Core
- *
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- * Copyright (C) 2015-2017 Linaro Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef QC_MSM_CAMSS_H
-#define QC_MSM_CAMSS_H
-
-#include <linux/types.h>
-#include <media/v4l2-async.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-subdev.h>
-#include <media/media-device.h>
-#include <media/media-entity.h>
-#include <linux/device.h>
-
-#include "camss-csid.h"
-#include "camss-csiphy.h"
-#include "camss-ispif.h"
-#include "camss-vfe.h"
-
-#define CAMSS_CSID_NUM 2
-#define CAMSS_CSIPHY_NUM 2
-
-#define to_camss(ptr_module)	\
-	container_of(ptr_module, struct camss, ptr_module)
-
-#define to_device(ptr_module)	\
-	(to_camss(ptr_module)->dev)
-
-#define module_pointer(ptr_module, index)	\
-	((const struct ptr_module##_device (*)[]) &(ptr_module[-(index)]))
-
-#define to_camss_index(ptr_module, index)	\
-	container_of(module_pointer(ptr_module, index),	\
-		     struct camss, ptr_module)
-
-#define to_device_index(ptr_module, index)	\
-	(to_camss_index(ptr_module, index)->dev)
-
-#define CAMSS_RES_MAX 15
-
-struct resources {
-	char *regulator[CAMSS_RES_MAX];
-	char *clock[CAMSS_RES_MAX];
-	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
-	char *reg[CAMSS_RES_MAX];
-	char *interrupt[CAMSS_RES_MAX];
-};
-
-struct resources_ispif {
-	char *clock[CAMSS_RES_MAX];
-	char *clock_for_reset[CAMSS_RES_MAX];
-	char *reg[CAMSS_RES_MAX];
-	char *interrupt;
-};
-
-struct camss {
-	struct v4l2_device v4l2_dev;
-	struct v4l2_async_notifier notifier;
-	struct media_device media_dev;
-	struct device *dev;
-	struct csiphy_device csiphy[CAMSS_CSIPHY_NUM];
-	struct csid_device csid[CAMSS_CSID_NUM];
-	struct ispif_device ispif;
-	struct vfe_device vfe;
-	atomic_t ref_count;
-};
-
-struct camss_camera_interface {
-	u8 csiphy_id;
-	struct csiphy_csi2_cfg csi2;
-};
-
-struct camss_async_subdev {
-	struct camss_camera_interface interface;
-	struct v4l2_async_subdev asd;
-};
-
-struct camss_clock {
-	struct clk *clk;
-	const char *name;
-	u32 *freq;
-	u32 nfreqs;
-};
-
-void camss_add_clock_margin(u64 *rate);
-int camss_enable_clocks(int nclocks, struct camss_clock *clock,
-			struct device *dev);
-void camss_disable_clocks(int nclocks, struct camss_clock *clock);
-int camss_get_pixel_clock(struct media_entity *entity, u32 *pixel_clock);
-void camss_delete(struct camss *camss);
-
-#endif /* QC_MSM_CAMSS_H */
diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
new file mode 100644
index 0000000..3c4024f
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -0,0 +1,11 @@
+# Makefile for Qualcomm CAMSS driver
+
+qcom-camss-objs += \
+		camss.o \
+		camss-csid.o \
+		camss-csiphy.o \
+		camss-ispif.o \
+		camss-vfe.o \
+		camss-video.o \
+
+obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
new file mode 100644
index 0000000..39ea27b
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -0,0 +1,1094 @@
+/*
+ * camss-csid.c
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
+ *
+ * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+#include "camss-csid.h"
+#include "camss.h"
+
+#define MSM_CSID_NAME "msm_csid"
+
+#define CAMSS_CSID_HW_VERSION		0x0
+#define CAMSS_CSID_CORE_CTRL_0		0x004
+#define CAMSS_CSID_CORE_CTRL_1		0x008
+#define CAMSS_CSID_RST_CMD		0x00c
+#define CAMSS_CSID_CID_LUT_VC_n(n)	(0x010 + 0x4 * (n))
+#define CAMSS_CSID_CID_n_CFG(n)		(0x020 + 0x4 * (n))
+#define CAMSS_CSID_IRQ_CLEAR_CMD	0x060
+#define CAMSS_CSID_IRQ_MASK		0x064
+#define CAMSS_CSID_IRQ_STATUS		0x068
+#define CAMSS_CSID_TG_CTRL		0x0a0
+#define CAMSS_CSID_TG_CTRL_DISABLE	0xa06436
+#define CAMSS_CSID_TG_CTRL_ENABLE	0xa06437
+#define CAMSS_CSID_TG_VC_CFG		0x0a4
+#define CAMSS_CSID_TG_VC_CFG_H_BLANKING		0x3ff
+#define CAMSS_CSID_TG_VC_CFG_V_BLANKING		0x7f
+#define CAMSS_CSID_TG_DT_n_CGG_0(n)	(0x0ac + 0xc * (n))
+#define CAMSS_CSID_TG_DT_n_CGG_1(n)	(0x0b0 + 0xc * (n))
+#define CAMSS_CSID_TG_DT_n_CGG_2(n)	(0x0b4 + 0xc * (n))
+
+#define DATA_TYPE_EMBEDDED_DATA_8BIT	0x12
+#define DATA_TYPE_YUV422_8BIT		0x1e
+#define DATA_TYPE_RAW_6BIT		0x28
+#define DATA_TYPE_RAW_8BIT		0x2a
+#define DATA_TYPE_RAW_10BIT		0x2b
+#define DATA_TYPE_RAW_12BIT		0x2c
+
+#define DECODE_FORMAT_UNCOMPRESSED_6_BIT	0x0
+#define DECODE_FORMAT_UNCOMPRESSED_8_BIT	0x1
+#define DECODE_FORMAT_UNCOMPRESSED_10_BIT	0x2
+#define DECODE_FORMAT_UNCOMPRESSED_12_BIT	0x3
+
+#define CSID_RESET_TIMEOUT_MS 500
+
+struct csid_fmts {
+	u32 code;
+	u8 data_type;
+	u8 decode_format;
+	u8 bpp;
+	u8 spp; /* bus samples per pixel */
+};
+
+static const struct csid_fmts csid_input_fmts[] = {
+	{
+		MEDIA_BUS_FMT_UYVY8_2X8,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_VYUY8_2X8,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_YUYV8_2X8,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_YVYU8_2X8,
+		DATA_TYPE_YUV422_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		2,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB8_1X8,
+		DATA_TYPE_RAW_8BIT,
+		DECODE_FORMAT_UNCOMPRESSED_8_BIT,
+		8,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB10_1X10,
+		DATA_TYPE_RAW_10BIT,
+		DECODE_FORMAT_UNCOMPRESSED_10_BIT,
+		10,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB12_1X12,
+		DATA_TYPE_RAW_12BIT,
+		DECODE_FORMAT_UNCOMPRESSED_12_BIT,
+		12,
+		1,
+	}
+};
+
+static const struct csid_fmts *csid_get_fmt_entry(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(csid_input_fmts); i++)
+		if (code == csid_input_fmts[i].code)
+			return &csid_input_fmts[i];
+
+	WARN(1, "Unknown format\n");
+
+	return &csid_input_fmts[0];
+}
+
+/*
+ * csid_isr - CSID module interrupt handler
+ * @irq: Interrupt line
+ * @dev: CSID device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t csid_isr(int irq, void *dev)
+{
+	struct csid_device *csid = dev;
+	u32 value;
+
+	value = readl_relaxed(csid->base + CAMSS_CSID_IRQ_STATUS);
+	writel_relaxed(value, csid->base + CAMSS_CSID_IRQ_CLEAR_CMD);
+
+	if ((value >> 11) & 0x1)
+		complete(&csid->reset_complete);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * csid_set_clock_rates - Calculate and set clock rates on CSID module
+ * @csiphy: CSID device
+ */
+static int csid_set_clock_rates(struct csid_device *csid)
+{
+	struct device *dev = to_device_index(csid, csid->id);
+	u32 pixel_clock;
+	int i, j;
+	int ret;
+
+	ret = camss_get_pixel_clock(&csid->subdev.entity, &pixel_clock);
+	if (ret)
+		pixel_clock = 0;
+
+	for (i = 0; i < csid->nclocks; i++) {
+		struct camss_clock *clock = &csid->clock[i];
+
+		if (!strcmp(clock->name, "csi0") ||
+			!strcmp(clock->name, "csi1")) {
+			u8 bpp = csid_get_fmt_entry(
+				csid->fmt[MSM_CSIPHY_PAD_SINK].code)->bpp;
+			u8 num_lanes = csid->phy.lane_cnt;
+			u64 min_rate = pixel_clock * bpp / (2 * num_lanes * 4);
+			long rate;
+
+			camss_add_clock_margin(&min_rate);
+
+			for (j = 0; j < clock->nfreqs; j++)
+				if (min_rate < clock->freq[j])
+					break;
+
+			if (j == clock->nfreqs) {
+				dev_err(dev,
+					"Pixel clock is too high for CSID\n");
+				return -EINVAL;
+			}
+
+			/* if sensor pixel clock is not available */
+			/* set highest possible CSID clock rate */
+			if (min_rate == 0)
+				j = clock->nfreqs - 1;
+
+			rate = clk_round_rate(clock->clk, clock->freq[j]);
+			if (rate < 0) {
+				dev_err(dev, "clk round rate failed: %ld\n",
+					rate);
+				return -EINVAL;
+			}
+
+			ret = clk_set_rate(clock->clk, rate);
+			if (ret < 0) {
+				dev_err(dev, "clk set rate failed: %d\n", ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * csid_reset - Trigger reset on CSID module and wait to complete
+ * @csid: CSID device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_reset(struct csid_device *csid)
+{
+	unsigned long time;
+
+	reinit_completion(&csid->reset_complete);
+
+	writel_relaxed(0x7fff, csid->base + CAMSS_CSID_RST_CMD);
+
+	time = wait_for_completion_timeout(&csid->reset_complete,
+		msecs_to_jiffies(CSID_RESET_TIMEOUT_MS));
+	if (!time) {
+		dev_err(to_device_index(csid, csid->id),
+			"CSID reset timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * csid_set_power - Power on/off CSID module
+ * @sd: CSID V4L2 subdevice
+ * @on: Requested power state
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+	struct device *dev = to_device_index(csid, csid->id);
+	int ret;
+
+	if (on) {
+		u32 hw_version;
+
+		ret = regulator_enable(csid->vdda);
+		if (ret < 0)
+			return ret;
+
+		ret = csid_set_clock_rates(csid);
+		if (ret < 0) {
+			regulator_disable(csid->vdda);
+			return ret;
+		}
+
+		ret = camss_enable_clocks(csid->nclocks, csid->clock, dev);
+		if (ret < 0) {
+			regulator_disable(csid->vdda);
+			return ret;
+		}
+
+		enable_irq(csid->irq);
+
+		ret = csid_reset(csid);
+		if (ret < 0) {
+			disable_irq(csid->irq);
+			camss_disable_clocks(csid->nclocks, csid->clock);
+			regulator_disable(csid->vdda);
+			return ret;
+		}
+
+		hw_version = readl_relaxed(csid->base + CAMSS_CSID_HW_VERSION);
+		dev_dbg(dev, "CSID HW Version = 0x%08x\n", hw_version);
+	} else {
+		disable_irq(csid->irq);
+		camss_disable_clocks(csid->nclocks, csid->clock);
+		ret = regulator_disable(csid->vdda);
+	}
+
+	return ret;
+}
+
+/*
+ * csid_set_stream - Enable/disable streaming on CSID module
+ * @sd: CSID V4L2 subdevice
+ * @enable: Requested streaming state
+ *
+ * Main configuration of CSID module is also done here.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+	struct csid_testgen_config *tg = &csid->testgen;
+	u32 val;
+
+	if (enable) {
+		u8 vc = 0; /* Virtual Channel 0 */
+		u8 cid = vc * 4; /* id of Virtual Channel and Data Type set */
+		u8 dt, dt_shift, df;
+		int ret;
+
+		ret = v4l2_ctrl_handler_setup(&csid->ctrls);
+		if (ret < 0) {
+			dev_err(to_device_index(csid, csid->id),
+				"could not sync v4l2 controls: %d\n", ret);
+			return ret;
+		}
+
+		if (!tg->enabled &&
+		    !media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
+			return -ENOLINK;
+
+		dt = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SRC].code)->
+								data_type;
+
+		if (tg->enabled) {
+			/* Config Test Generator */
+			struct v4l2_mbus_framefmt *f =
+					&csid->fmt[MSM_CSID_PAD_SRC];
+			u8 bpp = csid_get_fmt_entry(f->code)->bpp;
+			u8 spp = csid_get_fmt_entry(f->code)->spp;
+			u32 num_bytes_per_line = f->width * bpp * spp / 8;
+			u32 num_lines = f->height;
+
+			/* 31:24 V blank, 23:13 H blank, 3:2 num of active DT */
+			/* 1:0 VC */
+			val = ((CAMSS_CSID_TG_VC_CFG_V_BLANKING & 0xff) << 24) |
+			      ((CAMSS_CSID_TG_VC_CFG_H_BLANKING & 0x7ff) << 13);
+			writel_relaxed(val, csid->base + CAMSS_CSID_TG_VC_CFG);
+
+			/* 28:16 bytes per lines, 12:0 num of lines */
+			val = ((num_bytes_per_line & 0x1fff) << 16) |
+			      (num_lines & 0x1fff);
+			writel_relaxed(val, csid->base +
+				       CAMSS_CSID_TG_DT_n_CGG_0(0));
+
+			/* 5:0 data type */
+			val = dt;
+			writel_relaxed(val, csid->base +
+				       CAMSS_CSID_TG_DT_n_CGG_1(0));
+
+			/* 2:0 output test pattern */
+			val = tg->payload_mode;
+			writel_relaxed(val, csid->base +
+				       CAMSS_CSID_TG_DT_n_CGG_2(0));
+		} else {
+			struct csid_phy_config *phy = &csid->phy;
+
+			val = phy->lane_cnt - 1;
+			val |= phy->lane_assign << 4;
+
+			writel_relaxed(val,
+				       csid->base + CAMSS_CSID_CORE_CTRL_0);
+
+			val = phy->csiphy_id << 17;
+			val |= 0x9;
+
+			writel_relaxed(val,
+				       csid->base + CAMSS_CSID_CORE_CTRL_1);
+		}
+
+		/* Config LUT */
+
+		dt_shift = (cid % 4) * 8;
+		df = csid_get_fmt_entry(csid->fmt[MSM_CSID_PAD_SINK].code)->
+								decode_format;
+
+		val = readl_relaxed(csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
+		val &= ~(0xff << dt_shift);
+		val |= dt << dt_shift;
+		writel_relaxed(val, csid->base + CAMSS_CSID_CID_LUT_VC_n(vc));
+
+		val = (df << 4) | 0x3;
+		writel_relaxed(val, csid->base + CAMSS_CSID_CID_n_CFG(cid));
+
+		if (tg->enabled) {
+			val = CAMSS_CSID_TG_CTRL_ENABLE;
+			writel_relaxed(val, csid->base + CAMSS_CSID_TG_CTRL);
+		}
+	} else {
+		if (tg->enabled) {
+			val = CAMSS_CSID_TG_CTRL_DISABLE;
+			writel_relaxed(val, csid->base + CAMSS_CSID_TG_CTRL);
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * __csid_get_format - Get pointer to format structure
+ * @csid: CSID device
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad from which format is requested
+ * @which: TRY or ACTIVE format
+ *
+ * Return pointer to TRY or ACTIVE format structure
+ */
+static struct v4l2_mbus_framefmt *
+__csid_get_format(struct csid_device *csid,
+		  struct v4l2_subdev_pad_config *cfg,
+		  unsigned int pad,
+		  enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&csid->subdev, cfg, pad);
+
+	return &csid->fmt[pad];
+}
+
+/*
+ * csid_try_format - Handle try format by pad subdev method
+ * @csid: CSID device
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad on which format is requested
+ * @fmt: pointer to v4l2 format structure
+ * @which: wanted subdev format
+ */
+static void csid_try_format(struct csid_device *csid,
+			    struct v4l2_subdev_pad_config *cfg,
+			    unsigned int pad,
+			    struct v4l2_mbus_framefmt *fmt,
+			    enum v4l2_subdev_format_whence which)
+{
+	unsigned int i;
+
+	switch (pad) {
+	case MSM_CSID_PAD_SINK:
+		/* Set format on sink pad */
+
+		for (i = 0; i < ARRAY_SIZE(csid_input_fmts); i++)
+			if (fmt->code == csid_input_fmts[i].code)
+				break;
+
+		/* If not found, use UYVY as default */
+		if (i >= ARRAY_SIZE(csid_input_fmts))
+			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
+		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
+		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
+
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+
+		break;
+
+	case MSM_CSID_PAD_SRC:
+		if (csid->testgen_mode->cur.val == 0) {
+			/* Test generator is disabled, keep pad formats */
+			/* in sync - set and return a format same as sink pad */
+			struct v4l2_mbus_framefmt format;
+
+			format = *__csid_get_format(csid, cfg,
+						    MSM_CSID_PAD_SINK, which);
+			*fmt = format;
+		} else {
+			/* Test generator is enabled, set format on source*/
+			/* pad to allow test generator usage */
+
+			for (i = 0; i < ARRAY_SIZE(csid_input_fmts); i++)
+				if (csid_input_fmts[i].code == fmt->code)
+					break;
+
+			/* If not found, use UYVY as default */
+			if (i >= ARRAY_SIZE(csid_input_fmts))
+				fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
+			fmt->width = clamp_t(u32, fmt->width, 1, 8191);
+			fmt->height = clamp_t(u32, fmt->height, 1, 8191);
+
+			fmt->field = V4L2_FIELD_NONE;
+		}
+		break;
+	}
+
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+}
+
+/*
+ * csid_enum_mbus_code - Handle pixel format enumeration
+ * @sd: CSID V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @code: pointer to v4l2_subdev_mbus_code_enum structure
+ * return -EINVAL or zero on success
+ */
+static int csid_enum_mbus_code(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_pad_config *cfg,
+			       struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	if (code->pad == MSM_CSID_PAD_SINK) {
+		if (code->index >= ARRAY_SIZE(csid_input_fmts))
+			return -EINVAL;
+
+		code->code = csid_input_fmts[code->index].code;
+	} else {
+		if (csid->testgen_mode->cur.val == 0) {
+			if (code->index > 0)
+				return -EINVAL;
+
+			format = __csid_get_format(csid, cfg, MSM_CSID_PAD_SINK,
+						   code->which);
+
+			code->code = format->code;
+		} else {
+			if (code->index >= ARRAY_SIZE(csid_input_fmts))
+				return -EINVAL;
+
+			code->code = csid_input_fmts[code->index].code;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * csid_enum_frame_size - Handle frame size enumeration
+ * @sd: CSID V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fse: pointer to v4l2_subdev_frame_size_enum structure
+ * return -EINVAL or zero on success
+ */
+static int csid_enum_frame_size(struct v4l2_subdev *sd,
+				struct v4l2_subdev_pad_config *cfg,
+				struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	csid_try_format(csid, cfg, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	csid_try_format(csid, cfg, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+/*
+ * csid_get_format - Handle get format by pads subdev method
+ * @sd: CSID V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int csid_get_format(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_pad_config *cfg,
+			   struct v4l2_subdev_format *fmt)
+{
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __csid_get_format(csid, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+/*
+ * csid_set_format - Handle set format by pads subdev method
+ * @sd: CSID V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int csid_set_format(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_pad_config *cfg,
+			   struct v4l2_subdev_format *fmt)
+{
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __csid_get_format(csid, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	csid_try_format(csid, cfg, fmt->pad, &fmt->format, fmt->which);
+	*format = fmt->format;
+
+	/* Propagate the format from sink to source */
+	if (fmt->pad == MSM_CSID_PAD_SINK) {
+		format = __csid_get_format(csid, cfg, MSM_CSID_PAD_SRC,
+					   fmt->which);
+
+		*format = fmt->format;
+		csid_try_format(csid, cfg, MSM_CSID_PAD_SRC, format,
+				fmt->which);
+	}
+
+	return 0;
+}
+
+/*
+ * csid_init_formats - Initialize formats on all pads
+ * @sd: CSID V4L2 subdevice
+ * @fh: V4L2 subdev file handle
+ *
+ * Initialize all pad formats with default values.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = MSM_CSID_PAD_SINK,
+		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
+			      V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_UYVY8_2X8,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return csid_set_format(sd, fh ? fh->pad : NULL, &format);
+}
+
+static const char * const csid_test_pattern_menu[] = {
+	"Disabled",
+	"Incrementing",
+	"Alternating 0x55/0xAA",
+	"All Zeros 0x00",
+	"All Ones 0xFF",
+	"Pseudo-random Data",
+};
+
+/*
+ * csid_set_test_pattern - Set test generator's pattern mode
+ * @csid: CSID device
+ * @value: desired test pattern mode
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_set_test_pattern(struct csid_device *csid, s32 value)
+{
+	struct csid_testgen_config *tg = &csid->testgen;
+
+	/* If CSID is linked to CSIPHY, do not allow to enable test generator */
+	if (value && media_entity_remote_pad(&csid->pads[MSM_CSID_PAD_SINK]))
+		return -EBUSY;
+
+	tg->enabled = !!value;
+
+	switch (value) {
+	case 1:
+		tg->payload_mode = CSID_PAYLOAD_MODE_INCREMENTING;
+		break;
+	case 2:
+		tg->payload_mode = CSID_PAYLOAD_MODE_ALTERNATING_55_AA;
+		break;
+	case 3:
+		tg->payload_mode = CSID_PAYLOAD_MODE_ALL_ZEROES;
+		break;
+	case 4:
+		tg->payload_mode = CSID_PAYLOAD_MODE_ALL_ONES;
+		break;
+	case 5:
+		tg->payload_mode = CSID_PAYLOAD_MODE_RANDOM;
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * csid_s_ctrl - Handle set control subdev method
+ * @ctrl: pointer to v4l2 control structure
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct csid_device *csid = container_of(ctrl->handler,
+						struct csid_device, ctrls);
+	int ret = -EINVAL;
+
+	switch (ctrl->id) {
+	case V4L2_CID_TEST_PATTERN:
+		ret = csid_set_test_pattern(csid, ctrl->val);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops csid_ctrl_ops = {
+	.s_ctrl = csid_s_ctrl,
+};
+
+/*
+ * msm_csid_subdev_init - Initialize CSID device structure and resources
+ * @csid: CSID device
+ * @res: CSID module resources table
+ * @id: CSID module id
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_csid_subdev_init(struct csid_device *csid,
+			 const struct resources *res, u8 id)
+{
+	struct device *dev = to_device_index(csid, id);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *r;
+	int i, j;
+	int ret;
+
+	csid->id = id;
+
+	/* Memory */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
+	csid->base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(csid->base)) {
+		dev_err(dev, "could not map memory\n");
+		return PTR_ERR(csid->base);
+	}
+
+	/* Interrupt */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					 res->interrupt[0]);
+	if (!r) {
+		dev_err(dev, "missing IRQ\n");
+		return -EINVAL;
+	}
+
+	csid->irq = r->start;
+	snprintf(csid->irq_name, sizeof(csid->irq_name), "%s_%s%d",
+		 dev_name(dev), MSM_CSID_NAME, csid->id);
+	ret = devm_request_irq(dev, csid->irq, csid_isr,
+		IRQF_TRIGGER_RISING, csid->irq_name, csid);
+	if (ret < 0) {
+		dev_err(dev, "request_irq failed: %d\n", ret);
+		return ret;
+	}
+
+	disable_irq(csid->irq);
+
+	/* Clocks */
+
+	csid->nclocks = 0;
+	while (res->clock[csid->nclocks])
+		csid->nclocks++;
+
+	csid->clock = devm_kcalloc(dev, csid->nclocks, sizeof(*csid->clock),
+				    GFP_KERNEL);
+	if (!csid->clock)
+		return -ENOMEM;
+
+	for (i = 0; i < csid->nclocks; i++) {
+		struct camss_clock *clock = &csid->clock[i];
+
+		clock->clk = devm_clk_get(dev, res->clock[i]);
+		if (IS_ERR(clock->clk))
+			return PTR_ERR(clock->clk);
+
+		clock->name = res->clock[i];
+
+		clock->nfreqs = 0;
+		while (res->clock_rate[i][clock->nfreqs])
+			clock->nfreqs++;
+
+		if (!clock->nfreqs) {
+			clock->freq = NULL;
+			continue;
+		}
+
+		clock->freq = devm_kcalloc(dev,
+					   clock->nfreqs,
+					   sizeof(*clock->freq),
+					   GFP_KERNEL);
+		if (!clock->freq)
+			return -ENOMEM;
+
+		for (j = 0; j < clock->nfreqs; j++)
+			clock->freq[j] = res->clock_rate[i][j];
+	}
+
+	/* Regulator */
+
+	csid->vdda = devm_regulator_get(dev, res->regulator[0]);
+	if (IS_ERR(csid->vdda)) {
+		dev_err(dev, "could not get regulator\n");
+		return PTR_ERR(csid->vdda);
+	}
+
+	init_completion(&csid->reset_complete);
+
+	return 0;
+}
+
+/*
+ * msm_csid_get_csid_id - Get CSID HW module id
+ * @entity: Pointer to CSID media entity structure
+ * @id: Return CSID HW module id here
+ */
+void msm_csid_get_csid_id(struct media_entity *entity, u8 *id)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(entity);
+	struct csid_device *csid = v4l2_get_subdevdata(sd);
+
+	*id = csid->id;
+}
+
+/*
+ * csid_get_lane_assign - Calculate CSI2 lane assign configuration parameter
+ * @lane_cfg - CSI2 lane configuration
+ *
+ * Return lane assign
+ */
+static u32 csid_get_lane_assign(struct csiphy_lanes_cfg *lane_cfg)
+{
+	u32 lane_assign = 0;
+	int i;
+
+	for (i = 0; i < lane_cfg->num_data; i++)
+		lane_assign |= lane_cfg->data[i].pos << (i * 4);
+
+	return lane_assign;
+}
+
+/*
+ * csid_link_setup - Setup CSID connections
+ * @entity: Pointer to media entity structure
+ * @local: Pointer to local pad
+ * @remote: Pointer to remote pad
+ * @flags: Link flags
+ *
+ * Return 0 on success
+ */
+static int csid_link_setup(struct media_entity *entity,
+			   const struct media_pad *local,
+			   const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED)
+		if (media_entity_remote_pad(local))
+			return -EBUSY;
+
+	if ((local->flags & MEDIA_PAD_FL_SINK) &&
+	    (flags & MEDIA_LNK_FL_ENABLED)) {
+		struct v4l2_subdev *sd;
+		struct csid_device *csid;
+		struct csiphy_device *csiphy;
+		struct csiphy_lanes_cfg *lane_cfg;
+		struct v4l2_subdev_format format = { 0 };
+
+		sd = media_entity_to_v4l2_subdev(entity);
+		csid = v4l2_get_subdevdata(sd);
+
+		/* If test generator is enabled */
+		/* do not allow a link from CSIPHY to CSID */
+		if (csid->testgen_mode->cur.val != 0)
+			return -EBUSY;
+
+		sd = media_entity_to_v4l2_subdev(remote->entity);
+		csiphy = v4l2_get_subdevdata(sd);
+
+		/* If a sensor is not linked to CSIPHY */
+		/* do no allow a link from CSIPHY to CSID */
+		if (!csiphy->cfg.csi2)
+			return -EPERM;
+
+		csid->phy.csiphy_id = csiphy->id;
+
+		lane_cfg = &csiphy->cfg.csi2->lane_cfg;
+		csid->phy.lane_cnt = lane_cfg->num_data;
+		csid->phy.lane_assign = csid_get_lane_assign(lane_cfg);
+
+		/* Reset format on source pad to sink pad format */
+		format.pad = MSM_CSID_PAD_SRC;
+		format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+		csid_set_format(&csid->subdev, NULL, &format);
+	}
+
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops csid_core_ops = {
+	.s_power = csid_set_power,
+};
+
+static const struct v4l2_subdev_video_ops csid_video_ops = {
+	.s_stream = csid_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops csid_pad_ops = {
+	.enum_mbus_code = csid_enum_mbus_code,
+	.enum_frame_size = csid_enum_frame_size,
+	.get_fmt = csid_get_format,
+	.set_fmt = csid_set_format,
+};
+
+static const struct v4l2_subdev_ops csid_v4l2_ops = {
+	.core = &csid_core_ops,
+	.video = &csid_video_ops,
+	.pad = &csid_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops csid_v4l2_internal_ops = {
+	.open = csid_init_formats,
+};
+
+static const struct media_entity_operations csid_media_ops = {
+	.link_setup = csid_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+/*
+ * msm_csid_register_entity - Register subdev node for CSID module
+ * @csid: CSID device
+ * @v4l2_dev: V4L2 device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_csid_register_entity(struct csid_device *csid,
+			     struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd = &csid->subdev;
+	struct media_pad *pads = csid->pads;
+	struct device *dev = to_device_index(csid, csid->id);
+	int ret;
+
+	v4l2_subdev_init(sd, &csid_v4l2_ops);
+	sd->internal_ops = &csid_v4l2_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
+		 MSM_CSID_NAME, csid->id);
+	v4l2_set_subdevdata(sd, csid);
+
+	ret = v4l2_ctrl_handler_init(&csid->ctrls, 1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init ctrl handler: %d\n", ret);
+		return ret;
+	}
+
+	csid->testgen_mode = v4l2_ctrl_new_std_menu_items(&csid->ctrls,
+				&csid_ctrl_ops, V4L2_CID_TEST_PATTERN,
+				ARRAY_SIZE(csid_test_pattern_menu) - 1, 0, 0,
+				csid_test_pattern_menu);
+
+	if (csid->ctrls.error) {
+		dev_err(dev, "Failed to init ctrl: %d\n", csid->ctrls.error);
+		ret = csid->ctrls.error;
+		goto free_ctrl;
+	}
+
+	csid->subdev.ctrl_handler = &csid->ctrls;
+
+	ret = csid_init_formats(sd, NULL);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init format: %d\n", ret);
+		goto free_ctrl;
+	}
+
+	pads[MSM_CSID_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[MSM_CSID_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+	sd->entity.function = MEDIA_ENT_F_IO_V4L;
+	sd->entity.ops = &csid_media_ops;
+	ret = media_entity_pads_init(&sd->entity, MSM_CSID_PADS_NUM, pads);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init media entity: %d\n", ret);
+		goto free_ctrl;
+	}
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register subdev: %d\n", ret);
+		goto media_cleanup;
+	}
+
+	return 0;
+
+media_cleanup:
+	media_entity_cleanup(&sd->entity);
+free_ctrl:
+	v4l2_ctrl_handler_free(&csid->ctrls);
+
+	return ret;
+}
+
+/*
+ * msm_csid_unregister_entity - Unregister CSID module subdev node
+ * @csid: CSID device
+ */
+void msm_csid_unregister_entity(struct csid_device *csid)
+{
+	v4l2_device_unregister_subdev(&csid->subdev);
+	media_entity_cleanup(&csid->subdev.entity);
+	v4l2_ctrl_handler_free(&csid->ctrls);
+}
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
new file mode 100644
index 0000000..8012222
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -0,0 +1,82 @@
+/*
+ * camss-csid.h
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
+ *
+ * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef QC_MSM_CAMSS_CSID_H
+#define QC_MSM_CAMSS_CSID_H
+
+#include <linux/clk.h>
+#include <media/media-entity.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mediabus.h>
+#include <media/v4l2-subdev.h>
+
+#define MSM_CSID_PAD_SINK 0
+#define MSM_CSID_PAD_SRC 1
+#define MSM_CSID_PADS_NUM 2
+
+enum csid_payload_mode {
+	CSID_PAYLOAD_MODE_INCREMENTING = 0,
+	CSID_PAYLOAD_MODE_ALTERNATING_55_AA = 1,
+	CSID_PAYLOAD_MODE_ALL_ZEROES = 2,
+	CSID_PAYLOAD_MODE_ALL_ONES = 3,
+	CSID_PAYLOAD_MODE_RANDOM = 4,
+	CSID_PAYLOAD_MODE_USER_SPECIFIED = 5,
+};
+
+struct csid_testgen_config {
+	u8 enabled;
+	enum csid_payload_mode payload_mode;
+};
+
+struct csid_phy_config {
+	u8 csiphy_id;
+	u8 lane_cnt;
+	u32 lane_assign;
+};
+
+struct csid_device {
+	u8 id;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[MSM_CSID_PADS_NUM];
+	void __iomem *base;
+	u32 irq;
+	char irq_name[30];
+	struct camss_clock *clock;
+	int nclocks;
+	struct regulator *vdda;
+	struct completion reset_complete;
+	struct csid_testgen_config testgen;
+	struct csid_phy_config phy;
+	struct v4l2_mbus_framefmt fmt[MSM_CSID_PADS_NUM];
+	struct v4l2_ctrl_handler ctrls;
+	struct v4l2_ctrl *testgen_mode;
+};
+
+struct resources;
+
+int msm_csid_subdev_init(struct csid_device *csid,
+			 const struct resources *res, u8 id);
+
+int msm_csid_register_entity(struct csid_device *csid,
+			     struct v4l2_device *v4l2_dev);
+
+void msm_csid_unregister_entity(struct csid_device *csid);
+
+void msm_csid_get_csid_id(struct media_entity *entity, u8 *id);
+
+#endif /* QC_MSM_CAMSS_CSID_H */
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
new file mode 100644
index 0000000..642de25
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -0,0 +1,893 @@
+/*
+ * camss-csiphy.c
+ *
+ * Qualcomm MSM Camera Subsystem - CSIPHY Module
+ *
+ * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2016-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+#include "camss-csiphy.h"
+#include "camss.h"
+
+#define MSM_CSIPHY_NAME "msm_csiphy"
+
+#define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
+#define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
+#define CAMSS_CSI_PHY_GLBL_RESET		0x140
+#define CAMSS_CSI_PHY_GLBL_PWR_CFG		0x144
+#define CAMSS_CSI_PHY_GLBL_IRQ_CMD		0x164
+#define CAMSS_CSI_PHY_HW_VERSION		0x188
+#define CAMSS_CSI_PHY_INTERRUPT_STATUSn(n)	(0x18c + 0x4 * (n))
+#define CAMSS_CSI_PHY_INTERRUPT_MASKn(n)	(0x1ac + 0x4 * (n))
+#define CAMSS_CSI_PHY_INTERRUPT_CLEARn(n)	(0x1cc + 0x4 * (n))
+#define CAMSS_CSI_PHY_GLBL_T_INIT_CFG0		0x1ec
+#define CAMSS_CSI_PHY_T_WAKEUP_CFG0		0x1f4
+
+static const struct {
+	u32 code;
+	u8 bpp;
+} csiphy_formats[] = {
+	{
+		MEDIA_BUS_FMT_UYVY8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_VYUY8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_YUYV8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_YVYU8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR12_1X12,
+		12,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG12_1X12,
+		12,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG12_1X12,
+		12,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB12_1X12,
+		12,
+	}
+};
+
+/*
+ * csiphy_get_bpp - map media bus format to bits per pixel
+ * @code: media bus format code
+ *
+ * Return number of bits per pixel
+ */
+static u8 csiphy_get_bpp(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(csiphy_formats); i++)
+		if (code == csiphy_formats[i].code)
+			return csiphy_formats[i].bpp;
+
+	WARN(1, "Unknown format\n");
+
+	return csiphy_formats[0].bpp;
+}
+
+/*
+ * csiphy_isr - CSIPHY module interrupt handler
+ * @irq: Interrupt line
+ * @dev: CSIPHY device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t csiphy_isr(int irq, void *dev)
+{
+	struct csiphy_device *csiphy = dev;
+	u8 i;
+
+	for (i = 0; i < 8; i++) {
+		u8 val = readl_relaxed(csiphy->base +
+				       CAMSS_CSI_PHY_INTERRUPT_STATUSn(i));
+		writel_relaxed(val, csiphy->base +
+			       CAMSS_CSI_PHY_INTERRUPT_CLEARn(i));
+		writel_relaxed(0x1, csiphy->base + CAMSS_CSI_PHY_GLBL_IRQ_CMD);
+		writel_relaxed(0x0, csiphy->base + CAMSS_CSI_PHY_GLBL_IRQ_CMD);
+		writel_relaxed(0x0, csiphy->base +
+			       CAMSS_CSI_PHY_INTERRUPT_CLEARn(i));
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * csiphy_set_clock_rates - Calculate and set clock rates on CSIPHY module
+ * @csiphy: CSIPHY device
+ */
+static int csiphy_set_clock_rates(struct csiphy_device *csiphy)
+{
+	struct device *dev = to_device_index(csiphy, csiphy->id);
+	u32 pixel_clock;
+	int i, j;
+	int ret;
+
+	ret = camss_get_pixel_clock(&csiphy->subdev.entity, &pixel_clock);
+	if (ret)
+		pixel_clock = 0;
+
+	for (i = 0; i < csiphy->nclocks; i++) {
+		struct camss_clock *clock = &csiphy->clock[i];
+
+		if (!strcmp(clock->name, "csiphy0_timer") ||
+			!strcmp(clock->name, "csiphy1_timer")) {
+			u8 bpp = csiphy_get_bpp(
+					csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
+			u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
+			u64 min_rate = pixel_clock * bpp / (2 * num_lanes * 4);
+			long round_rate;
+
+			camss_add_clock_margin(&min_rate);
+
+			for (j = 0; j < clock->nfreqs; j++)
+				if (min_rate < clock->freq[j])
+					break;
+
+			if (j == clock->nfreqs) {
+				dev_err(dev,
+					"Pixel clock is too high for CSIPHY\n");
+				return -EINVAL;
+			}
+
+			/* if sensor pixel clock is not available */
+			/* set highest possible CSIPHY clock rate */
+			if (min_rate == 0)
+				j = clock->nfreqs - 1;
+
+			round_rate = clk_round_rate(clock->clk, clock->freq[j]);
+			if (round_rate < 0) {
+				dev_err(dev, "clk round rate failed: %ld\n",
+					round_rate);
+				return -EINVAL;
+			}
+
+			csiphy->timer_clk_rate = round_rate;
+
+			ret = clk_set_rate(clock->clk, csiphy->timer_clk_rate);
+			if (ret < 0) {
+				dev_err(dev, "clk set rate failed: %d\n", ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * csiphy_reset - Perform software reset on CSIPHY module
+ * @csiphy: CSIPHY device
+ */
+static void csiphy_reset(struct csiphy_device *csiphy)
+{
+	writel_relaxed(0x1, csiphy->base + CAMSS_CSI_PHY_GLBL_RESET);
+	usleep_range(5000, 8000);
+	writel_relaxed(0x0, csiphy->base + CAMSS_CSI_PHY_GLBL_RESET);
+}
+
+/*
+ * csiphy_set_power - Power on/off CSIPHY module
+ * @sd: CSIPHY V4L2 subdevice
+ * @on: Requested power state
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csiphy_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
+	struct device *dev = to_device_index(csiphy, csiphy->id);
+
+	if (on) {
+		u8 hw_version;
+		int ret;
+
+		ret = csiphy_set_clock_rates(csiphy);
+		if (ret < 0)
+			return ret;
+
+		ret = camss_enable_clocks(csiphy->nclocks, csiphy->clock, dev);
+		if (ret < 0)
+			return ret;
+
+		enable_irq(csiphy->irq);
+
+		csiphy_reset(csiphy);
+
+		hw_version = readl_relaxed(csiphy->base +
+					   CAMSS_CSI_PHY_HW_VERSION);
+		dev_dbg(dev, "CSIPHY HW Version = 0x%02x\n", hw_version);
+	} else {
+		disable_irq(csiphy->irq);
+
+		camss_disable_clocks(csiphy->nclocks, csiphy->clock);
+	}
+
+	return 0;
+}
+
+/*
+ * csiphy_get_lane_mask - Calculate CSI2 lane mask configuration parameter
+ * @lane_cfg - CSI2 lane configuration
+ *
+ * Return lane mask
+ */
+static u8 csiphy_get_lane_mask(struct csiphy_lanes_cfg *lane_cfg)
+{
+	u8 lane_mask;
+	int i;
+
+	lane_mask = 1 << lane_cfg->clk.pos;
+
+	for (i = 0; i < lane_cfg->num_data; i++)
+		lane_mask |= 1 << lane_cfg->data[i].pos;
+
+	return lane_mask;
+}
+
+/*
+ * csiphy_settle_cnt_calc - Calculate settle count value
+ * @csiphy: CSIPHY device
+ *
+ * Helper function to calculate settle count value. This is
+ * based on the CSI2 T_hs_settle parameter which in turn
+ * is calculated based on the CSI2 transmitter pixel clock
+ * frequency.
+ *
+ * Return settle count value or 0 if the CSI2 pixel clock
+ * frequency is not available
+ */
+static u8 csiphy_settle_cnt_calc(struct csiphy_device *csiphy)
+{
+	u8 bpp = csiphy_get_bpp(
+			csiphy->fmt[MSM_CSIPHY_PAD_SINK].code);
+	u8 num_lanes = csiphy->cfg.csi2->lane_cfg.num_data;
+	u32 pixel_clock; /* Hz */
+	u32 mipi_clock; /* Hz */
+	u32 ui; /* ps */
+	u32 timer_period; /* ps */
+	u32 t_hs_prepare_max; /* ps */
+	u32 t_hs_prepare_zero_min; /* ps */
+	u32 t_hs_settle; /* ps */
+	u8 settle_cnt;
+	int ret;
+
+	ret = camss_get_pixel_clock(&csiphy->subdev.entity, &pixel_clock);
+	if (ret) {
+		dev_err(to_device_index(csiphy, csiphy->id),
+			"Cannot get CSI2 transmitter's pixel clock\n");
+		return 0;
+	}
+	if (!pixel_clock) {
+		dev_err(to_device_index(csiphy, csiphy->id),
+			"Got pixel clock == 0, cannot continue\n");
+		return 0;
+	}
+
+	mipi_clock = pixel_clock * bpp / (2 * num_lanes);
+	ui = div_u64(1000000000000LL, mipi_clock);
+	ui /= 2;
+	t_hs_prepare_max = 85000 + 6 * ui;
+	t_hs_prepare_zero_min = 145000 + 10 * ui;
+	t_hs_settle = (t_hs_prepare_max + t_hs_prepare_zero_min) / 2;
+
+	timer_period = div_u64(1000000000000LL, csiphy->timer_clk_rate);
+	settle_cnt = t_hs_settle / timer_period;
+
+	return settle_cnt;
+}
+
+/*
+ * csiphy_stream_on - Enable streaming on CSIPHY module
+ * @csiphy: CSIPHY device
+ *
+ * Helper function to enable streaming on CSIPHY module.
+ * Main configuration of CSIPHY module is also done here.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csiphy_stream_on(struct csiphy_device *csiphy)
+{
+	struct csiphy_config *cfg = &csiphy->cfg;
+	u8 lane_mask = csiphy_get_lane_mask(&cfg->csi2->lane_cfg);
+	u8 settle_cnt;
+	u8 val;
+	int i = 0;
+
+	settle_cnt = csiphy_settle_cnt_calc(csiphy);
+	if (!settle_cnt)
+		return -EINVAL;
+
+	val = readl_relaxed(csiphy->base_clk_mux);
+	if (cfg->combo_mode && (lane_mask & 0x18) == 0x18) {
+		val &= ~0xf0;
+		val |= cfg->csid_id << 4;
+	} else {
+		val &= ~0xf;
+		val |= cfg->csid_id;
+	}
+	writel_relaxed(val, csiphy->base_clk_mux);
+
+	writel_relaxed(0x1, csiphy->base +
+		       CAMSS_CSI_PHY_GLBL_T_INIT_CFG0);
+	writel_relaxed(0x1, csiphy->base +
+		       CAMSS_CSI_PHY_T_WAKEUP_CFG0);
+
+	val = 0x1;
+	val |= lane_mask << 1;
+	writel_relaxed(val, csiphy->base + CAMSS_CSI_PHY_GLBL_PWR_CFG);
+
+	val = cfg->combo_mode << 4;
+	writel_relaxed(val, csiphy->base + CAMSS_CSI_PHY_GLBL_RESET);
+
+	while (lane_mask) {
+		if (lane_mask & 0x1) {
+			writel_relaxed(0x10, csiphy->base +
+				       CAMSS_CSI_PHY_LNn_CFG2(i));
+			writel_relaxed(settle_cnt, csiphy->base +
+				       CAMSS_CSI_PHY_LNn_CFG3(i));
+			writel_relaxed(0x3f, csiphy->base +
+				       CAMSS_CSI_PHY_INTERRUPT_MASKn(i));
+			writel_relaxed(0x3f, csiphy->base +
+				       CAMSS_CSI_PHY_INTERRUPT_CLEARn(i));
+		}
+
+		lane_mask >>= 1;
+		i++;
+	}
+
+	return 0;
+}
+
+/*
+ * csiphy_stream_off - Disable streaming on CSIPHY module
+ * @csiphy: CSIPHY device
+ *
+ * Helper function to disable streaming on CSIPHY module
+ */
+static void csiphy_stream_off(struct csiphy_device *csiphy)
+{
+	u8 lane_mask = csiphy_get_lane_mask(&csiphy->cfg.csi2->lane_cfg);
+	int i = 0;
+
+	while (lane_mask) {
+		if (lane_mask & 0x1)
+			writel_relaxed(0x0, csiphy->base +
+				       CAMSS_CSI_PHY_LNn_CFG2(i));
+
+		lane_mask >>= 1;
+		i++;
+	}
+
+	writel_relaxed(0x0, csiphy->base + CAMSS_CSI_PHY_GLBL_PWR_CFG);
+}
+
+
+/*
+ * csiphy_set_stream - Enable/disable streaming on CSIPHY module
+ * @sd: CSIPHY V4L2 subdevice
+ * @enable: Requested streaming state
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csiphy_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
+	int ret = 0;
+
+	if (enable)
+		ret = csiphy_stream_on(csiphy);
+	else
+		csiphy_stream_off(csiphy);
+
+	return ret;
+}
+
+/*
+ * __csiphy_get_format - Get pointer to format structure
+ * @csiphy: CSIPHY device
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad from which format is requested
+ * @which: TRY or ACTIVE format
+ *
+ * Return pointer to TRY or ACTIVE format structure
+ */
+static struct v4l2_mbus_framefmt *
+__csiphy_get_format(struct csiphy_device *csiphy,
+		    struct v4l2_subdev_pad_config *cfg,
+		    unsigned int pad,
+		    enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&csiphy->subdev, cfg, pad);
+
+	return &csiphy->fmt[pad];
+}
+
+/*
+ * csiphy_try_format - Handle try format by pad subdev method
+ * @csiphy: CSIPHY device
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad on which format is requested
+ * @fmt: pointer to v4l2 format structure
+ * @which: wanted subdev format
+ */
+static void csiphy_try_format(struct csiphy_device *csiphy,
+			      struct v4l2_subdev_pad_config *cfg,
+			      unsigned int pad,
+			      struct v4l2_mbus_framefmt *fmt,
+			      enum v4l2_subdev_format_whence which)
+{
+	unsigned int i;
+
+	switch (pad) {
+	case MSM_CSIPHY_PAD_SINK:
+		/* Set format on sink pad */
+
+		for (i = 0; i < ARRAY_SIZE(csiphy_formats); i++)
+			if (fmt->code == csiphy_formats[i].code)
+				break;
+
+		/* If not found, use UYVY as default */
+		if (i >= ARRAY_SIZE(csiphy_formats))
+			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
+		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
+		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
+
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+
+		break;
+
+	case MSM_CSIPHY_PAD_SRC:
+		/* Set and return a format same as sink pad */
+
+		*fmt = *__csiphy_get_format(csiphy, cfg, MSM_CSID_PAD_SINK,
+					    which);
+
+		break;
+	}
+}
+
+/*
+ * csiphy_enum_mbus_code - Handle pixel format enumeration
+ * @sd: CSIPHY V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @code: pointer to v4l2_subdev_mbus_code_enum structure
+ * return -EINVAL or zero on success
+ */
+static int csiphy_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_pad_config *cfg,
+				 struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	if (code->pad == MSM_CSIPHY_PAD_SINK) {
+		if (code->index >= ARRAY_SIZE(csiphy_formats))
+			return -EINVAL;
+
+		code->code = csiphy_formats[code->index].code;
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+
+		format = __csiphy_get_format(csiphy, cfg, MSM_CSIPHY_PAD_SINK,
+					     code->which);
+
+		code->code = format->code;
+	}
+
+	return 0;
+}
+
+/*
+ * csiphy_enum_frame_size - Handle frame size enumeration
+ * @sd: CSIPHY V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fse: pointer to v4l2_subdev_frame_size_enum structure
+ * return -EINVAL or zero on success
+ */
+static int csiphy_enum_frame_size(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_pad_config *cfg,
+				  struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	csiphy_try_format(csiphy, cfg, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	csiphy_try_format(csiphy, cfg, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+/*
+ * csiphy_get_format - Handle get format by pads subdev method
+ * @sd: CSIPHY V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int csiphy_get_format(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_pad_config *cfg,
+			     struct v4l2_subdev_format *fmt)
+{
+	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __csiphy_get_format(csiphy, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+/*
+ * csiphy_set_format - Handle set format by pads subdev method
+ * @sd: CSIPHY V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int csiphy_set_format(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_pad_config *cfg,
+			     struct v4l2_subdev_format *fmt)
+{
+	struct csiphy_device *csiphy = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __csiphy_get_format(csiphy, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	csiphy_try_format(csiphy, cfg, fmt->pad, &fmt->format, fmt->which);
+	*format = fmt->format;
+
+	/* Propagate the format from sink to source */
+	if (fmt->pad == MSM_CSIPHY_PAD_SINK) {
+		format = __csiphy_get_format(csiphy, cfg, MSM_CSIPHY_PAD_SRC,
+					     fmt->which);
+
+		*format = fmt->format;
+		csiphy_try_format(csiphy, cfg, MSM_CSIPHY_PAD_SRC, format,
+				  fmt->which);
+	}
+
+	return 0;
+}
+
+/*
+ * csiphy_init_formats - Initialize formats on all pads
+ * @sd: CSIPHY V4L2 subdevice
+ * @fh: V4L2 subdev file handle
+ *
+ * Initialize all pad formats with default values.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csiphy_init_formats(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = MSM_CSIPHY_PAD_SINK,
+		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
+			      V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_UYVY8_2X8,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return csiphy_set_format(sd, fh ? fh->pad : NULL, &format);
+}
+
+/*
+ * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
+ * @csiphy: CSIPHY device
+ * @res: CSIPHY module resources table
+ * @id: CSIPHY module id
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_csiphy_subdev_init(struct csiphy_device *csiphy,
+			   const struct resources *res, u8 id)
+{
+	struct device *dev = to_device_index(csiphy, id);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *r;
+	int i, j;
+	int ret;
+
+	csiphy->id = id;
+	csiphy->cfg.combo_mode = 0;
+
+	/* Memory */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
+	csiphy->base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(csiphy->base)) {
+		dev_err(dev, "could not map memory\n");
+		return PTR_ERR(csiphy->base);
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[1]);
+	csiphy->base_clk_mux = devm_ioremap_resource(dev, r);
+	if (IS_ERR(csiphy->base_clk_mux)) {
+		dev_err(dev, "could not map memory\n");
+		return PTR_ERR(csiphy->base_clk_mux);
+	}
+
+	/* Interrupt */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					 res->interrupt[0]);
+	if (!r) {
+		dev_err(dev, "missing IRQ\n");
+		return -EINVAL;
+	}
+
+	csiphy->irq = r->start;
+	snprintf(csiphy->irq_name, sizeof(csiphy->irq_name), "%s_%s%d",
+		 dev_name(dev), MSM_CSIPHY_NAME, csiphy->id);
+	ret = devm_request_irq(dev, csiphy->irq, csiphy_isr,
+			       IRQF_TRIGGER_RISING, csiphy->irq_name, csiphy);
+	if (ret < 0) {
+		dev_err(dev, "request_irq failed: %d\n", ret);
+		return ret;
+	}
+
+	disable_irq(csiphy->irq);
+
+	/* Clocks */
+
+	csiphy->nclocks = 0;
+	while (res->clock[csiphy->nclocks])
+		csiphy->nclocks++;
+
+	csiphy->clock = devm_kcalloc(dev,
+				     csiphy->nclocks, sizeof(*csiphy->clock),
+				     GFP_KERNEL);
+	if (!csiphy->clock)
+		return -ENOMEM;
+
+	for (i = 0; i < csiphy->nclocks; i++) {
+		struct camss_clock *clock = &csiphy->clock[i];
+
+		clock->clk = devm_clk_get(dev, res->clock[i]);
+		if (IS_ERR(clock->clk))
+			return PTR_ERR(clock->clk);
+
+		clock->name = res->clock[i];
+
+		clock->nfreqs = 0;
+		while (res->clock_rate[i][clock->nfreqs])
+			clock->nfreqs++;
+
+		if (!clock->nfreqs) {
+			clock->freq = NULL;
+			continue;
+		}
+
+		clock->freq = devm_kcalloc(dev,
+					   clock->nfreqs,
+					   sizeof(*clock->freq),
+					   GFP_KERNEL);
+		if (!clock->freq)
+			return -ENOMEM;
+
+		for (j = 0; j < clock->nfreqs; j++)
+			clock->freq[j] = res->clock_rate[i][j];
+	}
+
+	return 0;
+}
+
+/*
+ * csiphy_link_setup - Setup CSIPHY connections
+ * @entity: Pointer to media entity structure
+ * @local: Pointer to local pad
+ * @remote: Pointer to remote pad
+ * @flags: Link flags
+ *
+ * Rreturn 0 on success
+ */
+static int csiphy_link_setup(struct media_entity *entity,
+			     const struct media_pad *local,
+			     const struct media_pad *remote, u32 flags)
+{
+	if ((local->flags & MEDIA_PAD_FL_SOURCE) &&
+	    (flags & MEDIA_LNK_FL_ENABLED)) {
+		struct v4l2_subdev *sd;
+		struct csiphy_device *csiphy;
+		struct csid_device *csid;
+
+		if (media_entity_remote_pad(local))
+			return -EBUSY;
+
+		sd = media_entity_to_v4l2_subdev(entity);
+		csiphy = v4l2_get_subdevdata(sd);
+
+		sd = media_entity_to_v4l2_subdev(remote->entity);
+		csid = v4l2_get_subdevdata(sd);
+
+		csiphy->cfg.csid_id = csid->id;
+	}
+
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops csiphy_core_ops = {
+	.s_power = csiphy_set_power,
+};
+
+static const struct v4l2_subdev_video_ops csiphy_video_ops = {
+	.s_stream = csiphy_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops csiphy_pad_ops = {
+	.enum_mbus_code = csiphy_enum_mbus_code,
+	.enum_frame_size = csiphy_enum_frame_size,
+	.get_fmt = csiphy_get_format,
+	.set_fmt = csiphy_set_format,
+};
+
+static const struct v4l2_subdev_ops csiphy_v4l2_ops = {
+	.core = &csiphy_core_ops,
+	.video = &csiphy_video_ops,
+	.pad = &csiphy_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops csiphy_v4l2_internal_ops = {
+	.open = csiphy_init_formats,
+};
+
+static const struct media_entity_operations csiphy_media_ops = {
+	.link_setup = csiphy_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+/*
+ * msm_csiphy_register_entity - Register subdev node for CSIPHY module
+ * @csiphy: CSIPHY device
+ * @v4l2_dev: V4L2 device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_csiphy_register_entity(struct csiphy_device *csiphy,
+			       struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd = &csiphy->subdev;
+	struct media_pad *pads = csiphy->pads;
+	struct device *dev = to_device_index(csiphy, csiphy->id);
+	int ret;
+
+	v4l2_subdev_init(sd, &csiphy_v4l2_ops);
+	sd->internal_ops = &csiphy_v4l2_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
+		 MSM_CSIPHY_NAME, csiphy->id);
+	v4l2_set_subdevdata(sd, csiphy);
+
+	ret = csiphy_init_formats(sd, NULL);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init format: %d\n", ret);
+		return ret;
+	}
+
+	pads[MSM_CSIPHY_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[MSM_CSIPHY_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+	sd->entity.function = MEDIA_ENT_F_IO_V4L;
+	sd->entity.ops = &csiphy_media_ops;
+	ret = media_entity_pads_init(&sd->entity, MSM_CSIPHY_PADS_NUM, pads);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init media entity: %d\n", ret);
+		return ret;
+	}
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register subdev: %d\n", ret);
+		media_entity_cleanup(&sd->entity);
+	}
+
+	return ret;
+}
+
+/*
+ * msm_csiphy_unregister_entity - Unregister CSIPHY module subdev node
+ * @csiphy: CSIPHY device
+ */
+void msm_csiphy_unregister_entity(struct csiphy_device *csiphy)
+{
+	v4l2_device_unregister_subdev(&csiphy->subdev);
+	media_entity_cleanup(&csiphy->subdev.entity);
+}
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
new file mode 100644
index 0000000..9a42209
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
@@ -0,0 +1,77 @@
+/*
+ * camss-csiphy.h
+ *
+ * Qualcomm MSM Camera Subsystem - CSIPHY Module
+ *
+ * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2016-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef QC_MSM_CAMSS_CSIPHY_H
+#define QC_MSM_CAMSS_CSIPHY_H
+
+#include <linux/clk.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mediabus.h>
+#include <media/v4l2-subdev.h>
+
+#define MSM_CSIPHY_PAD_SINK 0
+#define MSM_CSIPHY_PAD_SRC 1
+#define MSM_CSIPHY_PADS_NUM 2
+
+struct csiphy_lane {
+	u8 pos;
+	u8 pol;
+};
+
+struct csiphy_lanes_cfg {
+	int num_data;
+	struct csiphy_lane *data;
+	struct csiphy_lane clk;
+};
+
+struct csiphy_csi2_cfg {
+	struct csiphy_lanes_cfg lane_cfg;
+};
+
+struct csiphy_config {
+	u8 combo_mode;
+	u8 csid_id;
+	struct csiphy_csi2_cfg *csi2;
+};
+
+struct csiphy_device {
+	u8 id;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[MSM_CSIPHY_PADS_NUM];
+	void __iomem *base;
+	void __iomem *base_clk_mux;
+	u32 irq;
+	char irq_name[30];
+	struct camss_clock *clock;
+	int nclocks;
+	u32 timer_clk_rate;
+	struct csiphy_config cfg;
+	struct v4l2_mbus_framefmt fmt[MSM_CSIPHY_PADS_NUM];
+};
+
+struct resources;
+
+int msm_csiphy_subdev_init(struct csiphy_device *csiphy,
+			   const struct resources *res, u8 id);
+
+int msm_csiphy_register_entity(struct csiphy_device *csiphy,
+			       struct v4l2_device *v4l2_dev);
+
+void msm_csiphy_unregister_entity(struct csiphy_device *csiphy);
+
+#endif /* QC_MSM_CAMSS_CSIPHY_H */
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
new file mode 100644
index 0000000..636d5e7
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -0,0 +1,1178 @@
+/*
+ * camss-ispif.c
+ *
+ * Qualcomm MSM Camera Subsystem - ISPIF (ISP Interface) Module
+ *
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+#include "camss-ispif.h"
+#include "camss.h"
+
+#define MSM_ISPIF_NAME "msm_ispif"
+
+#define ispif_line_array(ptr_line)	\
+	((const struct ispif_line (*)[]) &(ptr_line[-(ptr_line->id)]))
+
+#define to_ispif(ptr_line)	\
+	container_of(ispif_line_array(ptr_line), struct ispif_device, ptr_line)
+
+#define ISPIF_RST_CMD_0			0x008
+#define ISPIF_RST_CMD_0_STROBED_RST_EN		(1 << 0)
+#define ISPIF_RST_CMD_0_MISC_LOGIC_RST		(1 << 1)
+#define ISPIF_RST_CMD_0_SW_REG_RST		(1 << 2)
+#define ISPIF_RST_CMD_0_PIX_INTF_0_CSID_RST	(1 << 3)
+#define ISPIF_RST_CMD_0_PIX_INTF_0_VFE_RST	(1 << 4)
+#define ISPIF_RST_CMD_0_PIX_INTF_1_CSID_RST	(1 << 5)
+#define ISPIF_RST_CMD_0_PIX_INTF_1_VFE_RST	(1 << 6)
+#define ISPIF_RST_CMD_0_RDI_INTF_0_CSID_RST	(1 << 7)
+#define ISPIF_RST_CMD_0_RDI_INTF_0_VFE_RST	(1 << 8)
+#define ISPIF_RST_CMD_0_RDI_INTF_1_CSID_RST	(1 << 9)
+#define ISPIF_RST_CMD_0_RDI_INTF_1_VFE_RST	(1 << 10)
+#define ISPIF_RST_CMD_0_RDI_INTF_2_CSID_RST	(1 << 11)
+#define ISPIF_RST_CMD_0_RDI_INTF_2_VFE_RST	(1 << 12)
+#define ISPIF_RST_CMD_0_PIX_OUTPUT_0_MISR_RST	(1 << 16)
+#define ISPIF_RST_CMD_0_RDI_OUTPUT_0_MISR_RST	(1 << 17)
+#define ISPIF_RST_CMD_0_RDI_OUTPUT_1_MISR_RST	(1 << 18)
+#define ISPIF_RST_CMD_0_RDI_OUTPUT_2_MISR_RST	(1 << 19)
+#define ISPIF_IRQ_GLOBAL_CLEAR_CMD	0x01c
+#define ISPIF_VFE_m_CTRL_0(m)		(0x200 + 0x200 * (m))
+#define ISPIF_VFE_m_CTRL_0_PIX0_LINE_BUF_EN	(1 << 6)
+#define ISPIF_VFE_m_IRQ_MASK_0(m)	(0x208 + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_MASK_0_PIX0_ENABLE	0x00001249
+#define ISPIF_VFE_m_IRQ_MASK_0_PIX0_MASK	0x00001fff
+#define ISPIF_VFE_m_IRQ_MASK_0_RDI0_ENABLE	0x02492000
+#define ISPIF_VFE_m_IRQ_MASK_0_RDI0_MASK	0x03ffe000
+#define ISPIF_VFE_m_IRQ_MASK_1(m)	(0x20c + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_MASK_1_PIX1_ENABLE	0x00001249
+#define ISPIF_VFE_m_IRQ_MASK_1_PIX1_MASK	0x00001fff
+#define ISPIF_VFE_m_IRQ_MASK_1_RDI1_ENABLE	0x02492000
+#define ISPIF_VFE_m_IRQ_MASK_1_RDI1_MASK	0x03ffe000
+#define ISPIF_VFE_m_IRQ_MASK_2(m)	(0x210 + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_MASK_2_RDI2_ENABLE	0x00001249
+#define ISPIF_VFE_m_IRQ_MASK_2_RDI2_MASK	0x00001fff
+#define ISPIF_VFE_m_IRQ_STATUS_0(m)	(0x21c + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW	(1 << 12)
+#define ISPIF_VFE_m_IRQ_STATUS_0_RDI0_OVERFLOW	(1 << 25)
+#define ISPIF_VFE_m_IRQ_STATUS_1(m)	(0x220 + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_STATUS_1_PIX1_OVERFLOW	(1 << 12)
+#define ISPIF_VFE_m_IRQ_STATUS_1_RDI1_OVERFLOW	(1 << 25)
+#define ISPIF_VFE_m_IRQ_STATUS_2(m)	(0x224 + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_STATUS_2_RDI2_OVERFLOW	(1 << 12)
+#define ISPIF_VFE_m_IRQ_CLEAR_0(m)	(0x230 + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_CLEAR_1(m)	(0x234 + 0x200 * (m))
+#define ISPIF_VFE_m_IRQ_CLEAR_2(m)	(0x238 + 0x200 * (m))
+#define ISPIF_VFE_m_INTF_INPUT_SEL(m)	(0x244 + 0x200 * (m))
+#define ISPIF_VFE_m_INTF_CMD_0(m)	(0x248 + 0x200 * (m))
+#define ISPIF_VFE_m_INTF_CMD_1(m)	(0x24c + 0x200 * (m))
+#define ISPIF_VFE_m_PIX_INTF_n_CID_MASK(m, n)	\
+					(0x254 + 0x200 * (m) + 0x4 * (n))
+#define ISPIF_VFE_m_RDI_INTF_n_CID_MASK(m, n)	\
+					(0x264 + 0x200 * (m) + 0x4 * (n))
+#define ISPIF_VFE_m_PIX_INTF_n_STATUS(m, n)	\
+					(0x2c0 + 0x200 * (m) + 0x4 * (n))
+#define ISPIF_VFE_m_RDI_INTF_n_STATUS(m, n)	\
+					(0x2d0 + 0x200 * (m) + 0x4 * (n))
+
+#define CSI_PIX_CLK_MUX_SEL		0x000
+#define CSI_RDI_CLK_MUX_SEL		0x008
+
+#define ISPIF_TIMEOUT_SLEEP_US		1000
+#define ISPIF_TIMEOUT_ALL_US		1000000
+#define ISPIF_RESET_TIMEOUT_MS		500
+
+enum ispif_intf_cmd {
+	CMD_DISABLE_FRAME_BOUNDARY = 0x0,
+	CMD_ENABLE_FRAME_BOUNDARY = 0x1,
+	CMD_DISABLE_IMMEDIATELY = 0x2,
+	CMD_ALL_DISABLE_IMMEDIATELY = 0xaaaaaaaa,
+	CMD_ALL_NO_CHANGE = 0xffffffff,
+};
+
+static const u32 ispif_formats[] = {
+	MEDIA_BUS_FMT_UYVY8_2X8,
+	MEDIA_BUS_FMT_VYUY8_2X8,
+	MEDIA_BUS_FMT_YUYV8_2X8,
+	MEDIA_BUS_FMT_YVYU8_2X8,
+	MEDIA_BUS_FMT_SBGGR8_1X8,
+	MEDIA_BUS_FMT_SGBRG8_1X8,
+	MEDIA_BUS_FMT_SGRBG8_1X8,
+	MEDIA_BUS_FMT_SRGGB8_1X8,
+	MEDIA_BUS_FMT_SBGGR10_1X10,
+	MEDIA_BUS_FMT_SGBRG10_1X10,
+	MEDIA_BUS_FMT_SGRBG10_1X10,
+	MEDIA_BUS_FMT_SRGGB10_1X10,
+	MEDIA_BUS_FMT_SBGGR12_1X12,
+	MEDIA_BUS_FMT_SGBRG12_1X12,
+	MEDIA_BUS_FMT_SGRBG12_1X12,
+	MEDIA_BUS_FMT_SRGGB12_1X12,
+};
+
+/*
+ * ispif_isr - ISPIF module interrupt handler
+ * @irq: Interrupt line
+ * @dev: ISPIF device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t ispif_isr(int irq, void *dev)
+{
+	struct ispif_device *ispif = dev;
+	u32 value0, value1, value2;
+
+	value0 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_0(0));
+	value1 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_1(0));
+	value2 = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_STATUS_2(0));
+
+	writel_relaxed(value0, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(0));
+	writel_relaxed(value1, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(0));
+	writel_relaxed(value2, ispif->base + ISPIF_VFE_m_IRQ_CLEAR_2(0));
+
+	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
+
+	if ((value0 >> 27) & 0x1)
+		complete(&ispif->reset_complete);
+
+	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 pix0 overflow\n");
+
+	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_RDI0_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 rdi0 overflow\n");
+
+	if (unlikely(value1 & ISPIF_VFE_m_IRQ_STATUS_1_PIX1_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 pix1 overflow\n");
+
+	if (unlikely(value1 & ISPIF_VFE_m_IRQ_STATUS_1_RDI1_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 rdi1 overflow\n");
+
+	if (unlikely(value2 & ISPIF_VFE_m_IRQ_STATUS_2_RDI2_OVERFLOW))
+		dev_err_ratelimited(to_device(ispif), "VFE0 rdi2 overflow\n");
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * ispif_reset - Trigger reset on ISPIF module and wait to complete
+ * @ispif: ISPIF device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int ispif_reset(struct ispif_device *ispif)
+{
+	unsigned long time;
+	u32 val;
+	int ret;
+
+	ret = camss_enable_clocks(ispif->nclocks_for_reset,
+				  ispif->clock_for_reset,
+				  to_device(ispif));
+	if (ret < 0)
+		return ret;
+
+	reinit_completion(&ispif->reset_complete);
+
+	val = ISPIF_RST_CMD_0_STROBED_RST_EN |
+		ISPIF_RST_CMD_0_MISC_LOGIC_RST |
+		ISPIF_RST_CMD_0_SW_REG_RST |
+		ISPIF_RST_CMD_0_PIX_INTF_0_CSID_RST |
+		ISPIF_RST_CMD_0_PIX_INTF_0_VFE_RST |
+		ISPIF_RST_CMD_0_PIX_INTF_1_CSID_RST |
+		ISPIF_RST_CMD_0_PIX_INTF_1_VFE_RST |
+		ISPIF_RST_CMD_0_RDI_INTF_0_CSID_RST |
+		ISPIF_RST_CMD_0_RDI_INTF_0_VFE_RST |
+		ISPIF_RST_CMD_0_RDI_INTF_1_CSID_RST |
+		ISPIF_RST_CMD_0_RDI_INTF_1_VFE_RST |
+		ISPIF_RST_CMD_0_RDI_INTF_2_CSID_RST |
+		ISPIF_RST_CMD_0_RDI_INTF_2_VFE_RST |
+		ISPIF_RST_CMD_0_PIX_OUTPUT_0_MISR_RST |
+		ISPIF_RST_CMD_0_RDI_OUTPUT_0_MISR_RST |
+		ISPIF_RST_CMD_0_RDI_OUTPUT_1_MISR_RST |
+		ISPIF_RST_CMD_0_RDI_OUTPUT_2_MISR_RST;
+
+	writel_relaxed(val, ispif->base + ISPIF_RST_CMD_0);
+
+	time = wait_for_completion_timeout(&ispif->reset_complete,
+		msecs_to_jiffies(ISPIF_RESET_TIMEOUT_MS));
+	if (!time) {
+		dev_err(to_device(ispif), "ISPIF reset timeout\n");
+		return -EIO;
+	}
+
+	camss_disable_clocks(ispif->nclocks_for_reset, ispif->clock_for_reset);
+
+	return 0;
+}
+
+/*
+ * ispif_set_power - Power on/off ISPIF module
+ * @sd: ISPIF V4L2 subdevice
+ * @on: Requested power state
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int ispif_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct ispif_line *line = v4l2_get_subdevdata(sd);
+	struct ispif_device *ispif = to_ispif(line);
+	struct device *dev = to_device(ispif);
+	int ret = 0;
+
+	mutex_lock(&ispif->power_lock);
+
+	if (on) {
+		if (ispif->power_count) {
+			/* Power is already on */
+			ispif->power_count++;
+			goto exit;
+		}
+
+		ret = camss_enable_clocks(ispif->nclocks, ispif->clock, dev);
+		if (ret < 0)
+			goto exit;
+
+		ret = ispif_reset(ispif);
+		if (ret < 0) {
+			camss_disable_clocks(ispif->nclocks, ispif->clock);
+			goto exit;
+		}
+
+		ispif->intf_cmd[line->vfe_id].cmd_0 = CMD_ALL_NO_CHANGE;
+		ispif->intf_cmd[line->vfe_id].cmd_1 = CMD_ALL_NO_CHANGE;
+
+		ispif->power_count++;
+	} else {
+		if (ispif->power_count == 0) {
+			dev_err(dev, "ispif power off on power_count == 0\n");
+			goto exit;
+		} else if (ispif->power_count == 1) {
+			camss_disable_clocks(ispif->nclocks, ispif->clock);
+		}
+
+		ispif->power_count--;
+	}
+
+exit:
+	mutex_unlock(&ispif->power_lock);
+
+	return ret;
+}
+
+/*
+ * ispif_select_clk_mux - Select clock for PIX/RDI interface
+ * @ispif: ISPIF device
+ * @intf: VFE interface
+ * @csid: CSID HW module id
+ * @vfe: VFE HW module id
+ * @enable: enable or disable the selected clock
+ */
+static void ispif_select_clk_mux(struct ispif_device *ispif,
+				 enum ispif_intf intf, u8 csid,
+				 u8 vfe, u8 enable)
+{
+	u32 val;
+
+	switch (intf) {
+	case PIX0:
+		val = readl_relaxed(ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
+		val &= ~(0xf << (vfe * 8));
+		if (enable)
+			val |= (csid << (vfe * 8));
+		writel_relaxed(val, ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
+		break;
+
+	case RDI0:
+		val = readl_relaxed(ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
+		val &= ~(0xf << (vfe * 12));
+		if (enable)
+			val |= (csid << (vfe * 12));
+		writel_relaxed(val, ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
+		break;
+
+	case PIX1:
+		val = readl_relaxed(ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
+		val &= ~(0xf << (4 + (vfe * 8)));
+		if (enable)
+			val |= (csid << (4 + (vfe * 8)));
+		writel_relaxed(val, ispif->base_clk_mux + CSI_PIX_CLK_MUX_SEL);
+		break;
+
+	case RDI1:
+		val = readl_relaxed(ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
+		val &= ~(0xf << (4 + (vfe * 12)));
+		if (enable)
+			val |= (csid << (4 + (vfe * 12)));
+		writel_relaxed(val, ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
+		break;
+
+	case RDI2:
+		val = readl_relaxed(ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
+		val &= ~(0xf << (8 + (vfe * 12)));
+		if (enable)
+			val |= (csid << (8 + (vfe * 12)));
+		writel_relaxed(val, ispif->base_clk_mux + CSI_RDI_CLK_MUX_SEL);
+		break;
+	}
+
+	mb();
+}
+
+/*
+ * ispif_validate_intf_status - Validate current status of PIX/RDI interface
+ * @ispif: ISPIF device
+ * @intf: VFE interface
+ * @vfe: VFE HW module id
+ *
+ * Return 0 when interface is idle or -EBUSY otherwise
+ */
+static int ispif_validate_intf_status(struct ispif_device *ispif,
+				      enum ispif_intf intf, u8 vfe)
+{
+	int ret = 0;
+	u32 val = 0;
+
+	switch (intf) {
+	case PIX0:
+		val = readl_relaxed(ispif->base +
+			ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 0));
+		break;
+	case RDI0:
+		val = readl_relaxed(ispif->base +
+			ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 0));
+		break;
+	case PIX1:
+		val = readl_relaxed(ispif->base +
+			ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 1));
+		break;
+	case RDI1:
+		val = readl_relaxed(ispif->base +
+			ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 1));
+		break;
+	case RDI2:
+		val = readl_relaxed(ispif->base +
+			ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 2));
+		break;
+	}
+
+	if ((val & 0xf) != 0xf) {
+		dev_err(to_device(ispif), "%s: ispif is busy: 0x%x\n",
+			__func__, val);
+		ret = -EBUSY;
+	}
+
+	return ret;
+}
+
+/*
+ * ispif_wait_for_stop - Wait for PIX/RDI interface to stop
+ * @ispif: ISPIF device
+ * @intf: VFE interface
+ * @vfe: VFE HW module id
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int ispif_wait_for_stop(struct ispif_device *ispif,
+			       enum ispif_intf intf, u8 vfe)
+{
+	u32 addr = 0;
+	u32 stop_flag = 0;
+	int ret;
+
+	switch (intf) {
+	case PIX0:
+		addr = ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 0);
+		break;
+	case RDI0:
+		addr = ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 0);
+		break;
+	case PIX1:
+		addr = ISPIF_VFE_m_PIX_INTF_n_STATUS(vfe, 1);
+		break;
+	case RDI1:
+		addr = ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 1);
+		break;
+	case RDI2:
+		addr = ISPIF_VFE_m_RDI_INTF_n_STATUS(vfe, 2);
+		break;
+	}
+
+	ret = readl_poll_timeout(ispif->base + addr,
+				 stop_flag,
+				 (stop_flag & 0xf) == 0xf,
+				 ISPIF_TIMEOUT_SLEEP_US,
+				 ISPIF_TIMEOUT_ALL_US);
+	if (ret < 0)
+		dev_err(to_device(ispif), "%s: ispif stop timeout\n",
+			__func__);
+
+	return ret;
+}
+
+/*
+ * ispif_select_csid - Select CSID HW module for input from
+ * @ispif: ISPIF device
+ * @intf: VFE interface
+ * @csid: CSID HW module id
+ * @vfe: VFE HW module id
+ * @enable: enable or disable the selected input
+ */
+static void ispif_select_csid(struct ispif_device *ispif, enum ispif_intf intf,
+			      u8 csid, u8 vfe, u8 enable)
+{
+	u32 val;
+
+	val = readl_relaxed(ispif->base + ISPIF_VFE_m_INTF_INPUT_SEL(vfe));
+	switch (intf) {
+	case PIX0:
+		val &= ~(BIT(1) | BIT(0));
+		if (enable)
+			val |= csid;
+		break;
+	case RDI0:
+		val &= ~(BIT(5) | BIT(4));
+		if (enable)
+			val |= (csid << 4);
+		break;
+	case PIX1:
+		val &= ~(BIT(9) | BIT(8));
+		if (enable)
+			val |= (csid << 8);
+		break;
+	case RDI1:
+		val &= ~(BIT(13) | BIT(12));
+		if (enable)
+			val |= (csid << 12);
+		break;
+	case RDI2:
+		val &= ~(BIT(21) | BIT(20));
+		if (enable)
+			val |= (csid << 20);
+		break;
+	}
+
+	writel(val, ispif->base + ISPIF_VFE_m_INTF_INPUT_SEL(vfe));
+}
+
+/*
+ * ispif_select_cid - Enable/disable desired CID
+ * @ispif: ISPIF device
+ * @intf: VFE interface
+ * @cid: desired CID to enable/disable
+ * @vfe: VFE HW module id
+ * @enable: enable or disable the desired CID
+ */
+static void ispif_select_cid(struct ispif_device *ispif, enum ispif_intf intf,
+			     u8 cid, u8 vfe, u8 enable)
+{
+	u32 cid_mask = 1 << cid;
+	u32 addr = 0;
+	u32 val;
+
+	switch (intf) {
+	case PIX0:
+		addr = ISPIF_VFE_m_PIX_INTF_n_CID_MASK(vfe, 0);
+		break;
+	case RDI0:
+		addr = ISPIF_VFE_m_RDI_INTF_n_CID_MASK(vfe, 0);
+		break;
+	case PIX1:
+		addr = ISPIF_VFE_m_PIX_INTF_n_CID_MASK(vfe, 1);
+		break;
+	case RDI1:
+		addr = ISPIF_VFE_m_RDI_INTF_n_CID_MASK(vfe, 1);
+		break;
+	case RDI2:
+		addr = ISPIF_VFE_m_RDI_INTF_n_CID_MASK(vfe, 2);
+		break;
+	}
+
+	val = readl_relaxed(ispif->base + addr);
+	if (enable)
+		val |= cid_mask;
+	else
+		val &= ~cid_mask;
+
+	writel(val, ispif->base + addr);
+}
+
+/*
+ * ispif_config_irq - Enable/disable interrupts for PIX/RDI interface
+ * @ispif: ISPIF device
+ * @intf: VFE interface
+ * @vfe: VFE HW module id
+ * @enable: enable or disable
+ */
+static void ispif_config_irq(struct ispif_device *ispif, enum ispif_intf intf,
+			     u8 vfe, u8 enable)
+{
+	u32 val;
+
+	switch (intf) {
+	case PIX0:
+		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
+		val &= ~ISPIF_VFE_m_IRQ_MASK_0_PIX0_MASK;
+		if (enable)
+			val |= ISPIF_VFE_m_IRQ_MASK_0_PIX0_ENABLE;
+		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
+		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_0_PIX0_ENABLE,
+			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(vfe));
+		break;
+	case RDI0:
+		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
+		val &= ~ISPIF_VFE_m_IRQ_MASK_0_RDI0_MASK;
+		if (enable)
+			val |= ISPIF_VFE_m_IRQ_MASK_0_RDI0_ENABLE;
+		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_0(vfe));
+		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_0_RDI0_ENABLE,
+			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_0(vfe));
+		break;
+	case PIX1:
+		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
+		val &= ~ISPIF_VFE_m_IRQ_MASK_1_PIX1_MASK;
+		if (enable)
+			val |= ISPIF_VFE_m_IRQ_MASK_1_PIX1_ENABLE;
+		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
+		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_1_PIX1_ENABLE,
+			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(vfe));
+		break;
+	case RDI1:
+		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
+		val &= ~ISPIF_VFE_m_IRQ_MASK_1_RDI1_MASK;
+		if (enable)
+			val |= ISPIF_VFE_m_IRQ_MASK_1_RDI1_ENABLE;
+		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_1(vfe));
+		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_1_RDI1_ENABLE,
+			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_1(vfe));
+		break;
+	case RDI2:
+		val = readl_relaxed(ispif->base + ISPIF_VFE_m_IRQ_MASK_2(vfe));
+		val &= ~ISPIF_VFE_m_IRQ_MASK_2_RDI2_MASK;
+		if (enable)
+			val |= ISPIF_VFE_m_IRQ_MASK_2_RDI2_ENABLE;
+		writel_relaxed(val, ispif->base + ISPIF_VFE_m_IRQ_MASK_2(vfe));
+		writel_relaxed(ISPIF_VFE_m_IRQ_MASK_2_RDI2_ENABLE,
+			       ispif->base + ISPIF_VFE_m_IRQ_CLEAR_2(vfe));
+		break;
+	}
+
+	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
+}
+
+/*
+ * ispif_set_intf_cmd - Set command to enable/disable interface
+ * @ispif: ISPIF device
+ * @cmd: interface command
+ * @intf: VFE interface
+ * @vfe: VFE HW module id
+ * @vc: virtual channel
+ */
+static void ispif_set_intf_cmd(struct ispif_device *ispif, u8 cmd,
+			       enum ispif_intf intf, u8 vfe, u8 vc)
+{
+	u32 *val;
+
+	if (intf == RDI2) {
+		val = &ispif->intf_cmd[vfe].cmd_1;
+		*val &= ~(0x3 << (vc * 2 + 8));
+		*val |= (cmd << (vc * 2 + 8));
+		wmb();
+		writel_relaxed(*val, ispif->base + ISPIF_VFE_m_INTF_CMD_1(vfe));
+		wmb();
+	} else {
+		val = &ispif->intf_cmd[vfe].cmd_0;
+		*val &= ~(0x3 << (vc * 2 + intf * 8));
+		*val |= (cmd << (vc * 2 + intf * 8));
+		wmb();
+		writel_relaxed(*val, ispif->base + ISPIF_VFE_m_INTF_CMD_0(vfe));
+		wmb();
+	}
+}
+
+/*
+ * ispif_set_stream - Enable/disable streaming on ISPIF module
+ * @sd: ISPIF V4L2 subdevice
+ * @enable: Requested streaming state
+ *
+ * Main configuration of ISPIF module is also done here.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int ispif_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct ispif_line *line = v4l2_get_subdevdata(sd);
+	struct ispif_device *ispif = to_ispif(line);
+	enum ispif_intf intf = line->interface;
+	u8 csid = line->csid_id;
+	u8 vfe = line->vfe_id;
+	u8 vc = 0; /* Virtual Channel 0 */
+	u8 cid = vc * 4; /* id of Virtual Channel and Data Type set */
+	int ret;
+
+	if (enable) {
+		if (!media_entity_remote_pad(&line->pads[MSM_ISPIF_PAD_SINK]))
+			return -ENOLINK;
+
+		/* Config */
+
+		mutex_lock(&ispif->config_lock);
+		ispif_select_clk_mux(ispif, intf, csid, vfe, 1);
+
+		ret = ispif_validate_intf_status(ispif, intf, vfe);
+		if (ret < 0) {
+			mutex_unlock(&ispif->config_lock);
+			return ret;
+		}
+
+		ispif_select_csid(ispif, intf, csid, vfe, 1);
+		ispif_select_cid(ispif, intf, cid, vfe, 1);
+		ispif_config_irq(ispif, intf, vfe, 1);
+		ispif_set_intf_cmd(ispif, CMD_ENABLE_FRAME_BOUNDARY,
+				   intf, vfe, vc);
+	} else {
+		mutex_lock(&ispif->config_lock);
+		ispif_set_intf_cmd(ispif, CMD_DISABLE_FRAME_BOUNDARY,
+				   intf, vfe, vc);
+		mutex_unlock(&ispif->config_lock);
+
+		ret = ispif_wait_for_stop(ispif, intf, vfe);
+		if (ret < 0)
+			return ret;
+
+		mutex_lock(&ispif->config_lock);
+		ispif_config_irq(ispif, intf, vfe, 0);
+		ispif_select_cid(ispif, intf, cid, vfe, 0);
+		ispif_select_csid(ispif, intf, csid, vfe, 0);
+		ispif_select_clk_mux(ispif, intf, csid, vfe, 0);
+	}
+
+	mutex_unlock(&ispif->config_lock);
+
+	return 0;
+}
+
+/*
+ * __ispif_get_format - Get pointer to format structure
+ * @ispif: ISPIF line
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad from which format is requested
+ * @which: TRY or ACTIVE format
+ *
+ * Return pointer to TRY or ACTIVE format structure
+ */
+static struct v4l2_mbus_framefmt *
+__ispif_get_format(struct ispif_line *line,
+		   struct v4l2_subdev_pad_config *cfg,
+		   unsigned int pad,
+		   enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&line->subdev, cfg, pad);
+
+	return &line->fmt[pad];
+}
+
+/*
+ * ispif_try_format - Handle try format by pad subdev method
+ * @ispif: ISPIF line
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad on which format is requested
+ * @fmt: pointer to v4l2 format structure
+ * @which: wanted subdev format
+ */
+static void ispif_try_format(struct ispif_line *line,
+			     struct v4l2_subdev_pad_config *cfg,
+			     unsigned int pad,
+			     struct v4l2_mbus_framefmt *fmt,
+			     enum v4l2_subdev_format_whence which)
+{
+	unsigned int i;
+
+	switch (pad) {
+	case MSM_ISPIF_PAD_SINK:
+		/* Set format on sink pad */
+
+		for (i = 0; i < ARRAY_SIZE(ispif_formats); i++)
+			if (fmt->code == ispif_formats[i])
+				break;
+
+		/* If not found, use UYVY as default */
+		if (i >= ARRAY_SIZE(ispif_formats))
+			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
+		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
+		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
+
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+
+		break;
+
+	case MSM_ISPIF_PAD_SRC:
+		/* Set and return a format same as sink pad */
+
+		*fmt = *__ispif_get_format(line, cfg, MSM_ISPIF_PAD_SINK,
+					   which);
+
+		break;
+	}
+
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+}
+
+/*
+ * ispif_enum_mbus_code - Handle pixel format enumeration
+ * @sd: ISPIF V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @code: pointer to v4l2_subdev_mbus_code_enum structure
+ * return -EINVAL or zero on success
+ */
+static int ispif_enum_mbus_code(struct v4l2_subdev *sd,
+				struct v4l2_subdev_pad_config *cfg,
+				struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct ispif_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	if (code->pad == MSM_ISPIF_PAD_SINK) {
+		if (code->index >= ARRAY_SIZE(ispif_formats))
+			return -EINVAL;
+
+		code->code = ispif_formats[code->index];
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+
+		format = __ispif_get_format(line, cfg, MSM_ISPIF_PAD_SINK,
+					    code->which);
+
+		code->code = format->code;
+	}
+
+	return 0;
+}
+
+/*
+ * ispif_enum_frame_size - Handle frame size enumeration
+ * @sd: ISPIF V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fse: pointer to v4l2_subdev_frame_size_enum structure
+ * return -EINVAL or zero on success
+ */
+static int ispif_enum_frame_size(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_pad_config *cfg,
+				 struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct ispif_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	ispif_try_format(line, cfg, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	ispif_try_format(line, cfg, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+/*
+ * ispif_get_format - Handle get format by pads subdev method
+ * @sd: ISPIF V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int ispif_get_format(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_pad_config *cfg,
+			    struct v4l2_subdev_format *fmt)
+{
+	struct ispif_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __ispif_get_format(line, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+/*
+ * ispif_set_format - Handle set format by pads subdev method
+ * @sd: ISPIF V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int ispif_set_format(struct v4l2_subdev *sd,
+			    struct v4l2_subdev_pad_config *cfg,
+			    struct v4l2_subdev_format *fmt)
+{
+	struct ispif_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __ispif_get_format(line, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	ispif_try_format(line, cfg, fmt->pad, &fmt->format, fmt->which);
+	*format = fmt->format;
+
+	/* Propagate the format from sink to source */
+	if (fmt->pad == MSM_ISPIF_PAD_SINK) {
+		format = __ispif_get_format(line, cfg, MSM_ISPIF_PAD_SRC,
+					    fmt->which);
+
+		*format = fmt->format;
+		ispif_try_format(line, cfg, MSM_ISPIF_PAD_SRC, format,
+				 fmt->which);
+	}
+
+	return 0;
+}
+
+/*
+ * ispif_init_formats - Initialize formats on all pads
+ * @sd: ISPIF V4L2 subdevice
+ * @fh: V4L2 subdev file handle
+ *
+ * Initialize all pad formats with default values.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int ispif_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = MSM_ISPIF_PAD_SINK,
+		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
+			      V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_UYVY8_2X8,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return ispif_set_format(sd, fh ? fh->pad : NULL, &format);
+}
+
+/*
+ * msm_ispif_subdev_init - Initialize ISPIF device structure and resources
+ * @ispif: ISPIF device
+ * @res: ISPIF module resources table
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_ispif_subdev_init(struct ispif_device *ispif,
+			  const struct resources_ispif *res)
+{
+	struct device *dev = to_device(ispif);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *r;
+	int i;
+	int ret;
+
+	/* Memory */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
+	ispif->base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(ispif->base)) {
+		dev_err(dev, "could not map memory\n");
+		return PTR_ERR(ispif->base);
+	}
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[1]);
+	ispif->base_clk_mux = devm_ioremap_resource(dev, r);
+	if (IS_ERR(ispif->base_clk_mux)) {
+		dev_err(dev, "could not map memory\n");
+		return PTR_ERR(ispif->base_clk_mux);
+	}
+
+	/* Interrupt */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res->interrupt);
+
+	if (!r) {
+		dev_err(dev, "missing IRQ\n");
+		return -EINVAL;
+	}
+
+	ispif->irq = r->start;
+	snprintf(ispif->irq_name, sizeof(ispif->irq_name), "%s_%s",
+		 dev_name(dev), MSM_ISPIF_NAME);
+	ret = devm_request_irq(dev, ispif->irq, ispif_isr,
+			       IRQF_TRIGGER_RISING, ispif->irq_name, ispif);
+	if (ret < 0) {
+		dev_err(dev, "request_irq failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Clocks */
+
+	ispif->nclocks = 0;
+	while (res->clock[ispif->nclocks])
+		ispif->nclocks++;
+
+	ispif->clock = devm_kcalloc(dev,
+				    ispif->nclocks, sizeof(*ispif->clock),
+				    GFP_KERNEL);
+	if (!ispif->clock)
+		return -ENOMEM;
+
+	for (i = 0; i < ispif->nclocks; i++) {
+		struct camss_clock *clock = &ispif->clock[i];
+
+		clock->clk = devm_clk_get(dev, res->clock[i]);
+		if (IS_ERR(clock->clk))
+			return PTR_ERR(clock->clk);
+
+		clock->freq = NULL;
+		clock->nfreqs = 0;
+	}
+
+	ispif->nclocks_for_reset = 0;
+	while (res->clock_for_reset[ispif->nclocks_for_reset])
+		ispif->nclocks_for_reset++;
+
+	ispif->clock_for_reset = devm_kcalloc(dev,
+					      ispif->nclocks_for_reset,
+					      sizeof(*ispif->clock_for_reset),
+					      GFP_KERNEL);
+	if (!ispif->clock_for_reset)
+		return -ENOMEM;
+
+	for (i = 0; i < ispif->nclocks_for_reset; i++) {
+		struct camss_clock *clock = &ispif->clock_for_reset[i];
+
+		clock->clk = devm_clk_get(dev, res->clock_for_reset[i]);
+		if (IS_ERR(clock->clk))
+			return PTR_ERR(clock->clk);
+
+		clock->freq = NULL;
+		clock->nfreqs = 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ispif->line); i++)
+		ispif->line[i].id = i;
+
+	mutex_init(&ispif->power_lock);
+	ispif->power_count = 0;
+
+	mutex_init(&ispif->config_lock);
+
+	init_completion(&ispif->reset_complete);
+
+	return 0;
+}
+
+/*
+ * ispif_get_intf - Get ISPIF interface to use by VFE line id
+ * @line_id: VFE line id that the ISPIF line is connected to
+ *
+ * Return ISPIF interface to use
+ */
+static enum ispif_intf ispif_get_intf(enum vfe_line_id line_id)
+{
+	switch (line_id) {
+	case (VFE_LINE_RDI0):
+		return RDI0;
+	case (VFE_LINE_RDI1):
+		return RDI1;
+	case (VFE_LINE_RDI2):
+		return RDI2;
+	case (VFE_LINE_PIX):
+		return PIX0;
+	default:
+		return RDI0;
+	}
+}
+
+/*
+ * ispif_link_setup - Setup ISPIF connections
+ * @entity: Pointer to media entity structure
+ * @local: Pointer to local pad
+ * @remote: Pointer to remote pad
+ * @flags: Link flags
+ *
+ * Return 0 on success
+ */
+static int ispif_link_setup(struct media_entity *entity,
+			    const struct media_pad *local,
+			    const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED) {
+		if (media_entity_remote_pad(local))
+			return -EBUSY;
+
+		if (local->flags & MEDIA_PAD_FL_SINK) {
+			struct v4l2_subdev *sd;
+			struct ispif_line *line;
+
+			sd = media_entity_to_v4l2_subdev(entity);
+			line = v4l2_get_subdevdata(sd);
+
+			msm_csid_get_csid_id(remote->entity, &line->csid_id);
+		} else { /* MEDIA_PAD_FL_SOURCE */
+			struct v4l2_subdev *sd;
+			struct ispif_line *line;
+			enum vfe_line_id id;
+
+			sd = media_entity_to_v4l2_subdev(entity);
+			line = v4l2_get_subdevdata(sd);
+
+			msm_vfe_get_vfe_id(remote->entity, &line->vfe_id);
+			msm_vfe_get_vfe_line_id(remote->entity, &id);
+			line->interface = ispif_get_intf(id);
+		}
+	}
+
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops ispif_core_ops = {
+	.s_power = ispif_set_power,
+};
+
+static const struct v4l2_subdev_video_ops ispif_video_ops = {
+	.s_stream = ispif_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops ispif_pad_ops = {
+	.enum_mbus_code = ispif_enum_mbus_code,
+	.enum_frame_size = ispif_enum_frame_size,
+	.get_fmt = ispif_get_format,
+	.set_fmt = ispif_set_format,
+};
+
+static const struct v4l2_subdev_ops ispif_v4l2_ops = {
+	.core = &ispif_core_ops,
+	.video = &ispif_video_ops,
+	.pad = &ispif_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops ispif_v4l2_internal_ops = {
+	.open = ispif_init_formats,
+};
+
+static const struct media_entity_operations ispif_media_ops = {
+	.link_setup = ispif_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+/*
+ * msm_ispif_register_entities - Register subdev node for ISPIF module
+ * @ispif: ISPIF device
+ * @v4l2_dev: V4L2 device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_ispif_register_entities(struct ispif_device *ispif,
+				struct v4l2_device *v4l2_dev)
+{
+	struct device *dev = to_device(ispif);
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ispif->line); i++) {
+		struct v4l2_subdev *sd = &ispif->line[i].subdev;
+		struct media_pad *pads = ispif->line[i].pads;
+
+		v4l2_subdev_init(sd, &ispif_v4l2_ops);
+		sd->internal_ops = &ispif_v4l2_internal_ops;
+		sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+		snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d",
+			 MSM_ISPIF_NAME, i);
+		v4l2_set_subdevdata(sd, &ispif->line[i]);
+
+		ret = ispif_init_formats(sd, NULL);
+		if (ret < 0) {
+			dev_err(dev, "Failed to init format: %d\n", ret);
+			goto error;
+		}
+
+		pads[MSM_ISPIF_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+		pads[MSM_ISPIF_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+		sd->entity.function = MEDIA_ENT_F_IO_V4L;
+		sd->entity.ops = &ispif_media_ops;
+		ret = media_entity_pads_init(&sd->entity, MSM_ISPIF_PADS_NUM,
+					     pads);
+		if (ret < 0) {
+			dev_err(dev, "Failed to init media entity: %d\n", ret);
+			goto error;
+		}
+
+		ret = v4l2_device_register_subdev(v4l2_dev, sd);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register subdev: %d\n", ret);
+			media_entity_cleanup(&sd->entity);
+			goto error;
+		}
+	}
+
+	return 0;
+
+error:
+	for (i--; i >= 0; i--) {
+		struct v4l2_subdev *sd = &ispif->line[i].subdev;
+
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+	}
+
+	return ret;
+}
+
+/*
+ * msm_ispif_unregister_entities - Unregister ISPIF module subdev node
+ * @ispif: ISPIF device
+ */
+void msm_ispif_unregister_entities(struct ispif_device *ispif)
+{
+	int i;
+
+	mutex_destroy(&ispif->power_lock);
+	mutex_destroy(&ispif->config_lock);
+
+	for (i = 0; i < ARRAY_SIZE(ispif->line); i++) {
+		struct v4l2_subdev *sd = &ispif->line[i].subdev;
+
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+	}
+}
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.h b/drivers/media/platform/qcom/camss/camss-ispif.h
new file mode 100644
index 0000000..c90e159
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-ispif.h
@@ -0,0 +1,85 @@
+/*
+ * camss-ispif.h
+ *
+ * Qualcomm MSM Camera Subsystem - ISPIF (ISP Interface) Module
+ *
+ * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef QC_MSM_CAMSS_ISPIF_H
+#define QC_MSM_CAMSS_ISPIF_H
+
+#include <linux/clk.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+/* Number of ISPIF lines - same as number of CSID hardware modules */
+#define MSM_ISPIF_LINE_NUM 2
+
+#define MSM_ISPIF_PAD_SINK 0
+#define MSM_ISPIF_PAD_SRC 1
+#define MSM_ISPIF_PADS_NUM 2
+
+#define MSM_ISPIF_VFE_NUM 1
+
+enum ispif_intf {
+	PIX0,
+	RDI0,
+	PIX1,
+	RDI1,
+	RDI2
+};
+
+struct ispif_intf_cmd_reg {
+	u32 cmd_0;
+	u32 cmd_1;
+};
+
+struct ispif_line {
+	u8 id;
+	u8 csid_id;
+	u8 vfe_id;
+	enum ispif_intf interface;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[MSM_ISPIF_PADS_NUM];
+	struct v4l2_mbus_framefmt fmt[MSM_ISPIF_PADS_NUM];
+};
+
+struct ispif_device {
+	void __iomem *base;
+	void __iomem *base_clk_mux;
+	u32 irq;
+	char irq_name[30];
+	struct camss_clock *clock;
+	int nclocks;
+	struct camss_clock  *clock_for_reset;
+	int nclocks_for_reset;
+	struct completion reset_complete;
+	int power_count;
+	struct mutex power_lock;
+	struct ispif_intf_cmd_reg intf_cmd[MSM_ISPIF_VFE_NUM];
+	struct mutex config_lock;
+	struct ispif_line line[MSM_ISPIF_LINE_NUM];
+};
+
+struct resources_ispif;
+
+int msm_ispif_subdev_init(struct ispif_device *ispif,
+			  const struct resources_ispif *res);
+
+int msm_ispif_register_entities(struct ispif_device *ispif,
+				struct v4l2_device *v4l2_dev);
+
+void msm_ispif_unregister_entities(struct ispif_device *ispif);
+
+#endif /* QC_MSM_CAMSS_ISPIF_H */
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
new file mode 100644
index 0000000..380b90b
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -0,0 +1,3093 @@
+/*
+ * camss-vfe.c
+ *
+ * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module
+ *
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock_types.h>
+#include <linux/spinlock.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+#include "camss-vfe.h"
+#include "camss.h"
+
+#define MSM_VFE_NAME "msm_vfe"
+
+#define vfe_line_array(ptr_line)	\
+	((const struct vfe_line (*)[]) &(ptr_line[-(ptr_line->id)]))
+
+#define to_vfe(ptr_line)	\
+	container_of(vfe_line_array(ptr_line), struct vfe_device, ptr_line)
+
+#define VFE_0_HW_VERSION		0x000
+
+#define VFE_0_GLOBAL_RESET_CMD		0x00c
+#define VFE_0_GLOBAL_RESET_CMD_CORE	(1 << 0)
+#define VFE_0_GLOBAL_RESET_CMD_CAMIF	(1 << 1)
+#define VFE_0_GLOBAL_RESET_CMD_BUS	(1 << 2)
+#define VFE_0_GLOBAL_RESET_CMD_BUS_BDG	(1 << 3)
+#define VFE_0_GLOBAL_RESET_CMD_REGISTER	(1 << 4)
+#define VFE_0_GLOBAL_RESET_CMD_TIMER	(1 << 5)
+#define VFE_0_GLOBAL_RESET_CMD_PM	(1 << 6)
+#define VFE_0_GLOBAL_RESET_CMD_BUS_MISR	(1 << 7)
+#define VFE_0_GLOBAL_RESET_CMD_TESTGEN	(1 << 8)
+
+#define VFE_0_MODULE_CFG		0x018
+#define VFE_0_MODULE_CFG_DEMUX			(1 << 2)
+#define VFE_0_MODULE_CFG_CHROMA_UPSAMPLE	(1 << 3)
+#define VFE_0_MODULE_CFG_SCALE_ENC		(1 << 23)
+#define VFE_0_MODULE_CFG_CROP_ENC		(1 << 27)
+
+#define VFE_0_CORE_CFG			0x01c
+#define VFE_0_CORE_CFG_PIXEL_PATTERN_YCBYCR	0x4
+#define VFE_0_CORE_CFG_PIXEL_PATTERN_YCRYCB	0x5
+#define VFE_0_CORE_CFG_PIXEL_PATTERN_CBYCRY	0x6
+#define VFE_0_CORE_CFG_PIXEL_PATTERN_CRYCBY	0x7
+
+#define VFE_0_IRQ_CMD			0x024
+#define VFE_0_IRQ_CMD_GLOBAL_CLEAR	(1 << 0)
+
+#define VFE_0_IRQ_MASK_0		0x028
+#define VFE_0_IRQ_MASK_0_CAMIF_SOF			(1 << 0)
+#define VFE_0_IRQ_MASK_0_CAMIF_EOF			(1 << 1)
+#define VFE_0_IRQ_MASK_0_RDIn_REG_UPDATE(n)		(1 << ((n) + 5))
+#define VFE_0_IRQ_MASK_0_line_n_REG_UPDATE(n)		\
+	((n) == VFE_LINE_PIX ? (1 << 4) : VFE_0_IRQ_MASK_0_RDIn_REG_UPDATE(n))
+#define VFE_0_IRQ_MASK_0_IMAGE_MASTER_n_PING_PONG(n)	(1 << ((n) + 8))
+#define VFE_0_IRQ_MASK_0_IMAGE_COMPOSITE_DONE_n(n)	(1 << ((n) + 25))
+#define VFE_0_IRQ_MASK_0_RESET_ACK			(1 << 31)
+#define VFE_0_IRQ_MASK_1		0x02c
+#define VFE_0_IRQ_MASK_1_CAMIF_ERROR			(1 << 0)
+#define VFE_0_IRQ_MASK_1_VIOLATION			(1 << 7)
+#define VFE_0_IRQ_MASK_1_BUS_BDG_HALT_ACK		(1 << 8)
+#define VFE_0_IRQ_MASK_1_IMAGE_MASTER_n_BUS_OVERFLOW(n)	(1 << ((n) + 9))
+#define VFE_0_IRQ_MASK_1_RDIn_SOF(n)			(1 << ((n) + 29))
+
+#define VFE_0_IRQ_CLEAR_0		0x030
+#define VFE_0_IRQ_CLEAR_1		0x034
+
+#define VFE_0_IRQ_STATUS_0		0x038
+#define VFE_0_IRQ_STATUS_0_CAMIF_SOF			(1 << 0)
+#define VFE_0_IRQ_STATUS_0_RDIn_REG_UPDATE(n)		(1 << ((n) + 5))
+#define VFE_0_IRQ_STATUS_0_line_n_REG_UPDATE(n)		\
+	((n) == VFE_LINE_PIX ? (1 << 4) : VFE_0_IRQ_STATUS_0_RDIn_REG_UPDATE(n))
+#define VFE_0_IRQ_STATUS_0_IMAGE_MASTER_n_PING_PONG(n)	(1 << ((n) + 8))
+#define VFE_0_IRQ_STATUS_0_IMAGE_COMPOSITE_DONE_n(n)	(1 << ((n) + 25))
+#define VFE_0_IRQ_STATUS_0_RESET_ACK			(1 << 31)
+#define VFE_0_IRQ_STATUS_1		0x03c
+#define VFE_0_IRQ_STATUS_1_VIOLATION			(1 << 7)
+#define VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK		(1 << 8)
+#define VFE_0_IRQ_STATUS_1_RDIn_SOF(n)			(1 << ((n) + 29))
+
+#define VFE_0_IRQ_COMPOSITE_MASK_0	0x40
+#define VFE_0_VIOLATION_STATUS		0x48
+
+#define VFE_0_BUS_CMD			0x4c
+#define VFE_0_BUS_CMD_Mx_RLD_CMD(x)	(1 << (x))
+
+#define VFE_0_BUS_CFG			0x050
+
+#define VFE_0_BUS_XBAR_CFG_x(x)		(0x58 + 0x4 * ((x) / 2))
+#define VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_EN			(1 << 1)
+#define VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_SWAP_INTER_INTRA	(0x3 << 4)
+#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT		8
+#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_LUMA		0
+#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI0	5
+#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI1	6
+#define VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI2	7
+
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(n)		(0x06c + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_WR_PATH_SHIFT	0
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_FRM_BASED_SHIFT	1
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_PING_ADDR(n)	(0x070 + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_PONG_ADDR(n)	(0x074 + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG(n)		(0x078 + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_SHIFT	2
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_MASK	(0x1F << 2)
+
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG(n)		(0x07c + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG_OFFSET_SHIFT	16
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_IMAGE_SIZE(n)	(0x080 + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_BUFFER_CFG(n)	(0x084 + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_FRAMEDROP_PATTERN(n)	\
+							(0x088 + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN(n)	\
+							(0x08c + 0x24 * (n))
+#define VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN_DEF	0xffffffff
+
+#define VFE_0_BUS_PING_PONG_STATUS	0x268
+
+#define VFE_0_BUS_BDG_CMD		0x2c0
+#define VFE_0_BUS_BDG_CMD_HALT_REQ	1
+
+#define VFE_0_BUS_BDG_QOS_CFG_0		0x2c4
+#define VFE_0_BUS_BDG_QOS_CFG_0_CFG	0xaaa5aaa5
+#define VFE_0_BUS_BDG_QOS_CFG_1		0x2c8
+#define VFE_0_BUS_BDG_QOS_CFG_2		0x2cc
+#define VFE_0_BUS_BDG_QOS_CFG_3		0x2d0
+#define VFE_0_BUS_BDG_QOS_CFG_4		0x2d4
+#define VFE_0_BUS_BDG_QOS_CFG_5		0x2d8
+#define VFE_0_BUS_BDG_QOS_CFG_6		0x2dc
+#define VFE_0_BUS_BDG_QOS_CFG_7		0x2e0
+#define VFE_0_BUS_BDG_QOS_CFG_7_CFG	0x0001aaa5
+
+#define VFE_0_RDI_CFG_x(x)		(0x2e8 + (0x4 * (x)))
+#define VFE_0_RDI_CFG_x_RDI_STREAM_SEL_SHIFT	28
+#define VFE_0_RDI_CFG_x_RDI_STREAM_SEL_MASK	(0xf << 28)
+#define VFE_0_RDI_CFG_x_RDI_M0_SEL_SHIFT	4
+#define VFE_0_RDI_CFG_x_RDI_M0_SEL_MASK		(0xf << 4)
+#define VFE_0_RDI_CFG_x_RDI_EN_BIT		(1 << 2)
+#define VFE_0_RDI_CFG_x_MIPI_EN_BITS		0x3
+#define VFE_0_RDI_CFG_x_RDI_Mr_FRAME_BASED_EN(r)	(1 << (16 + (r)))
+
+#define VFE_0_CAMIF_CMD				0x2f4
+#define VFE_0_CAMIF_CMD_DISABLE_FRAME_BOUNDARY	0
+#define VFE_0_CAMIF_CMD_ENABLE_FRAME_BOUNDARY	1
+#define VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS	(1 << 2)
+#define VFE_0_CAMIF_CFG				0x2f8
+#define VFE_0_CAMIF_CFG_VFE_OUTPUT_EN		(1 << 6)
+#define VFE_0_CAMIF_FRAME_CFG			0x300
+#define VFE_0_CAMIF_WINDOW_WIDTH_CFG		0x304
+#define VFE_0_CAMIF_WINDOW_HEIGHT_CFG		0x308
+#define VFE_0_CAMIF_SUBSAMPLE_CFG_0		0x30c
+#define VFE_0_CAMIF_IRQ_SUBSAMPLE_PATTERN	0x314
+#define VFE_0_CAMIF_STATUS			0x31c
+#define VFE_0_CAMIF_STATUS_HALT			(1 << 31)
+
+#define VFE_0_REG_UPDATE			0x378
+#define VFE_0_REG_UPDATE_RDIn(n)		(1 << (1 + (n)))
+#define VFE_0_REG_UPDATE_line_n(n)		\
+			((n) == VFE_LINE_PIX ? 1 : VFE_0_REG_UPDATE_RDIn(n))
+
+#define VFE_0_DEMUX_CFG				0x424
+#define VFE_0_DEMUX_CFG_PERIOD			0x3
+#define VFE_0_DEMUX_GAIN_0			0x428
+#define VFE_0_DEMUX_GAIN_0_CH0_EVEN		(0x80 << 0)
+#define VFE_0_DEMUX_GAIN_0_CH0_ODD		(0x80 << 16)
+#define VFE_0_DEMUX_GAIN_1			0x42c
+#define VFE_0_DEMUX_GAIN_1_CH1			(0x80 << 0)
+#define VFE_0_DEMUX_GAIN_1_CH2			(0x80 << 16)
+#define VFE_0_DEMUX_EVEN_CFG			0x438
+#define VFE_0_DEMUX_EVEN_CFG_PATTERN_YUYV	0x9cac
+#define VFE_0_DEMUX_EVEN_CFG_PATTERN_YVYU	0xac9c
+#define VFE_0_DEMUX_EVEN_CFG_PATTERN_UYVY	0xc9ca
+#define VFE_0_DEMUX_EVEN_CFG_PATTERN_VYUY	0xcac9
+#define VFE_0_DEMUX_ODD_CFG			0x43c
+#define VFE_0_DEMUX_ODD_CFG_PATTERN_YUYV	0x9cac
+#define VFE_0_DEMUX_ODD_CFG_PATTERN_YVYU	0xac9c
+#define VFE_0_DEMUX_ODD_CFG_PATTERN_UYVY	0xc9ca
+#define VFE_0_DEMUX_ODD_CFG_PATTERN_VYUY	0xcac9
+
+#define VFE_0_SCALE_ENC_Y_CFG			0x75c
+#define VFE_0_SCALE_ENC_Y_H_IMAGE_SIZE		0x760
+#define VFE_0_SCALE_ENC_Y_H_PHASE		0x764
+#define VFE_0_SCALE_ENC_Y_V_IMAGE_SIZE		0x76c
+#define VFE_0_SCALE_ENC_Y_V_PHASE		0x770
+#define VFE_0_SCALE_ENC_CBCR_CFG		0x778
+#define VFE_0_SCALE_ENC_CBCR_H_IMAGE_SIZE	0x77c
+#define VFE_0_SCALE_ENC_CBCR_H_PHASE		0x780
+#define VFE_0_SCALE_ENC_CBCR_V_IMAGE_SIZE	0x790
+#define VFE_0_SCALE_ENC_CBCR_V_PHASE		0x794
+
+#define VFE_0_CROP_ENC_Y_WIDTH			0x854
+#define VFE_0_CROP_ENC_Y_HEIGHT			0x858
+#define VFE_0_CROP_ENC_CBCR_WIDTH		0x85c
+#define VFE_0_CROP_ENC_CBCR_HEIGHT		0x860
+
+#define VFE_0_CLAMP_ENC_MAX_CFG			0x874
+#define VFE_0_CLAMP_ENC_MAX_CFG_CH0		(0xff << 0)
+#define VFE_0_CLAMP_ENC_MAX_CFG_CH1		(0xff << 8)
+#define VFE_0_CLAMP_ENC_MAX_CFG_CH2		(0xff << 16)
+#define VFE_0_CLAMP_ENC_MIN_CFG			0x878
+#define VFE_0_CLAMP_ENC_MIN_CFG_CH0		(0x0 << 0)
+#define VFE_0_CLAMP_ENC_MIN_CFG_CH1		(0x0 << 8)
+#define VFE_0_CLAMP_ENC_MIN_CFG_CH2		(0x0 << 16)
+
+#define VFE_0_CGC_OVERRIDE_1			0x974
+#define VFE_0_CGC_OVERRIDE_1_IMAGE_Mx_CGC_OVERRIDE(x)	(1 << (x))
+
+/* VFE reset timeout */
+#define VFE_RESET_TIMEOUT_MS 50
+/* VFE halt timeout */
+#define VFE_HALT_TIMEOUT_MS 100
+/* Max number of frame drop updates per frame */
+#define VFE_FRAME_DROP_UPDATES 5
+/* Frame drop value. NOTE: VAL + UPDATES should not exceed 31 */
+#define VFE_FRAME_DROP_VAL 20
+
+#define VFE_NEXT_SOF_MS 500
+
+#define CAMIF_TIMEOUT_SLEEP_US 1000
+#define CAMIF_TIMEOUT_ALL_US 1000000
+
+#define SCALER_RATIO_MAX 16
+
+static const struct {
+	u32 code;
+	u8 bpp;
+} vfe_formats[] = {
+	{
+		MEDIA_BUS_FMT_UYVY8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_VYUY8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_YUYV8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_YVYU8_2X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB8_1X8,
+		8,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB10_1X10,
+		10,
+	},
+	{
+		MEDIA_BUS_FMT_SBGGR12_1X12,
+		12,
+	},
+	{
+		MEDIA_BUS_FMT_SGBRG12_1X12,
+		12,
+	},
+	{
+		MEDIA_BUS_FMT_SGRBG12_1X12,
+		12,
+	},
+	{
+		MEDIA_BUS_FMT_SRGGB12_1X12,
+		12,
+	}
+};
+
+/*
+ * vfe_get_bpp - map media bus format to bits per pixel
+ * @code: media bus format code
+ *
+ * Return number of bits per pixel
+ */
+static u8 vfe_get_bpp(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe_formats); i++)
+		if (code == vfe_formats[i].code)
+			return vfe_formats[i].bpp;
+
+	WARN(1, "Unknown format\n");
+
+	return vfe_formats[0].bpp;
+}
+
+static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
+{
+	u32 bits = readl_relaxed(vfe->base + reg);
+
+	writel_relaxed(bits & ~clr_bits, vfe->base + reg);
+}
+
+static inline void vfe_reg_set(struct vfe_device *vfe, u32 reg, u32 set_bits)
+{
+	u32 bits = readl_relaxed(vfe->base + reg);
+
+	writel_relaxed(bits | set_bits, vfe->base + reg);
+}
+
+static void vfe_global_reset(struct vfe_device *vfe)
+{
+	u32 reset_bits = VFE_0_GLOBAL_RESET_CMD_TESTGEN		|
+			 VFE_0_GLOBAL_RESET_CMD_BUS_MISR	|
+			 VFE_0_GLOBAL_RESET_CMD_PM		|
+			 VFE_0_GLOBAL_RESET_CMD_TIMER		|
+			 VFE_0_GLOBAL_RESET_CMD_REGISTER	|
+			 VFE_0_GLOBAL_RESET_CMD_BUS_BDG		|
+			 VFE_0_GLOBAL_RESET_CMD_BUS		|
+			 VFE_0_GLOBAL_RESET_CMD_CAMIF		|
+			 VFE_0_GLOBAL_RESET_CMD_CORE;
+
+	writel_relaxed(reset_bits, vfe->base + VFE_0_GLOBAL_RESET_CMD);
+}
+
+static void vfe_wm_enable(struct vfe_device *vfe, u8 wm, u8 enable)
+{
+	if (enable)
+		vfe_reg_set(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
+			    1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_WR_PATH_SHIFT);
+	else
+		vfe_reg_clr(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
+			    1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_WR_PATH_SHIFT);
+}
+
+static void vfe_wm_frame_based(struct vfe_device *vfe, u8 wm, u8 enable)
+{
+	if (enable)
+		vfe_reg_set(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
+			1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_FRM_BASED_SHIFT);
+	else
+		vfe_reg_clr(vfe, VFE_0_BUS_IMAGE_MASTER_n_WR_CFG(wm),
+			1 << VFE_0_BUS_IMAGE_MASTER_n_WR_CFG_FRM_BASED_SHIFT);
+}
+
+#define CALC_WORD(width, M, N) (((width) * (M) + (N) - 1) / (N))
+
+static int vfe_word_per_line(uint32_t format, uint32_t pixel_per_line)
+{
+	int val = 0;
+
+	switch (format) {
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		val = CALC_WORD(pixel_per_line, 1, 8);
+		break;
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_VYUY:
+		val = CALC_WORD(pixel_per_line, 2, 8);
+		break;
+	}
+
+	return val;
+}
+
+static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
+			     u16 *width, u16 *height, u16 *bytesperline)
+{
+	switch (pix->pixelformat) {
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+		*width = pix->width;
+		*height = pix->height;
+		*bytesperline = pix->plane_fmt[0].bytesperline;
+		if (plane == 1)
+			*height /= 2;
+		break;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		*width = pix->width;
+		*height = pix->height;
+		*bytesperline = pix->plane_fmt[0].bytesperline;
+		break;
+	}
+}
+
+static void vfe_wm_line_based(struct vfe_device *vfe, u32 wm,
+			      struct v4l2_pix_format_mplane *pix,
+			      u8 plane, u32 enable)
+{
+	u32 reg;
+
+	if (enable) {
+		u16 width = 0, height = 0, bytesperline = 0, wpl;
+
+		vfe_get_wm_sizes(pix, plane, &width, &height, &bytesperline);
+
+		wpl = vfe_word_per_line(pix->pixelformat, width);
+
+		reg = height - 1;
+		reg |= ((wpl + 1) / 2 - 1) << 16;
+
+		writel_relaxed(reg, vfe->base +
+			       VFE_0_BUS_IMAGE_MASTER_n_WR_IMAGE_SIZE(wm));
+
+		wpl = vfe_word_per_line(pix->pixelformat, bytesperline);
+
+		reg = 0x3;
+		reg |= (height - 1) << 4;
+		reg |= wpl << 16;
+
+		writel_relaxed(reg, vfe->base +
+			       VFE_0_BUS_IMAGE_MASTER_n_WR_BUFFER_CFG(wm));
+	} else {
+		writel_relaxed(0, vfe->base +
+			       VFE_0_BUS_IMAGE_MASTER_n_WR_IMAGE_SIZE(wm));
+		writel_relaxed(0, vfe->base +
+			       VFE_0_BUS_IMAGE_MASTER_n_WR_BUFFER_CFG(wm));
+	}
+}
+
+static void vfe_wm_set_framedrop_period(struct vfe_device *vfe, u8 wm, u8 per)
+{
+	u32 reg;
+
+	reg = readl_relaxed(vfe->base +
+			    VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG(wm));
+
+	reg &= ~(VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_MASK);
+
+	reg |= (per << VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_SHIFT)
+		& VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG_FRM_DROP_PER_MASK;
+
+	writel_relaxed(reg,
+		       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_ADDR_CFG(wm));
+}
+
+static void vfe_wm_set_framedrop_pattern(struct vfe_device *vfe, u8 wm,
+					 u32 pattern)
+{
+	writel_relaxed(pattern,
+	       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_FRAMEDROP_PATTERN(wm));
+}
+
+static void vfe_wm_set_ub_cfg(struct vfe_device *vfe, u8 wm, u16 offset,
+			      u16 depth)
+{
+	u32 reg;
+
+	reg = (offset << VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG_OFFSET_SHIFT) |
+		depth;
+	writel_relaxed(reg, vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_UB_CFG(wm));
+}
+
+static void vfe_bus_reload_wm(struct vfe_device *vfe, u8 wm)
+{
+	wmb();
+	writel_relaxed(VFE_0_BUS_CMD_Mx_RLD_CMD(wm), vfe->base + VFE_0_BUS_CMD);
+	wmb();
+}
+
+static void vfe_wm_set_ping_addr(struct vfe_device *vfe, u8 wm, u32 addr)
+{
+	writel_relaxed(addr,
+		       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_PING_ADDR(wm));
+}
+
+static void vfe_wm_set_pong_addr(struct vfe_device *vfe, u8 wm, u32 addr)
+{
+	writel_relaxed(addr,
+		       vfe->base + VFE_0_BUS_IMAGE_MASTER_n_WR_PONG_ADDR(wm));
+}
+
+static int vfe_wm_get_ping_pong_status(struct vfe_device *vfe, u8 wm)
+{
+	u32 reg;
+
+	reg = readl_relaxed(vfe->base + VFE_0_BUS_PING_PONG_STATUS);
+
+	return (reg >> wm) & 0x1;
+}
+
+static void vfe_bus_enable_wr_if(struct vfe_device *vfe, u8 enable)
+{
+	if (enable)
+		writel_relaxed(0x10000009, vfe->base + VFE_0_BUS_CFG);
+	else
+		writel_relaxed(0, vfe->base + VFE_0_BUS_CFG);
+}
+
+static void vfe_bus_connect_wm_to_rdi(struct vfe_device *vfe, u8 wm,
+				      enum vfe_line_id id)
+{
+	u32 reg;
+
+	reg = VFE_0_RDI_CFG_x_MIPI_EN_BITS;
+	reg |= VFE_0_RDI_CFG_x_RDI_Mr_FRAME_BASED_EN(id);
+	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(0), reg);
+
+	reg = VFE_0_RDI_CFG_x_RDI_EN_BIT;
+	reg |= ((3 * id) << VFE_0_RDI_CFG_x_RDI_STREAM_SEL_SHIFT) &
+		VFE_0_RDI_CFG_x_RDI_STREAM_SEL_MASK;
+	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(id), reg);
+
+	switch (id) {
+	case VFE_LINE_RDI0:
+	default:
+		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI0 <<
+		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		break;
+	case VFE_LINE_RDI1:
+		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI1 <<
+		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		break;
+	case VFE_LINE_RDI2:
+		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI2 <<
+		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		break;
+	}
+
+	if (wm % 2 == 1)
+		reg <<= 16;
+
+	vfe_reg_set(vfe, VFE_0_BUS_XBAR_CFG_x(wm), reg);
+}
+
+static void vfe_wm_set_subsample(struct vfe_device *vfe, u8 wm)
+{
+	writel_relaxed(VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN_DEF,
+	       vfe->base +
+	       VFE_0_BUS_IMAGE_MASTER_n_WR_IRQ_SUBSAMPLE_PATTERN(wm));
+}
+
+static void vfe_bus_disconnect_wm_from_rdi(struct vfe_device *vfe, u8 wm,
+					   enum vfe_line_id id)
+{
+	u32 reg;
+
+	reg = VFE_0_RDI_CFG_x_RDI_Mr_FRAME_BASED_EN(id);
+	vfe_reg_clr(vfe, VFE_0_RDI_CFG_x(0), reg);
+
+	reg = VFE_0_RDI_CFG_x_RDI_EN_BIT;
+	vfe_reg_clr(vfe, VFE_0_RDI_CFG_x(id), reg);
+
+	switch (id) {
+	case VFE_LINE_RDI0:
+	default:
+		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI0 <<
+		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		break;
+	case VFE_LINE_RDI1:
+		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI1 <<
+		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		break;
+	case VFE_LINE_RDI2:
+		reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_VAL_RDI2 <<
+		      VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		break;
+	}
+
+	if (wm % 2 == 1)
+		reg <<= 16;
+
+	vfe_reg_clr(vfe, VFE_0_BUS_XBAR_CFG_x(wm), reg);
+}
+
+static void vfe_set_xbar_cfg(struct vfe_device *vfe, struct vfe_output *output,
+			     u8 enable)
+{
+	struct vfe_line *line = container_of(output, struct vfe_line, output);
+	u32 p = line->video_out.active_fmt.fmt.pix_mp.pixelformat;
+	u32 reg;
+	unsigned int i;
+
+	for (i = 0; i < output->wm_num; i++) {
+		if (i == 0) {
+			reg = VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_LUMA <<
+				VFE_0_BUS_XBAR_CFG_x_M_SINGLE_STREAM_SEL_SHIFT;
+		} else if (i == 1) {
+			reg = VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_EN;
+			if (p == V4L2_PIX_FMT_NV12 || p == V4L2_PIX_FMT_NV16)
+				reg |= VFE_0_BUS_XBAR_CFG_x_M_PAIR_STREAM_SWAP_INTER_INTRA;
+		} else {
+			/* On current devices output->wm_num is always <= 2 */
+			break;
+		}
+
+		if (output->wm_idx[i] % 2 == 1)
+			reg <<= 16;
+
+		if (enable)
+			vfe_reg_set(vfe,
+				    VFE_0_BUS_XBAR_CFG_x(output->wm_idx[i]),
+				    reg);
+		else
+			vfe_reg_clr(vfe,
+				    VFE_0_BUS_XBAR_CFG_x(output->wm_idx[i]),
+				    reg);
+	}
+}
+
+static void vfe_set_rdi_cid(struct vfe_device *vfe, enum vfe_line_id id, u8 cid)
+{
+	vfe_reg_clr(vfe, VFE_0_RDI_CFG_x(id),
+		    VFE_0_RDI_CFG_x_RDI_M0_SEL_MASK);
+
+	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(id),
+		    cid << VFE_0_RDI_CFG_x_RDI_M0_SEL_SHIFT);
+}
+
+static void vfe_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	vfe->reg_update |= VFE_0_REG_UPDATE_line_n(line_id);
+	wmb();
+	writel_relaxed(vfe->reg_update, vfe->base + VFE_0_REG_UPDATE);
+	wmb();
+}
+
+static void vfe_enable_irq_wm_line(struct vfe_device *vfe, u8 wm,
+				   enum vfe_line_id line_id, u8 enable)
+{
+	u32 irq_en0 = VFE_0_IRQ_MASK_0_IMAGE_MASTER_n_PING_PONG(wm) |
+		      VFE_0_IRQ_MASK_0_line_n_REG_UPDATE(line_id);
+	u32 irq_en1 = VFE_0_IRQ_MASK_1_IMAGE_MASTER_n_BUS_OVERFLOW(wm) |
+		      VFE_0_IRQ_MASK_1_RDIn_SOF(line_id);
+
+	if (enable) {
+		vfe_reg_set(vfe, VFE_0_IRQ_MASK_0, irq_en0);
+		vfe_reg_set(vfe, VFE_0_IRQ_MASK_1, irq_en1);
+	} else {
+		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_0, irq_en0);
+		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_1, irq_en1);
+	}
+}
+
+static void vfe_enable_irq_pix_line(struct vfe_device *vfe, u8 comp,
+				    enum vfe_line_id line_id, u8 enable)
+{
+	struct vfe_output *output = &vfe->line[line_id].output;
+	unsigned int i;
+	u32 irq_en0;
+	u32 irq_en1;
+	u32 comp_mask = 0;
+
+	irq_en0 = VFE_0_IRQ_MASK_0_CAMIF_SOF;
+	irq_en0 |= VFE_0_IRQ_MASK_0_CAMIF_EOF;
+	irq_en0 |= VFE_0_IRQ_MASK_0_IMAGE_COMPOSITE_DONE_n(comp);
+	irq_en0 |= VFE_0_IRQ_MASK_0_line_n_REG_UPDATE(line_id);
+	irq_en1 = VFE_0_IRQ_MASK_1_CAMIF_ERROR;
+	for (i = 0; i < output->wm_num; i++) {
+		irq_en1 |= VFE_0_IRQ_MASK_1_IMAGE_MASTER_n_BUS_OVERFLOW(
+							output->wm_idx[i]);
+		comp_mask |= (1 << output->wm_idx[i]) << comp * 8;
+	}
+
+	if (enable) {
+		vfe_reg_set(vfe, VFE_0_IRQ_MASK_0, irq_en0);
+		vfe_reg_set(vfe, VFE_0_IRQ_MASK_1, irq_en1);
+		vfe_reg_set(vfe, VFE_0_IRQ_COMPOSITE_MASK_0, comp_mask);
+	} else {
+		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_0, irq_en0);
+		vfe_reg_clr(vfe, VFE_0_IRQ_MASK_1, irq_en1);
+		vfe_reg_clr(vfe, VFE_0_IRQ_COMPOSITE_MASK_0, comp_mask);
+	}
+}
+
+static void vfe_enable_irq_common(struct vfe_device *vfe)
+{
+	u32 irq_en0 = VFE_0_IRQ_MASK_0_RESET_ACK;
+	u32 irq_en1 = VFE_0_IRQ_MASK_1_VIOLATION |
+		      VFE_0_IRQ_MASK_1_BUS_BDG_HALT_ACK;
+
+	vfe_reg_set(vfe, VFE_0_IRQ_MASK_0, irq_en0);
+	vfe_reg_set(vfe, VFE_0_IRQ_MASK_1, irq_en1);
+}
+
+static void vfe_set_demux_cfg(struct vfe_device *vfe, struct vfe_line *line)
+{
+	u32 val, even_cfg, odd_cfg;
+
+	writel_relaxed(VFE_0_DEMUX_CFG_PERIOD, vfe->base + VFE_0_DEMUX_CFG);
+
+	val = VFE_0_DEMUX_GAIN_0_CH0_EVEN | VFE_0_DEMUX_GAIN_0_CH0_ODD;
+	writel_relaxed(val, vfe->base + VFE_0_DEMUX_GAIN_0);
+
+	val = VFE_0_DEMUX_GAIN_1_CH1 | VFE_0_DEMUX_GAIN_1_CH2;
+	writel_relaxed(val, vfe->base + VFE_0_DEMUX_GAIN_1);
+
+	switch (line->fmt[MSM_VFE_PAD_SINK].code) {
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_YUYV;
+		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_YUYV;
+		break;
+	case MEDIA_BUS_FMT_YVYU8_2X8:
+		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_YVYU;
+		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_YVYU;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_2X8:
+	default:
+		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_UYVY;
+		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_UYVY;
+		break;
+	case MEDIA_BUS_FMT_VYUY8_2X8:
+		even_cfg = VFE_0_DEMUX_EVEN_CFG_PATTERN_VYUY;
+		odd_cfg = VFE_0_DEMUX_ODD_CFG_PATTERN_VYUY;
+		break;
+	}
+
+	writel_relaxed(even_cfg, vfe->base + VFE_0_DEMUX_EVEN_CFG);
+	writel_relaxed(odd_cfg, vfe->base + VFE_0_DEMUX_ODD_CFG);
+}
+
+static inline u8 vfe_calc_interp_reso(u16 input, u16 output)
+{
+	if (input / output >= 16)
+		return 0;
+
+	if (input / output >= 8)
+		return 1;
+
+	if (input / output >= 4)
+		return 2;
+
+	return 3;
+}
+
+static void vfe_set_scale_cfg(struct vfe_device *vfe, struct vfe_line *line)
+{
+	u32 p = line->video_out.active_fmt.fmt.pix_mp.pixelformat;
+	u32 reg;
+	u16 input, output;
+	u8 interp_reso;
+	u32 phase_mult;
+
+	writel_relaxed(0x3, vfe->base + VFE_0_SCALE_ENC_Y_CFG);
+
+	input = line->fmt[MSM_VFE_PAD_SINK].width;
+	output = line->compose.width;
+	reg = (output << 16) | input;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_H_IMAGE_SIZE);
+
+	interp_reso = vfe_calc_interp_reso(input, output);
+	phase_mult = input * (1 << (13 + interp_reso)) / output;
+	reg = (interp_reso << 20) | phase_mult;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_H_PHASE);
+
+	input = line->fmt[MSM_VFE_PAD_SINK].height;
+	output = line->compose.height;
+	reg = (output << 16) | input;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_V_IMAGE_SIZE);
+
+	interp_reso = vfe_calc_interp_reso(input, output);
+	phase_mult = input * (1 << (13 + interp_reso)) / output;
+	reg = (interp_reso << 20) | phase_mult;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_Y_V_PHASE);
+
+	writel_relaxed(0x3, vfe->base + VFE_0_SCALE_ENC_CBCR_CFG);
+
+	input = line->fmt[MSM_VFE_PAD_SINK].width;
+	output = line->compose.width / 2;
+	reg = (output << 16) | input;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_H_IMAGE_SIZE);
+
+	interp_reso = vfe_calc_interp_reso(input, output);
+	phase_mult = input * (1 << (13 + interp_reso)) / output;
+	reg = (interp_reso << 20) | phase_mult;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_H_PHASE);
+
+	input = line->fmt[MSM_VFE_PAD_SINK].height;
+	output = line->compose.height;
+	if (p == V4L2_PIX_FMT_NV12 || p == V4L2_PIX_FMT_NV21)
+		output = line->compose.height / 2;
+	reg = (output << 16) | input;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_V_IMAGE_SIZE);
+
+	interp_reso = vfe_calc_interp_reso(input, output);
+	phase_mult = input * (1 << (13 + interp_reso)) / output;
+	reg = (interp_reso << 20) | phase_mult;
+	writel_relaxed(reg, vfe->base + VFE_0_SCALE_ENC_CBCR_V_PHASE);
+}
+
+static void vfe_set_crop_cfg(struct vfe_device *vfe, struct vfe_line *line)
+{
+	u32 p = line->video_out.active_fmt.fmt.pix_mp.pixelformat;
+	u32 reg;
+	u16 first, last;
+
+	first = line->crop.left;
+	last = line->crop.left + line->crop.width - 1;
+	reg = (first << 16) | last;
+	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_Y_WIDTH);
+
+	first = line->crop.top;
+	last = line->crop.top + line->crop.height - 1;
+	reg = (first << 16) | last;
+	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_Y_HEIGHT);
+
+	first = line->crop.left / 2;
+	last = line->crop.left / 2 + line->crop.width / 2 - 1;
+	reg = (first << 16) | last;
+	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_CBCR_WIDTH);
+
+	first = line->crop.top;
+	last = line->crop.top + line->crop.height - 1;
+	if (p == V4L2_PIX_FMT_NV12 || p == V4L2_PIX_FMT_NV21) {
+		first = line->crop.top / 2;
+		last = line->crop.top / 2 + line->crop.height / 2 - 1;
+	}
+	reg = (first << 16) | last;
+	writel_relaxed(reg, vfe->base + VFE_0_CROP_ENC_CBCR_HEIGHT);
+}
+
+static void vfe_set_clamp_cfg(struct vfe_device *vfe)
+{
+	u32 val = VFE_0_CLAMP_ENC_MAX_CFG_CH0 |
+		VFE_0_CLAMP_ENC_MAX_CFG_CH1 |
+		VFE_0_CLAMP_ENC_MAX_CFG_CH2;
+
+	writel_relaxed(val, vfe->base + VFE_0_CLAMP_ENC_MAX_CFG);
+
+	val = VFE_0_CLAMP_ENC_MIN_CFG_CH0 |
+		VFE_0_CLAMP_ENC_MIN_CFG_CH1 |
+		VFE_0_CLAMP_ENC_MIN_CFG_CH2;
+
+	writel_relaxed(val, vfe->base + VFE_0_CLAMP_ENC_MIN_CFG);
+}
+
+/*
+ * vfe_reset - Trigger reset on VFE module and wait to complete
+ * @vfe: VFE device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_reset(struct vfe_device *vfe)
+{
+	unsigned long time;
+
+	reinit_completion(&vfe->reset_complete);
+
+	vfe_global_reset(vfe);
+
+	time = wait_for_completion_timeout(&vfe->reset_complete,
+		msecs_to_jiffies(VFE_RESET_TIMEOUT_MS));
+	if (!time) {
+		dev_err(to_device(vfe), "VFE reset timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_halt - Trigger halt on VFE module and wait to complete
+ * @vfe: VFE device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_halt(struct vfe_device *vfe)
+{
+	unsigned long time;
+
+	reinit_completion(&vfe->halt_complete);
+
+	writel_relaxed(VFE_0_BUS_BDG_CMD_HALT_REQ,
+		       vfe->base + VFE_0_BUS_BDG_CMD);
+
+	time = wait_for_completion_timeout(&vfe->halt_complete,
+		msecs_to_jiffies(VFE_HALT_TIMEOUT_MS));
+	if (!time) {
+		dev_err(to_device(vfe), "VFE halt timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void vfe_init_outputs(struct vfe_device *vfe)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe->line); i++) {
+		struct vfe_output *output = &vfe->line[i].output;
+
+		output->state = VFE_OUTPUT_OFF;
+		output->buf[0] = NULL;
+		output->buf[1] = NULL;
+		INIT_LIST_HEAD(&output->pending_bufs);
+
+		output->wm_num = 1;
+		if (vfe->line[i].id == VFE_LINE_PIX)
+			output->wm_num = 2;
+	}
+}
+
+static void vfe_reset_output_maps(struct vfe_device *vfe)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe->wm_output_map); i++)
+		vfe->wm_output_map[i] = VFE_LINE_NONE;
+}
+
+static void vfe_set_qos(struct vfe_device *vfe)
+{
+	u32 val = VFE_0_BUS_BDG_QOS_CFG_0_CFG;
+	u32 val7 = VFE_0_BUS_BDG_QOS_CFG_7_CFG;
+
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_0);
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_1);
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_2);
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_3);
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_4);
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_5);
+	writel_relaxed(val, vfe->base + VFE_0_BUS_BDG_QOS_CFG_6);
+	writel_relaxed(val7, vfe->base + VFE_0_BUS_BDG_QOS_CFG_7);
+}
+
+static void vfe_set_cgc_override(struct vfe_device *vfe, u8 wm, u8 enable)
+{
+	u32 val = VFE_0_CGC_OVERRIDE_1_IMAGE_Mx_CGC_OVERRIDE(wm);
+
+	if (enable)
+		vfe_reg_set(vfe, VFE_0_CGC_OVERRIDE_1, val);
+	else
+		vfe_reg_clr(vfe, VFE_0_CGC_OVERRIDE_1, val);
+
+	wmb();
+}
+
+static void vfe_set_module_cfg(struct vfe_device *vfe, u8 enable)
+{
+	u32 val = VFE_0_MODULE_CFG_DEMUX |
+		  VFE_0_MODULE_CFG_CHROMA_UPSAMPLE |
+		  VFE_0_MODULE_CFG_SCALE_ENC |
+		  VFE_0_MODULE_CFG_CROP_ENC;
+
+	if (enable)
+		writel_relaxed(val, vfe->base + VFE_0_MODULE_CFG);
+	else
+		writel_relaxed(0x0, vfe->base + VFE_0_MODULE_CFG);
+}
+
+static void vfe_set_camif_cfg(struct vfe_device *vfe, struct vfe_line *line)
+{
+	u32 val;
+
+	switch (line->fmt[MSM_VFE_PAD_SINK].code) {
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+		val = VFE_0_CORE_CFG_PIXEL_PATTERN_YCBYCR;
+		break;
+	case MEDIA_BUS_FMT_YVYU8_2X8:
+		val = VFE_0_CORE_CFG_PIXEL_PATTERN_YCRYCB;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_2X8:
+	default:
+		val = VFE_0_CORE_CFG_PIXEL_PATTERN_CBYCRY;
+		break;
+	case MEDIA_BUS_FMT_VYUY8_2X8:
+		val = VFE_0_CORE_CFG_PIXEL_PATTERN_CRYCBY;
+		break;
+	}
+
+	writel_relaxed(val, vfe->base + VFE_0_CORE_CFG);
+
+	val = line->fmt[MSM_VFE_PAD_SINK].width * 2;
+	val |= line->fmt[MSM_VFE_PAD_SINK].height << 16;
+	writel_relaxed(val, vfe->base + VFE_0_CAMIF_FRAME_CFG);
+
+	val = line->fmt[MSM_VFE_PAD_SINK].width * 2 - 1;
+	writel_relaxed(val, vfe->base + VFE_0_CAMIF_WINDOW_WIDTH_CFG);
+
+	val = line->fmt[MSM_VFE_PAD_SINK].height - 1;
+	writel_relaxed(val, vfe->base + VFE_0_CAMIF_WINDOW_HEIGHT_CFG);
+
+	val = 0xffffffff;
+	writel_relaxed(val, vfe->base + VFE_0_CAMIF_SUBSAMPLE_CFG_0);
+
+	val = 0xffffffff;
+	writel_relaxed(val, vfe->base + VFE_0_CAMIF_IRQ_SUBSAMPLE_PATTERN);
+
+	val = VFE_0_RDI_CFG_x_MIPI_EN_BITS;
+	vfe_reg_set(vfe, VFE_0_RDI_CFG_x(0), val);
+
+	val = VFE_0_CAMIF_CFG_VFE_OUTPUT_EN;
+	writel_relaxed(val, vfe->base + VFE_0_CAMIF_CFG);
+}
+
+static void vfe_set_camif_cmd(struct vfe_device *vfe, u32 cmd)
+{
+	writel_relaxed(VFE_0_CAMIF_CMD_CLEAR_CAMIF_STATUS,
+		       vfe->base + VFE_0_CAMIF_CMD);
+
+	writel_relaxed(cmd, vfe->base + VFE_0_CAMIF_CMD);
+}
+
+static int vfe_camif_wait_for_stop(struct vfe_device *vfe)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(vfe->base + VFE_0_CAMIF_STATUS,
+				 val,
+				 (val & VFE_0_CAMIF_STATUS_HALT),
+				 CAMIF_TIMEOUT_SLEEP_US,
+				 CAMIF_TIMEOUT_ALL_US);
+	if (ret < 0)
+		dev_err(to_device(vfe), "%s: camif stop timeout\n", __func__);
+
+	return ret;
+}
+
+static void vfe_output_init_addrs(struct vfe_device *vfe,
+				  struct vfe_output *output, u8 sync)
+{
+	u32 ping_addr;
+	u32 pong_addr;
+	unsigned int i;
+
+	output->active_buf = 0;
+
+	for (i = 0; i < output->wm_num; i++) {
+		if (output->buf[0])
+			ping_addr = output->buf[0]->addr[i];
+		else
+			ping_addr = 0;
+
+		if (output->buf[1])
+			pong_addr = output->buf[1]->addr[i];
+		else
+			pong_addr = ping_addr;
+
+		vfe_wm_set_ping_addr(vfe, output->wm_idx[i], ping_addr);
+		vfe_wm_set_pong_addr(vfe, output->wm_idx[i], pong_addr);
+		if (sync)
+			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
+	}
+}
+
+static void vfe_output_update_ping_addr(struct vfe_device *vfe,
+					struct vfe_output *output, u8 sync)
+{
+	u32 addr;
+	unsigned int i;
+
+	for (i = 0; i < output->wm_num; i++) {
+		if (output->buf[0])
+			addr = output->buf[0]->addr[i];
+		else
+			addr = 0;
+
+		vfe_wm_set_ping_addr(vfe, output->wm_idx[i], addr);
+		if (sync)
+			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
+	}
+}
+
+static void vfe_output_update_pong_addr(struct vfe_device *vfe,
+					struct vfe_output *output, u8 sync)
+{
+	u32 addr;
+	unsigned int i;
+
+	for (i = 0; i < output->wm_num; i++) {
+		if (output->buf[1])
+			addr = output->buf[1]->addr[i];
+		else
+			addr = 0;
+
+		vfe_wm_set_pong_addr(vfe, output->wm_idx[i], addr);
+		if (sync)
+			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
+	}
+
+}
+
+static int vfe_reserve_wm(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	int ret = -EBUSY;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe->wm_output_map); i++) {
+		if (vfe->wm_output_map[i] == VFE_LINE_NONE) {
+			vfe->wm_output_map[i] = line_id;
+			ret = i;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int vfe_release_wm(struct vfe_device *vfe, u8 wm)
+{
+	if (wm >= ARRAY_SIZE(vfe->wm_output_map))
+		return -EINVAL;
+
+	vfe->wm_output_map[wm] = VFE_LINE_NONE;
+
+	return 0;
+}
+
+static void vfe_output_frame_drop(struct vfe_device *vfe,
+				  struct vfe_output *output,
+				  u32 drop_pattern)
+{
+	u8 drop_period;
+	unsigned int i;
+
+	/* We need to toggle update period to be valid on next frame */
+	output->drop_update_idx++;
+	output->drop_update_idx %= VFE_FRAME_DROP_UPDATES;
+	drop_period = VFE_FRAME_DROP_VAL + output->drop_update_idx;
+
+	for (i = 0; i < output->wm_num; i++) {
+		vfe_wm_set_framedrop_period(vfe, output->wm_idx[i],
+					    drop_period);
+		vfe_wm_set_framedrop_pattern(vfe, output->wm_idx[i],
+					     drop_pattern);
+	}
+	vfe_reg_update(vfe, container_of(output, struct vfe_line, output)->id);
+}
+
+static struct camss_buffer *vfe_buf_get_pending(struct vfe_output *output)
+{
+	struct camss_buffer *buffer = NULL;
+
+	if (!list_empty(&output->pending_bufs)) {
+		buffer = list_first_entry(&output->pending_bufs,
+					  struct camss_buffer,
+					  queue);
+		list_del(&buffer->queue);
+	}
+
+	return buffer;
+}
+
+/*
+ * vfe_buf_add_pending - Add output buffer to list of pending
+ * @output: VFE output
+ * @buffer: Video buffer
+ */
+static void vfe_buf_add_pending(struct vfe_output *output,
+				struct camss_buffer *buffer)
+{
+	INIT_LIST_HEAD(&buffer->queue);
+	list_add_tail(&buffer->queue, &output->pending_bufs);
+}
+
+/*
+ * vfe_buf_flush_pending - Flush all pending buffers.
+ * @output: VFE output
+ * @state: vb2 buffer state
+ */
+static void vfe_buf_flush_pending(struct vfe_output *output,
+				  enum vb2_buffer_state state)
+{
+	struct camss_buffer *buf;
+	struct camss_buffer *t;
+
+	list_for_each_entry_safe(buf, t, &output->pending_bufs, queue) {
+		vb2_buffer_done(&buf->vb.vb2_buf, state);
+		list_del(&buf->queue);
+	}
+}
+
+static void vfe_buf_update_wm_on_next(struct vfe_device *vfe,
+				      struct vfe_output *output)
+{
+	switch (output->state) {
+	case VFE_OUTPUT_CONTINUOUS:
+		vfe_output_frame_drop(vfe, output, 3);
+		break;
+	case VFE_OUTPUT_SINGLE:
+	default:
+		dev_err_ratelimited(to_device(vfe),
+				    "Next buf in wrong state! %d\n",
+				    output->state);
+		break;
+	}
+}
+
+static void vfe_buf_update_wm_on_last(struct vfe_device *vfe,
+				      struct vfe_output *output)
+{
+	switch (output->state) {
+	case VFE_OUTPUT_CONTINUOUS:
+		output->state = VFE_OUTPUT_SINGLE;
+		vfe_output_frame_drop(vfe, output, 1);
+		break;
+	case VFE_OUTPUT_SINGLE:
+		output->state = VFE_OUTPUT_STOPPING;
+		vfe_output_frame_drop(vfe, output, 0);
+		break;
+	default:
+		dev_err_ratelimited(to_device(vfe),
+				    "Last buff in wrong state! %d\n",
+				    output->state);
+		break;
+	}
+}
+
+static void vfe_buf_update_wm_on_new(struct vfe_device *vfe,
+				     struct vfe_output *output,
+				     struct camss_buffer *new_buf)
+{
+	int inactive_idx;
+
+	switch (output->state) {
+	case VFE_OUTPUT_SINGLE:
+		inactive_idx = !output->active_buf;
+
+		if (!output->buf[inactive_idx]) {
+			output->buf[inactive_idx] = new_buf;
+
+			if (inactive_idx)
+				vfe_output_update_pong_addr(vfe, output, 0);
+			else
+				vfe_output_update_ping_addr(vfe, output, 0);
+
+			vfe_output_frame_drop(vfe, output, 3);
+			output->state = VFE_OUTPUT_CONTINUOUS;
+		} else {
+			vfe_buf_add_pending(output, new_buf);
+			dev_err_ratelimited(to_device(vfe),
+					    "Inactive buffer is busy\n");
+		}
+		break;
+
+	case VFE_OUTPUT_IDLE:
+		if (!output->buf[0]) {
+			output->buf[0] = new_buf;
+
+			vfe_output_init_addrs(vfe, output, 1);
+
+			vfe_output_frame_drop(vfe, output, 1);
+			output->state = VFE_OUTPUT_SINGLE;
+		} else {
+			vfe_buf_add_pending(output, new_buf);
+			dev_err_ratelimited(to_device(vfe),
+					    "Output idle with buffer set!\n");
+		}
+		break;
+
+	case VFE_OUTPUT_CONTINUOUS:
+	default:
+		vfe_buf_add_pending(output, new_buf);
+		break;
+	}
+}
+
+static int vfe_get_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output;
+	unsigned long flags;
+	int i;
+	int wm_idx;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	output = &line->output;
+	if (output->state != VFE_OUTPUT_OFF) {
+		dev_err(to_device(vfe), "Output is running\n");
+		goto error;
+	}
+	output->state = VFE_OUTPUT_RESERVED;
+
+	output->active_buf = 0;
+
+	for (i = 0; i < output->wm_num; i++) {
+		wm_idx = vfe_reserve_wm(vfe, line->id);
+		if (wm_idx < 0) {
+			dev_err(to_device(vfe), "Can not reserve wm\n");
+			goto error_get_wm;
+		}
+		output->wm_idx[i] = wm_idx;
+	}
+
+	output->drop_update_idx = 0;
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+
+error_get_wm:
+	for (i--; i >= 0; i--)
+		vfe_release_wm(vfe, output->wm_idx[i]);
+	output->state = VFE_OUTPUT_OFF;
+error:
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return -EINVAL;
+}
+
+static int vfe_put_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output = &line->output;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	for (i = 0; i < output->wm_num; i++)
+		vfe_release_wm(vfe, output->wm_idx[i]);
+
+	output->state = VFE_OUTPUT_OFF;
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+	return 0;
+}
+
+static int vfe_enable_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output = &line->output;
+	unsigned long flags;
+	unsigned int i;
+	u16 ub_size;
+
+	switch (vfe->id) {
+	case 0:
+		ub_size = MSM_VFE_VFE0_UB_SIZE_RDI;
+		break;
+	case 1:
+		ub_size = MSM_VFE_VFE1_UB_SIZE_RDI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	vfe->reg_update &= ~VFE_0_REG_UPDATE_line_n(line->id);
+
+	if (output->state != VFE_OUTPUT_RESERVED) {
+		dev_err(to_device(vfe), "Output is not in reserved state %d\n",
+			output->state);
+		spin_unlock_irqrestore(&vfe->output_lock, flags);
+		return -EINVAL;
+	}
+	output->state = VFE_OUTPUT_IDLE;
+
+	output->buf[0] = vfe_buf_get_pending(output);
+	output->buf[1] = vfe_buf_get_pending(output);
+
+	if (!output->buf[0] && output->buf[1]) {
+		output->buf[0] = output->buf[1];
+		output->buf[1] = NULL;
+	}
+
+	if (output->buf[0])
+		output->state = VFE_OUTPUT_SINGLE;
+
+	if (output->buf[1])
+		output->state = VFE_OUTPUT_CONTINUOUS;
+
+	switch (output->state) {
+	case VFE_OUTPUT_SINGLE:
+		vfe_output_frame_drop(vfe, output, 1);
+		break;
+	case VFE_OUTPUT_CONTINUOUS:
+		vfe_output_frame_drop(vfe, output, 3);
+		break;
+	default:
+		vfe_output_frame_drop(vfe, output, 0);
+		break;
+	}
+
+	output->sequence = 0;
+	output->wait_sof = 0;
+	output->wait_reg_update = 0;
+	reinit_completion(&output->sof);
+	reinit_completion(&output->reg_update);
+
+	vfe_output_init_addrs(vfe, output, 0);
+
+	if (line->id != VFE_LINE_PIX) {
+		vfe_set_cgc_override(vfe, output->wm_idx[0], 1);
+		vfe_enable_irq_wm_line(vfe, output->wm_idx[0], line->id, 1);
+		vfe_bus_connect_wm_to_rdi(vfe, output->wm_idx[0], line->id);
+		vfe_wm_set_subsample(vfe, output->wm_idx[0]);
+		vfe_set_rdi_cid(vfe, line->id, 0);
+		vfe_wm_set_ub_cfg(vfe, output->wm_idx[0],
+				  (ub_size + 1) * output->wm_idx[0], ub_size);
+		vfe_wm_frame_based(vfe, output->wm_idx[0], 1);
+		vfe_wm_enable(vfe, output->wm_idx[0], 1);
+		vfe_bus_reload_wm(vfe, output->wm_idx[0]);
+	} else {
+		ub_size /= output->wm_num;
+		for (i = 0; i < output->wm_num; i++) {
+			vfe_set_cgc_override(vfe, output->wm_idx[i], 1);
+			vfe_wm_set_subsample(vfe, output->wm_idx[i]);
+			vfe_wm_set_ub_cfg(vfe, output->wm_idx[i],
+					  (ub_size + 1) * output->wm_idx[i],
+					  ub_size);
+			vfe_wm_line_based(vfe, output->wm_idx[i],
+					&line->video_out.active_fmt.fmt.pix_mp,
+					i, 1);
+			vfe_wm_enable(vfe, output->wm_idx[i], 1);
+			vfe_bus_reload_wm(vfe, output->wm_idx[i]);
+		}
+		vfe_enable_irq_pix_line(vfe, 0, line->id, 1);
+		vfe_set_module_cfg(vfe, 1);
+		vfe_set_camif_cfg(vfe, line);
+		vfe_set_xbar_cfg(vfe, output, 1);
+		vfe_set_demux_cfg(vfe, line);
+		vfe_set_scale_cfg(vfe, line);
+		vfe_set_crop_cfg(vfe, line);
+		vfe_set_clamp_cfg(vfe);
+		vfe_set_camif_cmd(vfe, VFE_0_CAMIF_CMD_ENABLE_FRAME_BOUNDARY);
+	}
+
+	vfe_reg_update(vfe, line->id);
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+}
+
+static int vfe_disable_output(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	struct vfe_output *output = &line->output;
+	unsigned long flags;
+	unsigned long time;
+	unsigned int i;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	output->wait_sof = 1;
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	time = wait_for_completion_timeout(&output->sof,
+					   msecs_to_jiffies(VFE_NEXT_SOF_MS));
+	if (!time)
+		dev_err(to_device(vfe), "VFE sof timeout\n");
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+	for (i = 0; i < output->wm_num; i++)
+		vfe_wm_enable(vfe, output->wm_idx[i], 0);
+
+	vfe_reg_update(vfe, line->id);
+	output->wait_reg_update = 1;
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	time = wait_for_completion_timeout(&output->reg_update,
+					   msecs_to_jiffies(VFE_NEXT_SOF_MS));
+	if (!time)
+		dev_err(to_device(vfe), "VFE reg update timeout\n");
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	if (line->id != VFE_LINE_PIX) {
+		vfe_wm_frame_based(vfe, output->wm_idx[0], 0);
+		vfe_bus_disconnect_wm_from_rdi(vfe, output->wm_idx[0], line->id);
+		vfe_enable_irq_wm_line(vfe, output->wm_idx[0], line->id, 0);
+		vfe_set_cgc_override(vfe, output->wm_idx[0], 0);
+		spin_unlock_irqrestore(&vfe->output_lock, flags);
+	} else {
+		for (i = 0; i < output->wm_num; i++) {
+			vfe_wm_line_based(vfe, output->wm_idx[i], NULL, i, 0);
+			vfe_set_cgc_override(vfe, output->wm_idx[i], 0);
+		}
+
+		vfe_enable_irq_pix_line(vfe, 0, line->id, 0);
+		vfe_set_module_cfg(vfe, 0);
+		vfe_set_xbar_cfg(vfe, output, 0);
+
+		vfe_set_camif_cmd(vfe, VFE_0_CAMIF_CMD_DISABLE_FRAME_BOUNDARY);
+		spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+		vfe_camif_wait_for_stop(vfe);
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_enable - Enable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_enable(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+	int ret;
+
+	mutex_lock(&vfe->stream_lock);
+
+	if (!vfe->stream_count) {
+		vfe_enable_irq_common(vfe);
+
+		vfe_bus_enable_wr_if(vfe, 1);
+
+		vfe_set_qos(vfe);
+	}
+
+	vfe->stream_count++;
+
+	mutex_unlock(&vfe->stream_lock);
+
+	ret = vfe_get_output(line);
+	if (ret < 0)
+		goto error_get_output;
+
+	ret = vfe_enable_output(line);
+	if (ret < 0)
+		goto error_enable_output;
+
+	vfe->was_streaming = 1;
+
+	return 0;
+
+
+error_enable_output:
+	vfe_put_output(line);
+
+error_get_output:
+	mutex_lock(&vfe->stream_lock);
+
+	if (vfe->stream_count == 1)
+		vfe_bus_enable_wr_if(vfe, 0);
+
+	vfe->stream_count--;
+
+	mutex_unlock(&vfe->stream_lock);
+
+	return ret;
+}
+
+/*
+ * vfe_disable - Disable streaming on VFE line
+ * @line: VFE line
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_disable(struct vfe_line *line)
+{
+	struct vfe_device *vfe = to_vfe(line);
+
+	vfe_disable_output(line);
+
+	vfe_put_output(line);
+
+	mutex_lock(&vfe->stream_lock);
+
+	if (vfe->stream_count == 1)
+		vfe_bus_enable_wr_if(vfe, 0);
+
+	vfe->stream_count--;
+
+	mutex_unlock(&vfe->stream_lock);
+
+	return 0;
+}
+
+/*
+ * vfe_isr_sof - Process start of frame interrupt
+ * @vfe: VFE Device
+ * @line_id: VFE line
+ */
+static void vfe_isr_sof(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	struct vfe_output *output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+	output = &vfe->line[line_id].output;
+	if (output->wait_sof) {
+		output->wait_sof = 0;
+		complete(&output->sof);
+	}
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+}
+
+/*
+ * vfe_isr_reg_update - Process reg update interrupt
+ * @vfe: VFE Device
+ * @line_id: VFE line
+ */
+static void vfe_isr_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	struct vfe_output *output;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+	vfe->reg_update &= ~VFE_0_REG_UPDATE_line_n(line_id);
+
+	output = &vfe->line[line_id].output;
+
+	if (output->wait_reg_update) {
+		output->wait_reg_update = 0;
+		complete(&output->reg_update);
+		spin_unlock_irqrestore(&vfe->output_lock, flags);
+		return;
+	}
+
+	if (output->state == VFE_OUTPUT_STOPPING) {
+		/* Release last buffer when hw is idle */
+		if (output->last_buffer) {
+			vb2_buffer_done(&output->last_buffer->vb.vb2_buf,
+					VB2_BUF_STATE_DONE);
+			output->last_buffer = NULL;
+		}
+		output->state = VFE_OUTPUT_IDLE;
+
+		/* Buffers received in stopping state are queued in */
+		/* dma pending queue, start next capture here */
+
+		output->buf[0] = vfe_buf_get_pending(output);
+		output->buf[1] = vfe_buf_get_pending(output);
+
+		if (!output->buf[0] && output->buf[1]) {
+			output->buf[0] = output->buf[1];
+			output->buf[1] = NULL;
+		}
+
+		if (output->buf[0])
+			output->state = VFE_OUTPUT_SINGLE;
+
+		if (output->buf[1])
+			output->state = VFE_OUTPUT_CONTINUOUS;
+
+		switch (output->state) {
+		case VFE_OUTPUT_SINGLE:
+			vfe_output_frame_drop(vfe, output, 2);
+			break;
+		case VFE_OUTPUT_CONTINUOUS:
+			vfe_output_frame_drop(vfe, output, 3);
+			break;
+		default:
+			vfe_output_frame_drop(vfe, output, 0);
+			break;
+		}
+
+		vfe_output_init_addrs(vfe, output, 1);
+	}
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+}
+
+/*
+ * vfe_isr_wm_done - Process write master done interrupt
+ * @vfe: VFE Device
+ * @wm: Write master id
+ */
+static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
+{
+	struct camss_buffer *ready_buf;
+	struct vfe_output *output;
+	dma_addr_t *new_addr;
+	unsigned long flags;
+	u32 active_index;
+	u64 ts = ktime_get_ns();
+	unsigned int i;
+
+	active_index = vfe_wm_get_ping_pong_status(vfe, wm);
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	if (vfe->wm_output_map[wm] == VFE_LINE_NONE) {
+		dev_err_ratelimited(to_device(vfe),
+				    "Received wm done for unmapped index\n");
+		goto out_unlock;
+	}
+	output = &vfe->line[vfe->wm_output_map[wm]].output;
+
+	if (output->active_buf == active_index) {
+		dev_err_ratelimited(to_device(vfe),
+				    "Active buffer mismatch!\n");
+		goto out_unlock;
+	}
+	output->active_buf = active_index;
+
+	ready_buf = output->buf[!active_index];
+	if (!ready_buf) {
+		dev_err_ratelimited(to_device(vfe),
+				    "Missing ready buf %d %d!\n",
+				    !active_index, output->state);
+		goto out_unlock;
+	}
+
+	ready_buf->vb.vb2_buf.timestamp = ts;
+	ready_buf->vb.sequence = output->sequence++;
+
+	/* Get next buffer */
+	output->buf[!active_index] = vfe_buf_get_pending(output);
+	if (!output->buf[!active_index]) {
+		/* No next buffer - set same address */
+		new_addr = ready_buf->addr;
+		vfe_buf_update_wm_on_last(vfe, output);
+	} else {
+		new_addr = output->buf[!active_index]->addr;
+		vfe_buf_update_wm_on_next(vfe, output);
+	}
+
+	if (active_index)
+		for (i = 0; i < output->wm_num; i++)
+			vfe_wm_set_ping_addr(vfe, output->wm_idx[i],
+					     new_addr[i]);
+	else
+		for (i = 0; i < output->wm_num; i++)
+			vfe_wm_set_pong_addr(vfe, output->wm_idx[i],
+					     new_addr[i]);
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	if (output->state == VFE_OUTPUT_STOPPING)
+		output->last_buffer = ready_buf;
+	else
+		vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+
+	return;
+
+out_unlock:
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+}
+
+/*
+ * vfe_isr_wm_done - Process composite image done interrupt
+ * @vfe: VFE Device
+ * @comp: Composite image id
+ */
+static void vfe_isr_comp_done(struct vfe_device *vfe, u8 comp)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe->wm_output_map); i++)
+		if (vfe->wm_output_map[i] == VFE_LINE_PIX) {
+			vfe_isr_wm_done(vfe, i);
+			break;
+		}
+}
+
+/*
+ * vfe_isr - ISPIF module interrupt handler
+ * @irq: Interrupt line
+ * @dev: VFE device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t vfe_isr(int irq, void *dev)
+{
+	struct vfe_device *vfe = dev;
+	u32 value0, value1;
+	u32 violation;
+	int i, j;
+
+	value0 = readl_relaxed(vfe->base + VFE_0_IRQ_STATUS_0);
+	value1 = readl_relaxed(vfe->base + VFE_0_IRQ_STATUS_1);
+
+	writel_relaxed(value0, vfe->base + VFE_0_IRQ_CLEAR_0);
+	writel_relaxed(value1, vfe->base + VFE_0_IRQ_CLEAR_1);
+
+	wmb();
+	writel_relaxed(VFE_0_IRQ_CMD_GLOBAL_CLEAR, vfe->base + VFE_0_IRQ_CMD);
+
+	if (value0 & VFE_0_IRQ_STATUS_0_RESET_ACK)
+		complete(&vfe->reset_complete);
+
+	if (value1 & VFE_0_IRQ_STATUS_1_VIOLATION) {
+		violation = readl_relaxed(vfe->base + VFE_0_VIOLATION_STATUS);
+		dev_err_ratelimited(to_device(vfe),
+				    "VFE: violation = 0x%08x\n", violation);
+	}
+
+	if (value1 & VFE_0_IRQ_STATUS_1_BUS_BDG_HALT_ACK) {
+		complete(&vfe->halt_complete);
+		writel_relaxed(0x0, vfe->base + VFE_0_BUS_BDG_CMD);
+	}
+
+	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++)
+		if (value0 & VFE_0_IRQ_STATUS_0_line_n_REG_UPDATE(i))
+			vfe_isr_reg_update(vfe, i);
+
+	if (value0 & VFE_0_IRQ_STATUS_0_CAMIF_SOF)
+		vfe_isr_sof(vfe, VFE_LINE_PIX);
+
+	for (i = VFE_LINE_RDI0; i <= VFE_LINE_RDI2; i++)
+		if (value1 & VFE_0_IRQ_STATUS_1_RDIn_SOF(i))
+			vfe_isr_sof(vfe, i);
+
+	for (i = 0; i < MSM_VFE_COMPOSITE_IRQ_NUM; i++)
+		if (value0 & VFE_0_IRQ_STATUS_0_IMAGE_COMPOSITE_DONE_n(i)) {
+			vfe_isr_comp_done(vfe, i);
+			for (j = 0; j < ARRAY_SIZE(vfe->wm_output_map); j++)
+				if (vfe->wm_output_map[j] == VFE_LINE_PIX)
+					value0 &= ~VFE_0_IRQ_MASK_0_IMAGE_MASTER_n_PING_PONG(j);
+		}
+
+	for (i = 0; i < MSM_VFE_IMAGE_MASTERS_NUM; i++)
+		if (value0 & VFE_0_IRQ_STATUS_0_IMAGE_MASTER_n_PING_PONG(i))
+			vfe_isr_wm_done(vfe, i);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * vfe_set_clock_rates - Calculate and set clock rates on VFE module
+ * @vfe: VFE device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_set_clock_rates(struct vfe_device *vfe)
+{
+	struct device *dev = to_device(vfe);
+	u32 pixel_clock[MSM_VFE_LINE_NUM];
+	int i, j;
+	int ret;
+
+	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++) {
+		ret = camss_get_pixel_clock(&vfe->line[i].subdev.entity,
+					    &pixel_clock[i]);
+		if (ret)
+			pixel_clock[i] = 0;
+	}
+
+	for (i = 0; i < vfe->nclocks; i++) {
+		struct camss_clock *clock = &vfe->clock[i];
+
+		if (!strcmp(clock->name, "camss_vfe_vfe")) {
+			u64 min_rate = 0;
+			long rate;
+
+			for (j = VFE_LINE_RDI0; j <= VFE_LINE_PIX; j++) {
+				u32 tmp;
+				u8 bpp;
+
+				if (j == VFE_LINE_PIX) {
+					tmp = pixel_clock[j];
+				} else {
+					bpp = vfe_get_bpp(vfe->line[j].
+						fmt[MSM_VFE_PAD_SINK].code);
+					tmp = pixel_clock[j] * bpp / 64;
+				}
+
+				if (min_rate < tmp)
+					min_rate = tmp;
+			}
+
+			camss_add_clock_margin(&min_rate);
+
+			for (j = 0; j < clock->nfreqs; j++)
+				if (min_rate < clock->freq[j])
+					break;
+
+			if (j == clock->nfreqs) {
+				dev_err(dev,
+					"Pixel clock is too high for VFE");
+				return -EINVAL;
+			}
+
+			/* if sensor pixel clock is not available */
+			/* set highest possible VFE clock rate */
+			if (min_rate == 0)
+				j = clock->nfreqs - 1;
+
+			rate = clk_round_rate(clock->clk, clock->freq[j]);
+			if (rate < 0) {
+				dev_err(dev, "clk round rate failed: %ld\n",
+					rate);
+				return -EINVAL;
+			}
+
+			ret = clk_set_rate(clock->clk, rate);
+			if (ret < 0) {
+				dev_err(dev, "clk set rate failed: %d\n", ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_check_clock_rates - Check current clock rates on VFE module
+ * @vfe: VFE device
+ *
+ * Return 0 if current clock rates are suitable for a new pipeline
+ * or a negative error code otherwise
+ */
+static int vfe_check_clock_rates(struct vfe_device *vfe)
+{
+	u32 pixel_clock[MSM_VFE_LINE_NUM];
+	int i, j;
+	int ret;
+
+	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++) {
+		ret = camss_get_pixel_clock(&vfe->line[i].subdev.entity,
+					    &pixel_clock[i]);
+		if (ret)
+			pixel_clock[i] = 0;
+	}
+
+	for (i = 0; i < vfe->nclocks; i++) {
+		struct camss_clock *clock = &vfe->clock[i];
+
+		if (!strcmp(clock->name, "camss_vfe_vfe")) {
+			u64 min_rate = 0;
+			unsigned long rate;
+
+			for (j = VFE_LINE_RDI0; j <= VFE_LINE_PIX; j++) {
+				u32 tmp;
+				u8 bpp;
+
+				if (j == VFE_LINE_PIX) {
+					tmp = pixel_clock[j];
+				} else {
+					bpp = vfe_get_bpp(vfe->line[j].
+						fmt[MSM_VFE_PAD_SINK].code);
+					tmp = pixel_clock[j] * bpp / 64;
+				}
+
+				if (min_rate < tmp)
+					min_rate = tmp;
+			}
+
+			camss_add_clock_margin(&min_rate);
+
+			rate = clk_get_rate(clock->clk);
+			if (rate < min_rate)
+				return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_get - Power up and reset VFE module
+ * @vfe: VFE Device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_get(struct vfe_device *vfe)
+{
+	int ret;
+
+	mutex_lock(&vfe->power_lock);
+
+	if (vfe->power_count == 0) {
+		ret = vfe_set_clock_rates(vfe);
+		if (ret < 0)
+			goto error_clocks;
+
+		ret = camss_enable_clocks(vfe->nclocks, vfe->clock,
+					  to_device(vfe));
+		if (ret < 0)
+			goto error_clocks;
+
+		ret = vfe_reset(vfe);
+		if (ret < 0)
+			goto error_reset;
+
+		vfe_reset_output_maps(vfe);
+
+		vfe_init_outputs(vfe);
+	} else {
+		ret = vfe_check_clock_rates(vfe);
+		if (ret < 0)
+			goto error_clocks;
+	}
+	vfe->power_count++;
+
+	mutex_unlock(&vfe->power_lock);
+
+	return 0;
+
+error_reset:
+	camss_disable_clocks(vfe->nclocks, vfe->clock);
+
+error_clocks:
+	mutex_unlock(&vfe->power_lock);
+
+	return ret;
+}
+
+/*
+ * vfe_put - Power down VFE module
+ * @vfe: VFE Device
+ */
+static void vfe_put(struct vfe_device *vfe)
+{
+	mutex_lock(&vfe->power_lock);
+
+	if (vfe->power_count == 0) {
+		dev_err(to_device(vfe), "vfe power off on power_count == 0\n");
+		goto exit;
+	} else if (vfe->power_count == 1) {
+		if (vfe->was_streaming) {
+			vfe->was_streaming = 0;
+			vfe_halt(vfe);
+		}
+		camss_disable_clocks(vfe->nclocks, vfe->clock);
+	}
+
+	vfe->power_count--;
+
+exit:
+	mutex_unlock(&vfe->power_lock);
+}
+
+/*
+ * vfe_video_pad_to_line - Get pointer to VFE line by media pad
+ * @pad: Media pad
+ *
+ * Return pointer to vfe line structure
+ */
+static struct vfe_line *vfe_video_pad_to_line(struct media_pad *pad)
+{
+	struct media_pad *vfe_pad;
+	struct v4l2_subdev *subdev;
+
+	vfe_pad = media_entity_remote_pad(pad);
+	if (vfe_pad == NULL)
+		return NULL;
+
+	subdev = media_entity_to_v4l2_subdev(vfe_pad->entity);
+
+	return container_of(subdev, struct vfe_line, subdev);
+}
+
+/*
+ * vfe_queue_buffer - Add empty buffer
+ * @vid: Video device structure
+ * @buf: Buffer to be enqueued
+ *
+ * Add an empty buffer - depending on the current number of buffers it will be
+ * put in pending buffer queue or directly given to the hardware to be filled.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_queue_buffer(struct camss_video *vid,
+			    struct camss_buffer *buf)
+{
+	struct vfe_device *vfe = &vid->camss->vfe;
+	struct vfe_line *line;
+	struct vfe_output *output;
+	unsigned long flags;
+
+	line = vfe_video_pad_to_line(&vid->pad);
+	if (!line) {
+		dev_err(to_device(vfe), "Can not queue buffer\n");
+		return -1;
+	}
+	output = &line->output;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	vfe_buf_update_wm_on_new(vfe, output, buf);
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+}
+
+/*
+ * vfe_flush_buffers - Return all vb2 buffers
+ * @vid: Video device structure
+ * @state: vb2 buffer state of the returned buffers
+ *
+ * Return all buffers to vb2. This includes queued pending buffers (still
+ * unused) and any buffers given to the hardware but again still not used.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_flush_buffers(struct camss_video *vid,
+			     enum vb2_buffer_state state)
+{
+	struct vfe_device *vfe = &vid->camss->vfe;
+	struct vfe_line *line;
+	struct vfe_output *output;
+	unsigned long flags;
+
+	line = vfe_video_pad_to_line(&vid->pad);
+	if (!line) {
+		dev_err(to_device(vfe),	"Can not flush buffers\n");
+		return -1;
+	}
+	output = &line->output;
+
+	spin_lock_irqsave(&vfe->output_lock, flags);
+
+	vfe_buf_flush_pending(output, state);
+
+	if (output->buf[0])
+		vb2_buffer_done(&output->buf[0]->vb.vb2_buf, state);
+
+	if (output->buf[1])
+		vb2_buffer_done(&output->buf[1]->vb.vb2_buf, state);
+
+	if (output->last_buffer) {
+		vb2_buffer_done(&output->last_buffer->vb.vb2_buf, state);
+		output->last_buffer = NULL;
+	}
+
+	spin_unlock_irqrestore(&vfe->output_lock, flags);
+
+	return 0;
+}
+
+/*
+ * vfe_set_power - Power on/off VFE module
+ * @sd: VFE V4L2 subdevice
+ * @on: Requested power state
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_set_power(struct v4l2_subdev *sd, int on)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct vfe_device *vfe = to_vfe(line);
+	int ret;
+
+	if (on) {
+		u32 hw_version;
+
+		ret = vfe_get(vfe);
+		if (ret < 0)
+			return ret;
+
+		hw_version = readl_relaxed(vfe->base + VFE_0_HW_VERSION);
+		dev_dbg(to_device(vfe),
+			"VFE HW Version = 0x%08x\n", hw_version);
+	} else {
+		vfe_put(vfe);
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_set_stream - Enable/disable streaming on VFE module
+ * @sd: VFE V4L2 subdevice
+ * @enable: Requested streaming state
+ *
+ * Main configuration of VFE module is triggered here.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_set_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct vfe_device *vfe = to_vfe(line);
+	int ret;
+
+	if (enable) {
+		ret = vfe_enable(line);
+		if (ret < 0)
+			dev_err(to_device(vfe),
+				"Failed to enable vfe outputs\n");
+	} else {
+		ret = vfe_disable(line);
+		if (ret < 0)
+			dev_err(to_device(vfe),
+				"Failed to disable vfe outputs\n");
+	}
+
+	return ret;
+}
+
+/*
+ * __vfe_get_format - Get pointer to format structure
+ * @line: VFE line
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad from which format is requested
+ * @which: TRY or ACTIVE format
+ *
+ * Return pointer to TRY or ACTIVE format structure
+ */
+static struct v4l2_mbus_framefmt *
+__vfe_get_format(struct vfe_line *line,
+		 struct v4l2_subdev_pad_config *cfg,
+		 unsigned int pad,
+		 enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_format(&line->subdev, cfg, pad);
+
+	return &line->fmt[pad];
+}
+
+/*
+ * __vfe_get_compose - Get pointer to compose selection structure
+ * @line: VFE line
+ * @cfg: V4L2 subdev pad configuration
+ * @which: TRY or ACTIVE format
+ *
+ * Return pointer to TRY or ACTIVE compose rectangle structure
+ */
+static struct v4l2_rect *
+__vfe_get_compose(struct vfe_line *line,
+		  struct v4l2_subdev_pad_config *cfg,
+		  enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_compose(&line->subdev, cfg,
+						   MSM_VFE_PAD_SINK);
+
+	return &line->compose;
+}
+
+/*
+ * __vfe_get_crop - Get pointer to crop selection structure
+ * @line: VFE line
+ * @cfg: V4L2 subdev pad configuration
+ * @which: TRY or ACTIVE format
+ *
+ * Return pointer to TRY or ACTIVE crop rectangle structure
+ */
+static struct v4l2_rect *
+__vfe_get_crop(struct vfe_line *line,
+	       struct v4l2_subdev_pad_config *cfg,
+	       enum v4l2_subdev_format_whence which)
+{
+	if (which == V4L2_SUBDEV_FORMAT_TRY)
+		return v4l2_subdev_get_try_crop(&line->subdev, cfg,
+						MSM_VFE_PAD_SRC);
+
+	return &line->crop;
+}
+
+/*
+ * vfe_try_format - Handle try format by pad subdev method
+ * @line: VFE line
+ * @cfg: V4L2 subdev pad configuration
+ * @pad: pad on which format is requested
+ * @fmt: pointer to v4l2 format structure
+ * @which: wanted subdev format
+ */
+static void vfe_try_format(struct vfe_line *line,
+			   struct v4l2_subdev_pad_config *cfg,
+			   unsigned int pad,
+			   struct v4l2_mbus_framefmt *fmt,
+			   enum v4l2_subdev_format_whence which)
+{
+	unsigned int i;
+	u32 code;
+
+	switch (pad) {
+	case MSM_VFE_PAD_SINK:
+		/* Set format on sink pad */
+
+		for (i = 0; i < ARRAY_SIZE(vfe_formats); i++)
+			if (fmt->code == vfe_formats[i].code)
+				break;
+
+		/* If not found, use UYVY as default */
+		if (i >= ARRAY_SIZE(vfe_formats))
+			fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
+		fmt->width = clamp_t(u32, fmt->width, 1, 8191);
+		fmt->height = clamp_t(u32, fmt->height, 1, 8191);
+
+		fmt->field = V4L2_FIELD_NONE;
+		fmt->colorspace = V4L2_COLORSPACE_SRGB;
+
+		break;
+
+	case MSM_VFE_PAD_SRC:
+		/* Set and return a format same as sink pad */
+
+		code = fmt->code;
+
+		*fmt = *__vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
+					 which);
+
+		if (line->id == VFE_LINE_PIX) {
+			struct v4l2_rect *rect;
+
+			rect = __vfe_get_crop(line, cfg, which);
+
+			fmt->width = rect->width;
+			fmt->height = rect->height;
+
+			switch (fmt->code) {
+			case MEDIA_BUS_FMT_YUYV8_2X8:
+				if (code == MEDIA_BUS_FMT_YUYV8_1_5X8)
+					fmt->code = MEDIA_BUS_FMT_YUYV8_1_5X8;
+				else
+					fmt->code = MEDIA_BUS_FMT_YUYV8_2X8;
+				break;
+			case MEDIA_BUS_FMT_YVYU8_2X8:
+				if (code == MEDIA_BUS_FMT_YVYU8_1_5X8)
+					fmt->code = MEDIA_BUS_FMT_YVYU8_1_5X8;
+				else
+					fmt->code = MEDIA_BUS_FMT_YVYU8_2X8;
+				break;
+			case MEDIA_BUS_FMT_UYVY8_2X8:
+			default:
+				if (code == MEDIA_BUS_FMT_UYVY8_1_5X8)
+					fmt->code = MEDIA_BUS_FMT_UYVY8_1_5X8;
+				else
+					fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+				break;
+			case MEDIA_BUS_FMT_VYUY8_2X8:
+				if (code == MEDIA_BUS_FMT_VYUY8_1_5X8)
+					fmt->code = MEDIA_BUS_FMT_VYUY8_1_5X8;
+				else
+					fmt->code = MEDIA_BUS_FMT_VYUY8_2X8;
+				break;
+			}
+		}
+
+		break;
+	}
+
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+}
+
+/*
+ * vfe_try_compose - Handle try compose selection by pad subdev method
+ * @line: VFE line
+ * @cfg: V4L2 subdev pad configuration
+ * @rect: pointer to v4l2 rect structure
+ * @which: wanted subdev format
+ */
+static void vfe_try_compose(struct vfe_line *line,
+			    struct v4l2_subdev_pad_config *cfg,
+			    struct v4l2_rect *rect,
+			    enum v4l2_subdev_format_whence which)
+{
+	struct v4l2_mbus_framefmt *fmt;
+
+	fmt = __vfe_get_format(line, cfg, MSM_VFE_PAD_SINK, which);
+
+	if (rect->width > fmt->width)
+		rect->width = fmt->width;
+
+	if (rect->height > fmt->height)
+		rect->height = fmt->height;
+
+	if (fmt->width > rect->width * SCALER_RATIO_MAX)
+		rect->width = (fmt->width + SCALER_RATIO_MAX - 1) /
+							SCALER_RATIO_MAX;
+
+	rect->width &= ~0x1;
+
+	if (fmt->height > rect->height * SCALER_RATIO_MAX)
+		rect->height = (fmt->height + SCALER_RATIO_MAX - 1) /
+							SCALER_RATIO_MAX;
+
+	if (rect->width < 16)
+		rect->width = 16;
+
+	if (rect->height < 4)
+		rect->height = 4;
+}
+
+/*
+ * vfe_try_crop - Handle try crop selection by pad subdev method
+ * @line: VFE line
+ * @cfg: V4L2 subdev pad configuration
+ * @rect: pointer to v4l2 rect structure
+ * @which: wanted subdev format
+ */
+static void vfe_try_crop(struct vfe_line *line,
+			 struct v4l2_subdev_pad_config *cfg,
+			 struct v4l2_rect *rect,
+			 enum v4l2_subdev_format_whence which)
+{
+	struct v4l2_rect *compose;
+
+	compose = __vfe_get_compose(line, cfg, which);
+
+	if (rect->width > compose->width)
+		rect->width = compose->width;
+
+	if (rect->width + rect->left > compose->width)
+		rect->left = compose->width - rect->width;
+
+	if (rect->height > compose->height)
+		rect->height = compose->height;
+
+	if (rect->height + rect->top > compose->height)
+		rect->top = compose->height - rect->height;
+
+	/* wm in line based mode writes multiple of 16 horizontally */
+	rect->left += (rect->width & 0xf) >> 1;
+	rect->width &= ~0xf;
+
+	if (rect->width < 16) {
+		rect->left = 0;
+		rect->width = 16;
+	}
+
+	if (rect->height < 4) {
+		rect->top = 0;
+		rect->height = 4;
+	}
+}
+
+/*
+ * vfe_enum_mbus_code - Handle pixel format enumeration
+ * @sd: VFE V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @code: pointer to v4l2_subdev_mbus_code_enum structure
+ *
+ * return -EINVAL or zero on success
+ */
+static int vfe_enum_mbus_code(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_pad_config *cfg,
+			      struct v4l2_subdev_mbus_code_enum *code)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	if (code->pad == MSM_VFE_PAD_SINK) {
+		if (code->index >= ARRAY_SIZE(vfe_formats))
+			return -EINVAL;
+
+		code->code = vfe_formats[code->index].code;
+	} else {
+		if (code->index > 0)
+			return -EINVAL;
+
+		format = __vfe_get_format(line, cfg, MSM_VFE_PAD_SINK,
+					  code->which);
+
+		code->code = format->code;
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_enum_frame_size - Handle frame size enumeration
+ * @sd: VFE V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fse: pointer to v4l2_subdev_frame_size_enum structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int vfe_enum_frame_size(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_pad_config *cfg,
+			       struct v4l2_subdev_frame_size_enum *fse)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt format;
+
+	if (fse->index != 0)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = 1;
+	format.height = 1;
+	vfe_try_format(line, cfg, fse->pad, &format, fse->which);
+	fse->min_width = format.width;
+	fse->min_height = format.height;
+
+	if (format.code != fse->code)
+		return -EINVAL;
+
+	format.code = fse->code;
+	format.width = -1;
+	format.height = -1;
+	vfe_try_format(line, cfg, fse->pad, &format, fse->which);
+	fse->max_width = format.width;
+	fse->max_height = format.height;
+
+	return 0;
+}
+
+/*
+ * vfe_get_format - Handle get format by pads subdev method
+ * @sd: VFE V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int vfe_get_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_pad_config *cfg,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __vfe_get_format(line, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	fmt->format = *format;
+
+	return 0;
+}
+
+static int vfe_set_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_pad_config *cfg,
+			     struct v4l2_subdev_selection *sel);
+
+/*
+ * vfe_set_format - Handle set format by pads subdev method
+ * @sd: VFE V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @fmt: pointer to v4l2 subdev format structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int vfe_set_format(struct v4l2_subdev *sd,
+			  struct v4l2_subdev_pad_config *cfg,
+			  struct v4l2_subdev_format *fmt)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = __vfe_get_format(line, cfg, fmt->pad, fmt->which);
+	if (format == NULL)
+		return -EINVAL;
+
+	vfe_try_format(line, cfg, fmt->pad, &fmt->format, fmt->which);
+	*format = fmt->format;
+
+	if (fmt->pad == MSM_VFE_PAD_SINK) {
+		struct v4l2_subdev_selection sel = { 0 };
+		int ret;
+
+		/* Propagate the format from sink to source */
+		format = __vfe_get_format(line, cfg, MSM_VFE_PAD_SRC,
+					  fmt->which);
+
+		*format = fmt->format;
+		vfe_try_format(line, cfg, MSM_VFE_PAD_SRC, format,
+			       fmt->which);
+
+		if (line->id != VFE_LINE_PIX)
+			return 0;
+
+		/* Reset sink pad compose selection */
+		sel.which = fmt->which;
+		sel.pad = MSM_VFE_PAD_SINK;
+		sel.target = V4L2_SEL_TGT_COMPOSE;
+		sel.r.width = fmt->format.width;
+		sel.r.height = fmt->format.height;
+		ret = vfe_set_selection(sd, cfg, &sel);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * vfe_get_selection - Handle get selection by pads subdev method
+ * @sd: VFE V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @sel: pointer to v4l2 subdev selection structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int vfe_get_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_pad_config *cfg,
+			     struct v4l2_subdev_selection *sel)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_rect *rect;
+	int ret;
+
+	if (line->id != VFE_LINE_PIX)
+		return -EINVAL;
+
+	if (sel->pad == MSM_VFE_PAD_SINK)
+		switch (sel->target) {
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+			fmt.pad = sel->pad;
+			fmt.which = sel->which;
+			ret = vfe_get_format(sd, cfg, &fmt);
+			if (ret < 0)
+				return ret;
+
+			sel->r.left = 0;
+			sel->r.top = 0;
+			sel->r.width = fmt.format.width;
+			sel->r.height = fmt.format.height;
+			break;
+		case V4L2_SEL_TGT_COMPOSE:
+			rect = __vfe_get_compose(line, cfg, sel->which);
+			if (rect == NULL)
+				return -EINVAL;
+
+			sel->r = *rect;
+			break;
+		default:
+			return -EINVAL;
+		}
+	else if (sel->pad == MSM_VFE_PAD_SRC)
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP_BOUNDS:
+			rect = __vfe_get_compose(line, cfg, sel->which);
+			if (rect == NULL)
+				return -EINVAL;
+
+			sel->r.left = rect->left;
+			sel->r.top = rect->top;
+			sel->r.width = rect->width;
+			sel->r.height = rect->height;
+			break;
+		case V4L2_SEL_TGT_CROP:
+			rect = __vfe_get_crop(line, cfg, sel->which);
+			if (rect == NULL)
+				return -EINVAL;
+
+			sel->r = *rect;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+	return 0;
+}
+
+/*
+ * vfe_set_selection - Handle set selection by pads subdev method
+ * @sd: VFE V4L2 subdevice
+ * @cfg: V4L2 subdev pad configuration
+ * @sel: pointer to v4l2 subdev selection structure
+ *
+ * Return -EINVAL or zero on success
+ */
+static int vfe_set_selection(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_pad_config *cfg,
+			     struct v4l2_subdev_selection *sel)
+{
+	struct vfe_line *line = v4l2_get_subdevdata(sd);
+	struct v4l2_rect *rect;
+	int ret;
+
+	if (line->id != VFE_LINE_PIX)
+		return -EINVAL;
+
+	if (sel->target == V4L2_SEL_TGT_COMPOSE &&
+		sel->pad == MSM_VFE_PAD_SINK) {
+		struct v4l2_subdev_selection crop = { 0 };
+
+		rect = __vfe_get_compose(line, cfg, sel->which);
+		if (rect == NULL)
+			return -EINVAL;
+
+		vfe_try_compose(line, cfg, &sel->r, sel->which);
+		*rect = sel->r;
+
+		/* Reset source crop selection */
+		crop.which = sel->which;
+		crop.pad = MSM_VFE_PAD_SRC;
+		crop.target = V4L2_SEL_TGT_CROP;
+		crop.r = *rect;
+		ret = vfe_set_selection(sd, cfg, &crop);
+	} else if (sel->target == V4L2_SEL_TGT_CROP &&
+		sel->pad == MSM_VFE_PAD_SRC) {
+		struct v4l2_subdev_format fmt = { 0 };
+
+		rect = __vfe_get_crop(line, cfg, sel->which);
+		if (rect == NULL)
+			return -EINVAL;
+
+		vfe_try_crop(line, cfg, &sel->r, sel->which);
+		*rect = sel->r;
+
+		/* Reset source pad format width and height */
+		fmt.which = sel->which;
+		fmt.pad = MSM_VFE_PAD_SRC;
+		ret = vfe_get_format(sd, cfg, &fmt);
+		if (ret < 0)
+			return ret;
+
+		fmt.format.width = rect->width;
+		fmt.format.height = rect->height;
+		ret = vfe_set_format(sd, cfg, &fmt);
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * vfe_init_formats - Initialize formats on all pads
+ * @sd: VFE V4L2 subdevice
+ * @fh: V4L2 subdev file handle
+ *
+ * Initialize all pad formats with default values.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int vfe_init_formats(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+{
+	struct v4l2_subdev_format format = {
+		.pad = MSM_VFE_PAD_SINK,
+		.which = fh ? V4L2_SUBDEV_FORMAT_TRY :
+			      V4L2_SUBDEV_FORMAT_ACTIVE,
+		.format = {
+			.code = MEDIA_BUS_FMT_UYVY8_2X8,
+			.width = 1920,
+			.height = 1080
+		}
+	};
+
+	return vfe_set_format(sd, fh ? fh->pad : NULL, &format);
+}
+
+/*
+ * msm_vfe_subdev_init - Initialize VFE device structure and resources
+ * @vfe: VFE device
+ * @res: VFE module resources table
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_vfe_subdev_init(struct vfe_device *vfe, const struct resources *res)
+{
+	struct device *dev = to_device(vfe);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *r;
+	struct camss *camss = to_camss(vfe);
+	int i, j;
+	int ret;
+
+	/* Memory */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, res->reg[0]);
+	vfe->base = devm_ioremap_resource(dev, r);
+	if (IS_ERR(vfe->base)) {
+		dev_err(dev, "could not map memory\n");
+		return PTR_ERR(vfe->base);
+	}
+
+	/* Interrupt */
+
+	r = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+					 res->interrupt[0]);
+	if (!r) {
+		dev_err(dev, "missing IRQ\n");
+		return -EINVAL;
+	}
+
+	vfe->irq = r->start;
+	snprintf(vfe->irq_name, sizeof(vfe->irq_name), "%s_%s%d",
+		 dev_name(dev), MSM_VFE_NAME, vfe->id);
+	ret = devm_request_irq(dev, vfe->irq, vfe_isr,
+			       IRQF_TRIGGER_RISING, vfe->irq_name, vfe);
+	if (ret < 0) {
+		dev_err(dev, "request_irq failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Clocks */
+
+	vfe->nclocks = 0;
+	while (res->clock[vfe->nclocks])
+		vfe->nclocks++;
+
+	vfe->clock = devm_kcalloc(dev, vfe->nclocks, sizeof(*vfe->clock),
+				  GFP_KERNEL);
+	if (!vfe->clock)
+		return -ENOMEM;
+
+	for (i = 0; i < vfe->nclocks; i++) {
+		struct camss_clock *clock = &vfe->clock[i];
+
+		clock->clk = devm_clk_get(dev, res->clock[i]);
+		if (IS_ERR(clock->clk))
+			return PTR_ERR(clock->clk);
+
+		clock->name = res->clock[i];
+
+		clock->nfreqs = 0;
+		while (res->clock_rate[i][clock->nfreqs])
+			clock->nfreqs++;
+
+		if (!clock->nfreqs) {
+			clock->freq = NULL;
+			continue;
+		}
+
+		clock->freq = devm_kcalloc(dev,
+					   clock->nfreqs,
+					   sizeof(*clock->freq),
+					   GFP_KERNEL);
+		if (!clock->freq)
+			return -ENOMEM;
+
+		for (j = 0; j < clock->nfreqs; j++)
+			clock->freq[j] = res->clock_rate[i][j];
+	}
+
+	mutex_init(&vfe->power_lock);
+	vfe->power_count = 0;
+
+	mutex_init(&vfe->stream_lock);
+	vfe->stream_count = 0;
+
+	spin_lock_init(&vfe->output_lock);
+
+	vfe->id = 0;
+	vfe->reg_update = 0;
+
+	for (i = VFE_LINE_RDI0; i <= VFE_LINE_PIX; i++) {
+		vfe->line[i].video_out.type =
+					V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+		vfe->line[i].video_out.camss = camss;
+		vfe->line[i].id = i;
+		init_completion(&vfe->line[i].output.sof);
+		init_completion(&vfe->line[i].output.reg_update);
+	}
+
+	init_completion(&vfe->reset_complete);
+	init_completion(&vfe->halt_complete);
+
+	return 0;
+}
+
+/*
+ * msm_vfe_get_vfe_id - Get VFE HW module id
+ * @entity: Pointer to VFE media entity structure
+ * @id: Return CSID HW module id here
+ */
+void msm_vfe_get_vfe_id(struct media_entity *entity, u8 *id)
+{
+	struct v4l2_subdev *sd;
+	struct vfe_line *line;
+	struct vfe_device *vfe;
+
+	sd = media_entity_to_v4l2_subdev(entity);
+	line = v4l2_get_subdevdata(sd);
+	vfe = to_vfe(line);
+
+	*id = vfe->id;
+}
+
+/*
+ * msm_vfe_get_vfe_line_id - Get VFE line id by media entity
+ * @entity: Pointer to VFE media entity structure
+ * @id: Return VFE line id here
+ */
+void msm_vfe_get_vfe_line_id(struct media_entity *entity, enum vfe_line_id *id)
+{
+	struct v4l2_subdev *sd;
+	struct vfe_line *line;
+
+	sd = media_entity_to_v4l2_subdev(entity);
+	line = v4l2_get_subdevdata(sd);
+
+	*id = line->id;
+}
+
+/*
+ * vfe_link_setup - Setup VFE connections
+ * @entity: Pointer to media entity structure
+ * @local: Pointer to local pad
+ * @remote: Pointer to remote pad
+ * @flags: Link flags
+ *
+ * Return 0 on success
+ */
+static int vfe_link_setup(struct media_entity *entity,
+			  const struct media_pad *local,
+			  const struct media_pad *remote, u32 flags)
+{
+	if (flags & MEDIA_LNK_FL_ENABLED)
+		if (media_entity_remote_pad(local))
+			return -EBUSY;
+
+	return 0;
+}
+
+static const struct v4l2_subdev_core_ops vfe_core_ops = {
+	.s_power = vfe_set_power,
+};
+
+static const struct v4l2_subdev_video_ops vfe_video_ops = {
+	.s_stream = vfe_set_stream,
+};
+
+static const struct v4l2_subdev_pad_ops vfe_pad_ops = {
+	.enum_mbus_code = vfe_enum_mbus_code,
+	.enum_frame_size = vfe_enum_frame_size,
+	.get_fmt = vfe_get_format,
+	.set_fmt = vfe_set_format,
+	.get_selection = vfe_get_selection,
+	.set_selection = vfe_set_selection,
+};
+
+static const struct v4l2_subdev_ops vfe_v4l2_ops = {
+	.core = &vfe_core_ops,
+	.video = &vfe_video_ops,
+	.pad = &vfe_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops vfe_v4l2_internal_ops = {
+	.open = vfe_init_formats,
+};
+
+static const struct media_entity_operations vfe_media_ops = {
+	.link_setup = vfe_link_setup,
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static const struct camss_video_ops camss_vfe_video_ops = {
+	.queue_buffer = vfe_queue_buffer,
+	.flush_buffers = vfe_flush_buffers,
+};
+
+void msm_vfe_stop_streaming(struct vfe_device *vfe)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe->line); i++)
+		msm_video_stop_streaming(&vfe->line[i].video_out);
+}
+
+/*
+ * msm_vfe_register_entities - Register subdev node for VFE module
+ * @vfe: VFE device
+ * @v4l2_dev: V4L2 device
+ *
+ * Initialize and register a subdev node for the VFE module. Then
+ * call msm_video_register() to register the video device node which
+ * will be connected to this subdev node. Then actually create the
+ * media link between them.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int msm_vfe_register_entities(struct vfe_device *vfe,
+			      struct v4l2_device *v4l2_dev)
+{
+	struct device *dev = to_device(vfe);
+	struct v4l2_subdev *sd;
+	struct media_pad *pads;
+	struct camss_video *video_out;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vfe->line); i++) {
+		char name[32];
+
+		sd = &vfe->line[i].subdev;
+		pads = vfe->line[i].pads;
+		video_out = &vfe->line[i].video_out;
+
+		v4l2_subdev_init(sd, &vfe_v4l2_ops);
+		sd->internal_ops = &vfe_v4l2_internal_ops;
+		sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+		if (i == VFE_LINE_PIX)
+			snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d_%s",
+				 MSM_VFE_NAME, vfe->id, "pix");
+		else
+			snprintf(sd->name, ARRAY_SIZE(sd->name), "%s%d_%s%d",
+				 MSM_VFE_NAME, vfe->id, "rdi", i);
+
+		v4l2_set_subdevdata(sd, &vfe->line[i]);
+
+		ret = vfe_init_formats(sd, NULL);
+		if (ret < 0) {
+			dev_err(dev, "Failed to init format: %d\n", ret);
+			goto error_init;
+		}
+
+		pads[MSM_VFE_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+		pads[MSM_VFE_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
+
+		sd->entity.function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
+		sd->entity.ops = &vfe_media_ops;
+		ret = media_entity_pads_init(&sd->entity, MSM_VFE_PADS_NUM,
+					     pads);
+		if (ret < 0) {
+			dev_err(dev, "Failed to init media entity: %d\n", ret);
+			goto error_init;
+		}
+
+		ret = v4l2_device_register_subdev(v4l2_dev, sd);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register subdev: %d\n", ret);
+			goto error_reg_subdev;
+		}
+
+		video_out->ops = &camss_vfe_video_ops;
+		video_out->bpl_alignment = 8;
+		video_out->line_based = 0;
+		if (i == VFE_LINE_PIX) {
+			video_out->bpl_alignment = 16;
+			video_out->line_based = 1;
+		}
+		snprintf(name, ARRAY_SIZE(name), "%s%d_%s%d",
+			 MSM_VFE_NAME, vfe->id, "video", i);
+		ret = msm_video_register(video_out, v4l2_dev, name,
+					 i == VFE_LINE_PIX ? 1 : 0);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register video node: %d\n",
+				ret);
+			goto error_reg_video;
+		}
+
+		ret = media_create_pad_link(
+				&sd->entity, MSM_VFE_PAD_SRC,
+				&video_out->vdev.entity, 0,
+				MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+		if (ret < 0) {
+			dev_err(dev, "Failed to link %s->%s entities: %d\n",
+				sd->entity.name, video_out->vdev.entity.name,
+				ret);
+			goto error_link;
+		}
+	}
+
+	return 0;
+
+error_link:
+	msm_video_unregister(video_out);
+
+error_reg_video:
+	v4l2_device_unregister_subdev(sd);
+
+error_reg_subdev:
+	media_entity_cleanup(&sd->entity);
+
+error_init:
+	for (i--; i >= 0; i--) {
+		sd = &vfe->line[i].subdev;
+		video_out = &vfe->line[i].video_out;
+
+		msm_video_unregister(video_out);
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+	}
+
+	return ret;
+}
+
+/*
+ * msm_vfe_unregister_entities - Unregister VFE module subdev node
+ * @vfe: VFE device
+ */
+void msm_vfe_unregister_entities(struct vfe_device *vfe)
+{
+	int i;
+
+	mutex_destroy(&vfe->power_lock);
+	mutex_destroy(&vfe->stream_lock);
+
+	for (i = 0; i < ARRAY_SIZE(vfe->line); i++) {
+		struct v4l2_subdev *sd = &vfe->line[i].subdev;
+		struct camss_video *video_out = &vfe->line[i].video_out;
+
+		msm_video_unregister(video_out);
+		v4l2_device_unregister_subdev(sd);
+		media_entity_cleanup(&sd->entity);
+	}
+}
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
new file mode 100644
index 0000000..5aa7407
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -0,0 +1,123 @@
+/*
+ * camss-vfe.h
+ *
+ * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module
+ *
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef QC_MSM_CAMSS_VFE_H
+#define QC_MSM_CAMSS_VFE_H
+
+#include <linux/clk.h>
+#include <linux/spinlock_types.h>
+#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+#include "camss-video.h"
+
+#define MSM_VFE_PAD_SINK 0
+#define MSM_VFE_PAD_SRC 1
+#define MSM_VFE_PADS_NUM 2
+
+#define MSM_VFE_LINE_NUM 4
+#define MSM_VFE_IMAGE_MASTERS_NUM 7
+#define MSM_VFE_COMPOSITE_IRQ_NUM 4
+
+#define MSM_VFE_VFE0_UB_SIZE 1023
+#define MSM_VFE_VFE0_UB_SIZE_RDI (MSM_VFE_VFE0_UB_SIZE / 3)
+#define MSM_VFE_VFE1_UB_SIZE 1535
+#define MSM_VFE_VFE1_UB_SIZE_RDI (MSM_VFE_VFE1_UB_SIZE / 3)
+
+enum vfe_output_state {
+	VFE_OUTPUT_OFF,
+	VFE_OUTPUT_RESERVED,
+	VFE_OUTPUT_SINGLE,
+	VFE_OUTPUT_CONTINUOUS,
+	VFE_OUTPUT_IDLE,
+	VFE_OUTPUT_STOPPING
+};
+
+enum vfe_line_id {
+	VFE_LINE_NONE = -1,
+	VFE_LINE_RDI0 = 0,
+	VFE_LINE_RDI1 = 1,
+	VFE_LINE_RDI2 = 2,
+	VFE_LINE_PIX = 3
+};
+
+struct vfe_output {
+	u8 wm_num;
+	u8 wm_idx[3];
+
+	int active_buf;
+	struct camss_buffer *buf[2];
+	struct camss_buffer *last_buffer;
+	struct list_head pending_bufs;
+
+	unsigned int drop_update_idx;
+
+	enum vfe_output_state state;
+	unsigned int sequence;
+	int wait_sof;
+	int wait_reg_update;
+	struct completion sof;
+	struct completion reg_update;
+};
+
+struct vfe_line {
+	enum vfe_line_id id;
+	struct v4l2_subdev subdev;
+	struct media_pad pads[MSM_VFE_PADS_NUM];
+	struct v4l2_mbus_framefmt fmt[MSM_VFE_PADS_NUM];
+	struct v4l2_rect compose;
+	struct v4l2_rect crop;
+	struct camss_video video_out;
+	struct vfe_output output;
+};
+
+struct vfe_device {
+	u8 id;
+	void __iomem *base;
+	u32 irq;
+	char irq_name[30];
+	struct camss_clock *clock;
+	int nclocks;
+	struct completion reset_complete;
+	struct completion halt_complete;
+	struct mutex power_lock;
+	int power_count;
+	struct mutex stream_lock;
+	int stream_count;
+	spinlock_t output_lock;
+	enum vfe_line_id wm_output_map[MSM_VFE_IMAGE_MASTERS_NUM];
+	struct vfe_line line[MSM_VFE_LINE_NUM];
+	u32 reg_update;
+	u8 was_streaming;
+};
+
+struct resources;
+
+int msm_vfe_subdev_init(struct vfe_device *vfe, const struct resources *res);
+
+int msm_vfe_register_entities(struct vfe_device *vfe,
+			      struct v4l2_device *v4l2_dev);
+
+void msm_vfe_unregister_entities(struct vfe_device *vfe);
+
+void msm_vfe_get_vfe_id(struct media_entity *entity, u8 *id);
+void msm_vfe_get_vfe_line_id(struct media_entity *entity, enum vfe_line_id *id);
+
+void msm_vfe_stop_streaming(struct vfe_device *vfe);
+
+#endif /* QC_MSM_CAMSS_VFE_H */
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
new file mode 100644
index 0000000..0e7b842
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -0,0 +1,859 @@
+/*
+ * camss-video.c
+ *
+ * Qualcomm MSM Camera Subsystem - V4L2 device node
+ *
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/slab.h>
+#include <media/media-entity.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-mc.h>
+#include <media/videobuf2-dma-sg.h>
+
+#include "camss-video.h"
+#include "camss.h"
+
+struct fract {
+	u8 numerator;
+	u8 denominator;
+};
+
+/*
+ * struct camss_format_info - ISP media bus format information
+ * @code: V4L2 media bus format code
+ * @pixelformat: V4L2 pixel format FCC identifier
+ * @planes: Number of planes
+ * @hsub: Horizontal subsampling (for each plane)
+ * @vsub: Vertical subsampling (for each plane)
+ * @bpp: Bits per pixel when stored in memory (for each plane)
+ */
+struct camss_format_info {
+	u32 code;
+	u32 pixelformat;
+	u8 planes;
+	struct fract hsub[3];
+	struct fract vsub[3];
+	unsigned int bpp[3];
+};
+
+static const struct camss_format_info formats_rdi[] = {
+	{ MEDIA_BUS_FMT_UYVY8_2X8, V4L2_PIX_FMT_UYVY, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
+	{ MEDIA_BUS_FMT_VYUY8_2X8, V4L2_PIX_FMT_VYUY, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
+	{ MEDIA_BUS_FMT_YUYV8_2X8, V4L2_PIX_FMT_YUYV, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
+	{ MEDIA_BUS_FMT_YVYU8_2X8, V4L2_PIX_FMT_YVYU, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 16 } },
+	{ MEDIA_BUS_FMT_SBGGR8_1X8, V4L2_PIX_FMT_SBGGR8, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
+	{ MEDIA_BUS_FMT_SGBRG8_1X8, V4L2_PIX_FMT_SGBRG8, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
+	{ MEDIA_BUS_FMT_SGRBG8_1X8, V4L2_PIX_FMT_SGRBG8, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
+	{ MEDIA_BUS_FMT_SRGGB8_1X8, V4L2_PIX_FMT_SRGGB8, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 8 } },
+	{ MEDIA_BUS_FMT_SBGGR10_1X10, V4L2_PIX_FMT_SBGGR10P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SGBRG10_1X10, V4L2_PIX_FMT_SGBRG10P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SGRBG10_1X10, V4L2_PIX_FMT_SGRBG10P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SRGGB10_1X10, V4L2_PIX_FMT_SRGGB10P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 10 } },
+	{ MEDIA_BUS_FMT_SBGGR12_1X12, V4L2_PIX_FMT_SBGGR12P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SGBRG12_1X12, V4L2_PIX_FMT_SGBRG12P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SGRBG12_1X12, V4L2_PIX_FMT_SGRBG12P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+	{ MEDIA_BUS_FMT_SRGGB12_1X12, V4L2_PIX_FMT_SRGGB12P, 1,
+	  { { 1, 1 } }, { { 1, 1 } }, { 12 } },
+};
+
+static const struct camss_format_info formats_pix[] = {
+	{ MEDIA_BUS_FMT_YUYV8_1_5X8, V4L2_PIX_FMT_NV12, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YVYU8_1_5X8, V4L2_PIX_FMT_NV12, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_UYVY8_1_5X8, V4L2_PIX_FMT_NV12, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_VYUY8_1_5X8, V4L2_PIX_FMT_NV12, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YUYV8_1_5X8, V4L2_PIX_FMT_NV21, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YVYU8_1_5X8, V4L2_PIX_FMT_NV21, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_UYVY8_1_5X8, V4L2_PIX_FMT_NV21, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_VYUY8_1_5X8, V4L2_PIX_FMT_NV21, 1,
+	  { { 1, 1 } }, { { 2, 3 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YUYV8_2X8, V4L2_PIX_FMT_NV16, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YVYU8_2X8, V4L2_PIX_FMT_NV16, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_UYVY8_2X8, V4L2_PIX_FMT_NV16, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_VYUY8_2X8, V4L2_PIX_FMT_NV16, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YUYV8_2X8, V4L2_PIX_FMT_NV61, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_YVYU8_2X8, V4L2_PIX_FMT_NV61, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_UYVY8_2X8, V4L2_PIX_FMT_NV61, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+	{ MEDIA_BUS_FMT_VYUY8_2X8, V4L2_PIX_FMT_NV61, 1,
+	  { { 1, 1 } }, { { 1, 2 } }, { 8 } },
+};
+
+/* -----------------------------------------------------------------------------
+ * Helper functions
+ */
+
+static int video_find_format(u32 code, u32 pixelformat,
+			     const struct camss_format_info *formats,
+			     unsigned int nformats)
+{
+	int i;
+
+	for (i = 0; i < nformats; i++) {
+		if (formats[i].code == code &&
+		    formats[i].pixelformat == pixelformat)
+			return i;
+	}
+
+	for (i = 0; i < nformats; i++)
+		if (formats[i].code == code)
+			return i;
+
+	WARN_ON(1);
+
+	return -EINVAL;
+}
+
+/*
+ * video_mbus_to_pix_mp - Convert v4l2_mbus_framefmt to v4l2_pix_format_mplane
+ * @mbus: v4l2_mbus_framefmt format (input)
+ * @pix: v4l2_pix_format_mplane format (output)
+ * @f: a pointer to formats array element to be used for the conversion
+ * @alignment: bytesperline alignment value
+ *
+ * Fill the output pix structure with information from the input mbus format.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int video_mbus_to_pix_mp(const struct v4l2_mbus_framefmt *mbus,
+				struct v4l2_pix_format_mplane *pix,
+				const struct camss_format_info *f,
+				unsigned int alignment)
+{
+	unsigned int i;
+	u32 bytesperline;
+
+	memset(pix, 0, sizeof(*pix));
+	v4l2_fill_pix_format_mplane(pix, mbus);
+	pix->pixelformat = f->pixelformat;
+	pix->num_planes = f->planes;
+	for (i = 0; i < pix->num_planes; i++) {
+		bytesperline = pix->width / f->hsub[i].numerator *
+			f->hsub[i].denominator * f->bpp[i] / 8;
+		bytesperline = ALIGN(bytesperline, alignment);
+		pix->plane_fmt[i].bytesperline = bytesperline;
+		pix->plane_fmt[i].sizeimage = pix->height /
+				f->vsub[i].numerator * f->vsub[i].denominator *
+				bytesperline;
+	}
+
+	return 0;
+}
+
+static struct v4l2_subdev *video_remote_subdev(struct camss_video *video,
+					       u32 *pad)
+{
+	struct media_pad *remote;
+
+	remote = media_entity_remote_pad(&video->pad);
+
+	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
+		return NULL;
+
+	if (pad)
+		*pad = remote->index;
+
+	return media_entity_to_v4l2_subdev(remote->entity);
+}
+
+static int video_get_subdev_format(struct camss_video *video,
+				   struct v4l2_format *format)
+{
+	struct v4l2_subdev_format fmt;
+	struct v4l2_subdev *subdev;
+	u32 pad;
+	int ret;
+
+	subdev = video_remote_subdev(video, &pad);
+	if (subdev == NULL)
+		return -EPIPE;
+
+	fmt.pad = pad;
+	fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
+
+	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);
+	if (ret)
+		return ret;
+
+	ret = video_find_format(fmt.format.code,
+				format->fmt.pix_mp.pixelformat,
+				video->formats, video->nformats);
+	if (ret < 0)
+		return ret;
+
+	format->type = video->type;
+
+	return video_mbus_to_pix_mp(&fmt.format, &format->fmt.pix_mp,
+				    &video->formats[ret], video->bpl_alignment);
+}
+
+/* -----------------------------------------------------------------------------
+ * Video queue operations
+ */
+
+static int video_queue_setup(struct vb2_queue *q,
+	unsigned int *num_buffers, unsigned int *num_planes,
+	unsigned int sizes[], struct device *alloc_devs[])
+{
+	struct camss_video *video = vb2_get_drv_priv(q);
+	const struct v4l2_pix_format_mplane *format =
+						&video->active_fmt.fmt.pix_mp;
+	unsigned int i;
+
+	if (*num_planes) {
+		if (*num_planes != format->num_planes)
+			return -EINVAL;
+
+		for (i = 0; i < *num_planes; i++)
+			if (sizes[i] < format->plane_fmt[i].sizeimage)
+				return -EINVAL;
+
+		return 0;
+	}
+
+	*num_planes = format->num_planes;
+
+	for (i = 0; i < *num_planes; i++)
+		sizes[i] = format->plane_fmt[i].sizeimage;
+
+	return 0;
+}
+
+static int video_buf_init(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct camss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	struct camss_buffer *buffer = container_of(vbuf, struct camss_buffer,
+						   vb);
+	const struct v4l2_pix_format_mplane *format =
+						&video->active_fmt.fmt.pix_mp;
+	struct sg_table *sgt;
+	unsigned int i;
+
+	for (i = 0; i < format->num_planes; i++) {
+		sgt = vb2_dma_sg_plane_desc(vb, i);
+		if (!sgt)
+			return -EFAULT;
+
+		buffer->addr[i] = sg_dma_address(sgt->sgl);
+	}
+
+	if (format->pixelformat == V4L2_PIX_FMT_NV12 ||
+			format->pixelformat == V4L2_PIX_FMT_NV21 ||
+			format->pixelformat == V4L2_PIX_FMT_NV16 ||
+			format->pixelformat == V4L2_PIX_FMT_NV61)
+		buffer->addr[1] = buffer->addr[0] +
+				format->plane_fmt[0].bytesperline *
+				format->height;
+
+	return 0;
+}
+
+static int video_buf_prepare(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct camss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	const struct v4l2_pix_format_mplane *format =
+						&video->active_fmt.fmt.pix_mp;
+	unsigned int i;
+
+	for (i = 0; i < format->num_planes; i++) {
+		if (format->plane_fmt[i].sizeimage > vb2_plane_size(vb, i))
+			return -EINVAL;
+
+		vb2_set_plane_payload(vb, i, format->plane_fmt[i].sizeimage);
+	}
+
+	vbuf->field = V4L2_FIELD_NONE;
+
+	return 0;
+}
+
+static void video_buf_queue(struct vb2_buffer *vb)
+{
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct camss_video *video = vb2_get_drv_priv(vb->vb2_queue);
+	struct camss_buffer *buffer = container_of(vbuf, struct camss_buffer,
+						   vb);
+
+	video->ops->queue_buffer(video, buffer);
+}
+
+static int video_check_format(struct camss_video *video)
+{
+	struct v4l2_pix_format_mplane *pix = &video->active_fmt.fmt.pix_mp;
+	struct v4l2_format format;
+	struct v4l2_pix_format_mplane *sd_pix = &format.fmt.pix_mp;
+	int ret;
+
+	sd_pix->pixelformat = pix->pixelformat;
+	ret = video_get_subdev_format(video, &format);
+	if (ret < 0)
+		return ret;
+
+	if (pix->pixelformat != sd_pix->pixelformat ||
+	    pix->height != sd_pix->height ||
+	    pix->width != sd_pix->width ||
+	    pix->num_planes != sd_pix->num_planes ||
+	    pix->field != format.fmt.pix_mp.field)
+		return -EPIPE;
+
+	return 0;
+}
+
+static int video_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct camss_video *video = vb2_get_drv_priv(q);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+	int ret;
+
+	ret = media_pipeline_start(&vdev->entity, &video->pipe);
+	if (ret < 0)
+		return ret;
+
+	ret = video_check_format(video);
+	if (ret < 0)
+		goto error;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_entity_remote_pad(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		ret = v4l2_subdev_call(subdev, video, s_stream, 1);
+		if (ret < 0 && ret != -ENOIOCTLCMD)
+			goto error;
+	}
+
+	return 0;
+
+error:
+	media_pipeline_stop(&vdev->entity);
+
+	video->ops->flush_buffers(video, VB2_BUF_STATE_QUEUED);
+
+	return ret;
+}
+
+static void video_stop_streaming(struct vb2_queue *q)
+{
+	struct camss_video *video = vb2_get_drv_priv(q);
+	struct video_device *vdev = &video->vdev;
+	struct media_entity *entity;
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+
+	entity = &vdev->entity;
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			break;
+
+		pad = media_entity_remote_pad(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			break;
+
+		entity = pad->entity;
+		subdev = media_entity_to_v4l2_subdev(entity);
+
+		v4l2_subdev_call(subdev, video, s_stream, 0);
+	}
+
+	media_pipeline_stop(&vdev->entity);
+
+	video->ops->flush_buffers(video, VB2_BUF_STATE_ERROR);
+}
+
+static const struct vb2_ops msm_video_vb2_q_ops = {
+	.queue_setup     = video_queue_setup,
+	.wait_prepare    = vb2_ops_wait_prepare,
+	.wait_finish     = vb2_ops_wait_finish,
+	.buf_init        = video_buf_init,
+	.buf_prepare     = video_buf_prepare,
+	.buf_queue       = video_buf_queue,
+	.start_streaming = video_start_streaming,
+	.stop_streaming  = video_stop_streaming,
+};
+
+/* -----------------------------------------------------------------------------
+ * V4L2 ioctls
+ */
+
+static int video_querycap(struct file *file, void *fh,
+			  struct v4l2_capability *cap)
+{
+	struct camss_video *video = video_drvdata(file);
+
+	strlcpy(cap->driver, "qcom-camss", sizeof(cap->driver));
+	strlcpy(cap->card, "Qualcomm Camera Subsystem", sizeof(cap->card));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
+		 dev_name(video->camss->dev));
+
+	return 0;
+}
+
+static int video_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
+{
+	struct camss_video *video = video_drvdata(file);
+	int i, j, k;
+
+	if (f->type != video->type)
+		return -EINVAL;
+
+	if (f->index >= video->nformats)
+		return -EINVAL;
+
+	/* find index "i" of "k"th unique pixelformat in formats array */
+	k = -1;
+	for (i = 0; i < video->nformats; i++) {
+		for (j = 0; j < i; j++) {
+			if (video->formats[i].pixelformat ==
+					video->formats[j].pixelformat)
+				break;
+		}
+
+		if (j == i)
+			k++;
+
+		if (k == f->index)
+			break;
+	}
+
+	if (k < f->index)
+		return -EINVAL;
+
+	f->pixelformat = video->formats[i].pixelformat;
+
+	return 0;
+}
+
+static int video_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct camss_video *video = video_drvdata(file);
+
+	*f = video->active_fmt;
+
+	return 0;
+}
+
+static int __video_try_fmt(struct camss_video *video, struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pix_mp;
+	const struct camss_format_info *fi;
+	struct v4l2_plane_pix_format *p;
+	u32 bytesperline[3] = { 0 };
+	u32 sizeimage[3] = { 0 };
+	u32 width, height;
+	u32 bpl, lines;
+	int i, j;
+
+	pix_mp = &f->fmt.pix_mp;
+
+	if (video->line_based)
+		for (i = 0; i < pix_mp->num_planes && i < 3; i++) {
+			p = &pix_mp->plane_fmt[i];
+			bytesperline[i] = clamp_t(u32, p->bytesperline,
+						  1, 65528);
+			sizeimage[i] = clamp_t(u32, p->sizeimage,
+					       bytesperline[i],
+					       bytesperline[i] * 4096);
+		}
+
+	for (j = 0; j < video->nformats; j++)
+		if (pix_mp->pixelformat == video->formats[j].pixelformat)
+			break;
+
+	if (j == video->nformats)
+		j = 0; /* default format */
+
+	fi = &video->formats[j];
+	width = pix_mp->width;
+	height = pix_mp->height;
+
+	memset(pix_mp, 0, sizeof(*pix_mp));
+
+	pix_mp->pixelformat = fi->pixelformat;
+	pix_mp->width = clamp_t(u32, width, 1, 8191);
+	pix_mp->height = clamp_t(u32, height, 1, 8191);
+	pix_mp->num_planes = fi->planes;
+	for (i = 0; i < pix_mp->num_planes; i++) {
+		bpl = pix_mp->width / fi->hsub[i].numerator *
+			fi->hsub[i].denominator * fi->bpp[i] / 8;
+		bpl = ALIGN(bpl, video->bpl_alignment);
+		pix_mp->plane_fmt[i].bytesperline = bpl;
+		pix_mp->plane_fmt[i].sizeimage = pix_mp->height /
+			fi->vsub[i].numerator * fi->vsub[i].denominator * bpl;
+	}
+
+	pix_mp->field = V4L2_FIELD_NONE;
+	pix_mp->colorspace = V4L2_COLORSPACE_SRGB;
+	pix_mp->flags = 0;
+	pix_mp->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(pix_mp->colorspace);
+	pix_mp->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
+					pix_mp->colorspace, pix_mp->ycbcr_enc);
+	pix_mp->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(pix_mp->colorspace);
+
+	if (video->line_based)
+		for (i = 0; i < pix_mp->num_planes; i++) {
+			p = &pix_mp->plane_fmt[i];
+			p->bytesperline = clamp_t(u32, p->bytesperline,
+						  1, 65528);
+			p->sizeimage = clamp_t(u32, p->sizeimage,
+					       p->bytesperline,
+					       p->bytesperline * 4096);
+			lines = p->sizeimage / p->bytesperline;
+
+			if (p->bytesperline < bytesperline[i])
+				p->bytesperline = ALIGN(bytesperline[i], 8);
+
+			if (p->sizeimage < p->bytesperline * lines)
+				p->sizeimage = p->bytesperline * lines;
+
+			if (p->sizeimage < sizeimage[i])
+				p->sizeimage = sizeimage[i];
+		}
+
+	return 0;
+}
+
+static int video_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct camss_video *video = video_drvdata(file);
+
+	return __video_try_fmt(video, f);
+}
+
+static int video_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
+{
+	struct camss_video *video = video_drvdata(file);
+	int ret;
+
+	if (vb2_is_busy(&video->vb2_q))
+		return -EBUSY;
+
+	ret = __video_try_fmt(video, f);
+	if (ret < 0)
+		return ret;
+
+	video->active_fmt = *f;
+
+	return 0;
+}
+
+static int video_enum_input(struct file *file, void *fh,
+			    struct v4l2_input *input)
+{
+	if (input->index > 0)
+		return -EINVAL;
+
+	strlcpy(input->name, "camera", sizeof(input->name));
+	input->type = V4L2_INPUT_TYPE_CAMERA;
+
+	return 0;
+}
+
+static int video_g_input(struct file *file, void *fh, unsigned int *input)
+{
+	*input = 0;
+
+	return 0;
+}
+
+static int video_s_input(struct file *file, void *fh, unsigned int input)
+{
+	return input == 0 ? 0 : -EINVAL;
+}
+
+static const struct v4l2_ioctl_ops msm_vid_ioctl_ops = {
+	.vidioc_querycap		= video_querycap,
+	.vidioc_enum_fmt_vid_cap_mplane	= video_enum_fmt,
+	.vidioc_g_fmt_vid_cap_mplane	= video_g_fmt,
+	.vidioc_s_fmt_vid_cap_mplane	= video_s_fmt,
+	.vidioc_try_fmt_vid_cap_mplane	= video_try_fmt,
+	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
+	.vidioc_querybuf		= vb2_ioctl_querybuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
+	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
+	.vidioc_streamon		= vb2_ioctl_streamon,
+	.vidioc_streamoff		= vb2_ioctl_streamoff,
+	.vidioc_enum_input		= video_enum_input,
+	.vidioc_g_input			= video_g_input,
+	.vidioc_s_input			= video_s_input,
+};
+
+/* -----------------------------------------------------------------------------
+ * V4L2 file operations
+ */
+
+static int video_open(struct file *file)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct camss_video *video = video_drvdata(file);
+	struct v4l2_fh *vfh;
+	int ret;
+
+	mutex_lock(&video->lock);
+
+	vfh = kzalloc(sizeof(*vfh), GFP_KERNEL);
+	if (vfh == NULL) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
+
+	v4l2_fh_init(vfh, vdev);
+	v4l2_fh_add(vfh);
+
+	file->private_data = vfh;
+
+	ret = v4l2_pipeline_pm_use(&vdev->entity, 1);
+	if (ret < 0) {
+		dev_err(video->camss->dev, "Failed to power up pipeline: %d\n",
+			ret);
+		goto error_pm_use;
+	}
+
+	mutex_unlock(&video->lock);
+
+	return 0;
+
+error_pm_use:
+	v4l2_fh_release(file);
+
+error_alloc:
+	mutex_unlock(&video->lock);
+
+	return ret;
+}
+
+static int video_release(struct file *file)
+{
+	struct video_device *vdev = video_devdata(file);
+
+	vb2_fop_release(file);
+
+	v4l2_pipeline_pm_use(&vdev->entity, 0);
+
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static const struct v4l2_file_operations msm_vid_fops = {
+	.owner          = THIS_MODULE,
+	.unlocked_ioctl = video_ioctl2,
+	.open           = video_open,
+	.release        = video_release,
+	.poll           = vb2_fop_poll,
+	.mmap		= vb2_fop_mmap,
+	.read		= vb2_fop_read,
+};
+
+/* -----------------------------------------------------------------------------
+ * CAMSS video core
+ */
+
+static void msm_video_release(struct video_device *vdev)
+{
+	struct camss_video *video = video_get_drvdata(vdev);
+
+	media_entity_cleanup(&vdev->entity);
+
+	mutex_destroy(&video->q_lock);
+	mutex_destroy(&video->lock);
+
+	if (atomic_dec_and_test(&video->camss->ref_count))
+		camss_delete(video->camss);
+}
+
+/*
+ * msm_video_init_format - Helper function to initialize format
+ * @video: struct camss_video
+ *
+ * Initialize pad format with default value.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int msm_video_init_format(struct camss_video *video)
+{
+	int ret;
+	struct v4l2_format format = {
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+		.fmt.pix_mp = {
+			.width = 1920,
+			.height = 1080,
+			.pixelformat = video->formats[0].pixelformat,
+		},
+	};
+
+	ret = __video_try_fmt(video, &format);
+	if (ret < 0)
+		return ret;
+
+	video->active_fmt = format;
+
+	return 0;
+}
+
+/*
+ * msm_video_register - Register a video device node
+ * @video: struct camss_video
+ * @v4l2_dev: V4L2 device
+ * @name: name to be used for the video device node
+ *
+ * Initialize and register a video device node to a V4L2 device. Also
+ * initialize the vb2 queue.
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+
+int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
+		       const char *name, int is_pix)
+{
+	struct media_pad *pad = &video->pad;
+	struct video_device *vdev;
+	struct vb2_queue *q;
+	int ret;
+
+	vdev = &video->vdev;
+
+	mutex_init(&video->q_lock);
+
+	q = &video->vb2_q;
+	q->drv_priv = video;
+	q->mem_ops = &vb2_dma_sg_memops;
+	q->ops = &msm_video_vb2_q_ops;
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	q->io_modes = VB2_DMABUF | VB2_MMAP | VB2_READ;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->buf_struct_size = sizeof(struct camss_buffer);
+	q->dev = video->camss->dev;
+	q->lock = &video->q_lock;
+	ret = vb2_queue_init(q);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to init vb2 queue: %d\n", ret);
+		goto error_vb2_init;
+	}
+
+	pad->flags = MEDIA_PAD_FL_SINK;
+	ret = media_entity_pads_init(&vdev->entity, 1, pad);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to init video entity: %d\n",
+			ret);
+		goto error_media_init;
+	}
+
+	mutex_init(&video->lock);
+
+	video->formats = formats_rdi;
+	video->nformats = ARRAY_SIZE(formats_rdi);
+	if (is_pix) {
+		video->formats = formats_pix;
+		video->nformats = ARRAY_SIZE(formats_pix);
+	}
+
+	ret = msm_video_init_format(video);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to init format: %d\n", ret);
+		goto error_video_register;
+	}
+
+	vdev->fops = &msm_vid_fops;
+	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING |
+							V4L2_CAP_READWRITE;
+	vdev->ioctl_ops = &msm_vid_ioctl_ops;
+	vdev->release = msm_video_release;
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->vfl_dir = VFL_DIR_RX;
+	vdev->queue = &video->vb2_q;
+	vdev->lock = &video->lock;
+	strlcpy(vdev->name, name, sizeof(vdev->name));
+
+	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	if (ret < 0) {
+		dev_err(v4l2_dev->dev, "Failed to register video device: %d\n",
+			ret);
+		goto error_video_register;
+	}
+
+	video_set_drvdata(vdev, video);
+	atomic_inc(&video->camss->ref_count);
+
+	return 0;
+
+error_video_register:
+	media_entity_cleanup(&vdev->entity);
+	mutex_destroy(&video->lock);
+error_media_init:
+	vb2_queue_release(&video->vb2_q);
+error_vb2_init:
+	mutex_destroy(&video->q_lock);
+
+	return ret;
+}
+
+void msm_video_stop_streaming(struct camss_video *video)
+{
+	if (vb2_is_streaming(&video->vb2_q))
+		vb2_queue_release(&video->vb2_q);
+}
+
+void msm_video_unregister(struct camss_video *video)
+{
+	atomic_inc(&video->camss->ref_count);
+	video_unregister_device(&video->vdev);
+	atomic_dec(&video->camss->ref_count);
+}
diff --git a/drivers/media/platform/qcom/camss/camss-video.h b/drivers/media/platform/qcom/camss/camss-video.h
new file mode 100644
index 0000000..821c1ef
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-video.h
@@ -0,0 +1,70 @@
+/*
+ * camss-video.h
+ *
+ * Qualcomm MSM Camera Subsystem - V4L2 device node
+ *
+ * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef QC_MSM_CAMSS_VIDEO_H
+#define QC_MSM_CAMSS_VIDEO_H
+
+#include <linux/mutex.h>
+#include <linux/videodev2.h>
+#include <media/media-entity.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-mediabus.h>
+#include <media/videobuf2-v4l2.h>
+
+struct camss_buffer {
+	struct vb2_v4l2_buffer vb;
+	dma_addr_t addr[3];
+	struct list_head queue;
+};
+
+struct camss_video;
+
+struct camss_video_ops {
+	int (*queue_buffer)(struct camss_video *vid, struct camss_buffer *buf);
+	int (*flush_buffers)(struct camss_video *vid,
+			     enum vb2_buffer_state state);
+};
+
+struct camss_format_info;
+
+struct camss_video {
+	struct camss *camss;
+	struct vb2_queue vb2_q;
+	struct video_device vdev;
+	struct media_pad pad;
+	struct v4l2_format active_fmt;
+	enum v4l2_buf_type type;
+	struct media_pipeline pipe;
+	const struct camss_video_ops *ops;
+	struct mutex lock;
+	struct mutex q_lock;
+	unsigned int bpl_alignment;
+	unsigned int line_based;
+	const struct camss_format_info *formats;
+	unsigned int nformats;
+};
+
+void msm_video_stop_streaming(struct camss_video *video);
+
+int msm_video_register(struct camss_video *video, struct v4l2_device *v4l2_dev,
+		       const char *name, int is_pix);
+
+void msm_video_unregister(struct camss_video *video);
+
+#endif /* QC_MSM_CAMSS_VIDEO_H */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
new file mode 100644
index 0000000..d1d27fc
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -0,0 +1,751 @@
+/*
+ * camss.c
+ *
+ * Qualcomm MSM Camera Subsystem - Core
+ *
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/clk.h>
+#include <linux/media-bus-format.h>
+#include <linux/media.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/slab.h>
+#include <linux/videodev2.h>
+
+#include <media/media-device.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mc.h>
+#include <media/v4l2-fwnode.h>
+
+#include "camss.h"
+
+#define CAMSS_CLOCK_MARGIN_NUMERATOR 105
+#define CAMSS_CLOCK_MARGIN_DENOMINATOR 100
+
+static const struct resources csiphy_res[] = {
+	/* CSIPHY0 */
+	{
+		.regulator = { NULL },
+		.clock = { "camss_top_ahb", "ispif_ahb",
+			   "camss_ahb", "csiphy0_timer" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 100000000, 200000000 } },
+		.reg = { "csiphy0", "csiphy0_clk_mux" },
+		.interrupt = { "csiphy0" }
+	},
+
+	/* CSIPHY1 */
+	{
+		.regulator = { NULL },
+		.clock = { "camss_top_ahb", "ispif_ahb",
+			   "camss_ahb", "csiphy1_timer" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 100000000, 200000000 } },
+		.reg = { "csiphy1", "csiphy1_clk_mux" },
+		.interrupt = { "csiphy1" }
+	}
+};
+
+static const struct resources csid_res[] = {
+	/* CSID0 */
+	{
+		.regulator = { "vdda" },
+		.clock = { "camss_top_ahb", "ispif_ahb",
+			   "csi0_ahb", "camss_ahb",
+			   "csi0", "csi0_phy", "csi0_pix", "csi0_rdi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 100000000, 200000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid0" },
+		.interrupt = { "csid0" }
+	},
+
+	/* CSID1 */
+	{
+		.regulator = { "vdda" },
+		.clock = { "camss_top_ahb", "ispif_ahb",
+			   "csi1_ahb", "camss_ahb",
+			   "csi1", "csi1_phy", "csi1_pix", "csi1_rdi" },
+		.clock_rate = { { 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 100000000, 200000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "csid1" },
+		.interrupt = { "csid1" }
+	},
+};
+
+static const struct resources_ispif ispif_res = {
+	/* ISPIF */
+	.clock = { "camss_top_ahb", "camss_ahb", "ispif_ahb",
+		   "csi0", "csi0_pix", "csi0_rdi",
+		   "csi1", "csi1_pix", "csi1_rdi" },
+	.clock_for_reset = { "camss_vfe_vfe", "camss_csi_vfe" },
+	.reg = { "ispif", "csi_clk_mux" },
+	.interrupt = "ispif"
+
+};
+
+static const struct resources vfe_res = {
+	/* VFE0 */
+	.regulator = { NULL },
+	.clock = { "camss_top_ahb", "camss_vfe_vfe", "camss_csi_vfe",
+		   "iface", "bus", "camss_ahb" },
+	.clock_rate = { { 0 },
+			{ 50000000, 80000000, 100000000, 160000000,
+			  177780000, 200000000, 266670000, 320000000,
+			  400000000, 465000000 },
+			{ 0 },
+			{ 0 },
+			{ 0 },
+			{ 0 },
+			{ 0 },
+			{ 0 },
+			{ 0 } },
+	.reg = { "vfe0" },
+	.interrupt = { "vfe0" }
+};
+
+/*
+ * camss_add_clock_margin - Add margin to clock frequency rate
+ * @rate: Clock frequency rate
+ *
+ * When making calculations with physical clock frequency values
+ * some safety margin must be added. Add it.
+ */
+inline void camss_add_clock_margin(u64 *rate)
+{
+	*rate *= CAMSS_CLOCK_MARGIN_NUMERATOR;
+	*rate = div_u64(*rate, CAMSS_CLOCK_MARGIN_DENOMINATOR);
+}
+
+/*
+ * camss_enable_clocks - Enable multiple clocks
+ * @nclocks: Number of clocks in clock array
+ * @clock: Clock array
+ * @dev: Device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int camss_enable_clocks(int nclocks, struct camss_clock *clock,
+			struct device *dev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < nclocks; i++) {
+		ret = clk_prepare_enable(clock[i].clk);
+		if (ret) {
+			dev_err(dev, "clock enable failed: %d\n", ret);
+			goto error;
+		}
+	}
+
+	return 0;
+
+error:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(clock[i].clk);
+
+	return ret;
+}
+
+/*
+ * camss_disable_clocks - Disable multiple clocks
+ * @nclocks: Number of clocks in clock array
+ * @clock: Clock array
+ */
+void camss_disable_clocks(int nclocks, struct camss_clock *clock)
+{
+	int i;
+
+	for (i = nclocks - 1; i >= 0; i--)
+		clk_disable_unprepare(clock[i].clk);
+}
+
+/*
+ * camss_find_sensor - Find a linked media entity which represents a sensor
+ * @entity: Media entity to start searching from
+ *
+ * Return a pointer to sensor media entity or NULL if not found
+ */
+static struct media_entity *camss_find_sensor(struct media_entity *entity)
+{
+	struct media_pad *pad;
+
+	while (1) {
+		pad = &entity->pads[0];
+		if (!(pad->flags & MEDIA_PAD_FL_SINK))
+			return NULL;
+
+		pad = media_entity_remote_pad(pad);
+		if (!pad || !is_media_entity_v4l2_subdev(pad->entity))
+			return NULL;
+
+		entity = pad->entity;
+
+		if (entity->function == MEDIA_ENT_F_CAM_SENSOR)
+			return entity;
+	}
+}
+
+/*
+ * camss_get_pixel_clock - Get pixel clock rate from sensor
+ * @entity: Media entity in the current pipeline
+ * @pixel_clock: Received pixel clock value
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+int camss_get_pixel_clock(struct media_entity *entity, u32 *pixel_clock)
+{
+	struct media_entity *sensor;
+	struct v4l2_subdev *subdev;
+	struct v4l2_ctrl *ctrl;
+
+	sensor = camss_find_sensor(entity);
+	if (!sensor)
+		return -ENODEV;
+
+	subdev = media_entity_to_v4l2_subdev(sensor);
+
+	ctrl = v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
+
+	if (!ctrl)
+		return -EINVAL;
+
+	*pixel_clock = v4l2_ctrl_g_ctrl_int64(ctrl);
+
+	return 0;
+}
+
+/*
+ * camss_of_parse_endpoint_node - Parse port endpoint node
+ * @dev: Device
+ * @node: Device node to be parsed
+ * @csd: Parsed data from port endpoint node
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int camss_of_parse_endpoint_node(struct device *dev,
+					struct device_node *node,
+					struct camss_async_subdev *csd)
+{
+	struct csiphy_lanes_cfg *lncfg = &csd->interface.csi2.lane_cfg;
+	struct v4l2_fwnode_bus_mipi_csi2 *mipi_csi2;
+	struct v4l2_fwnode_endpoint vep = { { 0 } };
+	unsigned int i;
+
+	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+
+	csd->interface.csiphy_id = vep.base.port;
+
+	mipi_csi2 = &vep.bus.mipi_csi2;
+	lncfg->clk.pos = mipi_csi2->clock_lane;
+	lncfg->clk.pol = mipi_csi2->lane_polarities[0];
+	lncfg->num_data = mipi_csi2->num_data_lanes;
+
+	lncfg->data = devm_kcalloc(dev,
+				   lncfg->num_data, sizeof(*lncfg->data),
+				   GFP_KERNEL);
+	if (!lncfg->data)
+		return -ENOMEM;
+
+	for (i = 0; i < lncfg->num_data; i++) {
+		lncfg->data[i].pos = mipi_csi2->data_lanes[i];
+		lncfg->data[i].pol = mipi_csi2->lane_polarities[i + 1];
+	}
+
+	return 0;
+}
+
+/*
+ * camss_of_parse_ports - Parse ports node
+ * @dev: Device
+ * @notifier: v4l2_device notifier data
+ *
+ * Return number of "port" nodes found in "ports" node
+ */
+static int camss_of_parse_ports(struct device *dev,
+				struct v4l2_async_notifier *notifier)
+{
+	struct device_node *node = NULL;
+	struct device_node *remote = NULL;
+	unsigned int size, i;
+	int ret;
+
+	while ((node = of_graph_get_next_endpoint(dev->of_node, node)))
+		if (of_device_is_available(node))
+			notifier->num_subdevs++;
+
+	size = sizeof(*notifier->subdevs) * notifier->num_subdevs;
+	notifier->subdevs = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!notifier->subdevs) {
+		dev_err(dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	i = 0;
+	while ((node = of_graph_get_next_endpoint(dev->of_node, node))) {
+		struct camss_async_subdev *csd;
+
+		if (!of_device_is_available(node))
+			continue;
+
+		csd = devm_kzalloc(dev, sizeof(*csd), GFP_KERNEL);
+		if (!csd) {
+			of_node_put(node);
+			dev_err(dev, "Failed to allocate memory\n");
+			return -ENOMEM;
+		}
+
+		notifier->subdevs[i++] = &csd->asd;
+
+		ret = camss_of_parse_endpoint_node(dev, node, csd);
+		if (ret < 0) {
+			of_node_put(node);
+			return ret;
+		}
+
+		remote = of_graph_get_remote_port_parent(node);
+		of_node_put(node);
+
+		if (!remote) {
+			dev_err(dev, "Cannot get remote parent\n");
+			return -EINVAL;
+		}
+
+		csd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
+		csd->asd.match.fwnode = of_fwnode_handle(remote);
+	}
+
+	return notifier->num_subdevs;
+}
+
+/*
+ * camss_init_subdevices - Initialize subdev structures and resources
+ * @camss: CAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int camss_init_subdevices(struct camss *camss)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++) {
+		ret = msm_csiphy_subdev_init(&camss->csiphy[i],
+					     &csiphy_res[i], i);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to init csiphy%d sub-device: %d\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(camss->csid); i++) {
+		ret = msm_csid_subdev_init(&camss->csid[i],
+					   &csid_res[i], i);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to init csid%d sub-device: %d\n",
+				i, ret);
+			return ret;
+		}
+	}
+
+	ret = msm_ispif_subdev_init(&camss->ispif, &ispif_res);
+	if (ret < 0) {
+		dev_err(camss->dev, "Failed to init ispif sub-device: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = msm_vfe_subdev_init(&camss->vfe, &vfe_res);
+	if (ret < 0) {
+		dev_err(camss->dev, "Fail to init vfe sub-device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * camss_register_entities - Register subdev nodes and create links
+ * @camss: CAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int camss_register_entities(struct camss *camss)
+{
+	int i, j;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++) {
+		ret = msm_csiphy_register_entity(&camss->csiphy[i],
+						 &camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register csiphy%d entity: %d\n",
+				i, ret);
+			goto err_reg_csiphy;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(camss->csid); i++) {
+		ret = msm_csid_register_entity(&camss->csid[i],
+					       &camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(camss->dev,
+				"Failed to register csid%d entity: %d\n",
+				i, ret);
+			goto err_reg_csid;
+		}
+	}
+
+	ret = msm_ispif_register_entities(&camss->ispif, &camss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(camss->dev, "Failed to register ispif entities: %d\n",
+			ret);
+		goto err_reg_ispif;
+	}
+
+	ret = msm_vfe_register_entities(&camss->vfe, &camss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(camss->dev, "Failed to register vfe entities: %d\n",
+			ret);
+		goto err_reg_vfe;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++) {
+		for (j = 0; j < ARRAY_SIZE(camss->csid); j++) {
+			ret = media_create_pad_link(
+				&camss->csiphy[i].subdev.entity,
+				MSM_CSIPHY_PAD_SRC,
+				&camss->csid[j].subdev.entity,
+				MSM_CSID_PAD_SINK,
+				0);
+			if (ret < 0) {
+				dev_err(camss->dev,
+					"Failed to link %s->%s entities: %d\n",
+					camss->csiphy[i].subdev.entity.name,
+					camss->csid[j].subdev.entity.name,
+					ret);
+				goto err_link;
+			}
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(camss->csid); i++) {
+		for (j = 0; j < ARRAY_SIZE(camss->ispif.line); j++) {
+			ret = media_create_pad_link(
+				&camss->csid[i].subdev.entity,
+				MSM_CSID_PAD_SRC,
+				&camss->ispif.line[j].subdev.entity,
+				MSM_ISPIF_PAD_SINK,
+				0);
+			if (ret < 0) {
+				dev_err(camss->dev,
+					"Failed to link %s->%s entities: %d\n",
+					camss->csid[i].subdev.entity.name,
+					camss->ispif.line[j].subdev.entity.name,
+					ret);
+				goto err_link;
+			}
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(camss->ispif.line); i++) {
+		for (j = 0; j < ARRAY_SIZE(camss->vfe.line); j++) {
+			ret = media_create_pad_link(
+				&camss->ispif.line[i].subdev.entity,
+				MSM_ISPIF_PAD_SRC,
+				&camss->vfe.line[j].subdev.entity,
+				MSM_VFE_PAD_SINK,
+				0);
+			if (ret < 0) {
+				dev_err(camss->dev,
+					"Failed to link %s->%s entities: %d\n",
+					camss->ispif.line[i].subdev.entity.name,
+					camss->vfe.line[j].subdev.entity.name,
+					ret);
+				goto err_link;
+			}
+		}
+	}
+
+	return 0;
+
+err_link:
+	msm_vfe_unregister_entities(&camss->vfe);
+err_reg_vfe:
+	msm_ispif_unregister_entities(&camss->ispif);
+err_reg_ispif:
+
+	i = ARRAY_SIZE(camss->csid);
+err_reg_csid:
+	for (i--; i >= 0; i--)
+		msm_csid_unregister_entity(&camss->csid[i]);
+
+	i = ARRAY_SIZE(camss->csiphy);
+err_reg_csiphy:
+	for (i--; i >= 0; i--)
+		msm_csiphy_unregister_entity(&camss->csiphy[i]);
+
+	return ret;
+}
+
+/*
+ * camss_unregister_entities - Unregister subdev nodes
+ * @camss: CAMSS device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static void camss_unregister_entities(struct camss *camss)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(camss->csiphy); i++)
+		msm_csiphy_unregister_entity(&camss->csiphy[i]);
+
+	for (i = 0; i < ARRAY_SIZE(camss->csid); i++)
+		msm_csid_unregister_entity(&camss->csid[i]);
+
+	msm_ispif_unregister_entities(&camss->ispif);
+	msm_vfe_unregister_entities(&camss->vfe);
+}
+
+static int camss_subdev_notifier_bound(struct v4l2_async_notifier *async,
+				       struct v4l2_subdev *subdev,
+				       struct v4l2_async_subdev *asd)
+{
+	struct camss *camss = container_of(async, struct camss, notifier);
+	struct camss_async_subdev *csd =
+		container_of(asd, struct camss_async_subdev, asd);
+	u8 id = csd->interface.csiphy_id;
+	struct csiphy_device *csiphy = &camss->csiphy[id];
+
+	csiphy->cfg.csi2 = &csd->interface.csi2;
+	subdev->host_priv = csiphy;
+
+	return 0;
+}
+
+static int camss_subdev_notifier_complete(struct v4l2_async_notifier *async)
+{
+	struct camss *camss = container_of(async, struct camss, notifier);
+	struct v4l2_device *v4l2_dev = &camss->v4l2_dev;
+	struct v4l2_subdev *sd;
+	int ret;
+
+	list_for_each_entry(sd, &v4l2_dev->subdevs, list) {
+		if (sd->host_priv) {
+			struct media_entity *sensor = &sd->entity;
+			struct csiphy_device *csiphy =
+					(struct csiphy_device *) sd->host_priv;
+			struct media_entity *input = &csiphy->subdev.entity;
+			unsigned int i;
+
+			for (i = 0; i < sensor->num_pads; i++) {
+				if (sensor->pads[i].flags & MEDIA_PAD_FL_SOURCE)
+					break;
+			}
+			if (i == sensor->num_pads) {
+				dev_err(camss->dev,
+					"No source pad in external entity\n");
+				return -EINVAL;
+			}
+
+			ret = media_create_pad_link(sensor, i,
+				input, MSM_CSIPHY_PAD_SINK,
+				MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+			if (ret < 0) {
+				dev_err(camss->dev,
+					"Failed to link %s->%s entities: %d\n",
+					sensor->name, input->name, ret);
+				return ret;
+			}
+		}
+	}
+
+	ret = v4l2_device_register_subdev_nodes(&camss->v4l2_dev);
+	if (ret < 0)
+		return ret;
+
+	return media_device_register(&camss->media_dev);
+}
+
+static const struct v4l2_async_notifier_operations camss_subdev_notifier_ops = {
+	.bound = camss_subdev_notifier_bound,
+	.complete = camss_subdev_notifier_complete,
+};
+
+static const struct media_device_ops camss_media_ops = {
+	.link_notify = v4l2_pipeline_link_notify,
+};
+
+/*
+ * camss_probe - Probe CAMSS platform device
+ * @pdev: Pointer to CAMSS platform device
+ *
+ * Return 0 on success or a negative error code on failure
+ */
+static int camss_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct camss *camss;
+	int ret;
+
+	camss = kzalloc(sizeof(*camss), GFP_KERNEL);
+	if (!camss)
+		return -ENOMEM;
+
+	atomic_set(&camss->ref_count, 0);
+	camss->dev = dev;
+	platform_set_drvdata(pdev, camss);
+
+	ret = camss_of_parse_ports(dev, &camss->notifier);
+	if (ret < 0)
+		return ret;
+
+	ret = camss_init_subdevices(camss);
+	if (ret < 0)
+		return ret;
+
+	ret = dma_set_mask_and_coherent(dev, 0xffffffff);
+	if (ret)
+		return ret;
+
+	camss->media_dev.dev = camss->dev;
+	strlcpy(camss->media_dev.model, "Qualcomm Camera Subsystem",
+		sizeof(camss->media_dev.model));
+	camss->media_dev.ops = &camss_media_ops;
+	media_device_init(&camss->media_dev);
+
+	camss->v4l2_dev.mdev = &camss->media_dev;
+	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
+		return ret;
+	}
+
+	ret = camss_register_entities(camss);
+	if (ret < 0)
+		goto err_register_entities;
+
+	if (camss->notifier.num_subdevs) {
+		camss->notifier.ops = &camss_subdev_notifier_ops;
+
+		ret = v4l2_async_notifier_register(&camss->v4l2_dev,
+						   &camss->notifier);
+		if (ret) {
+			dev_err(dev,
+				"Failed to register async subdev nodes: %d\n",
+				ret);
+			goto err_register_subdevs;
+		}
+	} else {
+		ret = v4l2_device_register_subdev_nodes(&camss->v4l2_dev);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register subdev nodes: %d\n",
+				ret);
+			goto err_register_subdevs;
+		}
+
+		ret = media_device_register(&camss->media_dev);
+		if (ret < 0) {
+			dev_err(dev, "Failed to register media device: %d\n",
+				ret);
+			goto err_register_subdevs;
+		}
+	}
+
+	return 0;
+
+err_register_subdevs:
+	camss_unregister_entities(camss);
+err_register_entities:
+	v4l2_device_unregister(&camss->v4l2_dev);
+
+	return ret;
+}
+
+void camss_delete(struct camss *camss)
+{
+	v4l2_device_unregister(&camss->v4l2_dev);
+	media_device_unregister(&camss->media_dev);
+	media_device_cleanup(&camss->media_dev);
+
+	kfree(camss);
+}
+
+/*
+ * camss_remove - Remove CAMSS platform device
+ * @pdev: Pointer to CAMSS platform device
+ *
+ * Always returns 0.
+ */
+static int camss_remove(struct platform_device *pdev)
+{
+	struct camss *camss = platform_get_drvdata(pdev);
+
+	msm_vfe_stop_streaming(&camss->vfe);
+
+	v4l2_async_notifier_unregister(&camss->notifier);
+	camss_unregister_entities(camss);
+
+	if (atomic_read(&camss->ref_count) == 0)
+		camss_delete(camss);
+
+	return 0;
+}
+
+static const struct of_device_id camss_dt_match[] = {
+	{ .compatible = "qcom,msm8916-camss" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, camss_dt_match);
+
+static struct platform_driver qcom_camss_driver = {
+	.probe = camss_probe,
+	.remove = camss_remove,
+	.driver = {
+		.name = "qcom-camss",
+		.of_match_table = camss_dt_match,
+	},
+};
+
+module_platform_driver(qcom_camss_driver);
+
+MODULE_ALIAS("platform:qcom-camss");
+MODULE_DESCRIPTION("Qualcomm Camera Subsystem driver");
+MODULE_AUTHOR("Todor Tomov <todor.tomov@linaro.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
new file mode 100644
index 0000000..0e7cfe6
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -0,0 +1,106 @@
+/*
+ * camss.h
+ *
+ * Qualcomm MSM Camera Subsystem - Core
+ *
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015-2018 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef QC_MSM_CAMSS_H
+#define QC_MSM_CAMSS_H
+
+#include <linux/types.h>
+#include <media/v4l2-async.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <linux/device.h>
+
+#include "camss-csid.h"
+#include "camss-csiphy.h"
+#include "camss-ispif.h"
+#include "camss-vfe.h"
+
+#define CAMSS_CSID_NUM 2
+#define CAMSS_CSIPHY_NUM 2
+
+#define to_camss(ptr_module)	\
+	container_of(ptr_module, struct camss, ptr_module)
+
+#define to_device(ptr_module)	\
+	(to_camss(ptr_module)->dev)
+
+#define module_pointer(ptr_module, index)	\
+	((const struct ptr_module##_device (*)[]) &(ptr_module[-(index)]))
+
+#define to_camss_index(ptr_module, index)	\
+	container_of(module_pointer(ptr_module, index),	\
+		     struct camss, ptr_module)
+
+#define to_device_index(ptr_module, index)	\
+	(to_camss_index(ptr_module, index)->dev)
+
+#define CAMSS_RES_MAX 15
+
+struct resources {
+	char *regulator[CAMSS_RES_MAX];
+	char *clock[CAMSS_RES_MAX];
+	u32 clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX];
+	char *reg[CAMSS_RES_MAX];
+	char *interrupt[CAMSS_RES_MAX];
+};
+
+struct resources_ispif {
+	char *clock[CAMSS_RES_MAX];
+	char *clock_for_reset[CAMSS_RES_MAX];
+	char *reg[CAMSS_RES_MAX];
+	char *interrupt;
+};
+
+struct camss {
+	struct v4l2_device v4l2_dev;
+	struct v4l2_async_notifier notifier;
+	struct media_device media_dev;
+	struct device *dev;
+	struct csiphy_device csiphy[CAMSS_CSIPHY_NUM];
+	struct csid_device csid[CAMSS_CSID_NUM];
+	struct ispif_device ispif;
+	struct vfe_device vfe;
+	atomic_t ref_count;
+};
+
+struct camss_camera_interface {
+	u8 csiphy_id;
+	struct csiphy_csi2_cfg csi2;
+};
+
+struct camss_async_subdev {
+	struct camss_camera_interface interface;
+	struct v4l2_async_subdev asd;
+};
+
+struct camss_clock {
+	struct clk *clk;
+	const char *name;
+	u32 *freq;
+	u32 nfreqs;
+};
+
+void camss_add_clock_margin(u64 *rate);
+int camss_enable_clocks(int nclocks, struct camss_clock *clock,
+			struct device *dev);
+void camss_disable_clocks(int nclocks, struct camss_clock *clock);
+int camss_get_pixel_clock(struct media_entity *entity, u32 *pixel_clock);
+void camss_delete(struct camss *camss);
+
+#endif /* QC_MSM_CAMSS_H */
-- 
2.7.4

