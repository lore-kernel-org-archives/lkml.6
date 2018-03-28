Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeC1PId (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:08:33 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36962 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeC1PIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:08:31 -0400
X-Google-Smtp-Source: AIpwx48psLRVv1EO3/QRAIvrplzOZz5mR34ekfeMFoma7y4rJ0nPAtRV4i7Dsiz0LvAKFgci+ciZBg==
Date: Wed, 28 Mar 2018 10:08:22 -0500
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org
Subject: [alsa-devel][PATCH 1/3 v3] ASoC: TSCS42xx: Shorten lines and other
 cleanup
Message-ID: <20180328150809.GA303@t7-ThinkPad-E560>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten lines greater than 80 chars
Add const to struct snd_soc_component_driver

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 87 ++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index cfc71b5411ee..37636d6efe60 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -204,7 +204,8 @@ static int power_up_audio_plls(struct snd_soc_component *component)
 		break;
 	default:
 		ret = -EINVAL;
-		dev_err(component->dev, "Unrecognized PLL output freq (%d)\n", ret);
+		dev_err(component->dev,
+				"Unrecognized PLL output freq (%d)\n", ret);
 		return ret;
 	}
 
@@ -261,7 +262,8 @@ static int power_down_audio_plls(struct snd_soc_component *component)
 static int coeff_ram_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
 	struct tscs42xx *tscs42xx = snd_soc_component_get_drvdata(component);
 	struct coeff_ram_ctl *ctl =
 		(struct coeff_ram_ctl *)kcontrol->private_value;
