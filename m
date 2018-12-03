Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C3820848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKZ9DSXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C3820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLCUgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:36:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36104 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLCUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:36:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so7066662plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0jUXxaO+O4mfWOWOmu+jjcx27CGrWCtZ/DXsjLwI0CU=;
        b=mKZ9DSXOwDmh0mgMZ/UfW5XTHK+OJRvkhzM0EI51gIyutFTXZ0U714E7aQtPMF4LXM
         mO+XDxQMfNh4RfSuFqCRYQE8r9mdf7OukfmDg8aQj/hV8MmXMx94V9N99QvUwhFtE3SN
         C69lRQG5B1fQqSgJBpADR9Nc4S0pM0DbV7uFvjiit0J/Fr9VVjR65aZ46xMd9Fu6rsDu
         +58cBaPd895rJcByrqsNQTiE/d4xTXqiu1VXmJnUxyZ50ygXdjsYkSqvEjr1o3iz+umS
         fhYBHXgnmUesrWCLpBKqdc9eoOnRHxXy47dkJ+jtR2AB1eOISSn7qU1X8XEGpGoMBdZU
         c+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0jUXxaO+O4mfWOWOmu+jjcx27CGrWCtZ/DXsjLwI0CU=;
        b=JSRR/V58tKO4pGEO02Hm1+aCDuRCZDPHcW/aEd5Lqp30fvs3WKmE8Nth+mloSU/NQw
         nZ2foOgydRwV6gs718yjmvBRdfph0lQMR4CTsxYMavZVdaTGR2y80WCo+u3wv6Ziw7Dv
         EgXKjotjmrcBtJzFDROGS2+nSaLgD7qQxecJzSiYDWUJzW5aho7HSEE1GApKLApR0JRf
         hlnSGYb1K/v7KzTMnkZxdYIJ40gGBOByGM973GmQ44lJfejNZ8EJs+ygeLRuGJB2C6ST
         s8FjU4BwORoVeIu/EjF/El/UKMcVbt6xpahqam9UDOkXxV9jj1XA/AdxGF9Z1O0B8Hzn
         d+YA==
X-Gm-Message-State: AA+aEWYUVRxSkD3hi7SUMiS6oYEr+QJ0HATR036gGCkcGnojhlSqiciM
        OvGuy0UpJ46msO7ajQ3flsPTvA==
X-Google-Smtp-Source: AFSGD/WH6K8ave7rvwGmaU9QA+x5aL1rmEhVclbqiExNCi3vxVOFnoOSAMoP8dNO3v6AOC1YhZrK6A==
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr17606671pld.13.1543869371140;
        Mon, 03 Dec 2018 12:36:11 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t5sm23227033pfb.60.2018.12.03.12.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:36:09 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:36:09 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, mhocko@kernel.org,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181203201214.GB3540@redhat.com>
Message-ID: <alpine.DEB.2.21.1812031226510.192288@chino.kir.corp.google.com>
References: <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com> <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com> <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Andrea Arcangeli wrote:

> In my earlier review of David's patch, it looked runtime equivalent to
> the __GFP_COMPACT_ONLY solution. It has the only advantage of adding a
> new gfpflag until we're sure we need it but it's the worst solution
> available for the long term in my view. It'd be ok to apply it as
> stop-gap measure though.
> 
> The "order == pageblock_order" hardcoding inside the allocator to
> workaround the __GFP_THISNODE flag passed from outside the allocator
> in the THP MADV_HUGEPAGE case, didn't look very attractive because
> it's not just THP allocating order >0 pages.
> 

We have two different things to consider: NUMA locality and the order of 
the allocation.  THP is preferred locally and we know the order.  For the 
other high-order pages you're referring to, I don't know if they are using 
__GFP_THISNODE or not (likely not).  I see them as two separate issues.

For thp on all platforms I have measured it on specifically for this patch 
(Broadwell, Haswell, Rome) there is a clear advantage to faulting local 
pages of the native page size over remote hugepages.  It also has the 
added effect of allowing khugepaged to collapse it into a hugepage later 
if fragmentation allows (the reason why khugepaged cares about NUMA 
locality, the same reason I do).  This is the rationale for __GFP_THISNODE 
for thp allocations.

For order == pageblock_order (or more correctly order >= pageblock_order), 
this is not based on NUMA whatsoever but is rather based on the 
implementation of memory compaction.  If it has already failed (or was 
deferred for order-HPAGE_PMD_ORDER), reclaim cannot be shown to help if 
memory compaction cannot utilize the freed memory in isolate_freepages(), 
so that reclaim has been pointless.  If compaction fails for other reasons 
(any unmovable page preventing a pageblock from becoming free), *all* 
reclaim activity has been pointless.  

> It'd be nicer if whatever compaction latency optimization that applies
> to THP could also apply to all other allocation orders too and the
> hardcoding of the THP order prevents that.
> 
> On the same lines if __GFP_THISNODE is so badly needed by
> MADV_HUGEPAGE, all other larger order allocations should also be able
> to take advantage of __GFP_THISNODE without ending in the same VM
> corner cases that required the "order == pageblock_order" hardcoding
> inside the allocator.
> 
> If you prefer David's patch I would suggest pageblock_order to be
> replaced with HPAGE_PMD_ORDER so it's more likely to match the THP
> order in all archs.
> 

That sounds fine and I will do that in my v2.
