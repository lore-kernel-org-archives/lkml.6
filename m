Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE21C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248D62070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Vjz4higG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfANTBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:01:04 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37789 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:01:04 -0500
Received: by mail-yw1-f67.google.com with SMTP id h193so45208ywc.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EYv7WFTyEw6RB+J56vAgi1p5NE2eZl4Vib2j6u/2wGA=;
        b=Vjz4higGCbEhPnVurIAe11qYMlnC8JuCIu6GgPJZ3vZAK6qB4jmAerRrDgs1j/SKQc
         UPymrejK64wlh3YqU1S0FkP7K+HotBnbRWzjb0EVGfEPGg8HBgvLYgN2kIxkqyixJEAQ
         vc5tnMbvOXpQfBKTMBfrHNWD31ef/tUPm74UrWmZIUpZheAslC/XbgzC4iE9fISCZuqp
         kuXYLTT09ZTlbtWH6EBdkk0tiBhG6uJh1b7QR6wV9Jr1k7CuuFJJ203I9ot73G2cAJFV
         v/Y1oeBKhyA5eVG2NdbCVw5k0oYZGprXZbbImerLbAim6x9kz5jRLOnWYbldKRGhYGcW
         iiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYv7WFTyEw6RB+J56vAgi1p5NE2eZl4Vib2j6u/2wGA=;
        b=hHdpl90IhETJG6YeHKfCOyvXxy5XfAG/d5gDL2mIe72CbEr1d765ItqTdZGbrdLbrn
         pCpRj+JkyKNdvzraX3pyfhdyPCP3ABuMk9F9YqFVUaAWHdU1PzVFE3csFNnqBJa5g5kf
         6vD3JgLIttUdEbBqFd+uXGn8TB+njS0y3S4cZwq8TyCLDR2GcgI0UQlWRky3gulff/Cm
         CsDqHYRvvkeMJZavlPXF2kHQFfa5bg1wKFYmtgKznvtT73hOyW4H15e3kHsKqDP3iAKc
         j11qbFa8oe8IlzIvC5STwoUBrW3C01W67gB87sjr5l15P+xl6wXNWFbYqRgVqC9Cdprc
         FSEA==
X-Gm-Message-State: AJcUukeYwxVu5m2Gwd2Omz7ty9DvdJQjyBq7ALpHhYmRdvWeFj1GjHdp
        fCyd+s/oBWTQb3mOoVm9MFq5Ww==
X-Google-Smtp-Source: ALg8bN6pH45vV6sYQTxojKUki5jxwamxK/XL3pdGToxYd4mz4JaKMshTx44SUfdoMV38w3370gF+Hg==
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr25422214ywe.496.1547492462711;
        Mon, 14 Jan 2019 11:01:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:de12])
        by smtp.gmail.com with ESMTPSA id j6sm371606ywi.110.2019.01.14.11.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:01:01 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:01:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when
 offlining
Message-ID: <20190114190100.GA8745@cmpxchg.org>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190109193247.GA16319@cmpxchg.org>
 <d92912c7-511e-2ab5-39a6-38af3209fcaf@linux.alibaba.com>
 <20190109212334.GA18978@cmpxchg.org>
 <9de4bb4a-6bb7-e13a-0d9a-c1306e1b3e60@linux.alibaba.com>
 <20190109225143.GA22252@cmpxchg.org>
 <99843dad-608d-10cc-c28f-e5e63a793361@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99843dad-608d-10cc-c28f-e5e63a793361@linux.alibaba.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:47:41PM -0800, Yang Shi wrote:
> On 1/9/19 2:51 PM, Johannes Weiner wrote:
> > On Wed, Jan 09, 2019 at 02:09:20PM -0800, Yang Shi wrote:
> > > On 1/9/19 1:23 PM, Johannes Weiner wrote:
> > > > On Wed, Jan 09, 2019 at 12:36:11PM -0800, Yang Shi wrote:
> > > > > As I mentioned above, if we know some page caches from some memcgs
> > > > > are referenced one-off and unlikely shared, why just keep them
> > > > > around to increase memory pressure?
> > > > It's just not clear to me that your scenarios are generic enough to
> > > > justify adding two interfaces that we have to maintain forever, and
> > > > that they couldn't be solved with existing mechanisms.
> > > > 
> > > > Please explain:
> > > > 
> > > > - Unmapped clean page cache isn't expensive to reclaim, certainly
> > > >     cheaper than the IO involved in new application startup. How could
> > > >     recycling clean cache be a prohibitive part of workload warmup?
> > > It is nothing about recycling. Those page caches might be referenced by
> > > memcg just once, then nobody touch them until memory pressure is hit. And,
> > > they might be not accessed again at any time soon.
> > I meant recycling the page frames, not the cache in them. So the new
> > workload as it starts up needs to take those pages from the LRU list
> > instead of just the allocator freelist. While that's obviously not the
> > same cost, it's not clear why the difference would be prohibitive to
> > application startup especially since app startup tends to be dominated
> > by things like IO to fault in executables etc.
> 
> I'm a little bit confused here. Even though those page frames are not
> reclaimed by force_empty, they would be reclaimed by kswapd later when
> memory pressure is hit. For some usecases, they may prefer get recycled
> before kswapd kick them out LRU, but for some usecases avoiding memory
> pressure might outpace page frame recycling.

I understand that, but you're not providing data for the "may prefer"
part. You haven't shown that any proactive reclaim actually matters
and is a significant net improvement to a real workload in a real
hardware environment, and that the usecase is generic and widespread
enough to warrant an entirely new kernel interface.

> > > > - Why you couldn't set memory.high or memory.max to 0 after the
> > > >     application quits and before you call rmdir on the cgroup
> > > I recall I explained this in the review email for the first version. Set
> > > memory.high or memory.max to 0 would trigger direct reclaim which may stall
> > > the offline of memcg. But, we have "restarting the same name job" logic in
> > > our usecase (I'm not quite sure why they do so). Basically, it means to
> > > create memcg with the exact same name right after the old one is deleted,
> > > but may have different limit or other settings. The creation has to wait for
> > > rmdir is done.
> > This really needs a fix on your end. We cannot add new cgroup control
> > files because you cannot handle a delayed release in the cgroupfs
> > namespace while you're reclaiming associated memory. A simple serial
> > number would fix this.
> > 
> > Whether others have asked for this knob or not, these patches should
> > come with a solid case in the cover letter and changelogs that explain
> > why this ABI is necessary to solve a generic cgroup usecase. But it
> > sounds to me that setting the limit to 0 once the group is empty would
> > meet the functional requirement (use fork() if you don't want to wait)
> > of what you are trying to do.
> 
> Do you mean do something like the below:
> 
> echo 0 > cg1/memory.max &
> rmdir cg1 &
> mkdir cg1 &
>
> But, the latency is still there, even though memcg creation (mkdir) can be
> done very fast by using fork(), the latency would delay afterwards
> operations, i.e. attaching tasks (echo PID > cg1/cgroup.procs). When we
> calculating the time consumption of the container deployment, we would count
> from mkdir to the job is actually launched.

I'm saying that the same-name requirement is your problem, not the
kernel's. It's not unreasonable for the kernel to say that as long as
you want to do something with the cgroup, such as forcibly emptying
out the left-over cache, that the group name stays in the namespace.

Requiring the same exact cgroup name for another instance of the same
job sounds like a bogus requirement. Surely you can use serial numbers
to denote subsequent invocations of the same job and handle that from
whatever job management software you're using:

	( echo 0 > job1345-1/memory.max; rmdir job12345-1 ) &
	mkdir job12345-2

See, completely decoupled.
