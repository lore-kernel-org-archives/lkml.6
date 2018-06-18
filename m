Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B2EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA3D20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="JAWoaBO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA3D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934921AbeFRMAX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934724AbeFRMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YvFs6YDd1Tz5Vz+67hoqRvd0g1qX41webe04qQdSeDk=; b=JAWoaBO/SLiY
        qU1+sjZtxTjZnshyoKla2Bu4GZKdggW2OAQqHt1N/U8//gyvrrpm7e+8Bf9+7dVAMgqmFriyOaA4U
        4mtqsqmGSC8/mysrhLLFhF/pF4INKS5ep2ckhIHTx0idfJvqQvGMyCXUP2Ro+hOUCsGBD1Y1jnq4y
        YRqP8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspH-0007xQ-Sh; Mon, 18 Jun 2018 12:00:03 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspH-0008WL-AN; Mon, 18 Jun 2018 13:00:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: twl6040: make pointer dmic_codec_dev static" to the asoc tree
In-Reply-To:  <20180606093504.30255-1-colin.king@canonical.com>
Message-Id: <E1fUspH-0008WL-AN@debutante>
Date:   Mon, 18 Jun 2018 13:00:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: twl6040: make pointer dmic_codec_dev static

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

From 510e419cb85798915c6426c496a164ec6328d1a7 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 6 Jun 2018 10:35:04 +0100
Subject: [PATCH] ASoC: twl6040: make pointer dmic_codec_dev static

The pointer dmic_codec_dev is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
warning: symbol 'dmic_codec_dev' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-abe-twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 15ccbf479c96..d5ae9eb8c756 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -40,7 +40,7 @@ struct abe_twl6040 {
 	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
 };
 
-struct platform_device *dmic_codec_dev;
+static struct platform_device *dmic_codec_dev;
 
 static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
-- 
2.17.1

