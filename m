Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31075C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EDA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMH83HWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EDA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeLMPyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:54:22 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34752 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:54:22 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so1473328vsi.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rr/HurXpyyqyL2OMn9pBryMAdkmhRZESlMdUO6+xRO4=;
        b=BMH83HWM10udZo8EMo+tm7jECBpqY5Soku6XV/ajIdEE9v/x/rd6O+1R47bq5VLc8p
         lc2UApEQs0Yx0q0TK1LNxz0DBDMfBwbFrINhAkbe60APL+lxbnnst1K8uAK7m14p5y4U
         NvUTgX8xqVjvAKFfsTUq5t1r5A2h3he5ELEMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr/HurXpyyqyL2OMn9pBryMAdkmhRZESlMdUO6+xRO4=;
        b=eh+yOeQ0mX31+XOLYa/GnTCn27zdRpGxgMLhIj/dknRcH/OWC6Hck6vJe2p8Chpgr2
         n0a190D93onX3fVsLx+UpKZJ8DYbOc3ujcz8IOnZH+FjVMhzAhEaXvkyfZ2PbAox67d8
         eM6rPzP1F/r0vOwC5zR4Ayg+L+AKpx9guts2JIurNswnCCI9vMhmNjO0NndRHvscFf0p
         smProg7IuMQh4kBtkuwMZRikv784AWCsp9f43s5WT8jDzraqGHvJS6Rwv3Iw8diE0wBM
         UZkSzqTIvMcqjwKUsjUYYWc6Lz7eD2fgN1/xK/AsMiIEARlI8oY/kVbWNgWGBewjOKgz
         dh2Q==
X-Gm-Message-State: AA+aEWbW8tIj+YzZGYE1AiHWJquiJs6giP3GWz0RAeb4klT28r7YLo+Y
        fIS0ng9eKOgIJSpN2i2/qymBL8uNn+rt4qCoJm4hTw==
X-Google-Smtp-Source: AFSGD/Vky9jAbclSPFPNTBTOYMMvMD9aW4AvGRJyCi4ToPOXgz0w+/OFz/O5UHCmtG5wb1laSS89SmcRk8wkAG7H5Lw=
X-Received: by 2002:a67:b245:: with SMTP id s5mr11570499vsh.200.1544716460938;
 Thu, 13 Dec 2018 07:54:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544611890.git.viresh.kumar@linaro.org> <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
In-Reply-To: <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Dec 2018 16:53:44 +0100
Message-ID: <CAPDyKFpFn60O7W71v7b3fsCtmS520=GG0AQhs3GpdarVE+W--A@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] PM / Domains: Propagate performance state updates
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 at 11:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This commit updates genpd core to start propagating performance state
> updates to master domains that have their set_performance_state()
> callback set.

I would appreciate some more words of what happens during the
propagation. For example, how OPP tables are used and how mapping
between performance states are done from a sub-domain to a
master-domain. At least a high level description would be nice, I
think.

>
> Currently a genpd only handles the performance state requirements from
> the devices under its control. This commit extends that to also handle
> the performance state requirement(s) put on the master genpd by its
> sub-domains. There is a separate value required for each master that
> the genpd has and so a new field is added to the struct gpd_link
> (link->performance_state), which represents the link between a genpd and
> its master. The struct gpd_link also got another field
> prev_performance_state, which is used by genpd core as a temporary
> variable during transitions.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 105 ++++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h   |   4 ++
>  2 files changed, 94 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 32ecbefbd191..5e0479b2e976 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -239,24 +239,90 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
>  static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
>  #endif
>
> +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> +                                          unsigned int state, int depth);
> +
>  static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> -                                       unsigned int state)
> +                                       unsigned int state, int depth)
>  {
> +       struct generic_pm_domain *master;
> +       struct gpd_link *link;
> +       unsigned int master_state;
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
> +                       master_state = 0;
> +               } else {
> +                       /* Find master's performance state */
> +                       master_state = dev_pm_opp_xlate_performance_state(genpd->opp_table,
> +                                               master->opp_table, state);
> +                       if (unlikely(!master_state)) {
> +                               ret = -EINVAL;
> +                               goto err;
> +                       }
> +               }

According to my comment for patch3, the above can be simplified.
Moreover, the "unlikely" thingy above is a bit questionable, as we
can't really know what is "unlikely" here.

> +
> +               genpd_lock_nested(master, depth + 1);
> +
> +               link->prev_performance_state = link->performance_state;
> +               link->performance_state = master_state;
> +               ret = _genpd_reeval_performance_state(master, master_state,
> +                                                     depth + 1);
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
> +               master_state = link->prev_performance_state;
> +               link->performance_state = master_state;
> +
> +               if (_genpd_reeval_performance_state(master, master_state,
> +                                                   depth + 1)) {
> +                       pr_err("%s: Failed to roll back to %d performance state\n",
> +                              master->name, master_state);
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
> @@ -274,21 +340,30 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
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
> +        * Traverse all sub-domains within the domain. This can be
> +        * done without any additional locking as the link->performance_state
> +        * field is protected by the master genpd->lock, which is already taken.
> +        *
> +        * Also note that link->performance_state (subdomain's performance state
> +        * requirement to master domain) is different from
> +        * link->slave->performance_state (current performance state requirement
> +        * of the devices/sub-domains of the subdomain) and so can have a
> +        * different value.
> +        *
> +        * Note that we also take vote from powered-off sub-domains into account
> +        * as the same is done for devices right now.
>          */
> +       list_for_each_entry(link, &genpd->master_links, master_node) {
> +               if (link->performance_state > state)
> +                       state = link->performance_state;
> +       }
> +
> +       if (state == genpd->performance_state)
> +               return 0;
>
>  update_state:
> -       return _genpd_set_performance_state(genpd, state);
> +       return _genpd_set_performance_state(genpd, state, depth);

Instead of calling _genpd_set_performance_state() from here, I suggest
to let the caller do it. Simply return the aggregated new state, if it
needs to be updated - and zero if no update is needed.

Why? I think it may clarify and simplify the code, in regards to the
actual set/propagation of state changes. Another side-effect, is that
you should be able to avoid the forward declaration of
_genpd_reeval_performance_state(), which I think is nice as well.

I guess changing this, should already be done in patch 5, so patch 6
can build on it.

>  }
>
>  /**
> @@ -332,7 +407,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>         prev = gpd_data->performance_state;
>         gpd_data->performance_state = state;
>
> -       ret = _genpd_reeval_performance_state(genpd, state);
> +       ret = _genpd_reeval_performance_state(genpd, state, 0);
>         if (ret)
>                 gpd_data->performance_state = prev;
>
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

Probably a leftover from the earlier versions, please remove.

>  };
>
>  struct gpd_timing_data {
> --
> 2.19.1.568.g152ad8e3369a
>

Kind regards
Uffe
