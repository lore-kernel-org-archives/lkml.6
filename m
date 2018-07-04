Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FDC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AC723E3D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dAriVezd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AC723E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeGDOmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:42:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52214 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeGDOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=hRvnedlgBA18rm3yl6RHSpk40mTrGbJXupIO0iMhtH8=; b=dAriVezdagYU
        nr9Mip74x7YPgLdnDqqvn7G+BfQ2FTPN9Hklei1PP/CaRLuG52NNA8otQ8joyAAs/8/MO7wGwoG14
        kZ8OD/yAFqLPxUOil6mQt9me4PJjh2ryvwGrxoFzyzs6UvZKQgUNpFTbqITvivRcIEl53VD4LlXcp
        4/d78=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyl-00073T-SR; Wed, 04 Jul 2018 14:41:59 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyl-0003ye-F9; Wed, 04 Jul 2018 15:41:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: add support to slim tx dais" to the asoc tree
In-Reply-To:  <20180704094944.16440-3-srinivas.kandagatla@linaro.org>
Message-Id: <E1faiyl-0003ye-F9@debutante>
Date:   Wed, 04 Jul 2018 15:41:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: add support to slim tx dais

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

From f03d6b1b4d2460a749fb2826aa71e15a66104a88 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:40 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: add support to slim tx dais

This patch adds support to SLIMbus TX dais in AFE module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 175 ++++++++++++++++++++++++++++---
 1 file changed, 161 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 1d2e5013c121..8dd3683eb367 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -382,23 +382,31 @@ static int q6slim_set_channel_map(struct snd_soc_dai *dai,
 	struct q6afe_port_config *pcfg = &dai_data->port_config[dai->id];
 	int i;
 
-	if (!rx_slot) {
-		pr_err("%s: rx slot not found\n", __func__);
-		return -EINVAL;
-	}
+	if (dai->id & 0x1) {
+		/* TX */
+		if (!tx_slot) {
+			pr_err("%s: tx slot not found\n", __func__);
+			return -EINVAL;
+		}
 
-	for (i = 0; i < rx_num; i++) {
-		pcfg->slim.ch_mapping[i] =   rx_slot[i];
-		pr_debug("%s: find number of channels[%d] ch[%d]\n",
-		       __func__, i, rx_slot[i]);
-	}
+		for (i = 0; i < tx_num; i++)
+			pcfg->slim.ch_mapping[i] = tx_slot[i];
+
+		pcfg->slim.num_channels = tx_num;
+
+
+	} else {
+		if (!rx_slot) {
+			pr_err("%s: rx slot not found\n", __func__);
+			return -EINVAL;
+		}
 
-	pcfg->slim.num_channels = rx_num;
+		for (i = 0; i < rx_num; i++)
+			pcfg->slim.ch_mapping[i] =   rx_slot[i];
 
-	pr_debug("%s: SLIMBUS_%d_RX cnt[%d] ch[%d %d]\n", __func__,
-		(dai->id - SLIMBUS_0_RX) / 2, rx_num,
-		pcfg->slim.ch_mapping[0],
-		pcfg->slim.ch_mapping[1]);
+		pcfg->slim.num_channels = rx_num;
+
+	}
 
 	return 0;
 }
@@ -443,6 +451,14 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
 	{"Slimbus5 Playback", NULL, "SLIMBUS_5_RX"},
 	{"Slimbus6 Playback", NULL, "SLIMBUS_6_RX"},
 
+	{"SLIMBUS_0_TX", NULL, "Slimbus Capture"},
+	{"SLIMBUS_1_TX", NULL, "Slimbus1 Capture"},
+	{"SLIMBUS_2_TX", NULL, "Slimbus2 Capture"},
+	{"SLIMBUS_3_TX", NULL, "Slimbus3 Capture"},
+	{"SLIMBUS_4_TX", NULL, "Slimbus4 Capture"},
+	{"SLIMBUS_5_TX", NULL, "Slimbus5 Capture"},
+	{"SLIMBUS_6_TX", NULL, "Slimbus6 Capture"},
+
 	{"Primary MI2S Playback", NULL, "PRI_MI2S_RX"},
 	{"Secondary MI2S Playback", NULL, "SEC_MI2S_RX"},
 	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
@@ -636,6 +652,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 			.rate_min = 8000,
 			.rate_max = 192000,
 		},
+	}, {
+		.name = "SLIMBUS_0_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_0_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus1 Playback",
@@ -654,6 +688,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_1_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+	}, {
+		.name = "SLIMBUS_1_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_1_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus1 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus2 Playback",
@@ -672,6 +724,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_2_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_2_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_2_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus2 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus3 Playback",
@@ -690,6 +761,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_3_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_3_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_3_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus3 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus4 Playback",
@@ -708,6 +798,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_4_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_4_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_4_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus4 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus5 Playback",
@@ -726,6 +835,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_5_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_5_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_5_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus5 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus6 Playback",
@@ -744,6 +872,25 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.id = SLIMBUS_6_RX,
 		.probe = msm_dai_q6_dai_probe,
 		.remove = msm_dai_q6_dai_remove,
+
+	}, {
+		.name = "SLIMBUS_6_TX",
+		.ops = &q6slim_ops,
+		.id = SLIMBUS_6_TX,
+		.probe = msm_dai_q6_dai_probe,
+		.remove = msm_dai_q6_dai_remove,
+		.capture = {
+			.stream_name = "Slimbus6 Capture",
+			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
+				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
+				 SNDRV_PCM_RATE_192000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE,
+			.channels_min = 1,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 192000,
+		},
 	}, {
 		.playback = {
 			.stream_name = "Primary MI2S Playback",
-- 
2.18.0.rc2

