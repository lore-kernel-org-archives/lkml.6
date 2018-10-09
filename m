Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4FBC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D2214FF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEKt7ErQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1D2214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeJJFgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:36:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47043 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:36:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so1482384plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FoxGLEotG+WHmpWYmKOVHTQk0tH8wgWeOMb3ZR1uV/M=;
        b=PEKt7ErQQGABY0eeCHcBnO5ac6uas5FRV2zrRwAJ1S8CMPibr8UBb8nf8O47O3I36N
         9t+lKFWWlTbA14+rsv+mNhsarJa0sp0am4FZutIuxHaXp/QuyhyUSDi9mPzjKhZg9jcb
         7uyH27G9eahZ9JnERX7s0aPymGEJa9P2EbWYjEpQp1O3FMbB3BqoqWF7r3udJEHJpSg2
         RHwHQeP4mAK92laJDn1U2H4GIM48eauP5BIp+uNfj9TD0V0tRpoKv25GdOw5CwDvzkyA
         jsht+hvgGI0P9ClqFTQNHmDkjgMO448pokupzgh/tB9XJ78CyCmGfM54JUd01tG9RfB2
         HopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FoxGLEotG+WHmpWYmKOVHTQk0tH8wgWeOMb3ZR1uV/M=;
        b=LRtOCyggG9alomC75WEAIpmoAQTcdHBPkWDbhnvaKKqYL6Z7V8nV+QUE2QTwF0+693
         qoIOf/A6MxnEZ/KzBqvtrvkzqTovjJXPxX+HiTvq/0hQ4v8QHME7oTbvsAGRZl9ZKy7h
         cYTGlaRkroFmC/lKpj/eEriGI9XMDHUAN3Pga/IT+JON1ubAXjtzglQGWFrBUyMCUgMU
         ahuJFBYnltGJKrQ8Hv/U4/R1WZzqvapwr0LsO1WBCJk0MwXMyqKvg44T+t+33fANBBfy
         XlxBUzcmJMv41cDfB2kVUWKaBwvVxHbPUpQBtmzs9TsRqMsWmwkmp/1/xdgXPlAU95aH
         5d1g==
X-Gm-Message-State: ABuFfogVjDTHXuE+u/IPoGQI1TqTzGMSb5eHSlo/38In8W3XsE7EqN4V
        hNAkAXq1M+BInQqwS7qIGuM+XA==
X-Google-Smtp-Source: ACcGV62GvPNlUDK96ZeDLH73BueyZRxal5Iq7QXZZYF8WS7se7MKVRBbqFxQE4bvjpwuhdI7a7/nzA==
X-Received: by 2002:a17:902:bf48:: with SMTP id u8-v6mr30750653pls.254.1539123452032;
        Tue, 09 Oct 2018 15:17:32 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e3-v6sm29365386pgc.71.2018.10.09.15.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 15:17:31 -0700 (PDT)
Date:   Tue, 9 Oct 2018 15:17:30 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@suse.de>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
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
In-Reply-To: <20181009094825.GC6931@suse.de>
Message-ID: <alpine.DEB.2.21.1810091424170.57306@chino.kir.corp.google.com>
References: <20180925120326.24392-1-mhocko@kernel.org> <20180925120326.24392-2-mhocko@kernel.org> <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com> <20181005073854.GB6931@suse.de> <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
 <20181005232155.GA2298@redhat.com> <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018, Mel Gorman wrote:

