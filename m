Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F37ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD4E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="anzL6VIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD4E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbeGTRdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:33:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeGTRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=G9TSImllRdqGo3+7kQ5yLpvZKpqYcvxltSfPDBsXnCg=; b=anzL6VInNVlT
        BaIvZO4dQKy244wtz3lz/z75knJZ/96Wb+Xi9nW09cOsBP2HjkRRYBGjeZ50uqKKxQA9jgiSKeOst
        Ujv08UQ3pKGiUUL6FgpBAfEmxPuRIQmvGyXGMdj4KJGuQEb861/RUPtvw8Np5C0teL66VhjOYdO4w
        xoIGQ=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYVS-00005N-Ph; Fri, 20 Jul 2018 16:43:50 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYVS-0000rI-Bt; Fri, 20 Jul 2018 17:43:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add tdm output driver" to the asoc tree
In-Reply-To:  <20180717153643.8806-15-jbrunet@baylibre.com>
Message-Id: <E1fgYVS-0000rI-Bt@debutante>
Date:   Fri, 20 Jul 2018 17:43:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add tdm output driver

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

From c41c2a355b86368608377eaf3df442ec0f342f1e Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:43:00 +0200
Subject: [PATCH] ASoC: meson: add tdm output driver

Add Amlogic's axg tdm output driver which pulls data from FRDDR fifo
and produce the TDM signals for 4 output lanes.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig      |   8 ++
 sound/soc/meson/Makefile     |   2 +
 sound/soc/meson/axg-tdmout.c | 259 +++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 sound/soc/meson/axg-tdmout.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 869b359c2ce7..08a522b77749 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -27,6 +27,14 @@ config SND_MESON_AXG_TDM_INTERFACE
 	tristate
 	select SND_MESON_AXG_TDM_FORMATTER
 
+config SND_MESON_AXG_TDMOUT
+	tristate "Amlogic AXG TDM Output Support"
+	select SND_MESON_AXG_TDM_FORMATTER
+	select SND_MESON_AXG_TDM_INTERFACE
+	help
+	  Select Y or M to add support for TDM output formatter embedded
+	  in the Amlogic AXG SoC family
+
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	imply SND_SOC_SPDIF
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index 1a8eb77402e3..a665c6b76a95 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -5,6 +5,7 @@ snd-soc-meson-axg-frddr-objs := axg-frddr.o
 snd-soc-meson-axg-toddr-objs := axg-toddr.o
 snd-soc-meson-axg-tdm-formatter-objs := axg-tdm-formatter.o
 snd-soc-meson-axg-tdm-interface-objs := axg-tdm-interface.o
+snd-soc-meson-axg-tdmout-objs := axg-tdmout.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
@@ -12,4 +13,5 @@ obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
 obj-$(CONFIG_SND_MESON_AXG_TODDR) += snd-soc-meson-axg-toddr.o
 obj-$(CONFIG_SND_MESON_AXG_TDM_FORMATTER) += snd-soc-meson-axg-tdm-formatter.o
 obj-$(CONFIG_SND_MESON_AXG_TDM_INTERFACE) += snd-soc-meson-axg-tdm-interface.o
