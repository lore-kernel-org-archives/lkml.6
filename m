Return-Path: <sricharan@codeaurora.org>
X-Google-Smtp-Source: AH8x226UMbjaG+7yqqEI/0lB/Ro0gUaRq+t2KI2vhh7wHVDC8jh5z/tlS+0DoFuvGQXi8/CaGbmk
ARC-Seal: i=1; a=rsa-sha256; t=1517550033; cv=none;
        d=google.com; s=arc-20160816;
        b=pKMTmLVuu3Hh5DlpZ1zQ/LYL1yb1HsX6BO4D7bV8x4vhvrViq/DWJ4p7HRJ/mXoOso
         pSlRSQe9O5yICmrbiht+dhuLYJNCRtzLuSHkM0Kwlp2WB2lVdhKLBMWVpbw18XuUGk4v
         uT/u7oEtmIFHj8WVDGCtBNXZpLxbGx7qf6+33/dX9VQthcvIKeNZ8b1j1FuDv+7G8iTQ
         zvIXhrKWbVtpg9k2bTkKMUTSKu94uQawQwG0F5ATQeDVzbyoztQSs0fF7alDLc8hUxm7
         F6Hv5TmKJT0rX1mbT1QY1JNzOfzlPIRPjmpOnUydcWGC48Wc6dKRA5QHqqR5MHzyY6dm
         HalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=YTQFaxU6ImWW6LtZoQc170sUTcbEXX8uuKXbw0T1ZrY=;
        b=KRXOLJLss/Hd+iy8vSPdJ/sii2ognksGGkYKPYHwKaSPK8W45vQ48nsEbueNlXKpAy
         JWOscz8IqB9ICUITlQij1jfYosquNzu0z1uKM1hDzFi5LvfSPXdD1WyuJT8ynm/AayIE
         5KPyo2M6vqmI2oAQ4Zn/p0e7di6Hm/qKOLmpFXd7IcdwgFEUQz8wWcFZMTPxhHlLY0+K
         CCFa0sdKNW/hzfH4fUNrTypFYf64gzR+pPovmO05Y/NEi2FeJ/g8E32EkjyUFA9Qc0wc
         6EcA7IJ8iZT76ubP3oUW+r7QI+4JztNJvGbB8fEtit1nlP4Qf8N46soATj6cAyH1qgGL
         ZW7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CXkf5I0D;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DrtvdfE1;
       spf=pass (google.com: domain of sricharan@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sricharan@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=CXkf5I0D;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DrtvdfE1;
       spf=pass (google.com: domain of sricharan@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sricharan@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7068B601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, alex.williamson@redhat.com,
 robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
 will.deacon@arm.com, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
 architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
 <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
Date: Fri, 2 Feb 2018 11:10:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590021073891800456?=
X-GMAIL-MSGID: =?utf-8?q?1591266544254102215?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Robin/Vivek,

On 2/1/2018 2:23 PM, Vivek Gautam wrote:
> Hi,
> 
> 
> On 1/31/2018 6:39 PM, Robin Murphy wrote:
>> On 19/01/18 11:43, Vivek Gautam wrote:
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> Finally add the device link between the master device and
>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>> master needs it. This is done from add_device callback which gets
>>> called once when the master is added to the smmu.
>>
>> Don't we need to balance this with a device_link_del() in .remove_device (like exynos-iommu does)?
> 
> Right. Will add device_link_del() call. Thanks for pointing out.

 The reason for not adding device_link_del from .remove_device was, the core device_del 
 which calls the .remove_device from notifier, calls device_links_purge before that.
 That does the same thing as device_link_del. So by the time .remove_device is called,
 device_links for that device is already cleaned up. Vivek, you may want to check once that
 calling device_link_del from .remove_device has no effect, just to confirm once more.

Regards,
 Sricharan
 
> 
> regards
> Vivek
> 
>>
>> Robin.
>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> ---
>>>   drivers/iommu/arm-smmu.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 95478bfb182c..33bbcfedb896 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1367,6 +1367,7 @@ static int arm_smmu_add_device(struct device *dev)
>>>       struct arm_smmu_device *smmu;
>>>       struct arm_smmu_master_cfg *cfg;
>>>       struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>> +    struct device_link *link;
>>>       int i, ret;
>>>         if (using_legacy_binding) {
>>> @@ -1428,6 +1429,16 @@ static int arm_smmu_add_device(struct device *dev)
>>>         pm_runtime_put_sync(smmu->dev);
>>>   +    /*
>>> +     * Establish the link between smmu and master, so that the
>>> +     * smmu gets runtime enabled/disabled as per the master's
>>> +     * needs.
>>> +     */
>>> +    link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
>>> +    if (!link)
>>> +        dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
>>> +             dev_name(smmu->dev), dev_name(dev));
>>> +
>>>       return 0;
>>>     out_cfg_free:
>>>
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
