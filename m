Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FFFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EB22086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvLj+kib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EB22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeK0U3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:29:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbeK0U3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:29:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so21915495wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdwZ9/1jD9FOU4ROVHQhwX/3wFWQEF7g/z16vkWX8dc=;
        b=AvLj+kibHv9/HItUsb7E3v6Za1X1LCj4jBJux+lNNiaEWi4SIRd+mdlEgBWdm8ExCQ
         evP3XfD4H1WIKfo/kZBJcDaU1TVN9I7+QGuWp5RM6ANxSUrA1jymbqp95G1Sm0C/ubmp
         nd6hxrwJHmlxcjLvp/mh9+ywI/cGS4oalMBBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdwZ9/1jD9FOU4ROVHQhwX/3wFWQEF7g/z16vkWX8dc=;
        b=S4sp/aKIYrygy6Pmf6VLKJdEy+bgAAi0UAH81BPxvUyW4KFGXBtebZdnx9+cvs/Hbg
         wb4qxhsOnjo82NQDI54XdG1GjeXe0Aoq4M5ecIoYyOeCQs21LOox/4EPz3YJcHwvYOtk
         1s2r1C+DFCcBFOuETN4vG4g4DNFP65JviR803uZsawkZeMifTBUTYs61jXjPyMVD0PfX
         gQaaCOcQ+bT91S1c9jw6tXxr9TTRnhfnxnM4h5UVu2H15X7I7POIFmisdG0hgeuKt38e
         UMZ6zLlIpvVHxZSO1Tt65jOK+1IAvBq0nJ5esxzjQIsO6ae4VqP391c5ogTzfhQ/gbFz
         C81Q==
X-Gm-Message-State: AA+aEWYNnwhhfahY25DOT92TzblokQ7h7cMp3ZKo0Ghauv2r9LomhXX7
        X5pMDw2eBA+RoE16d6LA0/s4Gg==
X-Google-Smtp-Source: AFSGD/XUbTECH0FwjQlBqroKlFOcFHZw6NJQsgDADBUWjXT9E6170a1LT/DwKOHzCToj77Sduz488A==
X-Received: by 2002:adf:f211:: with SMTP id p17mr26567354wro.293.1543311144105;
        Tue, 27 Nov 2018 01:32:24 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 125-v6sm4525929wmr.22.2018.11.27.01.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:32:23 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: qcom: sdm845: Add codec related
 configuration for sdm845
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181124110948.209019-1-cychiang@chromium.org>
 <20181124110948.209019-3-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4f8debc0-40f3-6195-8acb-de9ae3335671@linaro.org>
Date:   Tue, 27 Nov 2018 09:32:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181124110948.209019-3-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch Jimmy,

On 24/11/18 11:09, Cheng-Yi Chiang wrote:
> Set TDM time slots and DAI format for speaker codec.
> Set DAI format and clock for headset. >
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

Overall the patch looks good for me, but this needs to be split into two 
patches + few more minor nits!
> ---
>   sound/soc/qcom/sdm845.c | 82 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 43c03f8e8cdc2..d815040e98dc9 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -6,12 +6,15 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/of_device.h>
> +#include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
>   #include <sound/jack.h>
> +#include <sound/soc.h>
>   #include <uapi/linux/input-event-codes.h>
>   #include "common.h"
>   #include "qdsp6/q6afe.h"
> +#include "../codecs/rt5663.h"
>   
>   #define DEFAULT_SAMPLE_RATE_48K		48000
>   #define DEFAULT_MCLK_RATE		24576000
> @@ -34,7 +37,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> -	int ret = 0;
> +	int ret = 0, j;
>   	int channels, slot_width;
>   
>   	switch (params_format(params)) {
> @@ -81,6 +84,31 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
>   			goto end;
>   		}
>   	}
> +
> +	for (j = 0; j < rtd->num_codecs; j++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
> +
> +		if (!strcmp(codec_dai->component->name_prefix, "Left")) {
> +			ret = snd_soc_dai_set_tdm_slot(
> +					codec_dai, 0x30, 0x3, 8, slot_width);

These constants needs some kind of defines to make the code more readable!

> +			if (ret < 0) {
> +				dev_err(rtd->dev,
> +					"DEV0 TDM slot err:%d\n", ret);
> +				return ret;
> +			}
> +		}
> +
> +		if (!strcmp(codec_dai->component->name_prefix, "Right")) {
> +			ret = snd_soc_dai_set_tdm_slot(
> +					codec_dai, 0xC0, 0x3, 8, slot_width);
> +			if (ret < 0) {
> +				dev_err(rtd->dev,
> +					"DEV1 TDM slot err:%d\n", ret);
> +				return ret;
> +			}
> +		}
> +	}
> +
>   end:
>   	return ret;
>   }
> @@ -90,9 +118,26 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>   	int ret = 0;
>   
>   	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX:
> +	case PRIMARY_MI2S_TX:
> +		/*
> +		 * Use ASRC for internal clocks, as PLL rate isn't multiple
> +		 * of BCLK.
> +		 */
> +		rt5663_sel_asrc_clk_src(
> +			codec_dai->component,
> +			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
> +			RT5663_CLK_SEL_I2S1_ASRC);
> +		ret = snd_soc_dai_set_sysclk(codec_dai,
> +				RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);

Use DEFAULT_MCLK_RATE here.


> +		if (ret < 0)
> +			dev_err(rtd->dev,
> +				"snd_soc_dai_set_sysclk err = %d\n", ret);
> +		break;
>   	case QUATERNARY_TDM_RX_0:
>   	case QUATERNARY_TDM_TX_0:
>   		ret = sdm845_tdm_snd_hw_params(substream, params);
> @@ -155,14 +200,20 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
>   static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   {
>   	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> +	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_card *card = rtd->card;
>   	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
Unnecessary New line here.

> +	int j;
> +	int ret;
>   
>   	switch (cpu_dai->id) {
>   	case PRIMARY_MI2S_RX:
>   	case PRIMARY_MI2S_TX:
> +		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
>   		if (++(data->pri_mi2s_clk_count) == 1) {
>   			snd_soc_dai_set_sysclk(cpu_dai,
>   				Q6AFE_LPASS_CLK_ID_MCLK_1,
> @@ -172,6 +223,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>   		}
>   		snd_soc_dai_set_fmt(cpu_dai, fmt);
> +		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
>   		break;
>   
>   	case SECONDARY_MI2S_TX:
> @@ -190,6 +242,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
>   				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
>   				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
>   		}
> +
> +		codec_dai_fmt |= SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
> +
> +		for (j = 0; j < rtd->num_codecs; j++) {
> +			codec_dai = rtd->codec_dais[j];
> +
> +			if (!strcmp(codec_dai->component->name_prefix,
> +				    "Left")) {
> +				ret = snd_soc_dai_set_fmt(
> +						codec_dai, codec_dai_fmt);
> +				if (ret < 0) {
> +					dev_err(rtd->dev,
> +						"Left TDM fmt err:%d\n", ret);
> +					return ret;
> +				}
> +			}
> +
> +			if (!strcmp(codec_dai->component->name_prefix,
> +				    "Right")) {
> +				ret = snd_soc_dai_set_fmt(
> +						codec_dai, codec_dai_fmt);
> +				if (ret < 0) {
> +					dev_err(rtd->dev,
> +						"Right TDM slot err:%d\n", ret);
> +					return ret;
> +				}
> +			}
> +		}
>   		break;
>   
>   	default:
> 
