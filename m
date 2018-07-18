Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A1ECDFBC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF1120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MhR6KLkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF1120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeGRNDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:03:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43278 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeGRNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MzzjWEJ9HOrOsuSsqTjfcE0AzTw88ACt6iuK38pd1cQ=; b=MhR6KLkp7KDU
        EBXkvSFaU3+Raj7c+ToQ6gJJH4S1hcbSdDN7Lc5cLnotGTbJJJgulftzMkvegQRXbYN17HUQhiUU4
        WhyagCyE+keTA793qupJlDD55+W9THJOwbrQpD/XfZB+wwy6rIU0bYuAh0l/L0oNI9S4H+WfM7BUV
        DtbP4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflW5-0003UN-30; Wed, 18 Jul 2018 12:25:13 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflW4-00079E-Jo; Wed, 18 Jul 2018 13:25:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add axg spdif output" to the asoc tree
In-Reply-To:  <20180717153643.8806-8-jbrunet@baylibre.com>
Message-Id: <E1fflW4-00079E-Jo@debutante>
Date:   Wed, 18 Jul 2018 13:25:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add axg spdif output

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

From 53eb4b7aaa045e23b6e8edb0ae0d047a4a3612ef Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:55 +0200
Subject: [PATCH] ASoC: meson: add axg spdif output

Add support for the spdif output serializer of the axg SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig        |   7 +
 sound/soc/meson/Makefile       |   2 +
 sound/soc/meson/axg-spdifout.c | 456 +++++++++++++++++++++++++++++++++
 3 files changed, 465 insertions(+)
 create mode 100644 sound/soc/meson/axg-spdifout.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 3916060edcae..9408214b5854 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -19,4 +19,11 @@ config SND_MESON_AXG_TODDR
 	  Select Y or M to add support for the frontend capture interfaces
 	  embedded in the Amlogic AXG SoC family
 
+config SND_MESON_AXG_SPDIFOUT
+	tristate "Amlogic AXG SPDIF Output Support"
+	imply SND_SOC_SPDIF
+	help
+	  Select Y or M to add support for SPDIF output serializer embedded
+	  in the Amlogic AXG SoC family
+
 endmenu
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index 12edf2db2a24..d51ae045ef08 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -3,7 +3,9 @@
 snd-soc-meson-axg-fifo-objs := axg-fifo.o
 snd-soc-meson-axg-frddr-objs := axg-frddr.o
 snd-soc-meson-axg-toddr-objs := axg-toddr.o
+snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
 obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
 obj-$(CONFIG_SND_MESON_AXG_TODDR) += snd-soc-meson-axg-toddr.o
+obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
diff --git a/sound/soc/meson/axg-spdifout.c b/sound/soc/meson/axg-spdifout.c
new file mode 100644
index 000000000000..9dea528053ad
--- /dev/null
+++ b/sound/soc/meson/axg-spdifout.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/pcm_params.h>
+#include <sound/pcm_iec958.h>
+
+/*
+ * NOTE:
+ * The meaning of bits SPDIFOUT_CTRL0_XXX_SEL is actually the opposite
+ * of what the documentation says. Manual control on V, U and C bits is
+ * applied when the related sel bits are cleared
+ */
+
+#define SPDIFOUT_STAT			0x00
+#define SPDIFOUT_GAIN0			0x04
+#define SPDIFOUT_GAIN1			0x08
+#define SPDIFOUT_CTRL0			0x0c
+#define  SPDIFOUT_CTRL0_EN		BIT(31)
+#define  SPDIFOUT_CTRL0_RST_OUT		BIT(29)
+#define  SPDIFOUT_CTRL0_RST_IN		BIT(28)
+#define  SPDIFOUT_CTRL0_USEL		BIT(26)
+#define  SPDIFOUT_CTRL0_USET		BIT(25)
+#define  SPDIFOUT_CTRL0_CHSTS_SEL	BIT(24)
+#define  SPDIFOUT_CTRL0_DATA_SEL	BIT(20)
+#define  SPDIFOUT_CTRL0_MSB_FIRST	BIT(19)
+#define  SPDIFOUT_CTRL0_VSEL		BIT(18)
+#define  SPDIFOUT_CTRL0_VSET		BIT(17)
+#define  SPDIFOUT_CTRL0_MASK_MASK	GENMASK(11, 4)
+#define  SPDIFOUT_CTRL0_MASK(x)		((x) << 4)
+#define SPDIFOUT_CTRL1			0x10
+#define  SPDIFOUT_CTRL1_MSB_POS_MASK	GENMASK(12, 8)
+#define  SPDIFOUT_CTRL1_MSB_POS(x)	((x) << 8)
+#define  SPDIFOUT_CTRL1_TYPE_MASK	GENMASK(6, 4)
+#define  SPDIFOUT_CTRL1_TYPE(x)		((x) << 4)
+#define SPDIFOUT_PREAMB			0x14
+#define SPDIFOUT_SWAP			0x18
+#define SPDIFOUT_CHSTS0			0x1c
+#define SPDIFOUT_CHSTS1			0x20
+#define SPDIFOUT_CHSTS2			0x24
+#define SPDIFOUT_CHSTS3			0x28
+#define SPDIFOUT_CHSTS4			0x2c
+#define SPDIFOUT_CHSTS5			0x30
+#define SPDIFOUT_CHSTS6			0x34
+#define SPDIFOUT_CHSTS7			0x38
+#define SPDIFOUT_CHSTS8			0x3c
+#define SPDIFOUT_CHSTS9			0x40
+#define SPDIFOUT_CHSTSA			0x44
+#define SPDIFOUT_CHSTSB			0x48
+#define SPDIFOUT_MUTE_VAL		0x4c
+
+struct axg_spdifout {
+	struct regmap *map;
+	struct clk *mclk;
+	struct clk *pclk;
+};
+
+static void axg_spdifout_enable(struct regmap *map)
+{
+	/* Apply both reset */
+	regmap_update_bits(map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_RST_OUT | SPDIFOUT_CTRL0_RST_IN,
+			   0);
+
+	/* Clear out reset before in reset */
+	regmap_update_bits(map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_RST_OUT, SPDIFOUT_CTRL0_RST_OUT);
+	regmap_update_bits(map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_RST_IN,  SPDIFOUT_CTRL0_RST_IN);
+
+	/* Enable spdifout */
+	regmap_update_bits(map, SPDIFOUT_CTRL0, SPDIFOUT_CTRL0_EN,
+			   SPDIFOUT_CTRL0_EN);
+}
+
+static void axg_spdifout_disable(struct regmap *map)
+{
+	regmap_update_bits(map, SPDIFOUT_CTRL0, SPDIFOUT_CTRL0_EN, 0);
+}
+
+static int axg_spdifout_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		axg_spdifout_enable(priv->map);
+		return 0;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		axg_spdifout_disable(priv->map);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int axg_spdifout_digital_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+
+	/* Use spdif valid bit to perform digital mute */
+	regmap_update_bits(priv->map, SPDIFOUT_CTRL0, SPDIFOUT_CTRL0_VSET,
+			   mute ? SPDIFOUT_CTRL0_VSET : 0);
+
+	return 0;
+}
+
+static int axg_spdifout_sample_fmt(struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+	unsigned int val;
+
+	/* Set the samples spdifout will pull from the FIFO */
+	switch (params_channels(params)) {
+	case 1:
+		val = SPDIFOUT_CTRL0_MASK(0x1);
+		break;
+	case 2:
+		val = SPDIFOUT_CTRL0_MASK(0x3);
+		break;
+	default:
+		dev_err(dai->dev, "too many channels for spdif dai: %u\n",
+			params_channels(params));
+		return -EINVAL;
+	}
+
+	regmap_update_bits(priv->map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_MASK_MASK, val);
+
+	/* FIFO data are arranged in chunks of 64bits */
+	switch (params_physical_width(params)) {
+	case 8:
+		/* 8 samples of 8 bits */
+		val = SPDIFOUT_CTRL1_TYPE(0);
+		break;
+	case 16:
+		/* 4 samples of 16 bits - right justified */
+		val = SPDIFOUT_CTRL1_TYPE(2);
+		break;
+	case 32:
+		/* 2 samples of 32 bits - right justified */
+		val = SPDIFOUT_CTRL1_TYPE(4);
+		break;
+	default:
+		dev_err(dai->dev, "Unsupported physical width: %u\n",
+			params_physical_width(params));
+		return -EINVAL;
+	}
+
+	/* Position of the MSB in FIFO samples */
+	val |= SPDIFOUT_CTRL1_MSB_POS(params_width(params) - 1);
+
+	regmap_update_bits(priv->map, SPDIFOUT_CTRL1,
+			   SPDIFOUT_CTRL1_MSB_POS_MASK |
+			   SPDIFOUT_CTRL1_TYPE_MASK, val);
+
+	regmap_update_bits(priv->map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_MSB_FIRST | SPDIFOUT_CTRL0_DATA_SEL,
+			   0);
+
+	return 0;
+}
+
+static int axg_spdifout_set_chsts(struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+	unsigned int offset;
+	int ret;
+	u8 cs[4];
+	u32 val;
+
+	ret = snd_pcm_create_iec958_consumer_hw_params(params, cs, 4);
+	if (ret < 0) {
+		dev_err(dai->dev, "Creating IEC958 channel status failed %d\n",
+			ret);
+		return ret;
+	}
+	val = cs[0] | cs[1] << 8 | cs[2] << 16 | cs[3] << 24;
+
+	/* Setup channel status A bits [31 - 0]*/
+	regmap_write(priv->map, SPDIFOUT_CHSTS0, val);
+
+	/* Clear channel status A bits [191 - 32] */
+	for (offset = SPDIFOUT_CHSTS1; offset <= SPDIFOUT_CHSTS5;
+	     offset += regmap_get_reg_stride(priv->map))
+		regmap_write(priv->map, offset, 0);
+
+	/* Setup channel status B bits [31 - 0]*/
+	regmap_write(priv->map, SPDIFOUT_CHSTS6, val);
+
+	/* Clear channel status B bits [191 - 32] */
+	for (offset = SPDIFOUT_CHSTS7; offset <= SPDIFOUT_CHSTSB;
+	     offset += regmap_get_reg_stride(priv->map))
+		regmap_write(priv->map, offset, 0);
+
+	return 0;
+}
+
+static int axg_spdifout_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+	unsigned int rate = params_rate(params);
+	int ret;
+
+	/* 2 * 32bits per subframe * 2 channels = 128 */
+	ret = clk_set_rate(priv->mclk, rate * 128);
+	if (ret) {
+		dev_err(dai->dev, "failed to set spdif clock\n");
+		return ret;
+	}
+
+	ret = axg_spdifout_sample_fmt(params, dai);
+	if (ret) {
+		dev_err(dai->dev, "failed to setup sample format\n");
+		return ret;
+	}
+
+	ret = axg_spdifout_set_chsts(params, dai);
+	if (ret) {
+		dev_err(dai->dev, "failed to setup channel status words\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int axg_spdifout_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	/* Clock the spdif output block */
+	ret = clk_prepare_enable(priv->pclk);
+	if (ret) {
+		dev_err(dai->dev, "failed to enable pclk\n");
+		return ret;
+	}
+
+	/* Make sure the block is initially stopped */
+	axg_spdifout_disable(priv->map);
+
+	/* Insert data from bit 27 lsb first */
+	regmap_update_bits(priv->map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_MSB_FIRST | SPDIFOUT_CTRL0_DATA_SEL,
+			   0);
+
+	/* Manual control of V, C and U, U = 0 */
+	regmap_update_bits(priv->map, SPDIFOUT_CTRL0,
+			   SPDIFOUT_CTRL0_CHSTS_SEL | SPDIFOUT_CTRL0_VSEL |
+			   SPDIFOUT_CTRL0_USEL | SPDIFOUT_CTRL0_USET,
+			   0);
+
+	/* Static SWAP configuration ATM */
+	regmap_write(priv->map, SPDIFOUT_SWAP, 0x10);
+
+	return 0;
+}
+
+static void axg_spdifout_shutdown(struct snd_pcm_substream *substream,
+				  struct snd_soc_dai *dai)
+{
+	struct axg_spdifout *priv = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable_unprepare(priv->pclk);
+}
+
+static const struct snd_soc_dai_ops axg_spdifout_ops = {
+	.trigger	= axg_spdifout_trigger,
+	.digital_mute	= axg_spdifout_digital_mute,
+	.hw_params	= axg_spdifout_hw_params,
+	.startup	= axg_spdifout_startup,
+	.shutdown	= axg_spdifout_shutdown,
+};
+
+static struct snd_soc_dai_driver axg_spdifout_dai_drv[] = {
+	{
+		.name = "SPDIF Output",
+		.playback = {
+			.stream_name	= "Playback",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= (SNDRV_PCM_RATE_32000  |
+					   SNDRV_PCM_RATE_44100  |
+					   SNDRV_PCM_RATE_48000  |
+					   SNDRV_PCM_RATE_88200  |
+					   SNDRV_PCM_RATE_96000  |
+					   SNDRV_PCM_RATE_176400 |
+					   SNDRV_PCM_RATE_192000),
+			.formats	= (SNDRV_PCM_FMTBIT_S8     |
+					   SNDRV_PCM_FMTBIT_S16_LE |
+					   SNDRV_PCM_FMTBIT_S20_LE |
+					   SNDRV_PCM_FMTBIT_S24_LE),
+		},
+		.ops = &axg_spdifout_ops,
+	},
+};
+
+static const char * const spdifout_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2",
+};
+
+static SOC_ENUM_SINGLE_DECL(axg_spdifout_sel_enum, SPDIFOUT_CTRL1, 24,
+			    spdifout_sel_texts);
+
+static const struct snd_kcontrol_new axg_spdifout_in_mux =
+	SOC_DAPM_ENUM("Input Source", axg_spdifout_sel_enum);
+
+static const struct snd_soc_dapm_widget axg_spdifout_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &axg_spdifout_in_mux),
+};
+
+static const struct snd_soc_dapm_route axg_spdifout_dapm_routes[] = {
+	{ "SRC SEL", "IN 0", "IN 0" },
+	{ "SRC SEL", "IN 1", "IN 1" },
+	{ "SRC SEL", "IN 2", "IN 2" },
+	{ "Playback", NULL, "SRC SEL" },
+};
+
+static const struct snd_kcontrol_new axg_spdifout_controls[] = {
+	SOC_DOUBLE("Playback Volume", SPDIFOUT_GAIN0,  0,  8, 255, 0),
+	SOC_DOUBLE("Playback Switch", SPDIFOUT_CTRL0, 22, 21, 1, 1),
+	SOC_SINGLE("Playback Gain Enable Switch",
+		   SPDIFOUT_CTRL1, 26, 1, 0),
+	SOC_SINGLE("Playback Channels Mix Switch",
+		   SPDIFOUT_CTRL0, 23, 1, 0),
+};
+
+static int axg_spdifout_set_bias_level(struct snd_soc_component *component,
+				       enum snd_soc_bias_level level)
+{
+	struct axg_spdifout *priv = snd_soc_component_get_drvdata(component);
+	enum snd_soc_bias_level now =
+		snd_soc_component_get_bias_level(component);
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (now == SND_SOC_BIAS_STANDBY)
+			ret = clk_prepare_enable(priv->mclk);
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (now == SND_SOC_BIAS_PREPARE)
+			clk_disable_unprepare(priv->mclk);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+	case SND_SOC_BIAS_ON:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver axg_spdifout_component_drv = {
+	.controls		= axg_spdifout_controls,
+	.num_controls		= ARRAY_SIZE(axg_spdifout_controls),
+	.dapm_widgets		= axg_spdifout_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_spdifout_dapm_widgets),
+	.dapm_routes		= axg_spdifout_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_spdifout_dapm_routes),
+	.set_bias_level		= axg_spdifout_set_bias_level,
+};
+
+static const struct regmap_config axg_spdifout_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= SPDIFOUT_MUTE_VAL,
+};
+
+static const struct of_device_id axg_spdifout_of_match[] = {
+	{ .compatible = "amlogic,axg-spdifout", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, axg_spdifout_of_match);
+
+static int axg_spdifout_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axg_spdifout *priv;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->map = devm_regmap_init_mmio(dev, regs, &axg_spdifout_regmap_cfg);
+	if (IS_ERR(priv->map)) {
+		dev_err(dev, "failed to init regmap: %ld\n",
+			PTR_ERR(priv->map));
+		return PTR_ERR(priv->map);
+	}
+
+	priv->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(priv->pclk)) {
+		ret = PTR_ERR(priv->pclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get pclk: %d\n", ret);
+		return ret;
+	}
+
+	priv->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(priv->mclk)) {
+		ret = PTR_ERR(priv->mclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get mclk: %d\n", ret);
+		return ret;
+	}
+
+	return devm_snd_soc_register_component(dev, &axg_spdifout_component_drv,
+			axg_spdifout_dai_drv, ARRAY_SIZE(axg_spdifout_dai_drv));
+}
+
+static struct platform_driver axg_spdifout_pdrv = {
+	.probe = axg_spdifout_probe,
+	.driver = {
+		.name = "axg-spdifout",
+		.of_match_table = axg_spdifout_of_match,
+	},
+};
+module_platform_driver(axg_spdifout_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG SPDIF Output driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

