Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09410C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB12C20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+qb7grU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB12C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeK3TzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:55:07 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39180 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeK3TzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:55:06 -0500
Received: by mail-ua1-f68.google.com with SMTP id k10so1610789ual.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P16kqi0BbwC/Id9q3/kCZs+e6tgkK53zUmnuWDCPzCs=;
        b=f+qb7grULHlMjOQdpSnwJKX1BstBmNnAISS70Wy4sgwH6T6fulfl9I+00WWj+JiK0C
         ZlFI73BLMg/hwT/0ztE47qpKDWwOpvldDvTqAgOjml40HW8RyVMXyyV6LBhytgpUnvJU
         HdvgdIj1a4WLb45tNOr04Figujw0huWRFc7AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P16kqi0BbwC/Id9q3/kCZs+e6tgkK53zUmnuWDCPzCs=;
        b=GjA4nG7veZYmZ+LDRZfTI/DcOdLdBDZ4MXgkXm2/q1Q2u2sbeKXJyJvq30wVFFbHZK
         9R2nWDEjNgIJW31EoolRM1DKT6oSSTNVqLHDKjHoVgQZNBT0k5W6kIKlF/CGFZDic+EP
         vjzJAXZUAc+H7ibPZiIRUxmIAhzzDg7ar9An8OfGB1gpU85TvDkTJBRbzskf7KeLOVMi
         ETh+9SzSPPDVMNgcSvEdatTHo93qrkvPHPwxwqhxwbMZAZxkdCQfVVWiWFIJxXimsZQk
         5equ/Bco2gpFyey2LbaY8L1ZS/ieovqoF77OqqpwuHkdH2llnFRnac7Tkm5Qxg394QI7
         1NGA==
X-Gm-Message-State: AA+aEWYYQuOkTGWEovZ1ccrMOuCetJaPkohgz0Tkf8xzQxkGaUfhzFRC
        u1VpcRNPASphwCiE0pzS0Zo3a7uLyvBgEOtffcyvyw==
X-Google-Smtp-Source: AFSGD/Wm8m9s3bb07j+QyJH8nf+dIRfQWkvGmcMwLLTOAmUeMoFctCsM/r1oHwbnUAW1oYJEoDnEc/RYpJc5+LuNe7Y=
X-Received: by 2002:ab0:526:: with SMTP id 35mr2124916uax.25.1543567591183;
 Fri, 30 Nov 2018 00:46:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543219386.git.viresh.kumar@linaro.org> <8bb37fb6120221ded6abb53e69c86620aade20f6.1543219386.git.viresh.kumar@linaro.org>
In-Reply-To: <8bb37fb6120221ded6abb53e69c86620aade20f6.1543219386.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Nov 2018 09:45:55 +0100
Message-ID: <CAPDyKFo+P0oUoPuNCJV4eumn-cqrM5_LBOvY3qQ9qy_HY5Lt2g@mail.gmail.com>
Subject: Re: [PATCH V2 2/5] OPP: Add dev_pm_opp_xlate_performance_state() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
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
> Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> be used to translate from pstate of a device to another one.

I don't get this, could you please elaborate?

>
> Initially this will be used by genpd to find pstate of a master domain
> using its sub-domain's pstate.

I assume pstate is the performance state of a genpd that you refer to,
no? Please try to be a bit more descriptive in your changelogs, to
avoid confusions.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  7 +++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0eaa954b3f6c..99b71f60b6d8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1707,6 +1707,65 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
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
> + * Return: Positive performance state on success, otherwise 0 on errors.
> + */
> +unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
> +                                               struct opp_table *dst_table,
> +                                               unsigned int pstate)
> +{
> +       struct dev_pm_opp *opp;
> +       unsigned int dest_pstate = 0;
> +       int i;
> +
> +       /*
> +        * Normally the src_table will have the "required_opps" property set to
> +        * point to one of the OPPs in the dst_table, but in some cases the
> +        * genpd and its master have one to one mapping of performance states
> +        * and so none of them have the "required-opps" property set. Return the
> +        * pstate of the src_table as it is in such cases.

This comment is good, but I also think some of this important
information is missing in the changelog.

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
> +               return 0;
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
> index 2b2c3fd985ab..5a64a81a1789 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
>  void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
> +unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
>  }
>
>  static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
> +
> +static inline unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
> +{
> +       return 0;
> +}
> +
>  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>         return -ENOTSUPP;
> --
> 2.19.1.568.g152ad8e3369a
>

Besides the comments, I think this makes sense to me. Although, let me
review the rest in the series before making a final call.

Kind regards
Uffe
