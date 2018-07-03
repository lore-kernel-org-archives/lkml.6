Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B95BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8B523E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lUH6aQjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8B523E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeGCPf2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:35:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37922 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933726AbeGCPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Bl04FEFAJaip5H0dVFAs4XEo+w09yICtQW6QN1qhmes=; b=lUH6aQjDNqAm
        xdrQcq05RtDkYnpB0qb/19Vpo2CsUOr54yoJUVTwFPW/sYt9sOlOAYSqXhUSnhTXZrJrmjunlz6Ho
        DAZYRBJrzT+QNom/qEgA8hm4apsKvvbWN+lXhtkODlBda0f2BacAS3nLUt4bCO4R/eDEEabMZZsGi
        234Zg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJs-0006B1-8j; Tue, 03 Jul 2018 15:34:20 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJr-0003nQ-Qt; Tue, 03 Jul 2018 16:34:19 +0100
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
Subject: Applied "ASoC: AMD: Always subtract bytescount" to the asoc tree
In-Reply-To:  <20180702211956.149355-3-djkurtz@chromium.org>
Message-Id: <E1faNJr-0003nQ-Qt@debutante>
Date:   Tue, 03 Jul 2018 16:34:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Always subtract bytescount

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

From 715cdce04487fb23d5c10693b3bc01309fea955a Mon Sep 17 00:00:00 2001
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Mon, 2 Jul 2018 15:19:52 -0600
Subject: [PATCH] ASoC: AMD: Always subtract bytescount

It is always correct to subtract out the starting bytescount value.  Even
in the case of 2^64 byte rollover (292 Million Years in the future
@ 48000 Hz) the math still works out.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 4665ae12e74e..034fac3de037 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -995,8 +995,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd);
 
-	if (bytescount > rtd->bytescount)
-		bytescount -= rtd->bytescount;
+	bytescount -= rtd->bytescount;
 	pos = do_div(bytescount, buffersize);
 	return bytes_to_frames(runtime, pos);
 }
-- 
2.18.0.rc2

