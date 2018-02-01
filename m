Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x224xBhhtxsxVem3ycbgNZSjbVeAGraegjpmHUef69N/NRDwkspYK8JU1l6uW15aHQPwsbGob
ARC-Seal: i=1; a=rsa-sha256; t=1517488323; cv=none;
        d=google.com; s=arc-20160816;
        b=pWL+gLqV5N4mvBSoDJkVtNeTZKuuqHUn1+lom0FP8wladQXdI979w71AYnaMTq+kXP
         g0TR2D+280oQoTxGEvozAELunrrRh4D8FLh3Dx+VyTk+glwifZrrImohS5tGW9f/ob/t
         sSXHV4aEWt7QeUPOMXvw8GMbHxiLwSvExM6Jwq6hSAoQhGMSCjuRcaSV4taICzFAPrAU
         jweHB3zIv3/yRCAs1gMRJTZIqkuol6kWafovZ7OMnQT/lZJL/gnB/dqZ98EETgBZw66E
         Pcor7K1wIkGiY5uV1IiWys0kQwL0zM222fvsyc9uwSN0m7bAcRAnt6bgV/H7S9HzuPtl
         LpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=TZKNmZgOJ60c37Yd+Ka/d8yqmTuziQH4GUMZlOeKcX8=;
        b=Zn/L1atLvOHSERMsOpynpOwb3GoNGI4/kCAsIMYD0FOt2zPFcYaNUwiCll9tJLTIUU
         twx6HX/SkLW1voy6KbV5rImPfcsinCNUknSBlvlntqIeFCR6vUPnVjxBV85aw8UOIM4O
         nmk2uqtE9PEVnxiYGS/ywc3XqzHRDtzMiw/Rms1zdkcStB8FejQ98fzwj/s25k8uWCXT
         yV8aomkHBSE6fKMrM8AvRaX/YDwoPC6jBZPAZmT550CuHGvcsdJ9Bjq7Utf5vsINaucU
         iFTM8cWP82uB8jlli+J8xlZgf0sJakT5DfP99o6Q1WpLwBTpAlJWVBfWNXV6EbDfOpgx
         MR5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eIYpJyek;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FJw/YNu8;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eIYpJyek;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FJw/YNu8;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88D42606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v6 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Sricharan R <sricharan@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, alex.williamson@redhat.com,
 robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
 will.deacon@arm.com, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
 architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-4-git-send-email-vivek.gautam@codeaurora.org>
 <5367e45a-8406-6dd2-1eb8-e1de9095af1a@arm.com>
 <bb9c23ec-c6d8-80fe-a80f-c33c961ab657@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <f580d22b-972f-3033-7a80-daea308c81f5@codeaurora.org>
