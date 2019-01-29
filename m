Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F8C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A430521848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/EYODH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfA2PC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:02:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52162 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfA2PCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:02:55 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so4936505ite.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcGl2vWERSNLlX1x8MuJ4PVihGXS6s5oBYyDN8j2C+4=;
        b=L/EYODH/BFh8kjNGedPQPzgYsWDsS/GAzL2nDVkbX2c6vJYVWFyZhjzw42Iw+ZfLtd
         J9HJQpiVKRb7IuQBXeAx81kurTvlCp2DNAc3LJY7ewn7wAxfD5aXHg3NfqyBGfy0VLvE
         d8MYkIH4NsQW53RhLy2RQZO1QwQ1OrqLEy4V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcGl2vWERSNLlX1x8MuJ4PVihGXS6s5oBYyDN8j2C+4=;
        b=KfiS1sIJwm1KIgTfBM3DbHFcj9a1UGY00ZJYOu9Yr6spHhErqSAD0wHO8IyS+BOwFR
         DaEg08z1xtw14sBy1Yz0D0zRmE2NfkX1a3SPtNJ/hlT2oqm7vurWu+Ok+Z1b7O8sh2kk
         7LisTkchlN7X+WEkFgMXNOm9rfmqvMiSNsmt/HhGtTudKD5p0Yz4dx0w0lO5XddVNuvc
         xGzFq3A/sYUdXRUU32cjI2gdGpOSMMfjXSaBnCEp4suKWRmNbPTi4K0XUjyTIgokMdqr
         0L9DLlri7CIrp4xoLG7ozVO27VPCpmVn2m+d7DkpokOJ/vL+ThcLCTsRgL68pClgnFON
         AQHA==
X-Gm-Message-State: AJcUukeoyVWtmUolj0c1/9lzK54pfrmTFscUHUicH9qsV5uPOcd3svVA
        3FiA3bFaDS2HKW+Hx/5okBcc9rU21vHHvw9EM2nGDY8mKZ0=
X-Google-Smtp-Source: ALg8bN7ZsCbM/WBP2/WHL1rhL8TyzZra1quuvz0nSUIsnxTTR50HbjGIsaRMZRL0Ji/IG3VQVqPH3mFrkjcBUj7+Wpk=
X-Received: by 2002:a02:734b:: with SMTP id a11mr14929593jae.62.1548774173968;
 Tue, 29 Jan 2019 07:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
 <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com> <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
 <964779d6-c676-3379-bf1e-cde0dd82d63d@arm.com> <CAKv+Gu_Oz-QEFnq9KiOBHQrC8o+0ykkEZBm0vCWfYDfFB8QTcQ@mail.gmail.com>
 <CAFp+6iESSKZsG06j9RJDn3n84zNT=b962sEyPwfyW1u5DGu-+A@mail.gmail.com>
 <CAKv+Gu964=UOPcxh1ZZ4HEvJonrQ_d21t=GbVV9XwV3o91c6ng@mail.gmail.com> <CAFp+6iGJLNA-sgr+rCZsf20h8Ha0aVh4zKcxYQ_nYjP9CemVpw@mail.gmail.com>
In-Reply-To: <CAFp+6iGJLNA-sgr+rCZsf20h8Ha0aVh4zKcxYQ_nYjP9CemVpw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 29 Jan 2019 16:02:41 +0100
Message-ID: <CAKv+Gu9c2YYQdDNV_9Lgs3nb8MFXNvLj8GdeOfEnHvPAw6qAfg@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
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

(+ Bjorn)

