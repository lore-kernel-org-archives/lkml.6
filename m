Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF1C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503342145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N16LfCd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503342145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLCW57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:57:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42766 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLCW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:57:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so6393005pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=y3TBDSzaWqJ9MVeD2s1ej7Eh0gHItMsgUqQKBw5chZ4=;
        b=N16LfCd3wfrLSUDhv3Zlmd+xaE3loWDdX/O1nmWRo/sgxfaWyDhXLd79W3UgBYfuee
         ugrOG+xnoB3LcXAPnLRQ4J+sU766VfSriEcAPJnHyG81TSuIEqJp6oBjnzAHNxbd/3sC
         bBF8bM/YWRXzwc2OAb/9/CQ2m0njCOQXZZu6NpcLK49SHql34ddkYpV9cKqsC5bDbAqw
         H8d0HfJUMe1UJ1sk12KnokGNDG8mPoNehcNsbGx114S//4gqwrFlZt5GqtM/2BPWXuw8
         p2jfp8gjGwBPkrnh9Zhpyo01jrTPyfC8SyhC1N+o0Ag0B28T6qb2mZdHQLpNft+6XcPV
         ACmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=y3TBDSzaWqJ9MVeD2s1ej7Eh0gHItMsgUqQKBw5chZ4=;
        b=SlgPpU4RLBcfddmkpkdtVOwVKd5gAxduX0l+/VdgVQBWmoB7cDfaDlZJMeyK0aDl43
         lTUlQ2Sjo62js2H3lOpeg2Vgn/F5h/2SJBcKK9bVhNcg9Y3ol6GuZB9rBYsIsATO1xBt
         0kf8fKbA++dP9n0UTA7nTVeM8GVqmpolR/d8rLqllzKvx6BWgRP1v651n2OfwpAdQJBi
         I2XbNXSNuuWWFlT/s2/2hwtGlGESfb0jswOkweXPOMkJgh+U40bN2xjUvpwwFSbGCAgq
         YFDpC9ESYUPsWkpT9RBDpeNvSGdMdFB+u/U16Rpxry3iv8GRj95mRc3f0PSdcTd62RNd
         pt0A==
X-Gm-Message-State: AA+aEWZYYTOWN2q514SOmweyLjaRKxHXgRxmH+LOvhTK+shiQWiWvAHe
        PykfRf/pffUqc10D75Qb2DsKMlZ8UH4=
X-Google-Smtp-Source: AFSGD/VO8G9EGoXQKM12TaH5I57cJ8wAT/sILifmSO2+mWsV+vmmxVotCVq/YidLewNF62qeTn/e9w==
X-Received: by 2002:a63:1848:: with SMTP id 8mr14658026pgy.81.1543877877435;
        Mon, 03 Dec 2018 14:57:57 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x3sm23131680pgk.18.2018.12.03.14.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:57:56 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:57:55 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>, mhocko@kernel.org,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812031452280.253907@chino.kir.corp.google.com>
References: <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com> <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com> <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com> <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Linus Torvalds wrote:

> Side note: I think maybe people should just look at that whole
> compaction logic for that block, because it doesn't make much sense to
> me:
> 
>                 /*
>                  * Checks for costly allocations with __GFP_NORETRY, which
>                  * includes THP page fault allocations
>                  */
>                 if (costly_order && (gfp_mask & __GFP_NORETRY)) {
>                         /*
>                          * If compaction is deferred for high-order allocations,
>                          * it is because sync compaction recently failed. If
>                          * this is the case and the caller requested a THP
>                          * allocation, we do not want to heavily disrupt the
>                          * system, so we fail the allocation instead of entering
>                          * direct reclaim.
>                          */
>                         if (compact_result == COMPACT_DEFERRED)
>                                 goto nopage;
> 
>                         /*
>                          * Looks like reclaim/compaction is worth trying, but
>                          * sync compaction could be very expensive, so keep
>                          * using async compaction.
>                          */
>                         compact_priority = INIT_COMPACT_PRIORITY;
>                 }
> 
> this is where David wants to add *his* odd test, and I think everybody
> looks at that added case
> 
> +                       if (order == pageblock_order &&
> +                                       !(current->flags & PF_KTHREAD))
> +                               goto nopage;
> 
> and just goes "Eww".
> 
> But I think the real problem is that it's the "goto nopage" thing that
> makes _sense_, and the current cases for "let's try compaction" that
> are the odd ones, and then David adds one new special case for the
> sensible behavior.
> 
> For example, why would COMPACT_DEFERRED mean "don't bother", but not
> all the other reasons it didn't really make sense?
> 
> So does it really make sense to fall through AT ALL to that "retry"
> case, when we explicitly already had (gfp_mask & __GFP_NORETRY)?
> 
> Maybe the real fix is to instead of adding yet another special case
> for "goto nopage", it should just be unconditional: simply don't try
> to compact large-pages if __GFP_NORETRY was set.
> 

I think what is intended, which may not be represented by the code, is 
that if compaction is not suitable (__compaction_suitable() returns 
COMPACT_SKIPPED because of failing watermarks) that for non-hugepage 
allocations reclaim may be useful.  We just want to reclaim memory so that 
memory compaction has pages available for migration targets.

Note the same caveat I keep bringing up still applies, though: if reclaim 
frees memory that is iterated over by the compaction migration scanner, it 
was pointless.  That is a memory compaction implementation detail and can 
lead to a lot of unnecessary reclaim (or even thrashing) if unmovable page 
fragmentation cause compaction to fail even after it has migrated 
everything it could.  I think the likelihood of that happening increases 
by the allocation order.
