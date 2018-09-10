Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4368120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4368120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeIJNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:48:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36017 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeIJNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:48:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so38682501oie.3;
        Mon, 10 Sep 2018 01:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGLsywjddJXC95QmXvnQeAyW7HEgg9qQMTLWVdRMHXY=;
        b=i2MfCJO4MB4WwZ/uuLpmhbhYk6y4jdFW0vC3OxY+YgMqIYjRG9+NIM+uUC8muyY9Qb
         7vaGp0BrHURTY18hVmU0JkgL/tWa8lU1ET5RAihe+a/QhjWtkoshNJUxAXdJw8Ssze6L
         5V2iXcrZS/F486qU/pEEGR5sTcUsylak4vDoTZcmG+7cK3tDEMUyEyfh1dGiKdAtlzpM
         CAOgRmHDU3opUCvuRuigSLuGDPE4PhAKaxVL3Ri3mtUZM+TV3kWMTD5a6FkiqI71855T
         W3oVYTnRsyf9khfHywm06ia3oxZ/57hE8SUpcoDPmEuipaPCQ/8tIclNs/yOAuFZlvu/
         p5SQ==
X-Gm-Message-State: APzg51D1FKfXGSy8F/niTd9NH4eBQdYB42EdGpSPZUADHMnTzv0mxw8E
        2FbZByDLYAKn1VSEOPEMxXnXzrY5Cx51gDx964s=
X-Google-Smtp-Source: ANB0VdbfaqX79qyWJFaixVafokkuZoTeH4Qp9QjUEiDloBYNry6nfvmMhODJzELao8vy1pN3+tFxBaKd7BMvrYeBgSc=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr21844174oif.177.1536569755181;
 Mon, 10 Sep 2018 01:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <CAJZ5v0jL_k36RPc6e8yUHxAYGXp7HHWK+hLnBZWnu5Oi__7j3w@mail.gmail.com>
 <20180906143842.xlxcg5notwdaflww@queper01-lin> <1545744.fI5ZvP8FO0@aspire.rjw.lan>
 <20180907152923.oxsmcqciez4yhmkk@queper01-lin> <CAJZ5v0gs1Fb-Y1FbjmnxLNHQR=CSHFX_=KpDEkqRCYDJ9EJByQ@mail.gmail.com>
 <20180910082411.oyedkqerxs6b7um5@queper01-lin>
In-Reply-To: <20180910082411.oyedkqerxs6b7um5@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Sep 2018 10:55:43 +0200
Message-ID: <CAJZ5v0jSE2u7DpT6KBiR=zEN0RSBq4cO1Ve=e+pju6cwj8toFQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:24 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Rafael,
>
> On Sunday 09 Sep 2018 at 22:13:52 (+0200), Rafael J. Wysocki wrote:
> > On Fri, Sep 7, 2018 at 5:29 PM Quentin Perret <quentin.perret@arm.com> wrote:
> > > On Friday 07 Sep 2018 at 10:52:01 (+0200), Rafael J. Wysocki wrote:
> > > > Well, why don't you implement it as something like "if the governor changes
> > > > from sugov to something else (or the other way around), call this function
> > > > from the scheduler"?
> > >
> > > I just gave it a try and ended up with the diff below. It's basically
> > > the exact same patch with a direct function call instead of a notifier.
> > > (I also tried the sugov_start/stop thing I keep mentioning but it is
> > > more complex, so let's see if the simplest solution could work first).
> > >
> > > What do you think ?
> >
> > This generally works for me from the cpufreq perspective, but I would
> > add "cpufreq" to the name of the new function, that is call it
> > something like sched_cpufreq_governor_change().
>
> Ok, no problem.
>
> > Also do you really need the extra work item?  Governor changes are
> > carried out in process context anyway.
>
> Ah, good point, I can remove that. I just tried and got the following
> lock warning on boot, though:
>
> [    2.518684] ============================================
> [    2.523942] WARNING: possible recursive locking detected
> [    2.529200] 4.18.0-rc6-00086-g940e7a9fd5ec #10 Not tainted
> [    2.534630] --------------------------------------------
> [    2.539888] kworker/2:3/1349 is trying to acquire lock:
> [    2.545059] (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: rebuild_sched_domains_locked+0x2c/0x598
> [    2.554559]
> [    2.554559] but task is already holding lock:
> [    2.560332] (____ptrval____) (cpu_hotplug_lock.rw_sem){++++}, at: cpufreq_register_driver+0x80/0x1d0
> [    2.569396]
> [    2.569396] other info that might help us debug this:
> [    2.575858]  Possible unsafe locking scenario:
> [    2.575858]
> [    2.581717]        CPU0
> [    2.584135]        ----
> [    2.586553]   lock(cpu_hotplug_lock.rw_sem);
> [    2.590785]   lock(cpu_hotplug_lock.rw_sem);
> [    2.595017]
> [    2.595017]  *** DEADLOCK ***
> [    2.595017]
> [    2.600877]  May be due to missing lock nesting notation
>
> That seems to happen because cpufreq_register_driver() calls
> cpus_read_lock(), which is then called again by rebuild_sched_domains()
> down the line. So it might just be a missing lock nesting notation as
> the warning suggests ?
>
> I'll have a look.

It only is nested in the _register_driver() code path, otherwise it may not be.

Using the work item may be the most straightforward way to deal with
that, but then I would add a comment to explain what's up.

Thanks,
Rafael
