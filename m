Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17076C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A002146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550567431;
	bh=JJu4WC8iF96Rm4Uzmz4KF51N708wATnAtoJOCoT+7ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vVFd9OJPWSXZkMe8feaIpL4gQ5zohqlR0ifzzThKx8WcGQ/9G8qD/COnsmCJxwfQZ
	 9Q5uI3hnAWm++MGnG2NQyrxnW0GIAqDDVT8iLpruqA8J03XlrLj/NDSocmVfCDZ8Qo
	 6/rDf8PeO1RVHUPtzICC/Re0q606lKzcg3g+mf/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfBSJKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:10:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36526 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBSJKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:10:30 -0500
Received: by mail-ot1-f66.google.com with SMTP id v62so24150035otb.3;
        Tue, 19 Feb 2019 01:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h90ZAbZBceBrPYWroc4qbd6ah54VnGsQIfepeCqmeIo=;
        b=CP7Be9A7f5tM+sCzlyvhhALL7V+dW+pPdwQ6IBlv9AWB0duI0YLi16c1SWlQ4gUWGX
         k94O2SWqPG0AwdnRwQRaxSBB25W/yUglRWgbg35vMufojKwti1xWL39oRiECKszrJ+D8
         p7CR1jnTfqGlt+Jv5LqXezMwnDDmZsx3VA+pS/E0GdVudYgRPLe3D/YfK82m0ZraLPEP
         HaWbbrhi3dAugWXE51VFecSVfRb0o3ikIhq3Amq6KKWHJUqq5D7tANDK68nZFCrx3Itc
         fIP1+0Jp++fCJZDU40GH5qb9XvvMEhushoPhKmENVKlWdgIQcYbU2e0gJ+3mlimNPRlE
         tXgg==
X-Gm-Message-State: AHQUAuYroUMXWhYWCM/gfQiEJGOI3i6yFRU3OdZxntKEfs7w6W/sauTn
        EkJdh9nf21CMjB/qr+8SfsPK+iQAaGIS2oTTZ/MSCQ==
X-Google-Smtp-Source: AHgI3Ib7J+z+58ZzDMSOsklJAcg14D4L6Jx6BGXyVg7JtFQykl5wl1V2UgC1zC/AIIGaaoqva7uNz0cqAXLTTTj8sAE=
X-Received: by 2002:a9d:5509:: with SMTP id l9mr3206583oth.200.1550567428478;
 Tue, 19 Feb 2019 01:10:28 -0800 (PST)
MIME-Version: 1.0
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <5b1116912102ce6d0753fa1fedefc1a4e62837fe.1550545163.git.len.brown@intel.com>
In-Reply-To: <5b1116912102ce6d0753fa1fedefc1a4e62837fe.1550545163.git.len.brown@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Feb 2019 10:10:16 +0100
Message-ID: <CAJZ5v0gdqGnP8byHyZwJQnzk+c1BruqicTa0pYmkKWt3ECArNg@mail.gmail.com>
Subject: Re: [PATCH 09/11] powercap/intel_rapl: update rapl domain name and
 debug messages
