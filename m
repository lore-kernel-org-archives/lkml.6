Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E32ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21E420849
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sJg72sW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21E420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeGQQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35190 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbeGQQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id y22-v6so2009838wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWzx6WQNW9Bzj3tVg8EpFPsjv6MBgDW2jvjTa29j8eg=;
        b=sJg72sW4T1TEQwtVDgkDy0e+lynNHMX6ayN/quvqW65agBYDqAwrPo46JfqktoUitR
         fcs5A3+dj2hPOlqM592u1FYx4TAGGqYNl8lCsd8m4RpUtu9CNbUVj54ZLpnaagxYT1he
         AOrqO/p0XcOwl+S5/StUdT0CPPNLFGhZMwpzToxqObrjemj56CNUBfR5XtfvJaLc3ru/
         kNBBXe9QnlHdiE2p3KzDV7xkwMTfZcb8AwnZkNFEwCnYTgfVkS25wTA+GeMjSSv+cR2D
         pSK4DbJO64sspcDQtzhdSZcS9N0Oy+UgvtxevfTMC1mLI3ptkRWYCjCjI17DsXGEoKmx
         /djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWzx6WQNW9Bzj3tVg8EpFPsjv6MBgDW2jvjTa29j8eg=;
        b=V1taxemh2W5qvFLFrXy8GZf7WfN2/9vBnIxkDQ+7Z9JNmHayrDA4jXsstuEemTweYs
         xyDSe3nWT91tUskoYXg++4UMe9ekCqrcunibfGKaCmNNh5SYWMyZt5Wt3lkFH1bUCJbQ
         NnilScl45Bg14rAklaUDHFSM+g6TjnizZs4LdSr1pG/SZxJmsiETBlCThj5IH1ZFHkR2
         dAFRLAeFqtsR9JQizkdf5nnFHSJ4vzlceCktsPElYBDHwsgiwGJWFU+915+5YWaefvNH
         ec5IYBDsRTYyNfV82PgXhlUhM1PS5wp61/wLD8/30GBgaPXsE07W9S94zzHxyYRkC2ZM
         KJTw==
X-Gm-Message-State: AOUpUlEyXKI8fgj4ROFyGzkOE4fYLW3hFfvTLURSfNoYmpkmh+65nogI
        +/IuQejgstDdzyGO3V8VRBxDWw==
X-Google-Smtp-Source: AAOMgpefyZ6bPFkdUlPAntRjlw4YtLecNOPCrHzjLZMEwMQUp8rGXVhITwPTm9bKsVdiK5HKLobAqA==
X-Received: by 2002:a1c:180e:: with SMTP id 14-v6mr1735531wmy.120.1531841820760;
        Tue, 17 Jul 2018 08:37:00 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:37:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 10/15] ASoC: meson: add tdm interface driver
Date:   Tue, 17 Jul 2018 17:36:37 +0200
Message-Id: <20180717153643.8806-14-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Amlogic's axg TDM interface driver. This driver manages the format
and clocks provided on the pads.

On this SoC, each stream direction provides 4 serial lanes. This makes
a maximum of 8 channels in i2s modes and 128 channels in DSP modes.

While each lanes operate on the same slot number (same bit clock), they
may have different TDM masks. This requires to provide a function to let
the card set the 4 masks, in lieu of the usual set_tdm_slots() callback
of the dai driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig             |   4 +
 sound/soc/meson/Makefile            |   2 +
 sound/soc/meson/axg-tdm-interface.c | 542 ++++++++++++++++++++++++++++++++++++
 sound/soc/meson/axg-tdm.h           |   4 +
 4 files changed, 552 insertions(+)
 create mode 100644 sound/soc/meson/axg-tdm-interface.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 80a88689491f..869b359c2ce7 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -23,6 +23,10 @@ config SND_MESON_AXG_TDM_FORMATTER
 	tristate
 	select REGMAP_MMIO
 
