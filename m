Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EA0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213242083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcDiFuUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213242083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756590AbeFSIqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:46:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54924 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756453AbeFSIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:46:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so18444226wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=T7bx6rpiq0UWbh9QU9Snl7fZEZV5LNx/0Gv6ShM8+IA=;
        b=ZcDiFuUtwALRDgTOnxTdY3ioU2FDHGhwfi9otlc/J/EQXZsAQJD47jD4iZnDnhwclX
         j3/cDqEytO0CSVuHU0euYN/t3CwuVId4prIYBaLvjAzrs/HDTgkuB8i/ui6b5k+lpSeE
         MYpBV+U/NIeEsjXJxjaB8SVk1Q4p2pcRxrdCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T7bx6rpiq0UWbh9QU9Snl7fZEZV5LNx/0Gv6ShM8+IA=;
        b=mN89YmVpEL8FJ6k5anzN4FiAgxLNiG3QtkEGI5+uY4LAagGAxJsPVQXzNopyaJ4NEr
         NnsqGInGLNNShHbeK4MUqs6DAmh7p4MGxm++J2QcIyWU5W95RTdTKzaIf+bMz+RTrIXX
         1zH7BOw6ZU0U1FeKY+YihmMLPVsqYKjPC5gMWlXEOnejlSMED2kglKjB29uuIi1I9bub
         HNwDwMY5WZU06qRV6pLR4andYzQDt+tpg92Gn+tuWNPVLzY+PTIOxXhIfmV/bgFRkReP
         lVAnTLzSziodoPe0/FrWOyu6qS8hcqUQZdue2Z2IUKxz0mOSNUIrWFT4heGyisz5f5rF
         B5DA==
X-Gm-Message-State: APt69E2+gKYAjQUDIPW0XUWlbX72khnBPlsH/mRfV4aQTRIYYT/0C6nc
        Dwpn3IH26RT0wk9+I8qt2geOWDmMNWs=
X-Google-Smtp-Source: ADUXVKKAVUYAGTG8KZFGaVoSR4AH4I9gx8Z5Qv+afKlrzUKrPJmYcYM4bPC05uWmO7BRPBwCDmweiA==
X-Received: by 2002:a1c:110a:: with SMTP id 10-v6mr10149603wmr.130.1529397987940;
        Tue, 19 Jun 2018 01:46:27 -0700 (PDT)
Received: from [192.168.1.180] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id t14-v6sm20469439wrm.79.2018.06.19.01.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:46:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: add sdm845 sound card support
To:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
Message-ID: <f3f677bf-d0b5-baab-cf7c-4a7d7588259b@linaro.org>
Date:   Tue, 19 Jun 2018 09:46:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rohit for the patch!

On 18/06/18 12:16, Rohit kumar wrote:
> This patch adds sdm845 audio machine driver support.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   .../devicetree/bindings/sound/qcom,sdm845.txt      |  87 ++++
>   sound/soc/qcom/Kconfig                             |   9 +
>   sound/soc/qcom/Makefile                            |   2 +
>   sound/soc/qcom/sdm845.c                            | 539 +++++++++++++++++++++
>   4 files changed, 637 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt

Split the bindings into a separate patch!

>   create mode 100644 sound/soc/qcom/sdm845.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> new file mode 100644
> index 0000000..fc0e98c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> @@ -0,0 +1,87 @@
> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
> +
> +This binding describes the SDM845 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,sdm845-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board.
> +
> +- cdc-vdd-supply:
> +	Usage: Optional
> +	Value type: <phandle>
> +	Definition: phandle of regulator supply required for codec vdd.
> +
> += dailinks
> +Each subnode of sndcard represents either a dailink, and subnodes of each
> +dailinks would be cpu/codec/platform dais.
> +
> +- link-name:
> +	Usage: required
> +	Value type: <string>
> +	Definition: User friendly name for dai link
> +
> += CPU, PLATFORM, CODEC dais subnodes
> +- cpu:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: cpu dai sub-node
> +
> +- codec:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: codec dai sub-node
> +
> +- platform:
> +	Usage: opional

