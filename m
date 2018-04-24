Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757430AbeDXMfb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:35:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757400AbeDXMf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:35:28 -0400
Date: Tue, 24 Apr 2018 14:35:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
        c@hirez.programming.kicks-ass.net
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180424123523.GF4064@hirez.programming.kicks-ass.net>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:19:07PM +0100, Valentin Schneider wrote:
> On 24/04/18 11:43, Peter Zijlstra wrote:
> > On Tue, Apr 24, 2018 at 11:02:26AM +0100, Valentin Schneider wrote:
> >> I'd argue making things easier to read is a non-negligible part as well.
> > 
> > Right, so I don't object to either of these (I think); but it would be
> > good to see this in combination with that proposed EAS change.
> > 
> 
> True, I would've said the call to find_energy_efficient_cpu() ([1]) could
> simply be added to the if (sd) {} case, but...

I think the proposal was to put it before the for_each_domain() loop
entirely, however...

> > I think you (valentin) wanted to side-step the entire domain loop in
> > that case or something.
> > 
> 
> ...this would change more things. Admittedly I've been sort of out of the loop
> (no pun intended) lately, but this doesn't ring a bell. That might have been
> the other frenchie (Quentin) :)

It does indeed appear I confused the two of you, it was Quentin playing
with that.

In any case, if there not going to be conflicts here, this all looks
good.
