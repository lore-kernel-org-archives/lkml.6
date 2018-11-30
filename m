Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23607C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45982081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpsuS/Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45982081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeK3UCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:02:21 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45895 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeK3UCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:02:20 -0500
Received: by mail-vs1-f68.google.com with SMTP id v10so2872014vsv.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X1+MhAM+ndLUP+nviSfx6z+uM3DshGB8/xuC8G90ofg=;
        b=HpsuS/KgkcCpAVvZzsCoA5BrGmyDZN1XqHpZaERKtMW3T/PuWhOTAdDV6588LPqONo
         bMkJLx7gXj8N9JMiV2V3ggEfe284XqcLf0VyPPRts2MPETlMf5TXHIDruDdrDhw3uOHU
         2UDKZswPuURx6+iqujVZlbbZ6+bjqax1X7INk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1+MhAM+ndLUP+nviSfx6z+uM3DshGB8/xuC8G90ofg=;
        b=efMx39roNxMl9e8xduwpdqWlveC9gcUTwee9uFMnrke5lkUR9dLqnJZHzXhF35hNm3
         2G+l5ucUcS+RV+thjhJefdrkiWlnt0r/hs2z2O77AOM+IvEqNfEK1BffQfnTMaVKWRYg
         3w1FhNd8zngVs0Qk2GHtOGxS3OrL5NTXPGSk4wxuuahOYFHnEY9KHZtkvNwHGULzAHq1
         e8986Uchj376ZHB0N/XTuWAYeK0MilyJeqYCprSdXnwqFy4LL9VguTap+hSsCqoJHO6i
         2mRuDEEIJ1zAkVyibHiX1miymRL70U9n8pJwniblYUfwX+eBZ1S411yTmVfKDXro/GSJ
         Jmjg==
X-Gm-Message-State: AA+aEWas43/KE4guENvahc565dhRNUH9DnO95tHZSsdT/3vTUUyG1N9b
        hTkLNe77ttHt1y9CJjKQym07Uv8j31Z4bW5Gh73gyg==
X-Google-Smtp-Source: AFSGD/WO0IDW/+ZBovI0O7YdAjXRAz6Qjv/Rl+Zj85Si6U8n0jZ9c3f2wIKMsqCh9WM6hqOk23t9FWF6mflVxvV/joE=
X-Received: by 2002:a67:7685:: with SMTP id r127mr2136341vsc.35.1543568023843;
 Fri, 30 Nov 2018 00:53:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543219386.git.viresh.kumar@linaro.org> <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
In-Reply-To: <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Nov 2018 09:53:07 +0100
Message-ID: <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
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
> We will need these going forward in hotpath, i.e. from within
> dev_pm_genpd_set_performance_state().

Well, as for patch2, please try to be a bit more descriptive of why
and what this patch does.

>
> Lets fetch and save them while the OPP tables are added.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 23 +++++++++++++++++++++--
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 8e554e6a82a2..0d928359b880 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1907,12 +1907,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
>                                 ret);
>                         goto unlock;
>                 }
> +
> +               /*
> +                * Save table for faster processing while setting performance
> +                * state.
> +                */
> +               genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
> +               WARN_ON(!genpd->opp_table);

The WARN_ON seems lazy. Why not implement a proper error path?

>         }
>
>         ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
>         if (ret) {
> -               if (genpd->set_performance_state)
> +               if (genpd->set_performance_state) {
> +                       dev_pm_opp_put_opp_table(genpd->opp_table);
>                         dev_pm_opp_of_remove_table(&genpd->dev);
> +               }
>
>                 goto unlock;
>         }
> @@ -1965,6 +1974,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                                         i, ret);
>                                 goto error;
>                         }
> +
> +                       /*
> +                        * Save table for faster processing while setting
> +                        * performance state.
> +                        */
> +                       genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
> +                       WARN_ON(!genpd->opp_table);
>                 }
>
>                 genpd->provider = &np->fwnode;
> @@ -1989,8 +2005,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>                 genpd->provider = NULL;
>                 genpd->has_provider = false;
>
> -               if (genpd->set_performance_state)
> +               if (genpd->set_performance_state) {
> +                       dev_pm_opp_put_opp_table(genpd->opp_table);
>                         dev_pm_opp_of_remove_table(&genpd->dev);
> +               }
>         }
>
>         mutex_unlock(&gpd_list_lock);
> @@ -2024,6 +2042,7 @@ void of_genpd_del_provider(struct device_node *np)
>                                         if (!gpd->set_performance_state)
>                                                 continue;
>
> +                                       dev_pm_opp_put_opp_table(gpd->opp_table);
>                                         dev_pm_opp_of_remove_table(&gpd->dev);
>                                 }
>                         }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 642036952553..9ad101362aef 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -73,6 +73,7 @@ struct genpd_power_state {
>
>  struct genpd_lock_ops;
>  struct dev_pm_opp;
> +struct opp_table;
>
>  struct generic_pm_domain {
>         struct device dev;
> @@ -94,6 +95,7 @@ struct generic_pm_domain {
>         unsigned int performance_state; /* Aggregated max performance state */
>         int (*power_off)(struct generic_pm_domain *domain);
>         int (*power_on)(struct generic_pm_domain *domain);
> +       struct opp_table *opp_table;    /* OPP table of the genpd */
>         unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
>                                                  struct dev_pm_opp *opp);
>         int (*set_performance_state)(struct generic_pm_domain *genpd,
> --
> 2.19.1.568.g152ad8e3369a
>

Similar as for patch2, this makes sense to me. Although, let me review
the complete series before giving a final call.

Kind regards
Uffe
