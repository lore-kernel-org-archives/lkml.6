Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35648C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F69218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhGUDe8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfAaT1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35443 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfAaT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so3714502ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/Pt+HtUozx+9QMt6Rr3VaNIFQgfWtVo+mrMkt7RTBA=;
        b=hhGUDe8RAEHLFG+PQzlNwfGWQcvetDCBV+AzqVkzCSyAog/bjmfRxb4m6TIbPkQvz+
         0IULzAnIzmkyY8kZbjDkqR6/QAOfdjcMwjHHJugr+DEJX2uqYeWEwaYesWR21fOdYYg6
         HwHo7Z0zwrwIRFwHtskCqG2vLNdhqhLKoamIy3M9LIg5mgGFDaVkXqIZsMsN2UcFeYDZ
         aMDdiVM+Y/C9694QN2qC6yOFnm11dKvELxH7xdWMphlcWydGt+uLixQqMPjnKYMH5uhU
         x73eJoW/urq5/WWA3Too5CPxbcCbc18FKkIzFVLMh8iwILJHE+B7nLsH3zWCHejL5KSo
         9c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=M/Pt+HtUozx+9QMt6Rr3VaNIFQgfWtVo+mrMkt7RTBA=;
        b=P5PJ+uLqGUSAbmxTOcreSiaAqK9Ib/a6xSI/TEXpw08k4U26rLtrI4LN8cA55gHsvu
         5CuvZa1DTFtAhCMcVX7y4GynhuOm4d3zF/ffiSUNiogpyNYG4vAiciuulXyjQSaWqKZR
         xei0OrfspKfcR0CszgfhGLc+Xc+yKuCilJSMvvo2s+KW/7F2jS8Ligm4hOKRbRKQUBZF
         jpf1jvvoUUjNZg0aYByViiTK8VTjxDbUGYXnfY1JTIdWBR1Cgf1p/K575zGnVXleFLwH
         2RvUureoysQYFjdQLIuR6/uBbkEmMkpemxkifsTV+xmcvQS8LQykh2ytVhufvKzTcJdv
         5tIg==
X-Gm-Message-State: AJcUukf+wjp8B//3H1S3OnsncXWD4Tb56+yQZYFX3a06NqZ8OcE/zriv
        J7+bDItRdRq8qMPJq45vuqA=
X-Google-Smtp-Source: ALg8bN645wEofveUKxNhQo9U/P7WZ2KMFIjiOQ69Q301ODGUYib0TCmAxdSpXb2qYVWTqd9s/GhzAQ==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr25804389ljj.49.1548962801392;
        Thu, 31 Jan 2019 11:26:41 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:40 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 07/19] drm/panel: ilitek: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:07 +0100
Message-Id: <20190131192619.9763-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c  | 93 +++++++++++++++------------
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 14 ++--
 2 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 1ee8b2ccf718..e5e60347d3cf 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -302,7 +302,7 @@ static int ili9322_regmap_spi_write(void *context, const void *data,
 	memcpy(buf, data, 2);
 	buf[0] &= ~0x80;
 
-	dev_dbg(dev, "WRITE: %02x %02x\n", buf[0], buf[1]);
+	DRM_DEV_DEBUG(dev, "WRITE: %02x %02x\n", buf[0], buf[1]);
 	return spi_write_then_read(spi, buf, 2, NULL, 0);
 }
 
@@ -315,8 +315,8 @@ static int ili9322_regmap_spi_read(void *context, const void *reg,
 
 	/* Set bit 7 to 1 to read */
 	memcpy(buf, reg, 1);
-	dev_dbg(dev, "READ: %02x reg size = %zu, val size = %zu\n",
-		buf[0], reg_size, val_size);
+	DRM_DEV_DEBUG(dev, "READ: %02x reg size = %zu, val size = %zu\n",
+		      buf[0], reg_size, val_size);
 	buf[0] |= 0x80;
 
 	return spi_write_then_read(spi, buf, 1, val, 1);
@@ -362,7 +362,7 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 	ret = regmap_write(ili->regmap, ILI9322_GLOBAL_RESET,
 			   ILI9322_GLOBAL_RESET_ASSERT);
 	if (ret) {
-		dev_err(ili->dev, "can't issue GRESET (%d)\n", ret);
+		DRM_DEV_ERROR(ili->dev, "can't issue GRESET (%d)\n", ret);
 		return ret;
 	}
 
@@ -371,7 +371,8 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 		ret = regmap_write(ili->regmap, ILI9322_VREG1_VOLTAGE,
 				   ili->vreg1out);
 		if (ret) {
-			dev_err(ili->dev, "can't set up VREG1OUT (%d)\n", ret);
+			DRM_DEV_ERROR(ili->dev,
+				      "can't set up VREG1OUT (%d)\n", ret);
 			return ret;
 		}
 	}
