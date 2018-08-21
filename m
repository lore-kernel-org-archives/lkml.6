Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F03C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9150217FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sID9SnX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9150217FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHUXFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:05:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41506 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeHUXFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:05:46 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so8565360ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y7sn1yrXnMivKB1tsHT35xpqQapDm2oCf8sWGyB+fzE=;
        b=sID9SnX2a7/YR0502EVfCCq+Sxl2ed4VFqtivAX9YclTEoBojimbnGqlm0pT4RnWtO
         Xcw9YyY746os1eX3XDkJ58U7s23CIa/74RJpfC754ewrJDsNAbt/Dwtib7MgnVrz4+OK
         6d78SbkkGuJ5jps0LBnjZj0YXRb41fkgvdH5EbgUtbZ494VbV9bNWVuUAobXXFx+G++s
         PuDsj6PVW7HeEHzFdOYfy0Yb/mzbCHiMo0kyrtb0qevMY6ZqeZ/mHjcgn7yqbTcoysV2
         hOs+uajbE8hhtSSVGngRef1j6LsFKoF1NySVq+pGldVtP69oYLJZPWwaQp+JITMn1ixF
         bX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y7sn1yrXnMivKB1tsHT35xpqQapDm2oCf8sWGyB+fzE=;
        b=WbQF9DsIoIpQyDZSy74StqAQftAQ+Grt+GLQDDiGVg3F21vYPrDQt8zhuOSxqso+Aa
         AMYCUJxy7aA2HdDh4GaI04Lke2JcJqUUgKJz8J4vOh1s+zQkpzjjErWSETnJuHSPEZTr
         Cqgxar32ov3719zUXvzbirz4+7/KhBhGCyhzz/CgL10cCbhkrGlPOhhGhr5mJabNJlrp
         lsDqXdwLkppb67FnMVBEToDr9d79T3xdA+UjWfeZy6e7EJE2xIrol/7rms5w1HWEyoHE
         33TTqP+J47iipIiIMF1pfcoitObFPYNbhK8zMVfLiiFPTIE9UOo6JbOe4NKqpeYWoduE
         /jgg==
X-Gm-Message-State: AOUpUlH0949hmYjBVIhCQhwoQRZCa+lJ9sH7dlTxW2+uE2qEzfmMvWd2
        NINM582o5zUcHCU+RXHkg9YwTA==
X-Google-Smtp-Source: AA+uWPwNkNYim2/+6d+ZTfwkcO3wpZByJCYaYUICWgeJFQJaIXaK77oYRxJlG5miCODLq8RWUMV7Yg==
X-Received: by 2002:a81:5d41:: with SMTP id r62-v6mr27287988ywb.419.1534880656157;
        Tue, 21 Aug 2018 12:44:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:17a0])
        by smtp.gmail.com with ESMTPSA id s206-v6sm6475435ywc.55.2018.08.21.12.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 12:44:14 -0700 (PDT)
Date:   Tue, 21 Aug 2018 15:44:13 -0400
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
Message-ID: <20180821194413.GA24538@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803165641.GA2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803165641.GA2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a quick update on that feedback before I send out v4:

On Fri, Aug 03, 2018 at 06:56:41PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> > +static bool test_state(unsigned int *tasks, int cpu, enum psi_states state)
> > +{
> > +	switch (state) {
> > +	case PSI_IO_SOME:
> > +		return tasks[NR_IOWAIT];
> > +	case PSI_IO_FULL:
> > +		return tasks[NR_IOWAIT] && !tasks[NR_RUNNING];
> > +	case PSI_MEM_SOME:
> > +		return tasks[NR_MEMSTALL];
> > +	case PSI_MEM_FULL:
> > +		/*
> > +		 * Since we care about lost potential, things are
> > +		 * fully blocked on memory when there are no other
> > +		 * working tasks, but also when the CPU is actively
> > +		 * being used by a reclaimer and nothing productive
> > +		 * could run even if it were runnable.
> > +		 */
> > +		return tasks[NR_MEMSTALL] &&
> > +			(!tasks[NR_RUNNING] ||
> > +			 cpu_curr(cpu)->flags & PF_MEMSTALL);
> 
> I don't think you can do this, there is nothing that guarantees
> cpu_curr() still exists.

As discussed later in this thread, I've replaced this with time
sampling from inside scheduler_tick(): in the unlikely event that
rq->curr is PF_MEMSTALL, it'll record TICK_NSEC worth of MEM_FULL.

However:

> > +		for (s = PSI_NONIDLE; s >= 0; s--) {
> > +			u32 time, delta;
> > +
> > +			time = READ_ONCE(groupc->times[s]);
> > +			/*
> > +			 * In addition to already concluded states, we
> > +			 * also incorporate currently active states on
> > +			 * the CPU, since states may last for many
> > +			 * sampling periods.
> > +			 *
> > +			 * This way we keep our delta sampling buckets
> > +			 * small (u32) and our reported pressure close
> > +			 * to what's actually happening.
> > +			 */
> > +			if (test_state(groupc->tasks, cpu, s)) {
> > +				/*
> > +				 * We can race with a state change and
> > +				 * need to make sure the state_start
> > +				 * update is ordered against the
> > +				 * updates to the live state and the
> > +				 * time buckets (groupc->times).
> > +				 *
> > +				 * 1. If we observe task state that
> > +				 * needs to be recorded, make sure we
> > +				 * see state_start from when that
> > +				 * state went into effect or we'll
> > +				 * count time from the previous state.
> > +				 *
> > +				 * 2. If the time delta has already
> > +				 * been added to the bucket, make sure
> > +				 * we don't see it in state_start or
> > +				 * we'll count it twice.
> > +				 *
> > +				 * If the time delta is out of
> > +				 * state_start but not in the time
> > +				 * bucket yet, we'll miss it entirely
> > +				 * and handle it in the next period.
> > +				 */
> > +				smp_rmb();
> > +				time += cpu_clock(cpu) - groupc->state_start;
> > +			}
> 
> The alternative is adding an update to scheduler_tick(), that would
> ensure you're never more than nr_cpu_ids * TICK_NSEC behind.

I wasn't able to convert *all* states to tick updates like this.

The reason is that, while testing rq->curr for PF_MEMSTALL is cheap,
other tasks associated with the rq could be from any cgroup in the
system. That means we'd have to do for_each_cgroup() on every tick to
keep the groupc->times that closely uptodate, and that wouldn't scale.
We tend to have hundreds of them, some setups have thousands.

Since we don't need to be *that* current, I left the on-demand update
inside the aggregator for now. It's a bit trickier, but much cheaper.
