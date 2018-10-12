Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1D2C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCAD213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWlHgIW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCAD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeJLWpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:45:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53013 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbeJLWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:45:14 -0400
Received: by mail-it1-f194.google.com with SMTP id 134-v6so19220289itz.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zzwfY9nrW4Q7khu3vjGs7s13XauVtraptpLOdslm4X0=;
        b=eWlHgIW57WGbW4htCUX9aBm2zCOaXW3mFqSpWXsyXyo8wqXOENu1Uf6DSpJ4wdOGfz
         D7CK1kGvYR4TR6s+IVwENcIe8wN7W1S+Lfx9SUdNN/WVNSnfhumlG5q7TRc1akGt3sKN
         a+4IwYEv1Wgl3U2wulaSlcsYu3nvAIRV/V8+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zzwfY9nrW4Q7khu3vjGs7s13XauVtraptpLOdslm4X0=;
        b=hFKA8ImSs5DTbeoA3ryLXdsvcpWwsN6VpyuAPtMYbmCEXHlYjUj83vA+u02cf3zYTX
         toQEmeN6fxozGl5RsQLDnBAeYK7tRdv3O64gSln7y0vGe0NuzSYV4bMqK1ANpIE89q1O
         LmIRXobW+WlpooGYgUJuwyq+KeeURNrMt/6BbxBB8ia2c1FfW2Z7Ub7zeS44Ad131MQV
         Qpu6pzWao1lwZRuwVsoa/aTBjyfDDgGhbwQrWNeDK3VWMw79tZ/+wDuWCmFxxJVpmzpv
         dVjocxvksjsn+36IB0ubjH035K2hbM13KzIjHcKuhDP928XuEKEhLFPg1bF6WyjgCXCt
         QBAQ==
X-Gm-Message-State: ABuFfogqHVtHiUXfkkJ6LM8YSwEhYhaCi9ypx1nDZrnDgONW7ZL5zjKg
        aAR2mKFPfSUYdLrneKE/455QSq7YyR+23qwrlZDJyg==
X-Google-Smtp-Source: ACcGV60xbmAtbcrV3skQylRBVVEE+VqPr4IIeCEHqr4/2unQAwe2qeyXw6+rttRiOSoOlaZRijmXpVlXRM1oo0E1iXk=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr4819749itc.26.1539357139415;
 Fri, 12 Oct 2018 08:12:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 08:11:39
 -0700 (PDT)
