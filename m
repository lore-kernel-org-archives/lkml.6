Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E52FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36848214DE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="U8gD5XIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36848214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbeKVAFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbeKVAFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=31eoGq9PHyYdUIe0uAMkJadiihu20X1s/sFwqCtQPRU=; b=U8gD5XIMgaR2
        7IQzPMzgh9ZfnpFxYFN33LuTy0c/580/PVscjTBScQVSlcAzAsciIBoGC+kir1yrCJ9XAkI5zVj9L
        f2mxfQ8iQ9qUInQ8mLlFxL0nKGUA3viIGHJuSQ/jE+FjGJWcr53CNMy0AJUSD1PwPiXS/n3ZGWFis
        9EHpQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPSaQ-0003Ze-C9; Wed, 21 Nov 2018 13:30:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 128EC11250AE; Wed, 21 Nov 2018 13:30:34 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: Update slot_width for Quaternary TDM port" to the asoc tree
In-Reply-To:  <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
Message-Id: <20181121133034.128EC11250AE@debutante.sirena.org.uk>
Date:   Wed, 21 Nov 2018 13:30:34 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: Update slot_width for Quaternary TDM port

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

From a1849b7dd30a07654b53f3599cc8f028afeb5d9f Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 16 Nov 2018 13:11:57 +0530
Subject: [PATCH] ASoC: sdm845: Update slot_width for Quaternary TDM port

Change slot_width for quaternary TDM port to 16 and
update bclk rate for TDM and MI2S interfaces
accordingly.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 8d0cdff64377..84e6ee7d78d3 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -13,7 +13,8 @@
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
-#define DEFAULT_BCLK_RATE		12288000
+#define TDM_BCLK_RATE		6144000
+#define MI2S_BCLK_RATE		1536000
 
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
@@ -33,7 +34,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		slot_width = 32;
+		slot_width = 16;
 		break;
 	default:
 		dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
@@ -115,7 +116,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
@@ -125,7 +126,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		if (++(data->quat_tdm_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		break;
 
-- 
2.19.0.rc2

