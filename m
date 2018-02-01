Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x227OjIJ15ffp3xNKXc1Wavfa3+vjNMwUAh1wd0KG36Lfok0XBFazPnst9iYpgght8uOMCmBo
ARC-Seal: i=1; a=rsa-sha256; t=1517475199; cv=none;
        d=google.com; s=arc-20160816;
        b=dohkDfFGpfwd0qRLeDNqt59XyhNhshn87/zOmTFDQfzro+z8Mh7+vpDDWEETLzn6gQ
         Pnj4SqM0eMLNvUotTP/Bra13R74IKScbVFT2pLxeDJ0I/qqhLlnU5ocWgMPL/RmKCHC5
         3tk3/mGu3hii6VvkQdG9gKZC9PrF0M65vUbvTQbxkVUMlxP75cj15QXiP4IanviXHIrw
         K9GUQ6/k2tgS5dgrRFo4VWzsW8S488yNFHz/gGtoCQ1abDRnepMA0J/IJb3bWYVwcdFM
         TRz1j8v/GIMrEkgLUjR2b6JaO5jb08RareHEVQlY0JKkkP38Y6zaE+2AnDg8Q+X26f+z
         mxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=iaWcD20VeB9+z9GkNE4KnN4POpMPP5I8ZV9DGziguVQ=;
        b=KJxgSoBLluf3nSTnwK829qcbYie2zLM33Qx1QFfSBsE7YhqI/5iwWBzTe4bunltAlm
         g9j8+Tcm+EGhrU4515FR/6HID1JWl8xkY0UVmzVixc/gDHiUnhb2pBjukQQBxM3umviH
         djNo0tegInJrLOtGh81b/NCriJUgVGhHi1lFXYi8RA0T6EfnNC2pRV35581Hzsea+JVx
         LLf4wvErTSfxI6HQqpbezvb6hkUsD6EQ/3jbzHhRcFx1rm+PfnTYw8lSpHNmP67HAMNI
         gPl128p4v/8WaBIs39hiwwI2GX7EYrn1P9f7ewB9gnBD89kYYuGffH78DQGCJmvq2l2R
         27GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FbTbFLra;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Vk0CYrdz;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FbTbFLra;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Vk0CYrdz;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42A9C6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
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
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
Date: Thu, 1 Feb 2018 14:23:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590021073891800456?=
X-GMAIL-MSGID: =?utf-8?q?1591188074955072783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,


On 1/31/2018 6:39 PM, Robin Murphy wrote:
> On 19/01/18 11:43, Vivek Gautam wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> Finally add the device link between the master device and
>> smmu, so that the smmu gets runtime enabled/disabled only when the
>> master needs it. This is done from add_device callback which gets
>> called once when the master is added to the smmu.
>
> Don't we need to balance this with a device_link_del() in 
> .remove_device (like exynos-iommu does)?

Right. Will add device_link_del() call. Thanks for pointing out.

regards
Vivek

>
> Robin.
>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 95478bfb182c..33bbcfedb896 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1367,6 +1367,7 @@ static int arm_smmu_add_device(struct device *dev)
>>       struct arm_smmu_device *smmu;
>>       struct arm_smmu_master_cfg *cfg;
>>       struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +    struct device_link *link;
>>       int i, ret;
>>         if (using_legacy_binding) {
>> @@ -1428,6 +1429,16 @@ static int arm_smmu_add_device(struct device 
>> *dev)
>>         pm_runtime_put_sync(smmu->dev);
>>   +    /*
>> +     * Establish the link between smmu and master, so that the
>> +     * smmu gets runtime enabled/disabled as per the master's
>> +     * needs.
>> +     */
>> +    link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
>> +    if (!link)
>> +        dev_warn(smmu->dev, "Unable to create device link between %s 
>> and %s\n",
>> +             dev_name(smmu->dev), dev_name(dev));
>> +
>>       return 0;
>>     out_cfg_free:
>>
