Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B208C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLAd60ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB06D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJYT1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:27:39 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53371 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeJYT1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:27:39 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so1101833itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+9efLu04qrLs+69mBJH3OSOAGyBdESHIF60yhNhNKi4=;
        b=bLAd60ldFX+MhDXr3FbPdFGXT+F4D5LX0RlPdutHgTrd4BtmivWkBvsjeFRVb/e8dE
         v0AwX5/sq6GYFGSLqpgjFBEc0XEMJr24qBSJmPE+H039VCmmo6D0i6Ehx5S7osjxzH0h
         we6aRC9h4J7sWK2CATpuyEWZxItPhTvcduW6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+9efLu04qrLs+69mBJH3OSOAGyBdESHIF60yhNhNKi4=;
        b=lGziJXySn05fXJjnMNyNqpTyyNHCZTA40kUpuQKSmxh7OQCeLE25OcfXw70ftZBbOi
         jj05diHiphXznUD/19pr3Gy/r71Zsuu5/jdbImEzTyilu1bcJgTyCeeFRKkPVrdjQF+Z
         VK51YJuBSksvi8Za5yStO5Iocb14FdkFIVI+3MI/F32Owdf9Qs8MY8AtSqz5N6KiUJg3
         BOmywqmwsn74FIqNb4GQaQv988TMzWM/4B5Q9QRuLFbzFNBk12NtK4RWokBwwOVW7ZNI
         dyrIxVEWfeFQDdjtsTqNIiHShhhLsE9peSNGoOPRrk+eIMig91COrzwPYZBwfG35NjDC
         vw+Q==
X-Gm-Message-State: AGRZ1gKpmcjupzt7qaaqArrIpNAPwVm33sBEuF6LnpK66SYdY0vSuUa7
        +x8PXPlGxCymxQnxrCOm5U6sf4uDqKWaoew1Db1O3A==
X-Google-Smtp-Source: AJdET5fbBkM8HZOafUfyQd0+77zK9P1d33aOogHD+4mq+T5cRf6qh9Hu29Y2aPtySbdXuA2QmameJsAsBlS/65mVTlQ=
X-Received: by 2002:a02:2b29:: with SMTP id h41-v6mr667503jaa.12.1540464924806;
 Thu, 25 Oct 2018 03:55:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 25 Oct 2018 03:54:44
 -0700 (PDT)
