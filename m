Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27604ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F2220834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZ5VPvI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F2220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeJYT1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:27:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34725 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeJYT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:27:48 -0400
Received: by mail-io1-f65.google.com with SMTP id d80-v6so5188700iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wE6vN+VmpmM6YfGX8JOvp8Iwo0vQt6NomRHQDmoBt4c=;
        b=bZ5VPvI4fLWIjFrPH8e3C716aJSHfXB+tNQnkx3uJI7F4/HyIgFHWHxRVbr3uy7GiK
         uQ2ORKF6Hfpk4i746hbP15iZyqBhbNAE955SmGu7KE41khUYsmfArVaYS2YeJP58G6ds
         wHNava6WIS20Tdhx/qK4EmzE4YfCHFN5sGktc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wE6vN+VmpmM6YfGX8JOvp8Iwo0vQt6NomRHQDmoBt4c=;
        b=bchK1GKFJ1CRHT+q6zLJaOAVZAw9nXOwOoJmy8CGZdTsaLwdEBhUducl9itJtR1Uwd
         MtZYDBPuDwYwnh59iuhNjf0ZVlgPVWJVXSp+NWDVJpmNnvCGHD0q64Dm3JMviKloJdTT
         UToro6V5xcvTFEWS4Bbrt/Wh54JPl1A1x/eilu5Zjgy9Hy5wr9GFfM734Ybnb21FVmRV
         PXknHv8DtCvO/sqc+VtDIXgxV8aKS41ljuMXXpAoZBgKc29vpx5yPe294SDvlYOT9FJk
         OD9R3Y05464ziEaC7XTd4u/bK2IhEBWmQUE+n8pPk20K8dROrnN/XkCJofD48YPq4JkH
         GrlA==
X-Gm-Message-State: AGRZ1gILhdMhnFb5i7Ze7E2LpSnhD2b8fntNEQeYnD1jFOmpMYUCBNlw
        AINirBdytaS+0vLK5I90amH5DQBTwOY/fE7Ez/38QQ==
X-Google-Smtp-Source: AJdET5ePQsZ33B1gNiYJwozy5i+KOsjvtbNe8P5C87zn8eB9Mx3EtqgVxxryxztCJtduu/2FDfQCi+1u533RWNxc0Nw=
X-Received: by 2002:a6b:1406:: with SMTP id 6-v6mr582249iou.218.1540464933867;
 Thu, 25 Oct 2018 03:55:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 03:54:53
 -0700 (PDT)
