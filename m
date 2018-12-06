Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B8420868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7QJYswt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B8420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLFXna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:43:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44298 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeLFXna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:43:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so897241pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9iTC4MSMNM5ocxFRzmCs5S80icsKc1V8lrU3rPMJn0g=;
        b=n7QJYswtDJ9X5M9kD0gxwjivObqy5Zd6JanLr5VrHWDpAPzPQL+d45AFOAGrWBFQwM
         UUCRqqZoKBs+WmMMU5ewGAcIQ/kRGKhpg2hYGWGOz6Q2k109A2Kzv3FrJ/sTwtB0E7jN
         +HVToVdoVWaKRsCF6Oj9aH59xYKaecmzjAmjcg83pVIs5kV+YsyTSEYfQ67BjEwmtbZU
         Ew08MP3uvy7AaC2sTClIyUnjX7MTSAVTjfCgqZUwLd9vhMTeJvB+03PdN+zawOuT4VDn
         U3NoYewqN0MMYHfqR5HoBpgG4BfyS4c8MiP8ODxhW80JAXxgjbjnwyzq5V8Av4bPIasn
         WYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9iTC4MSMNM5ocxFRzmCs5S80icsKc1V8lrU3rPMJn0g=;
        b=lAzXK4NGOcHVYbDtbFLJR8hGV+rcIcj8y6e2bR/q29JfHpEElBV28Ef9kiF+EmBZ2v
         jh5bzz/CzqtJ0vt02swDXsz4xDXu/f1oTJAfFiD/gfGhhKxMMOD4AVrTnfdM2/y14ihC
         jHMYF5T0BKSVqUAaUHUZbWIeboBhfOmnASygZrstKsm+5sVxeWcbdmH/IBz7PvJvgGGd
         01XEcjn2l6bWEYo35k6Gdxew1VokDVxzzax0qgiR6vjHDPJuI9xXUGhqZ3Ie5OP1Qwij
         jWem6Wn3SDGWvyL1Nl6qeg7i7G3VvGSOdAZ0E54QRRHEJCJYFiLD1Q+6xs+BcPOCxd5N
         /YUA==
X-Gm-Message-State: AA+aEWavCf9bmIGUPu1G2tFTZAv3Gy/KgEoU7GzoQ5jB3mO+ZCN3ijsU
        MkCDpDJcMWZXoBYvLYpW77In9g==
X-Google-Smtp-Source: AFSGD/V1hXpMz9VrDHYUgubl/b6SUzpYh6AQVbZVuLPb28+JSNrFaKr57ncTWPPT29tom2BpxFYyxw==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr30472929pli.271.1544139809076;
        Thu, 06 Dec 2018 15:43:29 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b9sm1905575pfi.118.2018.12.06.15.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:43:27 -0800 (PST)
Date:   Thu, 6 Dec 2018 15:43:26 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com> <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com> <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com> <20181205233632.GE11899@redhat.com> <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Linus Torvalds wrote:

> > Ok, I've applied David's latest patch.
> >
> > I'm not at all objecting to tweaking this further, I just didn't want
> > to have this regression stand.
> 
> Hmm. Can somebody (David?) also perhaps try to state what the
> different latency impacts end up being? I suspect it's been mentioned
> several times during the argument, but it would be nice to have a
> "going forward, this is what I care about" kind of setup for good
> default behavior.
> 

I'm in the process of writing a more complete test case for this but I 
benchmarked a few platforms based solely on remote hugepages vs local 
small pages vs remote hugepages.  My previous numbers were based on data 
from actual workloads.

For all platforms, local hugepages are the premium, of course.

On Broadwell, the access latency to local small pages was +5.6%, remote 
hugepages +16.4%, and remote small pages +19.9%.

On Naples, the access latency to local small pages was +4.9%, intrasocket 
hugepages +10.5%, intrasocket small pages +19.6%, intersocket small pages 
+26.6%, and intersocket hugepages +29.2%

The results on Murano were similar, which is why I suspect Aneesh 
introduced the __GFP_THISNODE requirement for thp in 4.0, which preferred, 
in order, local small pages, remote 1-hop hugepages, remote 2-hop 
hugepages, remote 1-hop small pages, remote 2-hop small pages.

