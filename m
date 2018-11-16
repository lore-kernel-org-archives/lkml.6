Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B386C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76942087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2suuCWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76942087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeKPWgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeKPWgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:36:39 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD792146D;
        Fri, 16 Nov 2018 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542371068;
        bh=uN35ZmfuXaUuSIrBjEs9+MMyAITz3GjT5IYAyy8aSIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r2suuCWwCPF2d6+EUfZpBsAKKFNqlN2nCMcyPnrNnxdb8dg63r7FzD0iBLDYytGjQ
         KvQFcYssUgXlFh7kW653FymPn5vI3ni6GH3KQ4aAubGiEIoAdMqvnR4a2jFMJCFtu+
         2bP7sApLYI3M7uGYkWEnsfKQJPQOpL9DMpcHRAIQ=
Received: by mail-lj1-f182.google.com with SMTP id e5-v6so20160072lja.4;
        Fri, 16 Nov 2018 04:24:28 -0800 (PST)
X-Gm-Message-State: AGRZ1gK6WoWhn/o2czqh7FRhNZDXFQPNr1ZPTYLD+7TYFN8KfgFH+8L5
        4LpQr4+wDvPY5XHocRlDy+jzJkLoM3zL1sZWh1Y=
X-Google-Smtp-Source: AJdET5ftAsyr1d7WTCAgh5G5Q9ll2K2Ze9YwqqfMMBM3136QkgmUak96Vhj3zaYA1jzbodYRSGOl4geMWOqA0UKOGA0=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr6600037lji.60.1542371066582;
 Fri, 16 Nov 2018 04:24:26 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181115151230epcas1p35afa7ac09774a6e6256523b3a77453c3@epcas1p3.samsung.com>
 <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com> <1542294698-17470-6-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1542294698-17470-6-git-send-email-b.zolnierkie@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Nov 2018 13:24:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe_neF+nsvMC7owWufGKAbdCo9AicxE3BkNaj5ZtPUKDA@mail.gmail.com>
Message-ID: <CAJKOXPe_neF+nsvMC7owWufGKAbdCo9AicxE3BkNaj5ZtPUKDA@mail.gmail.com>
Subject: Re: [PATCH 5/9] ARM: EXYNOS: use chipid driver
To:     =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Cc:     arnd@arndb.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        kgene@kernel.org, m.reichl@fivetechno.de,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, javierm@redhat.com,
        pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 at 16:12, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Add soc_dev_is_exynos*() helpers and use them instead of
> soc_is_exynos*() ones.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h   |  6 ++++++
>  arch/arm/mach-exynos/exynos.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/firmware.c |  8 ++++----
>  arch/arm/mach-exynos/platsmp.c  | 12 ++++++------
>  arch/arm/mach-exynos/pm.c       | 17 +++++++++--------
>  5 files changed, 64 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index 1b8699e..20d205e 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -9,8 +9,14 @@
>  #ifndef __ARCH_ARM_MACH_EXYNOS_COMMON_H
>  #define __ARCH_ARM_MACH_EXYNOS_COMMON_H
>
> +#include <linux/sys_soc.h>
>  #include <linux/platform_data/cpuidle-exynos.h>
>
> +extern bool soc_dev_is_exynos3250(void);
> +extern bool soc_dev_is_exynos4210_rev11(void);
> +extern bool soc_dev_is_exynos4412(void);
> +extern bool soc_dev_is_exynos542x(void);
> +
>  #define EXYNOS3250_SOC_ID      0xE3472000
>  #define EXYNOS3_SOC_MASK       0xFFFFF000
>
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 865dcc4..463e457 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -24,6 +24,45 @@
>
>  #include "common.h"
>
> +static const struct soc_device_attribute exynos3250_soc_id[] = {
> +       { .soc_id = "EXYNOS3250" },
> +       { /* sentinel */ }
> +};
> +
> +static const struct soc_device_attribute exynos4210_rev11_soc_id[] = {
> +       { .soc_id = "EXYNOS4210", .revision = "11" },
> +       { /* sentinel */ }
> +};
> +
> +static const struct soc_device_attribute exynos4412_soc_id[] = {
> +       { .soc_id = "EXYNOS4412" },
> +       { /* sentinel */ }
> +};
> +
> +static const struct soc_device_attribute exynos542x_soc_id[] = {
> +       { .soc_id = "EXYNOS5420" },
> +       { .soc_id = "EXYNOS5800" },
> +       { /* sentinel */ }
> +};
> +
> +#define SOC_DEV_IS_EXYNOS(ver)                                         \
> +bool soc_dev_is_exynos##ver(void)                                      \
> +{                                                                      \
> +       static bool init_done, is_exynos##ver;                          \
> +                                                                       \
> +       if (!init_done) {                                               \
> +               is_exynos##ver = !!soc_device_match(exynos##ver##_soc_id); \
> +               init_done = true;                                       \
> +       }                                                               \
> +                                                                       \
> +       return is_exynos##ver;                                          \
> +}
> +
> +SOC_DEV_IS_EXYNOS(3250);
> +SOC_DEV_IS_EXYNOS(4210_rev11);
> +SOC_DEV_IS_EXYNOS(4412);
> +SOC_DEV_IS_EXYNOS(542x);