In-Reply-To: <6ac7dd52047805dc1ec211cce261aee561d10abc.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org> <6ac7dd52047805dc1ec211cce261aee561d10abc.1540446493.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Oct 2018 12:54:53 +0200
Message-ID: <CAPDyKFouaQzaQvaMfBVYzQadcU9R=LgD51bJKK4+N0T_ky1duA@mail.gmail.com>
Subject: Re: [PATCH V3 09/10] OPP: Rename and relocate of_genpd_opp_to_performance_state()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 October 2018 at 07:52, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP core already has the performance state values for each of the
> genpd's OPPs and there is no need to call the genpd callback again to
> get the performance state for the case where the end device doesn't have
> an OPP table and has the "required-opps" property directly in its node.
>
> This commit renames of_genpd_opp_to_performance_state() as
> of_get_required_opp_performance_state() and moves it to the OPP core, as
> it is all about OPP stuff now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 48 -------------------------------------
>  drivers/opp/of.c            | 44 ++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  9 -------
>  include/linux/pm_opp.h      |  5 ++++
>  4 files changed, 49 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7be8c94c6b7f..8e554e6a82a2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2552,54 +2552,6 @@ unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
>
> -/**
> - * of_genpd_opp_to_performance_state- Gets performance state of device's
> - * power domain corresponding to a DT node's "required-opps" property.
> - *
> - * @dev: Device for which the performance-state needs to be found.
> - * @np: DT node where the "required-opps" property is present. This can be
> - *     the device node itself (if it doesn't have an OPP table) or a node
> - *     within the OPP table of a device (if device has an OPP table).
> - *
> - * Returns performance state corresponding to the "required-opps" property of
> - * a DT node. This calls platform specific genpd->opp_to_performance_state()
> - * callback to translate power domain OPP to performance state.
> - *
> - * Returns performance state on success and 0 on failure.
> - */
> -unsigned int of_genpd_opp_to_performance_state(struct device *dev,
> -                                              struct device_node *np)
> -{
> -       struct generic_pm_domain *genpd;
> -       struct dev_pm_opp *opp;
> -       int state = 0;
> -
> -       genpd = dev_to_genpd(dev);
> -       if (IS_ERR(genpd))
> -               return 0;
> -
> -       if (unlikely(!genpd->set_performance_state))
> -               return 0;
> -
> -       genpd_lock(genpd);
> -
> -       opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
> -       if (IS_ERR(opp)) {
> -               dev_err(dev, "Failed to find required OPP: %ld\n",
> -                       PTR_ERR(opp));
> -               goto unlock;
> -       }
> -
> -       state = genpd->opp_to_performance_state(genpd, opp);
> -       dev_pm_opp_put(opp);
> -
> -unlock:
> -       genpd_unlock(genpd);
> -
> -       return state;
> -}
> -EXPORT_SYMBOL_GPL(of_genpd_opp_to_performance_state);
> -
>  static int __init genpd_bus_init(void)
>  {
>         return bus_register(&genpd_bus_type);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 4e494720ac25..0755ee307b1a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -969,6 +969,50 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
>
> +/**
> + * of_get_required_opp_performance_state() - Search for required OPP and return its performance state.
> + * @np: Node that contains the "required-opps" property.
> + * @index: Index of the phandle to parse.
> + *
> + * Returns the performance state of the OPP pointed out by the "required-opps"
> + * property at @index in @np.
> + *
> + * Return: Positive performance state on success, otherwise 0 on errors.
> + */
> +unsigned int of_get_required_opp_performance_state(struct device_node *np,
> +                                                  int index)
> +{
> +       struct dev_pm_opp *opp;
> +       struct device_node *required_np;
> +       struct opp_table *opp_table;
> +       unsigned int pstate = 0;
> +
> +       required_np = of_parse_required_opp(np, index);
> +       if (!required_np)
> +               return -ENODEV;
> +
> +       opp_table = _find_table_of_opp_np(required_np);
> +       if (IS_ERR(opp_table)) {
> +               pr_err("%s: Failed to find required OPP table %pOF: %ld\n",
> +                      __func__, np, PTR_ERR(opp_table));
> +               goto put_required_np;
> +       }
> +
> +       opp = _find_opp_of_np(opp_table, required_np);
> +       if (opp) {
> +               pstate = opp->pstate;
> +               dev_pm_opp_put(opp);
> +       }
> +
> +       dev_pm_opp_put_opp_table(opp_table);
> +
> +put_required_np:
> +       of_node_put(required_np);
> +
> +       return pstate;
> +}
> +EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
> +
>  /**
>   * of_dev_pm_opp_find_required_opp() - Search for required OPP.
>   * @dev: The device whose OPP node is referenced by the 'np' DT node.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 4f803f934308..642036952553 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -260,8 +260,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>                                struct genpd_power_state **states, int *n);
>  unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
>                                                struct dev_pm_opp *opp);
> -unsigned int of_genpd_opp_to_performance_state(struct device *dev,
> -                               struct device_node *np);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> @@ -308,13 +306,6 @@ pm_genpd_opp_to_performance_state(struct device *genpd_dev,
>         return 0;
>  }
>
> -static inline unsigned int
> -of_genpd_opp_to_performance_state(struct device *dev,
> -                                 struct device_node *np)
> -{
> -       return 0;
> -}
> -
>  static inline int genpd_dev_pm_attach(struct device *dev)
>  {
>         return 0;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 8fed222c089b..889bb347fbd9 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -315,6 +315,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
> +unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -357,6 +358,10 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>         return NULL;
>  }
> +static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
> +{
> +       return 0;
> +}
>  #endif
>
>  #endif         /* __LINUX_OPP_H__ */
> --
> 2.19.1.568.g152ad8e3369a
>
