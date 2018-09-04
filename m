Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D539AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5912086E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOGtlC4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5912086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeIDOw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43307 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeIDOwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so3359988wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xo+LywTGI/NZZfQlD2GoiNmhb+ig1aiyesIHof3m3Q=;
        b=jOGtlC4/8q2JI6KCwzTpbsS1caY6nByVTMa4hSh08d7tqxhLSunu+1yCBVpwCJuKOO
         y84HqbnnEfYc0YUKke1zyBYLUAE9vVk5Zjp4wtbrg9WzL2tJQnOjHlBQKxvUcleIib7j
         gcT0iUYGwvR2miaXqLa5BaT2sWyEEOjGEt8wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xo+LywTGI/NZZfQlD2GoiNmhb+ig1aiyesIHof3m3Q=;
        b=C5uZzy/n5oBNfIZt2Yr56XXgctHyGzKuas7MmP2lgn/G04daqY07ltdRIJEzYbaiyl
         TqLN4sI3P9RphoQ0WEh/51cxUn/Dpxc7M6LhuvvPEgjMIUl2+BXsPZr/vy4uyVNGbj2v
         wwgPCSQdJHKr5MvpAQJjlCsvyy81yIsr+XkzNaxZN/3UcsJ7uXrQWQRr3toJLIG1alzn
         egeyWXPQfW6ECTEzZEDuAAm5YpwSi9MGs+euQuwLxERNIts7L7FXJKRSeMvpLydeh9kO
         IosKEQyh4XSW0Urue+DY0PYsumYOMZFDhrVE5RumbvUzUT8uO+eme80zrkYt8e5hnrfZ
         oRtA==
X-Gm-Message-State: APzg51BeZzBEmCb7mIUkl+53N1fEQyklf7XLMu2zLTmLO4cD5fH5PwDI
        5Q/65Oc2g2MI2ryyPNgm+Y1Rcw==
X-Google-Smtp-Source: ANB0VdYYmzUNIvADXqK4omdEwitjvpz4M+DkyiwrmF3eCOtBCwEl0qSDMMvldFMfoKsZWy4eiB2Dfw==
X-Received: by 2002:adf:bbc5:: with SMTP id z5-v6mr21324231wrg.183.1536056865939;
        Tue, 04 Sep 2018 03:27:45 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 12/13] ASoC: apq8096: add slim support
Date:   Tue,  4 Sep 2018 11:24:59 +0100
Message-Id: <20180904102500.30318-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 69 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1543e85629f8..db07e9b62daf 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -9,6 +9,10 @@
 #include <sound/pcm.h>
 #include "common.h"
 
+#define SLIM_MAX_TX_PORTS 16
+#define SLIM_MAX_RX_PORTS 16
+#define WCD9335_DEFAULT_MCLK_RATE	9600000
+
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
@@ -19,6 +23,66 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
+}
+
+static int msm_snd_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
+	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
+	int ret = 0;
+
+	ret = snd_soc_dai_get_channel_map(codec_dai,
+				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
+	if (ret != 0 && ret != -ENOTSUPP) {
+		pr_err("failed to get codec chan map, err:%d\n", ret);
+		goto end;
+	} else if (ret == -ENOTSUPP) {
+		return 0;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+						  rx_ch_cnt, rx_ch);
+	else
+		ret = snd_soc_dai_set_channel_map(cpu_dai, tx_ch_cnt, tx_ch,
+						  0, NULL);
+	if (ret != 0 && ret != -ENOTSUPP)
+		pr_err("Failed to set cpu chan map, err:%d\n", ret);
+	else if (ret == -ENOTSUPP)
+		ret = 0;
+end:
+	return ret;
+}
+
+static struct snd_soc_ops apq8096_ops = {
+	.hw_params = msm_snd_hw_params,
+};
+
+static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/*
+	 * Codec SLIMBUS configuration
+	 * RX1, RX2, RX3, RX4, RX5, RX6, RX7, RX8, RX9, RX10, RX11, RX12, RX13
+	 * TX1, TX2, TX3, TX4, TX5, TX6, TX7, TX8, TX9, TX10, TX11, TX12, TX13
+	 * TX14, TX15, TX16
+	 */
+	unsigned int rx_ch[SLIM_MAX_RX_PORTS] = {144, 145, 146, 147, 148, 149,
+					150, 151, 152, 153, 154, 155, 156};
+	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
+					    134, 135, 136, 137, 138, 139,
+					    140, 141, 142, 143};
+
+	snd_soc_dai_set_channel_map(codec_dai, ARRAY_SIZE(tx_ch),
+					tx_ch, ARRAY_SIZE(rx_ch), rx_ch);
+
+	snd_soc_dai_set_sysclk(codec_dai, 0, WCD9335_DEFAULT_MCLK_RATE,
+				SNDRV_PCM_STREAM_PLAYBACK);
 
 	return 0;
 }
@@ -29,8 +93,11 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 	int i, num_links = card->num_links;
 
 	for (i = 0; i < num_links; i++) {
-		if (link->no_pcm == 1)
+		if (link->no_pcm == 1) {
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+			link->init = apq8096_init;
+			link->ops = &apq8096_ops;
+		}
 		link++;
 	}
 }
-- 
2.18.0

