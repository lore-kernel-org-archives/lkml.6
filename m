Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55821C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092942086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092942086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeIJOgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:36:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbeIJOgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:36:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B6B18A;
        Mon, 10 Sep 2018 02:43:06 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90D783F557;
        Mon, 10 Sep 2018 02:43:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 10:43:01 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Message-ID: <20180910094255.nzjjsiphjplh7ruk@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
 <20180906143842.xlxcg5notwdaflww@queper01-lin>
 <1545744.fI5ZvP8FO0@aspire.rjw.lan>
 <20180907152923.oxsmcqciez4yhmkk@queper01-lin>
 <CAJZ5v0gs1Fb-Y1FbjmnxLNHQR=CSHFX_=KpDEkqRCYDJ9EJByQ@mail.gmail.com>
 <20180910082411.oyedkqerxs6b7um5@queper01-lin>
 <CAJZ5v0jSE2u7DpT6KBiR=zEN0RSBq4cO1Ve=e+pju6cwj8toFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jSE2u7DpT6KBiR=zEN0RSBq4cO1Ve=e+pju6cwj8toFQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 Sep 2018 at 10:55:43 (+0200), Rafael J. Wysocki wrote:
> On Mon, Sep 10, 2018 at 10:24 AM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > On Sunday 09 Sep 2018 at 22:13:52 (+0200), Rafael J. Wysocki wrote:
> > > On Fri, Sep 7, 2018 at 5:29 PM Quentin Perret <quentin.perret@arm.com> wrote:
> > > > On Friday 07 Sep 2018 at 10:52:01 (+0200), Rafael J. Wysocki wrote:
> > > > > Well, why don't you implement it as something like "if the governor changes
> > > > > from sugov to something else (or the other way around), call this function
> > > > > from the scheduler"?
> > > >
> > > > I just gave it a try and ended up with the diff below. It's basically
> > > > the exact same patch with a direct function call instead of a notifier.
> > > > (I also tried the sugov_start/stop thing I keep mentioning but it is
> > > > more complex, so let's see if the simplest solution could work first).
> > > >
> > > > What do you think ?
> > >
> > > This generally works for me from the cpufreq perspective, but I would
> > > add "cpufreq" to the name of the new function, that is call it
> > > something like sched_cpufreq_governor_change().
> >
> > Ok, no problem.
> >
> > > Also do you really need the extra work item?  Governor changes are
> > > carried out in process context anyway.
> >
> > Ah, good point, I can remove that. I just tried and got the following
> > lock warning on boot, though:
> >
> > [    2.518684] ============================================
> > [    2.523942] WARNING: possible recursive locking detected
> > [    2.529200] 4.18.0-rc6-00086-g940e7a9fd5ec #10 Not tainted
> > [    2.534630] --------------------------------------------
> > [    2.539888] kworker/2:3/1349 is trying to acquire lock:
> > [    2.545059] (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: rebuild_sched_domains_locked+0x2c/0x598
> > [    2.554559]
> > [    2.554559] but task is already holding lock:
> > [    2.560332] (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: cpufreq_register_driver+0x80/0x1d0
> > [    2.569396]
> > [    2.569396] other info that might help us debug this:
> > [    2.575858]  Possible unsafe locking scenario:
> > [    2.575858]
> > [    2.581717]        CPU0
> > [    2.584135]        ----
> > [    2.586553]   lock(cpu_hotplug_lock.rw_sem);
> > [    2.590785]   lock(cpu_hotplug_lock.rw_sem);
> > [    2.595017]
> > [    2.595017]  *** DEADLOCK ***
> > [    2.595017]
> > [    2.600877]  May be due to missing lock nesting notation
> >
> > That seems to happen because cpufreq_register_driver() calls
> > cpus_read_lock(), which is then called again by rebuild_sched_domains()
> > down the line. So it might just be a missing lock nesting notation as
> > the warning suggests ?
> >
> > I'll have a look.
> 
> It only is nested in the _register_driver() code path, otherwise it may not be.

Right.

> Using the work item may be the most straightforward way to deal with
> that, but then I would add a comment to explain what's up.

Indeed, rw_sems don't seem to be appropriate for nested locking:
https://elixir.bootlin.com/linux/latest/source/include/linux/rwsem.h#L156

I'll stick a comment explaining that for now, unless I find a better
idea than using a work item in the meantime.

Thanks,
Quentin