In-Reply-To: <16fe09d146a2bcd892a62fec595252b1cb2e539d.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org> <16fe09d146a2bcd892a62fec595252b1cb2e539d.1539341929.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Oct 2018 17:11:39 +0200
Message-ID: <CAPDyKFoQh9W9yxjYrcMaLu9A8KPQ+PS71=6fOh4j1122R6JQsQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] OPP: Populate OPPs from "required-opps" property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 October 2018 at 13:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> An earlier commit populated the OPP tables from the "required-opps"
> property, this commit populates the individual OPPs. This is repeated
> for each OPP in the OPP table and these populated OPPs will be used by
> later commits.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c |  1 +
>  drivers/opp/of.c   | 81 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/opp/opp.h  |  6 ++++
>  3 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 85174a5c4850..02a69a62dac8 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -976,6 +976,7 @@ static void _opp_kref_release(struct kref *kref)
>          * frequency/voltage list.
>          */
>         blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_REMOVE, opp);
> +       _of_opp_free_required_opps(opp_table, opp);
>         opp_debug_remove_one(opp);
>         list_del(&opp->node);
>         kfree(opp);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index b5605196122a..ffaeefef98ce 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -259,6 +259,77 @@ void _of_clear_opp_table(struct opp_table *opp_table)
>         _opp_table_free_required_tables(opp_table);
>  }
>
> +/*
> + * Release all resources previously acquired with a call to
> + * _of_opp_alloc_required_opps().
> + */
> +void _of_opp_free_required_opps(struct opp_table *opp_table,
> +                               struct dev_pm_opp *opp)
> +{
> +       struct dev_pm_opp **required_opps = opp->required_opps;
> +       int i;
> +
> +       if (!required_opps)
> +               return;
> +
> +       for (i = 0; i < opp_table->required_opp_count; i++) {
> +               if (!required_opps[i])
> +                       break;
> +
> +               /* Put the reference back */
> +               dev_pm_opp_put(required_opps[i]);
> +       }
> +
> +       kfree(required_opps);
> +       opp->required_opps = NULL;
> +}
> +
> +/* Populate all required OPPs which are part of "required-opps" list */
> +static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
> +                                      struct dev_pm_opp *opp)
> +{
> +       struct dev_pm_opp **required_opps;
> +       struct opp_table *required_table;
> +       struct device_node *np;
> +       int i, ret, count = opp_table->required_opp_count;
> +
> +       if (!count)
> +               return 0;
> +
> +       required_opps = kcalloc(count, sizeof(*required_opps), GFP_KERNEL);
> +       if (!required_opps)
> +               return -ENOMEM;
> +
> +       opp->required_opps = required_opps;
> +
> +       for (i = 0; i < count; i++) {
> +               required_table = opp_table->required_opp_tables[i];
> +
> +               np = of_parse_required_opp(opp->np, i);
> +               if (unlikely(!np)) {
> +                       ret = -ENODEV;
> +                       goto free_required_opps;
> +               }
> +
> +               required_opps[i] = _find_opp_of_np(required_table, np);
> +               of_node_put(np);
> +
> +               if (!required_opps[i]) {
> +                       pr_err("%s: Unable to find required OPP node: %pOF (%d)\n",
> +                              __func__, opp->np, i);
> +                       ret = -ENODEV;
> +                       goto free_required_opps;
> +               }
> +       }
> +
> +       return 0;
> +
> +free_required_opps:
> +       _of_opp_free_required_opps(opp_table, opp);
> +
> +       return ret;
> +}
> +
>  static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>                               struct device_node *np)
>  {
> @@ -503,6 +574,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         new_opp->dynamic = false;
>         new_opp->available = true;
>
> +       ret = _of_opp_alloc_required_opps(opp_table, new_opp);
> +       if (ret)
> +               goto free_opp;
> +
>         if (!of_property_read_u32(np, "clock-latency-ns", &val))
>                 new_opp->clock_latency_ns = val;
>
> @@ -510,14 +585,14 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>
>         ret = opp_parse_supplies(new_opp, dev, opp_table);
>         if (ret)
> -               goto free_opp;
> +               goto free_required_opps;
>
>         ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
>         if (ret) {
>                 /* Don't return error for duplicate OPPs */
>                 if (ret == -EBUSY)
>                         ret = 0;
> -               goto free_opp;
> +               goto free_required_opps;
>         }
>
>         /* OPP to select on device suspend */
> @@ -547,6 +622,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         blocking_notifier_call_chain(&opp_table->head, OPP_EVENT_ADD, new_opp);
>         return new_opp;
>
> +free_required_opps:
> +       _of_opp_free_required_opps(opp_table, new_opp);
>  free_opp:
>         _opp_free(new_opp);
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 024e1be23d37..24b340ad18d1 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -63,6 +63,7 @@ extern struct list_head opp_tables;
>   * @supplies:  Power supplies voltage/current values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
>   *             frequency from any other OPP's frequency.
> + * @required_opps: List of OPPs that are required by this OPP.
>   * @opp_table: points back to the opp_table struct this opp belongs to
>   * @np:                OPP's device node.
>   * @dentry:    debugfs dentry pointer (per opp)
> @@ -84,6 +85,7 @@ struct dev_pm_opp {
>
>         unsigned long clock_latency_ns;
>
> +       struct dev_pm_opp **required_opps;
>         struct opp_table *opp_table;
>
>         struct device_node *np;
> @@ -216,10 +218,14 @@ void _put_opp_list_kref(struct opp_table *opp_table);
>  void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
>  void _of_clear_opp_table(struct opp_table *opp_table);
>  struct opp_table *_managed_opp(struct device *dev, int index);
> +void _of_opp_free_required_opps(struct opp_table *opp_table,
> +                               struct dev_pm_opp *opp);
>  #else
>  static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
>  static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
>  static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
> +static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
> +                                             struct dev_pm_opp *opp) {}
>  #endif
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.18.0.rc1.242.g61856ae69a2c
>
