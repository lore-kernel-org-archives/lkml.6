Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3996C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB43A218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfAECDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:03:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:49511 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfAECDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:03:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634702"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:03:44 -0800
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
Subject: [PATCH 05/21] ASoC: rt5645: remove unused mux define
Date:   Fri,  4 Jan 2019 20:02:33 -0600
Message-Id: <20190105020249.8639-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

rt5645_if3_adc_in_mux, rt5645_inr_mux, and rt5645_inl_mux are not used.
Remove them from the driver.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index be674688dc40..52ce380c8f3a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1288,30 +1288,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_dac_r2_mux =
 	SOC_DAPM_ENUM("DAC2 R source", rt5645_dac2r_enum);
 
-
-/* INL/R source */
-static const char * const rt5645_inl_src[] = {
-	"IN2P", "MonoP"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inl_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INL_SEL_SFT, rt5645_inl_src);
-
-static const struct snd_kcontrol_new rt5645_inl_mux =
-	SOC_DAPM_ENUM("INL source", rt5645_inl_enum);
-
-static const char * const rt5645_inr_src[] = {
-	"IN2N", "MonoN"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_inr_enum, RT5645_INL1_INR1_VOL,
-	RT5645_INR_SEL_SFT, rt5645_inr_src);
-
-static const struct snd_kcontrol_new rt5645_inr_mux =
-	SOC_DAPM_ENUM("INR source", rt5645_inr_enum);
-
 /* Stereo1 ADC source */
 /* MX-27 [12] */
 static const char * const rt5645_stereo_adc1_src[] = {
@@ -1611,18 +1587,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_if2_adc_in_mux =
 	SOC_DAPM_ENUM("IF2 ADC IN source", rt5645_if2_adc_in_enum);
 
-/* MX-2F [1:0] */
-static const char * const rt5645_if3_adc_in_src[] = {
-	"IF_ADC1", "IF_ADC2", "VAD_ADC"
-};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5645_if3_adc_in_enum, RT5645_DIG_INF1_DATA,
-	RT5645_IF3_ADC_IN_SFT, rt5645_if3_adc_in_src);
-
-static const struct snd_kcontrol_new rt5645_if3_adc_in_mux =
-	SOC_DAPM_ENUM("IF3 ADC IN source", rt5645_if3_adc_in_enum);
-
 /* MX-31 [15] [13] [11] [9] */
 static const char * const rt5645_pdm_src[] = {
 	"Mono DAC", "Stereo DAC"
-- 
2.17.1

