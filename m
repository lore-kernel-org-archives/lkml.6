Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC861ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFA420647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xwaBounN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFA420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGTRdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:33:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57618 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbeGTRdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TsnG6xOtMI51sfFGawxn+T/Eyk4yF+sJMIuOSfW3sjU=; b=xwaBounNFgHj
        awRMe9eu2zaNFJaSSPqLJG8EixdIkHIVMgZCS1avC3vsbzL1CLKRgxPD1yCoAgZKdRxCJexBYc+rH
        yh1fM+hWloYGqg/spdeQzXeQUdaFxTKz0qPyaG/9+NTWOc91LPPT59Aaws9tkQnnt0D/Bo6pHt8ux
        nKZSo=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYVQ-00005G-SN; Fri, 20 Jul 2018 16:43:48 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYVQ-0000oS-Ek; Fri, 20 Jul 2018 17:43:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add tdm input driver" to the asoc tree
In-Reply-To:  <20180717153643.8806-16-jbrunet@baylibre.com>
Message-Id: <E1fgYVQ-0000oS-Ek@debutante>
Date:   Fri, 20 Jul 2018 17:43:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add tdm input driver

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

From 13a22e6a98f8b47d61948fcd095d862377b3b143 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:43:01 +0200
Subject: [PATCH] ASoC: meson: add tdm input driver

Add Amlogic's axg TDM input driver which take the TDM signal of 4 input
lanes and push the decoded audio samples to TODDR fifo

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig     |   8 ++
 sound/soc/meson/Makefile    |   2 +
 sound/soc/meson/axg-tdmin.c | 229 ++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 sound/soc/meson/axg-tdmin.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 08a522b77749..00d05df67b52 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -27,6 +27,14 @@ config SND_MESON_AXG_TDM_INTERFACE
 	tristate
 	select SND_MESON_AXG_TDM_FORMATTER
 
+config SND_MESON_AXG_TDMIN
+	tristate "Amlogic AXG TDM Input Support"
+	select SND_MESON_AXG_TDM_FORMATTER
+	select SND_MESON_AXG_TDM_INTERFACE
+	help
+	  Select Y or M to add support for TDM input formatter embedded
+	  in the Amlogic AXG SoC family
+
 config SND_MESON_AXG_TDMOUT
 	tristate "Amlogic AXG TDM Output Support"
 	select SND_MESON_AXG_TDM_FORMATTER
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index a665c6b76a95..f62833fb44d8 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -5,6 +5,7 @@ snd-soc-meson-axg-frddr-objs := axg-frddr.o
 snd-soc-meson-axg-toddr-objs := axg-toddr.o
 snd-soc-meson-axg-tdm-formatter-objs := axg-tdm-formatter.o
 snd-soc-meson-axg-tdm-interface-objs := axg-tdm-interface.o
+snd-soc-meson-axg-tdmin-objs := axg-tdmin.o
 snd-soc-meson-axg-tdmout-objs := axg-tdmout.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 
@@ -13,5 +14,6 @@ obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
 obj-$(CONFIG_SND_MESON_AXG_TODDR) += snd-soc-meson-axg-toddr.o
 obj-$(CONFIG_SND_MESON_AXG_TDM_FORMATTER) += snd-soc-meson-axg-tdm-formatter.o
 obj-$(CONFIG_SND_MESON_AXG_TDM_INTERFACE) += snd-soc-meson-axg-tdm-interface.o
+obj-$(CONFIG_SND_MESON_AXG_TDMIN) += snd-soc-meson-axg-tdmin.o
 obj-$(CONFIG_SND_MESON_AXG_TDMOUT) += snd-soc-meson-axg-tdmout.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
