Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D86206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546887493;
	bh=VKklvMnL7U2HpS7uSWD0i52u1vj4CJ7F7scuvU7TyMA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GjiJ5Xb1SD3YCBtx0PTlCPWUddbVhVEV6jn2/HhKjO++8WEVxY8/3FfcHP45heQ7J
	 hNTDRnJ9NycUtAo4RJiQXjnNMv8LHgcrpLnpUQ9gCk1qQ51z+fLceAt+MYpymKl/vi
	 BLyygfvYZdq1JYJhfusa4nVmAUBpJg36059vAyfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfAGS6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:58:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfAGS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8mhR8S7CGb8l4xLCN6onbRFhQGIs5LN3sXJrRqQPQqI=; b=KyzB73bJcS59
        697R2x4bUWd+eg7VpBWhqKTHdszH00CuMvAjV/4TMrXDMh57AFiqzPK9fh4f+8KbwHLLlkiW0ARQF
        xb5O5VI1BCUBoT18gYImfDgXgVxo6LyDH2MLiu9ulkOBSFb2w11GhFfELELcJ138jkW/j23opvY8k
        F2KqI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gga68-0007mC-7r; Mon, 07 Jan 2019 18:58:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D87CB1127491; Mon,  7 Jan 2019 18:58:03 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Support Opensource <support.opensource@diasemi.com>,
        tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: fix endianness issues" to the asoc tree
In-Reply-To:  <20190105020249.8639-19-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190107185803.D87CB1127491@debutante.sirena.org.uk>
Date:   Mon,  7 Jan 2019 18:58:03 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: fix endianness issues

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

From 123c3def3bc5ea9958b8191d8139f610ed972d18 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:46 -0600
Subject: [PATCH] ASoC: da7219: fix endianness issues

Reported by Sparse.

da7219.c:440:44: warning: cast to restricted __le16
da7219.c:461:13: warning: incorrect type in assignment (different base types)
da7219.c:461:13:    expected unsigned short [unsigned] [usertype] val
da7219.c:461:13:    got restricted __le16 [usertype] <noident>
da7219.c:1451:16: warning: incorrect type in assignment (different base types)
da7219.c:1451:16:    expected unsigned short [unsigned] [usertype] offset
da7219.c:1451:16:    got restricted __le16 [usertype] <noident>

da7219-aad.c:150:37: warning: incorrect type in assignment (different base types)
da7219-aad.c:150:37:    expected unsigned short [unsigned] [usertype] tonegen_freq_hptest
da7219-aad.c:150:37:    got restricted __le16 [usertype] <noident>
da7219-aad.c:157:37: warning: incorrect type in assignment (different base types)
da7219-aad.c:157:37:    expected unsigned short [unsigned] [usertype] tonegen_freq_hptest
da7219-aad.c:157:37:    got restricted __le16 [usertype] <noident>

Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 2 +-
 sound/soc/codecs/da7219.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 2c7d5088e6f2..e0964b20a389 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -117,7 +117,7 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 
-	u16 tonegen_freq_hptest;
+	__le16 tonegen_freq_hptest;
 	u8 pll_srm_sts, pll_ctrl, gain_ramp_ctrl, accdet_cfg8;
 	int report = 0, ret = 0;
 
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e46e9f4bc994..ce165047b9f9 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -423,7 +423,7 @@ static int da7219_tonegen_freq_get(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mixer_ctrl =
 		(struct soc_mixer_control *) kcontrol->private_value;
 	unsigned int reg = mixer_ctrl->reg;
-	u16 val;
+	__le16 val;
 	int ret;
 
 	mutex_lock(&da7219->ctrl_lock);
@@ -450,7 +450,7 @@ static int da7219_tonegen_freq_put(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mixer_ctrl =
 		(struct soc_mixer_control *) kcontrol->private_value;
 	unsigned int reg = mixer_ctrl->reg;
-	u16 val;
+	__le16 val;
 	int ret;
 
 	/*
@@ -1396,7 +1396,7 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	struct snd_soc_component *component = dai->component;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 dai_bclks_per_wclk;
-	u16 offset;
+	__le16 offset;
 	u32 frame_size;
 
 	/* No channels enabled so disable TDM, revert to 64-bit frames */
-- 
2.20.1