+config SND_MESON_AXG_TDM_INTERFACE
+	tristate
+	select SND_MESON_AXG_TDM_FORMATTER
+
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	imply SND_SOC_SPDIF
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index a06b56a1c995..1a8eb77402e3 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -4,10 +4,12 @@ snd-soc-meson-axg-fifo-objs := axg-fifo.o
 snd-soc-meson-axg-frddr-objs := axg-frddr.o
 snd-soc-meson-axg-toddr-objs := axg-toddr.o
 snd-soc-meson-axg-tdm-formatter-objs := axg-tdm-formatter.o
+snd-soc-meson-axg-tdm-interface-objs := axg-tdm-interface.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
 obj-$(CONFIG_SND_MESON_AXG_FRDDR) += snd-soc-meson-axg-frddr.o
 obj-$(CONFIG_SND_MESON_AXG_TODDR) += snd-soc-meson-axg-toddr.o
 obj-$(CONFIG_SND_MESON_AXG_TDM_FORMATTER) += snd-soc-meson-axg-tdm-formatter.o
+obj-$(CONFIG_SND_MESON_AXG_TDM_INTERFACE) += snd-soc-meson-axg-tdm-interface.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
new file mode 100644
index 000000000000..7b8baf46d968
--- /dev/null
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "axg-tdm.h"
+
+enum {
+	TDM_IFACE_PAD,
+	TDM_IFACE_LOOPBACK,
+};
+
+static unsigned int axg_tdm_slots_total(u32 *mask)
+{
+	unsigned int slots = 0;
+	int i;
+
+	if (!mask)
+		return 0;
+
+	/* Count the total number of slots provided by all 4 lanes */
+	for (i = 0; i < AXG_TDM_NUM_LANES; i++)
+		slots += hweight32(mask[i]);
+
+	return slots;
+}
+
+int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
+			  u32 *rx_mask, unsigned int slots,
+			  unsigned int slot_width)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	struct axg_tdm_stream *tx = (struct axg_tdm_stream *)
+		dai->playback_dma_data;
+	struct axg_tdm_stream *rx = (struct axg_tdm_stream *)
+		dai->capture_dma_data;
+	unsigned int tx_slots, rx_slots;
+
+	tx_slots = axg_tdm_slots_total(tx_mask);
+	rx_slots = axg_tdm_slots_total(rx_mask);
+
+	/* We should at least have a slot for a valid interface */
+	if (!tx_slots && !rx_slots) {
+		dev_err(dai->dev, "interface has no slot\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Amend the dai driver channel number and let dpcm channel merge do
+	 * its job
+	 */
+	if (tx) {
+		tx->mask = tx_mask;
+		dai->driver->playback.channels_max = tx_slots;
+	}
+
+	if (rx) {
+		rx->mask = rx_mask;
+		dai->driver->capture.channels_max = rx_slots;
+	}
+
+	iface->slots = slots;
+
+	switch (slot_width) {
+	case 0:
+		/* defaults width to 32 if not provided */
+		iface->slot_width = 32;
+		break;
+	case 8:
+	case 16:
+	case 24:
+	case 32:
+		iface->slot_width = slot_width;
+		break;
+	default:
+		dev_err(dai->dev, "unsupported slot width: %d\n", slot_width);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(axg_tdm_set_tdm_slots);
+
+static int axg_tdm_iface_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+				    unsigned int freq, int dir)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	int ret = -ENOTSUPP;
+
+	if (dir == SND_SOC_CLOCK_OUT && clk_id == 0) {
+		if (!iface->mclk) {
+			dev_warn(dai->dev, "master clock not provided\n");
+		} else {
+			ret = clk_set_rate(iface->mclk, freq);
+			if (!ret)
+				iface->mclk_rate = freq;
+		}
+	}
+
+	return ret;
+}
+
+static int axg_tdm_iface_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+
+	/* These modes are not supported */
+	if (fmt & (SND_SOC_DAIFMT_CBS_CFM | SND_SOC_DAIFMT_CBM_CFS)) {
+		dev_err(dai->dev, "only CBS_CFS and CBM_CFM are supported\n");
+		return -EINVAL;
+	}
+
+	/* If the TDM interface is the clock master, it requires mclk */
+	if (!iface->mclk && (fmt & SND_SOC_DAIFMT_CBS_CFS)) {
+		dev_err(dai->dev, "cpu clock master: mclk missing\n");
+		return -ENODEV;
+	}
+
+	iface->fmt = fmt;
+	return 0;
+}
+
+static int axg_tdm_iface_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	struct axg_tdm_stream *ts =
+		snd_soc_dai_get_dma_data(dai, substream);
+	int ret;
+
+	if (!axg_tdm_slots_total(ts->mask)) {
+		dev_err(dai->dev, "interface has not slots\n");
+		return -EINVAL;
+	}
+
+	/* Apply component wide rate symmetry */
+	if (dai->component->active) {
+		ret = snd_pcm_hw_constraint_single(substream->runtime,
+						   SNDRV_PCM_HW_PARAM_RATE,
+						   iface->rate);
+		if (ret < 0) {
+			dev_err(dai->dev,
+				"can't set iface rate constraint\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int axg_tdm_iface_set_stream(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params,
+				    struct snd_soc_dai *dai)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+	unsigned int channels = params_channels(params);
+	unsigned int width = params_width(params);
+
+	/* Save rate and sample_bits for component symmetry */
+	iface->rate = params_rate(params);
+
+	/* Make sure this interface can cope with the stream */
+	if (axg_tdm_slots_total(ts->mask) < channels) {
+		dev_err(dai->dev, "not enough slots for channels\n");
+		return -EINVAL;
+	}
+
+	if (iface->slot_width < width) {
+		dev_err(dai->dev, "incompatible slots width for stream\n");
+		return -EINVAL;
+	}
+
+	/* Save the parameter for tdmout/tdmin widgets */
+	ts->physical_width = params_physical_width(params);
+	ts->width = params_width(params);
+	ts->channels = params_channels(params);
+
+	return 0;
+}
+
+static int axg_tdm_iface_set_lrclk(struct snd_soc_dai *dai,
+				   struct snd_pcm_hw_params *params)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	unsigned int ratio_num;
+	int ret;
+
+	ret = clk_set_rate(iface->lrclk, params_rate(params));
+	if (ret) {
+		dev_err(dai->dev, "setting sample clock failed: %d\n", ret);
+		return ret;
+	}
+
+	switch (iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		/* 50% duty cycle ratio */
+		ratio_num = 1;
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
+		/*
+		 * A zero duty cycle ratio will result in setting the mininum
+		 * ratio possible which, for this clock, is 1 cycle of the
+		 * parent bclk clock high and the rest low, This is exactly
+		 * what we want here.
+		 */
+		ratio_num = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	ret = clk_set_duty_cycle(iface->lrclk, ratio_num, 2);
+	if (ret) {
+		dev_err(dai->dev,
+			"setting sample clock duty cycle failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Set sample clock inversion */
+	ret = clk_set_phase(iface->lrclk,
+			    axg_tdm_lrclk_invert(iface->fmt) ? 180 : 0);
+	if (ret) {
+		dev_err(dai->dev,
+			"setting sample clock phase failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
+				  struct snd_pcm_hw_params *params)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	unsigned long srate;
+	int ret;
+
+	srate = iface->slots * iface->slot_width * params_rate(params);
+
+	if (!iface->mclk_rate) {
+		/* If no specific mclk is requested, default to bit clock * 4 */
+		clk_set_rate(iface->mclk, 4 * srate);
+	} else {
+		/* Check if we can actually get the bit clock from mclk */
+		if (iface->mclk_rate % srate) {
+			dev_err(dai->dev,
+				"can't derive sclk %lu from mclk %lu\n",
+				srate, iface->mclk_rate);
+			return -EINVAL;
+		}
+	}
+
+	ret = clk_set_rate(iface->sclk, srate);
+	if (ret) {
+		dev_err(dai->dev, "setting bit clock failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Set the bit clock inversion */
+	ret = clk_set_phase(iface->sclk,
+			    axg_tdm_sclk_invert(iface->fmt) ? 0 : 180);
+	if (ret) {
+		dev_err(dai->dev, "setting bit clock phase failed: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	switch (iface->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		if (iface->slots > 2) {
+			dev_err(dai->dev, "bad slot number for format: %d\n",
+				iface->slots);
+			return -EINVAL;
+		}
+		break;
+
+	case SND_SOC_DAI_FORMAT_DSP_A:
+	case SND_SOC_DAI_FORMAT_DSP_B:
+		break;
+
+	default:
+		dev_err(dai->dev, "unsupported dai format\n");
+		return -EINVAL;
+	}
+
+	ret = axg_tdm_iface_set_stream(substream, params, dai);
+	if (ret)
+		return ret;
+
+	if (iface->fmt & SND_SOC_DAIFMT_CBS_CFS) {
+		ret = axg_tdm_iface_set_sclk(dai, params);
+		if (ret)
+			return ret;
+
+		ret = axg_tdm_iface_set_lrclk(dai, params);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+
+	/* Stop all attached formatters */
+	axg_tdm_stream_stop(ts);
+
+	return 0;
+}
+
+static int axg_tdm_iface_prepare(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
+
+	/* Force all attached formatters to update */
+	return axg_tdm_stream_reset(ts);
+}
+
+static int axg_tdm_iface_remove_dai(struct snd_soc_dai *dai)
+{
+	if (dai->capture_dma_data)
+		axg_tdm_stream_free(dai->capture_dma_data);
+
+	if (dai->playback_dma_data)
+		axg_tdm_stream_free(dai->playback_dma_data);
+
+	return 0;
+}
+
+static int axg_tdm_iface_probe_dai(struct snd_soc_dai *dai)
+{
+	struct axg_tdm_iface *iface = snd_soc_dai_get_drvdata(dai);
+
+	if (dai->capture_widget) {
+		dai->capture_dma_data = axg_tdm_stream_alloc(iface);
+		if (!dai->capture_dma_data)
+			return -ENOMEM;
+	}
+
+	if (dai->playback_widget) {
+		dai->playback_dma_data = axg_tdm_stream_alloc(iface);
+		if (!dai->playback_dma_data) {
+			axg_tdm_iface_remove_dai(dai);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
+	.set_sysclk	= axg_tdm_iface_set_sysclk,
+	.set_fmt	= axg_tdm_iface_set_fmt,
+	.startup	= axg_tdm_iface_startup,
+	.hw_params	= axg_tdm_iface_hw_params,
+	.prepare	= axg_tdm_iface_prepare,
+	.hw_free	= axg_tdm_iface_hw_free,
+};
+
+/* TDM Backend DAIs */
+static const struct snd_soc_dai_driver axg_tdm_iface_dai_drv[] = {
+	[TDM_IFACE_PAD] = {
+		.name = "TDM Pad",
+		.playback = {
+			.stream_name	= "Playback",
+			.channels_min	= 1,
+			.channels_max	= AXG_TDM_CHANNEL_MAX,
+			.rates		= AXG_TDM_RATES,
+			.formats	= AXG_TDM_FORMATS,
+		},
+		.capture = {
+			.stream_name	= "Capture",
+			.channels_min	= 1,
+			.channels_max	= AXG_TDM_CHANNEL_MAX,
+			.rates		= AXG_TDM_RATES,
+			.formats	= AXG_TDM_FORMATS,
+		},
+		.id = TDM_IFACE_PAD,
+		.ops = &axg_tdm_iface_ops,
+		.probe = axg_tdm_iface_probe_dai,
+		.remove = axg_tdm_iface_remove_dai,
+	},
+	[TDM_IFACE_LOOPBACK] = {
+		.name = "TDM Loopback",
+		.capture = {
+			.stream_name	= "Loopback",
+			.channels_min	= 1,
+			.channels_max	= AXG_TDM_CHANNEL_MAX,
+			.rates		= AXG_TDM_RATES,
+			.formats	= AXG_TDM_FORMATS,
+		},
+		.id = TDM_IFACE_LOOPBACK,
+		.ops = &axg_tdm_iface_ops,
+		.probe = axg_tdm_iface_probe_dai,
+		.remove = axg_tdm_iface_remove_dai,
+	},
+};
+
+static int axg_tdm_iface_set_bias_level(struct snd_soc_component *component,
+					enum snd_soc_bias_level level)
+{
+	struct axg_tdm_iface *iface = snd_soc_component_get_drvdata(component);
+	enum snd_soc_bias_level now =
+		snd_soc_component_get_bias_level(component);
+	int ret = 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (now == SND_SOC_BIAS_STANDBY)
+			ret = clk_prepare_enable(iface->mclk);
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (now == SND_SOC_BIAS_PREPARE)
+			clk_disable_unprepare(iface->mclk);
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
+static const struct snd_soc_component_driver axg_tdm_iface_component_drv = {
+	.set_bias_level	= axg_tdm_iface_set_bias_level,
+};
+
+static const struct of_device_id axg_tdm_iface_of_match[] = {
+	{ .compatible = "amlogic,axg-tdm-iface", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, axg_tdm_iface_of_match);
+
+static int axg_tdm_iface_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct snd_soc_dai_driver *dai_drv;
+	struct axg_tdm_iface *iface;
+	int ret, i;
+
+	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
+	if (!iface)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, iface);
+
+	/*
+	 * Duplicate dai driver: depending on the slot masks configuration
+	 * We'll change the number of channel provided by DAI stream, so dpcm
+	 * channel merge can be done properly
+	 */
+	dai_drv = devm_kcalloc(dev, ARRAY_SIZE(axg_tdm_iface_dai_drv),
+			       sizeof(*dai_drv), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(axg_tdm_iface_dai_drv); i++)
+		memcpy(&dai_drv[i], &axg_tdm_iface_dai_drv[i],
+		       sizeof(*dai_drv));
+
+	/* Bit clock provided on the pad */
+	iface->sclk = devm_clk_get(dev, "sclk");
+	if (IS_ERR(iface->sclk)) {
+		ret = PTR_ERR(iface->sclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get sclk: %d\n", ret);
+		return ret;
+	}
+
+	/* Sample clock provided on the pad */
+	iface->lrclk = devm_clk_get(dev, "lrclk");
+	if (IS_ERR(iface->lrclk)) {
+		ret = PTR_ERR(iface->lrclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get lrclk: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * mclk maybe be missing when the cpu dai is in slave mode and
+	 * the codec does not require it to provide a master clock.
+	 * At this point, ignore the error if mclk is missing. We'll
+	 * throw an error if the cpu dai is master and mclk is missing
+	 */
+	iface->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(iface->mclk)) {
+		ret = PTR_ERR(iface->mclk);
+		if (ret == -ENOENT) {
+			iface->mclk = NULL;
+		} else {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "failed to get mclk: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return devm_snd_soc_register_component(dev,
+					&axg_tdm_iface_component_drv, dai_drv,
+					ARRAY_SIZE(axg_tdm_iface_dai_drv));
+}
+
+static struct platform_driver axg_tdm_iface_pdrv = {
+	.probe = axg_tdm_iface_probe,
+	.driver = {
+		.name = "axg-tdm-iface",
+		.of_match_table = axg_tdm_iface_of_match,
+	},
+};
+module_platform_driver(axg_tdm_iface_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG TDM interface driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/meson/axg-tdm.h b/sound/soc/meson/axg-tdm.h
index 435d95b86457..e578b6f40a07 100644
--- a/sound/soc/meson/axg-tdm.h
+++ b/sound/soc/meson/axg-tdm.h
@@ -71,4 +71,8 @@ static inline int axg_tdm_stream_reset(struct axg_tdm_stream *ts)
 	return axg_tdm_stream_start(ts);
 }
 
+int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
+			  u32 *rx_mask, unsigned int slots,
+			  unsigned int slot_width);
+
 #endif /* _MESON_AXG_TDM_H */
-- 
2.14.4

