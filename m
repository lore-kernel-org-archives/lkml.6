Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA0720864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwmM+IC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA0720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLCVxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:53:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37826 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLCVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:53:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so7153859plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7wnLVcWqpR1bBXdX8I97wudR+0vgQNYXZiKq0KUNR7I=;
        b=PwmM+IC1J5nZwCdrJLC+TdNpBSCwEo9K+pklVus6dVqdbMbR0Zcqxyqo3ultT+Lxfz
         f6e+ntoZKCNM3zrR1FjGFRbi6QuBHtaqRad3LG7kcvZvva0N4/3wrH3J1gntMzbyaC7I
         ix+Jx2TqBHf3Ko+p/+TEV+xFvWWaJDjvGkuDGkOF64SyuA8xAGus6EX4wejGmu0NHJUs
         x1MRMo0ruHC9hX3L5aIuqbGpmlqPUsJaLxnWlsMllhgAgzWeaczq/i1ss3oCZr+vD4wC
         sLiUPjCco7HA+vPZth4pP231KH1ZT6Td1wPATve3LKrWMayMuqdtZ1ykVz+zbJiNv7ue
         JmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7wnLVcWqpR1bBXdX8I97wudR+0vgQNYXZiKq0KUNR7I=;
        b=iOjFAlX77ydgosbzAxSbaFTeDXp8T0o6rVx7MWyDetLo5Phzc8GtQH0n4OQ54UrkN5
         oTmYePHEiaW3qDFPg22ICs44KoAL4mhbkVP9Wg85rfCHWYtge8XIgAlSNitKPEypMg0v
         ai4HM14MvLCECqLuBKcMIk2xOUYzoK+YRNYObqK8TFN/Andai5yxcrPXRA59g8RDGaG3
         kVJkqFL/vRnojhzL+nYi3F+wtUV+ncNGuC33waE0KCSr9LCiX3S/4dEmt4UX7yjQVUaq
         yk3odNo5JkdS179Iv96EBwc4nHw4Qzw3iLIMJYsoUKS4mLER1YeTiTGSuxgpVFAXSCWq
         /vtA==
X-Gm-Message-State: AA+aEWaaD3lob3dpPl/JG1RfRdJHgM2pp0Sb1hPf4051Pie+3ydb9OJx
        9FyiABmLQKiIPf8XVyP00lZy8MzLe1g=
X-Google-Smtp-Source: AFSGD/WF9zt9/jLL7/0vXQonaW8R4a5DrbZxel7IuaohvMZazIzV8CcVhrHC4iK0WFlNw/P3bhEKFQ==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr17793770plo.50.1543874003772;
        Mon, 03 Dec 2018 13:53:23 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m67sm13667818pfm.73.2018.12.03.13.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 13:53:22 -0800 (PST)
Date:   Mon, 3 Dec 2018 13:53:21 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181203212539.GR31738@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812031345180.224765@chino.kir.corp.google.com>
References: <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com> <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com> <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com>
 <20181203212539.GR31738@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Michal Hocko wrote:

> > I think extending functionality so thp can be allocated remotely if truly 
> > desired is worthwhile
> 
> This is a complete NUMA policy antipatern that we have for all other
> user memory allocations. So far you have to be explicit for your numa
> requirements. You are trying to conflate NUMA api with MADV and that is
> just conflating two orthogonal things and that is just wrong.
> 

No, the page allocator change for both my patch and __GFP_COMPACT_ONLY has 
nothing to do with any madvise() mode.  It has to do with where thp 
allocations are preferred.  Yes, this is different than other memory 
allocations where it doesn't cause a 13.9% access latency regression for 
the lifetime of a binary for users who back their text with hugepages.  
MADV_HUGEPAGE still has its purpose to try synchronous memory compaction 
at fault time under all thp defrag modes other than "never".  The specific 
problem being reported here, and that both my patch and __GFP_COMPACT_ONLY 
address, is the pointless reclaim activity that does not assist in making 
compaction more successful.

> Let's put the __GFP_THISNODE issue aside. I do not remember you
> confirming that __GFP_COMPACT_ONLY patch is OK for you (sorry it might
> got lost in the emails storm from back then) but if that is the only
> agreeable solution for now then I can live with that.

The discussion between my patch and Andrea's patch seemed to only be about 
whether this should be a gfp bit or not

> __GFP_NORETRY hack
> was shown to not work properly by Mel AFAIR. Again if I misremember then
> I am sorry and I can live with that.

Andrea's patch as posted in this thread sets __GFP_NORETRY for 
__GFP_ONLY_COMPACT, so both my patch and his patch require it.  His patch 
gets this behavior for page faults by way of alloc_pages_vma(), mine gets 
it from modifying GFP_TRANSHUGE.

> But conflating MADV_TRANSHUGE with
> an implicit numa placement policy and/or adding an opt-in for remote
> NUMA placing is completely backwards and a broken API which will likely
> bites us later. I sincerely hope we are not going to repeat mistakes
> from the past.

Assuming s/MADV_TRANSHUGE/MADV_HUGEPAGE/.  Again, this is *not* about the 
madvise(); it's specifically about the role of direct reclaim in the 
allocation of a transparent hugepage at fault time regardless of any 
madvise() because you can get the same behavior with defrag=always (and 
the inconsistent use of __GFP_NORETRY there that is fixed by both of our 
patches).
