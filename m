Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A812EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E73923EC8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qws+uspd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E73923EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeGCPee (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:34:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeGCPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=S5tj5RaMly926aZfWv7/95A/JEmnW1UUssK1KeuFGFQ=; b=qws+uspdlb9K
        QN/tMhWIsBkYc4PXGAUY7jFHUyty7rbLwMte6Npl9oRKbUlqUDQUA/IDh5QtiyiM2SNTDkq7IQvwE
        6kDdsRFoJPDJWBB8lxcNcaxBtmAuxPmAzTdoITwNoD+2G2/ceE5PMKDbtBYVA5TE+lW5jHyelZvsd
        PDvU0=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJy-0006BZ-AZ; Tue, 03 Jul 2018 15:34:26 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJx-0003qE-Sk; Tue, 03 Jul 2018 16:34:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es7241: add es7241 codec support" to the asoc tree
In-Reply-To:  <20180703132845.26554-3-jbrunet@baylibre.com>
Message-Id: <E1faNJx-0003qE-Sk@debutante>
Date:   Tue, 03 Jul 2018 16:34:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es7241: add es7241 codec support

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

From 5f7bdc466c772b3af3145a71724965ecdc03e6bf Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 15:28:45 +0200
Subject: [PATCH] ASoC: es7241: add es7241 codec support

Add support for the everest es7241 which is a simple 2 channels
analog to digital converter.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es7241.c | 322 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 sound/soc/codecs/es7241.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6d1674699385..efb095dbcd71 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
 	select SND_SOC_ES7134
+	select SND_SOC_ES7241
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_ICS43432
@@ -585,6 +586,9 @@ config SND_SOC_HDMI_CODEC
 config SND_SOC_ES7134
        tristate "Everest Semi ES7134 CODEC"
 
+config SND_SOC_ES7241
+       tristate "Everest Semi ES7241 CODEC"
+
 config SND_SOC_ES8316
 	tristate "Everest Semi ES8316 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f26ded89a1e5..7ae7c85e8219 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -71,6 +71,7 @@ snd-soc-da732x-objs := da732x.o
 snd-soc-da9055-objs := da9055.o
 snd-soc-dmic-objs := dmic.o
 snd-soc-es7134-objs := es7134.o
+snd-soc-es7241-objs := es7241.o
 snd-soc-es8316-objs := es8316.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
@@ -330,6 +331,7 @@ obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES7134)	+= snd-soc-es7134.o
+obj-$(CONFIG_SND_SOC_ES7241)	+= snd-soc-es7241.o
 obj-$(CONFIG_SND_SOC_ES8316)    += snd-soc-es8316.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
