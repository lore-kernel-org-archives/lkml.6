Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1504FC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F592064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qh4C5JTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F592064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLJA3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:29:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41564 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLJA3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:29:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so4501074pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 16:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zmdKOnAe97IQjsjN+LZw0dQZYH9ZjtseI/M5pBXkouI=;
        b=Qh4C5JTgT90TKqncfhCcemqRvRglhJmY6tPR4ovt4GfIvC9snAABPeul41VHaErrrs
         QDcoKrgDGqbKgxeB50nghumb21u4PhXrjHbpew8F1F0OQ46sm+nYp3D46mwESQxzK4q0
         404v4QMeE7AoFiET8IKJfy4+LC5QfAK5VYRcOL4NkPf08aPGGc2G4ocxhGwRKUt9KLm3
         Hg8Uz+CxK7NBeflZMMgHYe4AmzXdHSh22x4dxhPYkGYPDj7d7S2SWtRm4qTJ6zFvTJId
         XqtclgE79F5beNBqgEGHfaHcI7EsUbnvz3PR7eNYqpEq7V72hSt8okQc8FgdVpwlWej8
         r0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zmdKOnAe97IQjsjN+LZw0dQZYH9ZjtseI/M5pBXkouI=;
        b=Ux22VWeRPqFf7UWDazW9PkVb5QZA26uHeNQtmzvhpykyT2Ac8AEahX7mXyqf0QKQUs
         YrgDx6FjIZe0BswBjJJzpSlG5pQq5h/qDX3p96oo0s0rRYVxYjbWMGgkLvGmm+HvlEPV
         YEJhqgWn3IAH0Uutvd6EM8B45aFyLfuPlsNEnaNGyi7D+pgOb3mxLS4CavFzinWbyWdo
         oI/lk5jq7n3Z/X/+GoX7n/2h3j/ld/lj4U4gf5F6/eiSrEk1Zenla224xgxg1IYWPVWk
         xQcCwsqimd6GqG5m16q+g7lW95ch4pNQUNkhiZQUWKRikvi58+1kvmwpHS7hhNa3Tw3P
         /reQ==
X-Gm-Message-State: AA+aEWYN0WbLTImLuHTu+XunuT53tPd9O1qJqZlICwwokNYPremejBGb
        PTIt8K1CAZVlTbS1XBugC4GN7Q==
X-Google-Smtp-Source: AFSGD/W/5jQVoL8KRsK+rAJatVKuhyhtEEIq30OYuJK7Y2hvl0LpKoQMQrFwQXqJEL4voWL7XyjbKQ==
X-Received: by 2002:a63:b17:: with SMTP id 23mr9145144pgl.423.1544401756635;
        Sun, 09 Dec 2018 16:29:16 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v9sm13588936pfg.144.2018.12.09.16.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 16:29:14 -0800 (PST)
Date:   Sun, 9 Dec 2018 16:29:13 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com> <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com> <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com> <20181205233632.GE11899@redhat.com> <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com> <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Linus Torvalds wrote:

> > On Broadwell, the access latency to local small pages was +5.6%, remote
> > hugepages +16.4%, and remote small pages +19.9%.
> >
> > On Naples, the access latency to local small pages was +4.9%, intrasocket
> > hugepages +10.5%, intrasocket small pages +19.6%, intersocket small pages
> > +26.6%, and intersocket hugepages +29.2%
> 
> Are those two last numbers transposed?
> 
> Or why would small page accesses be *faster* than hugepages for the
> intersocket case?
> 
> Of course, depending on testing, maybe the page itself was remote, but
> the page tables were random, and you happened to get a remote page
> table for the hugepage case?
> 

Yes, looks like that was the case, if the page tables were from the same 
node as the intersocket remote hugepage it looks like a ~0.1% increase 
accessing small pages, so basically unchanged.  So this complicates the 
allocation strategy somewhat; on this platform, at least, hugepages are 
preferred on the same socket but there isn't a significant benefit from 
getting a cross socket hugepage over small page.

The typical way this is resolved is based on the SLIT and how the kernel 
defines RECLAIM_DISTANCE.  I'm not sure that we can expect the distances 
between proximity domains to be defined according to this value for a 
one-size-fits-all solution.  I've always thought that RECLAIM_DISTANCE 
should be configurable so that initscripts can actually determine its 
ideal value when using vm.zone_reclaim_mode.

