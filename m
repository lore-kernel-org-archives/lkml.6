Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B7220672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwgbkZCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B7220672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeLEFv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:51:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42866 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLEFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:51:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so8492560pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7B9CTpvYp8u/sULrhl76RfRou0xrjyBsdRlbjKE8Ho=;
        b=CwgbkZCAdv5iXvavxspbZTlrvci7haOVEDqSV54ieGnR8NmMDEk5kOiEihAwY2EDXR
         GslGbiUVCkW9dDlHGAxZFUE9wLWC1s9nS4QR+tXos15jBfJGk2BkGPvNtR7OqbCFfHZQ
         9gRsdtV15ckj7dBeNrIZ7mKV3SnEr6Bo9DJvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7B9CTpvYp8u/sULrhl76RfRou0xrjyBsdRlbjKE8Ho=;
        b=d/60u/CHTUpQR+72b8nfmvf/c0S+t8nalrx0WDkP9gGUN4+c3F4S11c5EGUzgVNBPT
         pjGS3IexTXxBwP3raohMSxs4pvCo5ebRGPZEbwlAHqjxyLLuX8hXEE8DplX+Jx2MVv4d
         ZW1qphoAL62jNW8u+ZbrCl/et1MzEIYReM+P+TXguUtkxpZ0gJBAl7/XjOAKe+o4FQjT
         kibFrSidvBnoKo/jphCKzs5uxVcCXVwwrQJCdISwqBoY3u8OMqQ8+Pb27S6gn5sM1S4X
         E/XIW4YG7ZP46AjfTnNYOXb76EBeSC4Tor4Z5QQAnPG7bgLtRnE2VYzIYc3lo28ctO/4
         RM5w==
X-Gm-Message-State: AA+aEWY7XDf+0Xy3rOZ/HLQvt0lONI4x4TJ4UjfC4nAyA3ALsW5d1CIT
        TIb/a0ZF7IFhZf1Q8Z90TQY5B2J1k5qUIUlWoF/jTw==
X-Google-Smtp-Source: AFSGD/WnqzvPNxEcwdeKF0Z3YYSXuv2XwN4gyJTrVZxB7RcC9HXuRyiJWFGIlBYYfacjsjjz7eYfkfdNkFkfIbwfXWo=
X-Received: by 2002:a63:7cf:: with SMTP id 198mr19694633pgh.129.1543989088019;
 Tue, 04 Dec 2018 21:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <CANMq1KDxmRcWhtaJbrLHqx6yPGkNaK7WNYYf+iFjH1e8XdrwRg@mail.gmail.com>
 <b99dd00f-fe1c-1cac-8ee3-5b0c1af9a92e@suse.cz> <CANMq1KDzKJqJwGsW3A90JY_0kgDtAMjOikT-3C9zQG01=3dibQ@mail.gmail.com>
In-Reply-To: <CANMq1KDzKJqJwGsW3A90JY_0kgDtAMjOikT-3C9zQG01=3dibQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 5 Dec 2018 13:51:16 +0800
Message-ID: <CANMq1KAd4SzyWY+=fS4aeqyj_b3y7AUXmdoUWe3X1gq=ATOD5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hch@infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>, Tomasz Figa <tfiga@google.com>,
        yingjoe.chen@mediatek.com, Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 10:04 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Tue, Dec 4, 2018 at 10:35 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 12/4/18 10:37 AM, Nicolas Boichat wrote:
> > > On Sun, Nov 11, 2018 at 5:04 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >>
> > >> This is a follow-up to the discussion in [1], to make sure that the page
> > >> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> > >> physical address space.
> > >>
> > >> [1] https://lists.linuxfoundation.org/pipermail/iommu/2018-November/030876.html
> > >
> > > Hi everyone,
> > >
> > > Let's try to summarize here.
> > >
> > > First, we confirmed that this is a regression, and IOMMU errors happen
> > > on 4.19 and linux-next/master on MT8173 (elm, Acer Chromebook R13).
> > > The issue most likely starts from ad67f5a6545f ("arm64: replace
> > > ZONE_DMA with ZONE_DMA32"), i.e. 4.15, and presumably breaks a number
> > > of Mediatek platforms (and maybe others?).
> > >
> > > We have a few options here:
> > > 1. This series [2], that adds support for GFP_DMA32 slab caches,
> > > _without_ adding kmalloc caches (since there are no users of
> > > kmalloc(..., GFP_DMA32)). I think I've addressed all the comments on
> > > the 3 patches, and AFAICT this solution works fine.
> > > 2. genalloc. That works, but unless we preallocate 4MB for L2 tables
> > > (which is wasteful as we usually only need a handful of L2 tables),
> > > we'll need changes in the core (use GFP_ATOMIC) to allow allocating on
> > > demand, and as it stands we'd have no way to shrink the allocation.
> > > 3. page_frag [3]. That works fine, and the code is quite simple. One
> > > drawback is that fragments in partially freed pages cannot be reused
> > > (from limited experiments, I see that IOMMU L2 tables are rarely
> > > freed, so it's unlikely a whole page would get freed). But given the
> > > low number of L2 tables, maybe we can live with that.
> > >
> > > I think 2 is out. Any preference between 1 and 3? I think 1 makes
> > > better use of the memory, so that'd be my preference. But I'm probably
> > > missing something.
> >
> > I would prefer 1 as well. IIRC you already confirmed that alignment
> > requirements are not broken for custom kmem caches even in presence of
> > SLUB debug options (and I would say it's a bug to be fixed if they
> > weren't).
>
> > I just asked (and didn't get a reply I think) about your
> > ability to handle the GFP_ATOMIC allocation failures. They should be
> > rare when only single page allocations are needed for the kmem cache.
> > But in case they are not an option, then preallocating would be needed,
> > thus probably option 2.
>
> Oh, sorry, I missed your question.
>
> I don't have a full answer, but:
> - The allocations themselves are rare (I count a few 10s of L2 tables
> at most on my system, I assume we rarely have >100), and yes, we only
> need a single page, so the failures should be exceptional.
> - My change is probably not making anything worse: I assume that even
> with the current approach using GFP_DMA slab caches on older kernels,
> failures could potentially happen. I don't think we've seen those. If
> we are really concerned about this, maybe we'd need to modify
> mtk_iommu_map to not hold a spinlock (if that's possible), so we don't
> need to use GFP_ATOMIC. I suggest we just keep an eye on such issues,
> and address them if they show up (we can even revisit genalloc at that
> stage).
>
> Anyway, I'll clean up patches for 1 (mostly commit message changes
> based on the comments in the threads) and resend.

Done here: https://patchwork.kernel.org/cover/10713019/ .

> Thanks,
>
> > > [2] https://patchwork.kernel.org/cover/10677529/, 3 patches
> > > [3] https://patchwork.codeaurora.org/patch/671639/
> > >
> > > Thanks,
> > >
> > > Nicolas
> > >
> >
