Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E03AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022172150C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eZe3QHme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022172150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeIRXSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:18:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbeIRXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sNF0GuQ5D1+QSgH8cnNrFAajx7Z+bjr+l+21/DCzWW8=; b=eZe3QHmejEjc
        1DUOwAT4lRij6xLwYMOpVttUyeJ2lZSmJd5XV+8cGcRXwtS6tVaICGddMyFhJjb9MMxwv2Gy8/wbu
        tJrf+RO4uZ5JKnJP4X8/eG7VIxFkpm3goLd9uq60gVlXC5BxtKCz2AxzWHWjn+IVIJvKLuMZZ9Tcc
        6c7EM=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2K3b-0003WZ-5d; Tue, 18 Sep 2018 17:45:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 56D92440078; Tue, 18 Sep 2018 18:45:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        akshu.agrawal@amd.com, Mark Brown <broonie@kernel.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        cychiang@chromium.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Fix capture unstable in beginning for some runs" to the asoc tree
In-Reply-To:  <1537255398-25166-1-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20180918174501.56D92440078@finisterre.ee.mobilebroadband>
Date:   Tue, 18 Sep 2018 18:45:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Fix capture unstable in beginning for some runs

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

From c50535ed6a10fcae1b64ae83c0f6b1eeb5535afc Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Tue, 18 Sep 2018 12:53:13 +0530
Subject: [PATCH] ASoC: AMD: Fix capture unstable in beginning for some runs

alsa_conformance_test -C hw:0,4 -p 1024 --debug
would sometime show:
TIME_DIFF(s)    HW_LEVEL       READ              RATE
0.000095970         1024       1024    10670001.041992
0.042609555         1024       2048       24032.168372
0.021330364         1024       3072       48006.681930
0.021339559         1024       4096       47985.996337
The issue is that in dma pointer function we can have stale value
of the register for current descriptor of channel.
The register retains the number of the last descriptor that
was transferred.

Fix ensures that we report position, 0, till the one period worth of
data is transferred.  After one period of data, in handler of period
completion interrupt we update the config and correct value of descriptor
starts reflecting.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 77b265bd0505..3135e9eafd18 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1036,16 +1036,22 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
-		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
-		if (dscr == rtd->dma_dscr_idx_1)
-			pos = period_bytes;
-		else
-			pos = 0;
 		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
+		if (bytescount >= rtd->bytescount)
 			bytescount -= rtd->bytescount;
-		delay = do_div(bytescount, period_bytes);
-		runtime->delay = bytes_to_frames(runtime, delay);
+		if (bytescount < period_bytes) {
+			pos = 0;
+		} else {
+			dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
+			if (dscr == rtd->dma_dscr_idx_1)
+				pos = period_bytes;
+			else
+				pos = 0;
+		}
+		if (bytescount > 0) {
+			delay = do_div(bytescount, period_bytes);
+			runtime->delay = bytes_to_frames(runtime, delay);
+		}
 	} else {
 		buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 		bytescount = acp_get_byte_count(rtd);
-- 
2.19.0

