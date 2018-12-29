Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F000C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF62020873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqfdXjaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeL2Ndw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41029 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeL2Ndn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so12684143edc.8;
        Sat, 29 Dec 2018 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6hlwUzt3iqnLqHxtQFjDhVD9Lmiuk+pC1ktKGz0gdo0=;
        b=bqfdXjaUz2SJp5X5Z8v9NbEkCR9VMJquljD+XYTXGcv1vTAoEdK1xq16izZa1N3pvT
         a52gHDyFjaJeMI6nPIrypMS3RmVJwLTrNV2ppYmzSVc+IUDPV4K4bKGXg802L3Rj9hjQ
         r0zbUYXS5OWKCjQ14P5Yb6LuYzLybHWXCTowIiAzGvIawGO5Bqa7W2AC6uiC0H+iFKVi
         5AHyDMzLCqqhPhGL2WFIJPrpRd8A5YoNMRl6d/S+TQSaV6mStDuGOZk2GfMQhx1N35im
         ZKD63QBfbGUGHbr8LX6uVjSAWO/IKxGyfMCDr/x9m/ljnExVEsvCZ6mCF1cMDMuWE1Q0
         ps5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6hlwUzt3iqnLqHxtQFjDhVD9Lmiuk+pC1ktKGz0gdo0=;
        b=j2eUvR2p4RKobD4mX48fl21pO2X/tgBiBKSPH0dfw1go3fe19vv+FYhCLnWH+rtS9B
         571zitUQmB2CN7NV2AoG9Gv37dMQwH3nfPh40esr6ZMFgvmZDEvTj9NaKSs8QU0mdSvw
         uHTfrJmhz2D62+X17FLI4bDkq9jqLLYlX+gEV2TbHkte3wto6Iy7LK4VAPrsLp/OicMX
         ZzavBB57izD1LpdHT3uTY1o/Lz8MjDnQJ5c8kMjyeU0YILTCimpYJOSAV1h+P6Y8WSUl
         FGbvzQvjHDDdmRK8A4enHHM409PUTK72ogCY1NYCtFjNYi0BTAoNy3hx7jFWG6f2N7I2
         8QMQ==
X-Gm-Message-State: AA+aEWYR2Cv9JbO4aixkDgxxNGdad4O6Yd38qmH0OWVJNc5B2KJW9s/t
        0g7tgDA3x7QGEg7twBoIz64=
X-Google-Smtp-Source: AFSGD/W0hXHRKlY+E88zqPZYg4fpS2+rPmewlW87OBFkonxgiuJhM0ilnb5Bc3xQQltOcfPWfOgBkw==
X-Received: by 2002:a50:9291:: with SMTP id k17mr26014074eda.243.1546090418287;
        Sat, 29 Dec 2018 05:33:38 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:37 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 4/7] drm: rockchip: introduce rk3066 hdmi
Date:   Sat, 29 Dec 2018 14:33:15 +0100
Message-Id: <20181229133318.18128-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yang <zhengyang@rock-chips.com>

Introduce rk3066 hdmi.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/Kconfig            |   8 +
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rk3066_hdmi.c      | 928 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rk3066_hdmi.h      | 235 +++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 6 files changed, 1175 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.c
 create mode 100644 drivers/gpu/drm/rockchip/rk3066_hdmi.h

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 26438d457..db284b6c9 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -77,4 +77,12 @@ config ROCKCHIP_RGB
 	  Some Rockchip CRTCs, like rv1108, can directly output parallel
 	  and serial RGB format to panel or connect to a conversion chip.
 	  say Y to enable its driver.
+
+config ROCKCHIP_RK3066_HDMI
+	bool "Rockchip specific extensions for RK3066 HDMI"
+	depends on DRM_ROCKCHIP
+	help
+	  This selects support for Rockchip SoC specific extensions
+	  for the RK3066 HDMI driver. If you want to enable
+	  HDMI on RK3066 based SoC, you should select this option.
 endif
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index 868263ff0..41b3baee4 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -15,5 +15,6 @@ rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
 rockchipdrm-$(CONFIG_ROCKCHIP_RGB) += rockchip_rgb.o
