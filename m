Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F3DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F241323E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LDRTYd3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F241323E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeGCPeV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:34:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933726AbeGCPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iCxwgXc3M1LUH8T95w/31pXFtexgrbv/fCrOH6XDNw8=; b=LDRTYd3GHhSR
        UUl6Id6QdrXwpstwiIM9Wjp4Ag6fTUdndvMYwEaQYu1PMg1aley2XwksnDCtVB+Igf5s7buoNT3hO
        3CND9u/JQuJIDlXyaa3lkrqOWWyT6HWX1GWCEGXLgmmfgWRtBToLmv++t7BySnPlxwjBPVUY6p3k8
        MObcg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJj-0006AT-Kg; Tue, 03 Jul 2018 15:34:11 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJj-0003is-6E; Tue, 03 Jul 2018 16:34:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Simplify trigger handler" to the asoc tree
In-Reply-To:  <20180702211956.149355-6-djkurtz@chromium.org>
Message-Id: <E1faNJj-0003is-6E@debutante>
Date:   Tue, 03 Jul 2018 16:34:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Simplify trigger handler

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

From df61f9f76609456efbc60d495b3235baf7d07691 Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:55 -0600
Subject: [PATCH] ASoC: AMD: Simplify trigger handler

Now that the I2S channel names are fixed, and DMA data flow order is
consistent (ch1 then ch2), we can simplify channel start order:
start the upstream channel and then the downstream channel for both
playback and capture cases.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index ab60129f4f26..65c1033bd51c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1024,10 +1024,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
 		rtd->bytescount = acp_get_byte_count(rtd);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_start(rtd->acp_mmio, rtd->ch1);
-			acp_dma_start(rtd->acp_mmio, rtd->ch2);
-		} else {
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 			if (rtd->capture_channel == CAP_CHANNEL0) {
 				acp_dma_cap_channel_disable(rtd->acp_mmio,
 							    CAP_CHANNEL1);
@@ -1040,9 +1037,9 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 				acp_dma_cap_channel_enable(rtd->acp_mmio,
 							   CAP_CHANNEL1);
 			}
-			acp_dma_start(rtd->acp_mmio, rtd->ch2);
-			acp_dma_start(rtd->acp_mmio, rtd->ch1);
 		}
+		acp_dma_start(rtd->acp_mmio, rtd->ch1);
+		acp_dma_start(rtd->acp_mmio, rtd->ch2);
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.18.0.rc2