> > So it *appears* from the x86 platforms that NUMA matters much more
> > significantly than hugeness, but remote hugepages are a slight win over
> > remote small pages.  PPC appeared the same wrt the local node but then
> > prefers hugeness over affinity when it comes to remote pages.
> 
> I do think POWER at least historically has much weaker TLB fills, but
> also very costly page table creation/teardown. Constant-time O(1)
> arguments about hash lookups are only worth so much when the constant
> time is pretty big. They've been working on it.
> 
> So at least on POWER, afaik one issue is literally that hugepages made
> the hash setup and teardown situation much better.
> 

I'm still working on the more elaborate test case that will generate these 
results because I think I can use it at boot to determine an ideal 
RECLAIM_DISTANCE.  I can also get numbers for hash vs radix MMU if you're 
interested.

> One thing that might be worth looking at is whether the process itself
> is all that node-local. Maybe we could aim for a policy that says
> "prefer local memory, but if we notice that the accesses to this vma
> aren't all that local, then who cares?".
> 
> IOW, the default could be something more dynamic than just "always use
> __GFP_THISNODE". It could be more along the lines of "start off using
> __GFP_THISNODE, but for longer-lived processes that bounce around
> across nodes, maybe relax it?"
> 

It would allow the use of MPOL_PREFERRED for an exact preference if they 
are known to not be bounced around.  This would be required for processes 
that are bound to the cpus of a single node through cpuset or 
sched_setaffinity() but unconstrained as far as memory is concerned.

The goal of __GFP_THISNODE being the default for thp, however, is that we 
*know* we're going to be accessing it locally at least in the short term, 
perhaps forever.  Any other default would assume the remotely allocated 
hugepage would eventually be accessed locally, otherwise we would have 
been much better off just failing the hugepage allocation and accessing 
small pages.  You could make an assumption that's the case iff the process 
does not fit in its local node, and I think that would be the minority of 
applications.

I guess there could be some heuristic that could determine this based on 
MM_ANONPAGES of Andrea's qemu and zone->zone_pgdat->node_present_pages.  
It feels like something that should be more exactly defined, though, for 
the application to say that it prefers remote hugepages over local 
small pages because it can't access either locally forever anyway.

This was where I suggested a new prctl() mode so that an application can 
prefer remote hugepages because it knows it's larger than the single node 
and that requires no change to the binary itself because it is inherited 
across fork.

The sane default, though, seems to always prefer local allocation, whether 
hugepages or small pages, for the majority of workloads since that's where 
the lowest access latency is.

> Honestly, I think things like vm_policy etc should not be the solution
> - yes, some people may know *exactly* what access patterns they want,
> but for most situations, I think the policy should be that defaults
> "just work".
> 
> In fact, I wish even MADV_HUGEPAGE itself were to approach being a
> no-op with THP.
> 

Besides the NUMA locality of the allocations, we still have the allocation 
latency concern that MADV_HUGEPAGE changes.  The madvise mode has taken on 
two meanings: (1) prefer to fault hugepages when the thp enabled setting 
is "madvise" so other applications don't blow up their rss unexpectedly, 
and (2) try synchronous compaction/reclaim at fault for thp defrag 
settings of "madvise" or "defer+madvise".

 [ It was intended to take on an additional meaning through the 
   now-reverted patch, which was (3) relax the NUMA locality preference. ]

My binaries that remap their text segment to be backed by transparent 
hugepages and qemu both share the same preference to try hard to fault 
hugepages through compaction because we don't necessarily care about 
allocation latency, we care about access latency later.  Smaller binaries, 
those that do not have strict NUMA locality requirements, and short-lived 
allocations are not going to want to incur the performance penalty of 
synchronous compaction.

So I think today's semantics for MADV_HUGEPAGE make sense, but I'd like to 
explore other areas that could improve this, both for the default case and 
the specialized cases:

 - prctl() mode to readily allow remote allocations rather than reclaiming
   or compacting memory locally (affects more than just hugepages if the
   system has a non-zero vm.zone_reclaim_mode),

 - better feedback loop after the first compaction attempt in the page 
   allocator slowpath to determine if reclaim is actually worthwhile for
   high-order allocations, and

 - configurable vm.reclaim_distance (use RECLAIM_DISTANCE as the default)
   which can be defined since there is not a one-size-fits-all strategy
   for allocations (there's no benefit to allocating hugepages cross 
   socket on Naples, for example),
