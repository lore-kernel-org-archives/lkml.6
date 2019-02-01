Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B9BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669F218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfU/q/p0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfBAR3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:29:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33287 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBAR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:29:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so6513769ljd.0;
        Fri, 01 Feb 2019 09:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXx5ppy3Cxa8ue+r2iDJAtbQ20DIPseQM6vRxnwyhkg=;
        b=JfU/q/p0KqIV0f065O6eTrhw8ZBFZLQRUQpDcogyZKXbr0YR2zLAOX3SqoDfzHvFRh
         pRVsfFX3+54t5KE7YcaZyUQEpO9Tor1fzWa+4/cOFxsV/ub3JOKv6uike6/EvfIP361Y
         8D5mDwM+V4k6XdjJ71BUhtA9gWNmWBrwwWNFZY1GULBut3J8sHgr6YCj3lcxAAevm6dD
         8bjuLsTHHdHPJzQAXo35SsH1LP674Fh7qY10pXvav7U+B6EdIVVqqLSG6RuIDb4xrI5L
         M1vcZgTO7wF4cIBRdbbV7n/jVeSZsMVaawJgb6YYxd5l50IiyK008Qi/+7UFvZgngYSw
         I4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXx5ppy3Cxa8ue+r2iDJAtbQ20DIPseQM6vRxnwyhkg=;
        b=KdlfVWKFski3YrU3yHk14TBE05pXnRYcTLJ+ZZm5CMurx8lExpLnXQlFMnLM+lcQss
         yJX1xtmiuT14CBxjvM+aVOAn2zrKgqfWTBPth+isShED6VRQiTqvHXEz1EM9HL0CYBls
         M6d+lRViCnhT7f4gmzL8FbDVJksAlIVz1B9LwatrBC8Njy+5wq7AoNItWgH7JioSnOw+
         Le9IdZZh5GMmF4aoKbDduyQdeiKWz1/njVVsXIwvwRyw2Np0qRGvCLEfY3/hj4OV8r+b
         TgnepAjXJ9jk3R4nFkGZ/5ODLIDJ1WxzKZSblo3q1/DeBJZ2IE6Xk3YPWdLdPsMEIV1Q
         qG3A==
X-Gm-Message-State: AJcUukfrAPbYRhjaAghTRWHPxzm8/VOGiNlyPWDHaMaQxT++qe3DWlnF
        gHeY3F0N6a9ppywsXqZD7kk=
X-Google-Smtp-Source: ALg8bN6ZynyMbQceWex5AXcXdYDJF8lt54o+D1j3eJuseazSc+ozWRsQ1YRnpFG4w5MmUHPJBADbmw==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr32337104ljb.51.1549042141184;
        Fri, 01 Feb 2019 09:29:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:b0fa:39a8:9559:1b76])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm1388796lju.46.2019.02.01.09.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:29:00 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/2] drm/panel: Add driver for Samsung S6E63M0 panel
Date:   Fri,  1 Feb 2019 18:28:52 +0100
Message-Id: <20190201172852.4944-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201172852.4944-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190201172852.4944-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Samsung S6E63M0 AMOLED LCD panel driver, connected over
spi. It's based on already removed, non dt s6e63m0 driver and
panel-samsung-ld9040. It can be found for example in some of Samsung
Aries based phones.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Correct order of Kconfig/Makefile entry
  - Fix SPDX tag, so it matches value of MODULE_LICENSE
  - Remove inclusion of drmP.h
  - Fix code formatting
  - Use DRM_DEV_ERROR/DEBUG
  - Extract hardcoded values
  - Remove possibility to change gamma through sysfs, leaving only one
    gamma table values
  - Fix reset_gpio handling, so it'll be asserted in power_on and
    deasserted in power_off. Also do it before turning voltage on.
  - Disable backlight and enter sleep mode in disable callback.
    Previously it was done in unprepare
  - Enable display and backlight in enable callback. Previously it was
    done in prepare
  - Hardcode display timings and delays. Previously they were readed
    from device tree
  - We're using SPDX, so we don't need to have license body
  - Use MIPI_DCS_EXIT_SLEEP_MODE and MIPI_DCS_SET_DISPLAY_ON
  - Rename MAX_GAMMA_LEVEL to NUM_GAMMA_LEVELS
  - Ommit get_brightness callback
  - Use backlight_enable/disable API, like it's done in other panel
    drivers (for example panel-simple)
  - Make set_brightness called only from backlight api, like it's done
    in other panel drivers (for example panel-simple).
  - Reset gpio should be set to GPIOD_OUT_HIGH. It's declared as active
    low in device tree
  - Don't call power_off in remove callback
