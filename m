Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB19F217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB19F217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbeHIMM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:12:59 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:58855 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727371AbeHIMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:12:58 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 63/09-05448-40E0C6B5; Thu, 09 Aug 2018 09:48:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRWlGSWpSXmKPExsUSt3OpsS4LX06
  0waNtQhZXLh5ispj68AmbxbcrHUwWl3fNYbPo3NXParHh+1pGBzaPDZ+b2Dx2zrrL7rFpVSeb
  x763y9g81m+5yuLxeZNcAFsUa2ZeUn5FAmvG3auPmAtOqFc8mr2IsYHxtGIXIxeHkMA6Rol3s
  /oYuxg5gZwKiU3H29lAbDYBC4nJJx6A2SwCKhJPp70Bs4UFQiTmz9/PDGKLCHQxSpw/6g1iMw
  uUS2z5NBEszivgINFypZcVwhaUODnzCQtEjYTEwRcvmCF2GUicXtAIFpcQsJeY/v4qUJwDyNa
  XaDwWCxE2lPg+6xtUiblEa8t+xgmM/LOQTJ2FZOoCRqZVjBZJRZnpGSW5iZk5uoYGBrqGhsa6
  5rom5nqJVbpJeqmlusmpeSVFiUBJvcTyYr3iytzknBS9vNSSTYzAcGcAgh2M/X9SDjFKcjApi
  fKGfM6OFuJLyk+pzEgszogvKs1JLT7EKMPBoSTB28KTEy0kWJSanlqRlpkDjDyYtAQHj5II72
  aQNG9xQWJucWY6ROoUozHHqeaeScwcf95PncQsxJKXn5cqJc47FaRUAKQ0ozQPbhAsIVxilJU
  S5mUEOk2IpyC1KDezBFX+FaM4B6OSMO9ZkCk8mXklcPteAZ3CBHTKG+1MkFNKEhFSUg2Mcy75
  qNeUxx+RE+XqFUnMCbv/12DyrpKkT5Xf/rxhPDxriXjBoXmub6eU1DUobE+oDjuZtcBL4oXxG
  S+B6snnOhWOf8zjYK485fnzvNbedveLxt7+oo3Zr/5EPJjzZdLyHP26g4v+6nUbCxU4bZ34kb
  lW4p1XMrv1kb+zv7tNUr/mudbiZ2OmEktxRqKhFnNRcSIAdetDPgMDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-6.tower-246.messagelabs.com!1533808132!3854365!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13305 invoked from network); 9 Aug 2018 09:48:52 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-6.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 9 Aug 2018 09:48:52 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 9 Aug 2018 10:48:50 +0100
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 F1B623FB9D; Thu,  9 Aug 2018 10:48:50 +0100 (BST)
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Thu, 9 Aug 2018 10:48:50 +0100
Subject: [PATCH] ASoC: da7219: Add delays to capture path to remove DC offset
 noise
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     Support Opensource <support.opensource@diasemi.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Message-ID: <20180809094850.F1B623FB9D@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 09/08/2018 05:12:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms it has been noted that a pop noise can be
witnessed when capturing audio, mainly for first time after a
headset jack has been inserted. This is due to a DC offset in the
Mic PGA and so to avoid this delays are required when powering
up the capture path.

This commit rectifies the problem by adding delays post Mic PGA and
post Mixin PGA. The post Mic PGA delay is determined based on
Mic Bias voltage, and is only applied the first time after a
headset jack is inserted.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219-aad.c |  5 +++++
 sound/soc/codecs/da7219.c     | 44 +++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/da7219.h     |  8 ++++++--
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index a49ab75..2c7d508 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -59,6 +59,7 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 		container_of(work, struct da7219_aad_priv, btn_det_work);
 	struct snd_soc_component *component = da7219_aad->component;
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 statusa, micbias_ctrl;
 	bool micbias_up = false;
 	int retries = 0;
