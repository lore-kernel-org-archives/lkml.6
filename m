Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C67C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5497C206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxM4LTAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5497C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeLDWEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:04:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41145 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:04:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so8896756pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2uwV9K9lD7GjY7kJi/YZk4TItn6nz345cENCtA8i8Zc=;
        b=OxM4LTAxEYSwPwRdIbGaipZ9XAmtPG80VcAg3dvjXGZPMqSgPfC64RUlyAqbhdjMDC
         VwHl4EzYdAgQwdf3Sa/05Agqp+fjo88+hIyQQqBcTQf5objSSESSfssqzCZqX0KiNW1o
         32LauellJH8ytHSKvpBVbMRtByOF/Qo+fX/ODKd1Xjp5XVe7DF1vsN2Qxunj0cwlpgSz
         +b0eM1d8m5pAC985E9sBPNSNzm3sft9j9v+t5cGijSvgQB97HxWHktUI+f+qgBFQ3jRm
         WD6tZerttHgeVlUZTja1L+xrZOG3g5C3XIrIB4CmXm3vklLJywG0Kzg0me/sQgo3iK5i
         kDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2uwV9K9lD7GjY7kJi/YZk4TItn6nz345cENCtA8i8Zc=;
        b=jbHfVCUSvG2ebMFZpbzjQirVhlDR/XYrfMfAzVznaYNvDErjNTSDexdS3kDXTXLo3/
         E19NGt/BgKIVgB8iF6z+K+o68jKjPmXa4OmU4teCCWC5hqJfPHp8HJ76twL0Wsb6N0c9
         ur5Mi74e8NFjE/Sw3m7sklrG9gHL3k/gY2rWdfJbcP761iipsuiP2H8HfeHR/p01K3oe
         RdWpWatdTvRchOGPsIOKF1/KTeMrO5Kw9sgeV6tDHRUz6qNCShfB1iElKExD0Z0faBNl
         8WhCMvHY+Wohqn3J8fXuvRPa4kMNGZAIZ3syJCK97AkLidD/GRlNeyHUrpXjTVeHFbEd
         mAqg==
X-Gm-Message-State: AA+aEWaWGQXS4IiA78cS0MYhjaGCWV/FckoMM79Sin3gcLzLmYhCEbr6
        PUCT0vcoXTBviSeKntNB4eTvdw==
X-Google-Smtp-Source: AFSGD/U7XFus9oc/Trjpr1m8p8Ua6Ig/Fgtrr17Sf4cAi9FgI6oixMXKvXPiDrejfXeBwC8lk0zJRQ==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr18614523pgs.166.1543961052287;
        Tue, 04 Dec 2018 14:04:12 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f13sm26559778pfa.132.2018.12.04.14.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 14:04:11 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:04:10 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        Michal Hocko <mhocko@suse.com>, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch 0/2 for-4.20] mm, thp: fix remote access and allocation
 regressions
In-Reply-To: <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
Message-ID: <alpine.DEB.2.21.1812041356490.157466@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812031545080.161134@chino.kir.corp.google.com> <bb198d88-27be-0d5c-d871-1ffd26a08e29@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Vlastimil Babka wrote:

> So, AFAIK, the situation is:
> 
> - commit 5265047ac301 in 4.1 introduced __GFP_THISNODE for THP. The
> intention came a bit earlier in 4.0 commit 077fcf116c8c. (I admit acking
> both as it seemed to make sense).

Yes, both are based on the preference to fault local thp and fallback to 
local pages before allocating remotely because it does not cause the 
performance regression introduced by not setting __GFP_THISNODE.

> - The resulting node-reclaim-like behavior regressed Andrea's KVM
> workloads, but reverting it (only for madvised or non-default
> defrag=always THP by commit ac5b2c18911f) would regress David's
> workloads starting with 4.20 to pre-4.1 levels.
> 

Almost, but the defrag=always case had the subtle difference of also 
setting __GFP_NORETRY whereas MADV_HUGEPAGE did not.  This was different 
than the comment in __alloc_pages_slowpath() that expected thp fault 
allocations to be caught by checking __GFP_NORETRY.

> If the decision is that it's too late to revert a 4.1 regression for one
> kind of workload in 4.20 because it causes regression for another
> workload, then I guess we just revert ac5b2c18911f (patch 1) for 4.20
> and don't rush a different fix (patch 2) to 4.20. It's not a big
> difference if a 4.1 regression is fixed in 4.20 or 4.21?
> 

The revert is certainly needed to prevent the regression, yes, but I 
anticipate that Andrea will report back that patch 2 at least improves the 
situation for the problem that he was addressing, specifically that it is 
pointless to thrash any node or reclaim unnecessarily when compaction has 
already failed.  This is what setting __GFP_NORETRY for all thp fault 
allocations fixes.

> Because there might be other unexpected consequences of patch 2 that
> testing won't be able to catch in the remaining 4.20 rc's. And I'm not
> even sure if it will fix Andrea's workloads. While it should prevent
> node-reclaim-like thrashing, it will still mean that KVM (or anyone)
> won't be able to allocate THP's remotely, even if the local node is
> exhausted of both huge and base pages.
> 

Patch 2 does nothing with respect to the remote allocation policy; it 
simply prevents reclaim (and potentially thrashing).  Patch 1 sets 
__GFP_THISNODE to prevent the remote allocation.

Note that the commit to be reverted in patch 1, if not reverted, would 
cause an even more severe regression from Andrea's case if remote memory 
is fragmented as well: it opens the door to thrashing both local and 
remote memory instead of only local memory.  I measured this as a 40% 
allocation latency regression when purposefully fragmenting all nodes and 
faulting without __GFP_THISNODE, and that was on Haswell; I can imagine it 
would be even greater on Rome.