So it *appears* from the x86 platforms that NUMA matters much more 
significantly than hugeness, but remote hugepages are a slight win over 
remote small pages.  PPC appeared the same wrt the local node but then 
prefers hugeness over affinity when it comes to remote pages.

Of course this could be much different on platforms I have not tested.  I 
can look at POWER9 but I suspect it will be similar to Murano.

> How much of the problem ends up being about the cost of compaction vs
> the cost of getting a remote node bigpage?
> 
> That would seem to be a fairly major issue, but __GFP_THISNODE affects
> both. It limits compaction to just this now, in addition to obviously
> limiting the allocation result.
> 
> I realize that we probably do want to just have explicit policies that
> do not exist right now, but what are (a) sane defaults, and (b) sane
> policies?
> 

The common case is that local node allocation, whether huge or small, is 
*always* better.  After that, I assume than some actual measurement of 
access latency at boot would be better than hardcoding a single policy in 
the page allocator for everybody.  On my x86 platforms, it's always a 
simple preference of "try huge, try small, go to the next nearest node, 
repeat".  On my PPC platforms, it's "try local huge, try local small, try 
huge from remaining nodes, try small from remaining nodes."

> For example, if we cannot get a hugepage on this node, but we *do* get
> a node-local small page, is the local memory advantage simply better
> than the possible TLB advantage?
> 
> Because if that's the case (at least commonly), then that in itself is
> a fairly good argument for "hugepage allocations should always be
> THISNODE".
> 
> But David also did mention the actual allocation overhead itself in
> the commit, and maybe the math is more "try to get a local hugepage,
> but if no such thing exists, see if you can get a remote hugepage
> _cheaply_".
> 
> So another model can be "do local-only compaction, but allow non-local
> allocation if the local node doesn't have anything". IOW, if other
> nodes have hugepages available, pick them up, but don't try to compact
> other nodes to do so?
> 

It would be nice if there was a specific policy that was optimal on all 
platforms; since that's not the case, introducing a sane default policy is 
going to require some complexity.

It would likely always make sense to allocate huge over small pages 
remotely when local allocation is not possible both for MADV_HUGEPAGE 
users and non-MADV_HUGEPAGE users.  That would require a restructuring of 
how thp fallback is done which, today, is try to allocate huge locally and 
fail so handle_pte_fault() can take it from there and would obviously 
touch more than just the page allocator.  I *suspect* that's not all that 
common because it's easier to reclaim some pages and fault local small 
pages instead, which always has better access latency.

What's different in this discussion thus far is workloads that do not fit 
into a single node so allocating remote hugepages is actually better than 
constantly reclaiming and compacting locally.  Mempolicies are 
interesting, but I worry about the interaction it would have with small 
page policies because you can only define one mode: we may have a 
combination of default, interleave, bind, and preferred policies for huge 
and small memory and that may become overly complex.

Since these workloads are in the minority and it seems, to me at least, 
that it's a property of the size of the workload rather than a general 
desire for remote hugepages over small pages for specific ranges of 
memory.

We already have prctl(PR_SET_THP_DISABLE) which was introduced by SGI and 
is inherited by child processes so that it's possible to disable hugepages 
for a process where you cannot modify the binary or rebuild it.  For this 
particular usecase, I'd suggest adding a new prctl() mode rather than any 
new madvise mode or mempolicy to prefer allocating remote hugepages as 
well because the workload cannot fit into a single node.

The implementation would be quite simple, add a new per-process 
PF_REMOTE_HUGEPAGE flag that is inherited across fork, and does not set 
__GFP_THISNODE in alloc_pages_vma() when faulting hugepages.  This would 
require no change to qemu or any other binary if the execing process sets 
it because it already *knows* the special requirements of that specific 
workload.  Andrea, would this work for you?

It also seems more extensible because prctl() modes can take arguments so 
you could specify the exact allocation policy for the workload to define 
whether it is willing to reclaim or compact from remote memory, for 
example, during fault to get a hugepage or whether it should truly be best 
effort.
