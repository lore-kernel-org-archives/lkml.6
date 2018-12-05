Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C76C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F020879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYFv4cCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43F020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeLEV7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:59:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38574 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeLEV7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:59:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so10672973pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2baRLc9Lla8EgyOI76XxTXH/K9OcFRrl7TyETyl5sNo=;
        b=HYFv4cCOaI59c5/+3aofiTl1kGtUUlW3lgm0XgWmMWLX8i6WUckFvDTXqrcrAoc0iR
         mUi823U096bNJRPCWN03bL0gKFBwEok2SypfofjqlMG0RI7UbxudfTPWBploNPcObGa1
         i3oZyQzsX2CFv/5W7ZPSP1lP91yBsEQaWM2rU4TJedTEuZMLjiCKGmYw4XTLTy1Z7zKE
         KfWWAl6mbyu2gsb/PyHwr3D/IgB5or7aEnhnFqBkc7NgmbkQGoAnoxuzDZl+p06b0Mp3
         DwNAXHqnptkFogaKdfp4+EflR8ef8uqJbhap5JMSZXvpqut8SVIRmbF5bENFWQspWU2/
         lr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2baRLc9Lla8EgyOI76XxTXH/K9OcFRrl7TyETyl5sNo=;
        b=frJvNgHvjmqPtwAqy62+Ux05mKZX2m7YM1kTUnNkjGnUZpkLMRm4d43n/rRKyNAezV
         sEyygy7rA2O2FGXYKXfjSYaFvmOcDgIeLUM5XI0aRo2Uw1gFShBo3RsTtCzkzpLzjN4y
         qhSgcxzotX7x17B6dwEyuIxxArrtFD3pxbS8Wa5FoYZoX1VaVS7dK2Wtsgir5RdKWCU6
         gTv/naige4Bd+dh1UzpdA1Z0H66HDN9spvmXWhYZL0s1OL039zcwHWwL/TQTtnZ5DFQL
         uScUaYkH9ccpw2qIXiqjVVw66ouvJN7Ot9Gmtw7v7kUfJEPqqYfcbIx1sllzge9R6ZWT
         a5aQ==
X-Gm-Message-State: AA+aEWZUQ23j8Trq2Z4kcjjdc9H+5JxCUV2vNaGsdxlLlaXfUdawAC9S
        /8alK3uRf/GJeQtK3jJvNiqOEQ==
X-Google-Smtp-Source: AFSGD/UIma2mqMQVkFBnDZ3jZ43XS5N0dQSW5Nve4WsM7AoNDX1kTzYA4WIDq0qqdQVijaBPv5/31Q==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr14089871pfd.56.1544047174121;
        Wed, 05 Dec 2018 13:59:34 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f20sm14533571pfn.177.2018.12.05.13.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 13:59:33 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:59:32 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181205204034.GB11899@redhat.com>
Message-ID: <alpine.DEB.2.21.1812051316150.9633@chino.kir.corp.google.com>
References: <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com> <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Andrea Arcangeli wrote:

> > thpscale Percentage Faults Huge
> >                                4.20.0-rc4             4.20.0-rc4
> >                            mmots-20181130       gfpthisnode-v1r1
> > Percentage huge-3        95.14 (   0.00%)        7.94 ( -91.65%)
> > Percentage huge-5        91.28 (   0.00%)        5.00 ( -94.52%)
> > Percentage huge-7        86.87 (   0.00%)        9.36 ( -89.22%)
> > Percentage huge-12       83.36 (   0.00%)       21.03 ( -74.78%)
> > Percentage huge-18       83.04 (   0.00%)       30.73 ( -63.00%)
> > Percentage huge-24       83.74 (   0.00%)       27.47 ( -67.20%)
> > Percentage huge-30       83.66 (   0.00%)       31.85 ( -61.93%)
> > Percentage huge-32       83.89 (   0.00%)       29.09 ( -65.32%)
> > 
> > They're down the toilet. 3 threads are able to get 95% of the requested
> > THP pages with Andrews tree as of Nov 30th. David's patch drops that to
> > 8% success rate.
> 
> This is the downside of David's patch very well exposed above. And
> this will make non-NUMA system regress like above too despite they
> have no issue to begin with (which is probably why nobody noticed the
> trouble with __GFP_THISNODE reclaim until recently, combined with the
> fact most workloads can fit in a single NUMA node).
> 
> So we're effectively crippling down MADV_HUGEPAGE effectiveness on
> non-NUMA (where it cannot help to do so) and on NUMA (as a workaround
> for the false positive swapout storms) because in some workload and
> system THP improvements are less significant than NUMA improvements.
> 

