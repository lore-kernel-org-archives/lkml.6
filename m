Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6CFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E420892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uj4nHhC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeLETld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:41:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45951 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbeLETld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:41:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so10533345plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8X3OP8Ia1YXc3DnyZBzz87JOukWTLaSuWmbPxmbR5Uk=;
        b=Uj4nHhC/ZLkCEoMUBYAsBURHFJxPvSen7Xc/aEI22SHjMyColpV42lb6Y8LtJqKoUr
         iFnMi4P1hOTVDGmRaYNGZN68GVJxlE5UuIXAgEL3lOo0c0i72ozuIn7Tbpz8A+/BLH2Y
         keV/f9Y2lg3FFwehYbIpQgpO5sXzypBU9T3lBDvCgvU0EB4vpyEDVymVkZOGOl02An9R
         QqtLCcol4beO3V5W4mJnuvtmfdW5jMURk593XAnGAwgR0F+o0UKZmjmaJhpFsZqm2c7H
         I3tic+fHI08seWjH07NBJcc1OTdzygWnPhhk4+DIITwHbNRlV/vjSciS463z1rDl5WbP
         fI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8X3OP8Ia1YXc3DnyZBzz87JOukWTLaSuWmbPxmbR5Uk=;
        b=VNUitWkqXBixt0k2ekzwh34eK0eYqTcCq32Bm2TWIqgUDaKLcxyIwGjSVQw2I4hFG8
         WxCqIIVKfEHfH8AofykBgsLEaCc5gfhvAnTDPyJgEdpFYzJM5WeRHg3agaCu23SVE0Nk
         t+nVLDNrb8PVdCgUdJW/+bYKgHRbLBtC28CUeqX0I36QkRBTYLilwCZBmtJ82dFXUN8y
         1HPsBj7tk0Kcoo1bdiZWLgkELwM+gBgsBCGo/3ZY2YqlEmx2kHFsYhtygd8arhGCXeUG
         ogCyU9DXLyUqwpoh4I64H/mV/NXiX4Q+BeZMdo3SDmnNUXOVS8GwMUD9cGTPvRvy4DyQ
         NHJQ==
X-Gm-Message-State: AA+aEWbfQi1S0QE1TYCE8srxRJV7hEmY7qw69Fz0+DAP376JHd1KnkrS
        AS24oLn8UWduDNTTMmH/I+A5FZECUDo=
X-Google-Smtp-Source: AFSGD/Uk2QpIZrzfzEjzM59IsdWmCnc2YcXO1PWnS7JizpgThW0gQPlVBlfz8jc6y+7/2eUyC3ilSA==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr6976792plb.241.1544038892672;
        Wed, 05 Dec 2018 11:41:32 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l85sm54703105pfg.161.2018.12.05.11.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:41:31 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:41:31 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
In-Reply-To: <20181205101512.GY23260@techsingularity.net>
Message-ID: <alpine.DEB.2.21.1812051126250.240991@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <20181204073850.GW31738@dhcp22.suse.cz> <alpine.DEB.2.21.1812041415270.159770@chino.kir.corp.google.com> <20181205101512.GY23260@techsingularity.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Mel Gorman wrote:

> > This is a single MADV_HUGEPAGE usecase, there is nothing special about it.  
> > It would be the same as if you did mmap(), madvise(MADV_HUGEPAGE), and 
> > faulted the memory with a fragmented local node and then measured the 
> > remote access latency to the remote hugepage that occurs without setting 
> > __GFP_THISNODE.  You can also measure the remote allocation latency by 
> > fragmenting the entire system and then faulting.
> > 
> 
> I'll make the same point as before, the form the fragmentation takes
> matters as well as the types of pages that are resident and whether
> they are active or not. It affects the level of work the system does
> as well as the overall success rate of operations (be it reclaim, THP
> allocation, compaction, whatever). This is why a reproduction case that is
> representative of the problem you're facing on the real workload matters
> would have been helpful because then any alternative proposal could have
> taken your workload into account during testing.
> 

We know from Andrea's report that compaction is failing, and repeatedly 
failing because otherwise we would not need excessive swapping to make it 
work.  That can mean one of two things: (1) a general low-on-memory 
situation that causes us repeatedly to be under watermarks to deem 
compaction suitable (isolate_freepages() will be too painful) or (2) 
compaction has the memory that it needs but is failing to make a hugepage 
available because all pages from a pageblock cannot be migrated.

If (1), perhaps in the presence of an antagonist that is quickly 
allocating the memory before compaction can pass watermark checks, further 
reclaim is not beneficial: the allocation is becoming too expensive and 
there is no guarantee that compaction can find this reclaimed memory in 
isolate_freepages().

I chose to duplicate (2) by synthetically introducing fragmentation 
(high-order slab, free every other one) locally to test the patch that 
does not set __GFP_THISNODE.  The result is a remote transparent hugepage, 
but we do not even need to get to the point of local compaction for that 
fallback to happen.  And this is where I measure the 13.9% access latency 
regression for the lifetime of the binary as a result of this patch.

If local compaction works the first time, great!  But that is not what is 
happening in Andrea's report and as a result of not setting __GFP_THISNODE 
we are *guaranteed* worse access latency and may encounter even worse 
allocation latency if the remote memory is fragmented as well.

So while I'm only testing the functional behavior of the patch itself, I 
cannot speak to the nature of the local fragmentation on Andrea's systems.
