Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C72C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E0220862
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RLOeT1fL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E0220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeH2P2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:28:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56762 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2P2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pEp0M+xWHMOY2ZfrKJ0OzbmwQ5x/wfV12zVijqBPuaY=; b=RLOeT1fLlPGO
        l1jfBwmLoXmOgtZPOG7uIEF3d1BbpQACVMVYfIyYBq5vHy0MfIKxqUDFGPQ83TJkXoBgnaZ+N+0WJ
        VVU++PRI7QJLxBCzn7C3izXWuwVVOPQVvzk6NBcBfCYxOtQ7+dfGzPgaWRJ3mUgHT3USAsAirUiWX
        ETwjY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuyh5-0008UK-NA; Wed, 29 Aug 2018 11:31:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6CD381124859; Wed, 29 Aug 2018 12:31:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pcm3060: Improve legibility of if-statements" to the asoc tree
In-Reply-To:  <20180828214231.10164-2-kmarinushkin@birdec.tech>
Message-Id: <20180829113127.6CD381124859@debutante.sirena.org.uk>
Date:   Wed, 29 Aug 2018 12:31:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3060: Improve legibility of if-statements

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

From 080aaf10892eec4b359126473e582f62ebb09496 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Tue, 28 Aug 2018 23:42:31 +0200
Subject: [PATCH] ASoC: pcm3060: Improve legibility of if-statements

Modified some if-statements to make them more clear

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 5b9718fa766d..494d9d662be8 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -68,7 +68,10 @@ static int pcm3060_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_FMT, val);
 
@@ -124,7 +127,10 @@ static int pcm3060_hw_params(struct snd_pcm_substream *substream,
 	}
 
 val_ready:
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_MS, val);
 
-- 
2.18.0

