Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68BECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F82220BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XP/R8V6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F82220BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbeGLXzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:55:54 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41321 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbeGLXzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:55:54 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so11345655ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=j1nfsCFf+3rsUeQKuNo8AHzK2oDdT1d25mnRxBZLt0M=;
        b=XP/R8V6fDKuxjqheXbpwg+zfR1qC/BtdE89B3DuTsuqS5OTWguWrq4OX/A26tzYc/y
         Y24h5dPQ4M9fzIrjSRyAF1ukmN7oulFLRnYYt9Q3cK984gxWopLXtjZSBuJl3f/SkINg
         geXF7ItHEHb1qY1ycgNwpU48me3i5v+MjRu58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=j1nfsCFf+3rsUeQKuNo8AHzK2oDdT1d25mnRxBZLt0M=;
        b=ehE109/2qx2TYHjrWjwukL/+f2/21mJfwk9OEEFXeMNITmdWU7IN3mmHQ4quV5W1Yg
         Ganp9ZPWttlQJwzyARQaAy/y+80RuFoXsbih8N99eKUrBjmDvaXKpSKxR51NAAXyffLP
         73lD51XKkHx/SAJSJ0hiOhXX9w204e4KLeIi8My4fEC6QMv9PSWkAIA6/pJwb4SFriPe
         CyJl6ytjVdOR7gzVlqTdnyEF2bJMmnubvtrxQj2dpz2Zw0Hyo8+cQlCi6GDoSodenTJW
         YOLAZf7Uvon8ipCC782/x7FH/bTVH67lip37E95Ih9LVj4W/VKXHwdWCYO2rOEBMh0M7
         p2oA==
X-Gm-Message-State: AOUpUlEvU7jLZ96xfZevl53Xl+bZrLKTk70A8T6dn/p7WltOljJhad/g
        9aHYEksBPtii5eOJh8Rc15au0w==
X-Google-Smtp-Source: AAOMgpcGWBTaUAGZEiV0eUstQr1Q+n70YHksSDKhfx62dBFkaFPSKGpixqdfc8/8eFl+C/4fit+2rw==
X-Received: by 2002:a17:902:7898:: with SMTP id q24-v6mr4011914pll.254.1531439041675;
        Thu, 12 Jul 2018 16:44:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id n9-v6sm32970173pfg.21.2018.07.12.16.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 16:44:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com, Taniya Das <tdas@codeaurora.org>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
Message-ID: <153143904032.48062.5226250425566383129@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Thu, 12 Jul 2018 16:44:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-12 11:05:45)
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> =

> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 52f5f1a..141ec3e 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -312,3 +312,13 @@ config ARM_PXA2xx_CPUFREQ
>           This add the CPUFreq driver support for Intel PXA2xx SOCs.
> =

>           If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_HW
> +       bool "QCOM CPUFreq HW driver"

Why can't it be a module?

> +       help
> +        Support for the CPUFreq HW driver.
> +        Some QCOM chipsets have a HW engine to offload the steps
> +        necessary for changing the frequency of the CPUs. Firmware loaded
> +        in this engine exposes a programming interafce to the High-level=
 OS.

typo on interface. Why is High capitalized? Just say OS?

> +        The driver implements the cpufreq driver interface for this HW e=
ngine.

So much 'driver'.

> +        Say Y if you want to support CPUFreq HW.
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpu=
freq-hw.c
> new file mode 100644
> index 0000000..fa25a95
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#define INIT_RATE                      300000000UL

This doesn't need to be configured from DT? Or more likely be specified
as some sort of PLL that is part of the clocks property so we know what
the 'safe' or 'default' frequency is?

> +#define XO_RATE                                19200000UL

This should come from DT via some clocks property.