For context, you're referring to the patch I posted that is similar to 
__GFP_COMPACT_ONLY and patch 2/2 in my series.  It's not referring to the 
revert of the 4.20-rc commit that relaxes the __GFP_THISNODE restriction 
on thp faults and conflates MADV_HUGEPAGE with NUMA locality.  For 4.20, I 
believe at minimum that patch 1/2 should be merged to restore what we have 
had for three years, stop piling more semantics on top of the intent (or 
perceived intent) of MADV_HUGEPAGE, and address the swap storm issue 
separately.

> The higher fault latency is generally the higher cost you pay to get
> the good initial THP utilization for apps that do long lived
> allocations and in turn can use MADV_HUGEPAGE without downsides. The
> cost of compaction pays off over time.
> 
> Short lived allocations sensitive to the allocation latency should not
> use MADV_HUGEPAGE in the first place. If you don't want high latency
> you shouldn't use MADV_HUGEPAGE and khugepaged already uses
> __GFP_THISNODE but it replaces memory so it has a neutral memory
> footprint at it, so it's ok with regard to reclaim.
> 

Completely agreed, and is why we want to try synchronous memory compaction 
to try to allocate hugepages locally in our usecases as well.  We aren't 
particularly concerned about the allocation latency, that is secondary to 
the long-lived access latency regression that occurs when you do not set 
__GFP_THISNODE.

> In my view David's workload is the outlier that uses MADV_HUGEPAGE but
> pretends a low latency and NUMA local behavior as first priority. If
> your workload fits in the per-socket CPU cache it doesn't matter which
> node it is but it totally matters if you've 2M or 4k tlb. I'm not even
> talking about KVM where THP has a multipler effect with EPT.
> 

Hm, no, we do not mind the high allocation latency for MADV_HUGEPAGE 
users.  We *do* care about access latency and that is due to NUMA 
locality.  Before commit ac5b2c18911f ("mm: thp: relax __GFP_THISNODE for 
MADV_HUGEPAGE mappings"), *all* thp faults were done with __GFP_THISNODE 
and had been for at least three years.  That commit conflates 
MADV_HUGEPAGE with a new semantic that it allows remote allocation instead 
of what it has done for three years: try harder synchronously to allocate 
hugepages locally.  We obviously need to address the problem in another 
way and not change long-standing behavior that causes regressions.  Either 
my patch 2/2, __GFP_COMPACT_ONLY, a new mempolicy mode, new madvise mode, 
prctl, etc.

> Even if you make the __GFP_NORETRY change for the HPAGE_PMD_ORDER to
> skip reclaim in David's patch conditional NUMA being enabled in the
> host (so that it won't cripple THP utilization also on non-NUMA
> systems), imagine that you go in the bios, turn off interleaving to
> enable host NUMA and THP utilization unexpectedly drops significantly
> for your VM.
> 

What's needed is appropriate feedback from memory compaction to determine 
if reclaim is worthwhile: checking only COMPACT_DEFERRED is insufficient.  
We need to determine if compaction has failed due to order-0 low watermark 
checks or whether it simply failed to defragment memory so a hugepage 
could be allocated.  Determining if compaction has failed due to order-0 
low watermark checks is harder than it seems because the reclaimed memory 
may not be accessible by isolate_freepages(); we don't have the ability to 
only reclaim memory from the end of the zone.  Otherwise, reclaim is very 
unlikely to help.

> Rome ryzen architecture has been mentioned several times by David but
> in my threadripper (not-Rome, as it's supposed to be available in 2019
> only AFIK) enabling THP made a measurable difference for me for some
> workloads. As opposed if I turn off NUMA by setting up the
> interleaving in the dimm I get a barely measurable slowdown. So I'm
> surprised in Rome there's such a radical difference in behavior.
> 

We can compare Naples if that's better; accessing remote hugepages over 
local pages of the native page size incurs a 13.8% latency increase 
intrasocket and 38.9% latency increase intersocket.  Accessing remote 
hugepages over remote pages of the native page size is 2.2% better 
intrasocket and unchanged intersocket.

> Like Mel said we need to work towards a more complete solution than
> putting __GFP_THISNODE from the outside and then turning off reclaim
> from the inside. Mel made examples of things that should
> happen, that won't increase allocation latency and that can't happen
> with __GFP_THISNODE.
> 
> I'll try to describe again what's going on:
> 
> 1: The allocator is being asked through __GFP_THISNODE "ignore all
> remote nodes for all reclaim and compaction" from the
> outside. Compaction then returns COMPACT_SKIPPED and tells the
> allocator "I can generate many more huge pages if you reclaim/swapout
> 2M of anon memory in this node, the only reason I failed to compact
> memory is because there aren't enough 4k fragmented pages free in this
> zone". The allocator then goes ahead and swaps 2M and invokes
> compaction again that succeeds the order 9 allocation fine. Goto 1;
> 
> The above keeps running in a loop at every additional page fault of
> the app using MADV_HUGEPAGE until all RAM of the node is swapped out
> and replaced by THP and all others nodes had 100% free memory,
> potentially 100% order 9, but the allocator completely ignored all
> other nodes. That is the thing that we're fixing here, because such
> swap storms caused massive slowdowns. If the workload can't fit in a
> single node, it's like running with only a fraction of the RAM.
> 
> So David's patch (and __GFP_COMPACT_ONLY) to fix the above swap storm,
> inside the allocator skips reclaim entirely when compaction tells "I
> can generate one more HPAGE_PMD_ORDER compound page if you
> reclaim/swap 2M", if __GFP_NORETRY is set (and makes sure
> __GFP_NORETRY is always set for THP). And that however prevents to
> generate any more THP globally the moment any node is full of
> filesystem cache.
> 
> NOTE: the filesystem cache will still be shrunk but it'll be shrunk by
> 4k allocations only. So we just artificially cripple compaction with
> David's patch as shown in the quoted results above. This applied to
> __GFP_COMPACT_ONLY too and that's I always said there's lots of margin
> for improvement there and even __GFP_COMPACT_ONLY was also a stop-gap
> measure.
> 

