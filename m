Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367252171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j8w6d/0Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hMzQ6bHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfABHw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:52:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45440 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfABHw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:52:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD0556072E; Wed,  2 Jan 2019 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546415575;
        bh=EwjffueHTy6gqY/GdcrwQf2t7+MyCZ5PnuuJOoGYmV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j8w6d/0Z1fmmivvoHJtuu9gy2Y7dHwPGpq7ouqkV62+6WWTB5B3ICZ/LZQAgtC8pW
         SP5AZ/KXlAabo/Hsf9zn0uqYZvArNKRpOtpLXKyIOPchm1wAzth9L37CGSPdiTgTLu
         Mvyrq8p5cdXVPwFke7N1SlfHPBwdY5upN++abJjw=
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BABBF60709;
        Wed,  2 Jan 2019 07:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546415574;
        bh=EwjffueHTy6gqY/GdcrwQf2t7+MyCZ5PnuuJOoGYmV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hMzQ6bHGcTp7BaAm5BzY9gAnMNCkkEABrBAM++ipNrn78asVcRdhRmsx5OiSS79dz
         dFb8lfm5bUHBcQBAUrDIA9JZLnvknrzat+GEHqO/VO3PJQMBU2Wk1w4CMhl/F3zg+o
         DWEWoaTLP7stqBtJfBury1kry2VExPni2hbERihM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BABBF60709
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f176.google.com with SMTP id i7so32656894qtj.10;
        Tue, 01 Jan 2019 23:52:53 -0800 (PST)
X-Gm-Message-State: AA+aEWYbOicCZbfN/JSSjtEq1Oodkg5562LZnqowhxGIYFccwO5uP6HZ
        IpKlXK2MOMi4RBtx0/YzlNRiq7d/JmZFX1NgHZY=
X-Google-Smtp-Source: AFSGD/VMaUc17A5OkT2ywrGP6a7n4YWrAZXZgBT0WFnBzs+UozoV/yd6jpR41YjvbxKOvHUEtteWsaaYdr0jknQautc=
X-Received: by 2002:ac8:7353:: with SMTP id q19mr40912203qtp.265.1546415572931;
 Tue, 01 Jan 2019 23:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20181204110122.12434-1-vivek.gautam@codeaurora.org>
 <99682bd2-1ca6-406a-890c-b34c25a1b2b3@arm.com> <CAFp+6iE7U3HCJwHkeL9A4DXUVryt13YxDCYfBDxcSSM2Z_vqcg@mail.gmail.com>
