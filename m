Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x226tZgqwGanC57WdX6dFzpgkq7I4ZnD4p08oWkAm3JBmfs1GPIVaDsSBUsbI82XjgAPMyjCx
ARC-Seal: i=1; a=rsa-sha256; t=1517465646; cv=none;
        d=google.com; s=arc-20160816;
        b=WxqH4+ggyj2XbbV1Kn9dudvNz7DXaZ3L1kUEsdVKARYj98Iz29K+JPqhr6ehz7GWHG
         PlJSDiyiHWGu+LWNT52CaWmocag5EOPzAOA9wbA7gQP7gcVM33xstuABpyN67dbGzNFN
         rSCNCCdEkIvlWF1WhX8zYSkc6n24XoNUuDQudt2ZlIhiEb/nTr9TndjRhxHkpDc+p53D
         FXeN3ZGS7QY8gR0jrSdUwFkapPU6QNiYaFB397GBbyc0EgKcIq/SYjYEO/g/vISF0fCe
         kulDcXyr3MRE5gIMeri1uFc9tObECzeaS+ftP3FJDfT3WD76jeOBJVcfcsYVBS5lF2Sv
         CtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=dW4c6qrUdGw+WGhYruxWKlEm2oYEhz4C1zH8u6lMvqE=;
        b=hkd2AS/v7EGoL801wgjoPbMUKqQ02I4U9Bf2eLyRaQjbBplvyDi/ZtxHz+uazezi88
         L9xq3PbhvKFqWG1l1cfH6wh48/isvLqHKAVa7JICT6+wF1s/3EHAhvq6lfQ7kPAIcA6b
         iArZWRR2luiBDR9KX4paNhvrjE8UtjvSHVKoi5KqlPwRLVD70Jg+kkCGcsOmKe6NK4X1
         6IMJEhhq4SB/MeAdDuiuVs8bPmCMcb62HMwYHd0GtJKo68Sp2sA1YBpRE23DqGh5HRVG
         6HXmtL0FYNnVcpIxXvDERL9yojNDBZ34IYLlY4qFiSbfSv/ZqIOEjwj7gh2RwLtIA40Y
         NNFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YLXKd8sX;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jrfgy8Tj;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YLXKd8sX;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jrfgy8Tj;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31274606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v6 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
To: Robin Murphy <robin.murphy@arm.com>, alex.williamson@redhat.com,
 robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
 will.deacon@arm.com, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, sricharan@codeaurora.org,
 m.szyprowski@samsung.com, architt@codeaurora.org,
 linux-arm-msm@vger.kernel.org
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-3-git-send-email-vivek.gautam@codeaurora.org>
 <9942b74d-7437-21cc-cbd7-38f2844c5d1d@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <1bbaff1b-a3db-e9c4-5b32-2792ed6c4952@codeaurora.org>
Date: Thu, 1 Feb 2018 11:43:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <9942b74d-7437-21cc-cbd7-38f2844c5d1d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590021062654092311?=
X-GMAIL-MSGID: =?utf-8?q?1591178057578869855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 1/31/2018 5:53 PM, Robin Murphy wrote:
> On 19/01/18 11:43, Vivek Gautam wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu needs to be functional only when the respective
>> master's using it are active. The device_link feature
>> helps to track such functional dependencies, so that the
>> iommu gets powered when the master device enables itself
>> using pm_runtime. So by adapting the smmu driver for
>> runtime pm, above said dependency can be addressed.
>>
>> This patch adds the pm runtime/sleep callbacks to the
>> driver and also the functions to parse the smmu clocks
>> from DT and enable them in resume/suspend.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>> [vivek: Clock rework to request bulk of clocks]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 55 
>> ++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 78d4c6b8f1ba..21acffe91a1c 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -48,6 +48,7 @@
>>   #include <linux/of_iommu.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>>   @@ -205,6 +206,9 @@ struct arm_smmu_device {
>>       u32                num_global_irqs;
>>       u32                num_context_irqs;
>>       unsigned int            *irqs;
>> +    struct clk_bulk_data        *clocks;
>> +    int                num_clks;
>> +    const char * const        *clk_names;
>
> This seems unnecessary, as we use it a grand total of of once, during 
> initialisation when we have the source data directly to hand. Just 
> pass data->clks into arm_smmu_init_clks() as an additional argument.

Sure, will do that.
>
> Otherwise, I think this looks reasonable; it's about as unobtrusive as 
> it's going to get.

Thanks for reviewing.

regards
Vivek

>
> Robin.
>
>>       u32                cavium_id_base; /* Specific to Cavium */
>>   @@ -1685,6 +1689,25 @@ static int arm_smmu_id_size_to_bits(int size)
>>       }
>>   }
>>   +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
>> +{
>> +    int i;
>> +    int num = smmu->num_clks;
>> +
>> +    if (num < 1)
>> +        return 0;
>> +
>> +    smmu->clocks = devm_kcalloc(smmu->dev, num,
>> +                    sizeof(*smmu->clocks), GFP_KERNEL);
>> +    if (!smmu->clocks)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < num; i++)
>> +        smmu->clocks[i].id = smmu->clk_names[i];
>> +
>> +    return devm_clk_bulk_get(smmu->dev, num, smmu->clocks);
>> +}
>> +
>>   static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>   {
>>       unsigned long size;
>> @@ -1897,10 +1920,12 @@ static int arm_smmu_device_cfg_probe(struct 
>> arm_smmu_device *smmu)
>>   struct arm_smmu_match_data {
>>       enum arm_smmu_arch_version version;
>>       enum arm_smmu_implementation model;
>> +    const char * const *clks;
>> +    int num_clks;
>>   };
>>     #define ARM_SMMU_MATCH_DATA(name, ver, imp)    \
>> -static struct arm_smmu_match_data name = { .version = ver, .model = 
>> imp }
>> +static const struct arm_smmu_match_data name = { .version = ver, 
>> .model = imp }
>>     ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>   ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> @@ -2001,6 +2026,8 @@ static int arm_smmu_device_dt_probe(struct 
>> platform_device *pdev,
>>       data = of_device_get_match_data(dev);
>>       smmu->version = data->version;
>>       smmu->model = data->model;
>> +    smmu->clk_names = data->clks;
>> +    smmu->num_clks = data->num_clks;
>>         parse_driver_options(smmu);
>>   @@ -2099,6 +2126,10 @@ static int arm_smmu_device_probe(struct 
>> platform_device *pdev)
>>           smmu->irqs[i] = irq;
>>       }
>>   +    err = arm_smmu_init_clocks(smmu);
>> +    if (err)
>> +        return err;
>> +
>>       err = arm_smmu_device_cfg_probe(smmu);
>>       if (err)
>>           return err;
>> @@ -2197,7 +2228,27 @@ static int __maybe_unused 
>> arm_smmu_pm_resume(struct device *dev)
>>       return 0;
>>   }
>>   -static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
>> +static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
>> +{
>> +    struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +    return clk_bulk_prepare_enable(smmu->num_clks, smmu->clocks);
>> +}
>> +
>> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
>> +{
>> +    struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>> +
>> +    clk_bulk_disable_unprepare(smmu->num_clks, smmu->clocks);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops arm_smmu_pm_ops = {
>> +    SET_SYSTEM_SLEEP_PM_OPS(NULL, arm_smmu_pm_resume)
>> +    SET_RUNTIME_PM_OPS(arm_smmu_runtime_suspend,
>> +               arm_smmu_runtime_resume, NULL)
>> +};
>>     static struct platform_driver arm_smmu_driver = {
>>       .driver    = {
>>
