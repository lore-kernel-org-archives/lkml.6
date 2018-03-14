Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeCNLUG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:20:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45261 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeCNLUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:20:04 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Joel Fernandes <joelaf@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Wed, 14 Mar 2018 12:20:38 +0100
Message-ID: <2122625.mgU2W7rFO1@aspire.rjw.lan>
In-Reply-To: <CAJWu+orsBLQdjGJZKOnLP15M-aKboiDPVTQ2W+8tiHpgNLexMg@mail.gmail.com>
References: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com> <20180313111506.GC15832@vireshk-i7> <CAJWu+orsBLQdjGJZKOnLP15M-aKboiDPVTQ2W+8tiHpgNLexMg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 2:27:53 AM CET Joel Fernandes wrote:
> On Tue, Mar 13, 2018 at 4:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 13-03-18, 11:35, Claudio Scordino wrote:
> >> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> >> we should not wait for the rate limit, otherwise we may miss some
> >> deadline.
> >>
> >> Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
> >> shown reductions of even 10% of deadline misses with a negligible
> >> increase of energy consumption (measured through Baylibre Cape).
> >>
> >> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> CC: Viresh Kumar <viresh.kumar@linaro.org>
> >> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> >> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> CC: Morten Rasmussen <morten.rasmussen@arm.com>
> >> CC: Juri Lelli <juri.lelli@redhat.com>
> >> CC: Vincent Guittot <vincent.guittot@linaro.org>
> >> CC: Todd Kjos <tkjos@android.com>
> >> CC: Joel Fernandes <joelaf@google.com>
> >> CC: linux-pm@vger.kernel.org
> >> CC: linux-kernel@vger.kernel.org
> >> ---
> >> Changes from v3:
> >>  - Specific routine renamed as ignore_dl_rate_limit()
> >
> > LGTM. Thanks.
> 
> Nice! Thanks.

OK, the patch doesn't seem to depend on anything in -tip, so I'm going to
apply it.

Thanks!
