Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990C4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CB0214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4SQYKmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CB0214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeIZRIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:08:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35879 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeIZRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:08:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10-v6so3371756wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CYCpy6wUXybA78VmW2RA9tuZ3zcS78wdiasTrV33UGg=;
        b=I4SQYKmOsDUJgnDMQ3YYvHdP2DPpJi69/Vsz34S1VNPY/brpmC1pEUZ/GoQ6/am53j
         kFg753oYJyZojUzxjCL+/CeYYPPSAUkBiEIKp7Xn6BfLvrxXBY0F65QO+wVmna8C7e+i
         5ZN/l8F+KuX6lCdPaOMO8dQD9CfYfquOJK/gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CYCpy6wUXybA78VmW2RA9tuZ3zcS78wdiasTrV33UGg=;
        b=eXo3uI/ib+pQBUsChMvVshYSB+lgjZPTnjJ05Y8xqu9B+02ruaKDVhIW6ICj6i77sv
         Dn2ZXMsbyIHp407UizPP/wzTAq2StrbetlEkmnGg5/blMQKlNk8etYUGdh066Y8bqOR3
         b8YL7qHt4lyOOYXLm/yuKaU70x0CKg/js17GGgYgCtMgGtzvzC9fHDxkyrq6+m7HH+ai
         QBTQWoCUNCcUSCcWKswT3AL99bRMNDqeOLKxJKoEImHQc5xGVd0tYMhl91OS5fkVreFM
         vioT3smxjFPFVpSwvlb8iMjNGndr+Mj95hsHjkf6m1y09r+I9WZ1CHLbOcvZMlzCEdbh
         mzKA==
X-Gm-Message-State: ABuFfojmcCZbEPXEhiIRL5PKFhAMfEotMCD3sziqw3G/3AwWryuho0Cs
        R7UrAwbqszoP7+PhYHkV4VJx9g==
X-Google-Smtp-Source: ACcGV61R0p1NqqosLhFLzvwgTLDtwC7lpt3P/pO1EbZnsmmoOEdCmf9ROieibArbqkyuiCqFp1JZJQ==
X-Received: by 2002:a5d:5391:: with SMTP id d17-v6mr4573003wrv.191.1537959387577;
        Wed, 26 Sep 2018 03:56:27 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm8675961wmv.6.2018.09.26.03.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 03:56:26 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v4 14/14] ASoC: qcom: common: move
 be_hw_fixup to common
To:     Rohit Kumar <rohitkr@codeaurora.org>, lee.jones@linaro.org,
        robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
 <20180917005727.32728-15-srinivas.kandagatla@linaro.org>
 <500df2e4-6593-5537-ca08-b20a9b601c47@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1f89b5e9-a123-02f4-b8e8-ebcc89bbc99c@linaro.org>
Date:   Wed, 26 Sep 2018 11:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <500df2e4-6593-5537-ca08-b20a9b601c47@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/09/18 06:49, Rohit Kumar wrote:
> Hello Srinivas,
> 
> 
> We will add support for vi feedback usecase in sdm845 machine driver 
> where we have to support 4 channel tx data for a particular backend. We 
> should probably keep be_hw_params_fixup in respective machine driver for 
> now to support such requirement.
> 
I agree, we can drop this patch!

