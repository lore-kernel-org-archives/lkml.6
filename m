Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF944C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D90E21761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3JAPpoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D90E21761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeHCQYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:24:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37917 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbeHCQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:24:46 -0400
Received: by mail-io0-f195.google.com with SMTP id v26-v6so5126885iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FD9yMlAWPygbUY04RhS908gkGVyFDqkZ4jDUfIZqzK0=;
        b=P3JAPpoyEt6n69z/tU4h4LQAN4lfz37yRMvb6LPyyIOQojCm6sv3Szbq1Vl70dQ9Vr
         dpAPfHgFr0obDo4dCt+z1PS+ThnAbgBf2tbxqwcjg8sGrBts0+pZZpEwMfVYaq/FxgA4
         rW7g4TuAI6dZmJ8qKO8U0Wywo2Lf4FrFaeb/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FD9yMlAWPygbUY04RhS908gkGVyFDqkZ4jDUfIZqzK0=;
        b=czDWVm+BIzLnE4gwOA88wS9b7B0mFAaOmNWXfmRpYa4mdyUSeYCdJ757UNmr1/TieD
         pHNeXBd2ZrfQEbjt3TfOhBw0dT6YXF4VUuPrHGj1QfJZ3JTPAipuoQbfvI9lgGBFDPI5
         +/jUyNMa3012xgQpeqlZmxfKbYxJCB8VAleYx/OvC/xVhwI5Q8kZwKg8IqPxRBjveCnw
         CR6gsR2TWCqzO42B0urNOAHD+lyY4Jr71sHtJruIbx4n/2alcsWo4dO6KXMKKsCPbNwW
         2U4Jk3qgpDdZgbqT+C3sIjshaQnFBcQ/JDk9GsLJJeZ/maxtXdRnSLOKyqbG3v7kBv+5
         gi1Q==
X-Gm-Message-State: AOUpUlHBCkqiDnICS+e+0D31dqDqbX6P9YSSzSjtDXrUCE3OsphJyeIb
        DFDOfTKgXkzu3iR1s8y52+pdLi7prsputM7X41/PBQ==
X-Google-Smtp-Source: AA+uWPz1ht20PpxWuKYRISDX2TWkHTDTQok0INTceWRwv58fX62sQCOnAWT9Fb1OXdHWhbcLNKp1lJHLEyUlS3A4xuk=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr6039571iog.131.1533306490489;
 Fri, 03 Aug 2018 07:28:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 07:28:09 -0700 (PDT)
In-Reply-To: <10360149.m4MlxDWZY5@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org> <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Aug 2018 16:28:09 +0200
Message-ID: <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
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

On 26 July 2018 at 11:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, July 19, 2018 12:32:52 PM CEST Rafael J. Wysocki wrote:
>> On Wednesday, June 20, 2018 7:22:07 PM CEST Ulf Hansson wrote:
>> > As it's now perfectly possible that a PM domain managed by genpd contains
>> > devices belonging to CPUs, we should start to take into account the
>> > residency values for the idle states during the state selection process.
>> > The residency value specifies the minimum duration of time, the CPU or a
>> > group of CPUs, needs to spend in an idle state to not waste energy entering
>> > it.
>> >
>> > To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
>> > may be used for a PM domain that have CPU devices attached or if the CPUs
>> > are attached through subdomains.
>> >
>> > The new governor computes the minimum expected idle duration time for the
>> > online CPUs being attached to the PM domain and its subdomains. Then in the
>> > state selection process, trying the deepest state first, it verifies that
>> > the idle duration time satisfies the state's residency value.
>> >
>> > It should be noted that, when computing the minimum expected idle duration
>> > time, we use the information from tick_nohz_get_next_wakeup(), to find the
>> > next wakeup for the related CPUs. Future wise, this may deserve to be
>> > improved, as there are more reasons to why a CPU may be woken up from idle.
>> >
>> > Cc: Thomas Gleixner <tglx@linutronix.de>
>> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> > Cc: Lina Iyer <ilina@codeaurora.org>
>> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> > Cc: Ingo Molnar <mingo@kernel.org>
>> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> > ---
>> >  drivers/base/power/domain_governor.c | 58 ++++++++++++++++++++++++++++
>> >  include/linux/pm_domain.h            |  2 +
>> >  2 files changed, 60 insertions(+)
>> >
>> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>> > index 99896fbf18e4..1aad55719537 100644
>> > --- a/drivers/base/power/domain_governor.c
>> > +++ b/drivers/base/power/domain_governor.c
>> > @@ -10,6 +10,9 @@
>> >  #include <linux/pm_domain.h>
>> >  #include <linux/pm_qos.h>
>> >  #include <linux/hrtimer.h>
>> > +#include <linux/cpumask.h>
>> > +#include <linux/ktime.h>
>> > +#include <linux/tick.h>
>> >
>> >  static int dev_update_qos_constraint(struct device *dev, void *data)
>> >  {
>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>> >     return false;
>> >  }
>> >
>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>> > +{
>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
>> > +   ktime_t domain_wakeup, cpu_wakeup;
>> > +   s64 idle_duration_ns;
>> > +   int cpu, i;
>> > +
>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>> > +           return true;
>> > +
>> > +   /*
>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
>> > +    * contains a mask of all CPUs from subdomains.
>> > +    */
>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
>> > +                   domain_wakeup = cpu_wakeup;
>> > +   }
>
> Here's a concern I have missed before. :-/
>
> Say, one of the CPUs you're walking here is woken up in the meantime.

Yes, that can happen - when we miss-predicted "next wakeup".

>
> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
> to update domain_wakeup.  We really should just avoid the domain power off in
> that case at all IMO.

Correct.

However, we also want to avoid locking contentions in the idle path,
which is what this boils done to.

>
> Sure enough, if the domain power off is already started and one of the CPUs
> in the domain is woken up then, too bad, it will suffer the latency (but in
> that case the hardware should be able to help somewhat), but otherwise CPU
> wakeup should prevent domain power off from being carried out.

The CPU is not prevented from waking up, as we rely on the FW to deal with that.

Even if the above computation turns out to wrongly suggest that the
cluster can be powered off, the FW shall together with the genpd
backend driver prevent it.

To cover this case for PSCI, we also use a per cpu variable for the
CPU's power off state, as can be seen later in the series.

Hope this clarifies your concern, else tell and will to elaborate a bit more.

Kind regards
Uffe