@@ -280,7 +282,8 @@ static int coeff_ram_get(struct snd_kcontrol *kcontrol,
 static int coeff_ram_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
 	struct tscs42xx *tscs42xx = snd_soc_component_get_drvdata(component);
 	struct coeff_ram_ctl *ctl =
 		(struct coeff_ram_ctl *)kcontrol->private_value;
@@ -363,7 +366,8 @@ static int dapm_micb_event(struct snd_soc_dapm_widget *w,
 static int pll_event(struct snd_soc_dapm_widget *w,
 		     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
 	int ret;
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
@@ -377,7 +381,8 @@ static int pll_event(struct snd_soc_dapm_widget *w,
 static int dac_event(struct snd_soc_dapm_widget *w,
 		     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
 	struct tscs42xx *tscs42xx = snd_soc_component_get_drvdata(component);
 	int ret;
 
@@ -819,16 +824,19 @@ static int setup_sample_format(struct snd_soc_component *component,
 		dev_err(component->dev, "Unsupported format width (%d)\n", ret);
 		return ret;
 	}
-	ret = snd_soc_component_update_bits(component, R_AIC1, RM_AIC1_WL, width);
+	ret = snd_soc_component_update_bits(component,
+			R_AIC1, RM_AIC1_WL, width);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to set sample width (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to set sample width (%d)\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int setup_sample_rate(struct snd_soc_component *component, unsigned int rate)
+static int setup_sample_rate(struct snd_soc_component *component,
+		unsigned int rate)
 {
 	struct tscs42xx *tscs42xx = snd_soc_component_get_drvdata(component);
 	unsigned int br, bm;
@@ -881,24 +889,32 @@ static int setup_sample_rate(struct snd_soc_component *component, unsigned int r
 	}
 
 	/* DAC and ADC share bit and frame clock */
-	ret = snd_soc_component_update_bits(component, R_DACSR, RM_DACSR_DBR, br);
+	ret = snd_soc_component_update_bits(component,
+			R_DACSR, RM_DACSR_DBR, br);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to update register (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to update register (%d)\n", ret);
 		return ret;
 	}
-	ret = snd_soc_component_update_bits(component, R_DACSR, RM_DACSR_DBM, bm);
+	ret = snd_soc_component_update_bits(component,
+			R_DACSR, RM_DACSR_DBM, bm);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to update register (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to update register (%d)\n", ret);
 		return ret;
 	}
-	ret = snd_soc_component_update_bits(component, R_ADCSR, RM_DACSR_DBR, br);
+	ret = snd_soc_component_update_bits(component,
+			R_ADCSR, RM_DACSR_DBR, br);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to update register (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to update register (%d)\n", ret);
 		return ret;
 	}
-	ret = snd_soc_component_update_bits(component, R_ADCSR, RM_DACSR_DBM, bm);
+	ret = snd_soc_component_update_bits(component,
+			R_ADCSR, RM_DACSR_DBM, bm);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to update register (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to update register (%d)\n", ret);
 		return ret;
 	}
 
@@ -1076,7 +1092,8 @@ static int tscs42xx_hw_params(struct snd_pcm_substream *substream,
 
 	ret = setup_sample_rate(component, params_rate(params));
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to setup sample rate (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to setup sample rate (%d)\n", ret);
 		return ret;
 	}
 
@@ -1087,7 +1104,8 @@ static inline int dac_mute(struct snd_soc_component *component)
 {
 	int ret;
 
-	ret = snd_soc_component_update_bits(component, R_CNVRTR1, RM_CNVRTR1_DACMU,
+	ret = snd_soc_component_update_bits(component,
+			R_CNVRTR1, RM_CNVRTR1_DACMU,
 		RV_CNVRTR1_DACMU_ENABLE);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to mute DAC (%d)\n",
@@ -1102,7 +1120,8 @@ static inline int dac_unmute(struct snd_soc_component *component)
 {
 	int ret;
 
-	ret = snd_soc_component_update_bits(component, R_CNVRTR1, RM_CNVRTR1_DACMU,
+	ret = snd_soc_component_update_bits(component,
+			R_CNVRTR1, RM_CNVRTR1_DACMU,
 		RV_CNVRTR1_DACMU_DISABLE);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to unmute DAC (%d)\n",
@@ -1117,8 +1136,8 @@ static inline int adc_mute(struct snd_soc_component *component)
 {
 	int ret;
 
-	ret = snd_soc_component_update_bits(component, R_CNVRTR0, RM_CNVRTR0_ADCMU,
-		RV_CNVRTR0_ADCMU_ENABLE);
+	ret = snd_soc_component_update_bits(component,
+			R_CNVRTR0, RM_CNVRTR0_ADCMU, RV_CNVRTR0_ADCMU_ENABLE);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to mute ADC (%d)\n",
 				ret);
@@ -1132,8 +1151,8 @@ static inline int adc_unmute(struct snd_soc_component *component)
 {
 	int ret;
 
-	ret = snd_soc_component_update_bits(component, R_CNVRTR0, RM_CNVRTR0_ADCMU,
-		RV_CNVRTR0_ADCMU_DISABLE);
+	ret = snd_soc_component_update_bits(component,
+			R_CNVRTR0, RM_CNVRTR0_ADCMU, RV_CNVRTR0_ADCMU_DISABLE);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to unmute ADC (%d)\n",
 				ret);
@@ -1171,8 +1190,8 @@ static int tscs42xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* Slave mode not supported since it needs always-on frame clock */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		ret = snd_soc_component_update_bits(component, R_AIC1, RM_AIC1_MS,
-				RV_AIC1_MS_MASTER);
+		ret = snd_soc_component_update_bits(component,
+				R_AIC1, RM_AIC1_MS, RV_AIC1_MS_MASTER);
 		if (ret < 0) {
 			dev_err(component->dev,
 				"Failed to set codec DAI master (%d)\n", ret);
@@ -1211,14 +1230,18 @@ static int tscs42xx_set_dai_bclk_ratio(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	ret = snd_soc_component_update_bits(component, R_DACSR, RM_DACSR_DBCM, value);
+	ret = snd_soc_component_update_bits(component,
+			R_DACSR, RM_DACSR_DBCM, value);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to set DAC BCLK ratio (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to set DAC BCLK ratio (%d)\n", ret);
 		return ret;
 	}
-	ret = snd_soc_component_update_bits(component, R_ADCSR, RM_ADCSR_ABCM, value);
+	ret = snd_soc_component_update_bits(component,
+			R_ADCSR, RM_ADCSR_ABCM, value);
 	if (ret < 0) {
-		dev_err(component->dev, "Failed to set ADC BCLK ratio (%d)\n", ret);
+		dev_err(component->dev,
+				"Failed to set ADC BCLK ratio (%d)\n", ret);
 		return ret;
 	}
 
@@ -1309,7 +1332,7 @@ static int part_is_valid(struct tscs42xx *tscs42xx)
 	};
 }
 
-static struct snd_soc_component_driver soc_codec_dev_tscs42xx = {
+static const struct snd_soc_component_driver soc_codec_dev_tscs42xx = {
 	.dapm_widgets		= tscs42xx_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(tscs42xx_dapm_widgets),
 	.dapm_routes		= tscs42xx_intercon,
@@ -1416,8 +1439,8 @@ static int tscs42xx_i2c_probe(struct i2c_client *i2c,
 	mutex_init(&tscs42xx->coeff_ram_lock);
 	mutex_init(&tscs42xx->pll_lock);
 
-	ret = devm_snd_soc_register_component(tscs42xx->dev, &soc_codec_dev_tscs42xx,
-			&tscs42xx_dai, 1);
+	ret = devm_snd_soc_register_component(tscs42xx->dev,
+			&soc_codec_dev_tscs42xx, &tscs42xx_dai, 1);
 	if (ret) {
 		dev_err(tscs42xx->dev, "Failed to register codec (%d)\n", ret);
 		return ret;
-- 
2.15.1
