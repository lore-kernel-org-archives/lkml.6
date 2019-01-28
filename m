Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFCF21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mD+VEfCp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xcwsag/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1L1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:27:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1L1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:27:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A47A6086A; Mon, 28 Jan 2019 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548674856;
        bh=GvSUQcq7N/C7v1w2GnvRqV+rRImFxea+GcurXp/M5iQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mD+VEfCpvN9CGC87bZYh3XSGtRiOutqeHWLQWr5/Gnlk50CCKQe2GoaO1zr6IGeI6
         BaVHwVnaJ2jnR2ZbUecphwVWr4hkBwgHsPLO+evW9ZM5dSTPKVxYieTkf0/OVQL7rt
         n6dsJUMSMM3WwmcW1Bxfd5wNi30dZlBbkLC++7MU=
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 709256083E;
        Mon, 28 Jan 2019 11:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548674855;
        bh=GvSUQcq7N/C7v1w2GnvRqV+rRImFxea+GcurXp/M5iQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xcwsag/L8j5I5f75u1uc3Uchhgo3xnLWdmhMAZumgzr3Eju7Z1UryGNtf5O91bh1I
         hLZcv4wreGHNluifVPJh5tbt8LVpItqropzGYEvlSZ0Y1nu9r6fki15Q2m/zSBT6oA
         ku8tpxrtLtAaIE6a0lHPdpl1ti6bheawf/THvzso=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 709256083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f42.google.com with SMTP id a20so12679040edc.8;
        Mon, 28 Jan 2019 03:27:35 -0800 (PST)
X-Gm-Message-State: AJcUukeUHF79VVSaE2NY6nD5J5fD4q1NC1ZkcZozco+Nnkn+6C9tAdYP
        xClIHsoBI0Np3bsuL8BRCrXOTgV9AGMSsAmmC/0=
X-Google-Smtp-Source: ALg8bN5j15aSG9OfDt3vq437p6naA6h0/k1vqV3rEGX/jeamxBf6jv5vwuNo2jp/WjnpggqDQ5hjRkOpL/2Ffy7VyFA=
X-Received: by 2002:a50:d002:: with SMTP id j2mr21027184edf.123.1548674854081;
 Mon, 28 Jan 2019 03:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com> <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
 <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com> <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
 <CAFp+6iESSKZsG06j9RJDn3n84zNT=b962sEyPwfyW1u5DGu-+A@mail.gmail.com> <CAKv+Gu964=UOPcxh1ZZ4HEvJonrQ_d21t=GbVV9XwV3o91c6ng@mail.gmail.com>