thanks,
srini
> 
> Thanks,
> 
> Rohit
> 
> 
> On 9/17/2018 6:27 AM, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> be_hw_fixup for qdsp is common across mutiple qcom machine drivers,
>> so move it to common file and remove the redundant code.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/apq8096.c | 15 ---------------
>>   sound/soc/qcom/common.c  | 17 +++++++++++++++++
>>   sound/soc/qcom/sdm845.c  | 22 ++--------------------
>>   3 files changed, 19 insertions(+), 35 deletions(-)
>>
>> diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
>> index daad43f..9cb26aee 100644
>> --- a/sound/soc/qcom/apq8096.c
>> +++ b/sound/soc/qcom/apq8096.c
>> @@ -20,20 +20,6 @@ struct apq8096_card_data {
>>       bool jack_setup;
>>   };
>> -static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>> -                      struct snd_pcm_hw_params *params)
>> -{
>> -    struct snd_interval *rate = hw_param_interval(params,
>> -                    SNDRV_PCM_HW_PARAM_RATE);
>> -    struct snd_interval *channels = hw_param_interval(params,
>> -                    SNDRV_PCM_HW_PARAM_CHANNELS);
>> -
>> -    rate->min = rate->max = 48000;
>> -    channels->min = channels->max = 2;
>> -
>> -    return 0;
>> -}
>> -
>>   static int msm_snd_hw_params(struct snd_pcm_substream *substream,
>>                    struct snd_pcm_hw_params *params)
>>   {
>> @@ -139,7 +125,6 @@ static void apq8096_add_be_ops(struct snd_soc_card 
>> *card)
>>       for (i = 0; i < num_links; i++) {
>>           if (link->no_pcm == 1) {
>> -            link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
>>               link->init = apq8096_init;
>>               link->ops = &apq8096_ops;
>>           }
>> diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
>> index eb1b9da..ce8e759 100644
>> --- a/sound/soc/qcom/common.c
>> +++ b/sound/soc/qcom/common.c
>> @@ -3,8 +3,24 @@
>>   // Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>   #include <linux/module.h>
>> +#include <sound/pcm_params.h>
>>   #include "common.h"
>> +static int qcom_snd_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>> +                       struct snd_pcm_hw_params *params)
>> +{
>> +    struct snd_interval *rate = hw_param_interval(params,
>> +                    SNDRV_PCM_HW_PARAM_RATE);
>> +    struct snd_interval *channels = hw_param_interval(params,
>> +                    SNDRV_PCM_HW_PARAM_CHANNELS);
>> +
>> +    rate->min = rate->max = 48000;
>> +    channels->min = channels->max = 2;
>> +    params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
>> +
>> +    return 0;
>> +}
>> +
>>   int qcom_snd_parse_of(struct snd_soc_card *card)
>>   {
>>       struct device_node *np;
>> @@ -79,6 +95,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
>>               }
>>               link->no_pcm = 1;
>>               link->ignore_pmdown_time = 1;
>> +            link->be_hw_params_fixup = qcom_snd_be_hw_params_fixup;
>>           } else {
>>               link->platform_of_node = link->cpu_of_node;
>>               link->codec_dai_name = "snd-soc-dummy-dai";
>> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
>> index 2a781d8..87e150c 100644
>> --- a/sound/soc/qcom/sdm845.c
>> +++ b/sound/soc/qcom/sdm845.c
>> @@ -11,7 +11,6 @@
>>   #include "common.h"
>>   #include "qdsp6/q6afe.h"
>> -#define DEFAULT_SAMPLE_RATE_48K        48000
>>   #define DEFAULT_MCLK_RATE        24576000
>>   #define DEFAULT_BCLK_RATE        12288000
>> @@ -177,32 +176,15 @@ static struct snd_soc_ops sdm845_be_ops = {
>>       .shutdown = sdm845_snd_shutdown,
>>   };
>> -static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
>> -                struct snd_pcm_hw_params *params)
>> -{
>> -    struct snd_interval *rate = hw_param_interval(params,
>> -                    SNDRV_PCM_HW_PARAM_RATE);
>> -    struct snd_interval *channels = hw_param_interval(params,
>> -                    SNDRV_PCM_HW_PARAM_CHANNELS);
>> -    struct snd_mask *fmt = hw_param_mask(params, 
>> SNDRV_PCM_HW_PARAM_FORMAT);
>> -
>> -    rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
>> -    channels->min = channels->max = 2;
>> -    snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
>> -
>> -    return 0;
>> -}
>> -
>>   static void sdm845_add_be_ops(struct snd_soc_card *card)
>>   {
>>       struct snd_soc_dai_link *link = card->dai_link;
>>       int i, num_links = card->num_links;
>>       for (i = 0; i < num_links; i++) {
>> -        if (link->no_pcm == 1) {
>> +        if (link->no_pcm == 1)
>>               link->ops = &sdm845_be_ops;
>> -            link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
>> -        }
>> +
>>           link++;
>>       }
>>   }
> 