Optional
> +	Value type: <subnode>
> +	Definition: platform dai sub-node
> +
> +- sound-dai:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
> +
> +Example:
> +
> +audio {
> +	compatible = "qcom,sdm845-sndcard";
> +	qcom,model = "sdm845-snd-card";
> +	pinctrl-names = "pri_active", "pri_sleep";
> +	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
> +	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
> +
> +	qcom,audio-routing = "PRI_MI2S_RX Audio Mixer", "Pri-mi2s-gpio";
> +
> +	cdc-vdd-supply = <&pm8998_l14>;
> +
> +	fe@1 {
Lets not use fe or be reference here, its just a link.

> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +		platform {
> +			sound-dai = <&q6asmdai>;
> +		};
asmdai has sound-cell specifier as 1, so this will dtc will throw 
warning for this.

have a look at how 8996 is done.

> +	};
> +
> +	be@1 {
> +		link-name = "PRI MI2S Playback";
> +		cpu {
> +			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +};
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 87838fa..09de50d 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -90,3 +90,12 @@ config SND_SOC_MSM8996
>             Support for Qualcomm Technologies LPASS audio block in
>             APQ8096 SoC-based systems.
>             Say Y if you want to use audio device on this SoCs
> +
> +config SND_SOC_SDM845
> +	tristate "SoC Machine driver for SDM845 boards"
> +	depends on QCOM_APR
> +	select SND_SOC_QDSP6
> +	help
> +	  To add support for audio on Qualcomm Technologies Inc.
> +	  SDM845 SoC-based systems.
> +          Say Y if you want to use audio device on this SoCs
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> index 206945b..ac9609e 100644
> --- a/sound/soc/qcom/Makefile
> +++ b/sound/soc/qcom/Makefile
> @@ -14,10 +14,12 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
>   snd-soc-storm-objs := storm.o
>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>   snd-soc-apq8096-objs := apq8096.o
> +snd-soc-sdm845-objs := sdm845.o
>   
>   obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>   obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
> ++obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o

?? looks like typo here.

>   
>   #DSP lib
>   obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> new file mode 100644
> index 0000000..70d2611
> --- /dev/null
> +++ b/sound/soc/qcom/sdm845.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/component.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/atomic.h>

> +#include <linux/of_device.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <linux/soc/qcom/apr.h>
> +#include "qdsp6/q6afe.h"
> +
> +#define DEFAULT_SAMPLE_RATE_48K		48000
> +#define DEFAULT_MCLK_RATE		24576000
> +#define DEFAULT_BCLK_RATE		1536000
> +
> +struct sdm845_snd_data {
> +	struct snd_soc_card *card;
> +	struct regulator *vdd_supply;
> +	struct snd_soc_dai_link dai_link[];
> +};
> +
> +static struct mutex pri_mi2s_res_lock;
> +static struct mutex quat_tdm_res_lock;
> +static atomic_t pri_mi2s_clk_count;
> +static atomic_t quat_tdm_clk_count;
> +
> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
> +static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int ret = 0;
> +
> +	switch (cpu_dai->id) {
> +	case QUATERNARY_TDM_RX_0:
> +	case QUATERNARY_TDM_TX_0:
> +		ret = sdm845_tdm_snd_hw_params(substream, params);
> +		break;
> +	default:
> +		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int sdm845_snd_startup(struct snd_pcm_substream *substream)
> +{
> +	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +
> +	pr_debug("%s: dai_id: 0x%x\n", __func__, cpu_dai->id);
> +	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX:
> +	case PRIMARY_MI2S_TX:
> +		mutex_lock(&pri_mi2s_res_lock);

Mutex and atomic variables looks redundant here.
Can you explain why do you need both?
> +		if (atomic_inc_return(&pri_mi2s_clk_count) == 1) { > +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_MCLK_1,
> +				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +		}
> +		mutex_unlock(&pri_mi2s_res_lock);
> +		snd_soc_dai_set_fmt(cpu_dai, fmt);
> +		break;
> +	case QUATERNARY_TDM_RX_0:
> +	case QUATERNARY_TDM_TX_0:
> +		mutex_lock(&quat_tdm_res_lock);
> +		if (atomic_inc_return(&quat_tdm_clk_count) == 1) {
> +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +		}
> +		mutex_unlock(&quat_tdm_res_lock);
> +		break;
> +	default:
> +		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> +		break;
> +	}
> +	return 0;
> +}
> +

...
> +
> +static int sdm845_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	struct device_node *np, *codec, *platform, *cpu, *node;
> +	int ret, num_links;
> +	struct sdm845_snd_data *data;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(node);
> +
> +	dev_info(dev, "Found %d child audio dai links..\n", num_links);

Looks unnessary!

> +	/* Allocate the private data and the DAI link array */
> +	data = kzalloc(sizeof(*data) + sizeof(*link) * num_links,
> +			GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	card->dai_link = &data->dai_link[0];
> +	card->num_links = num_links;
> +	card->dapm_widgets = sdm845_widgets;
> +	card->num_dapm_widgets = ARRAY_SIZE(sdm845_widgets);
> +
> +	link = data->dai_link;
> +	data->card = card;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +
> +		if (!cpu) {
> +			dev_err(dev, "Can't find cpu DT node\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> +		if (!link->cpu_of_node) {
> +			dev_err(card->dev, "error getting cpu phandle\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		link->platform_of_node = of_parse_phandle(platform,
> +				"sound-dai", 0);
> +		if (!link->platform_of_node) {
> +			dev_err(card->dev, "error getting platform phandle\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting cpu dai name\n");
> +			goto fail;
> +		}
> +
> +		if (codec) {
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +			if (ret < 0) {
> +				dev_err(card->dev, "error getting codec dai name\n");
> +				goto fail;
> +			}
> +			link->no_pcm = 1;
> +			link->ignore_suspend = 1;
> +			link->ignore_pmdown_time = 1;
> +			link->ops = &sdm845_be_ops;
> +			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
> +		} else {
> +			link->dynamic = 1;
> +			link->codec_dai_name = "snd-soc-dummy-dai";
> +			link->codec_name = "snd-soc-dummy";
> +		}
> +

You could optimize this code, have a look at apq8096.c which does 
exactly same thing.

> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev,
> +				"error getting codec dai_link name\n");
> +			goto fail;
> +		}
> +
> +		link->dpcm_playback = 1;
> +		link->dpcm_capture = 1;
> +		link->stream_name = link->name;
> +		link++;
> +	}
> +	dev_set_drvdata(dev, card);
> +	snd_soc_card_set_drvdata(card, data);
> +
> +	return ret;
> +fail:
> +	kfree(data);
> +	return ret;
> +}
...
> +
> +static void sdm845_unbind(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> +
> +	mutex_destroy(&pri_mi2s_res_lock);
> +	mutex_destroy(&quat_tdm_res_lock);
> +	if (data->vdd_supply)
> +		regulator_put(data->vdd_supply);
> +	component_unbind_all(dev, card);
> +	snd_soc_unregister_card(card);
> +	kfree(data);
> +	kfree(card);
> +}
> +
> +static const struct component_master_ops sdm845_ops = {
> +	.bind = sdm845_bind,
> +	.unbind = sdm845_unbind,
> +};
> +
> +static int sdm845_runtime_resume(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> +
> +	if (!data->vdd_supply) {
> +		dev_dbg(dev, "no supplies defined\n");
> +		return 0;
> +	}
> +
> +	if (regulator_enable(data->vdd_supply))
> +		dev_err(dev, "Enable regulator supply failed\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdm845_snd_driver = {
> +	.probe = sdm845_snd_platform_probe,
> +	.remove = sdm845_snd_platform_remove,
> +	.driver = {
> +		.name = "msm-snd-sdm845",
> +		.pm = &sdm845_pm_ops,
> +		.owner = THIS_MODULE,
not necessary!
> +		.of_match_table = of_match_ptr(sdm845_snd_device_id),
> +	},
> +};
> +module_platform_driver(sdm845_snd_driver);
> +
> +MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
> +MODULE_LICENSE("GPL v2");
> 
