Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD23AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7055A222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394803AbfBNIpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:45:16 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:4874 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbfBNIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:45:16 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id C8/30-04268-89A256C5; Thu, 14 Feb 2019 08:45:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRWlGSWpSXmKPExsUS3ulwWHeGVmq
  MQetTHotTLXvYLa5cPMRkMfXhEzaLb1c6mCwu75rDZtG5q5/VYsP3tYwO7B4bPjexebRe+svm
  sXPWXXaPTas62Tz2vV3G5rF+y1UWj8+b5ALYo1gz85LyKxJYM37tMC2Yq1zxceFK9gbG7bJdj
  FwcQgLbGCVO/+pghnDWM0rc23WUtYuRE8ipkLh/5hKYzSuQKTHzVR87iM0p4C7x6exOdogaN4
  mfB34wgdhsAhYSk088YAOxWQRUJS5/vAhmCwPVn9w2DWyOiEAXo8T5o94gy5gF5jNKbFt4FWq
  BoMTJmU9YQGxmAQmJgy9eMEMsMJA4vaARLC4hYC8x/f1VoDgHkK0v0XgsFiJsKPF91jeoEnOJ
  nTuWs6Eqx1Tz59RPZkw1yGxriesfZrFNYJSYheS6WUiuW8DItIrRIqkoMz2jJDcxM0fX0MBA1
  9DQSNfQ0gKIzfQSq3ST9FJLdctTi0t0DfUSy4v1iitzk3NS9PJSSzYxAqM7peDYkR2Mp7vSDz
  FKcjApifIaX0yJEeJLyk+pzEgszogvKs1JLT7EKMPBoSTBq6uZGiMkWJSanlqRlpkDTDMwaQk
  OHiURXkGQNG9xQWJucWY6ROoUo6KUOO9lkIQASCKjNA+uDZbaLjHKSgnzMjIwMAjxFKQW5WaW
  oMq/YhTnYFQS5r2gDjSFJzOvBG76K6DFTECLn4qkgCwuSURISTUwMsww4Eh8FhP4Sb42YFHOt
  anNxlelSh403Ndc1BghsSyursDjStWkU3WbnzErhh94Pas/LyCY2Zjn8uMrO7t6bHnupi4raH
  SYuv/H3x0r2SSec09+epQzyvPA7r/G6tq8geGXKrZfEvTbU6RVNPn+y0UCzMc3i0xQ+n+v1/m
  3W39/1ZyeSfUtSizFGYmGWsxFxYkAdOQ1n2gDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-288.messagelabs.com!1550133911!2392454!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11715 invoked from network); 14 Feb 2019 08:45:12 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-15.tower-288.messagelabs.com with AES128-SHA256 encrypted SMTP; 14 Feb 2019 08:45:12 -0000
Received: from SW-EX-CASHUB01.diasemi.com (10.20.16.141) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.141) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Feb 2019 09:45:11 +0100
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 17:47:33 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 A6E643FBBB; Wed, 13 Feb 2019 17:47:33 +0000 (GMT)
Message-ID: <be6aa7bea4d091367951f328467f6ff755aaab97.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Wed, 13 Feb 2019 17:47:33 +0000
Subject: [PATCH 2/2] ASoC: da7219: Update TDM usage to be more flexible
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
index 7dbecf3..be606e3 100644
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