new file mode 100644
index 000000000000..bbac44c81688
--- /dev/null
+++ b/sound/soc/meson/axg-tdmin.c
@@ -0,0 +1,229 @@
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
+#define TDMIN_CTRL			0x00
+#define  TDMIN_CTRL_ENABLE		BIT(31)
+#define  TDMIN_CTRL_I2S_MODE		BIT(30)
+#define  TDMIN_CTRL_RST_OUT		BIT(29)
+#define  TDMIN_CTRL_RST_IN		BIT(28)
+#define  TDMIN_CTRL_WS_INV		BIT(25)
+#define  TDMIN_CTRL_SEL_SHIFT		20
+#define  TDMIN_CTRL_IN_BIT_SKEW_MASK	GENMASK(18, 16)
+#define  TDMIN_CTRL_IN_BIT_SKEW(x)	((x) << 16)
+#define  TDMIN_CTRL_LSB_FIRST		BIT(5)
+#define  TDMIN_CTRL_BITNUM_MASK	GENMASK(4, 0)
+#define  TDMIN_CTRL_BITNUM(x)		((x) << 0)
+#define TDMIN_SWAP			0x04
+#define TDMIN_MASK0			0x08
+#define TDMIN_MASK1			0x0c
+#define TDMIN_MASK2			0x10
+#define TDMIN_MASK3			0x14
+#define TDMIN_STAT			0x18
+#define TDMIN_MUTE_VAL			0x1c
+#define TDMIN_MUTE0			0x20
+#define TDMIN_MUTE1			0x24
+#define TDMIN_MUTE2			0x28
+#define TDMIN_MUTE3			0x2c
+
+static const struct regmap_config axg_tdmin_regmap_cfg = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= TDMIN_MUTE3,
+};
+
+static const char * const axg_tdmin_sel_texts[] = {
+	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 5",
+};
+
+/* Change to special mux control to reset dapm */
+static SOC_ENUM_SINGLE_DECL(axg_tdmin_sel_enum, TDMIN_CTRL,
+			    TDMIN_CTRL_SEL_SHIFT, axg_tdmin_sel_texts);
+
+static const struct snd_kcontrol_new axg_tdmin_in_mux =
+	SOC_DAPM_ENUM("Input Source", axg_tdmin_sel_enum);
+
+static struct snd_soc_dai *
+axg_tdmin_get_be(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p = NULL;
+	struct snd_soc_dai *be;
+
+	snd_soc_dapm_widget_for_each_source_path(w, p) {
+		if (!p->connect)
+			continue;
+
+		if (p->source->id == snd_soc_dapm_dai_out)
+			return (struct snd_soc_dai *)p->source->priv;
+
+		be = axg_tdmin_get_be(p->source);
+		if (be)
+			return be;
+	}
+
+	return NULL;
+}
+
+static struct axg_tdm_stream *
+axg_tdmin_get_tdm_stream(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dai *be = axg_tdmin_get_be(w);
+
+	if (!be)
+		return NULL;
+
+	return be->capture_dma_data;
+}
+
+static void axg_tdmin_enable(struct regmap *map)
+{
+	/* Apply both reset */
+	regmap_update_bits(map, TDMIN_CTRL,
+			   TDMIN_CTRL_RST_OUT | TDMIN_CTRL_RST_IN, 0);
+
+	/* Clear out reset before in reset */
+	regmap_update_bits(map, TDMIN_CTRL,
+			   TDMIN_CTRL_RST_OUT, TDMIN_CTRL_RST_OUT);
+	regmap_update_bits(map, TDMIN_CTRL,
+			   TDMIN_CTRL_RST_IN,  TDMIN_CTRL_RST_IN);
+
+	/* Actually enable tdmin */
+	regmap_update_bits(map, TDMIN_CTRL,
+			   TDMIN_CTRL_ENABLE, TDMIN_CTRL_ENABLE);
+}
+
+static void axg_tdmin_disable(struct regmap *map)
+{
+	regmap_update_bits(map, TDMIN_CTRL, TDMIN_CTRL_ENABLE, 0);
+}
+
+static int axg_tdmin_prepare(struct regmap *map, struct axg_tdm_stream *ts)
+{
+	unsigned int val = 0;
+
+	/* Set stream skew */
+	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_DSP_A:
+		val |= TDMIN_CTRL_IN_BIT_SKEW(3);
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_DSP_B:
+		val = TDMIN_CTRL_IN_BIT_SKEW(2);
+		break;
+
+	default:
+		pr_err("Unsupported format: %u\n",
+		       ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	/* Set stream format mode */
+	switch (ts->iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		val |= TDMIN_CTRL_I2S_MODE;
+		break;
+	}
+
+	/* If the sample clock is inverted, invert it back for the formatter */
+	if (axg_tdm_lrclk_invert(ts->iface->fmt))
+		val |= TDMIN_CTRL_WS_INV;
+
+	/* Set the slot width */
+	val |= TDMIN_CTRL_BITNUM(ts->iface->slot_width - 1);
+
+	/*
+	 * The following also reset LSB_FIRST which result in the formatter
+	 * placing the first bit received at bit 31
+	 */
+	regmap_update_bits(map, TDMIN_CTRL,
+			   (TDMIN_CTRL_IN_BIT_SKEW_MASK | TDMIN_CTRL_WS_INV |
+			    TDMIN_CTRL_I2S_MODE | TDMIN_CTRL_LSB_FIRST |
+			    TDMIN_CTRL_BITNUM_MASK), val);
+
+	/* Set static swap mask configuration */
+	regmap_write(map, TDMIN_SWAP, 0x76543210);
+
+	return axg_tdm_formatter_set_channel_masks(map, ts, TDMIN_MASK0);
+}
+
+static const struct snd_soc_dapm_widget axg_tdmin_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &axg_tdmin_in_mux),
+	SND_SOC_DAPM_PGA_E("DEC", SND_SOC_NOPM, 0, 0, NULL, 0,
+			   axg_tdm_formatter_event,
+			   (SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD)),
+	SND_SOC_DAPM_AIF_OUT("OUT", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route axg_tdmin_dapm_routes[] = {
+	{ "SRC SEL", "IN 0", "IN 0" },
+	{ "SRC SEL", "IN 1", "IN 1" },
+	{ "SRC SEL", "IN 2", "IN 2" },
+	{ "SRC SEL", "IN 3", "IN 3" },
+	{ "SRC SEL", "IN 4", "IN 4" },
+	{ "SRC SEL", "IN 5", "IN 5" },
+	{ "DEC", NULL, "SRC SEL" },
+	{ "OUT", NULL, "DEC" },
+};
+
+static const struct snd_soc_component_driver axg_tdmin_component_drv = {
+	.dapm_widgets		= axg_tdmin_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_tdmin_dapm_widgets),
+	.dapm_routes		= axg_tdmin_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_tdmin_dapm_routes),
+};
+
+static const struct axg_tdm_formatter_ops axg_tdmin_ops = {
+	.get_stream	= axg_tdmin_get_tdm_stream,
+	.prepare	= axg_tdmin_prepare,
+	.enable		= axg_tdmin_enable,
+	.disable	= axg_tdmin_disable,
+};
+
+static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
+	.component_drv	= &axg_tdmin_component_drv,
+	.regmap_cfg	= &axg_tdmin_regmap_cfg,
+	.ops		= &axg_tdmin_ops,
+	.invert_sclk	= false,
+};
+
+static const struct of_device_id axg_tdmin_of_match[] = {
+	{
+		.compatible = "amlogic,axg-tdmin",
+		.data = &axg_tdmin_drv,
+	}, {}
+};
+MODULE_DEVICE_TABLE(of, axg_tdmin_of_match);
+
+static struct platform_driver axg_tdmin_pdrv = {
+	.probe = axg_tdm_formatter_probe,
+	.driver = {
+		.name = "axg-tdmin",
+		.of_match_table = axg_tdmin_of_match,
+	},
+};
+module_platform_driver(axg_tdmin_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG TDM input formatter driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