@@ -86,6 +87,8 @@ static void da7219_aad_btn_det_work(struct work_struct *work)
 	if (retries >= DA7219_AAD_MICBIAS_CHK_RETRIES)
 		dev_warn(component->dev, "Mic bias status check timed out");
 
+	da7219->micbias_on_event = true;
+
 	/*
 	 * Mic bias pulse required to enable mic, must be done before enabling
 	 * button detection to prevent erroneous button readings.
@@ -439,6 +442,8 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 			snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
 					    DA7219_BUTTON_CONFIG_MASK, 0);
 
+			da7219->micbias_on_event = false;
+
 			/* Disable mic bias */
 			snd_soc_dapm_disable_pin(dapm, "Mic Bias");
 			snd_soc_dapm_sync(dapm);
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c0144f2..e46e9f4 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -768,6 +768,30 @@ static int da7219_tonegen_freq_put(struct snd_kcontrol *kcontrol,
  * DAPM Events
  */
 
+static int da7219_mic_pga_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (da7219->micbias_on_event) {
+			/*
+			 * Delay only for first capture after bias enabled to
+			 * avoid possible DC offset related noise.
+			 */
+			da7219->micbias_on_event = false;
+			msleep(da7219->mic_pga_delay);
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
@@ -937,12 +961,12 @@ static int da7219_gain_ramp_event(struct snd_soc_dapm_widget *w,
 	SND_SOC_DAPM_INPUT("MIC"),
 
 	/* Input PGAs */
-	SND_SOC_DAPM_PGA("Mic PGA", DA7219_MIC_1_CTRL,
-			 DA7219_MIC_1_AMP_EN_SHIFT, DA7219_NO_INVERT,
-			 NULL, 0),
-	SND_SOC_DAPM_PGA("Mixin PGA", DA7219_MIXIN_L_CTRL,
-			 DA7219_MIXIN_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
-			 NULL, 0),
+	SND_SOC_DAPM_PGA_E("Mic PGA", DA7219_MIC_1_CTRL,
+			   DA7219_MIC_1_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			   NULL, 0, da7219_mic_pga_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_E("Mixin PGA", DA7219_MIXIN_L_CTRL,
+			   DA7219_MIXIN_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			   NULL, 0, da7219_settling_event, SND_SOC_DAPM_POST_PMU),
 
 	/* Input Filters */
 	SND_SOC_DAPM_ADC("ADC", NULL, DA7219_ADC_L_CTRL, DA7219_ADC_L_EN_SHIFT,
@@ -1847,6 +1871,14 @@ static void da7219_handle_pdata(struct snd_soc_component *component)
 
 		snd_soc_component_write(component, DA7219_MICBIAS_CTRL, micbias_lvl);
 
+		/*
+		 * Calculate delay required to compensate for DC offset in
+		 * Mic PGA, based on Mic Bias voltage.
+		 */
+		da7219->mic_pga_delay =  DA7219_MIC_PGA_BASE_DELAY +
+					(pdata->micbias_lvl *
+					 DA7219_MIC_PGA_OFFSET_DELAY);
+
 		/* Mic */
 		switch (pdata->mic_amp_in_sel) {
 		case DA7219_MIC_AMP_IN_SEL_DIFF:
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 1b00023..3a00686 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -781,8 +781,10 @@
 #define DA7219_SYS_STAT_CHECK_DELAY	50
 
 /* Power up/down Delays */
-#define DA7219_SETTLING_DELAY	40
-#define DA7219_MIN_GAIN_DELAY	30
+#define DA7219_SETTLING_DELAY		40
+#define DA7219_MIN_GAIN_DELAY		30
+#define DA7219_MIC_PGA_BASE_DELAY	100
+#define DA7219_MIC_PGA_OFFSET_DELAY	40
 
 enum da7219_clk_src {
 	DA7219_CLKSRC_MCLK = 0,
@@ -828,6 +830,8 @@ struct da7219_priv {
 
 	bool master;
 	bool alc_en;
+	bool micbias_on_event;
+	unsigned int mic_pga_delay;
 	u8 gain_ramp_ctrl;
 };
 
-- 
1.9.1