@@ -380,8 +381,9 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 		ret = regmap_write(ili->regmap, ILI9322_VCOM_AMP,
 				   ili->vcom_amplitude);
 		if (ret) {
-			dev_err(ili->dev,
-				"can't set up VCOM amplitude (%d)\n", ret);
+			DRM_DEV_ERROR(ili->dev,
+				      "can't set up VCOM amplitude (%d)\n",
+				      ret);
 			return ret;
 		}
 	};
@@ -390,7 +392,8 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 		ret = regmap_write(ili->regmap, ILI9322_VCOM_HIGH,
 				   ili->vcom_high);
 		if (ret) {
-			dev_err(ili->dev, "can't set up VCOM high (%d)\n", ret);
+			DRM_DEV_ERROR(ili->dev,
+				      "can't set up VCOM high (%d)\n", ret);
 			return ret;
 		}
 	};
@@ -400,9 +403,9 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 		ret = regmap_write(ili->regmap, ILI9322_GAMMA_1 + i,
 				   ili->gamma[i]);
 		if (ret) {
-			dev_err(ili->dev,
-				"can't write gamma V%d to 0x%02x (%d)\n",
-				i + 1, ILI9322_GAMMA_1 + i, ret);
+			DRM_DEV_ERROR(ili->dev,
+				      "can't write gamma V%d to 0x%02x (%d)\n",
+				      i + 1, ILI9322_GAMMA_1 + i, ret);
 			return ret;
 		}
 	}
@@ -434,7 +437,8 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 		reg |= ILI9322_POL_VSYNC;
 	ret = regmap_write(ili->regmap, ILI9322_POL, reg);
 	if (ret) {
-		dev_err(ili->dev, "can't write POL register (%d)\n", ret);
+		DRM_DEV_ERROR(ili->dev,
+			      "can't write POL register (%d)\n", ret);
 		return ret;
 	}
 
@@ -446,7 +450,8 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 	reg |= ILI9322_IF_CTRL_LINE_INVERSION;
 	ret = regmap_write(ili->regmap, ILI9322_IF_CTRL, reg);
 	if (ret) {
-		dev_err(ili->dev, "can't write IF CTRL register (%d)\n", ret);
+		DRM_DEV_ERROR(ili->dev,
+			      "can't write IF CTRL register (%d)\n", ret);
 		return ret;
 	}
 
@@ -460,14 +465,14 @@ static int ili9322_init(struct drm_panel *panel, struct ili9322 *ili)
 	reg |= ILI9322_ENTRY_AUTODETECT;
 	ret = regmap_write(ili->regmap, ILI9322_ENTRY, reg);
 	if (ret) {
-		dev_err(ili->dev, "can't write ENTRY reg (%d)\n", ret);
+		DRM_DEV_ERROR(ili->dev, "can't write ENTRY reg (%d)\n", ret);
 		return ret;
 	}
-	dev_info(ili->dev, "display is in %s mode, syncmode %02x\n",
-		 ili9322_inputs[ili->input],
+	DRM_DEV_INFO(ili->dev, "display is in %s mode, syncmode %02x\n",
+		     ili9322_inputs[ili->input],
 		 ili->conf->syncmode);
 
-	dev_info(ili->dev, "initialized display\n");
+	DRM_DEV_INFO(ili->dev, "initialized display\n");
 
 	return 0;
 }
@@ -484,7 +489,7 @@ static int ili9322_power_on(struct ili9322 *ili)
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ili->supplies), ili->supplies);
 	if (ret < 0) {
-		dev_err(ili->dev, "unable to enable regulators\n");
+		DRM_DEV_ERROR(ili->dev, "unable to enable regulators\n");
 		return ret;
 	}
 	msleep(20);