In-Reply-To: <6a9919dba23fe0d28bfb3a72aef980ec5c3c539b.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org> <6a9919dba23fe0d28bfb3a72aef980ec5c3c539b.1540446493.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Oct 2018 12:54:44 +0200
Message-ID: <CAPDyKFoJ1uM-bvF5B3VA+OHKO6SzDXGde=0a_-DLjxXjiY0kfw@mail.gmail.com>
Subject: Re: [PATCH V3 07/10] OPP: Add dev_pm_opp_{set|put}_genpd_virt_dev() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
> Multiple generic power domains for a consumer device are supported with
> the help of virtual devices, which are created for each consumer device
> - genpd pair. These are the device structures which are attached to the
> power domain and are required by the OPP core to set the performance
> state of the genpd.
>
> The helpers added by this commit are required to be called once for each
> of these virtual devices. These are required only if multiple domains
> are available for a device, otherwise the actual device structure will
> be used instead by the OPP core.
>
> The new helpers also support the complex cases where the consumer device
> wouldn't always require all the domains. For example, a camera may
> require only one power domain during normal operations but two during
> high resolution operations. The consumer driver can call
> dev_pm_opp_put_genpd_virt_dev(high_resolution_genpd_virt_dev) if it is
> currently operating in the normal mode and doesn't have any performance
> requirements from the genpd which manages high resolution power
> requirements. The consumer driver can later call
> dev_pm_opp_set_genpd_virt_dev(high_resolution_genpd_virt_dev) once it
> switches back to the high resolution mode.
>
> The new helpers differ from other OPP set/put helpers as the new ones
> can be called with OPPs initialized for the table as we may need to call
> them on the fly because of the complex case explained above. For this
> reason it is possible that the genpd virt_dev structure may be used in
> parallel while the new helpers are running and a new mutex is added to
> protect against that. We didn't use the existing opp_table->lock mutex
> as that is widely used in the OPP core and we will need this lock in the
> dev_pm_opp_set_rate() helper while changing OPP and we need to make sure
> there is not much contention while doing that as that's the hotpath.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/opp/core.c     | 88 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/opp/of.c       | 16 +++++++-
>  drivers/opp/opp.h      |  4 ++
>  include/linux/pm_opp.h |  8 ++++
>  4 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 02a69a62dac8..cef2ccda355d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -823,6 +823,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
>                 return NULL;
>
>         mutex_init(&opp_table->lock);
> +       mutex_init(&opp_table->genpd_virt_dev_lock);
>         INIT_LIST_HEAD(&opp_table->dev_list);
>
>         opp_dev = _add_opp_dev(dev, opp_table);
> @@ -920,6 +921,7 @@ static void _opp_table_kref_release(struct kref *kref)
>                 _remove_opp_dev(opp_dev, opp_table);
>         }
>
> +       mutex_destroy(&opp_table->genpd_virt_dev_lock);
>         mutex_destroy(&opp_table->lock);
>         list_del(&opp_table->node);
>         kfree(opp_table);
> @@ -1602,6 +1604,92 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_unregister_set_opp_helper);
>
> +/**
> + * dev_pm_opp_set_genpd_virt_dev - Set virtual genpd device for an index
> + * @dev: Consumer device for which the genpd device is getting set.
> + * @virt_dev: virtual genpd device.
> + * @index: index.
> + *
> + * Multiple generic power domains for a device are supported with the help of
> + * virtual genpd devices, which are created for each consumer device - genpd
> + * pair. These are the device structures which are attached to the power domain
> + * and are required by the OPP core to set the performance state of the genpd.
> + *
> + * This helper will normally be called by the consumer driver of the device
> + * "dev", as only that has details of the genpd devices.
> + *
> + * This helper needs to be called once for each of those virtual devices, but
> + * only if multiple domains are available for a device. Otherwise the original
> + * device structure will be used instead by the OPP core.
> + */
> +struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev,
> +                                               struct device *virt_dev,
> +                                               int index)
> +{
> +       struct opp_table *opp_table;
> +
> +       opp_table = dev_pm_opp_get_opp_table(dev);
> +       if (!opp_table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       mutex_lock(&opp_table->genpd_virt_dev_lock);
> +
> +       if (unlikely(!opp_table->genpd_virt_devs ||
> +                    index >= opp_table->required_opp_count ||
> +                    opp_table->genpd_virt_devs[index])) {
> +
> +               dev_err(dev, "Invalid request to set required device\n");
> +               dev_pm_opp_put_opp_table(opp_table);
> +               mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       opp_table->genpd_virt_devs[index] = virt_dev;
> +       mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +
> +       return opp_table;
> +}
> +
> +/**
> + * dev_pm_opp_put_genpd_virt_dev() - Releases resources blocked for genpd device.
> + * @opp_table: OPP table returned by dev_pm_opp_set_genpd_virt_dev().
> + * @virt_dev: virtual genpd device.
> + *
> + * This releases the resource previously acquired with a call to
> + * dev_pm_opp_set_genpd_virt_dev(). The consumer driver shall call this helper
> + * if it doesn't want OPP core to update performance state of a power domain
> + * anymore.
> + */
> +void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> +                                  struct device *virt_dev)
> +{
> +       int i;
> +
> +       /*
> +        * Acquire genpd_virt_dev_lock to make sure virt_dev isn't getting
> +        * used in parallel.
> +        */
> +       mutex_lock(&opp_table->genpd_virt_dev_lock);
> +
> +       for (i = 0; i < opp_table->required_opp_count; i++) {
> +               if (opp_table->genpd_virt_devs[i] != virt_dev)
> +                       continue;
> +
> +               opp_table->genpd_virt_devs[i] = NULL;
> +               dev_pm_opp_put_opp_table(opp_table);
> +
> +               /* Drop the vote */
> +               dev_pm_genpd_set_performance_state(virt_dev, 0);
> +               break;
> +       }
> +
> +       mutex_unlock(&opp_table->genpd_virt_dev_lock);
> +
> +       if (unlikely(i == opp_table->required_opp_count))
> +               dev_err(virt_dev, "Failed to find required device entry\n");
> +}
> +
>  /**
>   * dev_pm_opp_add()  - Add an OPP table from a table definitions
>   * @dev:       device for which we do this operation
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index ffaeefef98ce..71aef28953c2 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -134,6 +134,7 @@ static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
>  static void _opp_table_free_required_tables(struct opp_table *opp_table)
>  {
>         struct opp_table **required_opp_tables = opp_table->required_opp_tables;
> +       struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
>         int i;
>
>         if (!required_opp_tables)
> @@ -147,8 +148,10 @@ static void _opp_table_free_required_tables(struct opp_table *opp_table)
>         }
>
>         kfree(required_opp_tables);
> +       kfree(genpd_virt_devs);
>
>         opp_table->required_opp_count = 0;
> +       opp_table->genpd_virt_devs = NULL;
>         opp_table->required_opp_tables = NULL;
>  }
>
> @@ -161,6 +164,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>                                              struct device_node *opp_np)
>  {
>         struct opp_table **required_opp_tables;
> +       struct device **genpd_virt_devs = NULL;
>         struct device_node *required_np, *np;
>         int count, i;
>
> @@ -175,11 +179,21 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>         if (!count)
>                 goto put_np;
>
> +       if (count > 1) {
> +               genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
> +                                       GFP_KERNEL);
> +               if (!genpd_virt_devs)
> +                       goto put_np;
> +       }
> +
>         required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
>                                       GFP_KERNEL);
> -       if (!required_opp_tables)
> +       if (!required_opp_tables) {
> +               kfree(genpd_virt_devs);
>                 goto put_np;
> +       }
>
> +       opp_table->genpd_virt_devs = genpd_virt_devs;
>         opp_table->required_opp_tables = required_opp_tables;
>         opp_table->required_opp_count = count;
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 24b340ad18d1..8aec38792cae 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -135,6 +135,8 @@ enum opp_table_access {
>   * @parsed_static_opps: True if OPPs are initialized from DT.
>   * @shared_opp: OPP is shared between multiple devices.
>   * @suspend_opp: Pointer to OPP to be used during device suspend.
> + * @genpd_virt_dev_lock: Mutex protecting the genpd virtual device pointers.
> + * @genpd_virt_devs: List of virtual devices for multiple genpd support.
>   * @required_opp_tables: List of device OPP tables that are required by OPPs in
>   *             this table.
>   * @required_opp_count: Number of required devices.
> @@ -177,6 +179,8 @@ struct opp_table {
>         enum opp_table_access shared_opp;
>         struct dev_pm_opp *suspend_opp;
>
> +       struct mutex genpd_virt_dev_lock;
> +       struct device **genpd_virt_devs;
>         struct opp_table **required_opp_tables;
>         unsigned int required_opp_count;
>
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 5d399eeef172..8fed222c089b 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -126,6 +126,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>  void dev_pm_opp_put_clkname(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
> +struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
> +void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
>  int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
> @@ -272,6 +274,12 @@ static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const
>
>  static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
>
> +static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
> +
> +static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
>  static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  {
>         return -ENOTSUPP;
> --
> 2.19.1.568.g152ad8e3369a
>