In-Reply-To: <CAKv+Gu964=UOPcxh1ZZ4HEvJonrQ_d21t=GbVV9XwV3o91c6ng@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 28 Jan 2019 16:57:22 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGJLNA-sgr+rCZsf20h8Ha0aVh4zKcxYQ_nYjP9CemVpw@mail.gmail.com>
Message-ID: <CAFp+6iGJLNA-sgr+rCZsf20h8Ha0aVh4zKcxYQ_nYjP9CemVpw@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        pratikp@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Jan 24, 2019 at 1:25 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 07:58, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >
> > On Mon, Jan 21, 2019 at 7:55 PM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Mon, 21 Jan 2019 at 14:56, Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > On 21/01/2019 13:36, Ard Biesheuvel wrote:
> > > > > On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > >>
> > > > >> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> > > > >>> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > > >>>>
> > > > >>>> Hi,
> > > > >>>>
> > > > >>>>
> > > > >>>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> > > > >>>> <ard.biesheuvel@linaro.org> wrote:
> > > > >>>>>
> > > > >>>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > > >>>>>>
> > > > >>>>>> Qualcomm SoCs have an additional level of cache called as
> > > > >>>>>> System cache, aka. Last level cache (LLC). This cache sits right
> > > > >>>>>> before the DDR, and is tightly coupled with the memory controller.
> > > > >>>>>> The clients using this cache request their slices from this
> > > > >>>>>> system cache, make it active, and can then start using it.
> > > > >>>>>> For these clients with smmu, to start using the system cache for
> > > > >>>>>> buffers and, related page tables [1], memory attributes need to be
> > > > >>>>>> set accordingly. This series add the required support.
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> Does this actually improve performance on reads from a device? The
> > > > >>>>> non-cache coherent DMA routines perform an unconditional D-cache
> > > > >>>>> invalidate by VA to the PoC before reading from the buffers filled by
> > > > >>>>> the device, and I would expect the PoC to be defined as lying beyond
> > > > >>>>> the LLC to still guarantee the architected behavior.
> > > > >>>>
> > > > >>>> We have seen performance improvements when running Manhattan
> > > > >>>> GFXBench benchmarks.
> > > > >>>>
> > > > >>>
> > > > >>> Ah ok, that makes sense, since in that case, the data flow is mostly
> > > > >>> to the device, not from the device.
> > > > >>>
> > > > >>>> As for the PoC, from my knowledge on sdm845 the system cache, aka
> > > > >>>> Last level cache (LLC) lies beyond the point of coherency.
> > > > >>>> Non-cache coherent buffers will not be cached to system cache also, and
> > > > >>>> no additional software cache maintenance ops are required for system cache.
> > > > >>>> Pratik can add more if I am missing something.
> > > > >>>>
> > > > >>>> To take care of the memory attributes from DMA APIs side, we can add a
> > > > >>>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> > > > >>>>
> > > > >>>
> > > > >>> So does the device use the correct inner non-cacheable, outer
> > > > >>> writeback cacheable attributes if the SMMU is in pass-through?
> > > > >>>
> > > > >>> We have been looking into another use case where the fact that the
> > > > >>> SMMU overrides memory attributes is causing issues (WC mappings used
> > > > >>> by the radeon and amdgpu driver). So if the SMMU would honour the
> > > > >>> existing attributes, would you still need the SMMU changes?
> > > > >>
> > > > >> Even if we could force a stage 2 mapping with the weakest pagetable
> > > > >> attributes (such that combining would work), there would still need to
> > > > >> be a way to set the TCR attributes appropriately if this behaviour is
> > > > >> wanted for the SMMU's own table walks as well.
> > > > >>
> > > > >
> > > > > Isn't that just a matter of implementing support for SMMUs that lack
> > > > > the 'dma-coherent' attribute?
> > > >
> > > > Not quite - in general they need INC-ONC attributes in case there
> > > > actually is something in the architectural outer-cacheable domain.
> > >
> > > But is it a problem to use INC-ONC attributes for the SMMU PTW on this
> > > chip? AIUI, the reason for the SMMU changes is to avoid the
> > > performance hit of snooping, which is more expensive than cache
> > > maintenance of SMMU page tables. So are you saying the by-VA cache
> > > maintenance is not relayed to this system cache, resulting in page
> > > table updates to be invisible to masters using INC-ONC attributes?
> >
> > The reason for this SMMU changes is that the non-coherent devices
> > can't access the inner caches at all. But they have a way to allocate
> > and lookup in system cache.
> >
> > CPU will by default make use of system cache when the inner-cacheable
> > and outer-cacheable memory attribute is set.
> >
> > So for SMMU page tables to be visible to PTW,
> > -- For IO coherent clients, the CPU cache maintenance operations are not
> > required for buffers marked Normal Cached to achieve a coherent view of
> > memory. However, client-specific cache maintenance may still be
> > required for devices
> > with local caches (for example, compute DSP local L1 or L2).
>
> Why would devices need to access the SMMU page tables?

No, the devices don't need to access the page tables, rather the PTW does.
Sorry for mixing it up.

>
> > -- For non-IO coherent clients, the CPU cache maintenance operations (cleans
> > and/or invalidates) are required at buffer handoff points for buffers marked as
> > Normal Cached in any CPU page table in order to observe the latest updates.
> >
>
> Indeed, and this is what your non-coherent SMMU PTW requires, and what
> you /should/ get when you omit the 'dma-coherent' property from its DT
> node (and if you don't, it is a bug in the SMMU driver that should get
> fixed)
>
> The question is whether using inner-non-cached/outer-cacheable
> attributes for the PTW is required for correctness, or whether it is
> merely an optimization (since the point of this exercise was to avoid
> snoop latency from the SMMU PTW). If it is an optimization, I would
> like to understand whether the performance delta between SMMU page
> tables in DRAM vs SMMU page tables in the LLC justifies these
> intrusive changes to the SMMU driver.

IIUC, SMMU uses the TCR configurations to decide how PTW should access
the memory. TCR doesn't direct CPU whether to use cacheable or non -cacheable
memory to allocate page tables. Is that right?
Currently, these TCR configurations are set for inner-cacheable, and
outer-cacheable.
With this, is it assumed that PTW would snoop into the CPU caches for
any updates
of the page tables?

When we omit 'dma-coherent', CPU will allocate non-coherent memory
for these page tables, and software has to explicitly flush CPU caches to
make the changes visible to SMMU.
The CPU will still mark this memory as Normal Cached, i.e. inner cached,
outer cached, and the non-IO coherent SMMU PTW won't be able to snoop into
CPU caches. Does the following code in io-pgtable-arm.c ensures that SMMU
sees the latest page tables?

   } else if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) &&
                    !(pte & ARM_LPAE_PTE_SW_SYNC)) {
                 __arm_lpae_sync_pte(ptep, cfg);
   }

This change is mostly to get optimized PTW. As seen in the patch [1] for GPU,
there's a separate slice for page tables - "gpuhtw_llc_slice".
Let me try to get the numbers for this optimization.


[1] https://patchwork.kernel.org/patch/10302791/


Regards
Vivek

>
>
> > >
> > > > The
> > > > case of the outer cacheablility being not that but a hint to control
> > > > non-CPU traffic through some not-quite-transparent cache behind the PoC
> > > > definitely stays wrapped up in qcom-specific magic ;)
> > > >
> > >
> > > I'm not surprised ...
> >
> >
> >
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
