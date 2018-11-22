Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F883C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF17920831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/8CsJQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF17920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391145AbeKVLmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 06:42:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45044 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbeKVLmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 06:42:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so7872046plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 17:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H88b1cmdsQaoqoZRWizaECbaO0xqVJmOgfKDRxRxpmQ=;
        b=A/8CsJQuup1VRcpAYA9SR4z7C3uaETeqL5QqwT76vV7znii0KUhHbYeR7OHGdRSsmv
         T+5oK5DCI/jo9i/GbH+ocWUll1oI8dpGXauNR+ZqE/c1+nW1w5EYDzVK/YQcBnxr7Sqg
         21bZOvHrKM0/gUthVulYOhiMjUXbTIZyoe5YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H88b1cmdsQaoqoZRWizaECbaO0xqVJmOgfKDRxRxpmQ=;
        b=MFroIfV2h3RXgxOjiaXQofTtnfaFByeHKL7lbpmp4873EBlv67nxlHqtnbjWCSRvIR
         abusfP79RH30IT/7kwspc9WzgAdwwamoxWwdNJ3cvxL4/8yx4vmm6yHzIJSXXGsgNdYy
         q1h40yRGA6XcHy+BvwbVziTYl9f7bo4S538XnWSJ4A3wHgoAuJcAucZHbgvJ8dR3GAOO
         MepwnzdNpmdpnMvwD2QVCnkDERfeJJ/dPEGoiurzR5rMQ+VBgaegdCMo66Eg2kkDVkmx
         xkJdNYirFK3/tr9gLa51ln8+NsQjMP70oLLoQwju9+mhpdNuIc0VbL1GQ01TXkmfPy1d
         W6YA==
X-Gm-Message-State: AA+aEWbLfYlq6TcYW2hhGAn7lQgBzawvmu+BoFlA3rVRMsHLSg59MDCC
        21rnB1/SQy7wzUOsoMy7glMvOifQM6Q5ljnbpzIY3u4/dNzeODPw
X-Google-Smtp-Source: AFSGD/UqX9+d9WAkQU3htMDieQlRG2pQOAjpDeW/DppRdyLlC2eOPC22Ii1BSqjgFpHVRHc8BiSAyZm2rN7xEAVXYxE=
X-Received: by 2002:a17:902:8214:: with SMTP id x20-v6mr8712162pln.224.1542848742049;
 Wed, 21 Nov 2018 17:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org> <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
In-Reply-To: <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 22 Nov 2018 09:05:30 +0800
Message-ID: <CANMq1KASTr_zCZnymfT173BLgGH0p0Pr7ortO1sdm_yb9rjKUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     willy@infradead.org, Christoph Lameter <cl@linux.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 6:27 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2018-11-21 9:38 pm, Matthew Wilcox wrote:
> > On Wed, Nov 21, 2018 at 06:20:02PM +0000, Christopher Lameter wrote:
> >> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
> >>
> >>> This is a follow-up to the discussion in [1], to make sure that the page
> >>> tables allocated by iommu/io-pgtable-arm-v7s are contained within 32-bit
> >>> physical address space.
> >>
> >> Page tables? This means you need a page frame? Why go through the slab
> >> allocators?
> >
> > Because this particular architecture has sub-page-size PMD page tables.
> > We desperately need to hoist page table allocation out of the architectures;
> > there're a bunch of different implementations and they're mostly bad,
> > one way or another.
>
> These are IOMMU page tables, rather than CPU ones, so we're already well
> outside arch code - indeed the original motivation of io-pgtable was to
> be entirely independent of the p*d types and arch-specific MM code (this
> Armv7 short-descriptor format is already "non-native" when used by
> drivers in an arm64 kernel).
>
> There are various efficiency reasons for using regular kernel memory
> instead of coherent DMA allocations - for the most part it works well,
> we just have the odd corner case like this one where the 32-bit format
> gets used on 64-bit systems such that the tables themselves still need
> to be allocated below 4GB (although the final output address can point
> at higher memory by virtue of the IOMMU in question not implementing
> permissions and repurposing some of those PTE fields as extra address bits).
>
> TBH, if this DMA32 stuff is going to be contentious we could possibly
> just rip out the offending kmem_cache - it seemed like good practice for
> the use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied
> upon to give the same 1KB alignment and chance of succeeding as the
> equivalent kmem_cache_alloc(), then we could quite easily make do with
> that instead.

Yes, but if we want to use kzalloc, we'll need to create
kmalloc_caches for DMA32, which seems wasteful as there are no other
users (see my comment here:
https://patchwork.kernel.org/patch/10677525/#22332697).

Thanks,

> Thanks,
> Robin.
>
> > For each level of page table we generally have three cases:
> >
> > 1. single page
> > 2. sub-page, naturally aligned
> > 3. multiple pages, naturally aligned
> >
> > for 1 and 3, the page allocator will do just fine.
> > for 2, we should have a per-MM page_frag allocator.  s390 already has
> > something like this, although it's more complicated.  ppc also has
> > something a little more complex for the cases when it's configured with
> > a 64k page size but wants to use a 4k page table entry.
> >
> > I'd like x86 to be able to simply do:
> >
> > #define pte_alloc_one(mm, addr)       page_alloc_table(mm, addr, 0)
> > #define pmd_alloc_one(mm, addr)       page_alloc_table(mm, addr, 0)
> > #define pud_alloc_one(mm, addr)       page_alloc_table(mm, addr, 0)
> > #define p4d_alloc_one(mm, addr)       page_alloc_table(mm, addr, 0)
> >
> > An architecture with 4k page size and needing a 16k PMD would do:
> >
> > #define pmd_alloc_one(mm, addr) page_alloc_table(mm, addr, 2)
> >
> > while an architecture with a 64k page size needing a 4k PTE would do:
> >
> > #define ARCH_PAGE_TABLE_FRAG
> > #define pte_alloc_one(mm, addr) pagefrag_alloc_table(mm, addr, 4096)
> >
> > I haven't had time to work on this, but perhaps someone with a problem
> > that needs fixing would like to, instead of burying yet another awful
> > implementation away in arch/ somewhere.
> >