@@ -510,7 +515,7 @@ static int ili9322_disable(struct drm_panel *panel)
 	ret = regmap_write(ili->regmap, ILI9322_POW_CTRL,
 			   ILI9322_POW_CTRL_STANDBY);
 	if (ret) {
-		dev_err(ili->dev, "unable to go to standby mode\n");
+		DRM_DEV_ERROR(ili->dev, "unable to go to standby mode\n");
 		return ret;
 	}
 
@@ -548,7 +553,7 @@ static int ili9322_enable(struct drm_panel *panel)
 	ret = regmap_write(ili->regmap, ILI9322_POW_CTRL,
 			   ILI9322_POW_CTRL_DEFAULT);
 	if (ret) {
-		dev_err(ili->dev, "unable to enable panel\n");
+		DRM_DEV_ERROR(ili->dev, "unable to enable panel\n");
 		return ret;
 	}
 
@@ -756,7 +761,7 @@ static int ili9322_probe(struct spi_device *spi)
 	 */
 	ili->conf = of_device_get_match_data(dev);
 	if (!ili->conf) {
-		dev_err(dev, "missing device configuration\n");
+		DRM_DEV_ERROR(dev, "missing device configuration\n");
 		return -ENODEV;
 	}
 
@@ -766,20 +771,21 @@ static int ili9322_probe(struct spi_device *spi)
 		ili->vreg1out = U8_MAX;
 	} else {
 		if (val < 3600) {
-			dev_err(dev, "too low VREG1OUT\n");
+			DRM_DEV_ERROR(dev, "too low VREG1OUT\n");
 			return -EINVAL;
 		}
 		if (val > 6000) {
-			dev_err(dev, "too high VREG1OUT\n");
+			DRM_DEV_ERROR(dev, "too high VREG1OUT\n");
 			return -EINVAL;
 		}
 		if ((val % 100) != 0) {
-			dev_err(dev, "VREG1OUT is no even 100 microvolt\n");
+			DRM_DEV_ERROR(dev,
+				      "VREG1OUT is no even 100 microvolt\n");
 			return -EINVAL;
 		}
 		val -= 3600;
 		val /= 100;
-		dev_dbg(dev, "VREG1OUT = 0x%02x\n", val);
+		DRM_DEV_DEBUG(dev, "VREG1OUT = 0x%02x\n", val);
 		ili->vreg1out = val;
 	}
 
@@ -789,15 +795,15 @@ static int ili9322_probe(struct spi_device *spi)
 		ili->vcom_high = U8_MAX;
 	} else {
 		if (val < 37) {
-			dev_err(dev, "too low VCOM high\n");
+			DRM_DEV_ERROR(dev, "too low VCOM high\n");
 			return -EINVAL;
 		}
 		if (val > 100) {
-			dev_err(dev, "too high VCOM high\n");
+			DRM_DEV_ERROR(dev, "too high VCOM high\n");
 			return -EINVAL;
 		}
 		val -= 37;
-		dev_dbg(dev, "VCOM high = 0x%02x\n", val);
+		DRM_DEV_DEBUG(dev, "VCOM high = 0x%02x\n", val);
 		ili->vcom_high = val;
 	}
 
@@ -807,34 +813,38 @@ static int ili9322_probe(struct spi_device *spi)
 		ili->vcom_high = U8_MAX;
 	} else {
 		if (val < 70) {
-			dev_err(dev, "too low VCOM amplitude\n");
+			DRM_DEV_ERROR(dev, "too low VCOM amplitude\n");
 			return -EINVAL;
 		}
 		if (val > 132) {
-			dev_err(dev, "too high VCOM amplitude\n");
+			DRM_DEV_ERROR(dev, "too high VCOM amplitude\n");
 			return -EINVAL;
 		}
 		val -= 70;
 		val >>= 1; /* Increments of 2% */
-		dev_dbg(dev, "VCOM amplitude = 0x%02x\n", val);
+		DRM_DEV_DEBUG(dev, "VCOM amplitude = 0x%02x\n", val);
 		ili->vcom_amplitude = val;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ili->gamma); i++) {
 		val = ili->conf->gamma_corr_neg[i];
 		if (val > 15) {
-			dev_err(dev, "negative gamma %u > 15, capping\n", val);
+			DRM_DEV_ERROR(dev,
+				      "negative gamma %u > 15, capping\n",
+				      val);
 			val = 15;
 		}
 		gamma = val << 4;
 		val = ili->conf->gamma_corr_pos[i];
 		if (val > 15) {
-			dev_err(dev, "positive gamma %u > 15, capping\n", val);
+			DRM_DEV_ERROR(dev,
+				      "positive gamma %u > 15, capping\n",
+				      val);
 			val = 15;
 		}
 		gamma |= val;
 		ili->gamma[i] = gamma;
-		dev_dbg(dev, "gamma V%d: 0x%02x\n", i + 1, gamma);
+		DRM_DEV_DEBUG(dev, "gamma V%d: 0x%02x\n", i + 1, gamma);
 	}
 
 	ili->supplies[0].supply = "vcc"; /* 2.7-3.6 V */
