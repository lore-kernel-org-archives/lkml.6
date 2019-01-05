Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FAC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8990218E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfAECDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:03:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfAECDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:03:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634708"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:03:46 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/21] ASoC: rt5670: remove unused mux/mixer define
Date:   Fri,  4 Jan 2019 20:02:34 -0600
Message-Id: <20190105020249.8639-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

Some mux/mixer are not used. Remove them from the driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5670.c | 54 ---------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 453328c988c0..9a037108b1ae 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1057,20 +1057,6 @@ static const struct snd_kcontrol_new rt5670_lout_mix[] = {
 			RT5670_M_OV_R_LM_SFT, 1, 1),
 };
 
-static const struct snd_kcontrol_new rt5670_hpl_mix[] = {
-	SOC_DAPM_SINGLE("DAC L1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_DACL1_HML_SFT, 1, 1),
-	SOC_DAPM_SINGLE("INL1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_INL1_HML_SFT, 1, 1),
-};
-
-static const struct snd_kcontrol_new rt5670_hpr_mix[] = {
-	SOC_DAPM_SINGLE("DAC R1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_DACR1_HMR_SFT, 1, 1),
-	SOC_DAPM_SINGLE("INR1 Switch", RT5670_HPO_MIXER,
-			RT5670_M_INR1_HMR_SFT, 1, 1),
-};
-
 static const struct snd_kcontrol_new lout_l_enable_control =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5670_LOUT1,
 		RT5670_L_MUTE_SFT, 1, 1);
@@ -1196,24 +1182,6 @@ static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
 static const struct snd_kcontrol_new rt5670_sto2_adc_2_mux =
 	SOC_DAPM_ENUM("Stereo2 ADC 2 Mux", rt5670_stereo2_adc2_enum);
 
-
-/* MX-27 MX26 [10] */
-static const char * const rt5670_stereo_adc_src[] = {
-	"ADC1L ADC2R", "ADC3"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc_enum, RT5670_STO1_ADC_MIXER,
-	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
-
-static const struct snd_kcontrol_new rt5670_sto_adc_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC source", rt5670_stereo1_adc_enum);
-
-static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc_enum, RT5670_STO2_ADC_MIXER,
-	RT5670_ADC_SRC_SFT, rt5670_stereo_adc_src);
-
-static const struct snd_kcontrol_new rt5670_sto2_adc_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC source", rt5670_stereo2_adc_enum);
-
 /* MX-27 MX-26 [9:8] */
 static const char * const rt5670_stereo_dmic_src[] = {
 	"DMIC1", "DMIC2", "DMIC3"
@@ -1231,17 +1199,6 @@ static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_dmic_enum, RT5670_STO2_ADC_MIXER,
 static const struct snd_kcontrol_new rt5670_sto2_dmic_mux =
 	SOC_DAPM_ENUM("Stereo2 DMIC source", rt5670_stereo2_dmic_enum);
 
-/* MX-27 [0] */
-static const char * const rt5670_stereo_dmic3_src[] = {
-	"DMIC3", "PDM ADC"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5670_stereo_dmic3_enum, RT5670_STO1_ADC_MIXER,
-	RT5670_DMIC3_SRC_SFT, rt5670_stereo_dmic3_src);
-
-static const struct snd_kcontrol_new rt5670_sto_dmic3_mux =
-	SOC_DAPM_ENUM("Stereo DMIC3 source", rt5670_stereo_dmic3_enum);
-
 /* Mono ADC source */
 /* MX-28 [12] */
 static const char * const rt5670_mono_adc_l1_src[] = {
@@ -1334,17 +1291,6 @@ static SOC_ENUM_SINGLE_DECL(rt5670_if2_adc_in_enum, RT5670_DIG_INF1_DATA,
 static const struct snd_kcontrol_new rt5670_if2_adc_in_mux =
 	SOC_DAPM_ENUM("IF2 ADC IN source", rt5670_if2_adc_in_enum);
 
-/* MX-30 [5:4] */
-static const char * const rt5670_if4_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "IF_ADC3"
-};
-
-static SOC_ENUM_SINGLE_DECL(rt5670_if4_adc_in_enum, RT5670_DIG_INF2_DATA,
-	RT5670_IF4_ADC_IN_SFT, rt5670_if4_adc_in_src);
-
-static const struct snd_kcontrol_new rt5670_if4_adc_in_mux =
-	SOC_DAPM_ENUM("IF4 ADC IN source", rt5670_if4_adc_in_enum);
-
 /* MX-31 [15] [13] [11] [9] */
 static const char * const rt5670_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
-- 
2.17.1

