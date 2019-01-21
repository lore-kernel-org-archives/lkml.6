Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE12C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA092085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W74LD6fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfAUKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:51:05 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35093 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfAUKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:51:05 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so14521592itp.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZG6s3eS8O+Mar/3L/gvujTkcPoy9mBP6SvWrZ1AAL0=;
        b=W74LD6faC9UTZ4Cci0rtns3bNle+1yA0bGh6FjsWHbGWci2K3pngKAuBKOil0nZl9u
         dMuoXpjCxhXJ9H8AnlnSEHcYKz2+W2tibHMM2VLs2K1PNdmISh6Wp277/DGnkkpqWfZm
         vzAVqEf8LsS0EwA/ev0IUYWg/3KgTAHlGXjII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZG6s3eS8O+Mar/3L/gvujTkcPoy9mBP6SvWrZ1AAL0=;
        b=F4OUtR93Yi/KWx19C6EjPGM4r8ntDj64SCFPclLY2jANGGnvvm3U8I9esWpznJuWHu
         ba1oOD+lAdrP95WVI0HPbcAeeMI0MKi+IABoKSvwwwg1pVdgSID5uCOAikUKenZoJ4sd
         l59UreK8ZNiD8NvqIj8T838F271ON6SeNxAPNf3ryAIQVF2c+BnWH90VphaUmjxinpeo
         WAFIJKsNYMHIeeyz5iY4p3SF+BryhwEFkJPWdkJHSxb1CI6Y9QPyEyNTyYorcSxMZGxg
         6YaVpwYIgteh55gbXXwDI27dOtlnU116xdZavK1AFbJl0KKQFLvbmJgV0kTMWbQjiNb4
         b1XQ==
X-Gm-Message-State: AJcUukdwRDBlmsW+VabbX6/2Eux3Dt3Er9Ko47o6c48GRbBI/Sp02UHD
        BC4aWwpKZI9xK1L/sVsVw2TBHnrUYLJCqegOztFQdg==
X-Google-Smtp-Source: ALg8bN5VOKAIyrSyYaD13M+6+CenuhEJ88Ty8sGuuVyVWt1mjlvT4P/C5SXAIIvgWt9I+WIZmSgF3tY1aLpWQuZ/IyM=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr18369678ith.158.1548067864287;
 Mon, 21 Jan 2019 02:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com> <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
In-Reply-To: <CAFp+6iEp-bzMrZz8cFUciTFKm7TwAoLdYpsSTD73kDfCRh60bA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 11:50:53 +0100
Message-ID: <CAKv+Gu9z_mGwdZYMKPfM_g2MZwrCF5=f4WAdn_R6wJ1A9xSZ_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
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

On Mon, 21 Jan 2019 at 11:17, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi,
>
>
> On Mon, Jan 21, 2019 at 12:56 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> > >
> > > Qualcomm SoCs have an additional level of cache called as
> > > System cache, aka. Last level cache (LLC). This cache sits right
> > > before the DDR, and is tightly coupled with the memory controller.
> > > The clients using this cache request their slices from this
> > > system cache, make it active, and can then start using it.
> > > For these clients with smmu, to start using the system cache for
> > > buffers and, related page tables [1], memory attributes need to be
> > > set accordingly. This series add the required support.
> > >
> >
> > Does this actually improve performance on reads from a device? The
> > non-cache coherent DMA routines perform an unconditional D-cache
> > invalidate by VA to the PoC before reading from the buffers filled by
> > the device, and I would expect the PoC to be defined as lying beyond
> > the LLC to still guarantee the architected behavior.
>
> We have seen performance improvements when running Manhattan
> GFXBench benchmarks.
>

Ah ok, that makes sense, since in that case, the data flow is mostly
to the device, not from the device.

> As for the PoC, from my knowledge on sdm845 the system cache, aka
> Last level cache (LLC) lies beyond the point of coherency.
> Non-cache coherent buffers will not be cached to system cache also, and
> no additional software cache maintenance ops are required for system cache.
> Pratik can add more if I am missing something.
>
> To take care of the memory attributes from DMA APIs side, we can add a
> DMA_ATTR definition to take care of any dma non-coherent APIs calls.
>

So does the device use the correct inner non-cacheable, outer
writeback cacheable attributes if the SMMU is in pass-through?

We have been looking into another use case where the fact that the
SMMU overrides memory attributes is causing issues (WC mappings used
by the radeon and amdgpu driver). So if the SMMU would honour the
existing attributes, would you still need the SMMU changes?