Date: Thu, 1 Feb 2018 18:01:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <bb9c23ec-c6d8-80fe-a80f-c33c961ab657@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590021068374610802?=
X-GMAIL-MSGID: =?utf-8?q?1591201835938226832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/1/2018 5:03 PM, Sricharan R wrote:
> Hi Robin,
>
> On 1/31/2018 6:36 PM, Robin Murphy wrote:
>> On 19/01/18 11:43, Vivek Gautam wrote:
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> The smmu device probe/remove and add/remove master device callbacks
>>> gets called when the smmu is not linked to its master, that is without
>>> the context of the master device. So calling runtime apis in those places
>>> separately.
>>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> [vivek: Cleanup pm runtime calls]
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> ---
>>>    drivers/iommu/arm-smmu.c | 45 +++++++++++++++++++++++++++++++++++++++++----
>>>    1 file changed, 41 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 21acffe91a1c..95478bfb182c 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -914,11 +914,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>>        struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>        struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>        struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>> -    int irq;
>>> +    int ret, irq;
>>>          if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>            return;
>>>    +    ret = pm_runtime_get_sync(smmu->dev);
>>> +    if (ret)
>>> +        return;
>>> +
>>>        /*
>>>         * Disable the context bank and free the page tables before freeing
>>>         * it.
>>> @@ -933,6 +937,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>>          free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>>        __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>>> +
>>> +    pm_runtime_put_sync(smmu->dev);
>>>    }
>>>      static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>>> @@ -1408,12 +1414,20 @@ static int arm_smmu_add_device(struct device *dev)
>>>        while (i--)
>>>            cfg->smendx[i] = INVALID_SMENDX;
>>>    -    ret = arm_smmu_master_alloc_smes(dev);
>>> +    ret = pm_runtime_get_sync(smmu->dev);
>>>        if (ret)
>>>            goto out_cfg_free;
>>>    +    ret = arm_smmu_master_alloc_smes(dev);
>>> +    if (ret) {
>>> +        pm_runtime_put_sync(smmu->dev);
>>> +        goto out_cfg_free;
>> Please keep to the existing pattern and put this on the cleanup path with a new label, rather than inline.
>   ok.
>
>>> +    }
>>> +
>>>        iommu_device_link(&smmu->iommu, dev);
>>>    +    pm_runtime_put_sync(smmu->dev);
>>> +
>>>        return 0;
>>>      out_cfg_free:
>>> @@ -1428,7 +1442,7 @@ static void arm_smmu_remove_device(struct device *dev)
>>>        struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>>        struct arm_smmu_master_cfg *cfg;
>>>        struct arm_smmu_device *smmu;
>>> -
>>> +    int ret;
>>>          if (!fwspec || fwspec->ops != &arm_smmu_ops)
>>>            return;
>>> @@ -1436,8 +1450,21 @@ static void arm_smmu_remove_device(struct device *dev)
>>>        cfg  = fwspec->iommu_priv;
>>>        smmu = cfg->smmu;
>>>    +    /*
>>> +     * The device link between the master device and
>>> +     * smmu is already purged at this point.
>>> +     * So enable the power to smmu explicitly.
>>> +     */
>> I don't understand this comment, especially since we don't even introduce device links until the following patch... :/
>>
>   This is because the core device_del callback, does a device_links_purge for that device,
>   before calling the remove_device notifier. As a result, have to explicitly turn on the
>   power to iommu. Probably the comment should be removed, rest of the places we don't
>   explain why we are turning on explicitly.

Yes, will remove the comment here.

>
>>> +
>>> +    ret = pm_runtime_get_sync(smmu->dev);
>>> +    if (ret)
>>> +        return;
>>> +
>>>        iommu_device_unlink(&smmu->iommu, dev);
>>>        arm_smmu_master_free_smes(fwspec);
>>> +
>>> +    pm_runtime_put_sync(smmu->dev);
>>> +
>>>        iommu_group_remove_device(dev);
>>>        kfree(fwspec->iommu_priv);
>>>        iommu_fwspec_free(dev);
>>> @@ -2130,6 +2157,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>        if (err)
>>>            return err;
>>>    +    platform_set_drvdata(pdev, smmu);
>>> +
>>> +    pm_runtime_enable(dev);
>>> +
>>> +    err = pm_runtime_get_sync(dev);
>>> +    if (err)
>>> +        return err;
>>> +
>>>        err = arm_smmu_device_cfg_probe(smmu);
>>>        if (err)
>>>            return err;
>>> @@ -2171,9 +2206,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>            return err;
>>>        }
>>>    -    platform_set_drvdata(pdev, smmu);
>>>        arm_smmu_device_reset(smmu);
>>>        arm_smmu_test_smr_masks(smmu);
>>> +    pm_runtime_put_sync(dev);
>>>          /*
>>>         * For ACPI and generic DT bindings, an SMMU will be probed before
>>> @@ -2212,6 +2247,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>>>          /* Turn the thing off */
>>>        writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>>> +    pm_runtime_force_suspend(smmu->dev);
>> Why do we need this? I guess it might be a Qualcomm-ism as I don't see anyone else calling it from .remove other than a couple of other qcom_* drivers. Given that we only get here during system shutdown (or the root user intentionally pissing about with driver unbinding), it doesn't seem like a point where power saving really matters all that much.
>>
>> I'd also naively expect that anything this device was the last consumer off would get turned off by core code anyway once it's removed, but maybe things aren't that slick; I dunno :/
>   hmm, that should not be needed. with turning of all consumers taken care by device_link code before
>   the supplier (iommu) remove gets called should ensure that. So the above force_suspend should
>   not be needed/can be removed. But one more thing is, we do touch the register in the above code.
>   So that should require a additional get/put sync around that writel.

Possibly we can replace the force_suspend() with a pm_runtime_disable() 
to complement pm_runtime_enable in the probe.
I will test the scenario where we are writing the SMMU register in 
.remove path.

regards
Vivek

>
> Regards,
>   Sricharan
>
