Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CA5218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H+D1s5bU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LGAMFMzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfABHWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:22:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfABHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:22:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EE61B6083C; Wed,  2 Jan 2019 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546413761;
        bh=IDkBkoqpMNzFD/mZd4YTDoOlIPTXXRg25jHC6bwHZDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+D1s5bUyve501+tizZDNxQVG3UE8+AM5CRuOEs+0SduvapWzmwequa9szsuC/DJm
         4Ct6kYDKgvf+7Fc7pg6T1V7jwTr3zMXSXCILw71f7nEIZkmSGvgIirqaeSrKag1XYT
         I0mQyQQrFOlps2NYx++ERoDTIL3AZwfH3UjlBxRQ=
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 172AD6034F;
        Wed,  2 Jan 2019 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546413760;
        bh=IDkBkoqpMNzFD/mZd4YTDoOlIPTXXRg25jHC6bwHZDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LGAMFMzPI7UtgSia4DNF3yG39VF1CE/Gw6ENP8UK5VZDAMg06Bor/4duSWD4xUUSo
         +DVLqmErXYPL5iIkrvYWOU6w4XvineQtRjldT+MOh9YoHN51Ksn2SI1CiJMoS/cL4W
         m0Xt2xGIctyXGjvb7EqA6zbqCCaxoASOhCT5+KmM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 172AD6034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f178.google.com with SMTP id k12so32617091qtf.7;
        Tue, 01 Jan 2019 23:22:40 -0800 (PST)
X-Gm-Message-State: AA+aEWaN8zNKYiJJK0yuPBcOMdkPLLf4lx8an47NiZdq1FW6xrcwqOY/
        JjIUxxg7CrxQIir/CAtFlZByeXVjwNPKxVm9FY0=
X-Google-Smtp-Source: AFSGD/XJzYo+078xFUjY6OMaVn1/Zz92xfgXtGdgSo5+fcCjvUb87n185obmusn0GKYguTwpcL7+ZldG+IzlEB/6tKA=
X-Received: by 2002:ac8:2353:: with SMTP id b19mr41006718qtb.187.1546413759330;
 Tue, 01 Jan 2019 23:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
 <99682bd2-1ca6-406a-890c-b34c25a1b2b3@arm.com> <CAFp+6iE7U3HCJwHkeL9A4DXUVryt13YxDCYfBDxcSSM2Z_vqcg@mail.gmail.com>
 <CAAFQd5C+BygjdBhBOsiBW=4kOgC0a=V8s9om6jqa6yzmn0TEWw@mail.gmail.com>
