Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7ADECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BE420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jgRdkV0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BE420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeGRNE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:04:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45458 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeGRNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Aqn4a8lGi1p49PoaMR4so5DupHdM+28c597pG/8t8iA=; b=jgRdkV0hsfG1
        Pca3x47fB+D650Ctdt2cjpQ48IlSYLKSVDVoG427WbaSy4NB/DYPNmEVvqbEoOrHGec/fUx6ss+aS
        eoecUyWgv/d/klkor+oVf0y3PSpL6KnecH0d7zAX7r7FA/ZojQE0in/uh8nb6QI9wozOyaQroNfcI
        HRb/k=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflXJ-0003Uw-O2; Wed, 18 Jul 2018 12:26:29 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflXJ-0007E9-8t; Wed, 18 Jul 2018 13:26:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add axg frddr driver" to the asoc tree
In-Reply-To:  <20180717153643.8806-4-jbrunet@baylibre.com>
Message-Id: <E1fflXJ-0007E9-8t@debutante>
Date:   Wed, 18 Jul 2018 13:26:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add axg frddr driver

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

From 57d552e3ea76003643b2e771042659ce71bac7c2 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:52 +0200
Subject: [PATCH] ASoC: meson: add axg frddr driver

Add the playback memory interface of Amlogic's axg SoCs.
This device pulls data from DDR to an internal FIFO.
This FIFO is then used to feed TDM and SPDIF Output devices.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/Kconfig     |   7 ++
 sound/soc/meson/Makefile    |   2 +
 sound/soc/meson/axg-frddr.c | 141 ++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 sound/soc/meson/axg-frddr.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index c3eb5e050308..cdd78f62e8d7 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -5,4 +5,11 @@ config SND_MESON_AXG_FIFO
 	tristate
 	select REGMAP_MMIO
 
+config SND_MESON_AXG_FRDDR
+	tristate "Amlogic AXG Playback FIFO support"
+	select SND_MESON_AXG_FIFO
+	help
+	  Select Y or M to add support for the frontend playback interfaces
+	  embedded in the Amlogic AXG SoC family
+
 endmenu
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index 75289b6b3ade..9c5d7d4a8e33 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
 
 snd-soc-meson-axg-fifo-objs := axg-fifo.o
+snd-soc-meson-axg-frddr-objs := axg-frddr.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
+obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
new file mode 100644
index 000000000000..a6f6f6a2eca8
--- /dev/null
+++ b/sound/soc/meson/axg-frddr.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+/* This driver implements the frontend playback DAI of AXG based SoCs */
+
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "axg-fifo.h"
+
+#define CTRL0_FRDDR_PP_MODE	BIT(30)
+
+static int axg_frddr_dai_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+	unsigned int fifo_depth, fifo_threshold;
+	int ret;
+
+	/* Enable pclk to access registers and clock the fifo ip */
+	ret = clk_prepare_enable(fifo->pclk);
+	if (ret)
+		return ret;
+
+	/* Apply single buffer mode to the interface */
+	regmap_update_bits(fifo->map, FIFO_CTRL0, CTRL0_FRDDR_PP_MODE, 0);
+
+	/*
+	 * TODO: We could adapt the fifo depth and the fifo threshold
+	 * depending on the expected memory throughput and lantencies
+	 * For now, we'll just use the same values as the vendor kernel
+	 * Depth and threshold are zero based.
+	 */
+	fifo_depth = AXG_FIFO_MIN_CNT - 1;
+	fifo_threshold = (AXG_FIFO_MIN_CNT / 2) - 1;
+	regmap_update_bits(fifo->map, FIFO_CTRL1,
+			   CTRL1_FRDDR_DEPTH_MASK | CTRL1_THRESHOLD_MASK,
+			   CTRL1_FRDDR_DEPTH(fifo_depth) |
+			   CTRL1_THRESHOLD(fifo_threshold));
+
+	return 0;
+}
+
+static void axg_frddr_dai_shutdown(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct axg_fifo *fifo = snd_soc_dai_get_drvdata(dai);
+
+	clk_disable_unprepare(fifo->pclk);
+}
+
+static int axg_frddr_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_soc_dai *dai)
+{
+	return axg_fifo_pcm_new(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+}
+
+static const struct snd_soc_dai_ops axg_frddr_ops = {
+	.startup	= axg_frddr_dai_startup,
+	.shutdown	= axg_frddr_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver axg_frddr_dai_drv = {
+	.name = "FRDDR",
+	.playback = {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= AXG_FIFO_CH_MAX,
+		.rates		= AXG_FIFO_RATES,
+		.formats	= AXG_FIFO_FORMATS,
+	},
+	.ops		= &axg_frddr_ops,
+	.pcm_new	= axg_frddr_pcm_new,
+};
+
+static const char * const axg_frddr_sel_texts[] = {
+	"OUT 0", "OUT 1", "OUT 2", "OUT 3"
+};
+
+static SOC_ENUM_SINGLE_DECL(axg_frddr_sel_enum, FIFO_CTRL0, CTRL0_SEL_SHIFT,
+			    axg_frddr_sel_texts);
+
+static const struct snd_kcontrol_new axg_frddr_out_demux =
+	SOC_DAPM_ENUM("Output Sink", axg_frddr_sel_enum);
+
+static const struct snd_soc_dapm_widget axg_frddr_dapm_widgets[] = {
+	SND_SOC_DAPM_DEMUX("SINK SEL", SND_SOC_NOPM, 0, 0,
+			   &axg_frddr_out_demux),
+	SND_SOC_DAPM_AIF_OUT("OUT 0", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route axg_frddr_dapm_routes[] = {
+	{ "SINK SEL", NULL, "Playback" },
+	{ "OUT 0", "OUT 0",  "SINK SEL" },
+	{ "OUT 1", "OUT 1",  "SINK SEL" },
+	{ "OUT 2", "OUT 2",  "SINK SEL" },
+	{ "OUT 3", "OUT 3",  "SINK SEL" },
+};
+
+static const struct snd_soc_component_driver axg_frddr_component_drv = {
+	.dapm_widgets		= axg_frddr_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(axg_frddr_dapm_widgets),
+	.dapm_routes		= axg_frddr_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(axg_frddr_dapm_routes),
+	.ops			= &axg_fifo_pcm_ops
+};
+
+static const struct axg_fifo_match_data axg_frddr_match_data = {
+	.component_drv	= &axg_frddr_component_drv,
+	.dai_drv	= &axg_frddr_dai_drv
+};
+
+static const struct of_device_id axg_frddr_of_match[] = {
+	{
+		.compatible = "amlogic,axg-frddr",
+		.data = &axg_frddr_match_data,
+	}, {}
+};
+MODULE_DEVICE_TABLE(of, axg_frddr_of_match);
+
+static struct platform_driver axg_frddr_pdrv = {
+	.probe = axg_fifo_probe,
+	.driver = {
+		.name = "axg-frddr",
+		.of_match_table = axg_frddr_of_match,
+	},
+};
+module_platform_driver(axg_frddr_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG playback fifo driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

