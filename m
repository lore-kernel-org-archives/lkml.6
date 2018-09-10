Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065B5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5viEbQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CE920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeIKBEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:04:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38900 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeIKBEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:04:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so10235401plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=651PR9ZL5xiLPK4ySq3rGQHgOJ3qmCuv0HgECVK+lOk=;
        b=W5viEbQtrK+B2+2LGev2yFRjhEVwIVPHPOYsFl9AD30X+wu2en+Em2RIgPOY6NFs8e
         2dNYci8zqibsdX+TLXbH+OMYop4GjzAt5z4lYtVJE4RlrmlW4eyMXvRmvvORV/PXk3Fk
         8F/0KaVuf24NhJ/uml+6RnQNMBmsrZ6cntJzhnO4GVYQsQkwS23hM+MQ8lb+pbIJaf8V
         lOIGt07dDpcb9xa83vV2dv6bYkRSfP6qyKwtZ8ksUq90eV4kznb7r0100KVLK6Rlw9PN
         li5fPqUrBjqenPE+gRJQyA6e74uNlOh6j4W4CVrqG4pENM5H7TuwSMxAXIeO5+TWV47D
         kOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=651PR9ZL5xiLPK4ySq3rGQHgOJ3qmCuv0HgECVK+lOk=;
        b=LfKfSvgy/fVJvB9r88R0D/K8fWVQSS0uCd7XzHU48bWSfbG3iMqyJ/RfBR23R8pAKd
         SdTiHCarBefxA2Hhx1wpfaC90ogWVHvL3j6LzTIpQV4UfRzvfEAaKDBeh9VCFfL51GXY
         Nlvg5VFGKHcAhuN2nMhdwGRkcK69NNAz7eE/gpYTXPlF9KnZJ9++7MyNsOK+HmcC/C8u
         hVHeZirireP368aMplIPFgfI2JcTPUdVoD/zcuCoaQBrpDiuDXhhOIeKPHo0VfAv0vjr
         Bm1Ezaf4CpHtZEjNUAKXXOE26HoVjbf/AlO09Ii9T7I2K+ZgdpmjqnZWNAAN7Bg0fzsP
         +1Gg==
X-Gm-Message-State: APzg51CxDPJ24zyeHE0o++f+B9hxcNgNX72+tbYeWWbv08S2KPGyUpog
        JCcSD3rebWs4V+wRgFRBIVbwyQ==
X-Google-Smtp-Source: ANB0VdbACA5emaOXq7qJYM/QfRod+p+SXJSACQZaqb3nHaVEGU2FtvPBS3Y3/+ke7IEV2A5RVSKc/g==
X-Received: by 2002:a17:902:c7:: with SMTP id a65-v6mr23375608pla.264.1536610116402;
        Mon, 10 Sep 2018 13:08:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u83-v6sm51064364pfj.37.2018.09.10.13.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:08:35 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:08:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20180907130550.11885-1-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com>
References: <20180907130550.11885-1-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> Andrea has noticed [1] that a THP allocation might be really disruptive
> when allocated on NUMA system with the local node full or hard to
> reclaim. Stefan has posted an allocation stall report on 4.12 based
> SLES kernel which suggests the same issue:
> [245513.362669] kvm: page allocation stalls for 194572ms, order:9, mode:0x4740ca(__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_THISNODE|__GFP_MOVABLE|__GFP_DIRECT_RECLAIM), nodemask=(null)
> [245513.363983] kvm cpuset=/ mems_allowed=0-1
> [245513.364604] CPU: 10 PID: 84752 Comm: kvm Tainted: G        W 4.12.0+98-ph <a href="/view.php?id=1" title="[geschlossen] Integration Ramdisk" class="resolved">0000001</a> SLE15 (unreleased)
> [245513.365258] Hardware name: Supermicro SYS-1029P-WTRT/X11DDW-NT, BIOS 2.0 12/05/2017
> [245513.365905] Call Trace:
> [245513.366535]  dump_stack+0x5c/0x84
> [245513.367148]  warn_alloc+0xe0/0x180
> [245513.367769]  __alloc_pages_slowpath+0x820/0xc90
> [245513.368406]  ? __slab_free+0xa9/0x2f0
> [245513.369048]  ? __slab_free+0xa9/0x2f0
> [245513.369671]  __alloc_pages_nodemask+0x1cc/0x210
> [245513.370300]  alloc_pages_vma+0x1e5/0x280
> [245513.370921]  do_huge_pmd_wp_page+0x83f/0xf00
> [245513.371554]  ? set_huge_zero_page.isra.52.part.53+0x9b/0xb0
> [245513.372184]  ? do_huge_pmd_anonymous_page+0x631/0x6d0
> [245513.372812]  __handle_mm_fault+0x93d/0x1060
> [245513.373439]  handle_mm_fault+0xc6/0x1b0
> [245513.374042]  __do_page_fault+0x230/0x430
> [245513.374679]  ? get_vtime_delta+0x13/0xb0
> [245513.375411]  do_page_fault+0x2a/0x70
> [245513.376145]  ? page_fault+0x65/0x80
> [245513.376882]  page_fault+0x7b/0x80

