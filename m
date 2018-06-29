Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4057A2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tgCeev2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4057A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeF2PJk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:09:40 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41172 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755582AbeF2PJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:09:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so9167316wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+7/swUQZFAd6N8K1M3uYNqQl1RfsDNPOrQv57pLlcFk=;
        b=tgCeev2qSnSV0/t54V01gojrXOBywyhPId8cd0dKtXsyAmH/pRB5tSgl0pZm8e9ivL
         RM4mI0xB0MQgUCokUF8K6PuejeJZeg5Wa/SoYGhxYNmjBi9FjTFzm5VCsAtA3b+aKK8G
         D4DPPTVf/WeMsurLmKFbrr9+I1G4nqWE3o8OLjwIyNKom4fRE0FDLQ3ikF/vgVqS4Pqk
         ONt8CEZi/g73BJ+pB1LZNSmde+ibPzItO4KW0uYiT3QobvDwZJnaeeL+qlJrn+efkgoB
         tt7McBiBbDVtP0iR2kKgVwTtkL6F/ZUMo3IqKFcrPWRTmUDp+CaOV6aY/6pbB+lS3Hog
         Jozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+7/swUQZFAd6N8K1M3uYNqQl1RfsDNPOrQv57pLlcFk=;
        b=d6PyOLwSPT824Y6oYSx/hQ83xIAXBjFz0T03VErsirYSsUnbH7YaeAl6UOV2zdiknm
         oAExrakWf4Idw8XIJ4gybRoLC2H5EFNfdSEN1ADbbwdX2EnyW4C/rbyj/gwsxssysbFj
         jSPje0jj0DyWmVXBKOlnfYt9YqwOIm+NapqWFL6JMIwY4Dh6vomRc0Btvj6kL2ICwxgV
         4jUSNZpl3ExLnCVnPVhm6ENnx9gFJa2PzIsiXX9sxn7I09CNLE30OoGWE+a4H0qAHJow
         dMGEI/D3KmxyGgNf1ObvAGmaXxmZgX9inPonpleHVRW+UavlmMi/lsQ/N3d0D2d3+h7E
         vrYA==
X-Gm-Message-State: APt69E3DaBFs3mQ84cXKSF2A8P5/lhPiigjLnbRBFXvZIc0D4LpDTQ+D
        zkHMmGIsfH56+EC1WTkS5EDCtA==
X-Google-Smtp-Source: AAOMgpdVUW2mleMKZ9txnVApE8dUzc1LbLEzheUuNXOng+XtVcPD5le40PActgYLaQiF0gNYQ29KdA==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr12359926wrl.26.1530284972968;
        Fri, 29 Jun 2018 08:09:32 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm11944222wro.52.2018.06.29.08.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:09:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ASoC: es7134: check if mclk rate is valid
Date:   Fri, 29 Jun 2018 17:09:21 +0200
Message-Id: <20180629150924.18197-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each supported sample rate, the es7134 can work with several
mclk / sample rate ratio. Check if ratio we get is actually OK.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 119 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 2fbb49f5b278..698289dc3e22 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -17,6 +17,7 @@
  * in the file called COPYING.
  */
 
+#include <linux/of_platform.h>
 #include <linux/module.h>
 #include <sound/soc.h>
 
@@ -24,6 +25,77 @@
  * The everest 7134 is a very simple DA converter with no register
  */
 
+struct es7134_clock_mode {
+	unsigned int rate_min;
+	unsigned int rate_max;
+	unsigned int *mclk_fs;
+	unsigned int mclk_fs_num;
+};
+
+struct es7134_chip {
+	const struct es7134_clock_mode *modes;
+	unsigned int mode_num;
+};
+
+struct es7134_data {
+	unsigned int mclk;
+	const struct es7134_chip *chip;
+};
+
+static int es7134_check_mclk(struct snd_soc_dai *dai,
+			     struct es7134_data *priv,
+			     unsigned int rate)
+{
+	unsigned int mfs = priv->mclk / rate;
+	int i, j;
+
+	for (i = 0; i < priv->chip->mode_num; i++) {
+		const struct es7134_clock_mode *mode = &priv->chip->modes[i];
+
+		if (rate < mode->rate_min || rate > mode->rate_max)
+			continue;
+
+		for (j = 0; j < mode->mclk_fs_num; j++) {
+			if (mode->mclk_fs[j] == mfs)
+				return 0;
+		}
+
+		dev_err(dai->dev, "unsupported mclk_fs %u for rate %u\n",
+			mfs, rate);
+		return -EINVAL;
+	}
+
+	/* should not happen */
+	dev_err(dai->dev, "unsupported rate: %u\n", rate);
+	return -EINVAL;
+}
+
+static int es7134_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct es7134_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	/* mclk has not been provided, assume it is OK */
+	if (!priv->mclk)
+		return 0;
+
+	return es7134_check_mclk(dai, priv, params_rate(params));
+}
+
+static int es7134_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			     unsigned int freq, int dir)
+{
+	struct es7134_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	if (dir == SND_SOC_CLOCK_IN && clk_id == 0) {
+		priv->mclk = freq;
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 static int es7134_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	fmt &= (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK |
@@ -40,6 +112,8 @@ static int es7134_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 
 static const struct snd_soc_dai_ops es7134_dai_ops = {
 	.set_fmt	= es7134_set_fmt,
+	.hw_params	= es7134_hw_params,
+	.set_sysclk	= es7134_set_sysclk,
 };
 
 static struct snd_soc_dai_driver es7134_dai = {
@@ -62,6 +136,33 @@ static struct snd_soc_dai_driver es7134_dai = {
 	.ops = &es7134_dai_ops,
 };
 
+static const struct es7134_clock_mode es7134_modes[] = {
+	{
+		/* Single speed mode */
+		.rate_min = 8000,
+		.rate_max = 50000,
+		.mclk_fs = (unsigned int[]) { 256, 384, 512, 768, 1024 },
+		.mclk_fs_num = 5,
+	}, {
+		/* Double speed mode */
+		.rate_min = 84000,
+		.rate_max = 100000,
+		.mclk_fs = (unsigned int[]) { 128, 192, 256, 384, 512 },
+		.mclk_fs_num = 5,
+	}, {
+		/* Quad speed mode */
+		.rate_min = 167000,
+		.rate_max = 192000,
+		.mclk_fs = (unsigned int[]) { 128, 192, 256 },
+		.mclk_fs_num = 3,
+	},
+};
+
+static const struct es7134_chip es7134_chip = {
+	.modes = es7134_modes,
+	.mode_num = ARRAY_SIZE(es7134_modes),
+};
+
 static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AOUTL"),
 	SND_SOC_DAPM_OUTPUT("AOUTR"),
@@ -86,6 +187,20 @@ static const struct snd_soc_component_driver es7134_component_driver = {
 
 static int es7134_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct es7134_data *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	priv->chip = of_device_get_match_data(dev);
+	if (!priv->chip) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
 	return devm_snd_soc_register_component(&pdev->dev,
 				      &es7134_component_driver,
 				      &es7134_dai, 1);
@@ -93,8 +208,8 @@ static int es7134_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id es7134_ids[] = {
-	{ .compatible = "everest,es7134", },
-	{ .compatible = "everest,es7144", },
+	{ .compatible = "everest,es7134", .data = &es7134_chip },
+	{ .compatible = "everest,es7144", .data = &es7134_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es7134_ids);
-- 
2.14.4