On Mon, 28 Jan 2019 at 12:27, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi Ard,
>
> On Thu, Jan 24, 2019 at 1:25 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 24 Jan 2019 at 07:58, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 7:55 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Mon, 21 Jan 2019 at 14:56, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > >
> > > > > On 21/01/2019 13:36, Ard Biesheuvel wrote:
> > > > > > On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > >>
> > > > > >> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> > > > > >>> On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > > > >>>>
> > > > > >>>> Hi,
> > > > > >>>>
> > > > > >>>>
> > > > > >>>> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> > > > > >>>> <ard.biesheuvel@linaro.org> wrote:
> > > > > >>>>>
> > > > > >>>>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > > > > >>>>>>
> > > > > >>>>>> Qualcomm SoCs have an additional level of cache called as
> > > > > >>>>>> System cache, aka. Last level cache (LLC). This cache sits right
> > > > > >>>>>> before the DDR, and is tightly coupled with the memory controller.
> > > > > >>>>>> The clients using this cache request their slices from this
> > > > > >>>>>> system cache, make it active, and can then start using it.
> > > > > >>>>>> For these clients with smmu, to start using the system cache for
> > > > > >>>>>> buffers and, related page tables [1], memory attributes need to be
> > > > > >>>>>> set accordingly. This series add the required support.
> > > > > >>>>>>
> > > > > >>>>>
> > > > > >>>>> Does this actually improve performance on reads from a device? The
> > > > > >>>>> non-cache coherent DMA routines perform an unconditional D-cache
> > > > > >>>>> invalidate by VA to the PoC before reading from the buffers filled by
> > > > > >>>>> the device, and I would expect the PoC to be defined as lying beyond
> > > > > >>>>> the LLC to still guarantee the architected behavior.
> > > > > >>>>
> > > > > >>>> We have seen performance improvements when running Manhattan
> > > > > >>>> GFXBench benchmarks.
> > > > > >>>>
> > > > > >>>
> > > > > >>> Ah ok, that makes sense, since in that case, the data flow is mostly
> > > > > >>> to the device, not from the device.
> > > > > >>>
> > > > > >>>> As for the PoC, from my knowledge on sdm845 the system cache, aka
> > > > > >>>> Last level cache (LLC) lies beyond the point of coherency.
> > > > > >>>> Non-cache coherent buffers will not be cached to system cache also, and
> > > > > >>>> no additional software cache maintenance ops are required for system cache.
> > > > > >>>> Pratik can add more if I am missing something.
> > > > > >>>>
> > > > > >>>> To take care of the memory attributes from DMA APIs side, we can add a
> > > > > >>>> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> > > > > >>>>
> > > > > >>>
> > > > > >>> So does the device use the correct inner non-cacheable, outer
> > > > > >>> writeback cacheable attributes if the SMMU is in pass-through?
> > > > > >>>
> > > > > >>> We have been looking into another use case where the fact that the
> > > > > >>> SMMU overrides memory attributes is causing issues (WC mappings used
> > > > > >>> by the radeon and amdgpu driver). So if the SMMU would honour the
> > > > > >>> existing attributes, would you still need the SMMU changes?
> > > > > >>
> > > > > >> Even if we could force a stage 2 mapping with the weakest pagetable
> > > > > >> attributes (such that combining would work), there would still need to
> > > > > >> be a way to set the TCR attributes appropriately if this behaviour is
> > > > > >> wanted for the SMMU's own table walks as well.
> > > > > >>
> > > > > >
> > > > > > Isn't that just a matter of implementing support for SMMUs that lack
> > > > > > the 'dma-coherent' attribute?
> > > > >
> > > > > Not quite - in general they need INC-ONC attributes in case there
> > > > > actually is something in the architectural outer-cacheable domain.
> > > >
> > > > But is it a problem to use INC-ONC attributes for the SMMU PTW on this
> > > > chip? AIUI, the reason for the SMMU changes is to avoid the
> > > > performance hit of snooping, which is more expensive than cache
> > > > maintenance of SMMU page tables. So are you saying the by-VA cache
> > > > maintenance is not relayed to this system cache, resulting in page
> > > > table updates to be invisible to masters using INC-ONC attributes?
> > >
> > > The reason for this SMMU changes is that the non-coherent devices
> > > can't access the inner caches at all. But they have a way to allocate
> > > and lookup in system cache.
> > >
> > > CPU will by default make use of system cache when the inner-cacheable
> > > and outer-cacheable memory attribute is set.
> > >
> > > So for SMMU page tables to be visible to PTW,
> > > -- For IO coherent clients, the CPU cache maintenance operations are not
> > > required for buffers marked Normal Cached to achieve a coherent view of
> > > memory. However, client-specific cache maintenance may still be
> > > required for devices
> > > with local caches (for example, compute DSP local L1 or L2).
> >
> > Why would devices need to access the SMMU page tables?
>
> No, the devices don't need to access the page tables, rather the PTW does.
> Sorry for mixing it up.
>
> >
> > > -- For non-IO coherent clients, the CPU cache maintenance operations (cleans
> > > and/or invalidates) are required at buffer handoff points for buffers marked as
> > > Normal Cached in any CPU page table in order to observe the latest updates.
> > >
> >
> > Indeed, and this is what your non-coherent SMMU PTW requires, and what
> > you /should/ get when you omit the 'dma-coherent' property from its DT
> > node (and if you don't, it is a bug in the SMMU driver that should get
> > fixed)
> >
> > The question is whether using inner-non-cached/outer-cacheable
> > attributes for the PTW is required for correctness, or whether it is
> > merely an optimization (since the point of this exercise was to avoid
> > snoop latency from the SMMU PTW). If it is an optimization, I would
> > like to understand whether the performance delta between SMMU page
> > tables in DRAM vs SMMU page tables in the LLC justifies these
> > intrusive changes to the SMMU driver.
>
> IIUC, SMMU uses the TCR configurations to decide how PTW should access
> the memory. TCR doesn't direct CPU whether to use cacheable or non -cacheable
> memory to allocate page tables. Is that right?

Correct

> Currently, these TCR configurations are set for inner-cacheable, and
> outer-cacheable.
> With this, is it assumed that PTW would snoop into the CPU caches for
> any updates
> of the page tables?
>
`
Yes, and if I understand the issue correctly, this snooping is costly,
which is why you want to avoid it, right?

> When we omit 'dma-coherent', CPU will allocate non-coherent memory
> for these page tables, and software has to explicitly flush CPU caches to
> make the changes visible to SMMU.

Indeed. But I would expect the TCR configuration to reflect this as
well, and that doesn't appear the case.

> The CPU will still mark this memory as Normal Cached, i.e. inner cached,
> outer cached, and the non-IO coherent SMMU PTW won't be able to snoop into
> CPU caches. Does the following code in io-pgtable-arm.c ensures that SMMU
> sees the latest page tables?
>
>    } else if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) &&
>                     !(pte & ARM_LPAE_PTE_SW_SYNC)) {
>                  __arm_lpae_sync_pte(ptep, cfg);
>    }
>

I don't know the history of why NO_DMA is implemented as a quirk (and
why it is called like that in the first place).
But it indeed appears that this is where the cache maintenance occurs
for non-coherent PTWs.

> This change is mostly to get optimized PTW. As seen in the patch [1] for GPU,
> there's a separate slice for page tables - "gpuhtw_llc_slice".
> Let me try to get the numbers for this optimization.
>

Yes, please. We'd need to compare page tables in the LLC with page
tables in system RAM, and for completeness, it would be nice to
include the cache-coherent configuration as well.
