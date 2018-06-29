Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77967C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9CF28055
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JGM1MdVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9CF28055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936692AbeF2PZN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:25:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41506 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936606AbeF2PZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:25:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so9214008wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=amC7OrFeGDfQcpL0iK7Bzy17i3STQdJneW6/UZWfDo0=;
        b=JGM1MdVZqbUcMj4NBN8kTNEz4EqUqidRZeBz6o3CKHRE4I5k4JA97f98jzHYMM1qyP
         Z/fQkcGmvvEA9CHsycLmzcZ/BRSZf7RUFccRdyqpF2AA1zrV7kZG9FHlHrfVkmnuFwpm
         TgE1E1IJ8dsumcpQlFa1GSxLN/Um9S4dUvKkG1S3QUgmU3Y9ao+VzY4Fb4B2yU8MEV6l
         MiaEfhRfmsO4ZZUeMdOdWw40s0Q3uWL8JKAYpP4T9Bp/tK0liEv6c7ZGQZMiEXDKF/Vl
         c2332pVm0LsC1xEEM598JQUtS1tsg6D7WE50Yh9y0pVe8jXbwdggrcS9FpRUTELDlqoa
         7h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amC7OrFeGDfQcpL0iK7Bzy17i3STQdJneW6/UZWfDo0=;
        b=c56CB6XfZ2Bo0dLA4F6W9l3ZtB7s6RUsmMKuJLgOzTjDmDiTVAatQZZVIoNYsNawZq
         RqIm6Dc1uthHUUjhWdWKVxP+/9Ecz3I2TAo1LO70RoaxKFNJPOWI+ekvLXzuMhrtG9Ma
         RdPQ22zY6L8QOpds4yd0JJ/gGyzjRbfJb8wsoPyECKYiE5F5jQLYJo90gysYqdkDSwXV
         XQ9R71uUNjFQafmGEgTdyyQ/yvDjbj2tWP0GkZAL0Q6LUucvtAS6CRkXqI+nDGcht9yt
         Mn39fymL2K1ijpjWmap094sVcsTfn/Vi68hzfhHgFVIgI6Ekpk9sSzooAJ2LhviNFZTV
         MwBA==
X-Gm-Message-State: APt69E1vLPJWNz9UHFxZGfmYlqWIwECcip7tobw4PMdeuFBQzBjIWHCZ
        /yZ2BqVo919r1OmK9BAgmKYQ8g==
X-Google-Smtp-Source: AAOMgpez8qGS2cXqKfofFPFVp8LhulNn9j+ezAQSWIpPPzC4qtHx5rA6KsHehnjPus/hgqZxKPMzYg==
X-Received: by 2002:adf:e701:: with SMTP id c1-v6mr9509302wrm.143.1530285905513;
        Fri, 29 Jun 2018 08:25:05 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q70-v6sm2754659wmd.45.2018.06.29.08.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:25:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: es7241: add es7241 codec support
Date:   Fri, 29 Jun 2018 17:24:44 +0200
Message-Id: <20180629152444.21525-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180629152444.21525-1-jbrunet@baylibre.com>
References: <20180629152444.21525-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the everest es7241 which is a simple 2 channels
analog to digital converter.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/Kconfig  |   4 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/es7241.c | 307 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 sound/soc/codecs/es7241.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f5839eeeed5e..047ac28ba40f 100644
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
@@ -584,6 +585,9 @@ config SND_SOC_HDMI_CODEC
 config SND_SOC_ES7134
        tristate "Everest Semi ES7134 CODEC"
 
+config SND_SOC_ES7241
+       tristate "Everest Semi ES7241 CODEC"
+
 config SND_SOC_ES8316
 	tristate "Everest Semi ES8316 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 6cc15d1c5767..719653a4c882 100644
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
@@ -329,6 +330,7 @@ obj-$(CONFIG_SND_SOC_DA732X)	+= snd-soc-da732x.o
 obj-$(CONFIG_SND_SOC_DA9055)	+= snd-soc-da9055.o
 obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES7134)	+= snd-soc-es7134.o
+obj-$(CONFIG_SND_SOC_ES7241)	+= snd-soc-es7241.o
 obj-$(CONFIG_SND_SOC_ES8316)    += snd-soc-es8316.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
diff --git a/sound/soc/codecs/es7241.c b/sound/soc/codecs/es7241.c
new file mode 100644
index 000000000000..f7cb2f76d27b
--- /dev/null
+++ b/sound/soc/codecs/es7241.c
@@ -0,0 +1,307 @@
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
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+
+	default:
+		dev_err(dai->dev, "Unsupported dai format\n");
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		priv->is_slave = true;
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
2.14.4

