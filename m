Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3012087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nun316VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3012087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeJKEYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:24:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39763 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeJKEYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:24:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so3231627pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CDLa69JCcNJtNB64BuSbF97p3HkkBGJVu7c5HN37+Ng=;
        b=Nun316VO4P6MfL3K11yGcMOlW+/0DYjktkkcbAXX6NS6JkiU3z8ELYIjwJVZ3ZWzQ7
         bGT7ao34YG/ra8vysi68yg3ybDRRLD22STNOHYnGWk8VzOmeGSCLz8oPIlEalAoHHH7s
         5b+K/a+YO8nfhhYkaBPvcre9dW8uWhkcmOwY2e1Z2gynvRzf3yWG9p+S6MpCDEXv7i9Z
         NeEkfZHZ0GLqxosDO7PIcxDitBJPvARzUf1yLH7w5bRKhHY0eYcpFjdnHqFBx93HxYUD
         BGJrvlxsFLq6dwIHSFOvW2WHp/JO9aD7n+HH/LRbQZTWFH6idsHvMGKg5ZTGWTY+Nycn
         XGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CDLa69JCcNJtNB64BuSbF97p3HkkBGJVu7c5HN37+Ng=;
        b=kdLPxIQK4uwLrN7C0A3d6GqxFk+sQsmuQUExz/QP0GMVijOcwpEmds1ho3iVWXISFW
         MOu1vcfefnhB60TkGrcZkwcWvU+LNP5af6QVnWivUdYjwmBNcbf7ZdqngAndArUKXKnH
         sUkWHVhXApVVJ5pL1nx44V7WNF/jxmvk+vZuniNcbT1Pb/ZFrxXQd0jbsO+SRx1Rbg2Y
         3BmtoQnuWKV9IgWSrRnxQqWXks0xrpzNk/wYqOONtM5yLqEQFpCsML3YNRBlxyc6Mlz8
         FqskhWkYbBXYuw9LXyEkkNNfUgBEi+i6a2iat0+QgmSUqTpAMyKwOdnCoytvLcKEA9UX
         2Yrg==
X-Gm-Message-State: ABuFfoiFta+CMEuJXhMRkgcT32gkz6OcGbvehBAFOX3MMUaaDAkt1nPx
        EF7chhg0uQWheSS6DTkcg9+w/A==
X-Google-Smtp-Source: ACcGV631BcI8b4q+y+2C2qWx8M47GgcnKZHTFTTDxiikpfK+MN4y4D08YKqjp6tBVSkBGaF0de6R0A==
X-Received: by 2002:a63:7c1d:: with SMTP id x29-v6mr1118841pgc.273.1539205257314;
        Wed, 10 Oct 2018 14:00:57 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s13-v6sm33482587pfj.105.2018.10.10.14.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:00:56 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:00:55 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181009225147.GD9307@redhat.com>
Message-ID: <alpine.DEB.2.21.1810101328550.231964@chino.kir.corp.google.com>
References: <20180925120326.24392-1-mhocko@kernel.org> <20180925120326.24392-2-mhocko@kernel.org> <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com> <20181005073854.GB6931@suse.de> <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
 <20181005232155.GA2298@redhat.com> <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <alpine.DEB.2.21.1810091424170.57306@chino.kir.corp.google.com> <20181009225147.GD9307@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018, Andrea Arcangeli wrote:

> On Tue, Oct 09, 2018 at 03:17:30PM -0700, David Rientjes wrote:
> > causes workloads to severely regress both in fault and access latency when 
> > we know that direct reclaim is unlikely to make direct compaction free an 
> > entire pageblock.  It's more likely than not that the reclaim was 
> > pointless and the allocation will still fail.
> 
> How do you know that? If all RAM is full of filesystem cache, but it's
> not heavily fragmented by slab or other unmovable objects, compaction
> will succeed every single time after reclaim frees 2M of cache like
> it's asked to do.
> 
> reclaim succeeds every time, compaction then succeeds every time.
> 
> Not doing reclaim after COMPACT_SKIPPED is returned simply makes
> compaction unable to compact memory once all nodes are filled by
> filesystem cache.
> 

For reclaim to assist memory compaction based on compaction's current 
implementation, it would require that the freeing scanner starting at the 
end of the zone can find these reclaimed pages as migration targets and 
that compaction will be able to utilize these migration targets to make an 
entire pageblock free.

In such low on memory conditions when a node is fully saturated, it is 
much less likely that memory compaction can free an entire pageblock even 
if the freeing scanner can find these now-free pages.  More likely is that 
we have unmovable pages in MIGRATE_MOVABLE pageblocks because the 
allocator allows fallback to pageblocks of other migratetypes to return 
node local memory (because affinity matters for kernel memory as it 
matters for thp) rather than fallback to remote memory.

This has caused us significant pain where we have 1.5GB of slab, for 
example, spread over 100GB of pageblocks once the node has become 
saturated.

