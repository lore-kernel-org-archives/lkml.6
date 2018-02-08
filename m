Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeBHPqv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:46:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47712 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeBHPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:46:48 -0500
Date: Thu, 8 Feb 2018 16:46:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@foss.arm.com, brendan.jackman@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
Message-ID: <20180208154643.GB25181@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <20180208140005.GH25201@hirez.programming.kicks-ass.net>
 <20180208153030.GB17775@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208153030.GB17775@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 03:30:31PM +0000, Will Deacon wrote:
> On Thu, Feb 08, 2018 at 03:00:05PM +0100, Peter Zijlstra wrote:

> > Without this ordering I think it would be possible to loose has_blocked
> > and not observe the CPU either.
> 
> I had a quick look at this, and I think you're right. This looks very much
> like an 'R'-shaped test, which means it's smp_mb() all round otherwise Power
> will go wrong. That also means the smp_mb__after_atomic() in
> nohz_balance_enter_idle *cannot* be an smp_wmb(), so you might want a
> comment stating that explicitly.

Thanks Will. BTW, where does that 'R' shape nomenclature come from?
This is the first I've heard of it.
