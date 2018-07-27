Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B84208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4tqVCqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B84208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbeG0Nmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:42:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39535 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388871AbeG0NmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:42:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so4855400wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h0UL0hL4eaq2ilW7CEGbY3Go4irnNGMSMcSofuJmA9E=;
        b=W4tqVCqLM7GFt0OW1v5ruIXNmqwmImxGLny7dhyyNcDXV6cMC3JhOwvtjPBEl6lBIC
         /zVpO+Q5KrXirvZ9POT7w+7wSOH1RJYY73Zvv0MpDLFEJ6VKiWkpsPA9E1By8qCtMkCP
         kmxWPc34IdSre+53WP1c+Yt9KtjwuXnizxx84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h0UL0hL4eaq2ilW7CEGbY3Go4irnNGMSMcSofuJmA9E=;
        b=M58DKdUYEr/XhoJdKK2tP/XYIdLK1a3ZZgqe3h5iCzlDelZqiKF1Kv6jeKwijgkJqm
         o82z0QB4OH8vrrWbKymesQSiJZk3GYZS5QnHqi1S2rFgWmB6BG991W5csg0k3wndqe88
         HnscxHrwM5n1Vn0x1zt3tmYMA5WLh7CqhVxZ5YK+LAC9JDhCNkEsV41spHhmE9PD60PH
         iK7IkHIw9DBg60CHtHkaAAvGKv0YqDRoQ1akVaMLAGkZtaO39sjHRDfmmx8ADfUxrQlw
         Q59ZxG6Ma9UYxVmtP6ja3SlfQ33NqhWhAR3k0AZQzfLn9pprmeChjYZ89AITxjjOHv2q
         wlCw==
X-Gm-Message-State: AOUpUlGn24PLs4WszrGBUq41pSybXkyO7vhtIoFJq5x5B4rLnYmntE1s
        t3+N2m3suBJc4wCFbYAMll45+A==
X-Google-Smtp-Source: AAOMgpdCMynzTVWKUFlzDEhneeMFg+b83faYionAL+uW/BW7CizM1IfIHvhddyqm/v+ReUZ5v4V9eg==
X-Received: by 2002:adf:9546:: with SMTP id 64-v6mr4461673wrs.257.1532694037392;
        Fri, 27 Jul 2018 05:20:37 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6178522wmf.41.2018.07.27.05.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 05:20:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 10/10] ASoC: apq8096: add support to Analog audio via WCD9335 slim
Date:   Fri, 27 Jul 2018 13:18:06 +0100
Message-Id: <20180727121806.18209-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support Analog audio via WCD9335 Codec connected via SLIMBus.
Tested it on DB820c.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index a56156281c8d..b886c18177ef 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -10,6 +10,72 @@
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
 
+#define SLIM_MAX_TX_PORTS 16
+#define SLIM_MAX_RX_PORTS 16
+#define WCD9335_DEFAULT_MCLK_RATE	9600000
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
+	snd_soc_dai_set_sysclk(codec_dai, 0, 9600000,
+				SNDRV_PCM_STREAM_PLAYBACK);
+
+	return 0;
+}
+
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
@@ -100,6 +166,8 @@ static int apq8096_sbc_parse_of(struct snd_soc_card *card)
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+			link->init = apq8096_init;
+			link->ops = &apq8096_ops;
 		} else {
 			link->platform_of_node = link->cpu_of_node;
 			link->codec_dai_name = "snd-soc-dummy-dai";
-- 
2.16.2

