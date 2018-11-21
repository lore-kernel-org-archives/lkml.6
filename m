Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9959214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hvwNQAij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9959214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeKVAFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59872 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729422AbeKVAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7vLM6cXbM8lDiJ691NYEZuHRwvtnw739UsBMooyoJCs=; b=hvwNQAijwzOJ
        1mvxPVCwF//FXhY5RHS9BdX1VmCt8srBmg6+tzS3qOW2o766VVQKbLvb1C1VE3D3vtq4lQiCNnhBk
        AkPiHfWccBrjQmU5IHZF4n/QJPMRycTF+KD61iBd6VhyqcUOwQnPyZN1aktqHpmdg+vTxH16c04vY
        4A3CA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPSaG-0003ZQ-4F; Wed, 21 Nov 2018 13:30:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CC42911250AE; Wed, 21 Nov 2018 13:30:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: sdm845: Add support for Secondary MI2S interface" to the asoc tree
In-Reply-To:  <1542354118-23360-3-git-send-email-rohitkr@codeaurora.org>
Message-Id: <20181121133023.CC42911250AE@debutante.sirena.org.uk>
Date:   Wed, 21 Nov 2018 13:30:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: Add support for Secondary MI2S interface

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

From 992e75b3c80952fc60946458c75e1bf609e86aa2 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 16 Nov 2018 13:11:58 +0530
Subject: [PATCH] ASoC: sdm845: Add support for Secondary MI2S interface

Add support to configure bit clock for secondary MI2S
TX interface.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 84e6ee7d78d3..58593db2ab15 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -19,6 +19,7 @@
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
+	uint32_t sec_mi2s_clk_count;
 	uint32_t quat_tdm_clk_count;
 };
 
@@ -121,6 +122,15 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
 
+	case SECONDARY_MI2S_TX:
+		if (++(data->sec_mi2s_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
+		}
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		break;
+
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		if (++(data->quat_tdm_clk_count) == 1) {
@@ -157,6 +167,14 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 		};
 		break;
 
+	case SECONDARY_MI2S_TX:
+		if (--(data->sec_mi2s_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+				0, SNDRV_PCM_STREAM_CAPTURE);
+		}
+		break;
+
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		if (--(data->quat_tdm_clk_count) == 0) {
-- 
2.19.0.rc2

