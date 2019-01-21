Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985AFC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArwJ8Lr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAUNgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:36:20 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53088 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfAUNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:36:20 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so16389123itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouVfrYoE4tBo/aI/S/8fegEEIgNFev38fWx5MQf/VJM=;
        b=ArwJ8Lr5+Hg4clYMFji1qY6Vo2rofrnjVP0RHCXnIPk+vN/lZ1h84Xu3WmeVnunuTg
         bQpqIwVqgYFTWo4Yb1ZWpKYyN2Ifm4/cFTkOcm5qT4aL30RDYLeLAqp6+7sB9ucFvD2q
         XpZFUGGZ2BVDn8RjrRtpA4VoRdh3P1L/TQVC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouVfrYoE4tBo/aI/S/8fegEEIgNFev38fWx5MQf/VJM=;
        b=QSyvDbOBzo9MhJClAuIxgECG/lwC84S/EOg8jGy2CbKSsQA5XnS+kWMUi/9k4sOhZk
         ql9mVtQDvOphdi1EOfi9az7VltLEOWgHiixHo0/Cqw+Au1HtZU1Jmzj6amaNGAZkMLGE
         PM2gCgiRry1LSUJ9o4DDRT0fWcXKWpwI520+Biijc+HCSfi0L4wAeNdKmAaF4iHgDRcm
         smbV8SWYOgtMjaUv9j51kDS3FgWYwZLJW+ocUi+XniEabSZuhNJDnfP2OGTDR8N/OpOj
         zLgHo23jpAQCjD+S7msZCo3Phbgv2viVA1KdfNgl/j7jgyjtiCsklA8gZLQcRZiKI+cu
         4t1g==
X-Gm-Message-State: AJcUukePbBgeNx+KNfa5LhtBmvT7WIIzhWtJIhF1uZlGOpwlfZXSWkhP
        wnDGD7NRuJ3fMHXKggyCzPu+XikWpnD963G6RxrHAA==
X-Google-Smtp-Source: ALg8bN6Zg2VceQChmTEUHfR/ksvGIMgODGDM+Sdy4ePGOWyA3+sSUky68PBxxjfLquGDgip4RzLmQ9e76n7P0+tx5AI=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr17398985itk.71.1548077778941;
 Mon, 21 Jan 2019 05:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
 <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
 <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com> <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
In-Reply-To: <dbba5a8a-70c0-dd01-713c-081eb412e2d7@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 14:36:07 +0100
Message-ID: <CAKv+Gu8K5f0va9q4FYk9x1puoOTDjZ0c25qokm2izSVAwd1gmQ@mail.gmail.com>
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

On Mon, 21 Jan 2019 at 14:25, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 10:50, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>
> >> Hi,
> >>
> >>
> >> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>>
> >>> On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >>>>
> >>>> Qualcomm SoCs have an additional level of cache called as
> >>>> System cache, aka. Last level cache (LLC). This cache sits right
> >>>> before the DDR, and is tightly coupled with the memory controller.
> >>>> The clients using this cache request their slices from this
> >>>> system cache, make it active, and can then start using it.
> >>>> For these clients with smmu, to start using the system cache for
> >>>> buffers and, related page tables [1], memory attributes need to be
> >>>> set accordingly. This series add the required support.
> >>>>
> >>>
> >>> Does this actually improve performance on reads from a device? The
> >>> non-cache coherent DMA routines perform an unconditional D-cache
> >>> invalidate by VA to the PoC before reading from the buffers filled by
> >>> the device, and I would expect the PoC to be defined as lying beyond
> >>> the LLC to still guarantee the architected behavior.
> >>
> >> We have seen performance improvements when running Manhattan
> >> GFXBench benchmarks.
> >>
> >
> > Ah ok, that makes sense, since in that case, the data flow is mostly
> > to the device, not from the device.
> >
> >> As for the PoC, from my knowledge on sdm845 the system cache, aka
> >> Last level cache (LLC) lies beyond the point of coherency.
> >> Non-cache coherent buffers will not be cached to system cache also, and
> >> no additional software cache maintenance ops are required for system cache.
> >> Pratik can add more if I am missing something.
> >>
> >> To take care of the memory attributes from DMA APIs side, we can add a
> >> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
> >>
> >
> > So does the device use the correct inner non-cacheable, outer
> > writeback cacheable attributes if the SMMU is in pass-through?
> >
> > We have been looking into another use case where the fact that the
> > SMMU overrides memory attributes is causing issues (WC mappings used
> > by the radeon and amdgpu driver). So if the SMMU would honour the
> > existing attributes, would you still need the SMMU changes?
>
> Even if we could force a stage 2 mapping with the weakest pagetable
> attributes (such that combining would work), there would still need to
> be a way to set the TCR attributes appropriately if this behaviour is
> wanted for the SMMU's own table walks as well.
>

Isn't that just a matter of implementing support for SMMUs that lack
the 'dma-coherent' attribute?