In-Reply-To: <CAFp+6iE7U3HCJwHkeL9A4DXUVryt13YxDCYfBDxcSSM2Z_vqcg@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 2 Jan 2019 13:22:40 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFBoKhPaCu_s+4Rb3v8ch8E3nv-ecSmGMzkQK4kiRzcDA@mail.gmail.com>
Message-ID: <CAFp+6iFBoKhPaCu_s+4Rb3v8ch8E3nv-ecSmGMzkQK4kiRzcDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pratikp@codeaurora.org, Tomasz Figa <tfiga@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Fri, Dec 7, 2018 at 2:54 PM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Hi Robin,
>
> On Tue, Dec 4, 2018 at 8:51 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 04/12/2018 11:01, Vivek Gautam wrote:
> > > Qualcomm SoCs have an additional level of cache called as
> > > System cache, aka. Last level cache (LLC). This cache sits right
> > > before the DDR, and is tightly coupled with the memory controller.
> > > The cache is available to all the clients present in the SoC system.
> > > The clients request their slices from this system cache, make it
> > > active, and can then start using it.
> > > For these clients with smmu, to start using the system cache for
> > > buffers and, related page tables [1], memory attributes need to be
> > > set accordingly.
> > > This change updates the MAIR and TCR configurations with correct
> > > attributes to use this system cache.
> > >
> > > To explain a little about memory attribute requirements here:
> > >
> > > Non-coherent I/O devices can't look-up into inner caches. However,
> > > coherent I/O devices can. But both can allocate in the system cache
> > > based on system policy and configured memory attributes in page
> > > tables.
> > > CPUs can access both inner and outer caches (including system cache,
> > > aka. Last level cache), and can allocate into system cache too
> > > based on memory attributes, and system policy.
> > >
> > > Further looking at memory types, we have following -
> > > a) Normal uncached :- MAIR 0x44, inner non-cacheable,
> > >                        outer non-cacheable;
> > > b) Normal cached :-   MAIR 0xff, inner read write-back non-transient,
> > >                        outer read write-back non-transient;
> > >                        attribute setting for coherenet I/O devices.
> > >
> > > and, for non-coherent i/o devices that can allocate in system cache
> > > another type gets added -
> > > c) Normal sys-cached/non-inner-cached :-
> > >                        MAIR 0xf4, inner non-cacheable,
> > >                        outer read write-back non-transient
> > >
> > > So, CPU will automatically use the system cache for memory marked as
> > > normal cached. The normal sys-cached is downgraded to normal non-cached
> > > memory for CPUs.
> > > Coherent I/O devices can use system cache by marking the memory as
> > > normal cached.
> > > Non-coherent I/O devices, to use system cache, should mark the memory as
> > > normal sys-cached in page tables.
> > >
> > > This change is a realisation of following changes
> > > from downstream msm-4.9:
> > > iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> > > iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
> > >
> > > [1] https://patchwork.kernel.org/patch/10302791/
> > > [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> > > [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> > >
> > > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > > ---
> > >
> > > Changes since v1:
> > >   - Addressed Tomasz's comments for basing the change on
> > >     "NO_INNER_CACHE" concept for non-coherent I/O devices
> > >     rather than capturing "SYS_CACHE". This is to indicate
> > >     clearly the intent of non-coherent I/O devices that
> > >     can't access inner caches.
> >
> > That seems backwards to me - there is already a fundamental assumption
> > that non-coherent devices can't access caches. What we're adding here is
> > a weird exception where they *can* use some level of cache despite still
> > being non-coherent overall.
> >
> > In other words, it's not a case of downgrading coherent devices'
> > accesses to bypass inner caches, it's upgrading non-coherent devices'
> > accesses to hit the outer cache. That's certainly the understanding I
> > got from talking with Pratik at Plumbers, and it does appear to fit with
> > your explanation above despite the final conclusion you draw being
> > different.
>
> Thanks for the thorough review of the change.
> Right, I guess it's rather an upgrade for non-coherent devices to use
> an outer cache than a downgrade for coherent devices.
>
> >
> > I do see what Tomasz meant in terms of the TCR attributes, but what we
> > currently do there is a little unintuitive and not at all representative
> > of actual mapping attributes - I'll come back to that inline.
> >
> > >   drivers/iommu/arm-smmu.c       | 15 +++++++++++++++
> > >   drivers/iommu/dma-iommu.c      |  3 +++
> > >   drivers/iommu/io-pgtable-arm.c | 22 +++++++++++++++++-----
> > >   drivers/iommu/io-pgtable.h     |  5 +++++
> > >   include/linux/iommu.h          |  3 +++
> > >   5 files changed, 43 insertions(+), 5 deletions(-)
> >
> > As a minor nit, I'd prefer this as at least two patches to separate the
> > io-pgtable changes and arm-smmu changes - basically I'd expect it to
> > look much the same as the non-strict mode support did.
>
> Sure, will split the patch.
>
> >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index ba18d89d4732..047f7ff95b0d 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -255,6 +255,7 @@ struct arm_smmu_domain {
> > >       struct mutex                    init_mutex; /* Protects smmu pointer */
> > >       spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> > >       struct iommu_domain             domain;
> > > +     bool                            no_inner_cache;
> >
> > Can we keep all the domain flags together please? In fact, I'd be
> > inclined to implement an options bitmap as we do elsewhere rather than
> > proliferate multiple bools.
>
> Yea, changing this to bitmap makes sense. Will update this.
>
> >
> > >   };
> > >
> > >   struct arm_smmu_option_prop {
> > > @@ -897,6 +898,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> > >       if (smmu_domain->non_strict)
> > >               pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> > >
> > > +     if (smmu_domain->no_inner_cache)
> > > +             pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NO_IC;
> >
> > Maybe we need to be a bit cleverer about setting the quirk (and/or
> > allowing the domain attribute to be set), since depending on
> > configuration and hardware support the domain may end up picking a stage
> > 2 or short-descriptor format and thus being rendered unusable.
>
> I don't think I completely get you here.
> But, do you mean that to set such quirks we should first check configurations
> such as the domain's stage, and the format before deciding whether
> we want to set this or not?
>
> >
> > > +
> > >       smmu_domain->smmu = smmu;
> > >       pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
> > >       if (!pgtbl_ops) {
> > > @@ -1579,6 +1583,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> > >               case DOMAIN_ATTR_NESTING:
> > >                       *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> > >                       return 0;
> > > +             case DOMAIN_ATTR_NO_IC:
> > > +                     *((int *)data) = smmu_domain->no_inner_cache;
> > > +                     return 0;
> > >               default:
> > >                       return -ENODEV;
> > >               }
> > > @@ -1619,6 +1626,14 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
> > >                       else
> > >                               smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> > >                       break;
> > > +             case DOMAIN_ATTR_NO_IC:
> > > +                     if (smmu_domain->smmu) {
> > > +                             ret = -EPERM;
> > > +                             goto out_unlock;
> > > +                     }
> > > +                     if (*((int *)data))
> > > +                             smmu_domain->no_inner_cache = true;
> >
> > This makes the attribute impossible to disable again, even before the
> > domain is initialized - is that intentional? (and if so, why?)
>
> Right. I should add for data = 0 as well. That should help to disable this
> attribute again.
>
> >
> > > +                     break;
> > >               default:
> > >                       ret = -ENODEV;
> > >               }
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index d1b04753b204..87c3d59c4a6c 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -354,6 +354,9 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
> > >   {
> > >       int prot = coherent ? IOMMU_CACHE : 0;
> > >
> > > +     if (!coherent && (attrs & DOMAIN_ATTR_NO_IC))
> > > +             prot |= IOMMU_NO_IC;
> > > +
> >
> > Erm, that's going to be a hilariously unexpected interpretation of
> > DMA_ATTR_FORCE_CONTIGUOUS...
>
> Right. :)
> I guess i will take your suggestion to have something like
> DOMAIN_ATTR_QCOM_SYSTEM_CACHE.
>
> >
> > I'm not sure it would really makes sense to expose fine-grained controls
> > at the DMA API level anyway, given the main point is to largely abstract
> > away the notion of caches altogether.
>
> But there are DMA devices (such as video) which use DMA mapping APIs only,
> and which are non-coherent-upgraded-to-use-sytem-cache. Such devices
> can't force set IOMMU quirks unless they do iommu_get_domain_for_dev()
> and then set the domain attributes.
> Will that be better way?

Any suggestions here?

>
> >
> > >       if (attrs & DMA_ATTR_PRIVILEGED)
> > >               prot |= IOMMU_PRIV;
> > >
> > > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > > index 237cacd4a62b..815b86067bcc 100644
> > > --- a/drivers/iommu/io-pgtable-arm.c
> > > +++ b/drivers/iommu/io-pgtable-arm.c
> > > @@ -168,10 +168,12 @@
> > >   #define ARM_LPAE_MAIR_ATTR_MASK             0xff
> > >   #define ARM_LPAE_MAIR_ATTR_DEVICE   0x04
> > >   #define ARM_LPAE_MAIR_ATTR_NC               0x44
> > > +#define ARM_LPAE_MAIR_ATTR_NO_IC     0xf4
> > >   #define ARM_LPAE_MAIR_ATTR_WBRWA    0xff
> > >   #define ARM_LPAE_MAIR_ATTR_IDX_NC   0
> > >   #define ARM_LPAE_MAIR_ATTR_IDX_CACHE        1
> > >   #define ARM_LPAE_MAIR_ATTR_IDX_DEV  2
> > > +#define ARM_LPAE_MAIR_ATTR_IDX_NO_IC 3
> > >
> > >   /* IOPTE accessors */
> > >   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> > > @@ -443,6 +445,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> > >               else if (prot & IOMMU_CACHE)
> > >                       pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
> > >                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > > +             else if (prot & IOMMU_NO_IC)
> > > +                     pte |= (ARM_LPAE_MAIR_ATTR_IDX_NO_IC
> > > +                             << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> > >       } else {
> > >               pte = ARM_LPAE_PTE_HAP_FAULT;
> > >               if (prot & IOMMU_READ)
> > > @@ -780,7 +785,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> > >       struct arm_lpae_io_pgtable *data;
> > >
> > >       if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
> > > -                         IO_PGTABLE_QUIRK_NON_STRICT))
> > > +                         IO_PGTABLE_QUIRK_NON_STRICT |
> > > +                         IO_PGTABLE_QUIRK_NO_IC))
> > >               return NULL;
> > >
> > >       data = arm_lpae_alloc_pgtable(cfg);
> > > @@ -788,9 +794,13 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
> > >               return NULL;
> > >
> > >       /* TCR */
> > > -     reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> > > -           (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> > > -           (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> >
> > The subtle assumption here is that if the SMMU is coherent then these
> > are the attributes we actually want to use, but if it's non-coherent
> > then the interconnect should ignore them anyway so it doesn't really
> > matter. Does either of those aspects hold for qcom SoCs?
>
> From the downstream [1] it's clear that default for smmu is set to
> Non-cached access.
> So, I don't think the interconnect helps us. OR, possibly we are just
> forcing these
> mappings be uncached.
>
> >
> > TBH if we're going to touch the TCR attributes at all then we should
> > probably correct that sloppiness first - there's an occasional argument
> > for using non-cacheable pagetables even on a coherent SMMU if reducing
> > snoop traffic/latency on walks outweighs the cost of cache maintenance
> > on PTE updates, but anyone thinking they can get that by overriding
> > dma-coherent silently gets the worst of both worlds thanks to this
> > current TCR value.
>
> So, what do you suggest?
> This is something that's smmu's implementation specific detail, not something
> that's going to vary from one domain to another? Isn't that right?
> So, in that case additional dt property can help setting a quirk?

I have a change that adds "arm,smmu-pgtable-non-coherent" option
and based on that adds a quick IO_PGTABLE_QUIRK_NON_COHERENT.

But before that I would like to check if we can make use of
IO_PGTABLE_QUIRK_NO_DMA?
In present design though we don't force page table mappings to be
non-coherent based on this quirk. Do we just rely on the interconnect, as you
said earlier, for non-coherent SMMU?

Anyone who wants to just force smmu's page table to be non-coherent
can use IO_PGTABLE_QUIRK_NON_COHERENT when not declaring
the SMMU as dma-coherent.

[snip]


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
