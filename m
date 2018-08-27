Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783E2208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vf0DiFJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783E2208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeH0SIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:08:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36427 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0SIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:08:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so8505376wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=K3J/C6PUSNPX+1+GRCl8rpXvyVQLnz/WgMlsu3+XANg=;
        b=vf0DiFJwRaNotCzttmjhzO+/6CIQvsrTowfK2DdgpQfkhPAQwPrLchYMTYwQrM7b2G
         vZb5U5HpGQ8kOf3iHQV3BPYnTQSfK/6FzmhyQ5yMW49EGCVLqaeTHauvUlLmVzTJ3ybJ
         LUiEnC1n5yZ+hpX+4zW8O203FAQnahYOq5Fqrol3EW5ue4VkpcwxtYG+1zX1sb3d2JUr
         3nLBi8jfzht11fGep5Ke6aaAzXsT/N0dFTKUgXFhNnhSpJR5RLouO2Svz4o+lNUXAbMy
         uGP7k8ZWO8n8KzC4LEpiv6dh72xRsOZzUMWrvJ6RpFviSh6i1PVycArod4dszqbU1WhF
         UHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K3J/C6PUSNPX+1+GRCl8rpXvyVQLnz/WgMlsu3+XANg=;
        b=CeTyKKEq4swFMrZDEpHXF08z1rhld6Wb1CKjn5B++DxqFHRR5+Af2GCDDqsmX4vIP0
         6cQlzmFdJgb8k3DEDJ1iqtiaNQGzbFylgJ+x7ORzMT+Xa13KFvsnBpPIG6gA4OTU7+Hg
         1kwN95gfsZ5TkL43cr+MeQ11e8e906CvfgyAqRCS9PPBU2rA2zncBaB+bFXWQZr0lkci
         r7Jb4jid5Bl2BDwxBHnSaNco4WlSeopc9dYqL87/atVQQ8h23WmvLYpux8XQ7HdkYZNT
         2O95hpk9vIkAmwchTzXPPQmzyZOjfG/JGotbjaH3tGQi7NVDpAzRP+VaS8PZDjCKSTft
         wM0g==
X-Gm-Message-State: APzg51CKqFVYPoxMuvFPzHszOJhsLFAMXazz0swLjucO/eUnXAQpyyyI
        swC1mPcz+RmcrpFJJ4WoR0973w==
X-Google-Smtp-Source: ANB0VdaADToHHkN+eBe+rDUGovJPgFEXMYtgLsWlH8dvc5s8Y3l+Huyrge30zc97EuEyVOFDDajkaQ==
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr3627156wmc.24.1535379674517;
        Mon, 27 Aug 2018 07:21:14 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 204-v6sm13896316wmh.25.2018.08.27.07.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 07:21:14 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: axg-tdm: restrict formats depending on slot width
Date:   Mon, 27 Aug 2018 16:21:07 +0200
Message-Id: <20180827142107.8153-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict the formats possible on the TDM interface depending on the width
of the TDM slot and let dpcm merging do the rest.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 50 +++++++++++++++++------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 7b8baf46d968..585ce030b79b 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -42,6 +42,7 @@ int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
 	struct axg_tdm_stream *rx = (struct axg_tdm_stream *)
 		dai->capture_dma_data;
 	unsigned int tx_slots, rx_slots;
+	unsigned int fmt = 0;
 
 	tx_slots = axg_tdm_slots_total(tx_mask);
 	rx_slots = axg_tdm_slots_total(rx_mask);
@@ -52,38 +53,45 @@ int axg_tdm_set_tdm_slots(struct snd_soc_dai *dai, u32 *tx_mask,
 		return -EINVAL;
 	}
 
-	/*
-	 * Amend the dai driver channel number and let dpcm channel merge do
-	 * its job
-	 */
-	if (tx) {
-		tx->mask = tx_mask;
-		dai->driver->playback.channels_max = tx_slots;
-	}
-
-	if (rx) {
-		rx->mask = rx_mask;
-		dai->driver->capture.channels_max = rx_slots;
-	}
-
 	iface->slots = slots;
 
 	switch (slot_width) {
 	case 0:
-		/* defaults width to 32 if not provided */
-		iface->slot_width = 32;
-		break;
-	case 8:
-	case 16:
-	case 24:
+		slot_width = 32;
+		/* Fall-through */
 	case 32:
-		iface->slot_width = slot_width;
+		fmt |= SNDRV_PCM_FMTBIT_S32_LE;
+		/* Fall-through */
+	case 24:
+		fmt |= SNDRV_PCM_FMTBIT_S24_LE;
+		fmt |= SNDRV_PCM_FMTBIT_S20_LE;
+		/* Fall-through */
+	case 16:
+		fmt |= SNDRV_PCM_FMTBIT_S16_LE;
+		/* Fall-through */
+	case 8:
+		fmt |= SNDRV_PCM_FMTBIT_S8;
 		break;
 	default:
 		dev_err(dai->dev, "unsupported slot width: %d\n", slot_width);
 		return -EINVAL;
 	}
 
+	iface->slot_width = slot_width;
+
+	/* Amend the dai driver and let dpcm merge do its job */
+	if (tx) {
+		tx->mask = tx_mask;
+		dai->driver->playback.channels_max = tx_slots;
+		dai->driver->playback.formats = fmt;
+	}
+
+	if (rx) {
+		rx->mask = rx_mask;
+		dai->driver->capture.channels_max = rx_slots;
+		dai->driver->capture.formats = fmt;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(axg_tdm_set_tdm_slots);
-- 
2.17.1