Nicely compacted definition but:
1. You blow real code (4 functions doing exactly the same),
2. You break jumping to definitions in IDE (searching/indexing symbols).

Currently this can be executed on only one, specific Exynos chip. This
means that you can have only one static variable holding current soc
revision and compare against it. This might require adding some enums
and code would look like:
enum soc_exynos {
SOC_EXYNOS_3250,
SOC_EXYNOS_542X,
...
};

bool soc_dev_is_exynos(soc) {
  static bool init_done;
  enum soc_exynos exynos_type;

  if (!init_done) {
    match = soc_device_match(exynos_soc_id);
    exynos_type = match.data;
  }
  return soc == exynos_type;
}

and the callers would be:
if (soc_dev_is_exynos(EXYNOS_542x))

Other point is comment in soc_device_match():
"This function is meant as a helper in place of of_match_node() in
cases where either no device tree is available or the information in a
device node is insufficient..."
and
"For new devices, the DT binding .. that allow the use of
of_match_node() instead."

so of_match_node() is preferred instead.

> +
>  static struct platform_device exynos_cpuidle = {
>         .name              = "exynos_cpuidle",
>  #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> index d602e3b..d526d5e 100644
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -40,7 +40,7 @@ static int exynos_do_idle(unsigned long mode)
>                 writel_relaxed(__pa_symbol(exynos_cpu_resume_ns),
>                                sysram_ns_base_addr + 0x24);
>                 writel_relaxed(EXYNOS_AFTR_MAGIC, sysram_ns_base_addr + 0x20);
> -               if (soc_is_exynos3250()) {
> +               if (soc_dev_is_exynos3250()) {
>                         flush_cache_all();
>                         exynos_smc(SMC_CMD_SAVE, OP_TYPE_CORE,
>                                    SMC_POWERSTATE_IDLE, 0);
> @@ -61,7 +61,7 @@ static int exynos_cpu_boot(int cpu)
>          * Exynos3250 doesn't need to send smc command for secondary CPU boot
>          * because Exynos3250 removes WFE in secure mode.
>          */
> -       if (soc_is_exynos3250())
> +       if (soc_dev_is_exynos3250())
>                 return 0;
>
>         /*
> @@ -85,7 +85,7 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>          * additional offset for every CPU, with Exynos4412 being the only
>          * exception.
>          */
> -       if (soc_is_exynos4412())
> +       if (soc_dev_is_exynos4412())
>                 boot_reg += 4 * cpu;
>
>         writel_relaxed(boot_addr, boot_reg);
> @@ -101,7 +101,7 @@ static int exynos_get_cpu_boot_addr(int cpu, unsigned long *boot_addr)
>
>         boot_reg = sysram_ns_base_addr + 0x1c;
>
> -       if (soc_is_exynos4412())
> +       if (soc_dev_is_exynos4412())
>                 boot_reg += 4 * cpu;
>
>         *boot_addr = readl_relaxed(boot_reg);
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index c39ffd2..e2ba70f 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -88,7 +88,7 @@ void exynos_cpu_power_down(int cpu)
>  {
>         u32 core_conf;
>
> -       if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
> +       if (cpu == 0 && soc_dev_is_exynos542x()) {

With new implementation you might hit again LDREX and STREX here (see
commit ca489c58ef0b ("ARM: EXYNOS: Don't use LDREX and STREX after
disabling cache coherency")) because:
soc_device_match -> bus_for_each_dev -> klist_iter_init_node ->
kref_get_unless_zero -> refcount_inc_not_zero_checked
According to previous comments and
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dht0008a/CJABEHDA.html
this is not allowed with cache coherency disabled.

I think calling here soc_device_match() is unlikely because it should
be initialized before. However please check if this is really the case
and comment it in the code in both places:
1. the first place which effectively initializes
soc_dev_is_exynos542x():init_done (to be sure that no one removes this
first call)
2. here that it depends on previous call of soc_dev_is_exynos542x().

It is getting slightly error prone - usage of one function is safe
here only if it was called somewhere else before... so I am not sure
if it is worth to remove soc_is_exynos() here.

Please also check other places without cache coherency where
soc_is_exynos() is being replaced to new method.

Best regards,
Krzysztof
