Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89107C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4407B25B1C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HUCag/vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4407B25B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934133AbeGBKJq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:09:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41092 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934015AbeGBKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=gM8QA+KyDYI29ij4lqt9YgICRCQybBEZfhhwfHxlJHg=; b=HUCag/vb0UDO
        bTOwK7ijDJC8WBevofl7EgehXPOkQ59MCZAY3Y8MCEM4GVQzRan4sAdTJw3whsI9MC2PMYHToXCAu
        HQyzzUMA9ClvOLC+M5agHT40xDsCp9RTULZrBBeFYLb0qAegNwhfm3kP6dRMBYiwqFsxEnN3t/JpM
        NcFyU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvmB-000435-M5; Mon, 02 Jul 2018 10:09:43 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvmB-0006N9-83; Mon, 02 Jul 2018 11:09:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es7134: remove 64kHz rate from the supported rates" to the asoc tree
In-Reply-To:  <20180629150924.18197-2-jbrunet@baylibre.com>
Message-Id: <E1fZvmB-0006N9-83@debutante>
Date:   Mon, 02 Jul 2018 11:09:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es7134: remove 64kHz rate from the supported rates

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

From 5650729f9a1bbf65b57139d855dabe0a7e6cb494 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 29 Jun 2018 17:09:20 +0200
Subject: [PATCH] ASoC: es7134: remove 64kHz rate from the supported rates

64Khz is actually not supported by the es7134 according to the datasheet

Fixes: 9000b59d7a12 ("ASoC: es7134: add es7134 DAC driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 58515bb1a303..2fbb49f5b278 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -48,7 +48,11 @@ static struct snd_soc_dai_driver es7134_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000      |
+			  SNDRV_PCM_RATE_176400     |
+			  SNDRV_PCM_RATE_192000),
 		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
 			    SNDRV_PCM_FMTBIT_S18_3LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-- 
2.18.0.rc2

