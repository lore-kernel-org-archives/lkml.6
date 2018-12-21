Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3D21939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhI73Ffe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbeLUPXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:23:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34343 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeLUPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so5070311lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9DJPsrcLc6oh7vQnwaHi4ETgHtWCJup4CIGYGOLEJw=;
        b=RhI73FfecY10i517z4dn4KZIR//252tKpnd/MBq6T4GukITBKlLPF8OeXjSEqh5ugu
         rHk1eJXGaoyDulW47ccEKBN6p6LIGeyQt3iBVPi8yhNdLs4wjyqEMcKxO2b+xD4VwxKG
         DDNevi04KuZlzGqheDRHYESMPQcB5o5NEQ2yIR/8nGRoL2/eZWaXdlXGbfpp7qJ4o2MU
         mfA0hi4qrF42VKk82vwH0j5xR/wyy4PgR2m1+qlU7vNDVsNX8q+wKDyBxS36oBDe4BDX
         YCDAtrm1uS8yaYv7KEjGeruoNaXF7OuubP2GFnQcxRxUeOBqUm7WBaEDf5Vnm74St7Q3
         5kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9DJPsrcLc6oh7vQnwaHi4ETgHtWCJup4CIGYGOLEJw=;
        b=akPJmL8WnmZQv/uzsaxQxPGqBG1/ogEh3lFYTBfLjH0ZugB1U4dRC41gvJ/fsy1mKz
         CLx4CxS5R5js1YVcrz7wm14caGDOaN1n6r66V0f8k4e22hQbbGbXTjscG2d4p/bpgBIf
         orZtIjveFJsvdtF3aJP8kVyMsorqFnYSULep8CuVczIzMi2HripDMj9jv2BtlajMyuEU
         RLKiI+KT1EeHuCAUz3W9SqXwHVuA+Gy3C++U0mw8GU+nJb72HG/MvKzLwVm39FtxI1Yi
         CE9wz3gk+14EEE2ZehZuCK85e+0YPQCCCPe2vA99Uf2bCctyBUFhxNToZxOfyg/bjArp
         0XLw==
X-Gm-Message-State: AA+aEWbeL0jo/POX/zuo3Yy9P0xA2rlFZa6QfVelN7iGEpkQbmw/eNbB
        gA9slFGA5OoDP8j2nkKq/6c=
X-Google-Smtp-Source: ALg8bN55Pr2b7hOgI+w4rFgqkX2o4BxYYUtrOUK+qjOIGxWIgG4EwqTrg0zBy+JmTZjy1wE3KuKo8w==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr1934020ljc.172.1545405675172;
        Fri, 21 Dec 2018 07:21:15 -0800 (PST)
Received: from localhost.localdomain (c90-142-43-138.bredband.comhem.se. [90.142.43.138])
        by smtp.gmail.com with ESMTPSA id q30sm5005601lfi.94.2018.12.21.07.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:21:14 -0800 (PST)
From:   codekipper@gmail.com
To:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com
Cc:     linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it,
        Marcus Cooper <codekipper@gmail.com>
Subject: [PATCH v3 2/9] ASoC: sun4i-i2s: Add regmap field to sign extend sample
Date:   Fri, 21 Dec 2018 16:21:03 +0100
Message-Id: <20181221152110.17982-3-codekipper@gmail.com>
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

On the newer SoCs this is set by default to transfer a 0 after
each sample in each slot. Add the regmap field to configure this
and set it so that it pads the sample with 0s.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 64d073cb2aee..80bf29e0cc86 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -138,6 +138,7 @@
  * @field_fmt_bclk: regmap field to set clk polarity.
  * @field_fmt_lrclk: regmap field to set frame polarity.
  * @field_fmt_mode: regmap field to set the operational mode.
+ * @field_fmt_sext: regmap field to set the sign extension.
  * @field_txchanmap: location of the tx channel mapping register.
  * @field_rxchanmap: location of the rx channel mapping register.
  * @field_txchansel: location of the tx channel select bit fields.
@@ -163,6 +164,7 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_bclk;
 	struct reg_field		field_fmt_lrclk;
 	struct reg_field		field_fmt_mode;
+	struct reg_field		field_fmt_sext;
 	struct reg_field		field_txchanmap;
 	struct reg_field		field_rxchanmap;
 	struct reg_field		field_txchansel;
@@ -187,6 +189,7 @@ struct sun4i_i2s {
 	struct regmap_field	*field_fmt_bclk;
 	struct regmap_field	*field_fmt_lrclk;
 	struct regmap_field	*field_fmt_mode;
+	struct regmap_field	*field_fmt_sext;
 	struct regmap_field	*field_txchanmap;
 	struct regmap_field	*field_rxchanmap;
 	struct regmap_field	*field_txchansel;
@@ -346,6 +349,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
 
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_field_write(i2s->field_fmt_sext, 0);
+
 	return 0;
 }
 
@@ -876,6 +882,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -893,6 +900,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.has_slave_select_bit	= true,
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
 	.field_txchanmap	= REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -933,6 +941,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
 	.field_fmt_mode		= REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
+	.field_fmt_sext		= REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
 	.field_txchanmap	= REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
 	.field_rxchanmap	= REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
 	.field_txchansel	= REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
@@ -995,6 +1004,12 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	if (IS_ERR(i2s->field_fmt_mode))
 		return PTR_ERR(i2s->field_fmt_mode);
 
+	i2s->field_fmt_sext =
+			devm_regmap_field_alloc(dev, i2s->regmap,
+						i2s->variant->field_fmt_sext);
+	if (IS_ERR(i2s->field_fmt_sext))
+		return PTR_ERR(i2s->field_fmt_sext);
+
 	i2s->field_txchanmap =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_txchanmap);
-- 
2.20.1

