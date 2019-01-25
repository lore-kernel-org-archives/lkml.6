Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B0B218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENrEsONO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfAYKEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:04:45 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42273 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfAYKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:04:44 -0500
Received: by mail-ua1-f68.google.com with SMTP id d21so3040895uap.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36F1UyrhDpsJESxu4ZGkKTzuU4bNd6HP1thiwh5cFRo=;
        b=ENrEsONOxK7lU6jrUha4iAGX+QSos40HGj9coQLsdczjqQ4ivfEoIVMme5KT5qeEyf
         UbFSQV4DrpmUG/11C0Qjhv/sg7fQ/wvvmWBYkRG+IqjpeQbBTE6rRFyaGYOneyIsIBDc
         FvWxIYjKzfZvLHIyKv24yJOOvPZ5jYSnBONTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36F1UyrhDpsJESxu4ZGkKTzuU4bNd6HP1thiwh5cFRo=;
        b=NA6bNEbg3cv0+S80IjQPGS2nVDvQ1jgKAGLdAIrUuJNfhTuneV3WuhZiNvuZr0jT70
         nj+lkMkrluSwPxGX3qLBRnofrlbXIxnfmL2MP5M3hzIhPSZyEhVG63oEyYOZ6lQeULmz
         vdUcZZ0ed0M4LYUpxYr/ungzSKpzp81mXIjFw79wBYcFrws/VSJL4xGKpwsrlT4OjvqA
         Gsv+YhWmxuftcw+/+N8H+nOSGLg3KL7pwA2Ai2qFRuvrfNkkXzx7VD1DQ/QQTVnSCn0C
         gr1fkLCwhuogGvldu7Q/p8Ir0KEcgU8yxiv8RUcyb0AMvrAx+9lj83gq8bkxkOs5HPzk
         Gycg==
X-Gm-Message-State: AJcUukdD+ZLmhkfzYXoaoo/HEVzrSGyTztbuuUOxddY4Aeu3zxQYssDn
        04BApRffW3TkDxGk6oQvrE/hA1Qw15HEjwpVjsTH8Q==
X-Google-Smtp-Source: ALg8bN4L5VP4ph1HqjNAQH0JLvh/gz+aYxPplJ6n0Q8Zc+jWQeDbyiMLLfJXavtUfn688JnHqpKGwphwGPAhKwkYnxI=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr4314298uar.39.1548410683029;
 Fri, 25 Jan 2019 02:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-4-ulf.hansson@linaro.org> <119031115.C8gHTGbYmQ@aspire.rjw.lan>
 <CAPDyKFqQQnMKFNpGyi_dkP_Rm8qo-1WjPfVkp2unOxyXRa2wbA@mail.gmail.com>
 <CAJZ5v0iY7j5SThQhtq5xP+g5yNiHQ+cMWxq-tdVh3t5wJ_s3Tw@mail.gmail.com> <CAPDyKFr6nD6hazmsGqT-Z-Z67oime75Yavr+SuL0P_MZF3HZGQ@mail.gmail.com>
