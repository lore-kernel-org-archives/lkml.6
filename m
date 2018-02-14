Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x226qudX7zYzdLOfVUQUZOhkSq/FRCHRQPipmqwr8DVD7H4VnOBtUnQQZs5vJ1CQmPo6tyO0f
ARC-Seal: i=1; a=rsa-sha256; t=1518596930; cv=none;
        d=google.com; s=arc-20160816;
        b=YtCLoVRPvbx7QhyyKVEmNKRv3emMtQjaNImqz+G2DwQ+qfuBqwPHySjjXO9h1WbofH
         EAeY0y2bQ3O/98Vvr1P7MrvUWioRHCQM7NFEaxC8MT60ZYAy22Qm71LVNjehWrVq7pok
         Wku5BxI02mr6WYlzqD6nkDOKkrmDXeIFW58TrKw93KHuARCJZmklK2E+jhhTr4YDnjs9
         TIlLg+nuxQF4dnAyEIkgjaqaVeVZWcId4iItSCaGcXxi77rv+O5UH5M5Rh3MgCBPx0aE
         YRElAwI2ZnL1hcNKkjM6KZPh7m8KmjV6yys+pzJxn8EE5Jvm/F0kS0AdsqUmMDo4VjXH
         VpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Z7WXxLiQrAYk95oyYihhc1b75LxlheeMe79HAAB7Wwc=;
        b=x8C++sE5HREKQL8DHGuJ6m9RHAtQ66/TBZfMdI8NFdXagTnTaeeVQB69K6JoLB5rcC
         Qccfqr9y84XVcgDTNoqhWqtN+IRhbbs0inGlw2oF/sQ41tn3KyVJ1JXZvw0crTHORjp7
         W+8xAoIjhBrH4jrCRhXgELR5NV9erYEurtSt1FP3YmznsfJsDtZmWSGuiFnzXDbBFVNC
         DUBtVS+dW3BWwSDKoi76xioYmWwhks+qWGckyuiV0chKLktv6JnO/fIPs+elYuwNwB1y
         FeXv14tcFZasY6vwVY+jNLfyg6dODtoqxlHq2TqXWOuzSVt93kaR02h9VZVFVP/Ke5i6
         abDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lnsefSJy;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X/Iskujo;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lnsefSJy;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X/Iskujo;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C185460F8F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org> <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 14 Feb 2018 13:58:47 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGOsAxg63+T_xzAh5VmiPPsJp_0WxQVb+U0T407OTxvMQ@mail.gmail.com>
Message-ID: <CAFp+6iGOsAxg63+T_xzAh5VmiPPsJp_0WxQVb+U0T407OTxvMQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Tomasz Figa <tfiga@chromium.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1592364294951421804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomasz,


On Tue, Feb 13, 2018 at 1:54 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Vivek,
>
> Thanks for the patch. Please see my comments inline.
>
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 9e2f917e16c2..c024f69c1682 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -       int irq;
>> +       int ret, irq;
>>
>>         if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>                 return;
>>
>> +       ret = pm_runtime_get_sync(smmu->dev);
>> +       if (ret)
>> +               return;
>
> pm_runtime_get_sync() will return 0 if the device was powered off, 1
> if it was already/still powered on or runtime PM is not compiled in,
> or a negative value on error, so shouldn't the test be (ret < 0)?

Yes, I too noticed it while i was testing on a different platform, and
was hitting
a failure case. Will update at all places.

>
> Moreover, I'm actually wondering if it makes any sense to power up the
> hardware just to program it and power it down again. In a system where
> the IOMMU is located within a power domain, it would cause the IOMMU
> block to lose its state anyway.
>
> Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
> pm_runtime/sleep ops", perhaps it would make more sense to just
> control the clocks independently of runtime PM? Then, runtime PM could
> be used for real power management, e.g. really powering the block up
> and down, for further power saving.
>
> +Generally similar comments for other places in this patch.
>
>> +
>>         /*
>>          * Disable the context bank and free the page tables before freeing
>>          * it.
>> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>
>>         free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>         __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>> +
>> +       pm_runtime_put_sync(smmu->dev);
>
> Is there any point in the put being sync here?

No, I don't think. Can manage with just a 'put' here. Will modify.

best regards
Vivek

>
> [snip]
>
>> @@ -2131,6 +2152,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>         if (err)
>>                 return err;
>>
>> +       platform_set_drvdata(pdev, smmu);
>> +
>> +       pm_runtime_enable(dev);
>
> I suspect this may be a disaster for systems where IOMMUs are located
> inside power domains, because the driver doesn't take care of the
> IOMMU block losing its state on physical power down, as I mentioned in
> my comments above.
>
> Best regards,
> Tomasz



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
