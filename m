Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeBRWCS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:02:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751858AbeBRWB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:56 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted ignore_suspend settings
Date: Sun, 18 Feb 2018 23:01:45 +0100
Message-Id: <20180218220146.22485-9-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ignore_suspend settings were added in an attempt to try and fix
suspend / resume issues. But they never fully fixed these and now we've
a proper fix, so lets remove these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b6a1cfeec830..c506a6e129ca 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -532,9 +532,6 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 			return ret;
 	}
 
-	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
-	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
-
 	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
 		/*
 		 * The firmware might enable the clock at
@@ -691,7 +688,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 						| SND_SOC_DAIFMT_CBS_CFS,
 		.be_hw_params_fixup = byt_rt5640_codec_fixup,
-		.ignore_suspend = 1,
 		.nonatomic = true,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-- 
2.14.3