> > The page allocator is expecting __GFP_NORETRY for thp allocations per its 
> > comment:
> > 
> > 		/*
> > 		 * Checks for costly allocations with __GFP_NORETRY, which
> > 		 * includes THP page fault allocations
> > 		 */
> > 		if (costly_order && (gfp_mask & __GFP_NORETRY)) {
> > 
> > And that enables us to check compact_result to determine whether thp 
> > allocation should fail or continue to reclaim.  I don't think it helps 
> > that some thp fault allocations use __GFP_NORETRY and others do not.  I 
> > think that deserves a fix to alloc_hugepage_direct_gfpmask() or 
> > GFP_TRANSHUGE_LIGHT.
> > 
> 
> I am concerned that we may be trying to deal with this in terms of right
> and wrong when the range of workloads and their preferred semantics
> force us into a grey area.
> 
> The THP user without __GFP_NORETRY is "always"
> 
> always
>         means that an application requesting THP will stall on
>         allocation failure and directly reclaim pages and compact
>         memory in an effort to allocate a THP immediately. This may be
>         desirable for virtual machines that benefit heavily from THP
>         use and are willing to delay the VM start to utilise them.
> 

I'm not sure what you mean when you say the thp user without __GFP_NORETRY 
is "always".  If you're referring to the defrag mode "always", 
__GFP_NORETRY is only possible for non-madvised memory regions.  All other 
defrag modes exclude it, and I argue they incorrectly exclude it.

I believe the userspace expectation, whether it is described well or not, 
is that defrag mode "always" simply gets the same behavior for defrag mode 
"madvise" but for everybody, not just MADV_HUGEPAGE regions.  Then, 
"defer+madvise" triggers kswapd/kcompactd but compacts for MADV_HUGEPAGE, 
"defer" triggers kswapd/compactd and fails, and "never" fails.  This, to 
me, seems like the most sane heuristic.

Whether reclaim is helpful or not is what I'm questioning, I don't think 
that it benefits any user to have strict adherence to a documentation that 
causes workloads to severely regress both in fault and access latency when 
we know that direct reclaim is unlikely to make direct compaction free an 
entire pageblock.  It's more likely than not that the reclaim was 
pointless and the allocation will still fail.

If memory compaction were patched such that it can report that it could 
successfully free a page of the specified order if there were free pages 
at the end of the zone it could migrate to, reclaim might be helpful.  But 
with the current implementation, I don't think that is reliably possible.  
These free pages could easily be skipped over by the migration scanner 
because of the presence of slab pages, for example, and unavailable to the 
freeing scanner.

> Removing __GFP_NORETRY in this instance is due to the tuning hinting that
> direct reclaim is prefectly acceptable. __GFP_NORETRY means that the kernel
> will not compact memory after a recent failure but if the caller is willing
> to reclaim memory, then it follows that retrying compaction is justified.
> 
> Is this the correct thing to do in 100% of cases? Probably not, there
> will be corner cases but it also does not necessarily follow that
> __GFP_NORETRY should be univeral.
> 

For reclaim to be useful, I believe we need a major rewrite of memory 
compaction such that the freeing scanner is eliminated and it can benefit 
from memory passed over by the migration scanner.  In this case, it would 
require the freeing scanner to do the actual reclaim itself.  I don't 
believe it is beneficial to any user that we reclaim memory from the zone 
when we don't know (1) that the migration scanner will eventually be able 
to free an entire pageblock, (2) the reclaimed memory can be accessed by 
the freeing scanner as a migration target, and (3) all this synchronous 
work was not done on behalf of a user only to lose the hugepage to a 
concurrent allocator that is not even madvised.

Since we lack all of this in the allocator/compaction/reclaim, it seems 
that the painful fault latency here can be corrected by doing what is 
actually useful, memory compaction, and rely on its heuristics of when to 
give up and when to proceed rather than thrash the zone.  The insane fault 
latency being reported here is certainly not what the user is asking for 
when it does MADV_HUGEPAGE, and removing __GFP_THISNODE doesn't help in 
any way if remote memory is fragmented or low on memory as well.

> What is missing here is an agreed upon set of reference test cases
> that can be used for the basis of evaluating patches like this. They
> should be somewhat representative of the target applications of virtual
> memory initialisation (forget about runtime at the moment as that is
> stacking problems), a simulator of the google workload and library and
> my test case of simply referencing an amount of memory larger than one
> node. That would cover the current discussion at least but more would be
> needed later. Otherwise we're going to endlessly whack-a-mole fixing one
> workload and hurting another. It might be overkill but otherwise this
> discussion risks going in circles.
> 

Considering only fault latency, it's relatively trivial to fragment all 
zones and then measure the time it takes to start your workload.  This is 
where the 40% regression I reported came from.  Having tons of memory free 
remotely yet having the local node under such strenuous memory pressure 
that compaction cannot even find free pages isn't a healthy balance.  
Perhaps we do not fault remote memory as easily because there is not an 
imbalance.

My criticism is obviously based on the fault and access latency 
regressions that this introduces but is also focused on what makes sense 
for the current implementation of the page allocator, memory compaction, 
and direct reclaim.  I know that direct reclaim is these contexts will 
very, very seldom help memory compaction because it requires strenuous 
memory pressure (otherwise compaction would have tried and failed to 
defrag memory for other reasons) and under those situations we have data 
that shows slab fragmentation is much more likely to occur such that 
compaction will never be successful.  Situations where a node has 1.5GB of 
slab yet 100GB of pageblocks have 1+ slab pages because the allocator 
prefers to return node local memory at the cost of fragmenting 
MIGRATE_MOVABLE pageblocks.

I really think that for this patch to be merged over my proposed change 
that it needs to be clearly demonstrated that reclaim was successful in 
that it freed memory that was subsequently available to the compaction 
freeing scanner and that enabled entire pageblocks to become free.  That, 
in my experience, will very very seldom be successful because of internal 
slab fragmentation, compaction_alloc() cannot soak up pages from the 
reclaimed memory, and potentially thrash the zone completely pointlessly.  
The last point is the problem being reported here, but the other two are 
as legitimate.

> Which is better?
> 
> locality is more important if your workload fits in memory and the
> 	initialisation phase is not performance-critical. It would
> 	also be more important if your workload is larger than a
> 	node but the critical working set fits within a node while
> 	the other usages are like streaming readers and writers where
> 	the data is referenced once and can be safely reclaimed later.
> huge pages is more important if your workload is virtualised and
> 	benefits heavily due to reduced TLB cost from EPT.
> 	Similarly it's better if the workload has high special locality,
> 	particularly if it is also fitting within a cache where the
> 	remote cost is masked.
> 
> These are simple examples and even then we cannot detect which case
> applies in advance so it falls back to what does the hint mean? The name
> suggests that huge pages are desirable and the locality is a hint. Granted,
> if that means THP is going remote and incurring cost there, it might be
> worse overall for some workloads, particularly if the system is fragmented.
> 
> This goes back to my point that the MADV_HUGEPAGE hint should not make
> promises about locality and that introducing MADV_LOCAL for specialised
> libraries may be more appropriate with the initial semantic being how it
> treats MADV_HUGEPAGE regions.
> 

Forget locality, the patch incurs a 40% fault regression when remote 
memory is fragmented as well.  Thrashing the local node will begin to 
thrash the remote nodes as well if they are balanced and fragmented in the 
same way.  This cannot possibly be in the best interest of the user.  What 
is in the best interest of the user is what can actually be gained by 
incurring that latency.

We talked about a "privileged" madvise mode that is even stronger with 
regard to locality before, which I don't think is needed.  If you have 
the privilege you could always use drop_caches, explicitly trigger 
MIGRATE_SYNC compaction yourself, speedup khugepaged in that background 
temporarily, etc. 

You could build upon my patch and say that compaction is beneficial, but 
we can still remove __GFP_THISNODE to get remote hugepages.  But let us 
please focus on the role that reclaim has when allocating a hugepage 
coupled with the implementation of the page allocator.

When a user reports this 40% fault latency and 13.9% access latency 
regressions if this patch is merged, what is the suggested fix?  Wait for 
another madvise mode and then patch your binary, assuming you can modify 
the source, and then ask for a privilege so it can stress reclaim locally?

> What you're asking for asking is an astonishing amount of work --
> a multi platform study against a wide variety of workloads with the
> addition that some test should be able to start in a fragmented state
> that is reproducible.
> 

No, I'm asking that you show in the implementation of the page allocator, 
memory compaction, and direct reclaim why the work done by reclaim (the 
zone thrashing and swapping) is proven beneficial that it leads to the 
allocation of a hugepage.  I'm not a fan of thrashing a zone pointlessly 
because we think the compaction freeing scanner may be able to allocate 
and the migration scanner may then suddenly free an entire pageblock.  If 
that feedback loop can be provided, reclaim sounds worthwhile.  Until 
then, we can't do such pointless work.

> What is being asked of you is to consider introducing a new madvise hint and
> having MADV_HUGEPAGE being about huge pages and introducing a new hint that
> is hinting about locality without the strictness of memory binding. That
> is significantly more tractable and you also presumably have access to
> a reasonable reproduction cases even though I doubt you can release it.
> 

We continue to talk about the role of __GFP_THISNODE.  The Andrea patch is 
obviously premised on the idea that for some reason remote memory is much 
less fragmented or not under memory pressure.  If the nodes are actually 
balanced, you've incurred a 40% fault latency absolutely and completely 
pointlessly.  What I'm focusing on is the role of reclaim, not 
__GFP_THISNODE.  Let's fix the issue being reported and look at the 
implementation of memory compaction to understand why it is happening: 
reclaim very very seldom can assist memory compaction in making a 
pageblock free under these conditions.  It's not beneficial and should not 
be done.

> > > Like Mel said, your app just happens to fit in a local node, if the
> > > user of the lib is slightly different and allocates 16G on a system
> > > where each node is 4G, the post-fix MADV_HUGEPAGE will perform
> > > extremely better also for the lib user.
> > > 
> > 
> > It won't if the remote memory is fragmented; the patch is premised on the 
> > argument that remote memory is never fragmented or under memory pressure 
> > otherwise it is multiplying the fault latency by the number of nodes.  
> > Sure, creating test cases where the local node is under heavy memory 
> > pressure yet remote nodes are mostly free will minimize the impact this 
> > has on fault latency.  It still is a substantial increase, as I've 
> > measured on Haswell, but the access latency forever is the penalty.  This 
> > patch cannot make access to remote memory faster.
> > 
> 
> Indeed not but remote costs are highly platform dependant so decisions
> made for haswell are not necessarily justified on EPYC or any later Intel
> processor either.

I'm reporting regressions for the Andrea patch on Haswell, Naples, and 
Rome.  If you have numbers for any platform that suggests remote huge 
memory (and of course there's no consideration of NUMA distance here, so 
2-hop would be allowed as well by this patch) is beneficial over local 
native pages, please present it.

> Because these goalposts will keep changing, I think
> it's better to have more clearly defined madvise hints and rely less on
> implementation details that are subject to change. Otherwise we will get
> stuck in an endless debate about "is workload X more important than Y"?
> 

The clearly defined madvise is not helpful if it causes massive thrashing 
of *any* zone on the system and cannot enable memory compaction to 
directly make a hugepage available.  In other words, show that I didn't 
just reclaim 60GB of memory that still causes compaction to fail to free a 
pageblock, which is precisely what happens today, either because slab 
fragmentation as the result of the memory pressure that we are under or 
because it is inaccessible to the freeing scanner.

> I don't think it's necessarily bad but it cannot distinguish between
> THP and hugetlbfs. Hugetlbfs users are typically more willing to accept
> high overheads as they may be required for the application to function.
> That's probably fixable but will still leave us in the state where
> MADV_HUGEPAGE is also a hint about locality. It'd still be interesting
> to hear if it fixes the VM initialisation issue but do note that if this
> patch is used as a replacement that hugetlbfs users may complain down
> the line.
> 

Hugetlb memory is allocated round-robin over the set of allowed nodes with 
__GFP_THISNODE so it will already result in this thrashing problem that is 
being reported with the very unlikely possibility that reclaim has helped 
us allocate a hugepage.

And this does distinguish between thp memory and hugetlb memory, thp is 
explicitly allocated here with __GFP_NORETRY, which controls the goto 
nopage, and hugetlb memory is allocated with __GFP_RETRY_MAYFAIL.
 
I'd hate to add a gfp flag unnecessarily for this since we're talking 
about the role of reclaim in assisting memory compaction to make a 
high-order page available.  That is clearly defined in my patch to be 
based on __GFP_NORETRY.

I'd appreciate if Andrea can test this patch, have a rebuttal that we 
should still remove __GFP_THISNODE because we don't care about locality as 
much as forming a hugepage, we can make that change, and then merge this 
instead of causing such massive fault and access latencies.
