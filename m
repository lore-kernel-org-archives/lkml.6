Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950D7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C86C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViSv7EIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C86C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeJFDfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:35:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJFDfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:35:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id az3-v6so7332716plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s2qCxgB+d7zTusT4Aq369OMJa0xWDcCzNbVqJ7qfq+Q=;
        b=ViSv7EIyH6T3dugIH8AjKLevTqD6W79eMBSk7fUMAlBa+ccBhFR6EtcOxwayrS7eR2
         mKWS6sJawS0vitbJcnpZqsQ3VPPGoJsJ+ihSiekNPfVrYiYFBBz5Fn/4x41lnZ5KPq9o
         pLGIJKGCbXxCdPNGhf8K6qiAe7oK7TWRC/b4lmVpzFC1R3ZAdeUAl1fbE1damc929+4w
         Asc7mejy06u2i8A+d+UXXe7j8Z8AThRkrmPif6/zvJ2wnQGoEfWoyQz3NA5HXHv1W78U
         ckAxwPLWVKX4r6WXX+x+90lMk7qAuRc1/TXtDQZ6Vq+lz03HXV5TGbS9RxRG17atBiMt
         qMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s2qCxgB+d7zTusT4Aq369OMJa0xWDcCzNbVqJ7qfq+Q=;
        b=il5MRXEY7W+QbEnpDDJpxq2KjT/Js0B2VnWsOX40EZG4ym5av9IVR1jSXV/fCdyTeq
         Qlwgxa6caJCsrBYQ6KIZzxkvadMsG5/KccCtKYvtVjwanDe5t8O2UT3UgWqCs15UQ1IU
         LXhgiDEBwXOSMr2fUZnB5H0wvwciqlQ/RXALK/kXvEpcUYJ4ePJUnkvw4g+sSYSZGUmo
         fIoBLdKM0tx2WoE+skzHruNmU2/RpPOtObtAUh8G2OCZiV2/FgjKlEJ4614NungBHMu3
         po4z3MTRE+bU3vkbnMxVkeqCp3pZ3atiKwv5xjxPR+Ce1COeM4EPZjneRfOfkLTJE1N4
         iG7A==
X-Gm-Message-State: ABuFfoiGHIGYb1f2dDEXX8c9qF6C8BFuprd6K4RLTwjyol9nxZN8rg08
        9Icw+oBjNCKdMz3BbsFX+m0cWA==
X-Google-Smtp-Source: ACcGV61TUYCrhiV1motUBlQTWSZmfIqnyooVgSNXVo0+lnewo/VURqxZmGx2N/Zkk2/hCLIByJ/E1Q==
X-Received: by 2002:a17:902:788e:: with SMTP id q14-v6mr13493829pll.49.1538771717021;
        Fri, 05 Oct 2018 13:35:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d197-v6sm10893257pga.1.2018.10.05.13.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:35:15 -0700 (PDT)
Date:   Fri, 5 Oct 2018 13:35:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@suse.de>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stable tree <stable@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181005073854.GB6931@suse.de>
Message-ID: <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com>
References: <20180925120326.24392-1-mhocko@kernel.org> <20180925120326.24392-2-mhocko@kernel.org> <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com> <20181005073854.GB6931@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018, Mel Gorman wrote:

> > This causes, on average, a 13.9% access latency regression on Haswell, and 
> > the regression would likely be more severe on Naples and Rome.
> > 
> 
> That assumes that fragmentation prevents easy allocation which may very
> well be the case. While it would be great that compaction or the page
> allocator could be further improved to deal with fragmentation, it's
> outside the scope of this patch.
> 

Hi Mel,

The regression that Andrea is working on, correct me if I'm wrong, is 
heavy reclaim and swapping activity that is trying to desperately allocate 
local hugepages when the local node is fragmented based on advice provided 
by MADV_HUGEPAGE.

Why is it ever appropriate to do heavy reclaim and swap activity to 
allocate a transparent hugepage?  This is exactly what the __GFP_NORETRY 
check for high-order allocations is attempting to avoid, and it explicitly 
states that it is for thp faults.  The fact that we lost __GFP_NORERY for 
thp allocations for all settings, including the default setting, other 
than yours (setting of "always") is what I'm focusing on.  There is no 
guarantee that this activity will free an entire pageblock or that it is 
even worthwhile.

Why is thp memory ever being allocated without __GFP_NORETRY as the page 
allocator expects?

That aside, removing __GFP_THISNODE can make the fault latency much worse 
if remote notes are fragmented and/or reclaim has the inability to free 
contiguous memory, which it likely cannot.  This is where I measured over 
40% fault latency regression from Linus's tree with this patch on a 
fragmnented system where order-9 memory is neither available from node 0 
or node 1 on Haswell.

> > There exist libraries that allow the .text segment of processes to be 
> > remapped to memory backed by transparent hugepages and use MADV_HUGEPAGE 
> > to stress local compaction to defragment node local memory for hugepages 
> > at startup. 
> 
> That is taking advantage of a co-incidence of the implementation.
> MADV_HUGEPAGE is *advice* that huge pages be used, not what the locality
> is. A hint for strong locality preferences should be separate advice
> (madvise) or a separate memory policy. Doing that is outside the context
> of this patch but nothing stops you introducing such a policy or madvise,
> whichever you think would be best for the libraries to consume (I'm only
> aware of libhugetlbfs but there might be others).
> 

The behavior that MADV_HUGEPAGE specifies is certainly not clearly 
defined, unfortunately.  The way that an application writer may read it, 
as we have, is that it will make a stronger attempt at allocating a 
hugepage at fault.  This actually works quite well when the allocation 
correctly has __GFP_NORETRY, as it's supposed to, and compaction is 
MIGRATE_ASYNC.

So rather than focusing on what MADV_HUGEPAGE has meant over the past 2+ 
years of kernels that we have implemented based on, or what it meant prior 
to that, is a fundamental question of the purpose of direct reclaim and 
swap activity that had always been precluded before __GFP_NORETRY was 
removed in a thp allocation.  I don't think anybody in this thread wants 
14% remote access latency regression if we allocate remotely or 40% fault 
latency regression when remote nodes are fragmented as well.

Removing __GFP_THISNODE only helps when remote memory is not fragmented, 
otherwise it multiplies the problem as I've shown.

The numbers that you provide while using the non-default option to mimick 
MADV_HUGEPAGE mappings but also use __GFP_NORETRY makes the actual source 
of the problem quite easy to identify: there is an inconsistency in the 
thp gfp mask and the page allocator implementation.

> > The cost, including the statistics Mel gathered, is 
> > acceptable for these processes: they are not concerned with startup cost, 
> > they are concerned only with optimal access latency while they are 
> > running.
> > 
> 
> Then such applications at startup have the option of setting
> zone_reclaim_mode during initialisation assuming a privileged helper
> can be created. That would be somewhat heavy handed and a longer-term
> solution would still be to create a proper memory policy of madvise flag
> for those libraries.
> 

We *never* want to use zone_reclaim_mode for these allocations, that would 
be even worse, we do not want to reclaim because we have a very unlikely 
chance of making pageblocks free without the involvement of compaction.  
We want to trigger memory compaction with a well-bounded cost that 
MIGRATE_ASYNC provides and then fail.
