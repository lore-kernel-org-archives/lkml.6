Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A5D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="URBEvafc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A5D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeK3Uxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:53:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36798 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeK3Uxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:53:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so2972504vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Qu1DcI5v5cZnilrg7buSai+5hsVEquuHQetSPJ7xes=;
        b=URBEvafc0/fQ4x4n/Fn3ZvCB0jRFPjL8Z+KPBBDN9koCN/Rr0r7efRRamfxC4GWqhG
         VB1l6u/0I3sVVOaAV4iUcGb/GQipjufl6CwclWl1wfmBf+xL5hyWE6uyvUInXpltyqNV
         lZ5byWgOOaRy8bErYsL525SS9gb2lEN8xCf9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Qu1DcI5v5cZnilrg7buSai+5hsVEquuHQetSPJ7xes=;
        b=BrAauNYff32bsaNhFCR8OJdIdj60NClpCQKOR/1zChefb3YSg5SaiohiG91neGeLFD
         kcfet9FTqYSjMRv9W1RhqVWOQDTkazaLzu9hA4sC9BFxOHRhtOkjf4h2n4Y74tQLxowz
         iwnPUJs26IRNkal/W9qRVa4VQxQ313nX6as6SJWedD3tSzNX5zWz46vyyghAWPiuFc58
         hAmhL1NOXa+7qH2RuOjurVf9qR9FTKJcTdABfEEV5CAgl/xUeO8D57eHgeW0u5psFd+s
         juOP6iB1POXvxu0mVITQpLuore4R6Kyh+L9b96o32TrriI6RXnVVCwnJwmsgZoiFo5s2
         8HkA==
X-Gm-Message-State: AA+aEWZKGMRFTy2u8DPMMiqfQLB6jzzCB2ENUkNxl6ap69QdqfRt7870
        rbuTA+nLbOu93T/BKNHAf5Hbqud592nJCuFtwofU7A==
X-Google-Smtp-Source: AFSGD/VeHI3fvw7xWG2j6IiU1ZvjQktcA15VtbcbzHmpa7kfvQiyy5D0TXvLfASE6OYJYMIm4yrUPkUoCODWq0k/6DI=
X-Received: by 2002:a67:7685:: with SMTP id r127mr2195950vsc.35.1543571105678;
 Fri, 30 Nov 2018 01:45:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543219386.git.viresh.kumar@linaro.org> <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
In-Reply-To: <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Nov 2018 10:44:29 +0100
Message-ID: <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This commit updates genpd core to start propagating performance state
> updates to master domains that have their set_performance_state()
> callback set.
>
> A genpd handles two type of performance states now. The first one is the
> performance state requirement put on the genpd by the devices and
> sub-domains under it, which is already represented by
> genpd->performance_state.

This isn't correct.

Currently genpd->performance_state reflects the aggregation of the
state requirements from each device that is attached to it. Not from
subdomains.

> The second type, introduced in this commit, is
> the performance state requirement(s) put by the genpd on its master
> domain(s). There is a separate value required for each master that the
> genpd has and so a new field is added to the struct gpd_link
> (link->performance_state), which represents the link between a genpd and
> its master. The struct gpd_link also got another field
> prev_performance_state, which is used by genpd core as a temporary
> variable during transitions.
>
> We need to propagate setting performance state while powering-on a genpd
> as well, as we ignore performance state requirements from sub-domains
> which are powered-off. For this reason _genpd_power_on() also received
> the additional parameter, depth, which is used for hierarchical locking
> within genpd.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 113 ++++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h   |   4 ++
>  2 files changed, 98 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d6b389a9f678..206e263abe90 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,24 +239,88 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          unsigned int state, int depth);
> +

I don't like forward declarations like these, as in most cases it
means that the code can be re-worked and improved.

However, because of the recursiveness code in genpd, I understand that
it may be needed for some cases. Anyway, please have look and see if
you can rid of it.

