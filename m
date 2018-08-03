Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B13C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2296E21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXMFTiB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2296E21759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeHCNjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:39:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38792 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeHCNjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:39:16 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so7937166itb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oXuR2hcc/+Fmwt8ZzggVTWaIgwkPtS17lwQkmL2iLr0=;
        b=cXMFTiB4CW0kv8u1Hm54AlScQ/eGXxGgHlIrE+vRpnm6IuoEp8xkRjVXiOuNfT/CsH
         gfyEOEefLd4z3QaFo6TdoETEBAHvPjMPMpWyEVJ4s1T0d1QbyrfuUq3JHmehIAEesfG1
         HBJr/h5ESZeIeX0XCEoy1d9st9jBglGSLmYQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oXuR2hcc/+Fmwt8ZzggVTWaIgwkPtS17lwQkmL2iLr0=;
        b=gw83loH4WK9JLXEvDpghesQZ7ZgQCb/N0R2rJZQSvVWCdR5RSDX3R+p0aQMl+4/rog
         5LMPsvdJggxo1cWy/zULxnCif4Kxk+r0pd+ekknDpgeqZTg2sUa29GPr/AYALzcg/DmU
         dUWuAwtV81W9xFHO0k+rLzSAtZYIJiFQMlDtBGg0g7Lm21SmA3ew5RPTknPWQFY6LHWq
         Bk0mnePl9lkKrRDuq2Vpc0VpUsZlAEpAC+lYa+lywNVN7S/U++fmQmBMs9U5j/tRwyGO
         G+eqfWyVTTisuyIb6mfCrN20P9Bg8h23meyUfgw8qOWt4iDeUEWr75lIFH0Qx7c0BUEu
         QTeQ==
X-Gm-Message-State: AOUpUlFJAEA/Px0cbAmb0Bh+RZKBlxw7u7cY7XfoF56C9CYvgMC7oRdC
        FQeZEV83trp1W5zL1FjeJuYNXIQBKqhu291bcqXC2A==
X-Google-Smtp-Source: AAOMgpcNMiSpYLJkdErpfpNcZ7j6sPVcTqHlzRNn+FR1CjWy9nFXb5hQjb/aPadbfMlgIfPp/qIr/Q+5m6q0SvfFkGo=
X-Received: by 2002:a02:570c:: with SMTP id u12-v6mr3034946jaa.142.1533296598836;
 Fri, 03 Aug 2018 04:43:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 04:43:18 -0700 (PDT)
In-Reply-To: <1678369.6pMUSOvdlV@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-5-ulf.hansson@linaro.org> <1678369.6pMUSOvdlV@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Aug 2018 13:43:18 +0200
Message-ID: <CAPDyKFq=m7ad66SwiOr+4ab=e7PNiXrXJ6c8G0ZTPOdO1RQ_6g@mail.gmail.com>
Subject: Re: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 July 2018 at 12:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 20, 2018 7:22:04 PM CEST Ulf Hansson wrote:
>> To enable a device belonging to a CPU to be attached to a PM domain managed
>> by genpd, let's do a few changes to genpd as to make it convenient to
>> manage the specifics around CPUs.
>>
>> First, as to be able to quickly find out what CPUs that are attached to a
>> genpd, which typically becomes useful from a genpd governor as following
>> changes is about to show, let's add a cpumask 'cpus' to the struct
>> generic_pm_domain.
>>
>> At the point when a device that belongs to a CPU, is attached/detached to
>> its corresponding PM domain via genpd_add_device(), let's update the
>> cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
>> the master domains, which makes the genpd->cpus to contain a cpumask that
>> hierarchically reflect all CPUs for a genpd, including CPUs attached to
>> subdomains.
>>
>> Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
>> unnecessary for cases when only non-CPU devices are parts of a genpd.
>> Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
>> Clients must set the bit before they call pm_genpd_init(), as to instruct
>> genpd that it shall deal with CPUs and thus manage the cpumask in
>> genpd->cpus.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
>>  include/linux/pm_domain.h   |  3 ++
>>  2 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 21d298e1820b..6149ce0bfa7b 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/suspend.h>
>>  #include <linux/export.h>
>> +#include <linux/cpu.h>
>>
>>  #include "power.h"
>>
>> @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>>  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
>>  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
>>  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>> +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>>
>>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>>               const struct generic_pm_domain *genpd)
>> @@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
>>       dev_pm_put_subsys_data(dev);
>>  }
>>
>> +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
>> +                                int cpu, bool set, unsigned int depth)
>> +{
>> +     struct gpd_link *link;
>> +
>> +     if (!genpd_is_cpu_domain(genpd))
>> +             return;
>> +
>> +     list_for_each_entry(link, &genpd->slave_links, slave_node) {
>> +             struct generic_pm_domain *master = link->master;
>> +
>> +             genpd_lock_nested(master, depth + 1);
>> +             __genpd_update_cpumask(master, cpu, set, depth + 1);
>> +             genpd_unlock(master);
>> +     }
>> +
>> +     if (set)
>> +             cpumask_set_cpu(cpu, genpd->cpus);
>> +     else
>> +             cpumask_clear_cpu(cpu, genpd->cpus);
>> +}
>
> As noted elsewhere, there is a concern about the possible weight of this
> cpumask and I think that it would be good to explicitly put a limit on it.

I have been digesting your comments on the series, but wonder if this
is still a relevant concern?

Updating the mask is only done when the cpu is attached to its PM
domain. However, of course, I should not allocate the cpumask in
pm_genpd_init() unless the GENPD_FLAG_CPU_DOMAIN is set, as that is
just a waste.

>
>> +
>> +static void genpd_update_cpumask(struct generic_pm_domain *genpd,
>> +                              struct device *dev, bool set)
>> +{
>> +     bool is_cpu = false;
>> +     int cpu;
>> +
>> +     if (!genpd_is_cpu_domain(genpd))
>> +             return;
>> +
>> +     for_each_possible_cpu(cpu) {
>> +             if (get_cpu_device(cpu) == dev) {
>> +                     is_cpu = true;
>
> You may call __genpd_update_cpumask() right here and then you won't
> need the extra is_cpu variable.

Yes, indeed this looks weird, thanks for spotting it!

Ah, now I recall, the idea was to store an is_cpu variable per device,
to avoid looking up the cpu device at detach, but this is just
unnecessary. :-)

[...]

Thanks for reviewing!

Kind regards
Uffe