Since we don't have __GFP_REPEAT, this suggests that 
__alloc_pages_direct_compact() took >100s to complete.  The memory 
capacity of the system isn't shown, but I assume it's around 768GB?  This 
should be with COMPACT_PRIO_ASYNC, and MIGRATE_ASYNC compaction certainly 
should abort much earlier.

> [...]
> [245513.382056] Mem-Info:
> [245513.382634] active_anon:126315487 inactive_anon:1612476 isolated_anon:5
>                  active_file:60183 inactive_file:245285 isolated_file:0
>                  unevictable:15657 dirty:286 writeback:1 unstable:0
>                  slab_reclaimable:75543 slab_unreclaimable:2509111
>                  mapped:81814 shmem:31764 pagetables:370616 bounce:0
>                  free:32294031 free_pcp:6233 free_cma:0
> [245513.386615] Node 0 active_anon:254680388kB inactive_anon:1112760kB active_file:240648kB inactive_file:981168kB unevictable:13368kB isolated(anon):0kB isolated(file):0kB mapped:280240kB dirty:1144kB writeback:0kB shmem:95832kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 81225728kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> [245513.388650] Node 1 active_anon:250583072kB inactive_anon:5337144kB active_file:84kB inactive_file:0kB unevictable:49260kB isolated(anon):20kB isolated(file):0kB mapped:47016kB dirty:0kB writeback:4kB shmem:31224kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 31897600kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> 
> The defrag mode is "madvise" and from the above report it is clear that
> the THP has been allocated for MADV_HUGEPAGA vma.
> 
> Andrea has identified that the main source of the problem is
> __GFP_THISNODE usage:
> 
> : The problem is that direct compaction combined with the NUMA
> : __GFP_THISNODE logic in mempolicy.c is telling reclaim to swap very
> : hard the local node, instead of failing the allocation if there's no
> : THP available in the local node.
> :
> : Such logic was ok until __GFP_THISNODE was added to the THP allocation
> : path even with MPOL_DEFAULT.
> :
> : The idea behind the __GFP_THISNODE addition, is that it is better to
> : provide local memory in PAGE_SIZE units than to use remote NUMA THP
> : backed memory. That largely depends on the remote latency though, on
> : threadrippers for example the overhead is relatively low in my
> : experience.
> :
> : The combination of __GFP_THISNODE and __GFP_DIRECT_RECLAIM results in
> : extremely slow qemu startup with vfio, if the VM is larger than the
> : size of one host NUMA node. This is because it will try very hard to
> : unsuccessfully swapout get_user_pages pinned pages as result of the
> : __GFP_THISNODE being set, instead of falling back to PAGE_SIZE
> : allocations and instead of trying to allocate THP on other nodes (it
> : would be even worse without vfio type1 GUP pins of course, except it'd
> : be swapping heavily instead).
> 
> Fix this by removing __GFP_THISNODE handling from alloc_pages_vma where
> it doesn't belong and move it to alloc_hugepage_direct_gfpmask where we
> juggle gfp flags for different allocation modes. The rationale is that
> __GFP_THISNODE is helpful in relaxed defrag modes because falling back
> to a different node might be more harmful than the benefit of a large page.
> If the user really requires THP (e.g. by MADV_HUGEPAGE) then the THP has
> a higher priority than local NUMA placement.
> 

That's not entirely true, the remote access latency for remote thp on all 
of our platforms is greater than local small pages, this is especially 
true for remote thp that is allocated intersocket and must be accessed 
through the interconnect.

Our users of MADV_HUGEPAGE are ok with assuming the burden of increased 
allocation latency, but certainly not remote access latency.  There are 
users who remap their text segment onto transparent hugepages are fine 
with startup delay if they are access all of their text from local thp.  
Remote thp would be a significant performance degradation.

When Andrea brought this up, I suggested that the full solution would be a 
MPOL_F_HUGEPAGE flag that could define thp allocation policy -- the added 
benefit is that we could replace the thp "defrag" mode default by setting 
this as part of default_policy.  Right now, MADV_HUGEPAGE users are 
concerned about (1) getting thp when system-wide it is not default and (2) 
additional fault latency when direct compaction is not default.  They are 
not anticipating the degradation of remote access latency, so overloading 
the meaning of the mode is probably not a good idea.
