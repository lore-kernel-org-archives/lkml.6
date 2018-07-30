Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F0920881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RB/xjYwc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Up46nVv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F0920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeG3Lpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:45:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42806 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeG3Lpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:45:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F53360128; Mon, 30 Jul 2018 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945498;
        bh=zkmfYTXXIxSRmVvs2CRzWZc952sriWGgN0YDYpaWYcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RB/xjYwcmIfeQ16vEAZssc/C09TpKG+vqSruMeFNGj4bE5t/w0NDm0I42qcOlX/Ah
         ZHcXmfM8w+LWbmrb7oy1rUyXC5SXaNMazwOdTpw9Z/uQUe16Yme/wWOZJcFOvuIhrD
         7RMUR0QMAxYg2zednwxgozQRECOBdv2H8jhTy0lI=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA84D61996;
        Mon, 30 Jul 2018 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532945496;
        bh=zkmfYTXXIxSRmVvs2CRzWZc952sriWGgN0YDYpaWYcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Up46nVv2qpuE1r2HV28kOs2rBqOz5qmA+v7+C8UIb5snstWbgvWpYn2vpyh7mQRev
         AAFpK0aahSyk0itCMfZZ+wWtsL3fQZBERsPeqsI0X1vZyOtm1dUP6g+HL+6o9ORNaG
         8g9K0axaldqs7ILEIWB/9dLo4LywN57kC0ATP4tw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA84D61996
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH v4 4/4] ASoC: qcom: add sdm845 sound card support
Date:   Mon, 30 Jul 2018 15:40:54 +0530
Message-Id: <1532945454-10437-5-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
References: <1532945454-10437-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sdm845 audio machine driver support.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig  |   8 ++
 sound/soc/qcom/Makefile |   2 +
 sound/soc/qcom/sdm845.c | 286 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 sound/soc/qcom/sdm845.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 87838fa..3507308 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -90,3 +90,11 @@ config SND_SOC_MSM8996
           Support for Qualcomm Technologies LPASS audio block in
           APQ8096 SoC-based systems.
           Say Y if you want to use audio device on this SoCs
+
+config SND_SOC_SDM845
+	tristate "SoC Machine driver for SDM845 boards"
+	select SND_SOC_QDSP6
+	help
+	  To add support for audio on Qualcomm Technologies Inc.
+	  SDM845 SoC-based systems.
+	  Say Y if you want to use audio device on this SoCs.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index fefecc0..f0e94d4 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -14,10 +14,12 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 snd-soc-apq8096-objs := apq8096.o common.o
+snd-soc-sdm845-objs := sdm845.o common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
+obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
 
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
new file mode 100644
index 0000000..a4fbcf5
--- /dev/null
+++ b/sound/soc/qcom/sdm845.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/atomic.h>
+#include <linux/of_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <linux/soc/qcom/apr.h>
+#include "common.h"
+#include "qdsp6/q6afe.h"
+
+#define DEFAULT_SAMPLE_RATE_48K		48000
+#define DEFAULT_MCLK_RATE		24576000
+#define DEFAULT_BCLK_RATE		12288000
+
+struct sdm845_snd_data {
+	struct snd_soc_card *card;
+	uint32_t pri_mi2s_clk_count;
+	uint32_t quat_tdm_clk_count;
+};
+
+static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
+
+static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret = 0;
+	int channels, slot_width;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		slot_width = 32;
+		break;
+	default:
+		dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
+				__func__, params_format(params));
+		return -EINVAL;
+	}
+
+	channels = params_channels(params);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0x3,
+				8, slot_width);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+				channels, tdm_slot_offset);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+	} else {
+		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0,
+				8, slot_width);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+
+		ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
+				tdm_slot_offset, 0, NULL);
+		if (ret < 0) {
+			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
+					__func__, ret);
+			goto end;
+		}
+	}
+end:
+	return ret;
+}
+
+static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret = 0;
+
+	switch (cpu_dai->id) {
+	case QUATERNARY_TDM_RX_0:
+	case QUATERNARY_TDM_TX_0:
+		ret = sdm845_tdm_snd_hw_params(substream, params);
+		break;
+	default:
+		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+		break;
+	}
+	return ret;
+}
+
+static int sdm845_snd_startup(struct snd_pcm_substream *substream)
+{
+	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		if (++(data->pri_mi2s_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_MCLK_1,
+				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
+				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		break;
+
+	case QUATERNARY_TDM_RX_0:
+	case QUATERNARY_TDM_TX_0:
+		if (++(data->quat_tdm_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
+				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		break;
+
+	default:
+		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+		break;
+	}
+	return 0;
+}
+
+static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		if (--(data->pri_mi2s_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_MCLK_1,
+				0, SNDRV_PCM_STREAM_PLAYBACK);
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
+				0, SNDRV_PCM_STREAM_PLAYBACK);
+		};
+		break;
+
+	case QUATERNARY_TDM_RX_0:
+	case QUATERNARY_TDM_TX_0:
+		if (--(data->quat_tdm_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
+				0, SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		break;
+
+	default:
+		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
+		break;
+	}
+}
+
+static struct snd_soc_ops sdm845_be_ops = {
+	.hw_params = sdm845_snd_hw_params,
+	.startup = sdm845_snd_startup,
+	.shutdown = sdm845_snd_shutdown,
+};
+
+static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
+	channels->min = channels->max = 2;
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+
+	return 0;
+}
+
+static void sdm845_add_be_ops(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *link = card->dai_link;
+	int i, num_links = card->num_links;
+
+	for (i = 0; i < num_links; i++) {
+		if (link->no_pcm == 1) {
+			link->ops = &sdm845_be_ops;
+			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
+		}
+		link++;
+	}
+}
+
+static int sdm845_snd_platform_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card;
+	struct sdm845_snd_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	/* Allocate the private data */
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	card->dev = dev;
+	card->auto_bind = true;
+	dev_set_drvdata(dev, card);
+	ret = qcom_snd_parse_of(card);
+	if (ret) {
+		dev_err(dev, "Error parsing OF data\n");
+		goto parse_dt_fail;
+	}
+
+	data->card = card;
+	snd_soc_card_set_drvdata(card, data);
+
+	sdm845_add_be_ops(card);
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(dev, "Sound card registration failed\n");
+		goto register_card_fail;
+	}
+	return ret;
+
+register_card_fail:
+	kfree(card->dai_link);
+parse_dt_fail:
+	kfree(data);
+	kfree(card);
+	return ret;
+}
+
+static int sdm845_snd_platform_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
+	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
+
+	card->auto_bind = false;
+	snd_soc_unregister_card(card);
+	kfree(card->dai_link);
+	kfree(data);
+	kfree(card);
+	return 0;
+}
+
+static const struct of_device_id sdm845_snd_device_id[]  = {
+	{ .compatible = "qcom,sdm845-sndcard" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sdm845_snd_device_id);
+
+static struct platform_driver sdm845_snd_driver = {
+	.probe = sdm845_snd_platform_probe,
+	.remove = sdm845_snd_platform_remove,
+	.driver = {
+		.name = "msm-snd-sdm845",
+		.of_match_table = sdm845_snd_device_id,
+	},
+};
+module_platform_driver(sdm845_snd_driver);
+
+MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