diff --git a/sound/soc/codecs/es7241.c b/sound/soc/codecs/es7241.c
new file mode 100644
index 000000000000..87991bd4acef
--- /dev/null
+++ b/sound/soc/codecs/es7241.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/gpio/consumer.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+struct es7241_clock_mode {
+	unsigned int rate_min;
+	unsigned int rate_max;
+	unsigned int *slv_mfs;
+	unsigned int slv_mfs_num;
+	unsigned int mst_mfs;
+	unsigned int mst_m0:1;
+	unsigned int mst_m1:1;
+};
+
+struct es7241_chip {
+	const struct es7241_clock_mode *modes;
+	unsigned int mode_num;
+};
+
+struct es7241_data {
+	struct gpio_desc *reset;
+	struct gpio_desc *m0;
+	struct gpio_desc *m1;
+	unsigned int fmt;
+	unsigned int mclk;
+	bool is_slave;
+	const struct es7241_chip *chip;
+};
+
+static void es7241_set_mode(struct es7241_data *priv,  int m0, int m1)
+{
+	/* put the device in reset */
+	gpiod_set_value_cansleep(priv->reset, 0);
+
+	/* set the mode */
+	gpiod_set_value_cansleep(priv->m0, m0);
+	gpiod_set_value_cansleep(priv->m1, m1);
+
+	/* take the device out of reset - datasheet does not specify a delay */
+	gpiod_set_value_cansleep(priv->reset, 1);
+}
+
+static int es7241_set_slave_mode(struct es7241_data *priv,
+				 const struct es7241_clock_mode *mode,
+				 unsigned int mfs)
+{
+	int j;
+
+	if (!mfs)
+		goto out_ok;
+
+	for (j = 0; j < mode->slv_mfs_num; j++) {
+		if (mode->slv_mfs[j] == mfs)
+			goto out_ok;
+	}
+
+	return -EINVAL;
+
+out_ok:
+	es7241_set_mode(priv, 1, 1);
+	return 0;
+}
+
+static int es7241_set_master_mode(struct es7241_data *priv,
+				  const struct es7241_clock_mode *mode,
+				  unsigned int mfs)
+{
+	/*
+	 * We can't really set clock ratio, if the mclk/lrclk is different
+	 * from what we provide, then error out
+	 */
+	if (mfs && mfs != mode->mst_mfs)
+		return -EINVAL;
+
+	es7241_set_mode(priv, mode->mst_m0, mode->mst_m1);
+
+	return 0;
+}
+
+static int es7241_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct es7241_data *priv = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	unsigned int mfs = priv->mclk / rate;
+	int i;
+
+	for (i = 0; i < priv->chip->mode_num; i++) {
+		const struct es7241_clock_mode *mode = &priv->chip->modes[i];
+
+		if (rate < mode->rate_min || rate >= mode->rate_max)
+			continue;
+
+		if (priv->is_slave)
+			return es7241_set_slave_mode(priv, mode, mfs);
+		else
+			return es7241_set_master_mode(priv, mode, mfs);
+	}
+
+	/* should not happen */
+	dev_err(dai->dev, "unsupported rate: %u\n", rate);
+	return -EINVAL;
+}
+
+static int es7241_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			     unsigned int freq, int dir)
+{
+	struct es7241_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	if (dir == SND_SOC_CLOCK_IN && clk_id == 0) {
+		priv->mclk = freq;
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
+static int es7241_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct es7241_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF) {
+		dev_err(dai->dev, "Unsupported dai clock inversion\n");
+		return -EINVAL;
+	}
+
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != priv->fmt) {
+		dev_err(dai->dev, "Invalid dai format\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		priv->is_slave = true;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		priv->is_slave = false;
+		break;
+
+	default:
+		dev_err(dai->dev, "Unsupported clock configuration\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops es7241_dai_ops = {
+	.set_fmt	= es7241_set_fmt,
+	.hw_params	= es7241_hw_params,
+	.set_sysclk	= es7241_set_sysclk,
+};
+
+static struct snd_soc_dai_driver es7241_dai = {
+	.name = "es7241-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
+			    SNDRV_PCM_FMTBIT_S24_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &es7241_dai_ops,
+};
+
+static const struct es7241_clock_mode es7241_modes[] = {
+	{
+		/* Single speed mode */
+		.rate_min = 8000,
+		.rate_max = 50000,
+		.slv_mfs = (unsigned int[]) { 256, 384, 512, 768, 1024 },
+		.slv_mfs_num = 5,
+		.mst_mfs = 256,
+		.mst_m0 = 0,
+		.mst_m1 = 0,
+	}, {
+		/* Double speed mode */
+		.rate_min = 50000,
+		.rate_max = 100000,
+		.slv_mfs = (unsigned int[]) { 128, 192 },
+		.slv_mfs_num = 2,
+		.mst_mfs = 128,
+		.mst_m0 = 1,
+		.mst_m1 = 0,
+	}, {
+		/* Quad speed mode */
+		.rate_min = 100000,
+		.rate_max = 200000,
+		.slv_mfs = (unsigned int[]) { 64 },
+		.slv_mfs_num = 1,
+		.mst_mfs = 64,
+		.mst_m0 = 0,
+		.mst_m1 = 1,
+	},
+};
+
+static const struct es7241_chip es7241_chip = {
+	.modes = es7241_modes,
+	.mode_num = ARRAY_SIZE(es7241_modes),
+};
+
+static const struct snd_soc_dapm_widget es7241_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("AINL"),
+	SND_SOC_DAPM_INPUT("AINR"),
+	SND_SOC_DAPM_DAC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDP", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDD", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDA", 0, 0),
+};
+
+static const struct snd_soc_dapm_route es7241_dapm_routes[] = {
+	{ "ADC", NULL, "AINL", },
+	{ "ADC", NULL, "AINR", },
+	{ "ADC", NULL, "VDDA", },
+	{ "Capture", NULL, "VDDP", },
+	{ "Capture", NULL, "VDDD", },
+};
+
+static const struct snd_soc_component_driver es7241_component_driver = {
+	.dapm_widgets		= es7241_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(es7241_dapm_widgets),
+	.dapm_routes		= es7241_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(es7241_dapm_routes),
+	.idle_bias_on		= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static void es7241_parse_fmt(struct device *dev, struct es7241_data *priv)
+{
+	bool is_leftj;
+
+	/*
+	 * The format is given by a pull resistor on the SDOUT pin:
+	 * pull-up for i2s, pull-down for left justified.
+	 */
+	is_leftj = of_property_read_bool(dev->of_node,
+					 "everest,sdout-pull-down");
+	if (is_leftj)
+		priv->fmt = SND_SOC_DAIFMT_LEFT_J;
+	else
+		priv->fmt = SND_SOC_DAIFMT_I2S;
+}
+
+static int es7241_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct es7241_data *priv;
+	int err;
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
+	es7241_parse_fmt(dev, priv);
+
+	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->reset)) {
+		err = PTR_ERR(priv->reset);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'reset' gpio: %d", err);
+		return err;
+	}
+
+	priv->m0 = devm_gpiod_get_optional(dev, "m0", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->m0)) {
+		err = PTR_ERR(priv->m0);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'm0' gpio: %d", err);
+		return err;
+	}
+
+	priv->m1 = devm_gpiod_get_optional(dev, "m1", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->m1)) {
+		err = PTR_ERR(priv->m1);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get 'm1' gpio: %d", err);
+		return err;
+	}
+
+	return devm_snd_soc_register_component(&pdev->dev,
+				      &es7241_component_driver,
+				      &es7241_dai, 1);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id es7241_ids[] = {
+	{ .compatible = "everest,es7241", .data = &es7241_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, es7241_ids);
+#endif
+
+static struct platform_driver es7241_driver = {
+	.driver = {
+		.name = "es7241",
+		.of_match_table = of_match_ptr(es7241_ids),
+	},
+	.probe = es7241_probe,
+};
+
+module_platform_driver(es7241_driver);
+
+MODULE_DESCRIPTION("ASoC ES7241 audio codec driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL");
-- 
2.18.0.rc2

