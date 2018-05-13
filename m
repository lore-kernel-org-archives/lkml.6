Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEMIkg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:40:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41226 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeEMIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:40:35 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: rafael.j.wysocki@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: [PATCH] kernel/sched/cpufreq_schedutil: remove stale comment
Date: Sun, 13 May 2018 10:40:04 +0200
Message-ID: <8037017.m44Qr41QWi@aspire.rjw.lan>
In-Reply-To: <20180509084154.dbbhkegrengsw3ki@vireshk-i7>
References: <20180509084051.12107-1-juri.lelli@redhat.com> <20180509084154.dbbhkegrengsw3ki@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 9, 2018 10:41:54 AM CEST Viresh Kumar wrote:
> On 09-05-18, 10:40, Juri Lelli wrote:
> > After commit 794a56ebd9a57 ("sched/cpufreq: Change the worker kthread to
> > SCHED_DEADLINE") schedutil kthreads are "ignored" for a clock frequency
> > selection point of view, so the potential corner case for RT tasks is not
> > possible at all now.
> > 
> > Remove the stale comment mentioning it.
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Claudio Scordino <claudio@evidence.eu.com>
> > Cc: Luca Abeni <luca.abeni@santannapisa.it>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 13 -------------
> >  1 file changed, 13 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index d2c6083304b4..23ef19070137 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -396,19 +396,6 @@ static void sugov_irq_work(struct irq_work *irq_work)
> >  
> >  	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
> >  
> > -	/*
> > -	 * For RT tasks, the schedutil governor shoots the frequency to maximum.
> > -	 * Special care must be taken to ensure that this kthread doesn't result
> > -	 * in the same behavior.
> > -	 *
> > -	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
> > -	 * updated only at the end of the sugov_work() function and before that
> > -	 * the schedutil governor rejects all other frequency scaling requests.
> > -	 *
> > -	 * There is a very rare case though, where the RT thread yields right
> > -	 * after the work_in_progress flag is cleared. The effects of that are
> > -	 * neglected for now.
> > -	 */
> >  	kthread_queue_work(&sg_policy->worker, &sg_policy->work);
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied and pushed for 4.17-rc5.