So reclaim is not always "pointless" as you point out, but it should at 
least only be attempted if memory compaction could free an entire 
pageblock if it had free memory to migrate to.  It's much harder to make 
sure that these freed pages can be utilized by the freeing scanner.  Based 
on how memory compaction is implemented, I do not think any guarantee can 
be made that reclaim will ever be successful in allowing it to make 
order-9 memory available, unfortunately.

> > If memory compaction were patched such that it can report that it could 
> > successfully free a page of the specified order if there were free pages 
> > at the end of the zone it could migrate to, reclaim might be helpful.  But 
> > with the current implementation, I don't think that is reliably possible.  
> > These free pages could easily be skipped over by the migration scanner 
> > because of the presence of slab pages, for example, and unavailable to the 
> > freeing scanner.
> 
> Yes there's one case where reclaim is "pointless", but it happens once
> and then COMPACT_DEFERRED is returned and __GFP_NORETRY will skip
> reclaim then.
> 
> So you're right when we hit fragmentation there's one and only one
> "pointless" reclaim invocation. And immediately after we also
> exponentially backoff on the compaction invocations with the
> compaction deferred logic.
> 

This assumes that every time we get COMPACT_SKIPPED that if we can simply 
free memory that it'll succeed and that's definitely not the case based on 
the implementation of memory compaction: compaction_alloc() needs to find 
the memory and the migration scanner needs to free an entire pageblock.  
The migration scanner doesn't even look ahead to see if that's possible 
before starting to migrate pages, it's limited to COMPACT_CLUSTER_MAX.

The scenario we have: compaction returns COMPACT_SKIPPED; reclaim 
expensively tries to reclaim memory by thrashing the local node; the 
compaction migration scanner has already passed over the now-freed pages 
so it's inaccessible; if accessible, the migration scanner migrates memory 
to the newly freed pages but fails to make a pageblock free; loop.

My contention is that the second step is only justified if we can 
guarantee the freed memory can be useful for compaction and that it can 
free an entire pageblock for the hugepage if it can migrate.  Both of 
those are not possible to determine based on the current implementation.

> > I'd appreciate if Andrea can test this patch, have a rebuttal that we 
> > should still remove __GFP_THISNODE because we don't care about locality as 
> > much as forming a hugepage, we can make that change, and then merge this 
> > instead of causing such massive fault and access latencies.
> 
> I can certainly test, but from source review I'm already convinced
> it'll solve fine the "pathological THP allocation behavior", no
> argument about that. It's certainly better and more correct your patch
> than the current upstream (no security issues with lack of permissions
> for __GFP_THISNODE anymore either).
> 
> I expect your patch will run 100% equivalent to __GFP_COMPACT_ONLY
> alternative I posted, for our testcase that hit into the "pathological
> THP allocation behavior".
> 
> Your patch encodes __GFP_COMPACT_ONLY into the __GFP_NORETRY semantics
> and hardcodes the __GFP_COMPACT_ONLY for all orders = HPAGE_PMD_SIZE
> no matter which is the caller.
> 
> As opposed I let the caller choose and left __GFP_NORETRY semantics
> alone and orthogonal to the __GFP_COMPACT_ONLY semantics. I think
> letting the caller decide instead of hardcoding it for order 9 is
> better, because __GFP_COMPACT_ONLY made sense to be set only if
> __GFP_THISNODE was also set by the caller.
> 

I've hardcoded it directly for pageblock_order because compaction works 
over pageblocks and we lack the two crucial points of information I've 
stated that determines whether direct reclaim could possibly be useful.  
(It's more correctly implemented as order >= pageblock_order as opposed 
to order == pageblock_order.)

> If a driver does an order 9 allocation with __GFP_THISNODE not set,
> your patch will prevent it to allocate remote THP if all remote nodes
> are full of cache (which is a reasonable common assumption as more THP
> are allocated over time eating in all free memory).

Iff it's using __GFP_NORETRY, yes, the allocation and remote access 
latency that is incurred is the same as for thp.  Hugetlbfs doesn't use 
__GFP_NORETRY, it uses __GFP_RETRY_MAYFAIL, so it will attempt to reclaim 
memory after my patch.

My patch is assuming that a single call to reclaim followed up by another 
attempt at compaction is not beneficial for pageblock_order sized 
allocations with __GFP_NORETRY because it's unlikely to either free an 
entire pageblock and compaction may not be able to access this memory.  
It's based on how memory compaction is implemented rather than any special 
heuristic.

I won't argue if you protect this logic with __GFP_COMPACT_ONLY, but I 
think thp allocations should always have __GFP_NORETRY based on 
compaction's implementation.

I see removing __GFP_THISNODE as a separate discussion: if, after my patch 
(perhaps with a modification for __GFP_COMPACT_ONLY on top of it), you 
still get unacceptable fault latency and can show that remote access 
latency to remotely allocated hugepage is better on some platform that 
isn't Haswell, Naples, and Rome, we can address that but it will probably 
require more work that simply unsetting __GFP_THISNODE because it will 
depend on the latency to certain remote nodes over others.
