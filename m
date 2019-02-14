Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8650C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64D2222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406499AbfBNKNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:13:35 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:50651 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbfBNKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:13:34 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 38/2A-01731-B4F356C5; Thu, 14 Feb 2019 10:13:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRWlGSWpSXmKPExsUS3ulwWNfbPjX
  GYHqPgMWplj3sFlcuHmKymPrwCZvFtysdTBaXd81hs+jc1c9qseH7WkYHdo8Nn5vYPFov/WXz
  2DnrLrvHplWdbB773i5j81i/5SqLx+dNcgHsUayZeUn5FQmsGZPP3WMr+CpTsfHDG5YGxm6JL
  kYuDiGBbYwS+36/Z4dw1jNK7L5+GMjhBHIqJDon7mAEsXkFMiWuLN7NBGJzCrhLLGr8xgZR4y
  axduM6ZhCbTcBCYvKJB2BxFgFVicbfD8DqhQXCJX7eec4CYosIdDFKnD/qDbKMWWA+o8S2hVd
  ZIRYISpyc+QSsiFlAQuLgixfMEAsMJE4vaASLSwjYS0x/fxUozgFk60s0HouFCBtKfJ/1DarE
  XKJtYxczsvIJjMKzkGyYhWTDAkamVYyWSUWZ6RkluYmZObqGBga6hobGukZA0lwvsUo3US+1V
  Dc5Na+kKBEoq5dYXqxXXJmbnJOil5dasokRGGkphUylOxinLU8/xCjJwaQkymt8MSVGiC8pP6
  UyI7E4I76oNCe1+BCjDAeHkgSvik1qjJBgUWp6akVaZg4w5mHSEhw8SiK8F+2A0rzFBYm5xZn
  pEKlTjIpS4rx/bIESAiCJjNI8uDZYmrnEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZh3EcgU
  nsy8Erjpr4AWMwEtfiqSArK4JBEhJdXAuLabx3XmjlbVBIVcvTn7LqsmzcgysyjPSxT5oTEjY
  IkNV837ncsnnD4XpKZvqs+2ZEL4Pufle5ICJt1tCPiZ3lZ49ldn8u/sOoaUoN8h5r+/nl1m/3
  jFghdCp3Z/npvSrbTXvPb07n3XPqyb8M7tUs6k6bFbdgbHVtQ5v7onO0/W2/91ZLPqLyWW4ox
  EQy3mouJEADz7a7AuAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-44.tower-223.messagelabs.com!1550139210!1180341!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16230 invoked from network); 14 Feb 2019 10:13:31 -0000
Received: from unknown (HELO NB-EX-CASHUB02.diasemi.com) (87.137.64.195)
  by server-44.tower-223.messagelabs.com with AES128-SHA256 encrypted SMTP; 14 Feb 2019 10:13:31 -0000
Received: from SW-EX-CASHUB01.diasemi.com (10.20.16.141) by
 NB-EX-CASHUB02.diasemi.com (10.1.16.142) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Feb 2019 11:13:29 +0100
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 10:13:29 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 6A2503FBFF; Thu, 14 Feb 2019 10:13:29 +0000 (GMT)
Message-ID: <2a1ae702cb3cfb9029e04b69d68f9c9d0e92dbf5.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Thu, 14 Feb 2019 10:13:29 +0000
Subject: [PATCH v2 1/2] ASoC: da7219: Add support for master mode BCLK rate
 adjustment
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14/02/2019 07:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the driver would default the BCLK periods per WCLK to
64, to cover all possible non-TDM scenarios when the codec was
DAI clock master. However some devices require a lower BCLK rate
to operate correctly so with this in mind, this commit updates
the code to be more dynamic, with BCLK rate now based on SR and
word length provided to hw_params().

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 36 ++++++++++++++++++++++++++----------
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index b1df4bb..c599aa9 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1376,11 +1376,7 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	/* By default 64 BCLKs per WCLK is supported */
-	dai_clk_mode |= DA7219_DAI_BCLKS_PER_WCLK_64;
-
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-			    DA7219_DAI_BCLKS_PER_WCLK_MASK |
 			    DA7219_DAI_CLK_POL_MASK | DA7219_DAI_WCLK_POL_MASK,
 			    dai_clk_mode);
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL, DA7219_DAI_FORMAT_MASK,
@@ -1399,14 +1395,12 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	__le16 offset;
 	u32 frame_size;
 
-	/* No channels enabled so disable TDM, revert to 64-bit frames */
+	/* No channels enabled so disable TDM */
 	if (!tx_mask) {
 		snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
 				    DA7219_DAI_TDM_CH_EN_MASK |
 				    DA7219_DAI_TDM_MODE_EN_MASK, 0);
-		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-				    DA7219_DAI_BCLKS_PER_WCLK_MASK,
-				    DA7219_DAI_BCLKS_PER_WCLK_64);
+		da7219->tdm_en = false;
 		return 0;
 	}
 
@@ -1458,6 +1452,8 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
 			    DA7219_DAI_TDM_MODE_EN_MASK);
 
+	da7219->tdm_en = true;
+
 	return 0;
 }
 
@@ -1466,10 +1462,13 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
-	u8 dai_ctrl = 0, fs;
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	u8 dai_ctrl = 0, dai_bclks_per_wclk = 0, fs;
 	unsigned int channels;
+	int word_len = params_width(params);
+	int frame_size;
 
-	switch (params_width(params)) {
+	switch (word_len) {
 	case 16:
 		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S16_LE;
 		break;
@@ -1533,6 +1532,23 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/*
+	 * If we're master, then we have a limited set of BCLK rates we
+	 * support. For slave mode this isn't the case and the codec can detect
+	 * the BCLK rate automatically.
+	 */
+	if (da7219->master && !da7219->tdm_en) {
+		frame_size = word_len * 2;
+		if (frame_size <= 32)
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+		else
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
+
+		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+					      DA7219_DAI_BCLKS_PER_WCLK_MASK,
+					      dai_bclks_per_wclk);
+	}
+
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
 			    DA7219_DAI_WORD_LENGTH_MASK |
 			    DA7219_DAI_CH_NUM_MASK,
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 366cf46..018819c 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -830,6 +830,7 @@ struct da7219_priv {
 	int clk_src;
 
 	bool master;
+	bool tdm_en;
 	bool alc_en;
 	bool micbias_on_event;
 	unsigned int mic_pga_delay;
-- 
1.9.1

