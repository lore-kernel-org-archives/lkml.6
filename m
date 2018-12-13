Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77047C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289002086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sy40tjA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289002086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeLMOyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:54:00 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35303 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbeLMOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:53:59 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so1335479vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEqEvUYRoQzoe2HcBinTZo9g/lODyxn67n/F7eXM55o=;
        b=Sy40tjA3auWtG0GKfqajerAt/4lxS8oET4xa3PawE+z7hkacsKgnzEIpK0pBDMMsja
         c9oyv3AGG3VQ2YX97O56XkE2zsx/X6g6d7RS4FA7xwEvVCM/KTvI7lbhbgAaEbYYvu3V
         lfT4ICMh2QBHaf7+zEWcW8YagWV+j3AjygDyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEqEvUYRoQzoe2HcBinTZo9g/lODyxn67n/F7eXM55o=;
        b=YKPYWivDTIFCWMQuZgbDI44K6NGFIOSs9e84UJ+Yl8aSIXU1BNDQkh8KD22rlkKWk4
         +Dc9oEYrG6zfkuwlOrtTdp5nChkx7tiJeHWp6sVe1OoY3CafVjRsK/UWSh83j/C5NQIt
         uqkYSYgvOeeh9A+i/3ip1Hxom9Hn2oz/vm933DtlBfKjHbnwv0iMz85OkuUq+GJUliw8
         L1IEy40aSyxx9y/sSfQXw4lgK2ik4MMlPhhhyTPUvk9OGuLC8lHl+2qJA7W7BkedYuwD
         QqlqLlEFxPiRuwWdz/bQgClDvuwzUIEtIlJpd1LvjVTsX4Mg/BqtN+769R+z3WNPhRlc
         Fm6g==
X-Gm-Message-State: AA+aEWZF8FgfGT4Ozi7CR/LZzHP1SVULVaOEzBTspyOBHTW9YOZbyaiF
        KoAnyozVfIMFtolVCJBCBUb/dHbdXVfKc/yRTrUrxg==
X-Google-Smtp-Source: AFSGD/WsS+V8APY93XQrPaMTUd6IY9og/vXjdm1yQCGiNeVfote2HFdJO3w21KyYtCpPXFhH4xa9NtJfxZO1ND0f7vc=
X-Received: by 2002:a67:7685:: with SMTP id r127mr11176051vsc.35.1544712838098;
 Thu, 13 Dec 2018 06:53:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544611890.git.viresh.kumar@linaro.org> <6ea171c4f791aae3281e49077893f76ad4c55677.1544611890.git.viresh.kumar@linaro.org>
In-Reply-To: <6ea171c4f791aae3281e49077893f76ad4c55677.1544611890.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Dec 2018 15:53:22 +0100
Message-ID: <CAPDyKFo1f+QxR_M1_A_edsr2oFCPRH905fPQ6WV6N=79P1x6_Q@mail.gmail.com>
Subject: Re: [PATCH V3 3/6] OPP: Add dev_pm_opp_xlate_performance_state() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, 12 Dec 2018 at 11:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
> ---
>  drivers/opp/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  7 +++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 98e60f0ed8b0..386095e2f4f7 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1713,6 +1713,65 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
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

To simplify for callers, I would rather not have the return code 0
being treated as an error. Instead I would prefer 0 to mean that the
state shall be set to zero (which means it should be perfectly fine to
also give 0 as inparam for pstate)

For errors, I think it's better to return regular negative error
codes, as it's standard and more flexible.

Kind regards
Uffe

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
