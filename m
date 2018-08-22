Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1976C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B0220A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="zMr/NBJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B0220A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHVUyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:54:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42012 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeHVUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:54:14 -0400
Received: by mail-yw1-f67.google.com with SMTP id n207-v6so931456ywn.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0fqYneS8rObbjrQtaVaioH+NNLEqKGl0wY/oATv9iXk=;
        b=zMr/NBJzORtE1COVfHArW9FY3wL+CbxviCU//4jeV194L2ftzIk+l+qA2p5rCW/Gdq
         11Os04dc43eIa0tEDp9oFg/y+Wo6lsqcyG4FDCxC5aH71q59ijQPQkeRNbm5dOOD4Io7
         aWhzN6IkM0yvn6C9AJt+0Ft65+pOMvYJgILrqhaQdPx/Poj1xuuq+m4nlfUIvU64XBk8
         rhTxgyiwJtR6Ysoo97y7QX/aRjhHlatDrZ9GerLkrAhB6GJ7AYO9XTeNWSn+W3jwU7Av
         kWrqQi83dDWfU304d8y4A3MFqjsMOh9Z4SyIb4YEjffsNprKHUp1LKX930wyl26XGNsK
         wgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0fqYneS8rObbjrQtaVaioH+NNLEqKGl0wY/oATv9iXk=;
        b=LZYT22QdrztDn+uiIN+EBxY8/nKD2OPmuo4R0HrvYx4YDYckD7Wn3tXxaFSAJyB0La
         Q7yFmQtZnzqNlpyL7JvUZW7aCCIDzy6eEIvCOSox/mNQvCeoaPWhmemCxIgISEPVSHy8
         dNpOcbCTGHEGchqszC2OUrICeYyfG8Sq7EY7PpNFz/HKdsCcfZhCpVz38E97Qu2uXyAC
         CdeIiM6M6k7ka9lvSIx+LqMjkmat+CxLW/N7NWlBjfKEWWUxgPxhQEvDJbEHF6ud96La
         YDNvpT3A8eUniKdeQdh/ccezKuo/8PvRjMupZr8n0wl9V15lwR/JYmJik6l64hCQN4tO
         XN4w==
X-Gm-Message-State: APzg51AjyEL5J3DFwpFW8T2CpZ1CF0GJBjivajc9g8D7uIOnjmrVMMwT
        jBsd5keeDJfuNtHCSuhM8Fm/nA==
X-Google-Smtp-Source: ANB0VdaEjyEQVMaFpTkj2y+EiCe6Dg2Jk0qgk7t2zsbkI5h+Ol28radhZZe415cga6g+3x8Vlihthw==
X-Received: by 2002:a0d:c6c5:: with SMTP id i188-v6mr604994ywd.262.1534958907476;
        Wed, 22 Aug 2018 10:28:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:8f6c])
        by smtp.gmail.com with ESMTPSA id r3-v6sm883206ywd.82.2018.08.22.10.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 10:28:26 -0700 (PDT)
Date:   Wed, 22 Aug 2018 13:28:25 -0400
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
Message-ID: <20180822172825.GA1317@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803172139.GE2494@hirez.programming.kicks-ass.net>
 <20180821201115.GB24538@cmpxchg.org>
 <20180822091024.GU24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822091024.GU24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:10:24AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 21, 2018 at 04:11:15PM -0400, Johannes Weiner wrote:
> > On Fri, Aug 03, 2018 at 07:21:39PM +0200, Peter Zijlstra wrote:
> > > On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> > > > +			time = READ_ONCE(groupc->times[s]);
> > > > +			/*
> > > > +			 * In addition to already concluded states, we
> > > > +			 * also incorporate currently active states on
> > > > +			 * the CPU, since states may last for many
> > > > +			 * sampling periods.
> > > > +			 *
> > > > +			 * This way we keep our delta sampling buckets
> > > > +			 * small (u32) and our reported pressure close
> > > > +			 * to what's actually happening.
> > > > +			 */
> > > > +			if (test_state(groupc->tasks, cpu, s)) {
> > > > +				/*
> > > > +				 * We can race with a state change and
> > > > +				 * need to make sure the state_start
> > > > +				 * update is ordered against the
> > > > +				 * updates to the live state and the
> > > > +				 * time buckets (groupc->times).
> > > > +				 *
> > > > +				 * 1. If we observe task state that
> > > > +				 * needs to be recorded, make sure we
> > > > +				 * see state_start from when that
> > > > +				 * state went into effect or we'll
> > > > +				 * count time from the previous state.
> > > > +				 *
> > > > +				 * 2. If the time delta has already
> > > > +				 * been added to the bucket, make sure
> > > > +				 * we don't see it in state_start or
> > > > +				 * we'll count it twice.
> > > > +				 *
> > > > +				 * If the time delta is out of
> > > > +				 * state_start but not in the time
> > > > +				 * bucket yet, we'll miss it entirely
> > > > +				 * and handle it in the next period.
> > > > +				 */
> > > > +				smp_rmb();
> > > > +				time += cpu_clock(cpu) - groupc->state_start;
> > > > +			}
> > > 
> > > As is, groupc->state_start needs a READ_ONCE() above and a WRITE_ONCE()
> > > below. But like stated earlier, doing an update in scheduler_tick() is
> > > probably easier.
> > 
> > I've wrapped these in READ_ONCE/WRITE_ONCE.
> 
> I just realized, these are u64, so READ_ONCE/WRITE_ONCE will not work
> correct on 32bit.

Ah, right.

Actually, that race described in the comment above - "If the time
delta is out of state_start but not in the time bucket yet, we'll miss
it entirely and handle it in the next period" - can cause bogus time
samples if state persists for more than 2s. Because if we observed a
live state and included it in our private copy of the time bucket
(times_prev), missing the delta in transit to the time bucket in the
next aggregation results in times_prev being ahead of 'time', which
causes the delta to underflow into a bogusly large sample.

Memory barriers alone cannot guarantee full coherency here (neither
seeing the delta twice, nor missing it entirely) so I'm switching this
over to seqcount to make sure the aggregator sees something sensible.

And then I don't need the READ_ONCE/WRITE_ONCE.
