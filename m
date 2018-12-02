Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1011C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAE02082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ixLr5xDD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CgJyV1dJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLBDrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:47:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLBDrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:47:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 23587607F7; Sun,  2 Dec 2018 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722465;
        bh=TZecmOBka9E1VdnXW481jjEDWUVhwduxlxtTqnafwZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ixLr5xDDXCTlqE2Rh78YfyH2YRHknnIejNmjktfjrOareaKWeoYpg6LKrzOh92s5A
         JmrMgIVOaxMhAuDrL7RkhGgmwjtGq7Q+k4yA38bhdb36hno8ZM5mdqjoU50c7YdaMm
         I7mjkS1sDe41ig0A3Zhu/x+e+cFrEpiwpIjf721M=
Received: from [192.168.225.247] (unknown [49.33.158.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88464601C4;
        Sun,  2 Dec 2018 03:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722463;
        bh=TZecmOBka9E1VdnXW481jjEDWUVhwduxlxtTqnafwZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CgJyV1dJnRF2O6RU2etwrI8juvmu3PFXetbFqFq88rCbuc/LNaEAZ2VO9uCWxjMh/
         T3DJM3Re+GkXASo3lxfEBft7590M7nkAUpxkLU8aQBrK3OXwkdhpOhFNkhwjwDxAM2
         BGbdrXioTKNny3Bp2WqyWdNiHKkkthzwy4f6dLgM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88464601C4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v10 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-3-git-send-email-tdas@codeaurora.org>
 <154282461163.88331.5242491967634867688@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <6d8d69e5-b338-8ea3-d433-9a0b60385b11@codeaurora.org>
Date:   Sun, 2 Dec 2018 09:17:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <154282461163.88331.5242491967634867688@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the patch, I have updated the latest series with the patch 
and few comments from Matthias.

On 11/21/2018 11:53 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-21 02:42:47)
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index d5ee456..789b2e0 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)   += omap-cpufreq.o
>>   obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)       += pxa2xx-cpufreq.o
>>   obj-$(CONFIG_PXA3xx)                   += pxa3xx-cpufreq.o
>>   obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)    += qcom-cpufreq-kryo.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)      += qcom-cpufreq-hw.o
> 
> This isn't alphabetically sorted.
> 
>>   obj-$(CONFIG_ARM_S3C2410_CPUFREQ)      += s3c2410-cpufreq.o
>>   obj-$(CONFIG_ARM_S3C2412_CPUFREQ)      += s3c2412-cpufreq.o
>>   obj-$(CONFIG_ARM_S3C2416_CPUFREQ)      += s3c2416-cpufreq.o
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..6390e85
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -0,0 +1,346 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/cpufreq.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +
>> +#define LUT_MAX_ENTRIES                        40U
>> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE                   32
>> +#define CLK_HW_DIV                     2
>> +
>> +/* Register offsets */
>> +#define REG_ENABLE                     0x0
>> +#define REG_LUT_TABLE                  0x110
>> +#define REG_PERF_STATE                 0x920
>> +
>> +struct cpufreq_qcom {
>> +       struct cpufreq_frequency_table *table;
>> +       void __iomem *perf_base;
>> +       cpumask_t related_cpus;
>> +       unsigned int max_cores;
>> +       unsigned long xo_rate;
>> +       unsigned long cpu_hw_rate;
>> +};
>> +
>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>> +
>> +static int
>> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>> +                            unsigned int index)
>> +{
>> +       struct cpufreq_qcom *c = policy->driver_data;
>> +
>> +       writel_relaxed(index, c->perf_base);
>> +
> 
> This isn't using the pointer directly though.
> 
>> +       return 0;
>> +}
>> +
>> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>> +{
>> +       struct cpufreq_qcom *c;
>> +       struct cpufreq_policy *policy;
>> +       unsigned int index;
>> +
>> +       policy = cpufreq_cpu_get_raw(cpu);
>> +       if (!policy)
>> +               return 0;
>> +
>> +       c = policy->driver_data;
>> +
>> +       index = readl_relaxed(c->perf_base);
>> +       index = min(index, LUT_MAX_ENTRIES - 1);
>> +
>> +       return policy->freq_table[index].frequency;
>> +}
>> +
>> +static unsigned int
>> +qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>> +                           unsigned int target_freq)
>> +{
>> +       struct cpufreq_qcom *c = policy->driver_data;
>> +       int index;
>> +
>> +       index = policy->cached_resolved_idx;
>> +       if (index < 0)
>> +               return 0;
>> +
>> +       writel_relaxed(index, c->perf_base);
>> +
>> +       return policy->freq_table[index].frequency;
>> +}
>> +
>> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>> +{
>> +       struct cpufreq_qcom *c;
>> +
>> +       c = qcom_freq_domain_map[policy->cpu];
>> +       if (!c) {
>> +               pr_err("No scaling support for CPU%d\n", policy->cpu);
>> +               return -ENODEV;
>> +       }
>> +
>> +       cpumask_copy(policy->cpus, &c->related_cpus);
>> +
>> +       policy->fast_switch_possible = true;
>> +       policy->freq_table = c->table;
>> +       policy->driver_data = c;
>> +
>> +       return 0;
>> +}
>> +
>> +static struct freq_attr *qcom_cpufreq_hw_attr[] = {
>> +       &cpufreq_freq_attr_scaling_available_freqs,
>> +       &cpufreq_freq_attr_scaling_boost_freqs,
>> +       NULL
>> +};
>> +
>> +static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>> +       .flags          = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
>> +                         CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
>> +       .verify         = cpufreq_generic_frequency_table_verify,
>> +       .target_index   = qcom_cpufreq_hw_target_index,
>> +       .get            = qcom_cpufreq_hw_get,
>> +       .init           = qcom_cpufreq_hw_cpu_init,
>> +       .fast_switch    = qcom_cpufreq_hw_fast_switch,
>> +       .name           = "qcom-cpufreq-hw",
>> +       .attr           = qcom_cpufreq_hw_attr,
>> +       .boost_enabled  = true,
>> +};
>> +
>> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
>> +                                   struct cpufreq_qcom *c, void __iomem *base)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
>> +
>> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +                               sizeof(*c->table), GFP_KERNEL);
>> +       if (!c->table)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +               data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
>> +               src = (data & GENMASK(31, 30)) >> 30;
>> +               lval = data & GENMASK(7, 0);
>> +               core_count = CORE_COUNT_VAL(data);
> 
> CORE_COUNT_VAL is used in one place. Just inline it like the src and
> lval ones? Or better yet, use FIELD_GET helpers.
> 
>> +
>> +               if (src)
>> +                       c->table[i].frequency = c->xo_rate * lval / 1000;
>> +               else
>> +                       c->table[i].frequency = c->cpu_hw_rate / 1000;
>> +
>> +               cur_freq = c->table[i].frequency;
> 
> Write this as:
> 
> 		if (src)
> 			cur_freq = c->xo_rate * lval / 1000;
> 		else
> 			cur_freq = c->cpu_hw_rate / 1000;
> 		
> 		c->table[i].frequency = cur_freq;
> 
> for shorter lines.
> 
>> +
>> +               dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
>> +                       i, c->table[i].frequency, core_count);
> 
> Use cur_freq instead of the long route?
> 
>> +
>> +               if (core_count != c->max_cores)
>> +                       cur_freq = CPUFREQ_ENTRY_INVALID;
> 
> Don't we want to knock out the intermediate frequencies that also don't
> have the max_cores core_count? If so, I would expect there to be
> CPUFREQ_ENTRY_INVALID in the frequency table, but this isn't doing that.
> 
>> +
>> +               /*
>> +                * Two of the same frequencies with the same core counts means
>> +                * end of table.
>> +                */
>> +               if (i > 0 && c->table[i - 1].frequency ==
>> +                  c->table[i].frequency && prev_cc == core_count) {
>> +                       struct cpufreq_frequency_table *prev = &c->table[i - 1];
>> +
>> +                       if (prev_freq == CPUFREQ_ENTRY_INVALID)
>> +                               prev->flags = CPUFREQ_BOOST_FREQ;
>> +                       break;
>> +               }
> 
> This is really hard to read.
> 
>> +               prev_cc = core_count;
>> +               prev_freq = cur_freq;
>> +       }
>> +
>> +       c->table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_get_related_cpus(int index, struct cpumask *m)
>> +{
>> +       struct device_node *cpu_np;
>> +       struct of_phandle_args args;
>> +       int cpu, ret;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               cpu_np = of_cpu_device_node_get(cpu);
>> +               if (!cpu_np)
>> +                       continue;
>> +
>> +               ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>> +                                                "#freq-domain-cells", 0,
>> +                                                 &args);
>> +               of_node_put(cpu_np);
>> +               if (ret < 0)
>> +                       continue;
>> +
>> +               if (index == args.args[0])
>> +                       cpumask_set_cpu(cpu, m);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +                                  unsigned int cpu, int index,
>> +                                  unsigned long xo_rate,
>> +                                  unsigned long cpu_hw_rate)
>> +{
>> +       struct cpufreq_qcom *c;
>> +       struct resource *res;
>> +       struct device *dev = &pdev->dev;
>> +       void __iomem *base;
>> +       int ret, cpu_r;
>> +
>> +       if (qcom_freq_domain_map[cpu])
>> +               return 0;
>> +
>> +       c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +       if (!c)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>> +       base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       /* HW should be in enabled state to proceed */
>> +       if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
>> +               dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = qcom_get_related_cpus(index, &c->related_cpus);
>> +       if (ret) {
>> +               dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
>> +               return ret;
>> +       }
>> +
>> +       c->max_cores = cpumask_weight(&c->related_cpus);
>> +       if (!c->max_cores)
>> +               return -ENOENT;
>> +
>> +       c->xo_rate = xo_rate;
>> +       c->cpu_hw_rate = cpu_hw_rate;
> 
> Why do we need to pass around these local variables in the structure?
> 
>> +       c->perf_base = base + REG_PERF_STATE;
>> +
>> +       ret = qcom_cpufreq_hw_read_lut(pdev, c, base);
>> +       if (ret) {
>> +               dev_err(dev, "Domain-%d failed to read LUT\n", index);
>> +               return ret;
>> +       }
>> +
>> +       for_each_cpu(cpu_r, &c->related_cpus)
>> +               qcom_freq_domain_map[cpu_r] = c;
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_resources_init(struct platform_device *pdev)
>> +{
>> +       struct device_node *cpu_np;
>> +       struct of_phandle_args args;
>> +       struct clk *clk;
>> +       unsigned int cpu;
>> +       unsigned long xo_rate, cpu_hw_rate;
>> +       int ret;
>> +
>> +       clk = clk_get(&pdev->dev, "xo");
>> +       if (IS_ERR(clk))
>> +               return PTR_ERR(clk);
>> +
>> +       xo_rate = clk_get_rate(clk);
>> +
>> +       clk_put(clk);
>> +
>> +       clk = clk_get(&pdev->dev, "gcc_cpuss_gpll0_clk_src");
> 
> I didn't see this in the binding. And it doesn't make sense still
> because now it's a global clk name. It can't be called "safe" or
> "backup" or something like that?
> 
>> +       if (IS_ERR(clk))
>> +               return PTR_ERR(clk);
>> +
>> +       cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
>> +
>> +       clk_put(clk);
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               cpu_np = of_cpu_device_node_get(cpu);
>> +               if (!cpu_np) {
>> +                       dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
>> +                               cpu);
>> +                       continue;
>> +               }
>> +
>> +               ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>> +                                                "#freq-domain-cells", 0,
>> +                                                 &args);
>> +               of_node_put(cpu_np);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
>> +                                             xo_rate, cpu_hw_rate);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>> +{
>> +       int rc;
>> +
>> +       /* Get the bases of cpufreq for domains */
>> +       rc = qcom_resources_init(pdev);
>> +       if (rc) {
>> +               dev_err(&pdev->dev, "CPUFreq resource init failed\n");
>> +               return rc;
>> +       }
> 
> Not sure why this is split out of the probe function.
> 
>> +
>> +       rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>> +       if (rc) {
>> +               dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
>> +               return rc;
>> +       }
>> +
>> +       dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
>> +       { .compatible = "qcom,cpufreq-hw" },
>> +       {}
>> +};
> 
> Missing MODULE_DEVICE_TABLE here.
> 
>> +
>> +static struct platform_driver qcom_cpufreq_hw_driver = {
>> +       .probe = qcom_cpufreq_hw_driver_probe,
>> +       .driver = {
>> +               .name = "qcom-cpufreq-hw",
>> +               .of_match_table = qcom_cpufreq_hw_match,
>> +       },
>> +};
>> +
>> +static int __init qcom_cpufreq_hw_init(void)
>> +{
>> +       return platform_driver_register(&qcom_cpufreq_hw_driver);
>> +}
>> +subsys_initcall(qcom_cpufreq_hw_init);
>> +
>> +static void __exit qcom_cpufreq_hw_exit(void)
>> +{
>> +       cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
> 
> Why isn't this done in driver remove?
> 
>> +       platform_driver_unregister(&qcom_cpufreq_hw_driver);
>> +}
>> +module_exit(qcom_cpufreq_hw_exit);
>> +
>> +MODULE_DESCRIPTION("QTI CPUFREQ HW Driver");
>> +MODULE_LICENSE("GPL v2");
> 
> Here's a patch I tested out to do all this. Simple testing shows it
> works. If you need my sign-off to fold it in here you go.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
>   drivers/cpufreq/Makefile          |   2 +-
>   drivers/cpufreq/qcom-cpufreq-hw.c | 147 ++++++++++++++++++--------------------
>   2 files changed, 69 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 789b2e06f3ba..08c071be2491 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -61,8 +61,8 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>   obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>   obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>   obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
> -obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
>   obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
>   obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>   obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>   obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 6390e85df1b3..105c9fe69a64 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/cpufreq.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
> @@ -11,7 +12,9 @@
>   #include <linux/of_platform.h>
>   
>   #define LUT_MAX_ENTRIES			40U
> -#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
> +#define LUT_SRC				GENMASK(31, 30)
> +#define LUT_L_VAL			GENMASK(7, 0)
> +#define LUT_CORE_COUNT			GENMASK(18, 16)
>   #define LUT_ROW_SIZE			32
>   #define CLK_HW_DIV			2
>   
> @@ -24,27 +27,23 @@ struct cpufreq_qcom {
>   	struct cpufreq_frequency_table *table;
>   	void __iomem *perf_base;
>   	cpumask_t related_cpus;
> -	unsigned int max_cores;
> -	unsigned long xo_rate;
> -	unsigned long cpu_hw_rate;
>   };
>   
>   static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>   
> -static int
> -qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> -			     unsigned int index)
> +static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +					unsigned int index)
>   {
> -	struct cpufreq_qcom *c = policy->driver_data;
> +	void __iomem *perf_base = policy->driver_data;
>   
> -	writel_relaxed(index, c->perf_base);
> +	writel_relaxed(index, perf_base);
>   
>   	return 0;
>   }
>   
>   static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>   {
> -	struct cpufreq_qcom *c;
> +	void __iomem *perf_base;
>   	struct cpufreq_policy *policy;
>   	unsigned int index;
>   
> @@ -52,26 +51,25 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>   	if (!policy)
>   		return 0;
>   
> -	c = policy->driver_data;
> +	perf_base = policy->driver_data;
>   
> -	index = readl_relaxed(c->perf_base);
> +	index = readl_relaxed(perf_base);
>   	index = min(index, LUT_MAX_ENTRIES - 1);
>   
>   	return policy->freq_table[index].frequency;
>   }
>   
> -static unsigned int
> -qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> -			    unsigned int target_freq)
> +static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +						unsigned int target_freq)
>   {
> -	struct cpufreq_qcom *c = policy->driver_data;
> +	void __iomem *perf_base = policy->driver_data;
>   	int index;
>   
>   	index = policy->cached_resolved_idx;
>   	if (index < 0)
>   		return 0;
>   
> -	writel_relaxed(index, c->perf_base);
> +	writel_relaxed(index, perf_base);
>   
>   	return policy->freq_table[index].frequency;
>   }
> @@ -90,7 +88,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   
>   	policy->fast_switch_possible = true;
>   	policy->freq_table = c->table;
> -	policy->driver_data = c;
> +	policy->driver_data = c->perf_base;
>   
>   	return 0;
>   }
> @@ -114,11 +112,12 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>   	.boost_enabled	= true,
>   };
>   
> -static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
> -				    struct cpufreq_qcom *c, void __iomem *base)
> +static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
> +				    void __iomem *base, unsigned long xo_rate,
> +				    unsigned long cpu_hw_rate)
>   {
> -	struct device *dev = &pdev->dev;
> -	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, freq;
> +	unsigned int max_cores = cpumask_weight(&c->related_cpus);
>   
>   	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>   				sizeof(*c->table), GFP_KERNEL);
> @@ -127,37 +126,45 @@ static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
>   
>   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>   		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> -		src = (data & GENMASK(31, 30)) >> 30;
> -		lval = data & GENMASK(7, 0);
> -		core_count = CORE_COUNT_VAL(data);
> +		src = FIELD_GET(LUT_SRC, data);
> +		lval = FIELD_GET(LUT_L_VAL, data);
> +		core_count = FIELD_GET(LUT_CORE_COUNT, data);
>   
>   		if (src)
> -			c->table[i].frequency = c->xo_rate * lval / 1000;
> +			freq = xo_rate * lval / 1000;
>   		else
> -			c->table[i].frequency = c->cpu_hw_rate / 1000;
> -
> -		cur_freq = c->table[i].frequency;
> -
> -		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
> -			i, c->table[i].frequency, core_count);
> -
> -		if (core_count != c->max_cores)
> -			cur_freq = CPUFREQ_ENTRY_INVALID;
> +			freq = cpu_hw_rate / 1000;
> +
> +		/* Ignore boosts in the middle of the table */
> +		if (core_count != max_cores) {
> +			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +		} else {
> +			c->table[i].frequency = freq;
> +			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +				freq, core_count);
> +		}
>   
>   		/*
>   		 * Two of the same frequencies with the same core counts means
> -		 * end of table.
> +		 * end of table
>   		 */
> -		if (i > 0 && c->table[i - 1].frequency ==
> -		   c->table[i].frequency && prev_cc == core_count) {
> +		if (i > 0 && prev_freq == freq && prev_cc == core_count) {
>   			struct cpufreq_frequency_table *prev = &c->table[i - 1];
>   
> -			if (prev_freq == CPUFREQ_ENTRY_INVALID)
> +			/*
> +			 * Only treat the last frequency that might be a boost
> +			 * as the boost frequency
> +			 */
> +			if (prev_cc != max_cores) {
> +				prev->frequency = prev_freq;
>   				prev->flags = CPUFREQ_BOOST_FREQ;
> +			}
> +
>   			break;
>   		}
> +
>   		prev_cc = core_count;
> -		prev_freq = cur_freq;
> +		prev_freq = freq;
>   	}
>   
>   	c->table[i].frequency = CPUFREQ_TABLE_END;
> @@ -165,7 +172,7 @@ static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
>   	return 0;
>   }
>   
> -static int qcom_get_related_cpus(int index, struct cpumask *m)
> +static void qcom_get_related_cpus(int index, struct cpumask *m)
>   {
>   	struct device_node *cpu_np;
>   	struct of_phandle_args args;
> @@ -186,8 +193,6 @@ static int qcom_get_related_cpus(int index, struct cpumask *m)
>   		if (index == args.args[0])
>   			cpumask_set_cpu(cpu, m);
>   	}
> -
> -	return 0;
>   }
>   
>   static int qcom_cpu_resources_init(struct platform_device *pdev,
> @@ -201,9 +206,6 @@ static int qcom_cpu_resources_init(struct platform_device *pdev,
>   	void __iomem *base;
>   	int ret, cpu_r;
>   
> -	if (qcom_freq_domain_map[cpu])
> -		return 0;
> -
>   	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>   	if (!c)
>   		return -ENOMEM;
> @@ -219,21 +221,15 @@ static int qcom_cpu_resources_init(struct platform_device *pdev,
>   		return -ENODEV;
>   	}
>   
> -	ret = qcom_get_related_cpus(index, &c->related_cpus);
> -	if (ret) {
> +	qcom_get_related_cpus(index, &c->related_cpus);
> +	if (!cpumask_weight(&c->related_cpus)) {
>   		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> -		return ret;
> -	}
> -
> -	c->max_cores = cpumask_weight(&c->related_cpus);
> -	if (!c->max_cores)
>   		return -ENOENT;
> +	}
>   
> -	c->xo_rate = xo_rate;
> -	c->cpu_hw_rate = cpu_hw_rate;
>   	c->perf_base = base + REG_PERF_STATE;
>   
> -	ret = qcom_cpufreq_hw_read_lut(pdev, c, base);
> +	ret = qcom_cpufreq_hw_read_lut(dev, c, base, xo_rate, cpu_hw_rate);
>   	if (ret) {
>   		dev_err(dev, "Domain-%d failed to read LUT\n", index);
>   		return ret;
> @@ -245,7 +241,7 @@ static int qcom_cpu_resources_init(struct platform_device *pdev,
>   	return 0;
>   }
>   
> -static int qcom_resources_init(struct platform_device *pdev)
> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   {
>   	struct device_node *cpu_np;
>   	struct of_phandle_args args;
> @@ -259,15 +255,13 @@ static int qcom_resources_init(struct platform_device *pdev)
>   		return PTR_ERR(clk);
>   
>   	xo_rate = clk_get_rate(clk);
> -
>   	clk_put(clk);
>   
> -	clk = clk_get(&pdev->dev, "gcc_cpuss_gpll0_clk_src");
> +	clk = clk_get(&pdev->dev, "alternate");
>   	if (IS_ERR(clk))
>   		return PTR_ERR(clk);
>   
>   	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
> -
>   	clk_put(clk);
>   
>   	for_each_possible_cpu(cpu) {
> @@ -282,33 +276,22 @@ static int qcom_resources_init(struct platform_device *pdev)
>   						 "#freq-domain-cells", 0,
>   						  &args);
>   		of_node_put(cpu_np);
> -		if (ret < 0)
> +		if (ret)
>   			return ret;
>   
> +		if (qcom_freq_domain_map[cpu])
> +			continue;
> +
>   		ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
>   					      xo_rate, cpu_hw_rate);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	return 0;
> -}
> -
> -static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> -{
> -	int rc;
> -
> -	/* Get the bases of cpufreq for domains */
> -	rc = qcom_resources_init(pdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> -		return rc;
> -	}
> -
> -	rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> -	if (rc) {
> +	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> +	if (ret) {
>   		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> -		return rc;
> +		return ret;
>   	}
>   
>   	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> @@ -316,13 +299,20 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
> +{
> +	return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
> +}
> +
>   static const struct of_device_id qcom_cpufreq_hw_match[] = {
>   	{ .compatible = "qcom,cpufreq-hw" },
>   	{}
>   };
> +MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
>   
>   static struct platform_driver qcom_cpufreq_hw_driver = {
>   	.probe = qcom_cpufreq_hw_driver_probe,
> +	.remove = qcom_cpufreq_hw_driver_remove,
>   	.driver = {
>   		.name = "qcom-cpufreq-hw",
>   		.of_match_table = qcom_cpufreq_hw_match,
> @@ -337,7 +327,6 @@ subsys_initcall(qcom_cpufreq_hw_init);
>   
>   static void __exit qcom_cpufreq_hw_exit(void)
>   {
> -	cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
>   	platform_driver_unregister(&qcom_cpufreq_hw_driver);
>   }
>   module_exit(qcom_cpufreq_hw_exit);
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