---
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 517 ++++++++++++++++++
 3 files changed, 525 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 3f3537719beb..be05ed5218eb 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -158,6 +158,13 @@ config DRM_PANEL_SAMSUNG_S6E63J0X03
 	depends on BACKLIGHT_CLASS_DEVICE
 	select VIDEOMODE_HELPERS
 
+config DRM_PANEL_SAMSUNG_S6E63M0
+	tristate "Samsung S6E63M0 RGB/SPI panel"
+	depends on OF
+	depends on SPI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
+
 config DRM_PANEL_SAMSUNG_S6E8AA0
 	tristate "Samsung S6E8AA0 DSI video mode panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 4396658a7996..4507a2d253ac 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03) += panel-samsung-s6e63j0x03.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E63M0) += panel-samsung-s6e63m0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
 obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
new file mode 100644
index 000000000000..7658bd993088
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * S6E63M0 AMOLED LCD drm_panel driver.
+ *
+ * Copyright (C) 2019 Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
+ * Derived from drivers/gpu/drm/panel-samsung-ld9040.c
+ *
+ * Andrzej Hajda <a.hajda@samsung.com>
+ */
+
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <video/mipi_display.h>
+#include <video/of_videomode.h>
+#include <video/videomode.h>
+
+/* Manufacturer Command Set */
+#define MCS_ELVSS_ON                0xb1
+#define MCS_ACL_CTRL                0xc0
+#define MCS_DISPLAY_CONDITION   0xf2
+#define MCS_ETC_CONDITION           0xf6
+#define MCS_PANEL_CONDITION         0xF8
+#define MCS_GAMMA_CTRL              0xfa
+
+#define NUM_GAMMA_LEVELS             11
+#define GAMMA_TABLE_COUNT           23
+
+#define DATA_MASK                                       0x100
+
+#define MAX_BRIGHTNESS              (NUM_GAMMA_LEVELS - 1)
+
+/* array of gamma tables for gamma value 2.2 */
+static u8 const s6e63m0_gamma_22[NUM_GAMMA_LEVELS][GAMMA_TABLE_COUNT] = {
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x78, 0xEC, 0x3D, 0xC8,
+	  0xC2, 0xB6, 0xC4, 0xC7, 0xB6, 0xD5, 0xD7,
+	  0xCC, 0x00, 0x39, 0x00, 0x36, 0x00, 0x51 },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x73, 0x4A, 0x3D, 0xC0,
+	  0xC2, 0xB1, 0xBB, 0xBE, 0xAC, 0xCE, 0xCF,
+	  0xC5, 0x00, 0x5D, 0x00, 0x5E, 0x00, 0x82 },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x70, 0x51, 0x3E, 0xBF,
+	  0xC1, 0xAF, 0xB9, 0xBC, 0xAB, 0xCC, 0xCC,
+	  0xC2, 0x00, 0x65, 0x00, 0x67, 0x00, 0x8D },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x6C, 0x54, 0x3A, 0xBC,
+	  0xBF, 0xAC, 0xB7, 0xBB, 0xA9, 0xC9, 0xC9,
+	  0xBE, 0x00, 0x71, 0x00, 0x73, 0x00, 0x9E },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x69, 0x54, 0x37, 0xBB,
+	  0xBE, 0xAC, 0xB4, 0xB7, 0xA6, 0xC7, 0xC8,
+	  0xBC, 0x00, 0x7B, 0x00, 0x7E, 0x00, 0xAB },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x66, 0x55, 0x34, 0xBA,
+	  0xBD, 0xAB, 0xB1, 0xB5, 0xA3, 0xC5, 0xC6,
+	  0xB9, 0x00, 0x85, 0x00, 0x88, 0x00, 0xBA },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x63, 0x53, 0x31, 0xB8,
+	  0xBC, 0xA9, 0xB0, 0xB5, 0xA2, 0xC4, 0xC4,
+	  0xB8, 0x00, 0x8B, 0x00, 0x8E, 0x00, 0xC2 },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x62, 0x54, 0x30, 0xB9,
+	  0xBB, 0xA9, 0xB0, 0xB3, 0xA1, 0xC1, 0xC3,
+	  0xB7, 0x00, 0x91, 0x00, 0x95, 0x00, 0xDA },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x66, 0x58, 0x34, 0xB6,
+	  0xBA, 0xA7, 0xAF, 0xB3, 0xA0, 0xC1, 0xC2,
+	  0xB7, 0x00, 0x97, 0x00, 0x9A, 0x00, 0xD1 },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x64, 0x56, 0x33, 0xB6,
+	  0xBA, 0xA8, 0xAC, 0xB1, 0x9D, 0xC1, 0xC1,
+	  0xB7, 0x00, 0x9C, 0x00, 0x9F, 0x00, 0xD6 },
+	{ MCS_GAMMA_CTRL, 0x00,
+	  0x18, 0x08, 0x24, 0x5f, 0x50, 0x2d, 0xB6,
+	  0xB9, 0xA7, 0xAd, 0xB1, 0x9f, 0xbe, 0xC0,
+	  0xB5, 0x00, 0xa0, 0x00, 0xa4, 0x00, 0xdb },
+};
+
+struct s6e63m0 {
+	struct device *dev;
+	struct drm_panel panel;
+	struct backlight_device *bl_dev;
+
+	struct regulator_bulk_data supplies[2];
+	struct gpio_desc *reset_gpio;
+	struct videomode vm;
+
+	bool prepared;
+	bool enabled;
+
+	/*
+	 * This field is tested by functions directly accessing bus before
+	 * transfer, transfer is skipped if it is set. In case of transfer
+	 * failure or unexpected response the field is set to error value.
+	 * Such construct allows to eliminate many checks in higher level
+	 * functions.
+	 */
+	int error;
+};
+
+static const struct drm_display_mode default_mode = {
+	.clock		= 25628,
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 16,
+	.hsync_end	= 480 + 16 + 2,
+	.htotal		= 480 + 16 + 2 + 16,
+	.vdisplay	= 800,
+	.vsync_start	= 800 + 28,
+	.vsync_end	= 800 + 28 + 2,
+	.vtotal		= 800 + 28 + 2 + 1,
+	.vrefresh	= 60,
+	.width_mm	= 53,
+	.height_mm	= 89,
+	.flags		= DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static inline struct s6e63m0 *panel_to_s6e63m0(struct drm_panel *panel)
+{
+	return container_of(panel, struct s6e63m0, panel);
+}
+
+static int s6e63m0_clear_error(struct s6e63m0 *ctx)
+{
+	int ret = ctx->error;
+
+	ctx->error = 0;
+	return ret;
+}
+
+static int s6e63m0_spi_write_word(struct s6e63m0 *ctx, u16 data)
+{
+	struct spi_device *spi = to_spi_device(ctx->dev);
+	struct spi_transfer xfer = {
+		.len	= 2,
+		.tx_buf = &data,
+	};
+	struct spi_message msg;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	return spi_sync(spi, &msg);
+}
+
+static void s6e63m0_dcs_write(struct s6e63m0 *ctx, const u8 *data, size_t len)
+{
+	int ret = 0;
+
+	if (ctx->error < 0 || len == 0)
+		return;
+
+	DRM_DEV_DEBUG(ctx->dev, "writing dcs seq: %*ph\n", (int)len, data);
+	ret = s6e63m0_spi_write_word(ctx, *data);
+
+	while (!ret && --len) {
+		++data;
+		ret = s6e63m0_spi_write_word(ctx, *data | DATA_MASK);
+	}
+
+	if (ret) {
+		DRM_DEV_ERROR(ctx->dev, "error %d writing dcs seq: %*ph\n", ret,
+			      (int)len, data);
+		ctx->error = ret;
+	}
+
+	usleep_range(300, 310);
+}
+
+#define s6e63m0_dcs_write_seq_static(ctx, seq ...) \
+	({ \
+		static const u8 d[] = { seq }; \
+		s6e63m0_dcs_write(ctx, d, ARRAY_SIZE(d)); \
+	})
+
+static void s6e63m0_brightness_set(struct s6e63m0 *ctx)
+{
+	int brightness = ctx->bl_dev->props.brightness;
+
+	/* disable and set new gamma */
+	s6e63m0_dcs_write(ctx, s6e63m0_gamma_22[brightness],
+			  ARRAY_SIZE(s6e63m0_gamma_22[brightness]));
+
+	/* update gamma table. */
+	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL, 0x01);
+}
+
+static void s6e63m0_init(struct s6e63m0 *ctx)
+{
+	s6e63m0_dcs_write_seq_static(ctx, MCS_PANEL_CONDITION,
+				     0x01, 0x27, 0x27, 0x07, 0x07, 0x54, 0x9f,
+				     0x63, 0x86, 0x1a, 0x33, 0x0d, 0x00, 0x00);
+
+	s6e63m0_dcs_write_seq_static(ctx, MCS_DISPLAY_CONDITION,
+				     0x02, 0x03, 0x1c, 0x10, 0x10);
+	s6e63m0_dcs_write_seq_static(ctx, 0xf7,
+				     0x03, 0x00, 0x00);
+
+	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
+				     0x00, 0x18, 0x08, 0x24, 0x64, 0x56, 0x33,
+				     0xb6, 0xba, 0xa8, 0xac, 0xb1, 0x9d, 0xc1,
+				     0xc1, 0xb7, 0x00, 0x9c, 0x00, 0x9f, 0x00,
+				     0xd6);
+	s6e63m0_dcs_write_seq_static(ctx, MCS_GAMMA_CTRL,
+				     0x01);
+
+	s6e63m0_dcs_write_seq_static(ctx, MCS_ETC_CONDITION,
+				     0x00, 0x8c, 0x07);
+	s6e63m0_dcs_write_seq_static(ctx, 0xb3,
+				     0xc);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xb5,
+				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
+				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
+				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
+				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
+				     0x21, 0x20, 0x1e, 0x1e);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xb6,
+				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
+				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
+				     0x66, 0x66);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xb7,
+				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
+				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
+				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
+				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
+				     0x21, 0x20, 0x1e, 0x1e, 0x00, 0x00, 0x11,
+				     0x22, 0x33, 0x44, 0x44, 0x44, 0x55, 0x55,
+				     0x66, 0x66, 0x66, 0x66, 0x66, 0x66);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xb9,
+				     0x2c, 0x12, 0x0c, 0x0a, 0x10, 0x0e, 0x17,
+				     0x13, 0x1f, 0x1a, 0x2a, 0x24, 0x1f, 0x1b,
+				     0x1a, 0x17, 0x2b, 0x26, 0x22, 0x20, 0x3a,
+				     0x34, 0x30, 0x2c, 0x29, 0x26, 0x25, 0x23,
+				     0x21, 0x20, 0x1e, 0x1e);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xba,
+				     0x00, 0x00, 0x11, 0x22, 0x33, 0x44, 0x44,
+				     0x44, 0x55, 0x55, 0x66, 0x66, 0x66, 0x66,
+				     0x66, 0x66);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xc1,
+				     0x4d, 0x96, 0x1d, 0x00, 0x00, 0x01, 0xdf,
+				     0x00, 0x00, 0x03, 0x1f, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x06,
+				     0x09, 0x0d, 0x0f, 0x12, 0x15, 0x18);
+
+	s6e63m0_dcs_write_seq_static(ctx, 0xb2,
+				     0x10, 0x10, 0x0b, 0x05);
+
+	s6e63m0_dcs_write_seq_static(ctx, MCS_ACL_CTRL,
+				     0x01);
+
+	s6e63m0_dcs_write_seq_static(ctx, MCS_ELVSS_ON,
+				     0x0b);
+
+	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_EXIT_SLEEP_MODE);
+}
+
+static int s6e63m0_power_on(struct s6e63m0 *ctx)
+{
+	int ret;
+
+	gpiod_set_value(ctx->reset_gpio, 0);
+	msleep(120);
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	msleep(25);
+
+	return 0;
+}
+
+static int s6e63m0_power_off(struct s6e63m0 *ctx)
+{
+	int ret;
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		return ret;
+
+	gpiod_set_value(ctx->reset_gpio, 1);
+	msleep(120);
+
+	return 0;
+}
+
+static int s6e63m0_disable(struct drm_panel *panel)
+{
+	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
+
+	if (!ctx->enabled)
+		return 0;
+
+	backlight_disable(ctx->bl_dev);
+
+	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_ENTER_SLEEP_MODE);
+	msleep(200);
+
+	ctx->enabled = false;
+
+	return 0;
+}
+
+static int s6e63m0_unprepare(struct drm_panel *panel)
+{
+	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
+	int ret;
+
+	if (!ctx->prepared)
+		return 0;
+
+	s6e63m0_clear_error(ctx);
+
+	ret = s6e63m0_power_off(ctx);
+	if (ret < 0)
+		return ret;
+
+	ctx->prepared = false;
+
+	return 0;
+}
+
+static int s6e63m0_prepare(struct drm_panel *panel)
+{
+	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	ret = s6e63m0_power_on(ctx);
+	if (ret < 0)
+		return ret;
+
+	s6e63m0_init(ctx);
+
+	ret = s6e63m0_clear_error(ctx);
+
+	if (ret < 0)
+		s6e63m0_unprepare(panel);
+
+	ctx->prepared = true;
+
+	return ret;
+}
+
+static int s6e63m0_enable(struct drm_panel *panel)
+{
+	struct s6e63m0 *ctx = panel_to_s6e63m0(panel);
+
+	if (ctx->enabled)
+		return 0;
+
+	s6e63m0_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_ON);
+
+	backlight_enable(ctx->bl_dev);
+
+	ctx->enabled = true;
+
+	return 0;
+}
+
+static int s6e63m0_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &default_mode);
+	if (!mode) {
+		DRM_ERROR("failed to add mode %ux%ux@%u\n",
+			  default_mode.hdisplay, default_mode.vdisplay,
+			  default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs s6e63m0_drm_funcs = {
+	.disable	= s6e63m0_disable,
+	.unprepare	= s6e63m0_unprepare,
+	.prepare	= s6e63m0_prepare,
+	.enable		= s6e63m0_enable,
+	.get_modes	= s6e63m0_get_modes,
+};
+
+static int s6e63m0_set_brightness(struct backlight_device *bd)
+{
+	struct s6e63m0 *ctx = bl_get_data(bd);
+
+	s6e63m0_brightness_set(ctx);
+
+	return s6e63m0_clear_error(ctx);
+}
+
+static const struct backlight_ops s6e63m0_backlight_ops = {
+	.update_status	= s6e63m0_set_brightness,
+};
+
+static void s6e63m0_backlight_register(struct s6e63m0 *ctx)
+{
+	struct backlight_properties props = {
+		.type		= BACKLIGHT_RAW,
+		.brightness	= MAX_BRIGHTNESS,
+		.max_brightness = MAX_BRIGHTNESS
+	};
+	struct device *dev = ctx->dev;
+
+	ctx->bl_dev = devm_backlight_device_register(dev, "panel", dev, ctx,
+						     &s6e63m0_backlight_ops,
+						     &props);
+	if (IS_ERR(ctx->bl_dev))
+		DRM_DEV_ERROR(dev, "error registering backlight device (%ld)\n",
+			      PTR_ERR(ctx->bl_dev));
+}
+
+static int s6e63m0_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct s6e63m0 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(struct s6e63m0), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, ctx);
+
+	ctx->dev = dev;
+	ctx->enabled = false;
+	ctx->prepared = false;
+
+	ctx->supplies[0].supply = "vdd3";
+	ctx->supplies[1].supply = "vci";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio)) {
+		DRM_DEV_ERROR(dev, "cannot get reset-gpios %ld\n",
+			      PTR_ERR(ctx->reset_gpio));
+		return PTR_ERR(ctx->reset_gpio);
+	}
+
+	spi->bits_per_word = 9;
+	spi->mode = SPI_MODE_3;
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "spi setup failed.\n");
+		return ret;
+	}
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = dev;
+	ctx->panel.funcs = &s6e63m0_drm_funcs;
+
+	ret = drm_panel_add(&ctx->panel);
+	if (ret < 0)
+		return ret;
+
+	s6e63m0_backlight_register(ctx);
+
+	return 0;
+}
+
+static int s6e63m0_remove(struct spi_device *spi)
+{
+	struct s6e63m0 *ctx = spi_get_drvdata(spi);
+
+	drm_panel_remove(&ctx->panel);
+
+	return 0;
+}
+
+static const struct of_device_id s6e63m0_of_match[] = {
+	{ .compatible = "samsung,s6e63m0" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s6e63m0_of_match);
+
+static struct spi_driver s6e63m0_driver = {
+	.probe			= s6e63m0_probe,
+	.remove			= s6e63m0_remove,
+	.driver			= {
+		.name		= "panel-samsung-s6e63m0",
+		.of_match_table = s6e63m0_of_match,
+	},
+};
+module_spi_driver(s6e63m0_driver);
+
+MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
+MODULE_DESCRIPTION("s6e63m0 LCD Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

