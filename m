Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5307AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1589B217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Js1Zha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbeLUPW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:22:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32845 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390969AbeLUPVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so5079482ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YO4CeGln0tXYn1nCL2HnWXHfIVIdma6kfCZR3YsTlCA=;
        b=n8Js1ZhaCTlVzS2/ZLWrpbC5r7or7fEoj8Yp0xbzQZq9XSB3mlZNmBnGKJ+9+QhLIs
         PGqdVl+1UHg1nTRyNtcxR6qvUuhuBgln/agKDjUHfS6cMS/ChRTbTajk1QYYwKEEMcwA
         3eXiwLknJtBAzkfribgp7ZNo7FWPp25HaROqJ7WCCnUZbj/a0GYFwcEArsnnH09absrQ
         D4Sq3VkeZn3hJvBF+hAM7zwUEKiaVQJ6I0RHfl2BV8A8xGNDEvXX7GwxCy7a/J2eoV7D
         NPSbdF+FKZTeE6LVrcndFfKd1faWl/jjfoAwEo2USK35fheoSTWJvy70x5bLhFKN6q6O
         dXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YO4CeGln0tXYn1nCL2HnWXHfIVIdma6kfCZR3YsTlCA=;
        b=jD348gAD4m9NdE76RZ+i5LvTDYV4C9z6c1AmowVOZ5wYzKesYnYmKGc6W0bAo/5agJ
         b5BnrWUqXV/jBuA0cM03t5Bwap3O5Z0ykFA9/BoeXZoqwAKonop5REFHbJiSgIeMz3r4
         +gDCNIn51uEjzmtYpFOcph7cM5X5fR5n3QSvnpEO+nSwBJjGppZ0ll3YGLJSlOhNy+Wi
         Towte+j+lQOTRSDgB6RgPuvtGTYXPX1K0Y4ELu++Q4D/XsaopxMQmslBP03YTDqn+V8p
         46+2K/Ky2vFavwUqvf5R1RXoLKnOGCUJ5mP5YvhhLC1yvYK7UBhfYA4K9qGHEqKayZc6
         cIjA==
X-Gm-Message-State: AJcUukdF3hDn1nn6pGs8LM1+ZHREA3/J3KH2CdFJG6isMRRGNIS89M0g
        cM62OCRyuB5GzEu5RB0SHjg=
X-Google-Smtp-Source: ALg8bN4z/X7VrVOMuBNvI8ciYDEa/SZnf7tfwDqEUSLO8ASNF6ROkO19nRVwQkBUp6NU82630E7WPg==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr1801460ljk.109.1545405680201;
        Fri, 21 Dec 2018 07:21:20 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:19 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Date:   Fri, 21 Dec 2018 16:21:07 +0100
Message-Id: <20181221152110.17982-7-codekipper@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181221152110.17982-1-codekipper@gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

The i2s block supports multi-lane i2s output however this functionality
is only possible in earlier SoCs where the pins are exposed and for
the i2s block used for HDMI audio on the later SoCs.

To enable this functionality, an optional property has been added to
the bindings.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index b31f84787218..e85789d84c0c 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -27,7 +27,7 @@
 
 #define SUN4I_I2S_CTRL_REG		0x00
 #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
-#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + (sdo))
+#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) << 8)
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
 #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
 #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
@@ -394,14 +394,23 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	int sr, wss, channels;
 	u32 width;
+	int lines;
 
 	channels = params_channels(params);
-	if (channels != 2) {
+	if ((channels > dai->driver->playback.channels_max) ||
+		(channels < dai->driver->playback.channels_min)) {
 		dev_err(dai->dev, "Unsupported number of channels: %d\n",
 			channels);
 		return -EINVAL;
 	}
 
+	lines = (channels + 1) / 2;
+
+	/* Enable the required output lines */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN4I_I2S_CTRL_SDO_EN_MASK,
+			   SUN4I_I2S_CTRL_SDO_EN(lines));
+
 	if (i2s->variant->has_chcfg) {
 		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
 				   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
@@ -412,8 +421,19 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Map the channels for playback and capture */
-	regmap_field_write(i2s->field_txchanmap, 0x76543210);
 	regmap_field_write(i2s->field_rxchanmap, 0x00003210);
+	regmap_field_write(i2s->field_txchanmap, 0x10);
+	if (i2s->variant->has_chsel_tx_chen) {
+		if (channels > 2)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+4, 0x32);
+		if (channels > 4)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+8, 0x54);
+		if (channels > 6)
+			regmap_write(i2s->regmap,
+				     SUN8I_I2S_TX_CHAN_MAP_REG+12, 0x76);
+	}
 
 	/* Configure the channels */
 	regmap_field_write(i2s->field_txchansel,
@@ -1094,9 +1114,10 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
+	struct snd_soc_dai_driver *soc_dai;
 	struct resource *res;
 	void __iomem *regs;
-	int irq, ret;
+	int irq, ret, val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1175,6 +1196,12 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		soc_dai->capture.formats = SUN8I_FORMATS;
 	}
 
+	if (!of_property_read_u32(pdev->dev.of_node,
+				  "allwinner,playback-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			soc_dai->playback.channels_max = val;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
@@ -1184,7 +1211,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+					      soc_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
-- 
2.20.1

