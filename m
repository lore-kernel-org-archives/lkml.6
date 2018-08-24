Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E49C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF00A2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qm+MPU4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF00A2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeHXMDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:03:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41918 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeHXMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:03:15 -0400
Received: by mail-io0-f194.google.com with SMTP id q4-v6so6504326iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=msDsGT0wDIcOaXQtwPwbLgsxsRpGgvbXtPbX/ZS5o3M=;
        b=Qm+MPU4PMCp5rlt61GRRMD26o9KzdqtTvb56ADAkoklWY0/19oG5GjT5RZrJohfAQv
         3LNP6UZsTEnq6N9BvtW3HqPtYlYkQIL3BPbazH9WIQd77r2VDQ2CK5VStr2w19rycObZ
         xSMYJwEyBYVkxDbe7MXgy2rRXHnPyaJpi7ocg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=msDsGT0wDIcOaXQtwPwbLgsxsRpGgvbXtPbX/ZS5o3M=;
        b=VJPNw/JhM20RFrTAe03wHltRAHQWcov2gCPq+RGYTsHVO8hr8TF3W34ihzP+ZDG9F7
         M6mJlCkkvPm/jsC8u7k5/2/wPw2xM1HUE6NQpusxD1w+Qdc1MybC3gh0r8MmBvg6gmH+
         6vgkZsWU3kVkI8ouWWa+7HRLiSNrVnWuviTFh6XXI/CNht3ckFrg5/ShtLjerFtsZVkV
         QiXPjNEEP19jkDtqdVl0t1CHNa0bbrK3RAFProVz+xLZq+wSBDYgV876kW8qXX5kiDrw
         5T2nL0ZzKGz2Ct7/efRD/w+t0pu4L8tWT/T99vgndF6b3odvdaEbUAe/v6OHHXECGmaJ
         4eaA==
X-Gm-Message-State: APzg51AflwsOboNcUQKfci+HAoXXBJanUcSdljvLVryB80tay+6jN0G5
        vaB7A1n3p10Qeo7lYRex3DExLWbycWGQHyuS3lULbg==
X-Google-Smtp-Source: ANB0VdaJYBgzmT06QLknPovoisTmAA3VerJDg3cTSoQgLl/w+DIstyWnJI9TMuK/1ru1Olh8qWKjQBeK2aGOB3nQTR0=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr470334iof.266.1535099380348;
 Fri, 24 Aug 2018 01:29:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 01:29:39
 -0700 (PDT)
In-Reply-To: <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org> <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan> <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 10:29:39 +0200
Message-ID: <CAPDyKFqOv9d=w80s2W_+wcKEtBWnBKQ3CqGaG2yGJt8_qRTu6g@mail.gmail.com>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
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

On 6 August 2018 at 11:20, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 3, 2018 at 4:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 26 July 2018 at 11:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Thursday, July 19, 2018 12:32:52 PM CEST Rafael J. Wysocki wrote:
>>>> On Wednesday, June 20, 2018 7:22:07 PM CEST Ulf Hansson wrote:
>>>> > As it's now perfectly possible that a PM domain managed by genpd contains
>>>> > devices belonging to CPUs, we should start to take into account the
>>>> > residency values for the idle states during the state selection process.
>>>> > The residency value specifies the minimum duration of time, the CPU or a
>>>> > group of CPUs, needs to spend in an idle state to not waste energy entering
>>>> > it.
>>>> >
>>>> > To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
>>>> > may be used for a PM domain that have CPU devices attached or if the CPUs
>>>> > are attached through subdomains.
>>>> >
>>>> > The new governor computes the minimum expected idle duration time for the
>>>> > online CPUs being attached to the PM domain and its subdomains. Then in the
>>>> > state selection process, trying the deepest state first, it verifies that
>>>> > the idle duration time satisfies the state's residency value.
>>>> >
>>>> > It should be noted that, when computing the minimum expected idle duration
>>>> > time, we use the information from tick_nohz_get_next_wakeup(), to find the
>>>> > next wakeup for the related CPUs. Future wise, this may deserve to be
>>>> > improved, as there are more reasons to why a CPU may be woken up from idle.
>>>> >
>>>> > Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> > Cc: Lina Iyer <ilina@codeaurora.org>
>>>> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
>>>> > Cc: Ingo Molnar <mingo@kernel.org>
>>>> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>>>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> > ---
>>>> >  drivers/base/power/domain_governor.c | 58 ++++++++++++++++++++++++++++
>>>> >  include/linux/pm_domain.h            |  2 +
>>>> >  2 files changed, 60 insertions(+)
>>>> >
>>>> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>>>> > index 99896fbf18e4..1aad55719537 100644
>>>> > --- a/drivers/base/power/domain_governor.c
>>>> > +++ b/drivers/base/power/domain_governor.c
>>>> > @@ -10,6 +10,9 @@
>>>> >  #include <linux/pm_domain.h>
>>>> >  #include <linux/pm_qos.h>
>>>> >  #include <linux/hrtimer.h>
>>>> > +#include <linux/cpumask.h>
>>>> > +#include <linux/ktime.h>
>>>> > +#include <linux/tick.h>
>>>> >
>>>> >  static int dev_update_qos_constraint(struct device *dev, void *data)
>>>> >  {
>>>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>>>> >     return false;
>>>> >  }
>>>> >
>>>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>>> > +{
>>>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
>>>> > +   ktime_t domain_wakeup, cpu_wakeup;
>>>> > +   s64 idle_duration_ns;
>>>> > +   int cpu, i;
>>>> > +
>>>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>>>> > +           return true;
>>>> > +
>>>> > +   /*
>>>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
>>>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
>>>> > +    * contains a mask of all CPUs from subdomains.
>>>> > +    */
>>>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
>>>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
>>>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
>>>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
>>>> > +                   domain_wakeup = cpu_wakeup;
>>>> > +   }
>>>
>>> Here's a concern I have missed before. :-/
>>>
>>> Say, one of the CPUs you're walking here is woken up in the meantime.
>>
>> Yes, that can happen - when we miss-predicted "next wakeup".
>>
>>>
>>> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
>>> to update domain_wakeup.  We really should just avoid the domain power off in
>>> that case at all IMO.
>>
>> Correct.
>>
>> However, we also want to avoid locking contentions in the idle path,
>> which is what this boils done to.
>
> This already is done under genpd_lock() AFAICS, so I'm not quite sure
> what exactly you mean.
>
> Besides, this is not just about increased latency, which is a concern
> by itself but maybe not so much in all environments, but also about
> possibility of missing a CPU wakeup, which is a major issue.
>
> If one of the CPUs sharing the domain with the current one is woken up
> during cpu_power_down_ok() and the wakeup is an edge-triggered
> interrupt and the domain is turned off regardless, the wakeup may be
> missed entirely if I'm not mistaken.
>
> It looks like there needs to be a way for the hardware to prevent a
> domain poweroff when there's a pending interrupt or I don't quite see
> how this can be handled correctly.

