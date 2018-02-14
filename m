Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x225STY6VmNls36ywBYXg7iIGYt+Dy51ClxtYZu98EPanzbEy0dy60aF/7cHN2MkCInmMTtXB
ARC-Seal: i=1; a=rsa-sha256; t=1518596682; cv=none;
        d=google.com; s=arc-20160816;
        b=pP7zMkRrFww9IQoKkDapNXgHkF2SBPg+jVLcFUzApBlPJK7WrZc1//noiO3obNvLnj
         IpYOqSD+1CBJVdvGIzRBNMQ6EwTv9xIjA82OLiYeVGfsq3oe3PZRqx9yusF2QFe9T9ca
         j3f1uoz1XjT+gKNpqdOwXJThnXiNQJ4la/C5ZpFXrYre9V/crhUH7OOJ9fl4TomQpgR3
         pJrr7MImJo4d+pzj6uuD6jVBk+yOHYiKCrpBaAQIdyX3qtJcUruASTVn6JKJS9b4bihR
         dRHi819VOxGumZwGKvlzfQNl0BUJo4zXYGBsxZe7gmdt1XatNrN/MFm5jnZldkDT+PgF
         fZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=H+Z9mAhbGZFEbqFAJAtiRK2nNMw5PoUS/Auqtc7zY7Q=;
        b=Tq+H7lf/DVg7WNnWkWmJyFsWgFHt/yJ0C9/lhJDdP6CJ0PusviEc4g+xB3v1PrLoBX
         FeEEnZQngvZjkHJ9JoIZiais0LBlOwHFOZzZvaGfGVjkoG3WGQGWrB+uF4kIvll4AIB4
         qvuMTEXQq4tjiFJdmvJBHAGDCBa2Zy9tETC1LfbKnphIFpMXS0ljzi09W9mlrLLh8qkD
         iDua+gnNJzAzHkHquqLYAOneZ3/7WxhhwUso+N2aj6i1Tp/fr9wrskV5nLD5o5j1TkDD
         afQeDg4QAU+MlcL6qBhOVCgunuvRmq69Km+Dhr6aI0gtSiYNmnrSn2HF8OyXABBIp2n6
         UCxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HHuiM9Ut;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ar8KbmWF;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HHuiM9Ut;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ar8KbmWF;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9870660F78
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DJtQYPg5S3Ep2bK27+D5rQiKuA-uPfMDUon3FudmGF0w@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
 <906051dd-8898-ec6f-5ad4-3f37716292cf@arm.com> <CAAFQd5DJtQYPg5S3Ep2bK27+D5rQiKuA-uPfMDUon3FudmGF0w@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 14 Feb 2018 13:54:39 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHa6n+DbtWPVNNm7qhnd3rnnwDEiK2o1UaPPVOqHzOkjA@mail.gmail.com>
Message-ID: <CAFp+6iHa6n+DbtWPVNNm7qhnd3rnnwDEiK2o1UaPPVOqHzOkjA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	devicetree@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1592364035483150829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 7:22 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Tue, Feb 13, 2018 at 9:57 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 13/02/18 08:24, Tomasz Figa wrote:
>>>
>>> Hi Vivek,
>>>
>>> Thanks for the patch. Please see my comments inline.
>>>
>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>>
>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>
>>>> The smmu device probe/remove and add/remove master device callbacks
>>>> gets called when the smmu is not linked to its master, that is without
>>>> the context of the master device. So calling runtime apis in those places
>>>> separately.
>>>>
>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>> [vivek: Cleanup pm runtime calls]
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> ---
>>>>   drivers/iommu/arm-smmu.c | 42
>>>> ++++++++++++++++++++++++++++++++++++++----
>>>>   1 file changed, 38 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>> index 9e2f917e16c2..c024f69c1682 100644
>>>> --- a/drivers/iommu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm-smmu.c
>>>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct
>>>> iommu_domain *domain)
>>>>          struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>          struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>          struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>>> -       int irq;
>>>> +       int ret, irq;
>>>>
>>>>          if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>>                  return;
>>>>
>>>> +       ret = pm_runtime_get_sync(smmu->dev);
>>>> +       if (ret)
>>>> +               return;
>>>
>>>
>>> pm_runtime_get_sync() will return 0 if the device was powered off, 1
>>> if it was already/still powered on or runtime PM is not compiled in,
>>> or a negative value on error, so shouldn't the test be (ret < 0)?
>>>
>>> Moreover, I'm actually wondering if it makes any sense to power up the
>>> hardware just to program it and power it down again. In a system where
>>> the IOMMU is located within a power domain, it would cause the IOMMU
>>> block to lose its state anyway.
>>
>>
>> This is generally for the case where the SMMU internal state remains active,
>> but the programming interface needs to be powered up in order to access it.
>
> That's true for Qualcomm SMMU, but I think that would be different for
> existing users of the driver?
>
>>
>>> Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
>>> pm_runtime/sleep ops", perhaps it would make more sense to just
>>> control the clocks independently of runtime PM? Then, runtime PM could
>>> be used for real power management, e.g. really powering the block up
>>> and down, for further power saving.
>>
>>
>> Unfortunately that ends up pretty much unmanageable, because there are
>> numerous different SMMU microarchitectures with fundamentally different
>> clock/power domain schemes (multiplied by individual SoC integration
>> possibilities). Since this is fundamentally a generic architectural driver,
>> adding explicit clock support would probably make the whole thing about 50%
>> clock code, with complicated decision trees around every hardware access
>> calculating which clocks are necessary for a given operation on a given
>> system. That maintainability aspect is why we've already nacked such a
>> fine-grained approach in the past.
>
> Hmm, I think we are talking about different things here. My suggestion
> would not add much more code to the driver than this patch does, calls
> to arm_smmu_enable_clocks() instead of pm_runtime_get_sync() and
> arm_smmu_disable_clocks() instead of pm_runtime_put(). The
> implementation of both functions would be a simple call to clk_bulk_
> API (possibly even no need to put this into functions, just call
> directly).

Well, things are not so straight on msm. The IP clocks on msm are usually
powered by (or i should rather say, controlled by) the same power domain
that provides the VDD supply to iommu block. This is the behavior on msm8996
atleast that we are testing on right now.
On later SoCs too things don't change drastically.

So, you can't have the block in low power state until you program the
register space
and then power on the block to let it do its magic.
Clocks and power domains are linked, and that's why we add them to the
pm callbacks.

This approach also looks generic to me since the platforms will either have such
a link or they will not have. But, in either case you will have power and clocks
available at the time when you need them.


Thanks & regards
Vivek

>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
