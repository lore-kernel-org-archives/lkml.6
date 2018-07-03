Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7D1C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2D924AE5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="gP13slYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2D924AE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933907AbeGCPe0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:34:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933695AbeGCPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vfjk7g0HYRatru4dYAoVkVQhdW+SvxItahiA4m1DXDY=; b=gP13slYvG4hK
        X9l83Txfp7C4QONq6BJnbN9RKnBc3zAsQjPgyR9ZBliLXn/RjjTAYE15E+zZ/vssk7luSau0wz366
        g3J2jytWHB0JDzG0MyCP67CRWzfMM/NiYK+hxecpgjNRRoiR145N+L18os7YLSnvTeYxqUsLkteu8
        5nGPc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJu-0006BD-EC; Tue, 03 Jul 2018 15:34:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJu-0003oT-09; Tue, 03 Jul 2018 16:34:22 +0100
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
Subject: Applied "ASoC: AMD: Always stop ch2 first" to the asoc tree
In-Reply-To:  <20180702211956.149355-1-djkurtz@chromium.org>
Message-Id: <E1faNJu-0003oT-09@debutante>
Date:   Tue, 03 Jul 2018 16:34:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Always stop ch2 first

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

From 30896d3619bd80486a3f8a75d62ea3b58fc61ad5 Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:50 -0600
Subject: [PATCH] ASoC: AMD: Always stop ch2 first

Commit 6b116dfb4633a ("ASoC: AMD: make channel 1 dma as circular") made
both channels circular, so this comment and logic no longer applies.  Always
stop ch2 (the channel closest to the output) before ch1.  This ensures
that the downstream circular DMA channel does not continue to play/capture
repeated samples after the upstream circular DMA channel has already
stopped.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 3c3d398d0d0b..4665ae12e74e 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1067,21 +1067,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* For playback, non circular dma should be stopped first
-		 * i.e Sysram to acp dma transfer channel(rtd->ch1) should be
-		 * stopped before stopping cirular dma which is acp sram to i2s
-		 * fifo dma transfer channel(rtd->ch2). Where as in Capture
-		 * scenario, i2s fifo to acp sram dma channel(rtd->ch2) stopped
-		 * first before stopping acp sram to sysram which is circular
-		 * dma(rtd->ch1).
-		 */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-			ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-		} else {
-			acp_dma_stop(rtd->acp_mmio, rtd->ch2);
-			ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
-		}
+		acp_dma_stop(rtd->acp_mmio, rtd->ch2);
+		ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
 		rtd->bytescount = 0;
 		break;
 	default:
-- 
2.18.0.rc2

