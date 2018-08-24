Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0555BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E0E20847
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjyiPIJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E0E20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeHXKUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:20:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51831 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbeHXKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:20:36 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so835324itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sCv7c8KMDvmWJxbh2tLOcYKRL7o3gO6rLobnrVPXcLk=;
        b=KjyiPIJV4w60vl30H2ml0QfbvcEqLql/X0Iy9VXtzGUdvYciKYDzpFtU33l93JVWd8
         VXkGEJ1CveiDQlyd/ff+7XuKCmE+rroBzs/28q1oeMJekX3rLXc8SBJs3Y6vKlzhUcYR
         c2xqzQ1asunh0E8EPuQLBDAOej1mm08uJnlLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sCv7c8KMDvmWJxbh2tLOcYKRL7o3gO6rLobnrVPXcLk=;
        b=QYUDTQ7T6rXtu1v0HdshHwJ3v1dkE/2uDaiE8kqUXaCLl4Q7shX41oo3XtRONQaWfj
         JbTD08CR9IFu/J2CTf8uHc4rhCzDzabWR+H5GvSGRyRxvh3l5yfzjOkR41t0B6bq+Sjc
         WfghizrnDAH1b2a2NBYi5Pw/xL+BY6u/oLUPjCPKeCU4a3fBP2uXw5oXbka1flvDx4Hr
         1Y0GShYTgpMLbSRXmuEZO8Rvmi3ThQkK9/eJ6yNnbigglckkYqJc9YY+FZoZZSqZVXxU
         NiE7OrifmzEJx56v38NyAKu4/55YmjGleO56q2uLUJ2ehXPVSvcew6FvXDhkIah0Ei60
         xwOQ==
X-Gm-Message-State: APzg51Cat1YRQTwLj1EwqNTnbtpU+EYP+H6TVgRrN2CYn5mrcWRdt1Lp
        RHj3LUxMP45D097xjITW3Cgt/4TVoSgWshluw0YmKA==
X-Google-Smtp-Source: ANB0Vdb1SeJLXtKBcATAYEJVzMbJRCWXeHv7IGnanyaPmnZ2b0brqIfBM/Lf3Jv+H99trW1UPCsPFMc1XUA+MoR24I4=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr255405jad.107.1535093241610;
 Thu, 23 Aug 2018 23:47:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 23:47:21
 -0700 (PDT)
In-Reply-To: <CAJZ5v0jah=aiYoV_b_p=-x+puO0sxeGRBCtJnQAD8xb8p1QGfg@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-5-ulf.hansson@linaro.org> <1678369.6pMUSOvdlV@aspire.rjw.lan>
 <CAPDyKFq=m7ad66SwiOr+4ab=e7PNiXrXJ6c8G0ZTPOdO1RQ_6g@mail.gmail.com> <CAJZ5v0jah=aiYoV_b_p=-x+puO0sxeGRBCtJnQAD8xb8p1QGfg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 08:47:21 +0200
Message-ID: <CAPDyKFpatx81aMrbDtaeNPH=FXBYPCHsog3i=a0VN5=Q8if0=Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 August 2018 at 11:36, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 3, 2018 at 1:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 19 July 2018 at 12:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Wednesday, June 20, 2018 7:22:04 PM CEST Ulf Hansson wrote:
>>>> To enable a device belonging to a CPU to be attached to a PM domain managed
>>>> by genpd, let's do a few changes to genpd as to make it convenient to
>>>> manage the specifics around CPUs.
>>>>
>>>> First, as to be able to quickly find out what CPUs that are attached to a
>>>> genpd, which typically becomes useful from a genpd governor as following
>>>> changes is about to show, let's add a cpumask 'cpus' to the struct
>>>> generic_pm_domain.
>>>>
>>>> At the point when a device that belongs to a CPU, is attached/detached to
>>>> its corresponding PM domain via genpd_add_device(), let's update the
>>>> cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
>>>> the master domains, which makes the genpd->cpus to contain a cpumask that
>>>> hierarchically reflect all CPUs for a genpd, including CPUs attached to
>>>> subdomains.
>>>>
>>>> Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
>>>> unnecessary for cases when only non-CPU devices are parts of a genpd.
>>>> Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
>>>> Clients must set the bit before they call pm_genpd_init(), as to instruct
>>>> genpd that it shall deal with CPUs and thus manage the cpumask in
>>>> genpd->cpus.
>>>>
>>>> Cc: Lina Iyer <ilina@codeaurora.org>
>>>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>>  drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
>>>>  include/linux/pm_domain.h   |  3 ++
>>>>  2 files changed, 71 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>> index 21d298e1820b..6149ce0bfa7b 100644
>>>> --- a/drivers/base/power/domain.c
>>>> +++ b/drivers/base/power/domain.c
>>>> @@ -20,6 +20,7 @@
>>>>  #include <linux/sched.h>
>>>>  #include <linux/suspend.h>
>>>>  #include <linux/export.h>
>>>> +#include <linux/cpu.h>
>>>>
>>>>  #include "power.h"
>>>>
>>>> @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>>>>  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>>>>  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>>>>  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>>>> +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>>>>
>>>>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>>>>               const struct generic_pm_domain *genpd)
>>>> @@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
>>>>       dev_pm_put_subsys_data(dev);
>>>>  }
>>>>
>>>> +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>>>> +                                int cpu, bool set, unsigned int depth)
>>>> +{
>>>> +     struct gpd_link *link;
>>>> +
>>>> +     if (!genpd_is_cpu_domain(genpd))
>>>> +             return;
>>>> +
>>>> +     list_for_each_entry(link, &genpd->slave_links, slave_node) {
>>>> +             struct generic_pm_domain *master = link->master;
>>>> +
>>>> +             genpd_lock_nested(master, depth + 1);
>>>> +             __genpd_update_cpumask(master, cpu, set, depth + 1);
>>>> +             genpd_unlock(master);
>>>> +     }
>>>> +
>>>> +     if (set)
>>>> +             cpumask_set_cpu(cpu, genpd->cpus);
>>>> +     else
>>>> +             cpumask_clear_cpu(cpu, genpd->cpus);
>>>> +}
>>>
>>> As noted elsewhere, there is a concern about the possible weight of this
>>> cpumask and I think that it would be good to explicitly put a limit on it.
>>
>> I have been digesting your comments on the series, but wonder if this
>> is still a relevant concern?
>
> Well, there are systems with very large cpumasks and it is sort of
> good to have that in mind when designing any code using them.

Right.

So, if I avoid allocating the cpumask for those genpd structures that
doesn't need it (those not having GENPD_FLAG_CPU_DOMAIN set), would
that be sufficient to deal with your concern?

Kind regards
Uffe
