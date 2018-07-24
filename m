Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CAEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245EB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PEEW3Pit";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LqcQV8pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245EB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeGXKtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:49:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38892 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbeGXKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:49:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63B6E60328; Tue, 24 Jul 2018 09:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532425419;
        bh=zAxEhdfikk0APV1D+k26M56EhTnfF4EJuJZSJd2RjQo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PEEW3PitO2Bc7b3CJfetDS26UHgMWeiBZeuI27NDxPPRG7TcdQr9sHNg7m2HJTXdZ
         N/py3I3N4nhHDjShblgO1+Q9QZFU/NC4woRNCDyIoShPS8zNy0KKstjdWXh5nuuOlZ
         JM5JzJtF0orK/hf2Em66V1UQ6F3GSoVGtKFCVxQ4=
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C13B60328;
        Tue, 24 Jul 2018 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532425418;
        bh=zAxEhdfikk0APV1D+k26M56EhTnfF4EJuJZSJd2RjQo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LqcQV8pYmrPdSwOOyepVnKEVMHgZktTG8mBVrRt/mRJ7rpRwwjZaZoDc6a6TR771Y
         j1/gE20qTKbZnBIibAeCqacosjrmu8GZAIecZyXKWHh8mPZ+7tr+DIoSswGzn7YCsm
         UQ+7En4XPF++itj/F22aJG5kmufihClh/GtmU4Z4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C13B60328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f169.google.com with SMTP id d4-v6so3440920qtn.13;
        Tue, 24 Jul 2018 02:43:38 -0700 (PDT)
X-Gm-Message-State: AOUpUlH0nQn/fYcnB4VqFEbEaPZ1pTZseNF9lJr4QryMAbBLAYBCFuky
        EItRBm+wQoMU+bREJDdCUmlHdPEbo5mX1mryQ6U=
X-Google-Smtp-Source: AAOMgpdhutW5JJdF4RkAJxPIMjJK8YBY1rZXLb2uGaaTh41sVSEaO8QW/2LZrjsf8monkFJfbjIa87Z+ysdDoU5YuDQ=
X-Received: by 2002:ac8:34f:: with SMTP id w15-v6mr15982156qtg.410.1532425417897;
 Tue, 24 Jul 2018 02:43:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:43:37 -0700 (PDT)
In-Reply-To: <20180627163749.GA8729@arm.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
 <20180615165232.GE2202@arm.com> <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
 <20180627163749.GA8729@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 24 Jul 2018 15:13:37 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHnA1Jj8wKO08YYEBKVF2_3oEuOQOcW2boL=AYZ9+b=UA@mail.gmail.com>
Message-ID: <CAFp+6iHnA1Jj8wKO08YYEBKVF2_3oEuOQOcW2boL=AYZ9+b=UA@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Will Deacon <will.deacon@arm.com>
Cc:     pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


On Wed, Jun 27, 2018 at 10:07 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Vivek,
>
> On Tue, Jun 19, 2018 at 02:04:44PM +0530, Vivek Gautam wrote:
>> On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
>> >> Qualcomm SoCs have an additional level of cache called as
>> >> System cache or Last level cache[1]. This cache sits right
>> >> before the DDR, and is tightly coupled with the memory
>> >> controller.
>> >> The cache is available to all the clients present in the
>> >> SoC system. The clients request their slices from this system
>> >> cache, make it active, and can then start using it. For these
>> >> clients with smmu, to start using the system cache for
>> >> dma buffers and related page tables [2], few of the memory
>> >> attributes need to be set accordingly.
>> >> This change makes the related memory Outer-Shareable, and
>> >> updates the MAIR with necessary protection.
>> >>
>> >> The MAIR attribute requirements are:
>> >>     Inner Cacheablity = 0
>> >>     Outer Cacheablity = 1, Write-Back Write Allocate
>> >>     Outer Shareablity = 1
>> >
>> > Hmm, so is this cache coherent with the CPU or not?
>>
>> Thanks for reviewing.
>> Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
>> The different masters such as GPU as able to allocated and activate a slice
>> in this Last Level Cache.
>
> What I mean is, for example, if the CPU writes some data using Normal, Inner
> Shareable, Inner/Outer Cacheable, Inner/Outer Write-back, Non-transient
> Read/Write-allocate and a device reads that data using your MAIR encoding
> above, is the device guaranteed to see the CPU writes after the CPU has
> executed a DSB instruction?
>
> I don't think so, because the ARM ARM would say that there's a mismatch on
> the Inner Cacheability attribute.
>
>> > Why don't normal
>> > non-cacheable mappings allocated in the LLC by default?
>>
>> Sorry, I couldn't fully understand your question here.
>> Few of the masters on qcom socs are not io-coherent, so for them
>> the IC has to be marked as 0.
>
> By IC you mean Inner Cacheability? In your MAIR encoding above, it is zero
> so I don't understand the problem. What goes wrong if non-coherent devices
> use your MAIR encoding for their DMA buffers?
>
>> But they are able to use the LLC with OC marked as 1.
>
> The issue here is that whatever attributes we put in the SMMU need to align
> with the attributes used by the CPU in order to avoid introducing mismatched
> aliases. Currently, we support three types of mapping in the SMMU:
>
> 1. DMA non-coherent (e.g. "dma-coherent" is not set on the device)
>         Normal, Inner Shareable, Inner/Outer Non-Cacheable
>
> 2. DMA coherent (e.g. "dma-coherent" is set on the device) [IOMMU_CACHE]
>         Normal, Inner Shareable, Inner/Outer Cacheable, Inner/Outer
>         Write-back, Non-transient Read/Write-allocate
>
> 3. MMIO (e.g. MSI doorbell) [IOMMU_MMIO]
>         Device-nGnRE (Outer Shareable)
>
> So either you override one of these types (I was suggesting (1)) or you need
> to create a new memory type, along with the infrastructure for it to be
> recognised on a per-device basis and used by the DMA API so that we don't
> get mismatched aliases on the CPU.

My apologies for delay in responding to this thread.
I have been digging and getting in touch with internal tech teams
to get more information on this. I will update as soon as I have enough
details.
Thanks.

Best regards
Vivek

>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