+rockchipdrm-$(CONFIG_ROCKCHIP_RK3066_HDMI) += rk3066_hdmi.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
new file mode 100644
index 000000000..6e1843b64
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -0,0 +1,928 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ *    Zheng Yang <zhengyang@rock-chips.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/irq.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/hdmi.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_of.h>
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_vop.h"
+
+#include "rk3066_hdmi.h"
+
+#define DEFAULT_PLLA_RATE	30000000
+
+struct hdmi_data_info {
+	int vic;
+	bool sink_is_hdmi;
+	unsigned int enc_in_format;
+	unsigned int enc_out_format;
+	unsigned int colorimetry;
+};
+
+struct rk3066_hdmi_i2c {
+	struct i2c_adapter adap;
+
+	u8 ddc_addr;
+	u8 segment_addr;
+	u8 stat;
+
+	struct mutex lock;	/*for i2c operation*/
+	struct completion cmp;
+};
+
+struct rk3066_hdmi {
+	struct device *dev;
+	struct drm_device *drm_dev;
+	struct regmap *regmap;
+	int irq;
+	struct clk *hclk;
+	void __iomem *regs;
+
+	struct drm_connector	connector;
+	struct drm_encoder	encoder;
+
+	struct rk3066_hdmi_i2c *i2c;
+	struct i2c_adapter *ddc;
+
+	unsigned int tmdsclk;
+
+	struct hdmi_data_info	hdmi_data;
+	struct drm_display_mode previous_mode;
+};
+
+#define to_rk3066_hdmi(x)	container_of(x, struct rk3066_hdmi, x)
+
+static inline u8 hdmi_readb(struct rk3066_hdmi *hdmi, u16 offset)
+{
+	return readl_relaxed(hdmi->regs + offset);
+}
+
+static inline void hdmi_writeb(struct rk3066_hdmi *hdmi, u16 offset, u32 val)
+{
+	writel_relaxed(val, hdmi->regs + offset);
+}
+
+static inline void hdmi_modb(struct rk3066_hdmi *hdmi, u16 offset,
+			     u32 msk, u32 val)
+{
+	u8 temp = hdmi_readb(hdmi, offset) & ~msk;
+
+	temp |= val & msk;
+	hdmi_writeb(hdmi, offset, temp);
+}
+
+static void rk3066_hdmi_i2c_init(struct rk3066_hdmi *hdmi)
+{
+	int ddc_bus_freq;
+
+	ddc_bus_freq = (hdmi->tmdsclk >> 2) / HDMI_SCL_RATE;
+
+	hdmi_writeb(hdmi, HDMI_DDC_BUS_FREQ_L, ddc_bus_freq & 0xFF);
+	hdmi_writeb(hdmi, HDMI_DDC_BUS_FREQ_H, (ddc_bus_freq >> 8) & 0xFF);
+
+	/* Clear the EDID interrupt flag and mute the interrupt */
+	hdmi_modb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_EDID_MASK, 0);
+	hdmi_writeb(hdmi, HDMI_INTR_STATUS1, HDMI_INTR_EDID_MASK);
+}
+
+static inline u8 rk3066_hdmi_get_power_mode(struct rk3066_hdmi *hdmi)
+{
+	return hdmi_readb(hdmi, HDMI_SYS_CTRL) & HDMI_SYS_POWER_MODE_MASK;
+}
+
+static void rk3066_hdmi_set_power_mode(struct rk3066_hdmi *hdmi, int mode)
+{
+	u8 current_mode, next_mode;
+	u8 i = 0;
+
+	current_mode = rk3066_hdmi_get_power_mode(hdmi);
+
+	dev_dbg(hdmi->dev, "mode         :%d\n", mode);
+	dev_dbg(hdmi->dev, "current_mode :%d\n", current_mode);
+
+	if (current_mode == mode)
+		return;
+
+	do {
+		if (current_mode > mode)
+			next_mode = current_mode / 2;
+		else {
+			if (current_mode < HDMI_SYS_POWER_MODE_A)
+				next_mode = HDMI_SYS_POWER_MODE_A;
+			else
+				next_mode = current_mode * 2;
+		}
+
+		dev_dbg(hdmi->dev, "%d: next_mode :%d\n", i, next_mode);
+
+		if (next_mode != HDMI_SYS_POWER_MODE_D) {
+			hdmi_modb(hdmi, HDMI_SYS_CTRL,
+				  HDMI_SYS_POWER_MODE_MASK, next_mode);
+		} else {
+			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
+				    HDMI_SYS_POWER_MODE_D |
+				    HDMI_SYS_PLL_RESET_MASK);
+			usleep_range(90, 100);
+			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
+				    HDMI_SYS_POWER_MODE_D |
+				    HDMI_SYS_PLLB_RESET);
+			usleep_range(90, 100);
+			hdmi_writeb(hdmi, HDMI_SYS_CTRL,
+				    HDMI_SYS_POWER_MODE_D);
+		}
+		current_mode = next_mode;
+		i = i + 1;
+	} while ((next_mode != mode) && (i < 5));
+
+	/*
+	 * When IP controller haven't configured to an accurate video
+	 * timing, DDC_CLK is equal to PLLA freq which is 30MHz,so we
+	 * need to init the TMDS rate to PCLK rate, and reconfigure
+	 * the DDC clock.
+	 */
+	if (mode < HDMI_SYS_POWER_MODE_D)
+		hdmi->tmdsclk = DEFAULT_PLLA_RATE;
+}
+
+static int
+rk3066_hdmi_upload_frame(struct rk3066_hdmi *hdmi, int setup_rc,
+			 union hdmi_infoframe *frame, u32 frame_index,
+			 u32 mask, u32 disable, u32 enable)
+{
+	if (mask)
+		hdmi_modb(hdmi, HDMI_CP_AUTO_SEND_CTRL, mask, disable);
+
+	hdmi_writeb(hdmi, HDMI_CP_BUF_INDEX, frame_index);
+
+	if (setup_rc >= 0) {
+		u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
+		ssize_t rc, i;
+
+		rc = hdmi_infoframe_pack(frame, packed_frame,
+					 sizeof(packed_frame));
+		if (rc < 0)
+			return rc;
+
+		for (i = 0; i < rc; i++)
+			hdmi_writeb(hdmi, HDMI_CP_BUF_ACC_HB0 + i * 4,
+				    packed_frame[i]);
+
+		if (mask)
+			hdmi_modb(hdmi, HDMI_CP_AUTO_SEND_CTRL, mask, enable);
+	}
+
+	return setup_rc;
+}
+
+static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
+				  struct drm_display_mode *mode)
+{
+	union hdmi_infoframe frame;
+	int rc;
+
+	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi, mode, false);
+
+	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
+		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
+	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
+		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
+	else
+		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
+
+	frame.avi.colorimetry = hdmi->hdmi_data.colorimetry;
+	frame.avi.scan_mode = HDMI_SCAN_MODE_NONE;
+
+	return rk3066_hdmi_upload_frame(hdmi, rc, &frame,
+					HDMI_INFOFRAME_AVI, 0, 0, 0);
+}
+
+static int rk3066_hdmi_config_video_timing(struct rk3066_hdmi *hdmi,
+					   struct drm_display_mode *mode)
+{
+	int value, vsync_offset;
+
+	/* Set detail external video timing polarity and interlace mode */
+	value = HDMI_EXT_VIDEO_SET_EN;
+	value |= mode->flags & DRM_MODE_FLAG_PHSYNC ?
+		 HDMI_VIDEO_HSYNC_ACTIVE_HIGH : HDMI_VIDEO_HSYNC_ACTIVE_LOW;
+	value |= mode->flags & DRM_MODE_FLAG_PVSYNC ?
+		 HDMI_VIDEO_VSYNC_ACTIVE_HIGH : HDMI_VIDEO_VSYNC_ACTIVE_LOW;
+	value |= mode->flags & DRM_MODE_FLAG_INTERLACE ?
+		 HDMI_VIDEO_MODE_INTERLACE : HDMI_VIDEO_MODE_PROGRESSIVE;
+	if (hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3)
+		vsync_offset = 6;
+	else
+		vsync_offset = 0;
+	value |= vsync_offset << 4;
+	hdmi_writeb(hdmi, HDMI_EXT_VIDEO_PARA, value);
+
+	/* Set detail external video timing */
+	value = mode->htotal;
+	hdmi_writeb(hdmi, HDMI_EXT_HTOTAL_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HTOTAL_H, (value >> 8) & 0xFF);
+
+	value = mode->htotal - mode->hdisplay;
+	hdmi_writeb(hdmi, HDMI_EXT_HBLANK_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HBLANK_H, (value >> 8) & 0xFF);
+
+	value = mode->htotal - mode->hsync_start;
+	hdmi_writeb(hdmi, HDMI_EXT_HDELAY_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HDELAY_H, (value >> 8) & 0xFF);
+
+	value = mode->hsync_end - mode->hsync_start;
+	hdmi_writeb(hdmi, HDMI_EXT_HDURATION_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_HDURATION_H, (value >> 8) & 0xFF);
+
+	value = mode->vtotal;
+	hdmi_writeb(hdmi, HDMI_EXT_VTOTAL_L, value & 0xFF);
+	hdmi_writeb(hdmi, HDMI_EXT_VTOTAL_H, (value >> 8) & 0xFF);
+
+	value = mode->vtotal - mode->vdisplay;
+	hdmi_writeb(hdmi, HDMI_EXT_VBLANK_L, value & 0xFF);
+
+	value = mode->vtotal - mode->vsync_start + vsync_offset;
+	hdmi_writeb(hdmi, HDMI_EXT_VDELAY, value & 0xFF);
+
+	value = mode->vsync_end - mode->vsync_start;
+	hdmi_writeb(hdmi, HDMI_EXT_VDURATION, value & 0xFF);
+
+	return 0;
+}
+
+static void
+rk3066_hdmi_phy_write(struct rk3066_hdmi *hdmi, u16 offset, u8 value)
+{
+	hdmi_writeb(hdmi, offset, value);
+	hdmi_modb(hdmi, HDMI_SYS_CTRL,
+		  HDMI_SYS_PLL_RESET_MASK, HDMI_SYS_PLL_RESET);
+	usleep_range(90, 100);
+	hdmi_modb(hdmi, HDMI_SYS_CTRL, HDMI_SYS_PLL_RESET_MASK, 0);
+	usleep_range(900, 1000);
+}
+
+static void rk3066_hdmi_config_phy(struct rk3066_hdmi *hdmi)
+{
+	/* tmds frequency same as input dclk */
+	hdmi_writeb(hdmi, HDMI_DEEP_COLOR_MODE, 0x22);
+	if (hdmi->tmdsclk > 100000000) {
+		rk3066_hdmi_phy_write(hdmi, 0x158, 0x0E);
+		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
+		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x168, 0xDA);
+		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA1);
+		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
+		rk3066_hdmi_phy_write(hdmi, 0x174, 0x22);
+		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
+	} else if (hdmi->tmdsclk > 50000000) {
+		rk3066_hdmi_phy_write(hdmi, 0x158, 0x06);
+		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
+		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x168, 0xCA);
+		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA3);
+		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
+		rk3066_hdmi_phy_write(hdmi, 0x174, 0x20);
+		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
+	} else {
+		rk3066_hdmi_phy_write(hdmi, 0x158, 0x02);
+		rk3066_hdmi_phy_write(hdmi, 0x15c, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x160, 0x60);
+		rk3066_hdmi_phy_write(hdmi, 0x164, 0x00);
+		rk3066_hdmi_phy_write(hdmi, 0x168, 0xC2);
+		rk3066_hdmi_phy_write(hdmi, 0x16c, 0xA2);
+		rk3066_hdmi_phy_write(hdmi, 0x170, 0x0e);
+		rk3066_hdmi_phy_write(hdmi, 0x174, 0x20);
+		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
+	}
+}
+
+static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
+			     struct drm_display_mode *mode)
+{
+	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
+
+	hdmi->hdmi_data.enc_in_format = HDMI_COLORSPACE_RGB;
+	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
+
+	if (hdmi->hdmi_data.vic == 6 || hdmi->hdmi_data.vic == 7 ||
+	    hdmi->hdmi_data.vic == 21 || hdmi->hdmi_data.vic == 22 ||
+	    hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3 ||
+	    hdmi->hdmi_data.vic == 17 || hdmi->hdmi_data.vic == 18)
+		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
+	else
+		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
+
+	hdmi->tmdsclk = mode->clock * 1000;
+
+	/* Mute video and audio output */
+	hdmi_modb(hdmi, HDMI_VIDEO_CTRL2, HDMI_VIDEO_AUDIO_DISABLE_MASK,
+		  HDMI_AUDIO_DISABLE | HDMI_VIDEO_DISABLE);
+
+	/* Set power state to mode b */
+	if (rk3066_hdmi_get_power_mode(hdmi) != HDMI_SYS_POWER_MODE_B)
+		rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_B);
+
+	/* Input video mode is RGB24bit, Data enable signal from external */
+	hdmi_modb(hdmi, HDMI_AV_CTRL1,
+		  HDMI_VIDEO_DE_MASK, HDMI_VIDEO_EXTERNAL_DE);
+	hdmi_writeb(hdmi, HDMI_VIDEO_CTRL1,
+		    HDMI_VIDEO_OUTPUT_RGB444 |
+		    HDMI_VIDEO_INPUT_DATA_DEPTH_8BIT |
+		    HDMI_VIDEO_INPUT_COLOR_RGB);
+	hdmi_writeb(hdmi, HDMI_DEEP_COLOR_MODE, 0x20);
+
+	rk3066_hdmi_config_video_timing(hdmi, mode);
+
+	if (hdmi->hdmi_data.sink_is_hdmi) {
+		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK,
+			  HDMI_VIDEO_MODE_HDMI);
+	} else {
+		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK, 0);
+	}
+
+	rk3066_hdmi_config_avi(hdmi, mode);
+
+	rk3066_hdmi_config_phy(hdmi);
+
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_E);
+
+	/*
+	 * When IP controller have configured to an accurate video
+	 * timing, then the TMDS clock source would be switched to
+	 * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
+	 * clock rate, and reconfigure the DDC clock.
+	 */
+	rk3066_hdmi_i2c_init(hdmi);
+
+	/* Unmute video and audio output */
+	hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+		  HDMI_VIDEO_AUDIO_DISABLE_MASK, HDMI_AUDIO_DISABLE);
+	return 0;
+}
+
+static void
+rk3066_hdmi_encoder_mode_set(struct drm_encoder *encoder,
+			     struct drm_display_mode *mode,
+			     struct drm_display_mode *adj_mode)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
+
+	/* Store the display mode for plugin/DPMS poweron events */
+	memcpy(&hdmi->previous_mode, adj_mode, sizeof(hdmi->previous_mode));
+}
+
+static void rk3066_hdmi_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
+	int mux, val;
+
+	mux = drm_of_encoder_active_endpoint_id(hdmi->dev->of_node, encoder);
+	if (mux)
+		val = BIT(30) | BIT(14);
+	else
+		val = BIT(30);
+
+	regmap_write(hdmi->regmap, 0x150, val);
+
+	dev_dbg(hdmi->dev, "hdmi encoder enable select: vop%s\n",
+		(mux) ? "1" : "0");
+
+	rk3066_hdmi_setup(hdmi, &hdmi->previous_mode);
+}
+
+static void rk3066_hdmi_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(encoder);
+
+	dev_dbg(hdmi->dev, "hdmi encoder disable\n");
+
+	if (rk3066_hdmi_get_power_mode(hdmi) == HDMI_SYS_POWER_MODE_E) {
+		hdmi_writeb(hdmi, HDMI_VIDEO_CTRL2,
+			    HDMI_VIDEO_AUDIO_DISABLE_MASK);
+		hdmi_modb(hdmi, HDMI_VIDEO_CTRL2,
+			  HDMI_AUDIO_CP_LOGIC_RESET_MASK,
+			  HDMI_AUDIO_CP_LOGIC_RESET);
+		usleep_range(500, 510);
+	}
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
+}
+
+static bool
+rk3066_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
+			       const struct drm_display_mode *mode,
+			       struct drm_display_mode *adj_mode)
+{
+	return true;
+}
+
+static int
+rk3066_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+
+	s->output_mode = ROCKCHIP_OUT_MODE_P888;
+	s->output_type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return 0;
+}
+
+static const
+struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
+	.enable     = rk3066_hdmi_encoder_enable,
+	.disable    = rk3066_hdmi_encoder_disable,
+	.mode_fixup = rk3066_hdmi_encoder_mode_fixup,
+	.mode_set   = rk3066_hdmi_encoder_mode_set,
+	.atomic_check = rk3066_hdmi_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static enum drm_connector_status
+rk3066_hdmi_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+
+	return (hdmi_readb(hdmi, HDMI_HPG_MENS_STA) & HDMI_HPG_IN_STATUS_HIGH) ?
+		connector_status_connected : connector_status_disconnected;
+}
+
+static const struct drm_display_mode edid_cea_modes[] = {
+	/* 4 - 1280x720@60Hz 16:9 */
+	{ DRM_MODE("1280x720", DRM_MODE_TYPE_DRIVER, 74250, 1280, 1390,
+		   1430, 1650, 0, 720, 725, 730, 750, 0,
+		   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
+	  .vrefresh = 60, .picture_aspect_ratio = HDMI_PICTURE_ASPECT_16_9, },
+};
+
+static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+	struct drm_display_mode *mode = NULL;
+	struct edid *edid;
+	int ret = 0;
+
+	if (!hdmi->ddc)
+		return 0;
+
+	hdmi->hdmi_data.sink_is_hdmi = false;
+
+	edid = drm_get_edid(connector, hdmi->ddc);
+	if (edid) {
+		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
+
+		dev_info(hdmi->dev, "monitor type : %s : %dx%d cm\n",
+			(hdmi->hdmi_data.sink_is_hdmi ? "HDMI" : "DVI"),
+			edid->width_cm, edid->height_cm);
+
+		drm_connector_update_edid_property(connector, edid);
+		ret = drm_add_edid_modes(connector, edid);
+		kfree(edid);
+	}
+
+	if ((ret == 0) || (hdmi->hdmi_data.sink_is_hdmi == false)) {
+		hdmi->hdmi_data.sink_is_hdmi = false;
+
+		mode = drm_mode_duplicate(hdmi->drm_dev, &edid_cea_modes[0]);
+		if (!mode)
+			return ret;
+		mode->type |= DRM_MODE_TYPE_PREFERRED;
+		drm_mode_probed_add(connector, mode);
+		ret++;
+
+		dev_info(hdmi->dev, "no CEA mode found, use default\n");
+	}
+
+	return ret;
+}
+
+static enum drm_mode_status
+rk3066_hdmi_connector_mode_valid(struct drm_connector *connector,
+				 struct drm_display_mode *mode)
+{
+	u32 vic = drm_match_cea_mode(mode);
+
+	if (vic > 1)
+		return MODE_OK;
+	else
+		return MODE_BAD;
+}
+
+static struct drm_encoder *
+rk3066_hdmi_connector_best_encoder(struct drm_connector *connector)
+{
+	struct rk3066_hdmi *hdmi = to_rk3066_hdmi(connector);
+
+	return &hdmi->encoder;
+}
+
+static int
+rk3066_hdmi_probe_single_connector_modes(struct drm_connector *connector,
+					 uint32_t maxX, uint32_t maxY)
+{
+	return drm_helper_probe_single_connector_modes(connector, 1920, 1080);
+}
+
+static void rk3066_hdmi_connector_destroy(struct drm_connector *connector)
+{
+	drm_connector_unregister(connector);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs rk3066_hdmi_connector_funcs = {
+	.fill_modes = rk3066_hdmi_probe_single_connector_modes,
+	.detect = rk3066_hdmi_connector_detect,
+	.destroy = rk3066_hdmi_connector_destroy,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static const
+struct drm_connector_helper_funcs rk3066_hdmi_connector_helper_funcs = {
+	.get_modes = rk3066_hdmi_connector_get_modes,
+	.mode_valid = rk3066_hdmi_connector_mode_valid,
+	.best_encoder = rk3066_hdmi_connector_best_encoder,
+};
+
+static int
+rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
+{
+	struct drm_encoder *encoder = &hdmi->encoder;
+	struct device *dev = hdmi->dev;
+
+	encoder->possible_crtcs =
+		drm_of_find_possible_crtcs(drm, dev->of_node);
+
+	/*
+	 * If we failed to find the CRTC(s) which this encoder is
+	 * supposed to be connected to, it's because the CRTC has
+	 * not been registered yet.  Defer probing, and hope that
+	 * the required CRTC is added later.
+	 */
+	if (encoder->possible_crtcs == 0)
+		return -EPROBE_DEFER;
+
+	dev_info(hdmi->dev, "CRTC found\n");
+
+	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
+	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
+
+	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+
+	drm_connector_helper_add(&hdmi->connector,
+				 &rk3066_hdmi_connector_helper_funcs);
+	drm_connector_init(drm, &hdmi->connector,
+			   &rk3066_hdmi_connector_funcs,
+			   DRM_MODE_CONNECTOR_HDMIA);
+
+	drm_connector_attach_encoder(&hdmi->connector, encoder);
+
+	return 0;
+}
+
+static irqreturn_t rk3066_hdmi_i2c_irq(struct rk3066_hdmi *hdmi, u8 stat)
+{
+	struct rk3066_hdmi_i2c *i2c = hdmi->i2c;
+
+	if (!(stat & HDMI_INTR_EDID_MASK))
+		return IRQ_NONE;
+
+	i2c->stat = stat;
+
+	complete(&i2c->cmp);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rk3066_hdmi_hardirq(int irq, void *dev_id)
+{
+	struct rk3066_hdmi *hdmi = dev_id;
+	irqreturn_t ret = IRQ_NONE;
+	u8 interrupt;
+
+	if (rk3066_hdmi_get_power_mode(hdmi) == HDMI_SYS_POWER_MODE_A)
+		hdmi_writeb(hdmi, HDMI_SYS_CTRL, HDMI_SYS_POWER_MODE_B);
+
+	interrupt = hdmi_readb(hdmi, HDMI_INTR_STATUS1);
+	if (interrupt)
+		hdmi_writeb(hdmi, HDMI_INTR_STATUS1, interrupt);
+
+	if (hdmi->i2c)
+		ret = rk3066_hdmi_i2c_irq(hdmi, interrupt);
+
+	if (interrupt & (HDMI_INTR_HOTPLUG | HDMI_INTR_MSENS))
+		ret = IRQ_WAKE_THREAD;
+
+	return ret;
+}
+
+static irqreturn_t rk3066_hdmi_irq(int irq, void *dev_id)
+{
+	struct rk3066_hdmi *hdmi = dev_id;
+
+	drm_helper_hpd_irq_event(hdmi->connector.dev);
+
+	return IRQ_HANDLED;
+}
+
+static int rk3066_hdmi_i2c_read(struct rk3066_hdmi *hdmi, struct i2c_msg *msgs)
+{
+	int length = msgs->len;
+	u8 *buf = msgs->buf;
+	int ret;
+
+	ret = wait_for_completion_timeout(&hdmi->i2c->cmp, HZ / 10);
+	if (!ret || hdmi->i2c->stat & HDMI_INTR_EDID_ERR)
+		return -EAGAIN;
+
+	while (length--)
+		*buf++ = hdmi_readb(hdmi, HDMI_DDC_READ_FIFO_ADDR);
+
+	return 0;
+}
+
+static int rk3066_hdmi_i2c_write(struct rk3066_hdmi *hdmi, struct i2c_msg *msgs)
+{
+	/*
+	 * The DDC module only support read EDID message, so
+	 * we assume that each word write to this i2c adapter
+	 * should be the offset of EDID word address.
+	 */
+	if (msgs->len != 1 ||
+	    (msgs->addr != DDC_ADDR && msgs->addr != DDC_SEGMENT_ADDR))
+		return -EINVAL;
+
+	reinit_completion(&hdmi->i2c->cmp);
+
+	if (msgs->addr == DDC_SEGMENT_ADDR)
+		hdmi->i2c->segment_addr = msgs->buf[0];
+	if (msgs->addr == DDC_ADDR)
+		hdmi->i2c->ddc_addr = msgs->buf[0];
+
+	/* Set edid word address 0x00/0x80 */
+	hdmi_writeb(hdmi, HDMI_EDID_WORD_ADDR, hdmi->i2c->ddc_addr);
+
+	/* Set edid segment pointer */
+	hdmi_writeb(hdmi, HDMI_EDID_SEGMENT_POINTER, hdmi->i2c->segment_addr);
+
+	return 0;
+}
+
+static int rk3066_hdmi_i2c_xfer(struct i2c_adapter *adap,
+				struct i2c_msg *msgs, int num)
+{
+	struct rk3066_hdmi *hdmi = i2c_get_adapdata(adap);
+	struct rk3066_hdmi_i2c *i2c = hdmi->i2c;
+	int i, ret = 0;
+
+	mutex_lock(&i2c->lock);
+
+	rk3066_hdmi_i2c_init(hdmi);
+
+	/* Unmute the interrupt */
+	hdmi_modb(hdmi, HDMI_INTR_MASK1,
+		  HDMI_INTR_EDID_MASK, HDMI_INTR_EDID_MASK);
+	i2c->stat = 0;
+
+	for (i = 0; i < num; i++) {
+		dev_dbg(hdmi->dev, "xfer: num: %d/%d, len: %d, flags: %#x\n",
+			i + 1, num, msgs[i].len, msgs[i].flags);
+
+		if (msgs[i].flags & I2C_M_RD)
+			ret = rk3066_hdmi_i2c_read(hdmi, &msgs[i]);
+		else
+			ret = rk3066_hdmi_i2c_write(hdmi, &msgs[i]);
+
+		if (ret < 0)
+			break;
+	}
+
+	if (!ret)
+		ret = num;
+
+	/* Mute HDMI EDID interrupt */
+	hdmi_modb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_EDID_MASK, 0);
+
+	mutex_unlock(&i2c->lock);
+
+	return ret;
+}
+
+static u32 rk3066_hdmi_i2c_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm rk3066_hdmi_algorithm = {
+	.master_xfer	= rk3066_hdmi_i2c_xfer,
+	.functionality	= rk3066_hdmi_i2c_func,
+};
+
+static struct i2c_adapter *rk3066_hdmi_i2c_adapter(struct rk3066_hdmi *hdmi)
+{
+	struct i2c_adapter *adap;
+	struct rk3066_hdmi_i2c *i2c;
+	int ret;
+
+	i2c = devm_kzalloc(hdmi->dev, sizeof(*i2c), GFP_KERNEL);
+	if (!i2c)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&i2c->lock);
+	init_completion(&i2c->cmp);
+
+	adap = &i2c->adap;
+	adap->class = I2C_CLASS_DDC;
+	adap->owner = THIS_MODULE;
+	adap->dev.parent = hdmi->dev;
+	adap->dev.of_node = hdmi->dev->of_node;
+	adap->algo = &rk3066_hdmi_algorithm;
+	strlcpy(adap->name, "RK3066 HDMI", sizeof(adap->name));
+	i2c_set_adapdata(adap, hdmi);
+
+	ret = i2c_add_adapter(adap);
+	if (ret) {
+		dev_warn(hdmi->dev, "cannot add %s I2C adapter\n", adap->name);
+		devm_kfree(hdmi->dev, i2c);
+		return ERR_PTR(ret);
+	}
+
+	hdmi->i2c = i2c;
+
+	dev_info(hdmi->dev, "registered %s I2C bus driver\n", adap->name);
+
+	return adap;
+}
+
+static int rk3066_hdmi_bind(struct device *dev, struct device *master,
+			    void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct drm_device *drm = data;
+	struct rk3066_hdmi *hdmi;
+	struct resource *iores;
+	int irq;
+	int ret;
+
+	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
+	if (!hdmi)
+		return -ENOMEM;
+
+	hdmi->dev = dev;
+	hdmi->drm_dev = drm;
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores)
+		return -ENXIO;
+
+	hdmi->regs = devm_ioremap_resource(dev, iores);
+	if (IS_ERR(hdmi->regs))
+		return PTR_ERR(hdmi->regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	hdmi->hclk = devm_clk_get(hdmi->dev, "hclk");
+	if (IS_ERR(hdmi->hclk)) {
+		dev_err(hdmi->dev, "unable to get HDMI hclk clk\n");
+		return PTR_ERR(hdmi->hclk);
+	}
+
+	ret = clk_prepare_enable(hdmi->hclk);
+	if (ret) {
+		dev_err(hdmi->dev, "cannot enable HDMI hclk clock: %d\n", ret);
+		return ret;
+	}
+
+	hdmi->regmap =
+		syscon_regmap_lookup_by_phandle(hdmi->dev->of_node,
+						"rockchip,grf");
+	if (IS_ERR(hdmi->regmap)) {
+		dev_err(hdmi->dev, "unable to get rockchip,grf\n");
+		ret = PTR_ERR(hdmi->regmap);
+		goto err_disable_hclk;
+	}
+
+	/* internal hclk = hdmi_hclk / 25 */
+	hdmi_writeb(hdmi, HDMI_INTERNAL_CLK_DIVIDER, 25);
+
+	hdmi->ddc = rk3066_hdmi_i2c_adapter(hdmi);
+	if (IS_ERR(hdmi->ddc)) {
+		ret = PTR_ERR(hdmi->ddc);
+		hdmi->ddc = NULL;
+		goto err_disable_hclk;
+	}
+
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_B);
+	usleep_range(999, 1000);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK1, HDMI_INTR_HOTPLUG);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK2, 0);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK3, 0);
+	hdmi_writeb(hdmi, HDMI_INTR_MASK4, 0);
+	rk3066_hdmi_set_power_mode(hdmi, HDMI_SYS_POWER_MODE_A);
+
+	ret = rk3066_hdmi_register(drm, hdmi);
+	if (ret)
+		goto err_disable_hclk;
+
+	dev_set_drvdata(dev, hdmi);
+
+	ret = devm_request_threaded_irq(dev, irq, rk3066_hdmi_hardirq,
+					rk3066_hdmi_irq, IRQF_SHARED,
+					dev_name(dev), hdmi);
+	if (ret) {
+		dev_err(hdmi->dev,
+			"failed to request hdmi irq: %d\n", ret);
+		goto err_disable_hclk;
+	}
+
+	return 0;
+
+err_disable_hclk:
+	clk_disable_unprepare(hdmi->hclk);
+
+	return ret;
+}
+
+static void rk3066_hdmi_unbind(struct device *dev, struct device *master,
+			       void *data)
+{
+	struct rk3066_hdmi *hdmi = dev_get_drvdata(dev);
+
+	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+
+	clk_disable_unprepare(hdmi->hclk);
+	i2c_put_adapter(hdmi->ddc);
+}
+
+static const struct component_ops rk3066_hdmi_ops = {
+	.bind	= rk3066_hdmi_bind,
+	.unbind	= rk3066_hdmi_unbind,
+};
+
+static int rk3066_hdmi_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &rk3066_hdmi_ops);
+}
+
+static int rk3066_hdmi_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rk3066_hdmi_ops);
+
+	return 0;
+}
+
+static const struct of_device_id rk3066_hdmi_dt_ids[] = {
+	{ .compatible = "rockchip,rk3066-hdmi",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, rk3066_hdmi_dt_ids);
+
+struct platform_driver rk3066_hdmi_driver = {
+	.probe  = rk3066_hdmi_probe,
+	.remove = rk3066_hdmi_remove,
+	.driver = {
+		.name = "rockchip-rk3066hdmi",
+		.of_match_table = rk3066_hdmi_dt_ids,
+	},
+};
+
+MODULE_AUTHOR("Zheng Yang <zhengyang@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip Specific RK3066-HDMI Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:rockchip-rk3066hdmi");
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.h b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
new file mode 100644
index 000000000..f4c2e2081
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ *    Zheng Yang <zhengyang@rock-chips.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __RK3066_HDMI_H__
+#define __RK3066_HDMI_H__
+
+#define DDC_SEGMENT_ADDR			0x30
+#define HDMI_SCL_RATE				(50 * 1000)
+#define HDMI_MAXIMUM_INFO_FRAME_SIZE		0x11
+
+#define N_32K					0x1000
+#define N_441K					0x1880
+#define N_882K					0x3100
+#define N_1764K					0x6200
+#define N_48K					0x1800
+#define N_96K					0x3000
+#define N_192K					0x6000
+
+#define HDMI_SYS_CTRL				0x000
+#define HDMI_LR_SWAP_N3				0x004
+#define HDMI_N2					0x008
+#define HDMI_N1					0x00c
+#define HDMI_SPDIF_FS_CTS_INT3			0x010
+#define HDMI_CTS_INT2				0x014
+#define HDMI_CTS_INT1				0x018
+#define HDMI_CTS_EXT3				0x01c
+#define HDMI_CTS_EXT2				0x020
+#define HDMI_CTS_EXT1				0x024
+#define HDMI_AUDIO_CTRL1			0x028
+#define HDMI_AUDIO_CTRL2			0x02c
+#define HDMI_I2S_AUDIO_CTRL			0x030
+#define HDMI_I2S_SWAP				0x040
+#define HDMI_AUDIO_STA_BIT_CTRL1		0x044
+#define HDMI_AUDIO_STA_BIT_CTRL2		0x048
+#define HDMI_AUDIO_SRC_NUM_AND_LENGTH		0x050
+#define HDMI_AV_CTRL1				0x054
+#define HDMI_VIDEO_CTRL1			0x058
+#define HDMI_DEEP_COLOR_MODE			0x05c
+
+#define HDMI_EXT_VIDEO_PARA			0x0c0
+#define HDMI_EXT_HTOTAL_L			0x0c4
+#define HDMI_EXT_HTOTAL_H			0x0c8
+#define HDMI_EXT_HBLANK_L			0x0cc
+#define HDMI_EXT_HBLANK_H			0x0d0
+#define HDMI_EXT_HDELAY_L			0x0d4
+#define HDMI_EXT_HDELAY_H			0x0d8
+#define HDMI_EXT_HDURATION_L			0x0dc
+#define HDMI_EXT_HDURATION_H			0x0e0
+#define HDMI_EXT_VTOTAL_L			0x0e4
+#define HDMI_EXT_VTOTAL_H			0x0e8
+#define HDMI_AV_CTRL2				0x0ec
+#define HDMI_EXT_VBLANK_L			0x0f4
+#define HDMI_EXT_VBLANK_H			0x10c
+#define HDMI_EXT_VDELAY				0x0f8
+#define HDMI_EXT_VDURATION			0x0fc
+
+#define HDMI_CP_MANU_SEND_CTRL			0x100
+#define HDMI_CP_AUTO_SEND_CTRL			0x104
+#define HDMI_AUTO_CHECKSUM_OPT			0x108
+
+#define HDMI_VIDEO_CTRL2			0x114
+
+#define HDMI_PHY_OPTION				0x144
+
+#define HDMI_CP_BUF_INDEX			0x17c
+#define HDMI_CP_BUF_ACC_HB0			0x180
+#define HDMI_CP_BUF_ACC_HB1			0x184
+#define HDMI_CP_BUF_ACC_HB2			0x188
+#define HDMI_CP_BUF_ACC_PB0			0x18c
+
+#define HDMI_DDC_READ_FIFO_ADDR			0x200
+#define HDMI_DDC_BUS_FREQ_L			0x204
+#define HDMI_DDC_BUS_FREQ_H			0x208
+#define HDMI_DDC_BUS_CTRL			0x2dc
+#define HDMI_DDC_I2C_LEN			0x278
+#define HDMI_DDC_I2C_OFFSET			0x280
+#define HDMI_DDC_I2C_CTRL			0x284
+#define HDMI_DDC_I2C_READ_BUF0			0x288
+#define HDMI_DDC_I2C_READ_BUF1			0x28c
+#define HDMI_DDC_I2C_READ_BUF2			0x290
+#define HDMI_DDC_I2C_READ_BUF3			0x294
+#define HDMI_DDC_I2C_WRITE_BUF0			0x298
+#define HDMI_DDC_I2C_WRITE_BUF1			0x29c
+#define HDMI_DDC_I2C_WRITE_BUF2			0x2a0
+#define HDMI_DDC_I2C_WRITE_BUF3			0x2a4
+#define HDMI_DDC_I2C_WRITE_BUF4			0x2ac
+#define HDMI_DDC_I2C_WRITE_BUF5			0x2b0
+#define HDMI_DDC_I2C_WRITE_BUF6			0x2b4
+
+#define HDMI_INTR_MASK1				0x248
+#define HDMI_INTR_MASK2				0x24c
+#define HDMI_INTR_STATUS1			0x250
+#define HDMI_INTR_STATUS2			0x254
+#define HDMI_INTR_MASK3				0x258
+#define HDMI_INTR_MASK4				0x25c
+#define HDMI_INTR_STATUS3			0x260
+#define HDMI_INTR_STATUS4			0x264
+
+#define HDMI_HDCP_CTRL				0x2bc
+
+#define HDMI_EDID_SEGMENT_POINTER		0x310
+#define HDMI_EDID_WORD_ADDR			0x314
+#define HDMI_EDID_FIFO_ADDR			0x318
+
+#define HDMI_HPG_MENS_STA			0x37c
+
+#define HDMI_INTERNAL_CLK_DIVIDER		0x800
+
+enum {
+	/* HDMI_SYS_CTRL */
+	HDMI_SYS_POWER_MODE_MASK = 0xf0,
+	HDMI_SYS_POWER_MODE_A = 0x10,
+	HDMI_SYS_POWER_MODE_B = 0x20,
+	HDMI_SYS_POWER_MODE_D = 0x40,
+	HDMI_SYS_POWER_MODE_E = 0x80,
+	HDMI_SYS_PLL_RESET_MASK = 0x0c,
+	HDMI_SYS_PLL_RESET = 0x0c,
+	HDMI_SYS_PLLB_RESET = 0x08,
+
+	/* HDMI_LR_SWAP_N3 */
+	HDMI_AUDIO_LR_SWAP_MASK = 0xf0,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET0 = 0x10,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET1 = 0x20,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET2 = 0x40,
+	HDMI_AUDIO_LR_SWAP_SUBPACKET3 = 0x80,
+	HDMI_AUDIO_N_19_16_MASK = 0x0f,
+
+	/* HDMI_AUDIO_CTRL1 */
+	HDMI_AUDIO_EXTERNAL_CTS = BIT(7),
+	HDMI_AUDIO_INPUT_IIS = 0,
+	HDMI_AUDIO_INPUT_SPDIF = 0x08,
+	HDMI_AUDIO_INPUT_MCLK_ACTIVE = 0x04,
+	HDMI_AUDIO_INPUT_MCLK_DEACTIVE = 0,
+	HDMI_AUDIO_INPUT_MCLK_RATE_128X = 0,
+	HDMI_AUDIO_INPUT_MCLK_RATE_256X = 1,
+	HDMI_AUDIO_INPUT_MCLK_RATE_384X = 2,
+	HDMI_AUDIO_INPUT_MCLK_RATE_512X = 3,
+
+	/* HDMI_I2S_AUDIO_CTRL */
+	HDMI_AUDIO_I2S_FORMAT_STANDARD = 0,
+	HDMI_AUDIO_I2S_CHANNEL_1_2 = 0x04,
+	HDMI_AUDIO_I2S_CHANNEL_3_4 = 0x0c,
+	HDMI_AUDIO_I2S_CHANNEL_5_6 = 0x1c,
+	HDMI_AUDIO_I2S_CHANNEL_7_8 = 0x3c,
+
+	/* HDMI_AV_CTRL1 */
+	HDMI_AUDIO_SAMPLE_FRE_MASK = 0xf0,
+	HDMI_AUDIO_SAMPLE_FRE_32000 = 0x30,
+	HDMI_AUDIO_SAMPLE_FRE_44100 = 0,
+	HDMI_AUDIO_SAMPLE_FRE_48000 = 0x20,
+	HDMI_AUDIO_SAMPLE_FRE_88200 = 0x80,
+	HDMI_AUDIO_SAMPLE_FRE_96000 = 0xa0,
+	HDMI_AUDIO_SAMPLE_FRE_176400 = 0xc0,
+	HDMI_AUDIO_SAMPLE_FRE_192000 = 0xe0,
+	HDMI_AUDIO_SAMPLE_FRE_768000 = 0x90,
+
+	HDMI_VIDEO_INPUT_FORMAT_MASK = 0x0e,
+	HDMI_VIDEO_INPUT_RGB_YCBCR444 = 0,
+	HDMI_VIDEO_INPUT_YCBCR422 = 0x02,
+	HDMI_VIDEO_DE_MASK = 0x1,
+	HDMI_VIDEO_INTERNAL_DE = 0,
+	HDMI_VIDEO_EXTERNAL_DE = 0x01,
+
+	/* HDMI_VIDEO_CTRL1 */
+	HDMI_VIDEO_OUTPUT_FORMAT_MASK = 0xc0,
+	HDMI_VIDEO_OUTPUT_RGB444 = 0,
+	HDMI_VIDEO_OUTPUT_YCBCR444 = 0x40,
+	HDMI_VIDEO_OUTPUT_YCBCR422 = 0x80,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_MASK = 0x30,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_12BIT = 0,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_10BIT = 0x10,
+	HDMI_VIDEO_INPUT_DATA_DEPTH_8BIT = 0x30,
+	HDMI_VIDEO_INPUT_COLOR_MASK = 1,
+	HDMI_VIDEO_INPUT_COLOR_RGB = 0,
+	HDMI_VIDEO_INPUT_COLOR_YCBCR = 1,
+
+	/* HDMI_EXT_VIDEO_PARA */
+	HDMI_VIDEO_VSYNC_OFFSET_SHIFT = 4,
+	HDMI_VIDEO_VSYNC_ACTIVE_HIGH = BIT(3),
+	HDMI_VIDEO_VSYNC_ACTIVE_LOW = 0,
+	HDMI_VIDEO_HSYNC_ACTIVE_HIGH = BIT(2),
+	HDMI_VIDEO_HSYNC_ACTIVE_LOW = 0,
+	HDMI_VIDEO_MODE_INTERLACE = BIT(1),
+	HDMI_VIDEO_MODE_PROGRESSIVE = 0,
+	HDMI_EXT_VIDEO_SET_EN = BIT(0),
+
+	/* HDMI_CP_AUTO_SEND_CTRL */
+
+	/* HDMI_VIDEO_CTRL2 */
+	HDMI_VIDEO_AV_MUTE_MASK = 0xc0,
+	HDMI_VIDEO_CLR_AV_MUTE = BIT(7),
+	HDMI_VIDEO_SET_AV_MUTE = BIT(6),
+	HDMI_AUDIO_CP_LOGIC_RESET_MASK = BIT(2),
+	HDMI_AUDIO_CP_LOGIC_RESET = BIT(2),
+	HDMI_VIDEO_AUDIO_DISABLE_MASK = 0x3,
+	HDMI_AUDIO_DISABLE = BIT(1),
+	HDMI_VIDEO_DISABLE = BIT(0),
+
+	/* HDMI_CP_BUF_INDEX */
+	HDMI_INFOFRAME_VSI = 0x05,
+	HDMI_INFOFRAME_AVI = 0x06,
+	HDMI_INFOFRAME_AAI = 0x08,
+
+	/* HDMI_INTR_MASK1 */
+	/* HDMI_INTR_STATUS1 */
+	HDMI_INTR_HOTPLUG = BIT(7),
+	HDMI_INTR_MSENS = BIT(6),
+	HDMI_INTR_VSYNC = BIT(5),
+	HDMI_INTR_AUDIO_FIFO_FULL = BIT(4),
+	HDMI_INTR_EDID_MASK = 0x6,
+	HDMI_INTR_EDID_READY = BIT(2),
+	HDMI_INTR_EDID_ERR = BIT(1),
+
+	/* HDMI_HDCP_CTRL */
+	HDMI_VIDEO_MODE_MASK = BIT(1),
+	HDMI_VIDEO_MODE_HDMI = BIT(1),
+
+	/* HDMI_HPG_MENS_STA */
+	HDMI_HPG_IN_STATUS_HIGH = BIT(7),
+	HDMI_MSENS_IN_STATUS_HIGH = BIT(6),
+};
+
+#endif /* __RK3066_HDMI_H__ */
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 941f35233..1f0c592b3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -492,6 +492,8 @@ static int __init rockchip_drm_init(void)
 	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_driver,
 				CONFIG_ROCKCHIP_DW_MIPI_DSI);
 	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
+	ADD_ROCKCHIP_SUB_DRIVER(rk3066_hdmi_driver,
+				CONFIG_ROCKCHIP_RK3066_HDMI);
 
 	ret = platform_register_drivers(rockchip_sub_drivers,
 					num_rockchip_sub_drivers);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 21a023a97..d03890314 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -72,4 +72,5 @@ extern struct platform_driver inno_hdmi_driver;
 extern struct platform_driver rockchip_dp_driver;
 extern struct platform_driver rockchip_lvds_driver;
 extern struct platform_driver vop_platform_driver;
+extern struct platform_driver rk3066_hdmi_driver;
 #endif /* _ROCKCHIP_DRM_DRV_H_ */
-- 
2.11.0

