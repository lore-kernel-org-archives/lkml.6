Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C78C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0E220854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ku6y7gjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0E220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeKEVSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:18:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeKEVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GUBG7Fg66Qs4H4MxAwC8ybevySi7Kr3R39hUPxxMcsQ=; b=ku6y7gjP9iO8
        zep/fg9EhxScI1hZL35cR2bW4V2XIplDmxjKxe9IMqG3yyZGnssFb666a9ZmLslX5ixI0833b9e03
        z5LSq1SPRjlwDz5TGtpjoUsErAKSIrwBRHUBiZb/btk7PkXk2Y7cfjbuRkS8S23ODCpwY3Pa2N9Eg
        MMXfg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gJdWc-0008IN-DR; Mon, 05 Nov 2018 11:58:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1EC751124D98; Mon,  5 Nov 2018 11:58:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: codecs: constify snd_soc_dai_ops structures" to the asoc tree
In-Reply-To:  <1540647284-26728-4-git-send-email-Julia.Lawall@lip6.fr>
Message-Id: <20181105115834.1EC751124D98@debutante.sirena.org.uk>
Date:   Mon,  5 Nov 2018 11:58:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: codecs: constify snd_soc_dai_ops structures

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

From 704a9fc20b87f2929732cab0a1a04f28d4093085 Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 27 Oct 2018 15:34:44 +0200
Subject: [PATCH] ASoC: codecs: constify snd_soc_dai_ops structures

The snd_soc_dai_ops structures are only stored in the ops field of a
snd_soc_dai_driver structure, so make the snd_soc_dai_ops structures
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4458.c   | 2 +-
 sound/soc/codecs/ak5558.c   | 2 +-
 sound/soc/codecs/hdac_hda.c | 2 +-
 sound/soc/codecs/tas6424.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 299ada4dfaa0..70d4c89bd6fc 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -456,7 +456,7 @@ static int ak4458_startup(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_dai_ops ak4458_dai_ops = {
+static const struct snd_soc_dai_ops ak4458_dai_ops = {
 	.startup        = ak4458_startup,
 	.hw_params	= ak4458_hw_params,
 	.set_fmt	= ak4458_set_dai_fmt,
diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 448bb90c9c8e..60f1f12c81ea 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -246,7 +246,7 @@ static int ak5558_startup(struct snd_pcm_substream *substream,
 					  &ak5558_rate_constraints);
 }
 
-static struct snd_soc_dai_ops ak5558_dai_ops = {
+static const struct snd_soc_dai_ops ak5558_dai_ops = {
 	.startup        = ak5558_startup,
 	.hw_params	= ak5558_hw_params,
 
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 2aaa83028e55..ffecdaaa8cf2 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -46,7 +46,7 @@ static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
 static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 						 struct snd_soc_dai *dai);
 
-static struct snd_soc_dai_ops hdac_hda_dai_ops = {
+static const struct snd_soc_dai_ops hdac_hda_dai_ops = {
 	.startup = hdac_hda_dai_open,
 	.shutdown = hdac_hda_dai_close,
 	.prepare = hdac_hda_dai_prepare,
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 36aebdb8f55c..aaba39295079 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -378,7 +378,7 @@ static struct snd_soc_component_driver soc_codec_dev_tas6424 = {
 	.non_legacy_dai_naming	= 1,
 };
 
-static struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
+static const struct snd_soc_dai_ops tas6424_speaker_dai_ops = {
 	.hw_params	= tas6424_hw_params,
 	.set_fmt	= tas6424_set_dai_fmt,
 	.set_tdm_slot	= tas6424_set_dai_tdm_slot,
-- 
2.19.0.rc2

