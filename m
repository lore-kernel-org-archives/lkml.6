Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37818C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ABE20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv7kgQ5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ABE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbeLBVXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42184 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeLBVXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so10133019wrx.9;
        Sun, 02 Dec 2018 13:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+LxMji1rmgC9t/lu72XSjJGgts2lQWuFigEHj6EqQ0=;
        b=pv7kgQ5tYm0WM/80+JIkCQritf3PIkUgpyqbbGK+38rYocyqk87xx0wmbVweojIq35
         pK7DTFkO/ylyYrWoBaBU/0ZbuWt1SzxjK3Xt3hUcUF8DkkXWSnJH90HLWeZ+Jc5jl2kh
         +gYL2hLFa6iFYXRsf9RR7QVm7gR3dSLAA2BRww2uQngWvqT9vLXHa12VaN6/VjoqnOm8
         vpICHeA0fuavWp5jkCOPOxlah/b+XEpt0m/BFR0VpfIPr4Ni5d5GirfkrsWySBO/qPaW
         9sW7EjaCHr04j5bgTKVosq0qkyd1WdfYMN1AU89Wu+Sh8nSMFjpEjUgjKROUDvSarW1d
         62rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+LxMji1rmgC9t/lu72XSjJGgts2lQWuFigEHj6EqQ0=;
        b=ZZEmBgKT4UZt9DvZ2v4/ooet1cl68Rl3M8TsZokF5sDdoKUsTQlLLY29sAlp4HYgE5
         uBW/NDcc3rBNUpyivYEU/PWEWubyPn/sRwnhDRPWmUshXyXacJgOTFR843HC5Fm651XH
         Ao60wRqt6FMYzG8BUNmecOxZyHwq82x/CkR1IfJxqGlFl+Rh2QeR6ojqz2I4v05kT2Lo
         BE9DfzcTvvbU4Jmjh9/UHutN2d0Dw07pK3imhmBAKHMGJiPeCikQV0pPnAvn+4MGd79/
         +OX2U8udZ43fm6r947mpiq8hjksisDMM+16xuD6sw9B1Zv6MYISJyBG8Khi5A5U46D0w
         tzpQ==
X-Gm-Message-State: AA+aEWbfOrpqMg39VqbnlWWOdambq+prZhRB0i8OhX1mqsDX3DoHKM/s
        q76DJQbqgdBqHGFQ8WdAVTkQ+zkj8xI=
X-Google-Smtp-Source: AFSGD/Ur4YLCDN09H9lZy5dwOP6hgbKYzs8y6dXHpKgREYU7iFhdFYvt3J3Tl/0ElcnaIq8COpOzEQ==
X-Received: by 2002:adf:8228:: with SMTP id 37mr11440991wrb.160.1543785820865;
        Sun, 02 Dec 2018 13:23:40 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:40 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 06/10] ASoC: sun4i-codec: Add DMA Max Burst field
Date:   Mon,  3 Dec 2018 00:23:13 +0300
Message-Id: <b36cd894f89f572c44318e7999e7724b80ba857e.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner suniv F1C100s has similar DMA engine to sun4i but it has
smaller max burst size compared to sun4i. Add a quirk field to
differantitate between them.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9a3cb77..7a9f84e 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -224,6 +224,8 @@
 
 /* TODO H3 DAP (Digital Audio Processing) bits */
 
+#define SUN4I_DMA_MAX_BURST			(8)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1462,6 +1464,7 @@ struct sun4i_codec_quirks {
 	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
 	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
 	bool has_reset;
+	u32 dma_max_burst;
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
@@ -1471,6 +1474,7 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
@@ -1481,6 +1485,7 @@ static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
@@ -1490,6 +1495,7 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
@@ -1500,6 +1506,7 @@ static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
@@ -1515,6 +1522,7 @@ static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
@@ -1529,6 +1537,7 @@ static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -1655,12 +1664,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
-	scodec->playback_dma_data.maxburst = 8;
+	scodec->playback_dma_data.maxburst = quirks->dma_max_burst;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	/* DMA configuration for RX FIFO */
 	scodec->capture_dma_data.addr = res->start + quirks->reg_adc_rxdata;
-	scodec->capture_dma_data.maxburst = 8;
+	scodec->capture_dma_data.maxburst = quirks->dma_max_burst;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, quirks->codec,
-- 
2.7.4

