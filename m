Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544C220838
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DfhpuqJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544C220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393108AbeKWNrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:47:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33008 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731997AbeKWNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:47:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so1992678pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 19:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MC8eyd9+40cowj0IGrTrY5vh8damXSWR43TkM3I5PnU=;
        b=DfhpuqJ0Djtw7qrso3K/tvPnPFx9NmjmCRkK+BpDEzKipyhmBzrKibCCk1D1tEkIGF
         Sfhrp+UXd5UBfUqgfNDF2Jaus4JvXQ4nEghAlQg70GZaV5pHpfMAZuU5NvsjhrFbu9AR
         VoUdvUJeItgdoVCbesChfwvlmKUCuTH5qMTq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MC8eyd9+40cowj0IGrTrY5vh8damXSWR43TkM3I5PnU=;
        b=qcbEwwCHparF05Zpg0RpIBAeFQGC4bVbuf5mtbh7xFrCNhcknWSvpOI2MP7x3Pp3O+
         guGxb9Vn9Avm+B8n4ZbLIbbLoHMQCayyLB0d3Ka9O5gcqAIAzo8Nr8z/xjzTTft3AmUq
         AIAfQBL7RL7dsmM3mThYMUVj6jjiFqO+/ZLUkdeRQkNeZ3LOQOH4KRDFWyaWq2PiZ+MA
         HLL3kt0R7U9o+IiDUAUe47RPBXPcDkv5sA2GLVx6jGH4Hkt6jGX2KPA+b5f0R38O2CTA
         LIhPSLvYFjo+G9t5PFFbZFEf+gxn24sdAdhB3dfH7FFgUEbHgFg684EYSK+nL74qUWd1
         acQg==
X-Gm-Message-State: AA+aEWbu6bvYn1xp5A8VB1kvFie6iNJ6Y1mO7OS5Hx/L5YDARGzRVmaC
        gW2ICPH1ErJkXqphzfK2bcIvQjYSIPFYIf15yp81xA==
X-Google-Smtp-Source: AFSGD/Uh5Gm7ROEmO7KHaCgSZ6nc6l3hOfa4HTg2R1Dpa7c5RChNSZHaYG96zPylvPvUY3R3AsdjPzpUYj70enQrbqY=
X-Received: by 2002:a63:6645:: with SMTP id a66mr12169337pgc.390.1542942287344;
 Thu, 22 Nov 2018 19:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org> <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org>
In-Reply-To: <20181122082336.GA2049@infradead.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 23 Nov 2018 11:04:36 +0800
Message-ID: <CANMq1KALUmxkhE8aaYzEbd7YodF1296KdVympOP+2mWVQ9zmDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     hch@infradead.org
Cc:     Robin Murphy <robin.murphy@arm.com>, willy@infradead.org,
        Christoph Lameter <cl@linux.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        David Rientjes <rientjes@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 4:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Nov 21, 2018 at 10:26:26PM +0000, Robin Murphy wrote:
> > TBH, if this DMA32 stuff is going to be contentious we could possibly just
> > rip out the offending kmem_cache - it seemed like good practice for the
> > use-case, but provided kzalloc(SZ_1K, gfp | GFP_DMA32) can be relied upon to
> > give the same 1KB alignment and chance of succeeding as the equivalent
> > kmem_cache_alloc(), then we could quite easily make do with that instead.
>
> Neither is the slab support for kmalloc, not do kmalloc allocations
> have useful alignment apparently (at least if you use slub debug).
>
> But I do agree with the sentiment of not wanting to spread GFP_DMA32
> futher into the slab allocator.
>
> I think you want a simple genalloc allocator for this rather special
> use case.

So I had a look at genalloc, we'd need to add pre-allocated memory
using gen_pool_add [1]. There can be up to 4096 L2 page tables, so we
may need to pre-allocate 4MB of memory (1KB per L2 page table). We
could add chunks on demand, but then it'd be difficult to free them up
(genalloc does not have a "gen_pool_remove" call). So basically if the
full 4MB end up being requested, we'd be stuck with that until the
iommu domain is freed (on the arm64 Mediatek platforms I looked at,
there is only one iommu domain, and it never gets freed).

page_frag would at least have a chance to reclaim those pages (if I
understand Christoph's statement correctly)

Robin: Do you have some ideas of the lifetime/usage of L2 tables? If
they are usually few of them, or if they don't get reclaimed easily,
some on demand genalloc allocation would be ok (or even 4MB allocation
on init, if we're willing to take that hit). If they get allocated and
freed together, maybe page_frag is a better option?

Thanks,

[1] https://www.kernel.org/doc/html/v4.19/core-api/genalloc.html