Well, the job of genpd and its new cpu governor is not directly to
power off the PM domain, but rather to try to select/promote an idle
state for it. Along the lines of what Lorenzo explained in the other
thread.

Then what happens in the genpd backend driver's ->power_off()
callback, is platform specific. In other words, it's the job of the
backend driver to understand how its FW works and thus to correctly
deal with the last man standing algorithm.

In regards to the PSCI FW, it supports the race condition you are
referring to in the FW (which makes it easier), no matter if it's
running in OS-initiated mode or platform-coordinated mode.

>
>>> Sure enough, if the domain power off is already started and one of the CPUs
>>> in the domain is woken up then, too bad, it will suffer the latency (but in
>>> that case the hardware should be able to help somewhat), but otherwise CPU
>>> wakeup should prevent domain power off from being carried out.
>>
>> The CPU is not prevented from waking up, as we rely on the FW to deal with that.
>>
>> Even if the above computation turns out to wrongly suggest that the
>> cluster can be powered off, the FW shall together with the genpd
>> backend driver prevent it.
>
> Fine, but then the solution depends on specific FW/HW behavior, so I'm
> not sure how generic it really is.  At least, that expectation should
> be clearly documented somewhere, preferably in code comments.

Alright, let me add some comments somewhere in the code, to explain a
bit about what a genpd backend driver should expect when using the
GENPD_FLAG_CPU_DOMAIN flag.

>
>> To cover this case for PSCI, we also use a per cpu variable for the
>> CPU's power off state, as can be seen later in the series.
>
> Oh great, but the generic part should be independent on the underlying
> implementation of the driver.  If it isn't, then it also is not
> generic.
>
>> Hope this clarifies your concern, else tell and will to elaborate a bit more.
>
> Not really.
>
> There also is one more problem and that is the interaction between
> this code and the idle governor.
>
> Namely, the idle governor may select a shallower state for some
> reason, for example due to an additional latency limit derived from
> CPU utilization (like in the menu governor), and how does the code in
> cpu_power_down_ok() know what state has been selected and how does it
> honor the selection made by the idle governor?

This is indeed a valid concern. I must have failed to explained this
during various conferences, but at least I have tried. :-)

Ideally, we need the menu idle governor and genpd's new cpu governor
to share code or exchange information, somehow. I am looking into that
as a next step of improvements, count on it!

The idea at this point was instead to take a simplified approach to
the problem, to at least get some support for cpu cluster idle
management in place, then improve it on top.

This means, for PSCI, we are using the new genpd cpu governor *only*
for the cluster PM domain (master), but not for the genpd subdomains,
which each contains of a single CPU device. So, the subdomains don't
have a genpd governor assigned, but instead rely on the existing menu
idle governor to select an idle state for the CPU. This means that
*most* of the problem disappears, as its only when the last CPU in the
cluster goes idle, when the selection could be "wrong". In worst case,
genpd will promote an idle state for the cluster PM domain, while it
shouldn't.

Moreover, for the QCOM case in 410c, this isn't even a potential
problem, because there is only *one* idle state to pick by the menu
idle governor for the CPU (besides WFI). Hence, when the genpd cpu
governor runs to pick and idle state, we know that the menu idle
governor have already selected the deepest idle state for each CPU.

Kind regards
Uffe
