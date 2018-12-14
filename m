Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80AC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0EF20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wu0NqPPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0EF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeLNKlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:41:18 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33103 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeLNKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:41:17 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so1831165uap.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSjgLtKPy+OMFL+3EXCMhq0orR8xszZ9CZmatOoqlDk=;
        b=Wu0NqPPZcD89x5z02lR1UMOM+Sh03V3QgFMikynskLQ/S9h+FxzgEJtMZmho7XfaaM
         MFvJSbTEwNiomFV11oPGdJmzWQXYudA4jEYzaKLHuoF2L6gpDRztNMPdcYNkD/ASWWmx
         v169gPZi1L2oT11q6nsAj8E2ejPNR4lByuLiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSjgLtKPy+OMFL+3EXCMhq0orR8xszZ9CZmatOoqlDk=;
        b=jMG89hFx56w5AlDlPvGkwd0MBY82W/7H95lbamuyDSr6zzKYuvjBfG3yN+YDoXcPR5
         yG8ix2C2tp5VYj2CzHfWUoY15L/rX0HhWWuPPnjPfgUHcfmt1DfaXm5l4pXdRTLOhGVB
         OtRUnKdjkm0vIkrCzvD7F3I9oQOMDgjGlOprWgSkg7w3sqbpYmZyv2bJmarsMbD9GFe9
         q1JAaG7ScYQyuwQAB0V+zQeNfnUwlBGEN5h54pXicJ7sM9mTgdeY2PosNaKsj821XppB
         Trph8veuWw0O9hwwVEkmfhIUjCDBxIhnR9eix2zElCrcprf+5xbhBD43qr06HV9yFrZ6
         UmdQ==
X-Gm-Message-State: AA+aEWZhsQDM4sFYNEFwchMWR96+Bms1O3mxC9LitRC2yYMfM0HED9Lt
        lPo35vbWJV2q3R0DPy8xI4k8mm7YZEVi8JoWII0EhQ==
X-Google-Smtp-Source: AFSGD/Wt13APKw+K1hlgjxX3HQw9cdt2ZvUCRekrQTgD/AyQgEPFGH2lFHO1fsS3/FLXINwTzoILK0318ITsMA6F0ZA=
X-Received: by 2002:ab0:526:: with SMTP id 35mr1059480uax.25.1544784076617;
 Fri, 14 Dec 2018 02:41:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544782279.git.viresh.kumar@linaro.org> <135e59ab6353cc086b15ef96e2882aaec08e3322.1544782279.git.viresh.kumar@linaro.org>
In-Reply-To: <135e59ab6353cc086b15ef96e2882aaec08e3322.1544782279.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Dec 2018 11:40:40 +0100
Message-ID: <CAPDyKFqW5L_Bmfn6v2ymjeKWZ6jGd9TEvejBQK59r2vBROSviw@mail.gmail.com>
Subject: Re: [PATCH V4 3/7] OPP: Add dev_pm_opp_xlate_performance_state() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
> dev_pm_genpd_set_performance_state() needs to handle performance state
> propagation going forward. Currently this routine only gets the required
> performance state of the device's genpd as an argument, but it doesn't
> know how to translate that to master genpd(s) of the device's genpd.
>
> Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> be used to translate from performance state of a device (or genpd
> sub-domain) to another device (or master genpd).
>
> Normally the src_table (of genpd sub-domain) will have the
> "required_opps" property set to point to one of the OPPs in the
> dst_table (of master genpd), but in some cases the genpd and its master
> have one to one mapping of performance states and so none of them have
> the "required-opps" property set. Return the performance state of the
> src_table as it is in such cases.
>
> Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/opp/core.c     | 63 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  7 +++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 98e60f0ed8b0..e5507add8f04 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1713,6 +1713,69 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
>                 dev_err(virt_dev, "Failed to find required device entry\n");
>  }
>
> +/**
> + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> + * @src_table: OPP table which has dst_table as one of its required OPP table.
> + * @dst_table: Required OPP table of the src_table.
> + * @pstate: Current performance state of the src_table.
> + *
> + * This Returns pstate of the OPP (present in @dst_table) pointed out by the
> + * "required-opps" property of the OPP (present in @src_table) which has
> + * performance state set to @pstate.
> + *
> + * Return: Zero or positive performance state on success, otherwise negative
> + * value on errors.
> + */
> +int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
> +                                      struct opp_table *dst_table,
> +                                      unsigned int pstate)
> +{
> +       struct dev_pm_opp *opp;
> +       int dest_pstate = -EINVAL;
> +       int i;
> +
> +       if (!pstate)
> +               return 0;
> +
> +       /*
> +        * Normally the src_table will have the "required_opps" property set to
> +        * point to one of the OPPs in the dst_table, but in some cases the
> +        * genpd and its master have one to one mapping of performance states
> +        * and so none of them have the "required-opps" property set. Return the
> +        * pstate of the src_table as it is in such cases.
> +        */
> +       if (!src_table->required_opp_count)
> +               return pstate;
> +
> +       for (i = 0; i < src_table->required_opp_count; i++) {
> +               if (src_table->required_opp_tables[i]->np == dst_table->np)
> +                       break;
> +       }
> +
> +       if (unlikely(i == src_table->required_opp_count)) {
> +               pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
> +                      __func__, src_table, dst_table);
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&src_table->lock);
> +
> +       list_for_each_entry(opp, &src_table->opp_list, node) {
> +               if (opp->pstate == pstate) {
> +                       dest_pstate = opp->required_opps[i]->pstate;
> +                       goto unlock;
> +               }
> +       }
> +
> +       pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
> +              dst_table);
> +
> +unlock:
> +       mutex_unlock(&src_table->lock);
> +
> +       return dest_pstate;
> +}
> +
>  /**
>   * dev_pm_opp_add()  - Add an OPP table from a table definitions
>   * @dev:       device for which we do this operation
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 2b2c3fd985ab..0b04c2093eb9 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
>  void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
> +int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
>  }
>
>  static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
> +
> +static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
> +{
> +       return -ENOTSUPP;
> +}
> +
>  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>         return -ENOTSUPP;
> --
> 2.19.1.568.g152ad8e3369a
>
