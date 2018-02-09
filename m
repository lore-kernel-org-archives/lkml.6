Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeBIKiQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:38:16 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55401 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBIKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:38:15 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Fri, 09 Feb 2018 11:36:30 +0100
Message-ID: <11598161.veS9VGWB8G@aspire.rjw.lan>
In-Reply-To: <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com> <20180209035143.GX28462@vireshk-i7> <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 9, 2018 9:02:34 AM CET Claudio Scordino wrote:
> Hi Viresh,
> 
> Il 09/02/2018 04:51, Viresh Kumar ha scritto:
> > On 08-02-18, 18:01, Claudio Scordino wrote:
> >> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> >> we should not wait for the rate limit, otherwise we may miss some deadline.
> >>
> >> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
> >> misses for tasks with low RT periods.
> >>
> >> The patch applies on top of the one recently proposed by Peter to drop the
> >> SCHED_CPUFREQ_* flags.
> >>

[cut]

> 
> > 
> > Is it possible to (somehow) check here if the DL tasks will miss
> > deadline if we continue to run at current frequency? And only ignore
> > rate-limit if that is the case ?
> 
> I need to think further about it.

That would be my approach FWIW.

Increasing the frequency beyond what is necessary means wasting energy
in any case.

Thanks,
Rafael
