Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65212C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1068623CAA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gE3WzwpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1068623CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeGDJwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:52:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36672 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932733AbeGDJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:51:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so4679409wrm.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J9NlNC+HBVbx9h/W6EWGYjYfY0/f9mmfn41Tkqa7hTE=;
        b=gE3WzwpVqU8ousmUcUUdG4i+ZlzO9CPG1V7XS53U2AjsUmUmN96l+QMpI6d+TynSt2
         9UcxmbBH/CXuNPAVeCU0NI0MuIIMSdkWdei81q4cyHb5HgF5dqrCD7RrwnZjN0sbxsq0
         B66xLBmif6AjUwznUKuIl18AlcJfGC0B9H3Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J9NlNC+HBVbx9h/W6EWGYjYfY0/f9mmfn41Tkqa7hTE=;
        b=JTEXQy2Cs602pa7cRRLYodWngxx/cUGm8tdkMko887iwWr3WxatkqsZXYybEKdNyjV
         ZFUK0TIbsvi3JFY9wL++J0vrd7q0xXnM6Ht3unNgrit5TFlY1ee39fwKttiqSnko48mg
         oSLlrpX8Rua1BirN2yTMzgTkDRq0DmPPexGC9RZuvLi81bLEgaKdXjVunvmM/YC9re23
         KFt5xuCgKTdeTrBk1IRaP2kHf4Wd5tDzAYmfsvI9Wh4iCn6die6IC+5gU0DN93qQBvQ2
         WmXkXdiGpzlZynX6awqqIwdhUqIWu/dMWFtAynrgMcbGWUIDRsZVwx0OljOC8KgdH5pI
         ytPQ==
X-Gm-Message-State: APt69E2nCmljcxC7lQtmExJRvo/kcnjW53t8Y8NIey03MpbqJTao7fuB
        qq0TOz6LxQCA8CG9Su9GoPiwEw==
X-Google-Smtp-Source: AAOMgpfPF2e/LpPusfdpUujZvLc2OCo/ivugPJkjnZE6c2g+0/94HAcIZGtpKG20lsVlo9SazhKArQ==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr1090402wrd.272.1530697915216;
        Wed, 04 Jul 2018 02:51:55 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] ASoC: qdsp6: q6afe-dai: add support to slim tx dais
Date:   Wed,  4 Jul 2018 10:49:40 +0100
Message-Id: <20180704094944.16440-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to SLIMbus TX dais in AFE module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 175 +++++++++++++++++++++++++++++++++++----
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
2.16.2

