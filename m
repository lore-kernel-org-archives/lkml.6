Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C33AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BA72086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x4h6FNFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BA72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbeGQQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:16:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbeGQQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:16:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so1745300wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vNkHdoHxDTeCb62fmSaQ1EzoUhqjgTMT8K04+gGWmyw=;
        b=x4h6FNFIbgslVABs4yx6Ef3hrKhmAIpPvW6tgE3K4xyzcCEy2n+ZA8Dcy9/SsbHkkY
         Vkae1JTqRp7WOdAthQ1i6XTIBVoFHbSztiYW8D7/HDfaL7w4evi/JmFmpH9DtLTqCVSx
         yNgNSBbhSb4zJnXUagOIB3xW1vvq+Gb+ydOxLUD7Lrmz9L0DOiHRbVNzDlJRv/qYLCEa
         U3ukyASfngFHyZ1aNM+e6C8cSnZ8EMDk8ytely5HlRXVL2KH4Mn1fC3J5OrEoNAgaIvK
         utIGTQqOqsHDldE9IfiXNTkKaU77aRojAOaiO1ToW1N/NQSlkXEjOgBeQnKBwxv5dSLn
         IcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vNkHdoHxDTeCb62fmSaQ1EzoUhqjgTMT8K04+gGWmyw=;
        b=c03ajeVd0d8SCwh33bYB+BormIE2eMH/I6uPY4iXu26Bu1JlMrOOplEUjdGK+f+CiX
         AHHRTcceRYqAUDzTER4G0a3BMZ/NtjFt5q5xpqcD/R8JggAVqpcCi8tFs4L9bp0UtSpV
         QVUaHQdfd8RWnHmSZ5yHVdHhQvLnmg7W3Lys4lWrbhfzTCNUG56QjYNbiHbfO915/EPw
         OMCm2Kb9dW1CiJ0Z+J6Gl5jaOQrecBwnpaMyFbtSjkCgq0TrYTUWOr8H26mBcAdRv1dE
         tBJUG/UmobdEQUjHNbBVkfeWWCfsGsZP790TrtMt6XX0/kxh3Oh3govrthee9nsT+AUA
         cbmA==
X-Gm-Message-State: AOUpUlEANHoeLJ4GSuMWbNosOlLwetiovJtR04SpVsUR1cvHCzJZEDEp
        2MivJr5AmFdkvxNaOGQYDI95Hw==
X-Google-Smtp-Source: AAOMgpe4658GPRpwI0WB+JptZhGZCyZlIY7k3Algxl2QNSmSGkshhF99koxbMBn/UQySAR+K5V6cSw==
X-Received: by 2002:adf:fe8f:: with SMTP id l15-v6mr1860963wrr.165.1531842196399;
        Tue, 17 Jul 2018 08:43:16 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s12-v6sm17598252wmc.2.2018.07.17.08.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:43:15 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH RESEND 03/15] ASoC: meson: add axg frddr driver
Date:   Tue, 17 Jul 2018 17:42:52 +0200
Message-Id: <20180717154304.9973-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717154304.9973-1-jbrunet@baylibre.com>
References: <20180717154304.9973-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the playback memory interface of Amlogic's axg SoCs.
This device pulls data from DDR to an internal FIFO.
This FIFO is then used to feed TDM and SPDIF Output devices.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig     |   7 +++
 sound/soc/meson/Makefile    |   2 +
 sound/soc/meson/axg-frddr.c | 141 ++++++++++++++++++++++++++++++++++++++++++++
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
2.14.4