In-Reply-To: <CAPDyKFr6nD6hazmsGqT-Z-Z67oime75Yavr+SuL0P_MZF3HZGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Jan 2019 11:04:06 +0100
Message-ID: <CAPDyKFoRZyTpccWaE7TZXM=E2xRevqX9MxMGnuq6P=qfYQfBtg@mail.gmail.com>
Subject: Re: [PATCH v10 03/27] timer: Export next wakeup time of a CPU
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > > +/**
> > > > > + * tick_nohz_get_next_wakeup - return the next wake up of the CPU
> > > > > + * @cpu: the particular CPU to get next wake up for
> > > > > + *
> > > > > + * Called for idle CPUs only.
> > > > > + */
> > > > > +ktime_t tick_nohz_get_next_wakeup(int cpu)
> > > > > +{
> > > > > +     struct clock_event_device *dev = per_cpu(tick_cpu_device.evtdev, cpu);
> > > > > +
> > > > > +     return dev->next_event;
> > > > > +}
> > > > > +
> > > > >  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
> > > > >  {
> > > > >  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> > > > >
> > > >
> > > > Well, I have concerns regarding this one.
> > > >
> > > > I don't believe it is valid to call this new function for non-idle CPUs and
> > > > the kerneldoc kind of says so, but the next patch doesn't actually prevent
> > > > it from being called for a non-idle CPU (at the time it is called in there
> > > > the target CPU may not be idle any more AFAICS).
> > >
> > > You are correct, but let me clarify things.
> > >
> > > We are calling this new API from the new genpd governor, which may
> > > have a cpumask indicating there is more than one CPU attached to its
> > > PM domain+sub-PM domains. In other words, we may call the API for
> > > another CPU than the one we are executing on.
> > >
> > > When the new genpd governor is called, all CPUs in the cpumask of the
> > > genpd in question, are already runtime suspended and will remain so
> > > throughout the decisions made by the governor.
> > >
> > > However, because of the race condition, which needs to be manged by
> > > the genpd backend driver and its corresponding FW, one of the CPU in
> > > the genpd cpumask could potentially wake up from idle when the genpd
> > > governor runs. However, as a part of exiting from idle, that CPU needs
> > > to wait for the call to pm_runtime_get_sync() to return before
> > > completing the exit patch of idle. This also means waiting for the
> > > genpd governor to finish.
> >
> > OK, so the CPU spins on a spin lock inside of the idle loop with interrupts off.
>
> Correct.
>
> This is the part that is not very nice, but ideally it should be a
> rather rare condition as it only happens during the last man standing
> point.
>
> >
> > > The point is, no matter what decision the governor takes under these
> > > circumstances, the genpd backend driver and its FW must manage this
> > > race condition during the last man standing. For PSCI OSI mode, it
> > > means that if a cluster idle state is suggested by Linux during these
> > > circumstances, it must be prevented and aborted.
> >
> > I would suggest putting a comment to explain that somewhere as it is
> > not really obvious.
>
> Let me see if can squeeze in that somewhere, probably it's best suited
> in the new genpd governor code somewhere.
>
> >
> > > >
> > > > In principle, the cpuidle core can store this value, say in struct
> > > > cpuidle_device of the given CPU, and expose a helper to access it from
> > > > genpd, but that would be extra overhead totally unnecessary on everthing
> > > > that doesn't use genpd for cpuidle.
> > > >
> > > > So maybe the driver could store it in its ->enter callback?  After all,
> > > > the driver knows that genpd is going to be used later.
> > >
> > > This would work, but it wouldn't really change much when it comes to
> > > the race condition described above.
> >
> > No, it wouldn't make the race go away.
> >
> > > Of course it would turn the code
> > > into being more cpuidle specific, which seems reasonable to me.
> > >
> > > Anyway, if I understand your suggestion, in principle it means
> > > changing $subject patch in such way that the API should not take "int
> > > cpu" as an in-parameter, but instead only use __this_cpu() to read out
> > > the next event for current idle CPU.
> >
> > Yes.

I have looked closer to this and it turned out that it seems that I
should probably not need introduce an entirely new thing here. Instead
I should likely be able to re-factor the current
tick_nohz_get_sleep_length() and tick_nohz_next_event(), as those are
in principle doing the similar things as I need. So I started hacking
on that, when Daniel Lezcano told me that he already have a patch
doing exactly what I want. :-) However, in the context of his "next
wakeup prediction" work, but that shouldn't matter.

If I can make it work, I will fold in his patch in the next version of
the series instead.

Please tell if you already at this point, see any issues with this approach.

> >
> > > Additionally, we need another new cpuidle API, which genpd can call to
> > > retrieve a new per CPU "next event data" stored by the cpuidle driver
> > > from its ->enter() callback. Is this a correct interpretation of your
> > > suggestion?
> >
> > Yes, it is.
>
> Thanks for confirming!
>
> >
> > Generally, something like "cpuidle, give me the wakeup time of this
> > CPU".  And it may very well give you 0 if the CPU has woken up
> > already. :-)
>
> Yep, I was thinking something like that, so in principle it may
> minimize the window of receiving in-correct "next wakeup data" in
> genpd for a non-idle CPU, but again it doesn't solve the race
> condition.
>

Kind regards
Uffe
