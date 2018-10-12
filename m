Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C3C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 23:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0272098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 23:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekF0eJ/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0272098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeJMGoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:44:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38692 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJMGoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:44:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so6899171pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Aa7wfht1De17/v+VpkLzWV4ml0Jd7mv/a1Kf5+U9aJQ=;
        b=ekF0eJ/WyNKcj8ssr0UJ3dwvFhHlIRlNH+rpc/ZqxDeCsjGugCfQmuW1poBNq6DZQH
         hD3/b0AZrwGYkoCAhho6ycCkFaXCkP60WhfCO8RNP+pU22AajWKkUXiiA2j2ILtxKHI8
         YxJnq5BnDdgo+W6ESBaIUOyABblvHQNsJJeSLoQDFDfZhtEVOZQ8pDwzT7eSMWAyLVvt
         eq941k+S6R5nlRp6TsgcMRd8nZSvhsiJmZMKkPbgrBqXUZKpZtsEMFoVeMFKfgUGTDBc
         Evuqcwg9LtSR0syKTP9bEfgw4tpzL/sA2FhU80eYGkavvu1bUUemyCjFVfFgRtvUnRJF
         0KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Aa7wfht1De17/v+VpkLzWV4ml0Jd7mv/a1Kf5+U9aJQ=;
        b=cdD76uITLCFVeKy+/lc9vjobb0sSe2gELsknuJxVt0TqEZJszfSGRJcW6Qu7ZldP57
         QkaAyO3rVLaY7ZsM0wf/k+cbwS9AcuXEHvlC3qPNqaLuk/cDBLC+nENYnphMn9yB07Zd
         zqD5mr2ELevwSTo+FOv3iWjn0tx7COS8KcEq1Brb9nBl7Rq9fowWmyKB31q7Ww4msi/A
         ALTD7HuPTSUjIYtmpY7/SXQRlXqzXlPsPC4tIjJpmMLSmu50Di84/buLv09TBKQi6ttj
         hRXhoN38W9XaG1te97WneatBTjVkZeMHeQzVr5jbG1IlX4bQBjQHhQJ6R5ygVAD5ZnGE
         AlqA==
X-Gm-Message-State: ABuFfoiV9G6/KDl3s5Dz8jIN8/h/t70Od0vEa4mZmDbS9ktdi7SaSb0n
        cIjcCFtdApHhW+yrKKQCwIrOjA==
X-Google-Smtp-Source: ACcGV63yLKkTsngagu/o+Jkyor/MHGjAC2kuNH+pdQo1hddIpHCqu1+dGzUvFPX5P3w80j8bfYENrw==
X-Received: by 2002:a63:1066:: with SMTP id 38-v6mr7364710pgq.254.1539385796462;
        Fri, 12 Oct 2018 16:09:56 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d2-v6sm4352808pfj.122.2018.10.12.16.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 16:09:55 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:09:54 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, slab: avoid high-order slab pages when it does not
 reduce waste
In-Reply-To: <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1810121559460.133019@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810121424420.116562@chino.kir.corp.google.com> <20181012151341.286cd91321cdda9b6bde4de9@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018, Andrew Morton wrote:

> > The slab allocator has a heuristic that checks whether the internal
> > fragmentation is satisfactory and, if not, increases cachep->gfporder to
> > try to improve this.
> > 
> > If the amount of waste is the same at higher cachep->gfporder values,
> > there is no significant benefit to allocating higher order memory.  There
> > will be fewer calls to the page allocator, but each call will require
> > zone->lock and finding the page of best fit from the per-zone free areas.
> > 
> > Instead, it is better to allocate order-0 memory if possible so that pages
> > can be returned from the per-cpu pagesets (pcp).
> > 
> > There are two reasons to prefer this over allocating high order memory:
> > 
> >  - allocating from the pcp lists does not require a per-zone lock, and
> > 
> >  - this reduces stranding of MIGRATE_UNMOVABLE pageblocks on pcp lists
> >    that increases slab fragmentation across a zone.
> 
> Confused.  Higher-order slab pages never go through the pcp lists, do
> they?

Nope.

> I'd have thought that by tending to increase the amount of
> order-0 pages which are used by slab, such stranding would be
> *increased*?
> 

These cpus have MIGRATE_UNMOVABLE pages on their pcp list.  But because 
they are order-1 instead of order-0, we take zone->lock and find the 
smallest possible page in the zone's free area that is of sufficient size.  
On low on memory situations, there are no pages of MIGRATE_UNMOVABLE 
migratetype at any order in the free area.  This calls 
__rmqueue_fallback() that steals pageblocks, MIGRATE_RECLAIMABLE and then 
MIGRATE_MOVABLE, and as MIGRATE_UNMOVABLE.

We rely on the pcp batch count to backfill MIGRATE_UNMOVABLE pages onto 
the pcp list so we don't need to take zone->lock, and as a result of these 
allocations being order-0 rather than order-1 we can then allocate from 
these pages when such slab caches are expanded rather than stranding them.

We noticed this when the amount of memory wasted for TCPv6 was the same 
for both order-0 and order-1 allocations (order-1 waste was two times the 
order-0 waste).  We had hundreds of cpus with pages on their 
MIGRATE_UNMOVABLE pcp list, but while allocating order-1 memory it would 
prefer to happily steal other pageblocks before calling reclaim and 
draining pcp lists.

> > We are particularly interested in the second point to eliminate cases
> > where all other pages on a pageblock are movable (or free) and fallback to
> > pageblocks of other migratetypes from the per-zone free areas causes
> > high-order slab memory to be allocated from them rather than from free
> > MIGRATE_UNMOVABLE pages on the pcp.
> > 
> >  mm/slab.c | 15 +++++++++++++++
> 
> Do slub and slob also suffer from this effect?
> 

SLOB should not, SLUB will typically increase the order to improve 
performance of the cpu cache; there's a drawback to changing out the cpu 
cache that SLAB does not have.  In the case that this patch is addressing, 
there is no greater memory utilization from the allocted slab pages.
