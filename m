Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeBRWCA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:02:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751883AbeBRWB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:57 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] ASoC: Intel: bytcr_rt5651: Drop unwanted ignore_suspend settings
Date: Sun, 18 Feb 2018 23:01:46 +0100
Message-Id: <20180218220146.22485-10-hdegoede@redhat.com>
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
 sound/soc/intel/boards/bytcr_rt5651.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 456526a93dd5..49c538f2770a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -335,8 +335,6 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 		dev_err(card->dev, "unable to add card controls\n");
 		return ret;
 	}
-	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
-	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
 		/*
@@ -487,7 +485,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 						| SND_SOC_DAIFMT_CBS_CFS,
 		.be_hw_params_fixup = byt_rt5651_codec_fixup,
-		.ignore_suspend = 1,
 		.nonatomic = true,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-- 
2.14.3
