Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeFEQyi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:54:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbeFEQyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:54:36 -0400
Date: Tue, 5 Jun 2018 17:54:31 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
Message-ID: <20180605165431.GF32302@e110439-lin>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <CAKfTPtD8RDxT=-oO2VYJRbtwoEyEKEAau-Ad-bAd8L2T2zKWEg@mail.gmail.com>
 <20180605151129.GC32302@e110439-lin>
 <20180605153105.GM16081@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605153105.GM16081@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Jun 17:31, Juri Lelli wrote:
> On 05/06/18 16:11, Patrick Bellasi wrote:
> 
> [...]
> 
> > If I run an experiment with your example above, while using the
> > performance governor to rule out any possible scale invariance
> > difference, here is what I measure:
> > 
> >    Task1 (40ms delayed by the following Task2):
> >                                mean          std     max
> >       running_avg        455.387449    22.940168   492.0
> >       util_avg           433.233288    17.395477   458.0
> > 
> >    Task2 (waking up at same time of Task1 and running before):
> >                                mean          std     max
> >       running_avg        430.281834    22.405175   455.0
> >       util_avg           421.745331    22.098873   456.0
> > 
> > and if I compare Task1 above with another experiment where Task1 is
> > running alone:
> > 
> >    Task1 (running alone):
> >                                mean          std     min
> >       running_avg        460.257895    22.103704   460.0
> >       util_avg           435.119737    17.647556   461.0
> 
> Wait, why again in this last case running_avg != util_avg? :)

I _think_ it's mostly due to the rouding errors we have because of the
reasons I've explained in the reply to Joel:

   https://lkml.org/lkml/2018/6/5/559
   20180605152156.GD32302@e110439-lin

at the end, while commenting about the division overhead.

I should try the above examples while tracking the full signal at
___update_load_avg() time.

-- 
#include <best/regards.h>

Patrick Bellasi