> +#define LUT_MAX_ENTRIES                        40U
> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 1=
6)
> +#define LUT_ROW_SIZE                   32
> +
> +enum {
> +       REG_ENABLE,
> +       REG_LUT_TABLE,
> +       REG_PERF_STATE,
> +
> +       REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_qcom {
> +       struct cpufreq_frequency_table *table;
> +       struct device *dev;
> +       const u16 *reg_offset;
> +       void __iomem *base;
> +       cpumask_t related_cpus;
> +       unsigned int max_cores;
> +};
> +
> +static u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] =3D {

const?

> +       [REG_ENABLE]            =3D 0x0,
> +       [REG_LUT_TABLE]         =3D 0x110,
> +       [REG_PERF_STATE]        =3D 0x920,

Is the register map going to change again for the next device? It may be
better to precalculate the offset for the fast switch so that the
addition isn't in the hotpath.

> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> +
> +static int
> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +                            unsigned int index)
> +{
> +       struct cpufreq_qcom *c =3D policy->driver_data;
> +       unsigned int offset =3D c->reg_offset[REG_PERF_STATE];
> +
> +       writel_relaxed(index, c->base + offset);
> +
> +       return 0;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +{
> +       struct cpufreq_qcom *c;
> +       struct cpufreq_policy *policy;
> +       unsigned int index, offset;
> +
> +       policy =3D cpufreq_cpu_get_raw(cpu);
> +       if (!policy)
> +               return 0;
> +
> +       c =3D policy->driver_data;
> +       offset =3D c->reg_offset[REG_PERF_STATE];
> +
> +       index =3D readl_relaxed(c->base + offset);
> +       index =3D min(index, LUT_MAX_ENTRIES - 1);
> +
> +       return policy->freq_table[index].frequency;
> +}
> +
> +static unsigned int
> +qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +                           unsigned int target_freq)
> +{
> +       struct cpufreq_qcom *c =3D policy->driver_data;
> +       unsigned int offset;
> +       int index;
> +
> +       index =3D cpufreq_table_find_index_l(policy, target_freq);

It's unfortunate that we have to search the table in software again.
Why can't we use policy->cached_resolved_idx to avoid this search twice?

> +       if (index < 0)
> +               return 0;
> +
> +       offset =3D c->reg_offset[REG_PERF_STATE];
> +
> +       writel_relaxed(index, c->base + offset);
> +
> +       return policy->freq_table[index].frequency;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_qcom *c;
> +
> +       c =3D qcom_freq_domain_map[policy->cpu];
> +       if (!c) {
> +               pr_err("No scaling support for CPU%d\n", policy->cpu);
> +               return -ENODEV;
> +       }
> +
> +       cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +       policy->fast_switch_possible =3D true;
> +       policy->freq_table =3D c->table;
> +       policy->driver_data =3D c;
> +
> +       return 0;
> +}
> +
> +static struct freq_attr *qcom_cpufreq_hw_attr[] =3D {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       &cpufreq_freq_attr_scaling_boost_freqs,
> +       NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_qcom_hw_driver =3D {
> +       .flags          =3D CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CH=
ECK |
> +                         CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +       .verify         =3D cpufreq_generic_frequency_table_verify,
> +       .target_index   =3D qcom_cpufreq_hw_target_index,
> +       .get            =3D qcom_cpufreq_hw_get,
> +       .init           =3D qcom_cpufreq_hw_cpu_init,
> +       .fast_switch    =3D qcom_cpufreq_hw_fast_switch,
> +       .name           =3D "qcom-cpufreq-hw",
> +       .attr           =3D qcom_cpufreq_hw_attr,
> +       .boost_enabled  =3D true,
> +};
> +
> +static int qcom_read_lut(struct platform_device *pdev,
> +                        struct cpufreq_qcom *c)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       unsigned int offset;
> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +       c->table =3D devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +                               sizeof(*c->table), GFP_KERNEL);
> +       if (!c->table)
> +               return -ENOMEM;
> +
> +       offset =3D c->reg_offset[REG_LUT_TABLE];
> +
> +       for (i =3D 0; i < LUT_MAX_ENTRIES; i++) {
> +               data =3D readl_relaxed(c->base + offset + i * LUT_ROW_SIZ=
E);
> +               src =3D ((data & GENMASK(31, 30)) >> 30);

One too many parenthesis.

> +               lval =3D (data & GENMASK(7, 0));

One too many parenthesis.

> +               core_count =3D CORE_COUNT_VAL(data);
> +
> +               if (src =3D=3D 0)
> +                       c->table[i].frequency =3D INIT_RATE / 1000;
> +               else
> +                       c->table[i].frequency =3D XO_RATE * lval / 1000;
> +
> +               cur_freq =3D c->table[i].frequency;
> +
> +               dev_dbg(dev, "index=3D%d freq=3D%d, core_count %d\n",
> +                       i, c->table[i].frequency, core_count);
> +
> +               if (core_count !=3D c->max_cores)
> +                       cur_freq =3D CPUFREQ_ENTRY_INVALID;
> +
> +               /*
> +                * Two of the same frequencies with the same core counts =
means
> +                * end of table.
> +                */
> +               if (i > 0 && c->table[i - 1].frequency =3D=3D
> +                  c->table[i].frequency && prev_cc =3D=3D core_count) {
> +                       struct cpufreq_frequency_table *prev =3D &c->tabl=
e[i - 1];
> +
> +                       if (prev_freq =3D=3D CPUFREQ_ENTRY_INVALID)
> +                               prev->flags =3D CPUFREQ_BOOST_FREQ;
> +                       break;
> +               }
> +               prev_cc =3D core_count;
> +               prev_freq =3D cur_freq;
> +       }
> +
> +       c->table[i].frequency =3D CPUFREQ_TABLE_END;
> +
> +       return 0;
> +}
> +
> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask =
*m)
> +{
> +       struct device_node *cpu_np, *freq_np;
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_np =3D of_cpu_device_node_get(cpu);
> +               if (!cpu_np)
> +                       continue;
> +               freq_np =3D of_parse_phandle(cpu_np, "qcom,freq-domain", =
0);

Put the of_node_put(cpu_np) here? And then remove it from the other two
places below?

> +               if (!freq_np) {
> +                       of_node_put(cpu_np);
> +                       continue;
> +               }
> +               if (freq_np =3D=3D np)
> +                       cpumask_set_cpu(cpu, m);
> +
> +               of_node_put(cpu_np);
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_cpu_resources_init(struct platform_device *pdev,
> +                                  struct device_node *np, unsigned int c=
pu)
> +{
> +       struct cpufreq_qcom *c;
> +       struct resource res;
> +       struct device *dev =3D &pdev->dev;
> +       unsigned int offset, cpu_r;
> +       int ret;
> +
> +       c =3D devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +       if (!c)
> +               return -ENOMEM;
> +
> +       c->reg_offset =3D of_device_get_match_data(&pdev->dev);
> +       if (!c->reg_offset)
> +               return -EINVAL;
> +
> +       if (of_address_to_resource(np, 0, &res))

This is unfortunate that it can't use platform APIs.

> +               return -ENOMEM;
> +
> +       c->base =3D devm_ioremap(dev, res.start, resource_size(&res));

No devm_ioremap_resource? And we don't put the reg properties in the
top-level node?

> +       if (!c->base) {
> +               dev_err(dev, "Unable to map %s base\n", np->name);

We don't need error messages like this for mapping failures when it will
spew a kmalloc error.

> +               return -ENOMEM;
> +       }
> +
> +       offset =3D c->reg_offset[REG_ENABLE];
> +
> +       /* HW should be in enabled state to proceed */
> +       if (!(readl_relaxed(c->base + offset) & 0x1)) {
> +               dev_err(dev, "%s cpufreq hardware not enabled\n", np->nam=
e);
> +               return -ENODEV;
> +       }
> +
> +       ret =3D qcom_get_related_cpus(np, &c->related_cpus);
> +       if (ret) {
> +               dev_err(dev, "%s failed to get related CPUs\n", np->name);
> +               return ret;
> +       }
> +
> +       c->max_cores =3D cpumask_weight(&c->related_cpus);
> +       if (!c->max_cores)
> +               return -ENOENT;
> +
> +       ret =3D qcom_read_lut(pdev, c);

qcom_cpufreq_hw_read_lut?

> +       if (ret) {
> +               dev_err(dev, "%s failed to read LUT\n", np->name);
> +               return ret;
> +       }
> +
> +       qcom_freq_domain_map[cpu] =3D c;
> +
> +       /* Related CPUs to keep a single copy */

What does this comment mean?

> +       cpu_r =3D cpumask_first(&c->related_cpus);
> +       if (cpu !=3D cpu_r) {
> +               qcom_freq_domain_map[cpu] =3D qcom_freq_domain_map[cpu_r];
> +               devm_kfree(dev, c);
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_resources_init(struct platform_device *pdev)
> +{
> +       struct device_node *np, *cpu_np;
> +       unsigned int cpu;
> +       int ret;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_np =3D of_cpu_device_node_get(cpu);
> +               if (!cpu_np) {
> +                       dev_err(&pdev->dev, "Failed to get cpu %d device\=
n",
> +                               cpu);
> +                       continue;

An error, but we continue? Why not dev_dbg level?

> +               }
> +
> +               np =3D of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> +               if (!np) {
> +                       dev_err(&pdev->dev, "Failed to get freq-domain de=
vice\n");
> +                       return -EINVAL;
> +               }
> +
> +               of_node_put(cpu_np);
> +
> +               ret =3D qcom_cpu_resources_init(pdev, np, cpu);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +       int rc;
> +
> +       /* Get the bases of cpufreq for domains */
> +       rc =3D qcom_resources_init(pdev);
> +       if (rc) {
> +               dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> +               return rc;
> +       }
> +
> +       rc =3D cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> +       if (rc) {
> +               dev_err(&pdev->dev, "CPUFreq HW driver failed to register=
\n");
> +               return rc;
> +       }
> +
> +       dev_info(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");

Move to dev_dbg? We have other ways to know if a driver probes
successfully so the whole line isn't really needed.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id match_table[] =3D {

Please call it something besides 'match_table'. qcom_cpufreq_hw_match?

> +       { .compatible =3D "qcom,cpufreq-hw", .data =3D &cpufreq_qcom_std_=
offsets },
> +       {}
> +};
> +
> +static struct platform_driver qcom_cpufreq_hw_driver =3D {
> +       .probe =3D qcom_cpufreq_hw_driver_probe,
> +       .driver =3D {
> +               .name =3D "qcom-cpufreq-hw",
> +               .of_match_table =3D match_table,
> +               .owner =3D THIS_MODULE,

platform_driver_register() already assigns this. This should be dropped
from here.

> +       },
> +};
> +
> +static int __init qcom_cpufreq_hw_init(void)
> +{
> +       return platform_driver_register(&qcom_cpufreq_hw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_hw_init);
> +
> +MODULE_DESCRIPTION("QCOM firmware-based CPU Frequency driver");
> +MODULE_LICENSE("GPL v2");

It should be tristate then in the Kconfig.
