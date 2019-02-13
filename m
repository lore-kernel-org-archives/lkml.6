Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54288C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22150222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437585AbfBNIpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:45:23 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:4874 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728304AbfBNIpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:45:18 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id CB/30-04268-89A256C5; Thu, 14 Feb 2019 08:45:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRWlGSWpSXmKPExsUS3ulwWHeGVmq
  MwbqtkhanWvawW1y5eIjJYurDJ2wW3650MFlc3jWHzaJzVz+rxYbvaxkd2D02fG5i82i99JfN
  Y+esu+wem1Z1snnse7uMzWP9lqssHp83yQWwR7Fm5iXlVySwZuxu7mYs+CJTsfzjDuYGxi6JL
  kYuDiGBbYwSp391MEM46xkl/lw6wNrFyAnkVEhc2bYIKMHBwSuQKXGiTQwkzCngLvHp7E52iB
  I3iZ8HfjCB2GwCFhKTTzxgA7FZBFQlZv5rYgSxhQVCJE7tWwlWIyLQxShx/qg3yC5mgfmMEts
  WXgXbxSsgKHFy5hMWEJtZQELi4IsXzBALDCROL2gEi0sI2EtMf38V7B4JAX2JxmOxEGFDie+z
  vkGVmEvs3LGcDVU5ppo/p34yY6pBZltLXP8wi20Co8QsJNfNQnLdAkamVYwWSUWZ6RkluYmZO
  bqGBga6hoZGuoaWZrqGJsZ6iVW6SXqppbrlqcUluoZ6ieXFesWVuck5KXp5qSWbGIHRnVJwpH
  8H47Pl6YcYJTmYlER5jS+mxAjxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4NXVTI0REixKTU+tSMv
  MAaYZmLQEB4+SCK8gSJq3uCAxtzgzHSJ1ilFRSpxXWQMoIQCSyCjNg2uDpbZLjLJSwryMDAwM
  QjwFqUW5mSWo8q8YxTkYlYR5E0HG82TmlcBNfwW0mAlo8VORFJDFJYkIKakGxor75/5flt7W+
  +Lf+9PmB5ZceaJqde/Ri/uFp7/smx/5YfZen72uB1P+PFh/iEtePjvxiF3+15jeqxLVl7ezTP
  ZY0PSLa/r6xjPpvxX+dD//YsPT89frYejiyonps3KMbjF+lA+t2Z+53t38pPKDXUvUp99isr/
  uuCVq46cXbxod3acW639bbP5CiaU4I9FQi7moOBEAoS23PmgDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-288.messagelabs.com!1550133911!2392454!4
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12092 invoked from network); 14 Feb 2019 08:45:12 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-15.tower-288.messagelabs.com with AES128-SHA256 encrypted SMTP; 14 Feb 2019 08:45:12 -0000
Received: from SW-EX-CASHUB01.diasemi.com (10.20.16.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.141) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Feb 2019 09:45:11 +0100
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 17:47:32 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 A38233FBB6; Wed, 13 Feb 2019 17:47:32 +0000 (GMT)
Message-ID: <a044303abc42df1968d44b0c933ad30fb5cb4dc5.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 13 Feb 2019 17:47:32 +0000
Subject: [PATCH 1/2] ASoC: da7219: Add support for master mode BCLK rate
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
X-KSE-Antivirus-Info: Clean, bases: 13/02/2019 16:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14/02/2019 04:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
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
index b1df4bb..7dbecf3 100644
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
+	if (da7219->master & !da7219->tdm_en) {
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

