Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22658C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF09B2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhksynNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF09B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeHCNio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:38:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36341 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeHCNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:38:44 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so7964237itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=naIc7+UU99psMTXJQz+RJiQhcwnl+UPm5H2DCEC5u+I=;
        b=dhksynNBdoXB6+JzQqCdW/AxmvFqdIjUmRrdoHaFDA7ModJ6EYJ0qGbwFLmqNKc4/f
         2RAGSnqSylayRSJN9W9gWtzJN5ksasLgyWeiGZjwUrFy57XzaqzCe7tRrvrhml8GF6wI
         Vjimho4R/Qgu+q8Fa/rN9zzAvM/L7NNrzjfQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=naIc7+UU99psMTXJQz+RJiQhcwnl+UPm5H2DCEC5u+I=;
        b=g983fbsNj00crJu8xPTEn1H4cwPB6bwKpatpjR6/GPmt/JVgUAeJulOdXT3FHPFRJW
         KEi8nhNycuVebPl1lerlRK7/XiHaJpO8o4clKZw9u9oopgIobVle1xjejTKOnyCga0PQ
         w1P78akzaibpY6RknKQCuyiqXOiT7zCix4zgKmehCYLPf9Y3kdIrqYLFImzYX0oo7kIx
         F4j2g9UcpUKFcciXuHkx+uMeY188xXMU13g3vRQICrjwOLiVICsQEnOfMFWqdrUp2KE6
         4+D2ebk3EJflCF58L+1mQJUuiNPg9l5pWXpcL4jPcxebfMiyifH/Lvf8xLwvbztfeGZl
         GDag==
X-Gm-Message-State: AOUpUlECO3FollQe/JDE0ocacxe3aANpbsMoHrNq3ykrtRRYe9OE7uyx
        cfrVAh1ofDGfg+ZQiHhBfhLbXGwoI7D0GwNdT6QBOQ==
X-Google-Smtp-Source: AAOMgpd5na9IPVnQq1OLi5CnltlGYIW+ykyArm082MB7wd2q8DK7fG5kzUIvIC0S3Edcje2qEbSOEtoP6WdxcEAl8Vw=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr6369978itc.102.1533296567256;
 Fri, 03 Aug 2018 04:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 04:42:46 -0700 (PDT)
In-Reply-To: <1683770.JmsJDzJTZp@aspire.rjw.lan>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-9-ulf.hansson@linaro.org> <1683770.JmsJDzJTZp@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Aug 2018 13:42:46 +0200
Message-ID: <CAPDyKFrqKm3tyUi=nHoOY-_K+o=ok03TA0cDhzpyNg8_jiaZrQ@mail.gmail.com>
Subject: Re: [PATCH v8 08/26] PM / Domains: Extend genpd CPU governor to cope
 with QoS constraints
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

On 19 July 2018 at 12:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, June 20, 2018 7:22:08 PM CEST Ulf Hansson wrote:
>> CPU devices and other regular devices may share the same PM domain and may
>> also be hierarchically related via subdomains. In either case, all devices
>> including CPUs, may be attached to a PM domain managed by genpd, that has
>> an idle state with an enter/exit latency.
>>
>> Let's take these latencies into account in the state selection process by
>> genpd's governor for CPUs. This means the governor, pm_domain_cpu_gov,
>> becomes extended to satisfy both a state's residency and a potential dev PM
>> QoS constraint.
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain_governor.c | 15 +++++++++++----
>>  include/linux/pm_domain.h            |  1 +
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>> index 1aad55719537..03d4e9454ce9 100644
>> --- a/drivers/base/power/domain_governor.c
>> +++ b/drivers/base/power/domain_governor.c
>> @@ -214,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>       struct generic_pm_domain *genpd = pd_to_genpd(pd);
>>       struct gpd_link *link;
>>
>> -     if (!genpd->max_off_time_changed)
>> +     if (!genpd->max_off_time_changed) {
>> +             genpd->state_idx = genpd->cached_power_down_state_idx;
>>               return genpd->cached_power_down_ok;
>> +     }
>>
>>       /*
>>        * We have to invalidate the cached results for the masters, so
>> @@ -240,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>>               genpd->state_idx--;
>>       }
>>
>> +     genpd->cached_power_down_state_idx = genpd->state_idx;
>>       return genpd->cached_power_down_ok;
>>  }
>>
>> @@ -255,6 +258,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>       s64 idle_duration_ns;
>>       int cpu, i;
>>
>> +     /* Validate dev PM QoS constraints. */
>> +     if (!default_power_down_ok(pd))
>> +             return false;
>> +
>>       if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>>               return true;
>>
>> @@ -276,9 +283,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>       /*
>>        * Find the deepest idle state that has its residency value satisfied
>>        * and by also taking into account the power off latency for the state.
>> -      * Start at the deepest supported state.
>> +      * Start at the state picked by the dev PM QoS constraint validation.
>>        */
>> -     i = genpd->state_count - 1;
>> +     i = genpd->state_idx;
>>       do {
>>               if (!genpd->states[i].residency_ns)
>>                       break;
>> @@ -312,6 +319,6 @@ struct dev_power_governor pm_domain_always_on_gov = {
>>  };
>>
>>  struct dev_power_governor pm_domain_cpu_gov = {
>> -     .suspend_ok = NULL,
>> +     .suspend_ok = default_suspend_ok,
>>       .power_down_ok = cpu_power_down_ok,
>>  };
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 97901c833108..dbc69721cad8 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -81,6 +81,7 @@ struct generic_pm_domain {
>>       s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>>       bool max_off_time_changed;
>>       bool cached_power_down_ok;
>> +     bool cached_power_down_state_idx;
>>       int (*attach_dev)(struct generic_pm_domain *domain,
>>                         struct device *dev);
>>       void (*detach_dev)(struct generic_pm_domain *domain,
>>
>
> I don't see much value in splitting this patch off [07/26] and it actually
> confused me, so it may as well confuse someone else.
>

The idea was to let people, explicitly, comment on the whether dev PM
Qos constraints should be considered by the governor.

However, I get your point, let's combine them!

Kind regards
Uffe
