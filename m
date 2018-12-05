Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190CE205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uud8BWwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190CE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeLEWKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:10:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42900 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEWKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:10:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so5911298plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UJE/8RXB1RhtkKSokuWkuz7qGeGuqnPcz5FChZp6Ozk=;
        b=uud8BWwgwkD8br8Qfjm0LMY1/F58zGkr68SPcD7g2iZ0b5UumSauYZxfxXLQHXsFoG
         nCh0UD0ovXGS/J+ff07/WtbTnqmb7fLFIgUG4hpSWKToeuHUnTOuhFMgzXAFOI86zRN3
         wCIk/wjRVf3oRNSK3XOgt0tswJQkPGqKQnFp0UJc67vwINV4xEz6HA4fpqr5Had8c0jf
         vLW0qHhkRm+hzaQS6scr78mk0LE3o2FlYsJlyYOvK3dT+yFMbBLlISn0Eikq6qYe7uc3
         LjwD43LDtwuss8mOYzxLJHYa/i0JM27EQHfeoGv4wU4ecGCPTlfA2YA7KjvM+ste2SQM
         HRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UJE/8RXB1RhtkKSokuWkuz7qGeGuqnPcz5FChZp6Ozk=;
        b=EtARO21HF9t9Vm42i3EEQzfrG3WI/340nB5mIxhnt/sw5EEPkpe2Qkld/Hg8TXV/2k
         UKqvVtL4OjaxvYEwiRXQZ7zcGOWFMbf8WvtHpaU0IKSAN/QVOMsvyGkeGNtVTEsKUVrd
         I+Nt2B/+e5JP8u34hijU3YexO8WbwbBitnc3lRmNSKxnICKgd809AJyowTRxikRwDCXF
         Qz94UTO88n9Ya1s9WQoK2GpCWDAT8i9kGLniQzJXGIyFX2ffto3q9m4Mk+Ch2Z01Q4Pb
         TCGvjwDcUFMQQeu5qP/AAp+lg/pKHWCexhUDM1zXKdyxMMMVZ2tralEo0u5i0InAtHkI
         9SjQ==
X-Gm-Message-State: AA+aEWYFNW/GsXZWYaDz3l9Xg+vzk5S/dnTOrlK0LGxVDL8NWLxdrXmO
        AKiQi0ITddCa2zMbVqcJxlaWIQ==
X-Google-Smtp-Source: AFSGD/XLbOf30480o4cxHpbjGc0Pa+ElK5DBUAqm9dOa0dQSjkczaxPJ2C9otVDd0JDfj7Li02kksg==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr7338199plb.107.1544047849468;
        Wed, 05 Dec 2018 14:10:49 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q187sm94210352pfq.128.2018.12.05.14.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:10:48 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:10:47 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
In-Reply-To: <20181205214542.GC11899@redhat.com>
Message-ID: <alpine.DEB.2.21.1812051402150.9633@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz> <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com> <20181205090554.GX1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com> <20181205214542.GC11899@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Andrea Arcangeli wrote:

> > High thp utilization is not always better, especially when those hugepages 
> > are accessed remotely and introduce the regressions that I've reported.  
> > Seeking high thp utilization at all costs is not the goal if it causes 
> > workloads to regress.
> 
> Is it possible what you need is a defrag=compactonly_thisnode to set
> instead of the default defrag=madvise? The fact you seem concerned
> about page fault latencies doesn't make your workload an obvious
> candidate for MADV_HUGEPAGE to begin with. At least unless you decide
> to smooth the MADV_HUGEPAGE behavior with an mbind that will simply
> add __GFP_THISNODE to the allocations, perhaps you'll be even faster
> if you invoke reclaim in the local node for 4k allocations too.
> 

I've must have said this at least six or seven times: fault latency is 
secondary to the *access* latency.  We want to try hard for MADV_HUGEPAGE 
users to do synchronous compaction and try to make a hugepage available.  
We really want to be backed by hugepages, but certainly not when the 
access latency becomes 13.9% worse as a result compared to local pages of 
the native page size.

This is not a system-wide configuration detail, it is specific to the 
workload: does it span more than one node or not?  No workload that can 
fit into a single node, which you also say is going to be the majority of 
workloads on today's platforms, is going to want to revert __GFP_THISNODE 
behavior of the past almost four years.  It perfectly makes sense, 
however, to be a new mempolicy mode, a new madvise mode, or a prctl.

> It looks like for your workload THP is a nice to have add-on, which is
> practically true of all workloads (with a few corner cases that must
> use MADV_NOHUGEPAGE), and it's what the defrag= default is about.
> 
> Is it possible that you just don't want to shut off completely
> compaction in the page fault and if you're ok to do it for your
> library, you may be ok with that for all other apps too?
> 

We enable synchronous compaction for MADV_HUGEPAGE users, yes, because we 
are not concerned with the fault latency but rather the access latency.

> That's a different stance from other MADV_HUGEPAGE users because you
> don't seem to mind a severely crippled THP utilization in your
> app.
> 

If access latency is really better for local pages of the native page 
size, we of course want to fault those instead.  For almost the past four 
years, the behavior of MADV_HUGEPAGE has been to compact and possibly 
reclaim locally and then fallback to local pages.  It is exactly what our 
users of MADV_HUGEPAGE want; I did not introduce this NUMA locality 
restriction but our users have used it.

Please: if we wish to change behavior from February 2015, let's extend the 
API to allow for remote allocations in several of the ways we have already 
brainstormed rather than cause regressions.