+obj-$(CONFIG_SND_MESON_AXG_TDMOUT) += snd-soc-meson-axg-tdmout.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
diff --git a/sound/soc/meson/axg-tdmout.c b/sound/soc/meson/axg-tdmout.c
new file mode 100644
index 000000000000..f73368ee1088
--- /dev/null
+++ b/sound/soc/meson/axg-tdmout.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "axg-tdm-formatter.h"
+
+#define TDMOUT_CTRL0			0x00
+#define  TDMOUT_CTRL0_BITNUM_MASK	GENMASK(4, 0)
+#define  TDMOUT_CTRL0_BITNUM(x)		((x) << 0)
+#define  TDMOUT_CTRL0_SLOTNUM_MASK	GENMASK(9, 5)
+#define  TDMOUT_CTRL0_SLOTNUM(x)	((x) << 5)
+#define  TDMOUT_CTRL0_INIT_BITNUM_MASK	GENMASK(19, 15)
+#define  TDMOUT_CTRL0_INIT_BITNUM(x)	((x) << 15)
+#define  TDMOUT_CTRL0_ENABLE		BIT(31)
+#define  TDMOUT_CTRL0_RST_OUT		BIT(29)
+#define  TDMOUT_CTRL0_RST_IN		BIT(28)
+#define TDMOUT_CTRL1			0x04
+#define  TDMOUT_CTRL1_TYPE_MASK		GENMASK(6, 4)
+#define  TDMOUT_CTRL1_TYPE(x)		((x) << 4)
+#define  TDMOUT_CTRL1_MSB_POS_MASK	GENMASK(12, 8)
+#define  TDMOUT_CTRL1_MSB_POS(x)	((x) << 8)
+#define  TDMOUT_CTRL1_SEL_SHIFT		24
+#define  TDMOUT_CTRL1_GAIN_EN		26
+#define  TDMOUT_CTRL1_WS_INV		BIT(28)
+#define TDMOUT_SWAP			0x08
+#define TDMOUT_MASK0			0x0c
+#define TDMOUT_MASK1			0x10
+#define TDMOUT_MASK2			0x14
+#define TDMOUT_MASK3			0x18
+#define TDMOUT_STAT			0x1c
+#define TDMOUT_GAIN0			0x20
+#define TDMOUT_GAIN1			0x24
+#define TDMOUT_MUTE_VAL			0x28
+#define TDMOUT_MUTE0			0x2c
+#define TDMOUT_MUTE1			0x30
+#define TDMOUT_MUTE2			0x34
+#define TDMOUT_MUTE3			0x38
+#define TDMOUT_MASK_VAL			0x3c
+
+static const struct regmap_config axg_tdmout_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= TDMOUT_MASK_VAL,
+};
+
+static const struct snd_kcontrol_new axg_tdmout_controls[] = {
+	SOC_DOUBLE("Lane 0 Volume", TDMOUT_GAIN0,  0,  8, 255, 0),
+	SOC_DOUBLE("Lane 1 Volume", TDMOUT_GAIN0, 16, 24, 255, 0),
+	SOC_DOUBLE("Lane 2 Volume", TDMOUT_GAIN1,  0,  8, 255, 0),
+	SOC_DOUBLE("Lane 3 Volume", TDMOUT_GAIN1, 16, 24, 255, 0),
+	SOC_SINGLE("Gain Enable Switch", TDMOUT_CTRL1,
+		   TDMOUT_CTRL1_GAIN_EN, 1, 0),
+};
+
+static const char * const tdmout_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2",
+};
+
+static SOC_ENUM_SINGLE_DECL(axg_tdmout_sel_enum, TDMOUT_CTRL1,
+			    TDMOUT_CTRL1_SEL_SHIFT, tdmout_sel_texts);
+
+static const struct snd_kcontrol_new axg_tdmout_in_mux =
+	SOC_DAPM_ENUM("Input Source", axg_tdmout_sel_enum);
+
+static struct snd_soc_dai *
+axg_tdmout_get_be(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dai *be;
+
+	snd_soc_dapm_widget_for_each_sink_path(w, p) {
+		if (!p->connect)
+			continue;
+
+		if (p->sink->id == snd_soc_dapm_dai_in)
+			return (struct snd_soc_dai *)p->sink->priv;
+
+		be = axg_tdmout_get_be(p->sink);
+		if (be)
+			return be;
+	}
+
+	return NULL;
+}
+
+static struct axg_tdm_stream *
+axg_tdmout_get_tdm_stream(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dai *be = axg_tdmout_get_be(w);
+
+	if (!be)
+		return NULL;
+
+	return be->playback_dma_data;
+}
+
+static void axg_tdmout_enable(struct regmap *map)
+{
+	/* Apply both reset */
+	regmap_update_bits(map, TDMOUT_CTRL0,
+			   TDMOUT_CTRL0_RST_OUT | TDMOUT_CTRL0_RST_IN, 0);
+
+	/* Clear out reset before in reset */
+	regmap_update_bits(map, TDMOUT_CTRL0,
+			   TDMOUT_CTRL0_RST_OUT, TDMOUT_CTRL0_RST_OUT);
+	regmap_update_bits(map, TDMOUT_CTRL0,
+			   TDMOUT_CTRL0_RST_IN,  TDMOUT_CTRL0_RST_IN);
+
+	/* Actually enable tdmout */
+	regmap_update_bits(map, TDMOUT_CTRL0,
+			   TDMOUT_CTRL0_ENABLE, TDMOUT_CTRL0_ENABLE);
+}
+
+static void axg_tdmout_disable(struct regmap *map)
+{
+	regmap_update_bits(map, TDMOUT_CTRL0, TDMOUT_CTRL0_ENABLE, 0);
+}
+
+static int axg_tdmout_prepare(struct regmap *map, struct axg_tdm_stream *ts)
+{
+	unsigned int val = 0;
+
+	/* Set the stream skew */
+	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_DSP_A:
+		val |= TDMOUT_CTRL0_INIT_BITNUM(1);
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_DSP_B:
+		val |= TDMOUT_CTRL0_INIT_BITNUM(2);
+		break;
+
+	default:
+		pr_err("Unsupported format: %u\n",
+		       ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	/* Set the slot width */
+	val |= TDMOUT_CTRL0_BITNUM(ts->iface->slot_width - 1);
+
+	/* Set the slot number */
+	val |= TDMOUT_CTRL0_SLOTNUM(ts->iface->slots - 1);
+
+	regmap_update_bits(map, TDMOUT_CTRL0,
+			   TDMOUT_CTRL0_INIT_BITNUM_MASK |
+			   TDMOUT_CTRL0_BITNUM_MASK |
+			   TDMOUT_CTRL0_SLOTNUM_MASK, val);
+
+	/* Set the sample width */
+	val = TDMOUT_CTRL1_MSB_POS(ts->width - 1);
+
+	/* FIFO data are arranged in chunks of 64bits */
+	switch (ts->physical_width) {
+	case 8:
+		/* 8 samples of 8 bits */
+		val |= TDMOUT_CTRL1_TYPE(0);
+		break;
+	case 16:
+		/* 4 samples of 16 bits - right justified */
+		val |= TDMOUT_CTRL1_TYPE(2);
+		break;
+	case 32:
+		/* 2 samples of 32 bits - right justified */
+		val |= TDMOUT_CTRL1_TYPE(4);
+		break;
+	default:
+		pr_err("Unsupported physical width: %u\n",
+		       ts->physical_width);
+		return -EINVAL;
+	}
+
+	/* If the sample clock is inverted, invert it back for the formatter */
+	if (axg_tdm_lrclk_invert(ts->iface->fmt))
+		val |= TDMOUT_CTRL1_WS_INV;
+
+	regmap_update_bits(map, TDMOUT_CTRL1,
+			   (TDMOUT_CTRL1_TYPE_MASK | TDMOUT_CTRL1_MSB_POS_MASK |
+			    TDMOUT_CTRL1_WS_INV), val);
+
+	/* Set static swap mask configuration */
+	regmap_write(map, TDMOUT_SWAP, 0x76543210);
+
+	return axg_tdm_formatter_set_channel_masks(map, ts, TDMOUT_MASK0);
+}
+
+static const struct snd_soc_dapm_widget axg_tdmout_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &axg_tdmout_in_mux),
+	SND_SOC_DAPM_PGA_E("ENC", SND_SOC_NOPM, 0, 0, NULL, 0,
+			   axg_tdm_formatter_event,
+			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD)),
+	SND_SOC_DAPM_AIF_OUT("OUT", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route axg_tdmout_dapm_routes[] = {
+	{ "SRC SEL", "IN 0", "IN 0" },
+	{ "SRC SEL", "IN 1", "IN 1" },
+	{ "SRC SEL", "IN 2", "IN 2" },
+	{ "ENC", NULL, "SRC SEL" },
+	{ "OUT", NULL, "ENC" },
+};
+
+static const struct snd_soc_component_driver axg_tdmout_component_drv = {
+	.controls		= axg_tdmout_controls,
+	.num_controls		= ARRAY_SIZE(axg_tdmout_controls),
+	.dapm_widgets		= axg_tdmout_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_tdmout_dapm_widgets),
+	.dapm_routes		= axg_tdmout_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_tdmout_dapm_routes),
+};
+
+static const struct axg_tdm_formatter_ops axg_tdmout_ops = {
+	.get_stream	= axg_tdmout_get_tdm_stream,
+	.prepare	= axg_tdmout_prepare,
+	.enable		= axg_tdmout_enable,
+	.disable	= axg_tdmout_disable,
+};
+
+static const struct axg_tdm_formatter_driver axg_tdmout_drv = {
+	.component_drv	= &axg_tdmout_component_drv,
+	.regmap_cfg	= &axg_tdmout_regmap_cfg,
+	.ops		= &axg_tdmout_ops,
+	.invert_sclk	= true,
+};
+
+static const struct of_device_id axg_tdmout_of_match[] = {
+	{
+		.compatible = "amlogic,axg-tdmout",
+		.data = &axg_tdmout_drv,
+	}, {}
+};
+MODULE_DEVICE_TABLE(of, axg_tdmout_of_match);
+
+static struct platform_driver axg_tdmout_pdrv = {
+	.probe = axg_tdm_formatter_probe,
+	.driver = {
+		.name = "axg-tdmout",
+		.of_match_table = axg_tdmout_of_match,
+	},
+};
+module_platform_driver(axg_tdmout_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG TDM output formatter driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

