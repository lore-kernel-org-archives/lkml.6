Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD12FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795562083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jjnEjjaP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k90U0rk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795562083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937459AbeFSIeu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:34:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46436 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937236AbeFSIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:34:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7917B60AD8; Tue, 19 Jun 2018 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397286;
        bh=kycO8PmLk4U5/14Jv3eZxz63jfUzmPOXfNs2ptj1lKA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=jjnEjjaPUPQSZj4yG4VlLa2Eymshjj+9skbAB7j96kC0wpjT2ZEbnE2q93f/TuLUQ
         +eBsagbGIVdIW8vQXjhO+P+LOBNQU8E4qtpZuDHEB2RY11yKI7f2jXytlaT1zEbk5x
         mKYaVr055LCyKlBZJRoGe7RNQXjZPRf4Vjp4HoOQ=
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80A5760AD8;
        Tue, 19 Jun 2018 08:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529397285;
        bh=kycO8PmLk4U5/14Jv3eZxz63jfUzmPOXfNs2ptj1lKA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=k90U0rk6g3B5xuKf9neYS2/gElITu73U/TKeE2Vl9REvGKLxIKpzqXEXxGDCvL0sq
         Zw2y/Iyg9ACy/vZe2/b8OdPgnz51Q39qu6nX57u4XHhP6fW+loAYOecxRXF6JlIP2b
         iFKz911VN1qZeoZImJjVJUZcf7QfIULSg0Mfqlno=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80A5760AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f169.google.com with SMTP id y20-v6so2619946qto.8;
        Tue, 19 Jun 2018 01:34:45 -0700 (PDT)
X-Gm-Message-State: APt69E0BwjRsrZjlhzI+AYxZkEvPO8zJ0KEMzXppjM1M8jQz6a1Xyg3F
        jbRQ3jHec2xm+RXYJeYCXaK0264e9Z63AdTxMD0=
X-Google-Smtp-Source: ADUXVKKPZjqHH39oc9bBFR+fzxjAV+RkDwEbIdXiICDYAj5hyoQlJt0+5PX8Gv3IrGBKq+FMOqS6e8UOD3DY4lqUSj8=
X-Received: by 2002:ac8:720f:: with SMTP id a15-v6mr13574749qtp.243.1529397284699;
 Tue, 19 Jun 2018 01:34:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 01:34:44
 -0700 (PDT)
In-Reply-To: <20180615165232.GE2202@arm.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org> <20180615165232.GE2202@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 19 Jun 2018 14:04:44 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
Message-ID: <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        pdaly@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Vivek,
>
> On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
>> Qualcomm SoCs have an additional level of cache called as
>> System cache or Last level cache[1]. This cache sits right
>> before the DDR, and is tightly coupled with the memory
>> controller.
>> The cache is available to all the clients present in the
>> SoC system. The clients request their slices from this system
>> cache, make it active, and can then start using it. For these
>> clients with smmu, to start using the system cache for
>> dma buffers and related page tables [2], few of the memory
>> attributes need to be set accordingly.
>> This change makes the related memory Outer-Shareable, and
>> updates the MAIR with necessary protection.
>>
>> The MAIR attribute requirements are:
>>     Inner Cacheablity = 0
>>     Outer Cacheablity = 1, Write-Back Write Allocate
>>     Outer Shareablity = 1
>
> Hmm, so is this cache coherent with the CPU or not?

Thanks for reviewing.
Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
The different masters such as GPU as able to allocated and activate a slice
in this Last Level Cache.

> Why don't normal
> non-cacheable mappings allocated in the LLC by default?

Sorry, I couldn't fully understand your question here.
Few of the masters on qcom socs are not io-coherent, so for them
the IC has to be marked as 0.
But they are able to use the LLC with OC marked as 1.

Handling the IO-coherency is possibly a separate change to address?

>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index f7a96bcf94a6..8058e7205034 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -249,6 +249,7 @@ struct arm_smmu_domain {
>>       struct mutex                    init_mutex; /* Protects smmu pointer */
>>       spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
>>       struct iommu_domain             domain;
>> +     bool                            has_sys_cache;
>>  };
>>
>>  struct arm_smmu_option_prop {
>> @@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>>               pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>> +     if (smmu_domain->has_sys_cache)
>> +             pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
>>
>>       smmu_domain->smmu = smmu;
>>       pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>> @@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>       case DOMAIN_ATTR_NESTING:
>>               *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>>               return 0;
>> +     case DOMAIN_ATTR_USE_SYS_CACHE:
>> +             *((int *)data) = smmu_domain->has_sys_cache;
>> +             return 0;
>
> I really don't like exposing this to clients directly like this,
> particularly as there aren't any in-tree users. I would prefer that we
> provide a way for the io-pgtable code to have its MAIR values overridden
> so that all non-coherent DMA ends up using the system cache.

From the way it looks from the users of LLC (as also pointed to by Jordan),
the masters have to request and activate their slices in the cache, and then
they can start using it. Before that the transaction don't go through LLC.

But I will try to find out more on this.

Thanks & Regards
Vivek

>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
