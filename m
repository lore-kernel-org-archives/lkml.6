Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DE020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Gb4w+Wxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeHAPRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:17:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49936 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389217AbeHAPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Bzso0yPFRXB0hjxnhCVX1tjkvI+kPGpWymFWfLLFVKY=; b=Gb4w+WxjRmkh
        shVuje3CYRHA9IPULLqEktcz8mIT0sufif0DUauhoeP/U+PwEcTuLHt6+QsiiuqZeYqvAxAUh4sMF
        /6tzdcyn56Ruz2QR96K1BFWnK3L03WzUvsfBcRksbgc+CIECE+8EWxh1ttqc5XXuHJxqNzICRGQQ0
        e9ZfU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkrE0-0000zC-KT; Wed, 01 Aug 2018 13:31:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 25CCB1124241; Wed,  1 Aug 2018 14:31:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
        akshu.agrawal@amd.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: soc-pcm: Use delay set in component pointer function" to the asoc tree
In-Reply-To:  <1533118054-14509-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20180801133136.25CCB1124241@debutante.sirena.org.uk>
Date:   Wed,  1 Aug 2018 14:31:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-pcm: Use delay set in component pointer function

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

From 9fb4c2bf130b922c77c16a8368732699799c40de Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Wed, 1 Aug 2018 15:37:33 +0530
Subject: [PATCH] ASoC: soc-pcm: Use delay set in component pointer function

Take into account the base delay set in pointer callback.

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Now,
Total delay = base delay + cpu_dai delay + codec_dai delay

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4019bc10897c..9833e53754cb 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_sframes_t codec_delay = 0;
 	int i;
 
+	/* clearing the previous total delay */
+	runtime->delay = 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -1190,6 +1193,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 		offset = component->driver->ops->pointer(substream);
 		break;
 	}
+	/* base delay if assigned in pointer callback */
+	delay = runtime->delay;
 
 	if (cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
-- 
2.18.0

