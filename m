Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbeDMLXp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:23:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeDMLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:37 -0400
From: Mark Brown <broonie@kernel.org>
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS42xx: Shorten lines and other cleanup" to the asoc tree
In-Reply-To: <20180323232515.GA20519@t7-ThinkPad-E560>
Message-Id: <E1f6wnn-00006R-Gh@debutante>
Date: Fri, 13 Apr 2018 12:23:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS42xx: Shorten lines and other cleanup

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ca5b2b061e41ed97b1bc041bf0c0db2f40643863 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Wed, 4 Apr 2018 16:49:50 -0500
Subject: [PATCH] ASoC: TSCS42xx: Shorten lines and other cleanup

Shorten lines greater than 80 chars
Add const to struct snd_soc_component_driver

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 87 +++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index bbfc73a79b18..5ad68e5538ae 100644
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
2.17.0
