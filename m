Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F01CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1011523E21
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qnzKS5W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1011523E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934083AbeGBKJ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:09:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40328 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeGBKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=17TqHZ5Ugc7LGKMu1xGQiZs2UmwGe9AZNjHh/qHx0Bs=; b=qnzKS5W+inv/
        HiOan60gH1UadHDWE6N/I4i8dINTxUGAZJ+rjZb4bUX9+43g9vPi58fMQ3H16CGmaJKvFQxvfFyQ6
        v6a3Z9PHPD9BaQwDusS/0a48c1pgb89ENvw1WC9dDROb4P80fx1BplmeIiwfhoc688SbHiRNOob1E
        Q16ak=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvll-00042t-Om; Mon, 02 Jul 2018 10:09:17 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvll-0006Ll-Ax; Mon, 02 Jul 2018 11:09:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es7134: check if mclk rate is valid" to the asoc tree
In-Reply-To:  <20180629150924.18197-3-jbrunet@baylibre.com>
Message-Id: <E1fZvll-0006Ll-Ax@debutante>
Date:   Mon, 02 Jul 2018 11:09:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es7134: check if mclk rate is valid

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a016b11cc41df06b79c0c226e719d0d88373919c Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 29 Jun 2018 17:09:21 +0200
Subject: [PATCH] ASoC: es7134: check if mclk rate is valid

For each supported sample rate, the es7134 can work with several
mclk / sample rate ratio. Check if ratio we get is actually OK.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 119 +++++++++++++++++++++++++++++++++++++-
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
2.18.0.rc2

