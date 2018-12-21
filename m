Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE2FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B9B21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeyA6+yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391002AbeLUPV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:26 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46364 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390963AbeLUPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so4147827lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9okQAdEYSfawGP6mjgyyFINRwiA/ib6Xkeki24nmJg=;
        b=EeyA6+yDmgZ1SwNBwdBXl+2iF/ci0C1C3wJUvap/ilJFgjRTjOdBVzv74UyR6j+mVG
         YJrjXPTVtkw1VR0lIRYH5YdZKMzdpnGLo+Ke7bCuqAHCeofGo6qsI7jAouBwn4Pw4OYT
         Gpd/Bg0os72GzP7HtYnWLVwfu5AY3atSq+NAagM85NLNBQxo3Rxjp4mSQUvznhA/wAx4
         H3S5LS8q3mntPdOFoK1hHGok0QlATG2VvJpA65Ro2whYeRHJGVDQWVwNOwMM9bctZygc
         k6mj8ImnMUQ8p64pfoGcW57BpomJy2LkKELEKYC3h1dmcuZECgLi+S682jHCzZBq6xl4
         WSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9okQAdEYSfawGP6mjgyyFINRwiA/ib6Xkeki24nmJg=;
        b=UCOh5FLbgOi3lKFaSmb8OkIJ01i29oyYHsSs7D0yeFDcMpuPBMXP65f5NEA9FaDm4J
         IIgAqN9gRTAK8mAfxXA7nd9JVo/JUY2fFJNOpQTuCoTaKHRNdx7VSGERx55amzbSfmDT
         xFUpxZxmhIxBahyy2udPXO3w1h+bizxhxVRJFMGByGOJnvAf0e0rXKUVw8Vc+ieEdjV8
         X4kU5Ep+pLTD/oA6iyXTXO/dYqzcXAry1A2LsePsG1056z5kLUs9wDj6kS0aHOOdIRqE
         V/giIRWZBJ5qLIniax0GD2ZJanRINXb3naCoNQJhOVwzbT1Cd9/2QWXhJz/q7xxZNGm/
         9hBw==
X-Gm-Message-State: AA+aEWYihDDF+XKd/n4yTZ7W8NfD2O/basjZErNx/wgoX9Lf9y9VcRaB
        hWRBG43n5gCvhSxscCQwbWY=
X-Google-Smtp-Source: AFSGD/UB/wijVcMwWO3MB5YENS32w5qTsss2q8IWRnWuSl4WWq6kQAUBqIrgS7uxe2ET10bhHUrWtQ==
X-Received: by 2002:a19:54d7:: with SMTP id b84mr1598745lfl.131.1545405678851;
        Fri, 21 Dec 2018 07:21:18 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:18 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 5/9] ASoC: sun4i-i2s: Correct divider calculations
Date:   Fri, 21 Dec 2018 16:21:06 +0100
Message-Id: <20181221152110.17982-6-codekipper@gmail.com>
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

The clock division circuitry is different on the H3 and later SoCs.
The division of bclk is now based on pll2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 82 +++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 93a484d7e228..b31f84787218 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -129,10 +129,10 @@
  * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
  * @reg_offset_txdata: offset of the tx fifo.
  * @sun4i_i2s_regmap: regmap config to use.
- * @mclk_offset: Value by which mclkdiv needs to be adjusted.
- * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  * @fmt_offset: Value by which wss and sr needs to be adjusted.
  * @field_clkdiv_mclk_en: regmap field to enable mclk output.
+ * @field_clkdiv_mclk: regmap field for mclkdiv.
+ * @field_clkdiv_bclk: regmap field for bclkdiv.
  * @field_fmt_wss: regmap field to set word select size.
  * @field_fmt_sr: regmap field to set sample resolution.
  * @field_fmt_bclk: regmap field to set clk polarity.
