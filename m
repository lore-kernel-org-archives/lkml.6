Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeBTJgT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:36:19 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:42078 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeBTJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:36:13 -0500
X-Google-Smtp-Source: AH8x224w1g6WVDz7Se0LnHgBudHtd0UXtNOfs0l99mAlVgK0d4DN5XzXoj3XyyXpsVxSnVq7n01UBw==
Subject: Re: [alsa-devel] [PATCH v3 14/25] ASoC: qcom: qdsp6: Add support to
 q6afe dai driver
To: Rohit Kumar <rohitkr@codeaurora.org>, andy.gross@linaro.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org,
        spatakok@qti.qualcomm.com, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-15-srinivas.kandagatla@linaro.org>
 <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f5aed3f1-d037-861b-5efd-d6abd8cf7e6e@linaro.org>
Date: Tue, 20 Feb 2018 09:36:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <84723548-02a4-10e7-3de1-b347416d4fb0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for testing this out,

On 19/02/18 10:32, Rohit Kumar wrote:
>>
>> diff --git a/sound/soc/qcom/qdsp6/Makefile 
>> b/sound/soc/qcom/qdsp6/Makefile
>> index 660afcab98fd..c7833842b878 100644
>> --- a/sound/soc/qcom/qdsp6/Makefile
>> +++ b/sound/soc/qcom/qdsp6/Makefile
>> @@ -1,5 +1,5 @@
>>   obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
>> -obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
>> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o q6afe-dai.o
> depmod: ERROR: Cycle detected: q6afe -> q6afe_dai -> q6afe
> need to use like:
> +qdsp6_afe-objs := q6afe.o q6afe-dai.o
> +obj-$(CONFIG_SND_SOC_QDSP6_AFE) += qdsp6_afe.o
> similarly for asm and adm


Yep, will fix this in next version,

thanks,
srini
>>   obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o q6routing.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
>>   obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
>> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c 
>> b/sound/soc/qcom/qdsp6/q6afe-dai.c
>> new file mode 100644
>> index 000000000000..f6a618e9db9e 
