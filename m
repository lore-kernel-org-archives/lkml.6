Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51028ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC56F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RxDYlf1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC56F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeGQQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35201 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbeGQQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id y22-v6so2010275wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G74vTuT1DlINnuNuMu1EDadR9iCBF+SYA+UnFGqXqHY=;
        b=RxDYlf1JrGyxJSyNyC20Bvb40M8czIKRmWgRUIhPInyaTvaT24YB+rjnUR8lDac2FE
         ZGqADMcQK+KPlc3rz8XMvTnHJaBx2YCImDOftLmEibvXvv+X0A7+CzztzC08FoIwPnq5
         MXt5mUuf79yqVQTmo9WpfyVsezUsgg6jK871I4A0yWNA6iOXvgXvQKiR7b9pAK1dtMq1
         cI87OhA198qQNaQFlRtpKRo9MKadcoJLrtChWwqysEHNReF7DbEsF6jU7n9/fq7fFLx5
         J1GJHAd6VosfcYFwTk2D1c/907060es1U7UUF3/pIAUI8s2N7fJXFhxjtiTKfceLH2y9
         v82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G74vTuT1DlINnuNuMu1EDadR9iCBF+SYA+UnFGqXqHY=;
        b=RSUcZJR24bxC/YIf0BpPWXB3xQVbiW3Fy+A9imjUS/FIou8Fx5vGvFEIVrWdF8dD4q
         gAAC/ujtV356WwGVIU8m3Hxxn4C5HUFkkqsqApVZnZoEDFSF8AXA62bPyELmnqwybB11
         2eQ9cOOsML7q9CFZWq4NuUlmydzHQi/++gPbE3dNZg5unxB9QmzKdZE+9E5ch6Ji6Umx
         WFgUKYVNhA1QhM/2I/aSPdjHOs9S2hOG7KVuCsscaz2p5k4zWHpCHGL86v7VPaBB31tJ
         AMMwCKfCoFw8QWFZPagUGfX3BK5KZjFDwbE5ZXq3vE8hs+V4bA9O8mGIzS/Zmaav7/tJ
         aLbg==
X-Gm-Message-State: AOUpUlEgbh4wgCT08RgFqnM8OhCsePd3++0ujn3f6B0Qw1SfW4/F3SPE
        QY9nx0bX4LRXd//rPzSouuPKUw==
X-Google-Smtp-Source: AAOMgpczUvUeO5N0QEN2ekHsA+rc4v5aWuPHEe8cElR3qqTkpHJLdSMNmcFmdqQH4UF1iCSrybmfdQ==
X-Received: by 2002:a1c:9b43:: with SMTP id d64-v6mr1708288wme.109.1531841827384;
        Tue, 17 Jul 2018 08:37:07 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:37:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 15/15] ASoC: meson: add axg sound card support
Date:   Tue, 17 Jul 2018 17:36:43 +0200
Message-Id: <20180717153643.8806-20-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180717153643.8806-1-jbrunet@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the axg sound card to handle the specifities of the axg audio
sub system.

This card is required to:
 * setup the dpcm links specific to the AXG (with a cpu sound dai)
 * handle the 4 lanes masks of the tdm interfaces
 * add the loopback link when a tdm pad interface has a playback
   stream
 * handle multi-codec links

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Kconfig    |  11 +
 sound/soc/meson/Makefile   |   2 +
 sound/soc/meson/axg-card.c | 671 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 684 insertions(+)
 create mode 100644 sound/soc/meson/axg-card.c

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 00d05df67b52..4cf93c05a982 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -43,6 +43,17 @@ config SND_MESON_AXG_TDMOUT
 	  Select Y or M to add support for TDM output formatter embedded
 	  in the Amlogic AXG SoC family
 
+config SND_MESON_AXG_SOUND_CARD
+	tristate "Amlogic AXG Sound Card Support"
+	select SND_MESON_AXG_TDM_INTERFACE
+	imply SND_MESON_AXG_FRDDR
+	imply SND_MESON_AXG_TODDR
+	imply SND_MESON_AXG_TDMIN
+	imply SND_MESON_AXG_TDMOUT
+	imply SND_MESON_AXG_SPDIFOUT
+	help
+	  Select Y or M to add support for the AXG SoC sound card
+
 config SND_MESON_AXG_SPDIFOUT
 	tristate "Amlogic AXG SPDIF Output Support"
 	imply SND_SOC_SPDIF
diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index f62833fb44d8..c5e003b093db 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -7,6 +7,7 @@ snd-soc-meson-axg-tdm-formatter-objs := axg-tdm-formatter.o
 snd-soc-meson-axg-tdm-interface-objs := axg-tdm-interface.o
 snd-soc-meson-axg-tdmin-objs := axg-tdmin.o
 snd-soc-meson-axg-tdmout-objs := axg-tdmout.o
+snd-soc-meson-axg-sound-card-objs := axg-card.o
 snd-soc-meson-axg-spdifout-objs := axg-spdifout.o
 
 obj-$(CONFIG_SND_MESON_AXG_FIFO) += snd-soc-meson-axg-fifo.o
@@ -16,4 +17,5 @@ obj-$(CONFIG_SND_MESON_AXG_TDM_FORMATTER) += snd-soc-meson-axg-tdm-formatter.o
 obj-$(CONFIG_SND_MESON_AXG_TDM_INTERFACE) += snd-soc-meson-axg-tdm-interface.o
 obj-$(CONFIG_SND_MESON_AXG_TDMIN) += snd-soc-meson-axg-tdmin.o
 obj-$(CONFIG_SND_MESON_AXG_TDMOUT) += snd-soc-meson-axg-tdmout.o
+obj-$(CONFIG_SND_MESON_AXG_SOUND_CARD) += snd-soc-meson-axg-sound-card.o
 obj-$(CONFIG_SND_MESON_AXG_SPDIFOUT) += snd-soc-meson-axg-spdifout.o
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
new file mode 100644
index 000000000000..d6d1081d94ad
--- /dev/null
+++ b/sound/soc/meson/axg-card.c
@@ -0,0 +1,671 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright (c) 2018 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "axg-tdm.h"
+
+struct axg_card {
+	struct snd_soc_card card;
+	void **link_data;
+};
+
+struct axg_dai_link_tdm_mask {
+	u32 tx;
+	u32 rx;
+};
+
+struct axg_dai_link_tdm_data {
+	unsigned int mclk_fs;
+	unsigned int slots;
+	unsigned int slot_width;
+	u32 *tx_mask;
+	u32 *rx_mask;
+	struct axg_dai_link_tdm_mask *codec_masks;
+};
+
+#define PREFIX "amlogic,"
+
+static int axg_card_reallocate_links(struct axg_card *priv,
+				     unsigned int num_links)
+{
+	struct snd_soc_dai_link *links;
+	void **ldata;
+
+	links = krealloc(priv->card.dai_link,
+			 num_links * sizeof(*priv->card.dai_link),
+			 GFP_KERNEL | __GFP_ZERO);
+	ldata = krealloc(priv->link_data,
+			 num_links * sizeof(*priv->link_data),
+			 GFP_KERNEL | __GFP_ZERO);
+
+	if (!links || !ldata) {
+		dev_err(priv->card.dev, "failed to allocate links\n");
+		return -ENOMEM;
+	}
+
+	priv->card.dai_link = links;
+	priv->link_data = ldata;
+	priv->card.num_links = num_links;
+	return 0;
+}
+
+static int axg_card_parse_dai(struct snd_soc_card *card,
+			      struct device_node *node,
+			      struct device_node **dai_of_node,
+			      const char **dai_name)
+{
+	struct of_phandle_args args;
+	int ret;
+
+	if (!dai_name || !dai_of_node || !node)
+		return -EINVAL;
+
+	ret = of_parse_phandle_with_args(node, "sound-dai",
+					 "#sound-dai-cells", 0, &args);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(card->dev, "can't parse dai %d\n", ret);
+		return ret;
+	}
+	*dai_of_node = args.np;
+
+	return snd_soc_get_dai_name(&args, dai_name);
+}
+
+static int axg_card_set_link_name(struct snd_soc_card *card,
+				  struct snd_soc_dai_link *link,
+				  const char *prefix)
+{
+	char *name = devm_kasprintf(card->dev, GFP_KERNEL, "%s.%s",
+				    prefix, link->cpu_of_node->full_name);
+	if (!name)
+		return -ENOMEM;
+
+	link->name = name;
+	link->stream_name = name;
+
+	return 0;
+}
+
+static void axg_card_clean_references(struct axg_card *priv)
+{
+	struct snd_soc_card *card = &priv->card;
+	struct snd_soc_dai_link *link;
+	int i, j;
+
+	if (card->dai_link) {
+		for (i = 0; i < card->num_links; i++) {
+			link = &card->dai_link[i];
+			of_node_put(link->cpu_of_node);
+			for (j = 0; j < link->num_codecs; j++)
+				of_node_put(link->codecs[j].of_node);
+		}
+	}
+
+	if (card->aux_dev) {
+		for (i = 0; i < card->num_aux_devs; i++)
+			of_node_put(card->aux_dev[i].codec_of_node);
+	}
+
+	kfree(card->dai_link);
+	kfree(priv->link_data);
+}
+
+static int axg_card_add_aux_devices(struct snd_soc_card *card)
+{
+	struct device_node *node = card->dev->of_node;
+	struct snd_soc_aux_dev *aux;
+	int num, i;
+
+	num = of_count_phandle_with_args(node, PREFIX "aux-devs", NULL);
+	if (num == -ENOENT) {
+		/*
+		 * It is ok to have no auxiliary devices but for this card it
+		 * is a strange situtation. Let's warn the about it.
+		 */
+		dev_warn(card->dev, "card has no auxiliary devices\n");
+		return 0;
+	} else if (num < 0) {
+		dev_err(card->dev, "error getting auxiliary devices: %d\n",
+			num);
+		return num;
+	}
+
+	aux = devm_kcalloc(card->dev, num, sizeof(*aux), GFP_KERNEL);
+	if (!aux)
+		return -ENOMEM;
+	card->aux_dev = aux;
+	card->num_aux_devs = num;
+
+	for (i = 0; i < card->num_aux_devs; i++, aux++) {
+		aux->codec_of_node = of_parse_phandle(node,
+						      PREFIX "aux-devs", i);
+		if (!aux->codec_of_node)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int axg_card_tdm_be_hw_params(struct snd_pcm_substream *substream,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct axg_card *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct axg_dai_link_tdm_data *be =
+		(struct axg_dai_link_tdm_data *)priv->link_data[rtd->num];
+	struct snd_soc_dai *codec_dai;
+	unsigned int mclk;
+	int ret, i;
+
+	if (be->mclk_fs) {
+		mclk = params_rate(params) * be->mclk_fs;
+
+		for (i = 0; i < rtd->num_codecs; i++) {
+			codec_dai = rtd->codec_dais[i];
+			ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+						     SND_SOC_CLOCK_IN);
+			if (ret && ret != -ENOTSUPP)
+				return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, 0, mclk,
+					     SND_SOC_CLOCK_OUT);
+		if (ret && ret != -ENOTSUPP)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_ops axg_card_tdm_be_ops = {
+	.hw_params = axg_card_tdm_be_hw_params,
+};
+
+static int axg_card_tdm_dai_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct axg_card *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct axg_dai_link_tdm_data *be =
+		(struct axg_dai_link_tdm_data *)priv->link_data[rtd->num];
+	struct snd_soc_dai *codec_dai;
+	int ret, i;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		ret = snd_soc_dai_set_tdm_slot(codec_dai,
+					       be->codec_masks[i].tx,
+					       be->codec_masks[i].rx,
+					       be->slots, be->slot_width);
+		if (ret && ret != -ENOTSUPP) {
+			dev_err(codec_dai->dev,
+				"setting tdm link slots failed\n");
+			return ret;
+		}
+	}
+
+	ret = axg_tdm_set_tdm_slots(rtd->cpu_dai, be->tx_mask, be->rx_mask,
+				    be->slots, be->slot_width);
+	if (ret) {
+		dev_err(rtd->cpu_dai->dev, "setting tdm link slots failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int axg_card_tdm_dai_lb_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct axg_card *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct axg_dai_link_tdm_data *be =
+		(struct axg_dai_link_tdm_data *)priv->link_data[rtd->num];
+	int ret;
+
+	/* The loopback rx_mask is the pad tx_mask */
+	ret = axg_tdm_set_tdm_slots(rtd->cpu_dai, NULL, be->tx_mask,
+				    be->slots, be->slot_width);
+	if (ret) {
+		dev_err(rtd->cpu_dai->dev, "setting tdm link slots failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
+				     int *index)
+{
+	struct axg_card *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai_link *pad = &card->dai_link[*index];
+	struct snd_soc_dai_link *lb;
+	int ret;
+
+	/* extend links */
+	ret = axg_card_reallocate_links(priv, card->num_links + 1);
+	if (ret)
+		return ret;
+
+	lb = &card->dai_link[*index + 1];
+
+	lb->name = kasprintf(GFP_KERNEL, "%s-lb", pad->name);
+	if (!lb->name)
+		return -ENOMEM;
+
+	lb->stream_name = lb->name;
+	lb->cpu_of_node = pad->cpu_of_node;
+	lb->cpu_dai_name = "TDM Loopback";
+	lb->codec_name = "snd-soc-dummy";
+	lb->codec_dai_name = "snd-soc-dummy-dai";
+	lb->dpcm_capture = 1;
+	lb->no_pcm = 1;
+	lb->ops = &axg_card_tdm_be_ops;
+	lb->init = axg_card_tdm_dai_lb_init;
+
+	/* Provide the same link data to the loopback */
+	priv->link_data[*index + 1] = priv->link_data[*index];
+
+	/*
+	 * axg_card_clean_references() will iterate over this link,
+	 * make sure the node count is balanced
+	 */
+	of_node_get(lb->cpu_of_node);
+
+	/* Let add_links continue where it should */
+	*index += 1;
+
+	return 0;
+}
+
+static unsigned int axg_card_parse_daifmt(struct device_node *node,
+					  struct device_node *cpu_node)
+{
+	struct device_node *bitclkmaster = NULL;
+	struct device_node *framemaster = NULL;
+	unsigned int daifmt;
+
+	daifmt = snd_soc_of_parse_daifmt(node, PREFIX,
+					 &bitclkmaster, &framemaster);
+	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
+
+	/* If no master is provided, default to cpu master */
+	if (!bitclkmaster || bitclkmaster == cpu_node) {
+		daifmt |= (!framemaster || framemaster == cpu_node) ?
+			SND_SOC_DAIFMT_CBS_CFS : SND_SOC_DAIFMT_CBS_CFM;
+	} else {
+		daifmt |= (!framemaster || framemaster == cpu_node) ?
+			SND_SOC_DAIFMT_CBM_CFS : SND_SOC_DAIFMT_CBM_CFM;
+	}
+
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+
+	return daifmt;
+}
+
+static int axg_card_parse_cpu_tdm_slots(struct snd_soc_card *card,
+					struct snd_soc_dai_link *link,
+					struct device_node *node,
+					struct axg_dai_link_tdm_data *be)
+{
+	char propname[32];
+	u32 tx, rx;
+	int i;
+
+	be->tx_mask = devm_kcalloc(card->dev, AXG_TDM_NUM_LANES,
+				   sizeof(*be->tx_mask), GFP_KERNEL);
+	be->rx_mask = devm_kcalloc(card->dev, AXG_TDM_NUM_LANES,
+				   sizeof(*be->rx_mask), GFP_KERNEL);
+	if (!be->tx_mask || !be->rx_mask)
+		return -ENOMEM;
+
+	for (i = 0, tx = 0; i < AXG_TDM_NUM_LANES; i++) {
+		snprintf(propname, 32, "dai-tdm-slot-tx-mask-%d", i);
+		snd_soc_of_get_slot_mask(node, propname, &be->tx_mask[i]);
+		tx = max(tx, be->tx_mask[i]);
+	}
+
+	/* Disable playback is the interface has no tx slots */
+	if (!tx)
+		link->dpcm_playback = 0;
+
+	for (i = 0, rx = 0; i < AXG_TDM_NUM_LANES; i++) {
+		snprintf(propname, 32, "dai-tdm-slot-rx-mask-%d", i);
+		snd_soc_of_get_slot_mask(node, propname, &be->rx_mask[i]);
+		rx = max(rx, be->rx_mask[i]);
+	}
+
+	/* Disable capture is the interface has no rx slots */
+	if (!rx)
+		link->dpcm_capture = 0;
+
+	/* ... but the interface should at least have one of them */
+	if (!tx && !rx) {
+		dev_err(card->dev, "tdm link has no cpu slots\n");
+		return -EINVAL;
+	}
+
+	of_property_read_u32(node, "dai-tdm-slot-num", &be->slots);
+	if (!be->slots) {
+		/*
+		 * If the slot number is not provided, set it such as it
+		 * accommodates the largest mask
+		 */
+		be->slots = fls(max(tx, rx));
+	} else if (be->slots < fls(max(tx, rx)) || be->slots > 32) {
+		/*
+		 * Error if the slots can't accommodate the largest mask or
+		 * if it is just too big
+		 */
+		dev_err(card->dev, "bad slot number\n");
+		return -EINVAL;
+	}
+
+	of_property_read_u32(node, "dai-tdm-slot-width", &be->slot_width);
+
+	return 0;
+}
+
+static int axg_card_parse_codecs_masks(struct snd_soc_card *card,
+				       struct snd_soc_dai_link *link,
+				       struct device_node *node,
+				       struct axg_dai_link_tdm_data *be)
+{
+	struct axg_dai_link_tdm_mask *codec_mask;
+	struct device_node *np;
+
+	codec_mask = devm_kcalloc(card->dev, link->num_codecs,
+				  sizeof(*codec_mask), GFP_KERNEL);
+	if (!codec_mask)
+		return -ENOMEM;
+
+	be->codec_masks = codec_mask;
+
+	for_each_child_of_node(node, np) {
+		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask",
+					 &codec_mask->rx);
+		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-tx-mask",
+					 &codec_mask->tx);
+
+		codec_mask++;
+	}
+
+	return 0;
+}
+
+static int axg_card_parse_tdm(struct snd_soc_card *card,
+			      struct device_node *node,
+			      int *index)
+{
+	struct axg_card *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai_link *link = &card->dai_link[*index];
+	struct axg_dai_link_tdm_data *be;
+	int ret;
+
+	/* Allocate tdm link parameters */
+	be = devm_kzalloc(card->dev, sizeof(*be), GFP_KERNEL);
+	if (!be)
+		return -ENOMEM;
+	priv->link_data[*index] = be;
+
+	/* Setup tdm link */
+	link->ops = &axg_card_tdm_be_ops;
+	link->init = axg_card_tdm_dai_init;
+	link->dai_fmt = axg_card_parse_daifmt(node, link->cpu_of_node);
+
+	of_property_read_u32(node, "mclk-fs", &be->mclk_fs);
+
+	ret = axg_card_parse_cpu_tdm_slots(card, link, node, be);
+	if (ret) {
+		dev_err(card->dev, "error parsing tdm link slots\n");
+		return ret;
+	}
+
+	ret = axg_card_parse_codecs_masks(card, link, node, be);
+	if (ret)
+		return ret;
+
+	/* Add loopback if the pad dai has playback */
+	if (link->dpcm_playback) {
+		ret = axg_card_add_tdm_loopback(card, index);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int axg_card_set_be_link(struct snd_soc_card *card,
+				struct snd_soc_dai_link *link,
+				struct device_node *node)
+{
+	struct snd_soc_dai_link_component *codec;
+	struct device_node *np;
+	int ret, num_codecs;
+
+	link->no_pcm = 1;
+	link->dpcm_playback = 1;
+	link->dpcm_capture = 1;
+
+	num_codecs = of_get_child_count(node);
+	if (!num_codecs) {
+		dev_err(card->dev, "be link %s has no codec\n",
+			node->full_name);
+		return -EINVAL;
+	}
+
+	codec = devm_kcalloc(card->dev, num_codecs, sizeof(*codec), GFP_KERNEL);
+	if (!codec)
+		return -ENOMEM;
+
+	link->codecs = codec;
+	link->num_codecs = num_codecs;
+
+	for_each_child_of_node(node, np) {
+		ret = axg_card_parse_dai(card, np, &codec->of_node,
+					 &codec->dai_name);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+
+		codec++;
+	}
+
+	ret = axg_card_set_link_name(card, link, "be");
+	if (ret)
+		dev_err(card->dev, "error setting %s link name\n", np->name);
+
+	return ret;
+}
+
+static int axg_card_set_fe_link(struct snd_soc_card *card,
+				struct snd_soc_dai_link *link,
+				bool is_playback)
+{
+	link->dynamic = 1;
+	link->dpcm_merged_format = 1;
+	link->dpcm_merged_chan = 1;
+	link->dpcm_merged_rate = 1;
+	link->codec_dai_name = "snd-soc-dummy-dai";
+	link->codec_name = "snd-soc-dummy";
+
+	if (is_playback)
+		link->dpcm_playback = 1;
+	else
+		link->dpcm_capture = 1;
+
+	return axg_card_set_link_name(card, link, "fe");
+}
+
+static int axg_card_cpu_is_capture_fe(struct device_node *np)
+{
+	return of_device_is_compatible(np, PREFIX "axg-toddr");
+}
+
+static int axg_card_cpu_is_playback_fe(struct device_node *np)
+{
+	return of_device_is_compatible(np, PREFIX "axg-frddr");
+}
+
+static int axg_card_cpu_is_tdm_iface(struct device_node *np)
+{
+	return of_device_is_compatible(np, PREFIX "axg-tdm-iface");
+}
+
+static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
+			     int *index)
+{
+	struct snd_soc_dai_link *dai_link = &card->dai_link[*index];
+	int ret;
+
+	ret = axg_card_parse_dai(card, np, &dai_link->cpu_of_node,
+				 &dai_link->cpu_dai_name);
+	if (ret)
+		return ret;
+
+	if (axg_card_cpu_is_playback_fe(dai_link->cpu_of_node))
+		ret = axg_card_set_fe_link(card, dai_link, true);
+	else if (axg_card_cpu_is_capture_fe(dai_link->cpu_of_node))
+		ret = axg_card_set_fe_link(card, dai_link, false);
+	else
+		ret = axg_card_set_be_link(card, dai_link, np);
+
+	if (ret)
+		return ret;
+
+	if (axg_card_cpu_is_tdm_iface(dai_link->cpu_of_node))
+		ret = axg_card_parse_tdm(card, np, index);
+
+	return ret;
+}
+
+static int axg_card_add_links(struct snd_soc_card *card)
+{
+	struct axg_card *priv = snd_soc_card_get_drvdata(card);
+	struct device_node *node = card->dev->of_node;
+	struct device_node *np;
+	int num, i, ret;
+
+	num = of_get_child_count(node);
+	if (!num) {
+		dev_err(card->dev, "card has no links\n");
+		return -EINVAL;
+	}
+
+	ret = axg_card_reallocate_links(priv, num);
+	if (ret)
+		return ret;
+
+	i = 0;
+	for_each_child_of_node(node, np) {
+		ret = axg_card_add_link(card, np, &i);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+
+		i++;
+	}
+
+	return 0;
+}
+
+static int axg_card_parse_of_optional(struct snd_soc_card *card,
+				      const char *propname,
+				      int (*func)(struct snd_soc_card *c,
+						  const char *p))
+{
+	/* If property is not provided, don't fail ... */
+	if (!of_property_read_bool(card->dev->of_node, propname))
+		return 0;
+
+	/* ... but do fail if it is provided and the parsing fails */
+	return func(card, propname);
+}
+
+static const struct of_device_id axg_card_of_match[] = {
+	{ .compatible = "amlogic,axg-sound-card", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, axg_card_of_match);
+
+static int axg_card_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axg_card *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	snd_soc_card_set_drvdata(&priv->card, priv);
+
+	priv->card.owner = THIS_MODULE;
+	priv->card.dev = dev;
+
+	ret = snd_soc_of_parse_card_name(&priv->card, PREFIX "name");
+	if (ret < 0)
+		return ret;
+
+	ret = axg_card_parse_of_optional(&priv->card, PREFIX "routing",
+					 snd_soc_of_parse_audio_routing);
+	if (ret) {
+		dev_err(dev, "error while parsing routing\n");
+		return ret;
+	}
+
+	ret = axg_card_parse_of_optional(&priv->card, PREFIX "widgets",
+					 snd_soc_of_parse_audio_simple_widgets);
+	if (ret) {
+		dev_err(dev, "error while parsing widgets\n");
+		return ret;
+	}
+
+	ret = axg_card_add_links(&priv->card);
+	if (ret)
+		goto out_err;
+
+	ret = axg_card_add_aux_devices(&priv->card);
+	if (ret)
+		goto out_err;
+
+	ret = devm_snd_soc_register_card(dev, &priv->card);
+	if (ret)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	axg_card_clean_references(priv);
+	return ret;
+}
+
+static int axg_card_remove(struct platform_device *pdev)
+{
+	struct axg_card *priv = platform_get_drvdata(pdev);
+
+	axg_card_clean_references(priv);
+
+	return 0;
+}
+
+static struct platform_driver axg_card_pdrv = {
+	.probe = axg_card_probe,
+	.remove = axg_card_remove,
+	.driver = {
+		.name = "axg-sound-card",
+		.of_match_table = axg_card_of_match,
+	},
+};
+module_platform_driver(axg_card_pdrv);
+
+MODULE_DESCRIPTION("Amlogic AXG ALSA machine driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.4

