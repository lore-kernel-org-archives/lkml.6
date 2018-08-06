Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414A5C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0710219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="doipVUdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0710219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeHFRrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:47:33 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39538 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeHFRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:47:33 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so9173675qkg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qGtFj7QGQQt9S5+V3oAQSCBbiSZ7fGINDfjcXzvk80A=;
        b=doipVUdhWQjSItLgotm8duswFctbnFegpnQzV8RbRWdGIBRLv4YoA4CdkusAOiMjtI
         gFA0jFlkbOr2humb2F+PzGx1sQmQsyESlBXXmBRIHN5kaRJ07i1P1GbuCODQtfM10dbj
         Fm33vvDZdiXtFyk1SwCw30dF26jTaU4w5Msi4wr06kM1xIRwjUwq5l5aU49g1WmWrK/s
         jmtELt0EA5SuLdTLyLTf6l3ybX4JKr33fmYWbpIS0yvtnjEgl8f8G9idOVNBOEHQfrSH
         Gjb/AP8fa/0hkJYASs03WBYrzR75uVwYzlsEuYbhcJnhk+YY1nT5Ruf3aLpKMFG8MmLe
         q36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGtFj7QGQQt9S5+V3oAQSCBbiSZ7fGINDfjcXzvk80A=;
        b=Pe+7mcxpWzQwuHPxyd0HJpzxjFICR+do4VdxHrq68LptU+DN622ifbiX3M2b7WE8bd
         RP7QoLLBIrWwzLRcwps6QgJ311aHPzDmzdgfYQNKRyY4zMzogx+q6tFPWF9fQJ+B2XCf
         wQZX9Q2IguUgHgtsjd/ZxgVxEh8GWCIMjDPLAhl5mk1uhRiZxZ0x08+fh5ouR9bwEQhi
         wV4V+OJ/ydTvHqym4ODkdEvLHUk7QQGRKFQzEgZ1FXo/Z5lMM33xg7b0yLqE8/HhP6l2
         A5w71LOURsAND1M8BD20zdOZbO77gju8WHeoGQO/eKy6wgcRwPswI12U0DKlRSGQiq14
         s8Pg==
X-Gm-Message-State: AOUpUlGhrcAZSFP493xUZkuNZpXVfEsm2zk+6WssVEAmBBScbFZtQVhA
        R931+MUjO9zfi3j/tRHRxZyo+A==
X-Google-Smtp-Source: AAOMgpfr7nWmNMKJN+bHmq/uvPij//Bev/cPR/bOc+FMn3wWhm9xVed28OivHAel4KkpNGyzyNdeeQ==
X-Received: by 2002:a37:71c7:: with SMTP id m190-v6mr13962620qkc.275.1533569873837;
        Mon, 06 Aug 2018 08:37:53 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id t11-v6sm9584120qkt.28.2018.08.06.08.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:37:52 -0700 (PDT)
Date:   Mon, 6 Aug 2018 11:40:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180806154051.GA14209@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803165641.GA2476@hirez.programming.kicks-ass.net>
 <20180806150550.GA9888@cmpxchg.org>
 <20180806152528.GM2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806152528.GM2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 05:25:28PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 06, 2018 at 11:05:50AM -0400, Johannes Weiner wrote:
> > Argh, that's right. This needs an explicit count if we want to access
> > it locklessly. And you already said you didn't like that this is the
> > only state not derived purely from the task counters, so maybe this is
> > the way to go after all.
> > 
> > How about something like this (untested)?
> 
> 
> > +static inline void psi_switch(struct rq *rq, struct task_struct *prev,
> > +			      struct task_struct *next)
> > +{
> > +	if (psi_disabled)
> > +		return;
> > +
> > +	if (unlikely(prev->flags & PF_MEMSTALL))
> > +		psi_task_change(prev, rq_clock(rq), TSK_RECLAIMING, 0);
> > +	if (unlikely(next->flags & PF_MEMSTALL))
> > +		psi_task_change(next, rq_clock(rq), 0, TSK_RECLAIMING);
> > +}
> 
> 
> Urgh... can't say I really like that.
> 
> I would really rather do that scheduler_tick() thing to avoid the remote
> update. The tick is a lot less hot than the switch path and esp.
> next->flags might be a cold line (prev->flags is typically the same line
> as prev->state so we already have that, but I don't think anybody now
> looks at next->flags or its line, so that'd be cold load).

Okay, the tick updater sounds like a much better option then. HZ
frequency should produce more than recent enough data.

That means we will retain the not-so-nice PF_MEMSTALL flag test under
rq lock, but it'll eliminate most of that memory ordering headache.

I'll do that. Thanks!
