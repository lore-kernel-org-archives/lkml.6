Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2FBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E52208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XlUBAMKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E52208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934994AbeFRMGv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:06:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44750 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934217AbeFRL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Uv3bXWDb9o8Tb7qDww4zaO3Idb1B6d2POWU2IkshKNs=; b=XlUBAMKeNiq4
        QE8joXl+1Y7UiEe0n/gVU8E4qLXdWmdX9hAKIAcV0ffKvfqnEyXj4AHpLeAXp+5cfX+KRwbzjvpQk
        lrcqABkKBPSZzoA/IY2y5xWv/Nb017tOWrTUXt64Udwi0A/8iX5awILwDQ8vjb83beA/cZ8tkGPab
        9Db60=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsp8-0007wk-Pb; Mon, 18 Jun 2018 11:59:54 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsp8-0008S8-CN; Mon, 18 Jun 2018 12:59:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: TSCS42xx: Remove Playback/Capture in names" to the asoc tree
In-Reply-To:  <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
Message-Id: <E1fUsp8-0008S8-CN@debutante>
Date:   Mon, 18 Jun 2018 12:59:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: TSCS42xx: Remove Playback/Capture in names

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

From 19d996cc3ad698379bcd8482dabe78abe3dc8d96 Mon Sep 17 00:00:00 2001
From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Date: Mon, 4 Jun 2018 15:46:28 -0500
Subject: [PATCH] ASoC: TSCS42xx: Remove Playback/Capture in names

These aren't needed and some userspace apps don't work consistently with
them.

Remove Playback/Capture from control names

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs42xx.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 743194052fc4..5d596e4dab0c 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -625,19 +625,19 @@ static int bytes_info_ext(struct snd_kcontrol *kcontrol,
 
 static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Volumes */
-	SOC_DOUBLE_R_TLV("Headphone Playback Volume", R_HPVOLL, R_HPVOLR,
+	SOC_DOUBLE_R_TLV("Headphone Volume", R_HPVOLL, R_HPVOLR,
 			FB_HPVOLL, 0x7F, 0, hpvol_scale),
-	SOC_DOUBLE_R_TLV("Speaker Playback Volume", R_SPKVOLL, R_SPKVOLR,
+	SOC_DOUBLE_R_TLV("Speaker Volume", R_SPKVOLL, R_SPKVOLR,
 			FB_SPKVOLL, 0x7F, 0, spkvol_scale),
-	SOC_DOUBLE_R_TLV("Master Playback Volume", R_DACVOLL, R_DACVOLR,
+	SOC_DOUBLE_R_TLV("Master Volume", R_DACVOLL, R_DACVOLR,
 			FB_DACVOLL, 0xFF, 0, dacvol_scale),
-	SOC_DOUBLE_R_TLV("PCM Capture Volume", R_ADCVOLL, R_ADCVOLR,
+	SOC_DOUBLE_R_TLV("PCM Volume", R_ADCVOLL, R_ADCVOLR,
 			FB_ADCVOLL, 0xFF, 0, adcvol_scale),
-	SOC_DOUBLE_R_TLV("Master Capture Volume", R_INVOLL, R_INVOLR,
+	SOC_DOUBLE_R_TLV("Input Volume", R_INVOLL, R_INVOLR,
 			FB_INVOLL, 0x3F, 0, invol_scale),
 
 	/* INSEL */
-	SOC_DOUBLE_R_TLV("Mic Boost Capture Volume", R_INSELL, R_INSELR,
+	SOC_DOUBLE_R_TLV("Mic Boost Volume", R_INSELL, R_INSELR,
 			FB_INSELL_MICBSTL, FV_INSELL_MICBSTL_30DB,
 			0, mic_boost_scale),
 
@@ -736,9 +736,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 		R_CLECTL, FB_CLECTL_LIMIT_EN, 1, 0),
 	SOC_SINGLE("Comp Switch",
 		R_CLECTL, FB_CLECTL_COMP_EN, 1, 0),
-	SOC_SINGLE_TLV("CLE Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("CLE Make-Up Gain Volume",
 		R_MUGAIN, FB_MUGAIN_CLEMUG, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("Comp Thresh Volume",
 		R_COMPTH, FB_COMPTH, 0xff, 0, compth_scale),
 	SOC_ENUM("Comp Ratio", compressor_ratio_enum),
 	SND_SOC_BYTES("Comp Atk Time", R_CATKTCL, 2),
@@ -769,9 +769,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
 	SOC_SINGLE("MBC1 Phase Invert Switch",
 		R_DACMBCMUG1, FB_DACMBCMUG1_PHASE, 1, 0),
-	SOC_SINGLE_TLV("DAC MBC1 Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC1 Make-Up Gain Volume",
 		R_DACMBCMUG1, FB_DACMBCMUG1_MUGAIN, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("DAC MBC1 Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC1 Comp Thresh Volume",
 		R_DACMBCTHR1, FB_DACMBCTHR1_THRESH, 0xff, 0, compth_scale),
 	SOC_ENUM("DAC MBC1 Comp Ratio",
 		dac_mbc1_compressor_ratio_enum),
@@ -781,9 +781,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
 	SOC_SINGLE("MBC2 Phase Invert Switch",
 		R_DACMBCMUG2, FB_DACMBCMUG2_PHASE, 1, 0),
-	SOC_SINGLE_TLV("DAC MBC2 Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC2 Make-Up Gain Volume",
 		R_DACMBCMUG2, FB_DACMBCMUG2_MUGAIN, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("DAC MBC2 Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC2 Comp Thresh Volume",
 		R_DACMBCTHR2, FB_DACMBCTHR2_THRESH, 0xff, 0, compth_scale),
 	SOC_ENUM("DAC MBC2 Comp Ratio",
 		dac_mbc2_compressor_ratio_enum),
@@ -793,9 +793,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 
 	SOC_SINGLE("MBC3 Phase Invert Switch",
 		R_DACMBCMUG3, FB_DACMBCMUG3_PHASE, 1, 0),
-	SOC_SINGLE_TLV("DAC MBC3 Make-Up Gain Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC3 Make-Up Gain Volume",
 		R_DACMBCMUG3, FB_DACMBCMUG3_MUGAIN, 0x1f, 0, mugain_scale),
-	SOC_SINGLE_TLV("DAC MBC3 Comp Thresh Playback Volume",
+	SOC_SINGLE_TLV("DAC MBC3 Comp Thresh Volume",
 		R_DACMBCTHR3, FB_DACMBCTHR3_THRESH, 0xff, 0, compth_scale),
 	SOC_ENUM("DAC MBC3 Comp Ratio",
 		dac_mbc3_compressor_ratio_enum),
-- 
2.17.1

