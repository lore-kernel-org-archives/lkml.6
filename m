Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B64C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153242063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7N7w54M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfAUOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:25:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54070 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbfAUOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:25:08 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so16590693ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u94eUF5mgF2KHAxjyAftYpA3ypiVepGKgWhzr9h2W4=;
        b=e7N7w54MBAKV9DZq0MZ7LOLDV2AarARteFuPyCSQMy4juxp6Sp/YwZKQ9jMfam3QJ6
         /Yi8cFJWl3yBc65GwOy6HzxZwxnU2gVk+rs6hLIF1164xDzBwkk33wCUL8JYqSo17T7+
         iphonCyY82qrtMHsSEVHJgoLREb/Le/J+mjUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u94eUF5mgF2KHAxjyAftYpA3ypiVepGKgWhzr9h2W4=;
        b=ORKCAfdbvfRs2RuWDSLG0zrBebmp9NNpqnEfdtED2gdQbKp9mVQGAOK3ujtDFLu1MC
         Wz8VRe8MwGub6syh0QXu6J8ejlYxhzTdXX0CdwrSfk3cRkd8YPd419FnbP4A9hq02F6V
         +8v45TYw6pfjN8RjSDw1a2dUGXbmWz4UGsv09HcFCnCT9agL3aFf/MgE3dCe2lDX/K8M
         OABHdNYSdbxxyHAzW2jKR/gN/QAXOq15W5LI8Rspj4i/cB5u9O5Old0R6LZ+ugjabHEN
         hQyAyJB01RUvyALEiR/RbOQjLzeG4XNu6Y80zp4zwU8Ui/YWcpeUD8PQHdxoLfNfj2Yx
         Pq+A==
X-Gm-Message-State: AJcUukc/4z3ufZfJ4kEbwHo394PJRFxraQ0x/iKmfRjUaIqii96La7QV
        /9RJrPBzQ0ga7+zWDZ+/L6gFKqf8XW2I2X7mEHmQdA==
X-Google-Smtp-Source: ALg8bN4vZOqku531Dx/WHFBcJYrfl4tYJgZq6IRDEcLoS4fIkywiUCK2nNgSGC9K3c6YEnkly2mE1dy8Rg0hoIHQmCg=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr17498155itk.71.1548080706851;
 Mon, 21 Jan 2019 06:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com> <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
 <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com>
In-Reply-To: <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 15:24:55 +0100
Message-ID: <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>, pratikp@codeaurora.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 14:56, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 13:36, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> >>> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>>
> >>>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> >>>> <ard.biesheuvel@linaro.org> wrote:
> >>>>>
> >>>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>>>
> >>>>>> Qualcomm SoCs have an additional level of cache called as
> >>>>>> System cache, aka. Last level cache (LLC). This cache sits right
> >>>>>> before the DDR, and is tightly coupled with the memory controller.
> >>>>>> The clients using this cache request their slices from this
> >>>>>> system cache, make it active, and can then start using it.
> >>>>>> For these clients with smmu, to start using the system cache for
> >>>>>> buffers and, related page tables [1], memory attributes need to be
> >>>>>> set accordingly. This series add the required support.
> >>>>>>
> >>>>>
> >>>>> Does this actually improve performance on reads from a device? The
> >>>>> non-cache coherent DMA routines perform an unconditional D-cache
> >>>>> invalidate by VA to the PoC before reading from the buffers filled by
> >>>>> the device, and I would expect the PoC to be defined as lying beyond
> >>>>> the LLC to still guarantee the architected behavior.
> >>>>
> >>>> We have seen performance improvements when running Manhattan
> >>>> GFXBench benchmarks.
> >>>>
> >>>
> >>> Ah ok, that makes sense, since in that case, the data flow is mostly
> >>> to the device, not from the device.
> >>>
> >>>> As for the PoC, from my knowledge on sdm845 the system cache, aka
> >>>> Last level cache (LLC) lies beyond the point of coherency.
> >>>> Non-cache coherent buffers will not be cached to system cache also, and
> >>>> no additional software cache maintenance ops are required for system cache.
> >>>> Pratik can add more if I am missing something.
> >>>>
> >>>> To take care of the memory attributes from DMA APIs side, we can add a
> >>>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> >>>>
> >>>
> >>> So does the device use the correct inner non-cacheable, outer
> >>> writeback cacheable attributes if the SMMU is in pass-through?
> >>>
> >>> We have been looking into another use case where the fact that the
> >>> SMMU overrides memory attributes is causing issues (WC mappings used
> >>> by the radeon and amdgpu driver). So if the SMMU would honour the
> >>> existing attributes, would you still need the SMMU changes?
> >>
> >> Even if we could force a stage 2 mapping with the weakest pagetable
> >> attributes (such that combining would work), there would still need to
> >> be a way to set the TCR attributes appropriately if this behaviour is
> >> wanted for the SMMU's own table walks as well.
> >>
> >
> > Isn't that just a matter of implementing support for SMMUs that lack
> > the 'dma-coherent' attribute?
>
> Not quite - in general they need INC-ONC attributes in case there
> actually is something in the architectural outer-cacheable domain.

But is it a problem to use INC-ONC attributes for the SMMU PTW on this
chip? AIUI, the reason for the SMMU changes is to avoid the
performance hit of snooping, which is more expensive than cache
maintenance of SMMU page tables. So are you saying the by-VA cache
maintenance is not relayed to this system cache, resulting in page
table updates to be invisible to masters using INC-ONC attributes?

> The
> case of the outer cacheablility being not that but a hint to control
> non-CPU traffic through some not-quite-transparent cache behind the PoC
> definitely stays wrapped up in qcom-specific magic ;)
>

I'm not surprised ...
