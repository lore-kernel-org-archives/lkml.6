Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1210C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC00222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437966AbfBNKNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:13:38 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:42862 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406484AbfBNKNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:13:35 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id AF/F3-14930-C4F356C5; Thu, 14 Feb 2019 10:13:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRWlGSWpSXmKPExsUS3ulwWNfHPjX
  GYOE0dotTLXvYLa5cPMRkMfXhEzaLb1c6mCwu75rDZtG5q5/VYsP3tYwO7B4bPjexebRe+svm
  sXPWXXaPTas62Tz2vV3G5rF+y1UWj8+b5ALYo1gz85LyKxJYM9a2TmAumKtc0Tv5P0sD43bZL
  kYuDiGBbYwSh999Y4Jw1jNKTJ37iLGLkRPIqZA4uGMpO4jNK5ApcaH3GxuIzSngLrGoEcIWEn
  CTWLtxHTOIzSZgITH5xAOwOIuAqsTW3t9MILawgJfEhDeTwWwRgS5GifNHvUGWMQvMZ5TYtvA
  qK8QCQYmTM5+wgNjMAhISB1+8YIZYYCBxekEjWFxCwF5i+vurQHEOIFtfovFYLETYUOL7rG9Q
  JeYSbRu7mFGVg9jWEtc/zGKbwCgyC8m2WUi2LWBkWsVokVSUmZ5RkpuYmaNraGCga2horGuia
  2Gpl1ilm6SXWqqbnJpXUpQIlNRLLC/WK67MTc5J0ctLLdnECIy/lEKWyB2Ml5amH2KU5GBSEu
  U1vpgSI8SXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCV8UmNUZIsCg1PbUiLTMHmAhg0hIcPEoivBf
  tgNK8xQWJucWZ6RCpU4yKUuK8f2yBEgIgiYzSPLg2WPK5xCgrJczLyMDAIMRTkFqUm1mCKv+K
  UZyDUUmYdxHIFJ7MvBK46a+AFjMBLX4qkgKyuCQRISXVwJi9/s6iBVsao7lqu9lP34/8evTgW
  fsZC2Ikzb5xvWh+3+h865XB0oPW5ne5rgcxsCySzZLJ02S/9ULipcmCSaEWTs1mLzr/J0wL3/
  j2xP/6k3qsMyc5x10Qjk94sS3wz5psXvOKOy5P4pf5WP5Z/9+7cP7LaO1D79445PDe3f0/9kf
  dl6Xh4vlKLMUZiYZazEXFiQAEcppvOQMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-33.tower-246.messagelabs.com!1550139211!1544854!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30109 invoked from network); 14 Feb 2019 10:13:32 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-33.tower-246.messagelabs.com with AES128-SHA256 encrypted SMTP; 14 Feb 2019 10:13:32 -0000
Received: from SW-EX-CASHUB01.diasemi.com (10.20.16.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.141) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Feb 2019 11:13:31 +0100
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 10:13:30 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 6D4A33FBCD; Thu, 14 Feb 2019 10:13:30 +0000 (GMT)
Message-ID: <9d7cd9143bdc0a86a0d745ff0a12d26aea8de43c.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Thu, 14 Feb 2019 10:13:30 +0000
Subject: [PATCH v2 2/2] ASoC: da7219: Update TDM usage to be more flexible
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
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous implementatation was restrictive with regards to
BCLK rates for slave mode where the driver would not allow rates
the codec couldn't provide itself as clock master. The codec
is able to automatically determine and handle whatever rate is
provided so this restriction isn't necessary for slave mode. The
code was also flawed with regards to setting of the frame offset
as using rx_mask to explicitly set the offset has the knock on
effect of impacting the min and max channels for the codec, in
soc_pcm_hw_params() through the call to
soc_pcm_codec_params_fixup().

With this update, the driver now only limits frame size if codec
is clock master, and dynamically determines the BCLK offset
relating to WCLK using the tx_mask for slot offset along with the
slot width provided.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 80 ++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c599aa9..121a819 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1391,8 +1391,10 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 {
 	struct snd_soc_component *component = dai->component;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
-	u8 dai_bclks_per_wclk;
-	__le16 offset;
+	unsigned int ch_mask;
+	u8 dai_bclks_per_wclk, slot_offset;
+	u16 offset;
+	__le16 dai_offset;
 	u32 frame_size;
 
 	/* No channels enabled so disable TDM */
@@ -1405,51 +1407,63 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	}
 
 	/* Check we have valid slots */
-	if (fls(tx_mask) > DA7219_DAI_TDM_MAX_SLOTS) {
-		dev_err(component->dev, "Invalid number of slots, max = %d\n",
+	slot_offset = ffs(tx_mask) - 1;
+	ch_mask = (tx_mask >> slot_offset);
+	if (fls(ch_mask) > DA7219_DAI_TDM_MAX_SLOTS) {
+		dev_err(component->dev,
+			"Invalid number of slots, max = %d\n",
 			DA7219_DAI_TDM_MAX_SLOTS);
 		return -EINVAL;
 	}
 
-	/* Check we have a valid offset given */
-	if (rx_mask > DA7219_DAI_OFFSET_MAX) {
-		dev_err(component->dev, "Invalid slot offset, max = %d\n",
-			DA7219_DAI_OFFSET_MAX);
+	/*
+	 * Ensure we have a valid offset into the frame, based on slot width
+	 * and slot offset of first slot we're interested in.
+	 */
+	offset = slot_offset * slot_width;
+	if (offset > DA7219_DAI_OFFSET_MAX) {
+		dev_err(component->dev, "Invalid frame offset %d\n", offset);
 		return -EINVAL;
 	}
 
-	/* Calculate & validate frame size based on slot info provided. */
-	frame_size = slots * slot_width;
-	switch (frame_size) {
-	case 32:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
-		break;
-	case 64:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
-		break;
-	case 128:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_128;
-		break;
-	case 256:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_256;
-		break;
-	default:
-		dev_err(component->dev, "Invalid frame size %d\n", frame_size);
-		return -EINVAL;
-	}
+	/*
+	 * If we're master, calculate & validate frame size based on slot info
+	 * provided as we have a limited set of rates available.
+	 */
+	if (da7219->master) {
+		frame_size = slots * slot_width;
+		switch (frame_size) {
+		case 32:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+			break;
+		case 64:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
+			break;
+		case 128:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_128;
+			break;
+		case 256:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_256;
+			break;
+		default:
+			dev_err(component->dev, "Invalid frame size %d\n",
+				frame_size);
+			return -EINVAL;
+		}
 
-	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-			    DA7219_DAI_BCLKS_PER_WCLK_MASK,
-			    dai_bclks_per_wclk);
+		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+				DA7219_DAI_BCLKS_PER_WCLK_MASK,
+				dai_bclks_per_wclk);
+	}
 
-	offset = cpu_to_le16(rx_mask);
+	dai_offset = cpu_to_le16(offset);
 	regmap_bulk_write(da7219->regmap, DA7219_DAI_OFFSET_LOWER,
-			  &offset, sizeof(offset));
+			  &dai_offset, sizeof(dai_offset));
 
 	snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
 			    DA7219_DAI_TDM_CH_EN_MASK |
 			    DA7219_DAI_TDM_MODE_EN_MASK,
-			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
+			    (ch_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
 			    DA7219_DAI_TDM_MODE_EN_MASK);
 
 	da7219->tdm_en = true;
-- 
1.9.1

