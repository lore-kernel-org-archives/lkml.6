Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3233C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A65208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sJGL9s/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A65208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbeHANCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:02:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387590AbeHANCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MLRju/JvQxVpK6nPljZw2/YyDY82q8FtgGAXk8AYvrg=; b=sJGL9s/+RepP
        OsINOKDobvB/VbOcupNL8GoQU/Gs3/Se4RZHLHIAfNLgIoXDL5RjcOKszLVv3NbQjnTPkxaWRMsCO
        8yVd9BJYnF+boU1gzYvDFiTeNW1/cpTfJ5lHsvfbCcp0mMg2i/BXqeAfnZuX2Mol7VHEkTUPc/Rdb
        785iw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkp80-0000o7-KR; Wed, 01 Aug 2018 11:17:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 53E2D1124241; Wed,  1 Aug 2018 12:17:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: add sdm845 sound card support" to the asoc tree
In-Reply-To:  <1533114069-16570-5-git-send-email-rohitkr@codeaurora.org>
Message-Id: <20180801111716.53E2D1124241@debutante.sirena.org.uk>
Date:   Wed,  1 Aug 2018 12:17:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: add sdm845 sound card support

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

From 6b1687bf76ef84cb1e31386c4871a01fe66937bf Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Wed, 1 Aug 2018 14:31:09 +0530
Subject: [PATCH] ASoC: qcom: add sdm845 sound card support

This patch adds sdm845 audio machine driver support.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig  |   8 ++
 sound/soc/qcom/Makefile |   2 +
 sound/soc/qcom/sdm845.c | 286 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 sound/soc/qcom/sdm845.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 87838fa27997..350730839c6f 100644
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
index fefecc072265..f0e94d48ba98 100644
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
index 000000000000..bf4ec4646906
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
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
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
2.18.0

