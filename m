Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbeDML3c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:29:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDML3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:29:31 -0400
Date: Fri, 13 Apr 2018 13:29:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Message-ID: <20180413112926.GQ4064@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413084019.GQ4043@hirez.programming.kicks-ass.net>
 <20180413111753.GT14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413111753.GT14248@e110439-lin>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 12:17:53PM +0100, Patrick Bellasi wrote:
> On 13-Apr 10:40, Peter Zijlstra wrote:
> > On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > > +static inline void init_uclamp(void)
> > 
> > WTH is that inline?
> 
> You mean I can avoid the attribute?
> ... or that I should do it in another way?

yea, its init code, no need to go all inline with that (gcc will likely
inline it anyway because static-with-single-callsite).
