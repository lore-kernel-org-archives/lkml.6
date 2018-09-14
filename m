Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD6EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DD220861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DD220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeINQsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:48:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34780 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:48:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12-v6so4238582otl.1;
        Fri, 14 Sep 2018 04:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QfFIQD21TzZagJqmH+2KrLKAy9nQnSeVvnoZtkagi0=;
        b=IwF6HZ1HDr/OiuvtVqF/aOvn//XRE9eNOs/D3RUbm15/Lyi10bbZMZN/s2xNQzgbYc
         IW/vrsKOWyaD/gVNr5nnsNGgGz+FwISWNeEXtFDiKHjahDO7APCH1PDFLrVMdtWCy72s
         D+1IYXQhTQbPwDZ6rEE8iyXtpmhFKRXWVT0eSaASilv64n99GKbHgCJ+8HeK7LgivC9o
         uMf9BHl3kWMwX9tr+GTwn6Epadisv/ijrbOpM6lzI1IRlbPMMbxkTY1TE/UNpchRR0Fd
         tFcGZ2VFE+NiizxQwQIo3BgMdhgWY5mkAhb8PDs7uCOeCaX795YjbYzdJulxwoGifks1
         jP2g==
X-Gm-Message-State: APzg51B2LzVzEcHMMFt+cpmESCJ+9S+SF/RDxQYwHpk7DX9gVRYJse2P
        ilzq9YTHz5qzXjcIZ7p4CRh6JO2l9m/OPsOhmxE=
X-Google-Smtp-Source: ANB0VdZrwcqyJhOJTtgRo0VcxT9s4q0zb1tyQwmOwSMvnq7kohfEMAMQLVp6j5E6Lf+m6iInah8r5e/3APiYDEyOl0Q=
X-Received: by 2002:a9d:2645:: with SMTP id a63-v6mr3949973otb.270.1536924865801;
 Fri, 14 Sep 2018 04:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
 <20180809153925.GA20329@red-moon> <5398488.CyAMIAYSYI@aspire.rjw.lan> <20180914104431.GA20567@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180914104431.GA20567@e107981-ln.cambridge.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Sep 2018 13:34:14 +0200
