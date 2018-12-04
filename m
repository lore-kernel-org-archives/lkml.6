Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6550EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D7320851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuKoXQbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D7320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLDWZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:25:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33473 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:25:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so8032422pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GgnIbkTTYT6j4yMMvvZjd6oEH7KBr8tuTO49wtKWm0o=;
        b=IuKoXQbH5SohkE+LVxXg06YfeVKU6Iuqdwmwrxv3CEHRVkmY+E8zHlGaTkrxtRdFJy
         3jbiOx2eXW1YGKjwV+UULTQlJNH+7JW8WwRuY+A3d3GHRKPM4cYJKOC9puWSVrAPOl0J
         4uUpIpA9TblgYBV5JDJYkQ7w4eZSvz44chcp0qi6xXiq+gj/ss2m/20HRCWszaeyhxPY
         ZBvewc39DaA6nKw4seH1BA3o3ZjErgi707PsofH8AmsSh91vI+n7dnZbBiLH9P4Pz4e4
         Q2d5aX9gMjNXXn+6ivXf0y5+BlzBx2E0AZd0f9/lYmRMGuEPwLKvreD8LB5RyvbeqMR4
         5VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GgnIbkTTYT6j4yMMvvZjd6oEH7KBr8tuTO49wtKWm0o=;
        b=CxBCETHa3nK7+uHUlgoHvSX61hHJU3mHGGoaySdJLe9SoEWkd4WKalNK06HIDwPyhw
         pUiJJOL5YCPYKdaL20p2rksUJ10a0hLum5KQe8i0DFukt6kE5xEp22lPP9gie3/t91SY
         9dAgNGCQMiDwBNEjVdECK2DlezK+0k8sNrLm7+EoRmtSbbtGwnNALP/aSw/+RpR11cGo
         WslMfR4Kx5l6ZW56xocj9b+TbHMEdLCLN+1mbFciBN1wJpoafvRJ2AG+Rj/2xZx1sKTz
         Wm4uPqksi0cgXJ7vjc7Wu//8g79xei/yjFCVN11LKrM9nsvqB5blmUQusXmRYbRsLyBZ
         RK0Q==
X-Gm-Message-State: AA+aEWZvamLiVWMHBlo9vn87IQBK1UXYvLTTxD7RAFGiw3zTmoClsTlS
        HRv1rjcnyLJDAJluGseGnhSiKQ==
X-Google-Smtp-Source: AFSGD/UUx+UYRfKXUWIiYJTclqowafik4Iia7cRicDSVXnKqybrSYqzUcIvyYrQECECZiBWcn6isBA==
X-Received: by 2002:a63:2946:: with SMTP id p67mr18610653pgp.317.1543962356294;
        Tue, 04 Dec 2018 14:25:56 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h128sm22316145pgc.15.2018.12.04.14.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 14:25:55 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:25:54 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
In-Reply-To: <20181204073850.GW31738@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812041415270.159770@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <20181204073850.GW31738@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Michal Hocko wrote:

> > This fixes a 13.9% of remote memory access regression and 40% remote
> > memory allocation regression on Haswell when the local node is fragmented
> > for hugepage sized pages and memory is being faulted with either the thp
> > defrag setting of "always" or has been madvised with MADV_HUGEPAGE.
> > 
> > The usecase that initially identified this issue were binaries that mremap
> > their .text segment to be backed by transparent hugepages on startup.
> > They do mmap(), madvise(MADV_HUGEPAGE), memcpy(), and mremap().
> 
> Do you have something you can share with so that other people can play
> and try to reproduce?
> 

This is a single MADV_HUGEPAGE usecase, there is nothing special about it.  
It would be the same as if you did mmap(), madvise(MADV_HUGEPAGE), and 
faulted the memory with a fragmented local node and then measured the 
remote access latency to the remote hugepage that occurs without setting 
__GFP_THISNODE.  You can also measure the remote allocation latency by 
fragmenting the entire system and then faulting.

(Remapping the text segment only involves parsing /proc/self/exe, mmap, 
madvise, memcpy, and mremap.)

> > This requires a full revert and partial revert of commits merged during
> > the 4.20 rc cycle.  The full revert, of ac5b2c18911f ("mm: thp: relax
> > __GFP_THISNODE for MADV_HUGEPAGE mappings"), was anticipated to fix large
> > amounts of swap activity on the local zone when faulting hugepages by
> > falling back to remote memory.  This remote allocation causes the access
> > regression and, if fragmented, the allocation regression.
> 
> Have you tried to measure any of the workloads Mel and Andrea have
> pointed out during the previous review discussion? In other words what
> is the impact on the THP success rate and allocation latencies for other
> usecases?

It isn't a property of the workload, it's a property of the how fragmented 
both local and remote memory is.  In Andrea's case, I believe he has 
stated that memory compaction has failed locally and the resulting reclaim 
activity ends up looping and causing it the thrash the local node whereas 
75% of remote memory is free and not fragmented.  So we have local 
fragmentation and reclaim is very expensive to enable compaction to 
succeed, if it ever does succeed[*], and mostly free remote memory.

If remote memory is also fragmented, Andrea's case will run into a much 
more severe swap storm as a result of not setting __GFP_THISNODE.  The 
premise of the entire change is that his remote memory is mostly free so 
fallback results in a quick allocation.  For balanced nodes, that's not 
going to be the case.  The fix to prevent the heavy reclaim activity is to 
set __GFP_NORETRY as the page allocator suspects, which patch 2 here does.

That's an interesting memory state to

 [*] Reclaim here would only be beneficial if we fail the order-0 
     watermark check in __compaction_suitable() *and* the reclaimed
     memory can be accessed during isolate_freepages().
