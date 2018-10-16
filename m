Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594ABC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37C020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgRZjTOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37C020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPI1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:27:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43531 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeJPI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:27:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so10078834plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WSosgb27W9LPFM4xLLeVVvSzQWYl+Gyt1ZgVA1iSiqk=;
        b=jgRZjTOsIxmgl88OpRzctVnY69AcZxwicXy1JZwMo2JQl9/xjuuh/snZD6/LJ2oT2H
         ZfV9RAMGVxj5yWmvkuW+R1I0JYu73os2+5k85qkfpfNMvsFHWiIr30owg0SnISz2+9kD
         54PMjZEBp+aeBwrDpOYS4wOJ4PrW71X9fey1ifeoRM1Fxmk82REknZzBlQ9HpFVAKlCm
         0i5aWPs8rZVgchkFx3orJcCJKPAYz+fopA7tT7eIEG80PQzKgX3NS4m5oMeaLa5waUse
         vHXGo4zj+45klf6pXrlybho4h/sYaQY1uzE77NGm5qptJqARLTIr49x2U8mrcicMkGSl
         CqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WSosgb27W9LPFM4xLLeVVvSzQWYl+Gyt1ZgVA1iSiqk=;
        b=RuMyGHEycuO+tnMQd1QF7BZiaO5M8SPW2VXaUHidocuUOBHLmcdWygvz9TctvY2ELf
         4B7Ur+ghzB+Cx5XxGn7Vg0STo8XAGFpbgidOBnI0t31R733m9fOssZEmqFQzYOXcfEg1
         YxhiMDv9ghxf3qgBlh74TOZve8x85JHp37GKuV+DwYvAI5uDHJLXmXogrtX9bQP5jVb3
         5lQzbuoRhPi2MJsgH0FXO/QjExJsTBCKMJJfbEUjRnSNV8dvy+IVHJoDvY3SozlZQ99X
         /3h6Gia7xtGCAeA4v+iwismIZs1U9MvgaLcJnVSI5Ji2IKd7kakHHIBdjoJeVwsuKE/R
         GwJQ==
X-Gm-Message-State: ABuFfoiXhSX0/V81XUdpQ/zPY4Q2bfMgY6JwqP6hYxVNJod9GyQS7QjH
        kEYjP8QcyVBml1Y7Rz04TZYj6g==
X-Google-Smtp-Source: ACcGV61SJpMDlwJxhBbn2xsXScx3EAEezQyfB9pW8IAWNhXrxJgMhNOL7TrZhnXeinGXwaTsh0KsTg==
X-Received: by 2002:a17:902:744c:: with SMTP id e12-v6mr19334875plt.186.1539650366535;
        Mon, 15 Oct 2018 17:39:26 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c79-v6sm18278130pfb.147.2018.10.15.17.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 17:39:25 -0700 (PDT)
Date:   Mon, 15 Oct 2018 17:39:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christopher Lameter <cl@linux.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
In-Reply-To: <0100016679e3c96f-c78df4e2-9ab8-48db-8796-271c4b439f16-000000@email.amazonses.com>
Message-ID: <alpine.DEB.2.21.1810151715220.21338@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com> <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org> <0100016679e3c96f-c78df4e2-9ab8-48db-8796-271c4b439f16-000000@email.amazonses.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Christopher Lameter wrote:

> > > If the amount of waste is the same at higher cachep->gfporder values,
> > > there is no significant benefit to allocating higher order memory.  There
> > > will be fewer calls to the page allocator, but each call will require
> > > zone->lock and finding the page of best fit from the per-zone free areas.
> 
> There is a benefit because the management overhead is halved.
> 

It depends on (1) how difficult it is to allocate higher order memory and 
(2) the long term affects of preferring high order memory over order 0.

For (1), slab has no minimum order fallback like slub does so the 
allocation either succeeds at cachep->gfporder or it fails.  If memory 
fragmentation is such that order-1 memory is not possible, this is fixing 
an issue where the slab allocation would succeed but now fails 
unnecessarily.  If that order-1 memory is painful to allocate, we've 
reclaimed and compacted unnecessarily when order-0 pages are available 
from the pcp list.

For (2), high-order slab allocations increase fragmentation of the zone 
under memory pressure.  If the per-zone free area is void of 
MIGRATE_UNMOVABLE pageblocks such that it must fallback, which it is under 
memory pressure, these order-1 pages can be returned from pageblocks that 
are filled with movable memory, or otherwise free.  This ends up making 
hugepages difficult to allocate from (to the extent where 1.5GB of slab on 
a node is spread over 100GB of pageblocks).  This occurs even though there 
may be MIGRATE_UNMOVABLE pages available on pcp lists.  Using this patch, 
it is possible to backfill the pcp list up to the batchcount with 
MIGRATE_UNMOVABLE order-0 pages that we can subsequently allocate and 
free to, which turns out to be optimized for caches like TCPv6 that result 
in both faster page allocation and less slab fragmentation.

> > > Instead, it is better to allocate order-0 memory if possible so that pages
> > > can be returned from the per-cpu pagesets (pcp).
> 
> Have a benchmark that shows this?
> 

I'm not necessarily approaching this from a performance point of view, but 
rather as a means to reduce slab fragmentation when fallback to order-0 
memory, especially when completely legitimate, is prohibited.  From a 
performance standpoint, this will depend on separately on fragmentation 
and contention on zone->lock which both don't exist for order-0 memory 
until fallback is required and then the pcp are filled with up to 
batchcount pages.

> >
> > > There are two reasons to prefer this over allocating high order memory:
> > >
> > >  - allocating from the pcp lists does not require a per-zone lock, and
> > >
> > >  - this reduces stranding of MIGRATE_UNMOVABLE pageblocks on pcp lists
> > >    that increases slab fragmentation across a zone.
> 
> The slab allocators generally buffer pages from the page allocator to
> avoid this effect given the slowness of page allocator operations anyways.
> 

It is possible to buffer the same number of pages once they are allocated, 
absent memory pressure, and does not require high-order memory.  This 
seems like a separate issue.

> > > We are particularly interested in the second point to eliminate cases
> > > where all other pages on a pageblock are movable (or free) and fallback to
> > > pageblocks of other migratetypes from the per-zone free areas causes
> > > high-order slab memory to be allocated from them rather than from free
> > > MIGRATE_UNMOVABLE pages on the pcp.
> 
> Well does this actually do some good?
> 

Examining pageblocks via tools/vm/page-types under memory pressure that 
show all B (buddy) and UlAMab (anon mapped) pages and then a single 
order-1 S (slab) page would suggest that the pageblock would not be 
exempted from ever being allocated for a hugepage until the slab is 
completely freed (indeterminate amount of time) if there are any pages on 
the MIGRATE_UNMOVABLE pcp list.

This change is eliminating the exemption from allocating from unmovable 
pages that are readily available instead of preferring to expensively 
allocate order-1 with no reduction in waste.

For users of slab_max_order, which we are not for obvious reasons, I can 
change this to only consider when testing gfporder == 0 since that 
logically makes sense if you prefer.