In-Reply-To: <CAAFQd5C+BygjdBhBOsiBW=4kOgC0a=V8s9om6jqa6yzmn0TEWw@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 2 Jan 2019 12:52:26 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHc5PMCkp_LP+=vsr+eX=6XDUecV_knrmEHjUozbB2R5A@mail.gmail.com>
Message-ID: <CAFp+6iHc5PMCkp_LP+=vsr+eX=6XDUecV_knrmEHjUozbB2R5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>, pratikp@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:20 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Fri, Dec 7, 2018 at 6:25 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> >
> > Hi Robin,
> >
> > On Tue, Dec 4, 2018 at 8:51 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 04/12/2018 11:01, Vivek Gautam wrote:
> > > > Qualcomm SoCs have an additional level of cache called as
> > > > System cache, aka. Last level cache (LLC). This cache sits right
> > > > before the DDR, and is tightly coupled with the memory controller.
> > > > The cache is available to all the clients present in the SoC system.
> > > > The clients request their slices from this system cache, make it
> > > > active, and can then start using it.
> > > > For these clients with smmu, to start using the system cache for
> > > > buffers and, related page tables [1], memory attributes need to be
> > > > set accordingly.
> > > > This change updates the MAIR and TCR configurations with correct
> > > > attributes to use this system cache.
> > > >
> > > > To explain a little about memory attribute requirements here:
> > > >
> > > > Non-coherent I/O devices can't look-up into inner caches. However,
> > > > coherent I/O devices can. But both can allocate in the system cache
> > > > based on system policy and configured memory attributes in page
> > > > tables.
> > > > CPUs can access both inner and outer caches (including system cache,
> > > > aka. Last level cache), and can allocate into system cache too
> > > > based on memory attributes, and system policy.
> > > >
> > > > Further looking at memory types, we have following -
> > > > a) Normal uncached :- MAIR 0x44, inner non-cacheable,
> > > >                        outer non-cacheable;
> > > > b) Normal cached :-   MAIR 0xff, inner read write-back non-transient,
> > > >                        outer read write-back non-transient;
> > > >                        attribute setting for coherenet I/O devices.
> > > >
> > > > and, for non-coherent i/o devices that can allocate in system cache
> > > > another type gets added -
> > > > c) Normal sys-cached/non-inner-cached :-
> > > >                        MAIR 0xf4, inner non-cacheable,
> > > >                        outer read write-back non-transient
> > > >
> > > > So, CPU will automatically use the system cache for memory marked as
> > > > normal cached. The normal sys-cached is downgraded to normal non-cached
> > > > memory for CPUs.
> > > > Coherent I/O devices can use system cache by marking the memory as
> > > > normal cached.
> > > > Non-coherent I/O devices, to use system cache, should mark the memory as
> > > > normal sys-cached in page tables.
> > > >
> > > > This change is a realisation of following changes
> > > > from downstream msm-4.9:
> > > > iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> > > > iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
> > > >
> > > > [1] https://patchwork.kernel.org/patch/10302791/
> > > > [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> > > > [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> > > >
> > > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > > ---
> > > >
> > > > Changes since v1:
> > > >   - Addressed Tomasz's comments for basing the change on
> > > >     "NO_INNER_CACHE" concept for non-coherent I/O devices
> > > >     rather than capturing "SYS_CACHE". This is to indicate
> > > >     clearly the intent of non-coherent I/O devices that
> > > >     can't access inner caches.
> > >
> > > That seems backwards to me - there is already a fundamental assumption
> > > that non-coherent devices can't access caches. What we're adding here is
> > > a weird exception where they *can* use some level of cache despite still
> > > being non-coherent overall.
> > >
> > > In other words, it's not a case of downgrading coherent devices'
> > > accesses to bypass inner caches, it's upgrading non-coherent devices'
> > > accesses to hit the outer cache. That's certainly the understanding I
> > > got from talking with Pratik at Plumbers, and it does appear to fit with
> > > your explanation above despite the final conclusion you draw being
> > > different.
> >
> > Thanks for the thorough review of the change.
> > Right, I guess it's rather an upgrade for non-coherent devices to use
> > an outer cache than a downgrade for coherent devices.
> >
>
> Note that it was not my suggestion to use "NO_INNER_CACHE" for
> enabling the system cache, sorry for not being clear. What I was
> asking for in my comment was regarding the previous patch disabling
> inner cache if system cache is requested, which may not make for
> coherent devices, which could benefit from using both inner and system
> cache.

Sorry for not taking the cue correctly. The intention of the change was to
let coherent devices use system cache as well. But I guess the change
wasn't designed correctly.

>
> So note that there are several cases here:
>  - coherent, IC, system cache alloc,
>  - coherent. non-IC, system cache alloc,
>  - coherent, IC, system cache look-up,
>  - noncoherent device, non-IC, system cache alloc,
>  - noncoherent device, non-IC, system cache look-up.
>
> Given the presence or lack of coherency for the device, which of the
> 2/3 options is the best depends on the use case, e.g. DMA/CPU access
> pattern, sharing memory between multiple devices, etc.
>

- coherent, IC, system cache alloc,
- coherent, IC, system cache look-up,
These two are default for coherent mappings. Coherent devices and
coherent IOMMUs can use inner caches/outer caches, and can allocate
and lookup in system caches.

- noncoherent device, non-IC, system cache look-up,  --> Always
- noncoherent device, non-IC, system cache allocate.  --> Depends on
system policy.

So, any page table memory for non-coherent SMMUs could very well
use system cache and CPU is free to look-up into it.
And so do the non-coherent and coherent devices can use the system cache.

Best regards
Vivek

> Best regards,
> Tomasz
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
