Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751328AbeDYINm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:13:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDYINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:13:38 -0400
Date: Wed, 25 Apr 2018 09:13:35 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, c@hirez.programming.kicks-ass.net
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180425081334.GF14391@e108498-lin.cambridge.arm.com>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
 <20180425051509.aohopadqw7q5urbd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425051509.aohopadqw7q5urbd@vireshk-i7>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 Apr 2018 at 10:45:09 (+0530), Viresh Kumar wrote:
> On 24-04-18, 14:35, Peter Zijlstra wrote:
> > In any case, if there not going to be conflicts here, this all looks
> > good.
> 
> Thanks Peter.
> 
> I also had another patch and wasn't sure if that would be the right
> thing to do. The main purpose of this is to avoid calling
> sync_entity_load_avg() unnecessarily.

While you're at it, you could probably remove the one in wake_cap() ? I
think having just one in select_task_rq_fair() should be enough.

Thanks,
Quentin
