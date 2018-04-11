Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDKOyN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:54:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37741 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeDKOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:54:10 -0400
X-Google-Smtp-Source: AIpwx49WWqXyDC1rk14hl4nYV3A5fyWLK+Y/XnutrdhMTYc8wY3qGgnWyrCBAlu97fBgIpJ23CsGQg==
Date: Wed, 11 Apr 2018 20:24:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Message-ID: <20180411145407.GQ7671@vireshk-i7>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
 <20180410193708.GE4043@hirez.programming.kicks-ass.net>
 <20180411104445.GM14248@e110439-lin>
 <20180411105828.GL4082@hirez.programming.kicks-ass.net>
 <20180411143921.GP14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411143921.GP14248@e110439-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-18, 15:39, Patrick Bellasi wrote:
> On 11-Apr 12:58, Peter Zijlstra wrote:
> > On Wed, Apr 11, 2018 at 11:44:45AM +0100, Patrick Bellasi wrote:
> > > > > - sugov_set_iowait_boost: is now in charge only to set/increase the IO
> > > > >      wait boost, every time a task wakes up from an IO wait.
> > > > > 
> > > > > - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
> > > > >      boost, every time a sugov update is triggered, as well as
> > > > >      to (eventually) enforce the currently required IO boost value.
> > > > 
> > > > I'm not sold on those function names; feels like we can do better,
> > > > although I'm struggling to come up with anything sensible just now.
> > > 
> > > What about something like:
> > > 
> > >  sugov_iowait_init()
> > >  since here we are mainly initializing the iowait boost
> > > 
> > >  sugov_iowait_boost()
> > >  since here we are mainly applying the proper boost to each cpu
> > > 
> > > Although they are not really so different...
> > 
> > How about:
> > 
> >   sugov_iowait_boost() -- does the actual impulse/boost
> >   sugov_iowait_apply() -- applies the boost state
> > 
> > ?
> 
> Whould say it can work too, and it also allows to add a:
> 
>     sugov_iowait_reset() -- resets boots state after
>                             TICK_NSEC CPU idle time
> 
> Viresh, Rafael, Joel: any preferences or other suggestions?

Looks like no matter how we rename it, someone will find it confusing
:)

-- 
viresh