Right, this is all the same as __GFP_COMPACT_ONLY which implicitly set 
__GFP_NORETRY as part of the gfp flag itself.

> So ultimately we decided that the saner behavior that gives the least
> risk of regression for the short term, until we can do something
> better, was the one that is already applied upstream.
> 
> Of course David's workload regressed, but that's because it gets a
> minuscle improvement from THP, maybe it's seeking across all RAM and
> it's very RAM heavy bandwidth-heavy workload so 4k or 2m tlb don't
> matter at all for his workload and probably he's running it on bare
> metal only.
> 
> I think the challenge here is to get David's workload optimally
> without creating the above regression but we don't have a way to do it
> right now in an automatic way. It's trivial however to add a mbind new
> MPOL_THISNODE or MPOL_THISNODE_THP policy to force THP to set
> __GFP_THISNODE and return to the swap storm behavior that needle to
> say may have worked best by practically partioning the system, in fact
> you may want to use __GFP_THISNODE for 4k allocations too so you
> invoke reclaim from the local node before allocating RAM from the
> remote nodes.
> 

I'm not sure why we'd be changing the default behavior of three years that 
causes reported regressions instead of introducing a mempolicy that allows 
for the remote allocation.

This commit from 4.0:

commit 077fcf116c8c2bd7ee9487b645aa3b50368db7e1
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Feb 11 15:27:12 2015 -0800

    mm/thp: allocate transparent hugepages on local node
    
    This make sure that we try to allocate hugepages from local node if
    allowed by mempolicy.  If we can't, we fallback to small page allocation
    based on mempolicy.  This is based on the observation that allocating
    pages on local node is more beneficial than allocating hugepages on remote
    node.
    
    With this patch applied we may find transparent huge page allocation
    failures if the current node doesn't have enough freee hugepages.  Before
    this patch such failures result in us retrying the allocation on other
    nodes in the numa node mask.

    [akpm@linux-foundation.org: fix comment, add CONFIG_TRANSPARENT_HUGEPAGE dependency]
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Acked-by: Vlastimil Babka <vbabka@suse.cz>
    Cc: David Rientjes <rientjes@google.com>
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Is still needed, and the reason why I'm requesting we maintain that 
behavior of nearly four years and not conflate MADV_HUGEPAGE any more than 
it already is.

> To me it doesn't seem the requirements of David's workload are the
> same as for other MADV_HUGEPAGE users, I can't image other
> MADV_HUGEPAGE users not to care at all if the THP utilization drops,
> for David it seems THP is a nice thing to have only, and it seems to
> care about allocation latency too (which normal apps using
> MADV_HUGEPAGE must not).
> 

I have repeatedly said that allocation latency is secondary to the access 
latency regression that not setting __GFP_THISNODE causes with a 
fragmented local node on all of our platforms.

> In any case David's patch is better than reverting the revert, as the
> swap storms are a showstopper compared to crippling down compaction
> ability to compact memory when all nodes are full of cache.
> 

I'm going to propose a v2 of my two patch series, including the feedback 
from Michal in the first.  I suggest the first step is to restore the 
behavior we have had for three years to prevent the regression I'm 
reporting and the kernel test robot has reported, and then look to 
improvements that can be made to prevent local thrashing for users who 
would rather allocate remote hugepages (and perhaps incur the access 
latency issues if their workload does not span multiple nodes) instead of 
trying harder to allocate locally.
