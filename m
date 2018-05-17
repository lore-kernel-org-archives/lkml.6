Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQKe0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:34:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41356 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeEQKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:34:25 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joel Fernandes <joel@joelfernandes.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V2] sched/schedutil: Don't set next_freq to UINT_MAX
Date: Thu, 17 May 2018 12:33:51 +0200
Message-ID: <218097156.b89HneGrTB@aspire.rjw.lan>
In-Reply-To: <20180511204712.GA83958@joelaf.mtv.corp.google.com>
References: <dadd359a7fc0f719b9e95161b2ac469e1a3c70cc.1525861952.git.viresh.kumar@linaro.org> <20180511204712.GA83958@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 11, 2018 10:47:12 PM CEST Joel Fernandes wrote:
> On Wed, May 09, 2018 at 04:05:24PM +0530, Viresh Kumar wrote:
> > The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
> > occasions to discard the cached value of next freq:
> > - In sugov_start(), when the schedutil governor is started for a group
> >   of CPUs.
> > - And whenever we need to force a freq update before rate-limit
> >   duration, which happens when:
> >   - there is an update in cpufreq policy limits.
> >   - Or when the utilization of DL scheduling class increases.
> > 
> > In return, get_next_freq() doesn't return a cached next_freq value but
> > recalculates the next frequency instead.
> > 
> > But having special meaning for a particular value of frequency makes the
> > code less readable and error prone. We recently fixed a bug where the
> > UINT_MAX value was considered as valid frequency in
> > sugov_update_single().
> > 
> > All we need is a flag which can be used to discard the value of
> > sg_policy->next_freq and we already have need_freq_update for that. Lets
> > reuse it instead of setting next_freq to UINT_MAX.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2:
> > - Rebased over the fix sent by Rafael
> > 
> >   lkml.kernel.org/r/2276196.ev9rMjHTR0@aspire.rjw.lan
> > 
> > - Remove the additional check from sugov_update_single() as well.
> > - This is for 4.18 now instead of stable kernels.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thanks!
