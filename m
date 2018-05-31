Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeEaKru (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:47:50 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50604 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeEaKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:47:46 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v3 1/2] sched/cpufreq: always consider blocked FAIR utilization
Date: Thu, 31 May 2018 12:46:55 +0200
Message-ID: <1882135.N2Fi74R5Qz@aspire.rjw.lan>
In-Reply-To: <20180530165010.GK30654@e110439-lin>
References: <20180524141023.13765-1-patrick.bellasi@arm.com> <CAJZ5v0iq-k4QeeEm6vzfWNLkXxNtLZa0Y9_bBcYWCGQ_FjzgDQ@mail.gmail.com> <20180530165010.GK30654@e110439-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 6:50:10 PM CEST Patrick Bellasi wrote:
> On 27-May 11:50, Rafael J. Wysocki wrote:
> > On Thu, May 24, 2018 at 4:10 PM, Patrick Bellasi
> > <patrick.bellasi@arm.com> wrote:
> > > Since the refactoring introduced by:
> > >
> > >    commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
> > >
> > > we aggregate FAIR utilization only if this class has runnable tasks.
> > > This was mainly due to avoid the risk to stay on an high frequency just
> > > because of the blocked utilization of a CPU not being properly decayed
> > > while the CPU was idle.
> > >
> > > However, since:
> > >
> > >    commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
> > >
> > > the FAIR blocked utilization is properly decayed also for IDLE CPUs.
> > >
> > > This allows us to use the FAIR blocked utilization as a safe mechanism
> > > to gracefully reduce the frequency only if no FAIR tasks show up on a
> > > CPU for a reasonable period of time.
> > >
> > > Moreover, we also reduce the frequency drops of CPUs running periodic
> > > tasks which, depending on the task periodicity and the time required
> > > for a frequency switch, was increasing the chances to introduce some
> > > undesirable performance variations.
> > >
> > > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Joel Fernandes <joelaf@google.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Or please let me know if you want me to apply this one.
> 
> Hi Rafael, seems this patch has already been applied in tip/sched/core.
> However is missing your tag above. :/

That's OK.

I just wanted to let people know my opinion. :-)