@@ -153,8 +153,6 @@ struct sun4i_i2s_quirks {
 	bool				has_chsel_offset;
 	unsigned int			reg_offset_txdata;	/* TX FIFO */
 	const struct regmap_config	*sun4i_i2s_regmap;
-	unsigned int			mclk_offset;
-	unsigned int			bclk_offset;
 	unsigned int			fmt_offset;
 
 	/* Register fields for i2s */
@@ -210,7 +208,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
 	{ .div = 8, .val = 3 },
 	{ .div = 12, .val = 4 },
 	{ .div = 16, .val = 5 },
-	/* TODO - extend divide ratio supported by newer SoCs */
+};
+
+static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] = {
+	{ .div = 0, .val = 0 },
+	{ .div = 1, .val = 1 },
+	{ .div = 2, .val = 2 },
+	{ .div = 4, .val = 3 },
+	{ .div = 6, .val = 4 },
+	{ .div = 8, .val = 5 },
+	{ .div = 12, .val = 6 },
+	{ .div = 16, .val = 7 },
+	{ .div = 24, .val = 8 },
+	{ .div = 32, .val = 9 },
+	{ .div = 48, .val = 10 },
+	{ .div = 64, .val = 11 },
+	{ .div = 96, .val = 12 },
+	{ .div = 128, .val = 13 },
+	{ .div = 176, .val = 14 },
+	{ .div = 192, .val = 15 },
 };
 
 static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
@@ -222,21 +238,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 	{ .div = 12, .val = 5 },
 	{ .div = 16, .val = 6 },
 	{ .div = 24, .val = 7 },
-	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned int oversample_rate,
-				  unsigned int word_size)
+				  unsigned int word_size,
+				  const struct sun4i_i2s_clk_div *bdiv,
+				  unsigned int size)
 {
 	int div = oversample_rate / word_size / 2;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
-		const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
-
+	for (i = 0; i < size; i++) {
 		if (bdiv->div == div)
 			return bdiv->val;
+		bdiv++;
 	}
 
 	return -EINVAL;
@@ -245,16 +261,17 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
 				  unsigned int oversample_rate,
 				  unsigned int module_rate,
-				  unsigned int sampling_rate)
+				  unsigned int sampling_rate,
+				  const struct sun4i_i2s_clk_div *mdiv,
+				  unsigned int size)
 {
 	int div = module_rate / sampling_rate / oversample_rate;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
-		const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
-
+	for (i = 0; i < size; i++) {
 		if (mdiv->div == div)
 			return mdiv->val;
+		mdiv++;
 	}
 
 	return -EINVAL;
@@ -319,24 +336,39 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-					  word_size);
+	if (i2s->variant->has_fmt_set_lrck_period)
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
+						  word_size,
+						  sun8i_i2s_clk_div,
+						  ARRAY_SIZE(sun8i_i2s_clk_div));
+	else
+		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+						  word_size,
+						  sun4i_i2s_bclk_div,
+						  ARRAY_SIZE(sun4i_i2s_bclk_div));
 	if (bclk_div < 0) {
-		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
+		dev_err(dai->dev, "Unsupported BCLK divider: %d\n",
+			bclk_div);
 		return -EINVAL;
 	}
 
-	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-					  clk_rate, rate);
+
+	if (i2s->variant->has_fmt_set_lrck_period)
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate,
+						  sun8i_i2s_clk_div,
+						  ARRAY_SIZE(sun8i_i2s_clk_div));
+	else
+		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+						  clk_rate, rate,
+						  sun4i_i2s_mclk_div,
+						  ARRAY_SIZE(sun4i_i2s_mclk_div));
 	if (mclk_div < 0) {
-		dev_err(dai->dev, "Unsupported MCLK divider: %d\n", mclk_div);
+		dev_err(dai->dev, "Unsupported MCLK divider: %d\n",
+			mclk_div);
 		return -EINVAL;
 	}
 
-	/* Adjust the clock division values if needed */
-	bclk_div += i2s->variant->bclk_offset;
-	mclk_div += i2s->variant->mclk_offset;
-
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
 		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div));
@@ -955,8 +987,6 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.has_reset		= true,
 	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
 	.sun4i_i2s_regmap	= &sun8i_i2s_regmap_config,
-	.mclk_offset		= 1,
-	.bclk_offset		= 2,
 	.fmt_offset		= 3,
 	.has_fmt_set_lrck_period = true,
 	.has_chcfg		= true,
-- 
2.20.1