@@ -859,32 +869,32 @@ static int ili9322_probe(struct spi_device *spi)
 
 	ili->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ili->reset_gpio)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
+		DRM_DEV_ERROR(dev, "failed to get RESET GPIO\n");
 		return PTR_ERR(ili->reset_gpio);
 	}
 
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
 	if (ret < 0) {
-		dev_err(dev, "spi setup failed.\n");
+		DRM_DEV_ERROR(dev, "spi setup failed.\n");
 		return ret;
 	}
 	regmap_config = &ili9322_regmap_config;
 	ili->regmap = devm_regmap_init(dev, &ili9322_regmap_bus, dev,
 				       regmap_config);
 	if (IS_ERR(ili->regmap)) {
-		dev_err(dev, "failed to allocate register map\n");
+		DRM_DEV_ERROR(dev, "failed to allocate register map\n");
 		return PTR_ERR(ili->regmap);
 	}
 
 	ret = regmap_read(ili->regmap, ILI9322_CHIP_ID, &val);
 	if (ret) {
-		dev_err(dev, "can't get chip ID (%d)\n", ret);
+		DRM_DEV_ERROR(dev, "can't get chip ID (%d)\n", ret);
 		return ret;
 	}
 	if (val != ILI9322_CHIP_ID_MAGIC) {
-		dev_err(dev, "chip ID 0x%0x2, expected 0x%02x\n", val,
-			ILI9322_CHIP_ID_MAGIC);
+		DRM_DEV_ERROR(dev, "chip ID 0x%0x2, expected 0x%02x\n", val,
+			      ILI9322_CHIP_ID_MAGIC);
 		return -ENODEV;
 	}
 
@@ -892,7 +902,8 @@ static int ili9322_probe(struct spi_device *spi)
 	if (ili->conf->input == ILI9322_INPUT_UNKNOWN) {
 		ret = regmap_read(ili->regmap, ILI9322_ENTRY, &val);
 		if (ret) {
-			dev_err(dev, "can't get entry setting (%d)\n", ret);
+			DRM_DEV_ERROR(dev,
+				      "can't get entry setting (%d)\n", ret);
 			return ret;
 		}
 		/* Input enum corresponds to HW setting */
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 3ad4a46c4e94..f72059578c74 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -18,6 +18,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
@@ -395,10 +396,11 @@ static int ili9881c_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &bananapi_default_mode);
 	if (!mode) {
-		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
-			bananapi_default_mode.hdisplay,
-			bananapi_default_mode.vdisplay,
-			bananapi_default_mode.vrefresh);
+		DRM_DEV_ERROR(&ctx->dsi->dev,
+			      "failed to add mode %ux%ux@%u\n",
+			      bananapi_default_mode.hdisplay,
+			      bananapi_default_mode.vdisplay,
+			      bananapi_default_mode.vrefresh);
 		return -ENOMEM;
 	}
 
@@ -439,13 +441,13 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 
 	ctx->power = devm_regulator_get(&dsi->dev, "power");
 	if (IS_ERR(ctx->power)) {
-		dev_err(&dsi->dev, "Couldn't get our power regulator\n");
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our power regulator\n");
 		return PTR_ERR(ctx->power);
 	}
 
 	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset)) {
-		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our reset GPIO\n");
 		return PTR_ERR(ctx->reset);
 	}
 
-- 
2.12.0

