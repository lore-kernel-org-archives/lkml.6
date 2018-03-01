Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032811AbeCAQJY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031777AbeCAQJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:09:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34C321771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 1 Mar 2018 17:09:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v3 3/3] sched: update blocked load when newly idle
Message-ID: <20180301160918.GC29639@lerouge>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-4-git-send-email-vincent.guittot@linaro.org>
 <20180212120411.GT25201@hirez.programming.kicks-ass.net>
 <20180212143444.GA12378@linaro.org>
 <20180212153805.GW25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212153805.GW25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:38:05PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 03:34:44PM +0100, Vincent Guittot wrote:
> > > Aside from the above being an unreadable mess, I dislike that it breaks
> > > the various isolation crud, we should not touch CPUs outside of our
> > > domain.
> > >
> > > 
> > > Maybe something like the below? (unfinished)
> > >
> > 
> > good catch. I completely miss the isolation stuff.
> > But isn't already the case when kicking ilb ? I mean that an idle CPU touches
> > all idle CPUs and some can be outside its domain during ilb.
> 
> > Shouldn't we test housekeeping_cpu(cpu, HK_FLAG_SCHED) instead if we want to
> > make sure that an isolated/full nohz CPU will not be used for updating blocked
> > load of CPUs outside its domain ?
> 
> I _thought_ we had some 'housekeeping' crud in the ilb selection logic,
> but now I can't find it. Frederic?

I think you're referring to nohz_balance_idle(). The call is still there but HK_FLAG_SCHED
is unused for now. I initially turned it on by default on nohz_full but some people
complained. I don't recall why exactly. Anyway I'm waiting for a suitable interface
to use it.