>  static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> -                                       unsigned int state)
> +                                       unsigned int state, int depth)
>  {
> +       struct generic_pm_domain *master;
> +       struct gpd_link *link;
> +       unsigned int mstate;

please rename to master_state to clarify its use.

>         int ret;
>
> +       /* Propagate to masters of genpd */
> +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> +               master = link->master;
> +
> +               if (!master->set_performance_state)
> +                       continue;
> +
> +               if (unlikely(!state)) {
> +                       mstate = 0;
> +               } else {
> +                       /* Find master's performance state */
> +                       mstate = dev_pm_opp_xlate_performance_state(genpd->opp_table,
> +                                       master->opp_table, state);
> +                       if (unlikely(!mstate)) {
> +                               ret = -EINVAL;
> +                               goto err;
> +                       }
> +               }
> +
> +               genpd_lock_nested(master, depth + 1);
> +
> +               link->prev_performance_state = link->performance_state;
> +               link->performance_state = mstate;
> +               ret = _genpd_reeval_performance_state(master, mstate, depth + 1);
> +               if (ret)
> +                       link->performance_state = link->prev_performance_state;
> +
> +               genpd_unlock(master);
> +
> +               if (ret)
> +                       goto err;
> +       }
> +
>         ret = genpd->set_performance_state(genpd, state);
>         if (ret)
> -               return ret;
> +               goto err;
>
>         genpd->performance_state = state;
>         return 0;
> +
> +err:
> +       /* Encountered an error, lets rollback */
> +       list_for_each_entry_continue_reverse(link, &genpd->slave_links,
> +                                            slave_node) {
> +               master = link->master;
> +
> +               if (!master->set_performance_state)
> +                       continue;
> +
> +               genpd_lock_nested(master, depth + 1);
> +
> +               mstate = link->prev_performance_state;
> +               link->performance_state = mstate;
> +
> +               if (_genpd_reeval_performance_state(master, mstate, depth + 1)) {
> +                       pr_err("%s: Failed to roll back to %d performance state\n",
> +                              master->name, mstate);
> +               }
> +
> +               genpd_unlock(master);
> +       }
> +
> +       return ret;
>  }
>
>  static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> -                                          unsigned int state)
> +                                          unsigned int state, int depth)
>  {
>         struct generic_pm_domain_data *pd_data;
>         struct pm_domain_data *pdd;
> +       struct gpd_link *link;
>
>         /* New requested state is same as Max requested state */
>         if (state == genpd->performance_state)
> @@ -274,18 +338,27 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>                         state = pd_data->performance_state;
>         }
>
> -       if (state == genpd->performance_state)
> -               return 0;
> -
>         /*
> -        * We aren't propagating performance state changes of a subdomain to its
> -        * masters as we don't have hardware that needs it. Over that, the
> -        * performance states of subdomain and its masters may not have
> -        * one-to-one mapping and would require additional information. We can
> -        * get back to this once we have hardware that needs it. For that
> -        * reason, we don't have to consider performance state of the subdomains
> -        * of genpd here.
> +        * Traverse all powered-on subdomains within the domain. This can be
> +        * done without any additional locking as the link->performance_state
> +        * field is protected by the master genpd->lock, which is already taken.
> +        *
> +        * Also note that link->performance_state (subdomain's performance state
> +        * requirement to master domain) is different from
> +        * link->slave->performance_state (current performance state requirement
> +        * of the devices/sub-domains of the subdomain) and so can have a
> +        * different value.
>          */
> +       list_for_each_entry(link, &genpd->master_links, master_node) {
> +               if (!genpd_status_on(link->slave))
> +                       continue;
> +
> +               if (link->performance_state > state)
> +                       state = link->performance_state;
> +       }
> +
> +       if (state == genpd->performance_state)
> +               return 0;
>
>  update_state:
>         if (!genpd_status_on(genpd)) {
> @@ -293,7 +366,7 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>                 return 0;
>         }
>
> -       return _genpd_set_performance_state(genpd, state);
> +       return _genpd_set_performance_state(genpd, state, depth);
>  }
>
>  /**
> @@ -337,7 +410,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         prev = gpd_data->performance_state;
>         gpd_data->performance_state = state;
>
> -       ret = _genpd_reeval_performance_state(genpd, state);
> +       ret = _genpd_reeval_performance_state(genpd, state, 0);
>         if (ret)
>                 gpd_data->performance_state = prev;
>
> @@ -347,7 +420,8 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>
> -static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
> +static int
> +_genpd_power_on(struct generic_pm_domain *genpd, bool timed, int depth)

Cosmetics, but please move the new parameter below instead of moving
"static int" above.

>  {
>         unsigned int state_idx = genpd->state_idx;
>         ktime_t time_start;
> @@ -368,7 +442,8 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>         elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
>
>         if (unlikely(genpd->set_performance_state)) {
> -               ret = genpd->set_performance_state(genpd, genpd->performance_state);
> +               ret = _genpd_set_performance_state(genpd,
> +                                       genpd->performance_state, depth);

This is going to be a problem for genpd_sync_power_on() as in some
cases we can't allow to use locks.

Moreover I am wondering how this plays with genpd_power_on(), as when
it calls _genpd_power_on() the first time, that is done by holding the
top-level master's lock - and all locks in that hierarchy. In other
words we are always powering on the top most master first, then step
by step we move down in the hierarchy to power on the genpds.

>                 if (ret) {
>                         pr_warn("%s: Failed to set performance state %d (%d)\n",
>                                 genpd->name, genpd->performance_state, ret);
> @@ -558,7 +633,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
>                 }
>         }
>
> -       ret = _genpd_power_on(genpd, true);
> +       ret = _genpd_power_on(genpd, true, depth);
>         if (ret)
>                 goto err;
>
> @@ -963,7 +1038,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
>                         genpd_unlock(link->master);
>         }
>
> -       _genpd_power_on(genpd, false);
> +       _genpd_power_on(genpd, false, depth);
>
>         genpd->status = GPD_STATE_ACTIVE;
>  }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 9ad101362aef..dd364abb649a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -136,6 +136,10 @@ struct gpd_link {
>         struct list_head master_node;
>         struct generic_pm_domain *slave;
>         struct list_head slave_node;
> +
> +       /* Sub-domain's per-master domain performance state */
> +       unsigned int performance_state;
> +       unsigned int prev_performance_state;
>  };
>
>  struct gpd_timing_data {
> --
> 2.19.1.568.g152ad8e3369a
>

Kind regards
Uffe
