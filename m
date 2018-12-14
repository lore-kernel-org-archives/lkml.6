Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8FD21104
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VHkkHxTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8FD21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbeLNKl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:41:26 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37933 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeLNKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:41:24 -0500
Received: by mail-vs1-f67.google.com with SMTP id x64so3088198vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGQoybvRjzvId7zKUO+w4nxDczbkes5as/RhNukbQUU=;
        b=VHkkHxTTWkgBhjEt29T4pvdxy6FUsfdeZpzf6ss490NG+5G+CTMsWm5ck4Zv+lZ8Mr
         yanwH1QpvrPp9jNV6ifredDNBeENGUVU5zfmj3d/bsxPBZFmMTY7qfuR7Qob5MO0DYPk
         xWP+ZEndBnkTpRgJtA16r9NGCNcBd2+0/YLDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGQoybvRjzvId7zKUO+w4nxDczbkes5as/RhNukbQUU=;
        b=qaV7n4s2TbCwjaGnU8K3hdl5RTzlpBkzd1DpjBlBtvbdBA9kxacL5cWog/SDFmYeGa
         ZTsboNX8XaAY4kTLgijmI9vStq8UJZk2iI1Gs/OAbVIcSPau0bS/F/v/RquFsC2ifRVo
         UR7LM8xLpeFju7ySNQhHwrhpZR2HL0g37GtyuNMyabUg3Mf/1yCtrCHFl2sXdYIu9BQ6
         2GSDYySVp2rsxu2p2PLjd3aRmEOjmBYGO5KJCTkcdXUVUFlAcbu+6x6PEsV3lJxkwgYo
         EgauCH62dUiTIgD5xrfKSB6USPIznSfwYizUfm0IlU/IOg72JPcypTHyxTn94l4uwSYp
         zTVQ==
X-Gm-Message-State: AA+aEWYuMK9nFj4XgCFKDnjMLgqJV/qkTGqr3vSkpUcPUdj+ClAtm8bv
        eSlTXKvlLomgMh8aQgX+i4CZ/yfNSvBBFYJhAZMcbg==
X-Google-Smtp-Source: AFSGD/X+69Tet1oPvXQPcGWuZkKHhI4t7FNjsX73emaaZpLGHNBFsFvkccTORkAI+Y4v1MXasGeNokdcjriHnCdkGtc=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr1015754vsa.165.1544784083155;
 Fri, 14 Dec 2018 02:41:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544782279.git.viresh.kumar@linaro.org> <5603371d1ad204a7314a3618d362d583b555f6b6.1544782279.git.viresh.kumar@linaro.org>
In-Reply-To: <5603371d1ad204a7314a3618d362d583b555f6b6.1544782279.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Dec 2018 11:40:47 +0100
Message-ID: <CAPDyKFrDGr_xfNeaSoiScmJAwa_NkNjqQEeSyLkZnQGLUnxQbw@mail.gmail.com>
Subject: Re: [PATCH V4 5/7] PM / Domains: Save OPP table pointer in genpd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
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

On Fri, 14 Dec 2018 at 11:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> dev_pm_genpd_set_performance_state() will be required to call
> dev_pm_opp_xlate_performance_state() going forward to translate from
> performance state of a sub-domain to performance state of its master.
> And dev_pm_opp_xlate_performance_state() needs pointers to the OPP
> tables of both genpd and its master.
>
> Lets fetch and save them while the OPP tables are added. Fetching the
> OPP tables should never fail as we just added the OPP tables and so add
> a WARN_ON() for such a bug instead of full error paths.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/domain.c | 23 +++++++++++++++++++++--
>  include/linux/pm_domain.h   |  2 ++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4a4e39d12354..1e98c637e069 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1896,12 +1896,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
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
> @@ -1954,6 +1963,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
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
> @@ -1978,8 +1994,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
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
> @@ -2013,6 +2031,7 @@ void of_genpd_del_provider(struct device_node *np)
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