To:     Len Brown <lenb@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 4:40 AM Len Brown <lenb@kernel.org> wrote:
>
> From: Zhang Rui <rui.zhang@intel.com>
>
> The RAPL domain "name" attribute contains "Package-N",
> which is ambiguous on multi-die per-package systems.
>
> Update the name to "package-X-die-Y" on those systems.
>
> No change on systems without multi-die.
>
> Driver debug messages are also updated.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/powercap/intel_rapl.c | 57 ++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index e004707283da..c990eee45239 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -178,12 +178,15 @@ struct rapl_domain {
>  #define power_zone_to_rapl_domain(_zone) \
>         container_of(_zone, struct rapl_domain, power_zone)
>
> +/* maximum rapl package domain name: package-%d-die-%d */
> +#define PACKAGE_DOMAIN_NAME_LENGTH 30
>
> -/* Each physical package contains multiple domains, these are the common
> +
> +/* Each rapl package contains multiple domains, these are the common
>   * data across RAPL domains within a package.
>   */
>  struct rapl_package {
> -       unsigned int id; /* physical package/socket id */
> +       unsigned int id; /* logical die id, equals physical 1-die systems */
>         unsigned int nr_domains;
>         unsigned long domain_map; /* bit map of active domains */
>         unsigned int power_unit;
> @@ -198,6 +201,7 @@ struct rapl_package {
>         int lead_cpu; /* one active cpu per package for access */
>         /* Track active cpus */
>         struct cpumask cpumask;
> +       char name[PACKAGE_DOMAIN_NAME_LENGTH];
>  };
>
>  struct rapl_defaults {
> @@ -926,8 +930,8 @@ static int rapl_check_unit_core(struct rapl_package *rp, int cpu)
>         value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
>         rp->time_unit = 1000000 / (1 << value);
>
> -       pr_debug("Core CPU package %d energy=%dpJ, time=%dus, power=%duW\n",
> -               rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
> +       pr_debug("Core CPU %s energy=%dpJ, time=%dus, power=%duW\n",
> +               rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
>
>         return 0;
>  }
> @@ -951,8 +955,8 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
>         value = (msr_val & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
>         rp->time_unit = 1000000 / (1 << value);
>
> -       pr_debug("Atom package %d energy=%dpJ, time=%dus, power=%duW\n",
> -               rp->id, rp->energy_unit, rp->time_unit, rp->power_unit);
> +       pr_debug("Atom %s energy=%dpJ, time=%dus, power=%duW\n",
> +               rp->name, rp->energy_unit, rp->time_unit, rp->power_unit);
>
>         return 0;
>  }
> @@ -1179,7 +1183,7 @@ static void rapl_update_domain_data(struct rapl_package *rp)
>         u64 val;
>
>         for (dmn = 0; dmn < rp->nr_domains; dmn++) {
> -               pr_debug("update package %d domain %s data\n", rp->id,
> +               pr_debug("update %s domain %s data\n", rp->name,
>                          rp->domains[dmn].name);
>                 /* exclude non-raw primitives */
>                 for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
> @@ -1204,7 +1208,6 @@ static void rapl_unregister_powercap(void)
>  static int rapl_package_register_powercap(struct rapl_package *rp)
>  {
>         struct rapl_domain *rd;
> -       char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
>         struct powercap_zone *power_zone = NULL;
>         int nr_pl, ret;
>
> @@ -1215,20 +1218,16 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>         for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
>                 if (rd->id == RAPL_DOMAIN_PACKAGE) {
>                         nr_pl = find_nr_power_limit(rd);
> -                       pr_debug("register socket %d package domain %s\n",
> -                               rp->id, rd->name);
> -                       memset(dev_name, 0, sizeof(dev_name));
> -                       snprintf(dev_name, sizeof(dev_name), "%s-%d",
> -                               rd->name, rp->id);
> +                       pr_debug("register package domain %s\n", rp->name);
>                         power_zone = powercap_register_zone(&rd->power_zone,
>                                                         control_type,
> -                                                       dev_name, NULL,
> +                                                       rp->name, NULL,
>                                                         &zone_ops[rd->id],
>                                                         nr_pl,
>                                                         &constraint_ops);
>                         if (IS_ERR(power_zone)) {
> -                               pr_debug("failed to register package, %d\n",
> -                                       rp->id);
> +                               pr_debug("failed to register power zone %s\n",
> +                                       rp->name);
>                                 return PTR_ERR(power_zone);
>                         }
>                         /* track parent zone in per package/socket data */
> @@ -1254,8 +1253,8 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>                                                 &constraint_ops);
>
>                 if (IS_ERR(power_zone)) {
> -                       pr_debug("failed to register power_zone, %d:%s:%s\n",
> -                               rp->id, rd->name, dev_name);
> +                       pr_debug("failed to register power_zone, %s:%s\n",
> +                               rp->name, rd->name);
>                         ret = PTR_ERR(power_zone);
>                         goto err_cleanup;
>                 }
> @@ -1268,7 +1267,7 @@ static int rapl_package_register_powercap(struct rapl_package *rp)
>          * failed after the first domain setup.
>          */
>         while (--rd >= rp->domains) {
> -               pr_debug("unregister package %d domain %s\n", rp->id, rd->name);
> +               pr_debug("unregister %s domain %s\n", rp->name, rd->name);
>                 powercap_unregister_zone(control_type, &rd->power_zone);
>         }
>
> @@ -1378,8 +1377,8 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
>         /* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
>         if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
>                 if (val64) {
> -                       pr_info("RAPL package %d domain %s locked by BIOS\n",
> -                               rd->rp->id, rd->name);
> +                       pr_info("RAPL %s domain %s locked by BIOS\n",
> +                               rd->rp->name, rd->name);
>                         rd->state |= DOMAIN_STATE_BIOS_LOCKED;
>                 }
>         }
> @@ -1408,10 +1407,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
>         }
>         rp->nr_domains = bitmap_weight(&rp->domain_map, RAPL_DOMAIN_MAX);
>         if (!rp->nr_domains) {
> -               pr_debug("no valid rapl domains found in package %d\n", rp->id);
> +               pr_debug("no valid rapl domains found in %s\n", rp->name);
>                 return -ENODEV;
>         }
> -       pr_debug("found %d domains on package %d\n", rp->nr_domains, rp->id);
> +       pr_debug("found %d domains on %s\n", rp->nr_domains, rp->name);
>
>         rp->domains = kcalloc(rp->nr_domains + 1, sizeof(struct rapl_domain),
>                         GFP_KERNEL);
> @@ -1444,8 +1443,8 @@ static void rapl_remove_package(struct rapl_package *rp)
>                         rd_package = rd;
>                         continue;
>                 }
> -               pr_debug("remove package, undo power limit on %d: %s\n",
> -                        rp->id, rd->name);
> +               pr_debug("remove package, undo power limit on %s: %s\n",
> +                        rp->name, rd->name);
>                 powercap_unregister_zone(control_type, &rd->power_zone);
>         }
>         /* do parent zone last */
> @@ -1459,6 +1458,7 @@ static struct rapl_package *rapl_add_package(int cpu)
>  {
>         int id = topology_unique_die_id(cpu);
>         struct rapl_package *rp;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
>         int ret;
>
>         rp = kzalloc(sizeof(struct rapl_package), GFP_KERNEL);
> @@ -1469,6 +1469,13 @@ static struct rapl_package *rapl_add_package(int cpu)
>         rp->id = id;
>         rp->lead_cpu = cpu;
>
> +       if (c->x86_max_dies > 1)
> +               snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH,
> +                       "package-%d-die-%d", c->phys_proc_id, c->cpu_die_id);
> +       else
> +               snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d",
> +                       c->phys_proc_id);
> +
>         /* check if the package contains valid domains */
>         if (rapl_detect_domains(rp, cpu) ||
>                 rapl_defaults->check_unit(rp, cpu)) {
> --
> 2.18.0-rc0
>
