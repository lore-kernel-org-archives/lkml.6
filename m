Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11C2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9009920831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8gUDnD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9009920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLIWo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:44:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34026 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLIWo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:44:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so4306760plz.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pdWyWUbFfA+p+N+o5RbHk/Ilb/5UC+AUi5omO6iiXHg=;
        b=M8gUDnD+TzTl/JFiPXQ7HAwt7VBMGFjagoJTwwEsmv+3ScxVM/WM5Avdy3W+/oZPeP
         7BTOt1U8suTQ4ER91kJeouf6AvVaup2oC4BiAv/TI4rTm6EytXmpIRRn/w2XIycHOlOK
         8XZ3/LxJNxej6mHnNJhZEZ70EVYhBTpGjqfIKz4dYdhUMnLm5039wSMtOT0hIE2umNn7
         UHtWWQ/1516RmFrty2h549ZvePGBeQSM1rnSudFP+RgU03QhDxWjNAjixIL0W8eHxQ4w
         RSuB8VjwdjrtYhajiVDdGg+G1eXJQ6BQRSKnmDcIkoGsnTuaTge2Z3Y4TfkiB0g+tBW3
         F2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pdWyWUbFfA+p+N+o5RbHk/Ilb/5UC+AUi5omO6iiXHg=;
        b=V67kO49d+lYepsZOICWTe9UzJ3flxL1eQnLIb7xEXS85ZdMo/J77Un/ZCuLe793hY0
         Kgh3auNdznMQjVenvjWUkQHIkukVmUJdQ3OM289UkkxCEKBjXzW/BLtHuYjYEFidnqZs
         Tt0wl6IbKxtAsNEQrzw+Nwhsk+ZlFDoRo/DSKddl4/3VNnmd5CPxvGsWYOQfWdg9GMTq
         6Pr0R7CqHFP7TAUTWwPUNKPMYVH0jBf5sqv7Urd+Ko6yBu0F+U9ZCVFInjObVCSjjery
         Lk04rd2H7jWFurl9seU4UPLMYNkLgqHNYYttVcI85b6hAJhHqmr3Frrsavhpiq254Oo2
         V4Vw==
X-Gm-Message-State: AA+aEWbUz0FWD86iJJbJOSs7sDHfY/6Yme5/Fqe0XNJb+xoyOR6KTMaK
        I/4ihvCFtf6ofPJ34oNGuSYWGg==
X-Google-Smtp-Source: AFSGD/XMiEJI6S7oY0mvxdq1S1Hjy7QXdJBCNvGQrIItqIHJtdqYohMCX6TmmVXhQjETSclDbsMlnw==
X-Received: by 2002:a17:902:9345:: with SMTP id g5mr9679600plp.148.1544395465592;
        Sun, 09 Dec 2018 14:44:25 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c20sm13482837pfc.92.2018.12.09.14.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 14:44:24 -0800 (PST)
Date:   Sun, 9 Dec 2018 14:44:23 -0800 (PST)
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
In-Reply-To: <20181206003126.GA21159@redhat.com>
Message-ID: <alpine.DEB.2.21.1812091420350.95551@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz> <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com> <20181205090554.GX1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812051142040.240991@chino.kir.corp.google.com> <20181205214542.GC11899@redhat.com> <alpine.DEB.2.21.1812051402150.9633@chino.kir.corp.google.com> <20181206003126.GA21159@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Andrea Arcangeli wrote:

> > I've must have said this at least six or seven times: fault latency is 
> 
> In your original regression report in this thread to Linus:
> 
> https://lkml.kernel.org/r/alpine.DEB.2.21.1811281504030.231719@chino.kir.corp.google.com
> 
> you said "On a fragmented host, the change itself showed a 13.9%
> access latency regression on Haswell and up to 40% allocation latency
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> regression. This is more substantial on Naples and Rome.  I also
> ^^^^^^^^^^
> measured similar numbers to this for Haswell."
> 
> > secondary to the *access* latency.  We want to try hard for MADV_HUGEPAGE 
> > users to do synchronous compaction and try to make a hugepage available.  
> 
> I'm glad you said it six or seven times now, because you forgot to
> mention in the above email that the "40% allocation/fault latency
> regression" you reported above, is actually a secondary concern because
> those must be long lived allocations and we can't yet generate
> compound pages for free after all..
> 

I've been referring to the long history of this discussion, namely my 
explicit Nacked-by in https://marc.info/?l=linux-kernel&m=153868420126775 
two months ago stating the 13.9% access latency regression.  The patch was 
nonetheless still merged and I proposed the revert for the same chief 
complaint, and it was reverted.

I brought up the access latency issue three months ago in
https://marc.info/?l=linux-kernel&m=153661012118046 and said allocation 
latency was a secondary concern, specifically that our users of 
MADV_HUGEPAGE are willing to accept the increased allocation latency for 
local hugepages.

> BTW, I never bothered to ask yet, but, did you enable NUMA balancing
> in your benchmarks? NUMA balancing would fix the access latency very
> easily too, so that 13.9% access latency must quickly disappear if you
> correctly have NUMA balancing enabled in a NUMA system.
> 

No, we do not have CONFIG_NUMA_BALANCING enabled.  The __GFP_THISNODE 
behavior for hugepages was added in 4.0 for the PPC usecase, not by me.  
That had nothing to do with the madvise mode: the initial documentation 
referred to the mode as a way to prevent an increase in rss for configs 
where "enabled" was set to madvise.  The allocation policy was never about 
MADV_HUGEPAGE in any 4.x kernel, it was only an indication for certain 
defrag settings to determine how much work should be done to allocate 
*local* hugepages at fault.

If you are saying that the change in allocator policy in a patch from 
Aneesh almost four years ago and has gone unreported by anybody up until a 
few months ago, I can understand the frustration.  I do, however, support 
the __GFP_THISNODE change he made because his data shows the same results 
as mine.

I've suggested a very simple extension, specifically a prctl() mode that 
is inherited across fork, that would allow a workload to specify that it 
prefers remote allocations over local compaction/reclaim because it is too 
large to fit on a single node.  I'd value your feedback for that 
suggestion to fix your usecase.