Message-ID: <CAJZ5v0j27p9XHsLsJ+Eg9PGh1bbF5CRNFOrVW8qvNx1Am6W-2A@mail.gmail.com>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:44 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Sep 14, 2018 at 11:50:15AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, August 9, 2018 5:39:25 PM CEST Lorenzo Pieralisi wrote:
> > > On Mon, Aug 06, 2018 at 11:20:59AM +0200, Rafael J. Wysocki wrote:
> > >
> > > [...]
> > >
> > > > >>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> > > > >>> >     return false;
> > > > >>> >  }
> > > > >>> >
> > > > >>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > > > >>> > +{
> > > > >>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
> > > > >>> > +   ktime_t domain_wakeup, cpu_wakeup;
> > > > >>> > +   s64 idle_duration_ns;
> > > > >>> > +   int cpu, i;
> > > > >>> > +
> > > > >>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> > > > >>> > +           return true;
> > > > >>> > +
> > > > >>> > +   /*
> > > > >>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
> > > > >>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
> > > > >>> > +    * contains a mask of all CPUs from subdomains.
> > > > >>> > +    */
> > > > >>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > > > >>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > > > >>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> > > > >>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
> > > > >>> > +                   domain_wakeup = cpu_wakeup;
> > > > >>> > +   }
> > > > >>
> > > > >> Here's a concern I have missed before. :-/
> > > > >>
> > > > >> Say, one of the CPUs you're walking here is woken up in the meantime.
> > > > >
> > > > > Yes, that can happen - when we miss-predicted "next wakeup".
> > > > >
> > > > >>
> > > > >> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
> > > > >> to update domain_wakeup.  We really should just avoid the domain power off in
> > > > >> that case at all IMO.
> > > > >
> > > > > Correct.
> > > > >
> > > > > However, we also want to avoid locking contentions in the idle path,
> > > > > which is what this boils done to.
> > > >
> > > > This already is done under genpd_lock() AFAICS, so I'm not quite sure
> > > > what exactly you mean.
> > > >
> > > > Besides, this is not just about increased latency, which is a concern
> > > > by itself but maybe not so much in all environments, but also about
> > > > possibility of missing a CPU wakeup, which is a major issue.
> > > >
> > > > If one of the CPUs sharing the domain with the current one is woken up
> > > > during cpu_power_down_ok() and the wakeup is an edge-triggered
> > > > interrupt and the domain is turned off regardless, the wakeup may be
> > > > missed entirely if I'm not mistaken.
> > > >
> > > > It looks like there needs to be a way for the hardware to prevent a
> > > > domain poweroff when there's a pending interrupt or I don't quite see
> > > > how this can be handled correctly.
> > > >
> > > > >> Sure enough, if the domain power off is already started and one of the CPUs
> > > > >> in the domain is woken up then, too bad, it will suffer the latency (but in
> > > > >> that case the hardware should be able to help somewhat), but otherwise CPU
> > > > >> wakeup should prevent domain power off from being carried out.
> > > > >
> > > > > The CPU is not prevented from waking up, as we rely on the FW to deal with that.
> > > > >
> > > > > Even if the above computation turns out to wrongly suggest that the
> > > > > cluster can be powered off, the FW shall together with the genpd
> > > > > backend driver prevent it.
> > > >
> > > > Fine, but then the solution depends on specific FW/HW behavior, so I'm
> > > > not sure how generic it really is.  At least, that expectation should
> > > > be clearly documented somewhere, preferably in code comments.
> > > >
> > > > > To cover this case for PSCI, we also use a per cpu variable for the
> > > > > CPU's power off state, as can be seen later in the series.
> > > >
> > > > Oh great, but the generic part should be independent on the underlying
> > > > implementation of the driver.  If it isn't, then it also is not
> > > > generic.
> > > >
> > > > > Hope this clarifies your concern, else tell and will to elaborate a bit more.
> > > >
> > > > Not really.
> > > >
> > > > There also is one more problem and that is the interaction between
> > > > this code and the idle governor.
> > > >
> > > > Namely, the idle governor may select a shallower state for some
> > > > reason, for example due to an additional latency limit derived from
> > > > CPU utilization (like in the menu governor), and how does the code in
> > > > cpu_power_down_ok() know what state has been selected and how does it
> > > > honor the selection made by the idle governor?
> > >
> > > That's a good question and it maybe gives a path towards a solution.
> > >
> > > AFAICS the genPD governor only selects the idle state parameter that
> > > determines the idle state at, say, GenPD cpumask level it does not touch
> > > the CPUidle decision, that works on a subset of idle states (at cpu
> > > level).
> >
> > I've deferred responding to this as I wasn't quite sure if I followed you
> > at that time, but I'm afraid I'm still not following you now. :-)
> >
> > The idle governor has to take the total worst-case wakeup latency into
> > account.  Not just from the logical CPU itself, but also from whatever
> > state the SoC may end up in as a result of this particular logical CPU
> > going idle, this way or another.
> >
> > So for example, if your logical CPU has an idle state A that may trigger an
> > idle state X at the cluster level (if the other logical CPUs happen to be in
> > the right states and so on), then the worst-case exit latency for that
> > is the one of state X.
>
> I will provide an example:
>
> IDLE STATE A (affects CPU {0,1}): exit latency 1ms, min-residency 1.5ms
>
> CPU 0 is about to enter IDLE state A since its "next-event" fulfill the
> residency requirements and exit latency constraints.
>
> CPU 1 is in idle state A (given that CPU 0 is ON, some of the common
> logic shared between CPU {0,1} is still ON, but, as soon as CPU 0
> enters idle state A CPU {0,1} can enter the "full" idle state A
> power savings mode).
>
> The current CPUidle governor does not check the "next-event" for CPU 1,
> that it may wake up in, say, 10us.

Right.

> Requesting IDLE STATE A is a waste of power (if firmware or hardware
> does not demote it since it does peek at CPU 1 next-event and actually
> demote CPU 0 request).

OK, I see.

That's because the state is "collaborative" so to speak.  But was't
that supposed to be covered by the "coupled" thing?

> The current flat list of idle states has no notion of CPUs sharing
> an idle state request and that's where I think this series kicks in
> and that's the reason I say that the genPD governor can only demote
> an idle state request.
>
> Linking power domains to idle states is the only sensible way I see
> to define what logical cpus are affected by an idle state entry, this
> information is missing in the current kernel (whether that's wortwhile
> adding it that's another question).

OK, thanks for the clarification!

Cheers,
Rafael
