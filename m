Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ED2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC1A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+Z0mgtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC1A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeJWFYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:24:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39691 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeJWFYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:24:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so10648595plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VxVobE3NQmk/XRCiEd61zc12lCEehkI+kcfIKBa8aM4=;
        b=h+Z0mgtrCxQankC+/kJ9PNS7eIQ/RD5Rtt7FPmHvpLW8NkWtKcRMbH8ucIQWvTwPtJ
         oAmIw/vBOy+PQTmR17A42HXg46FwTc7xsX2VM6A6DAlduLqWaxwfOsOxMXAlK8Fz3dWk
         VeiGFGv91jKTG76CDqXGmO0z72HmFk7Xa976gN2zM1oRZM8EfPdS8jt37WI2/lvDA/US
         UrHl19JeKvGGf1CzsBNKqn12/95Xcrm6RdqikI/RSA50zCAVIUG0sMXrMYyU2yNILxlW
         g8dU+LwMEiT5ffCVJLkMpgI2EXAr9uTmBfHsgbffsN5VMtGSX8awsz7ohO36oImAVIrl
         nw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VxVobE3NQmk/XRCiEd61zc12lCEehkI+kcfIKBa8aM4=;
        b=UJaC0p/DBOyGsCMRUJzid4czBQt6VuF51nSZ6siuKZzG0qtf61qpnGp/O+gQtdjDXN
         v54IsRfISO7lkVL400O0E4gvJvfqPVhsL5/m9aWm8Txd+q2l8IkUnhzkk3Lb9de9ZBpQ
         p88/PmoomwdIdOoqj5L+27rbyV15g8oKUIXOjkjQiFmsYKOJ/5LM11BWYPXcfdWd035a
         XnZmItnv5GkjRa/m8lWGml6VAswPQMRrkhfSzAxBCS8w0HCjh33OJdToPj5lfiqqp8Tl
         o9uyz83KoQhfr27YbP0fPirA5smyydpTqtH4VsBpfsI4BQOcZGL0dSKr1AgEo8pnMAHV
         0EVQ==
X-Gm-Message-State: AGRZ1gIBUdyRPy9AgyhejrA6oB0HXE/e6q3wAElfD/PP3a/MkX421JBO
        D3DOfLGN3d/pQo7+wGROYal8aA==
X-Google-Smtp-Source: AJdET5c8e9RmdRNLCL7Dt91OVmCdIDdREggO6+tGx0j648qjiQaN3lq1CPR7eOPYczfHxS7RqXCS/Q==
X-Received: by 2002:a17:902:6184:: with SMTP id u4-v6mr4635595plj.291.1540242274844;
        Mon, 22 Oct 2018 14:04:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k132-v6sm2631400pga.28.2018.10.22.14.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 14:04:33 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:04:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@suse.de>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181016074606.GH6931@suse.de>
Message-ID: <alpine.DEB.2.21.1810221355050.120157@chino.kir.corp.google.com>
References: <20181005232155.GA2298@redhat.com> <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz> <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com> <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com> <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com> <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
 <20181016074606.GH6931@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018, Mel Gorman wrote:

> I consider this to be an unfortunate outcome. On the one hand, we have a
> problem that three people can trivially reproduce with known test cases
> and a patch shown to resolve the problem. Two of those three people work
> on distributions that are exposed to a large number of users. On the
> other, we have a problem that requires the system to be in a specific
> state and an unknown workload that suffers badly from the remote access
> penalties with a patch that has review concerns and has not been proven
> to resolve the trivial cases.

The specific state is that remote memory is fragmented as well, this is 
not atypical.  Removing __GFP_THISNODE to avoid thrashing a zone will only 
be beneficial when you can allocate remotely instead.  When you cannot 
allocate remotely instead, you've made the problem much worse for 
something that should be __GFP_NORETRY in the first place (and was for 
years) and should never thrash.

I'm not interested in patches that require remote nodes to have an 
abundance of free or unfragmented memory to avoid regressing.

> In the case of distributions, the first
> patch addresses concerns with a common workload where on the other hand
> we have an internal workload of a single company that is affected --
> which indirectly affects many users admittedly but only one entity directly.
> 

The alternative, which is my patch, hasn't been tested or shown why it 
cannot work.  We continue to talk about order >= pageblock_order vs
__GFP_COMPACTONLY.

I'd like to know, specifically:

 - what measurable affect my patch has that is better solved with removing
   __GFP_THISNODE on systems where remote memory is also fragmented?

 - what platforms benefit from remote access to hugepages vs accessing
   local small pages (I've asked this maybe 4 or 5 times now)?

 - how is reclaiming (and possibly thrashing) memory helpful if compaction
   fails to free an entire pageblock due to slab fragmentation due to low
   on memory conditions and the page allocator preference to return node-
   local memory?

 - how is reclaiming (and possibly thrashing) memory helpful if compaction
   cannot access the memory reclaimed because the freeing scanner has 
   already passed by it, or the migration scanner has passed by it, since
   this reclaim is not targeted to pages it can find?

 - what metrics can be introduced to the page allocator so that we can
   determine that reclaiming (and possibly thrashing) memory will result 
   in a hugepage being allocated?

Until we have answers, especially for the last, there is no reason why thp 
allocations should not be __GFP_NORETRY including for MADV_HUGEPAGE 
regions.  The implementation of memory compaction simply cannot guarantee 
that the cost is worthwhile.
