Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B842075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pw95/CGe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZIvYrbiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B842075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeGRGL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:11:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeGRGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:11:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 365F5607EB; Wed, 18 Jul 2018 05:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531892153;
        bh=qhtZytPLZ9JFSiUf+ZIgF7dp+sHWjwCouoIKu8KuRds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pw95/CGepTyHkLPLMiIhNjgs3QiEE9PqNATctksAoj8FEki9ahVjuQLuVfVrmxbwI
         0TbYlxRdjK0/BX5SkcnZYzoCFp9yZTkV0gxU2uelgfYemFWZW2JHTknKtRJuWza5U1
         XJo5rdYZmn7dCOTedLX+a/U2UuLwPzQP6XKQGPRg=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F4ED6063A;
        Wed, 18 Jul 2018 05:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531892151;
        bh=qhtZytPLZ9JFSiUf+ZIgF7dp+sHWjwCouoIKu8KuRds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZIvYrbiuDwhpDfV9lL+4C1R/yifEtoOX3edoa6q4dtY1vZoSGyZSocuV4pSpr9fum
         bfVx2DPrrtBb9aXQw9nUKt/IZLPfZ4LNTyTkMxHPBJvpatHwDn/7j9KQ5EAgJC4CVJ
         J9K5f44lYUJieJS5iueWs+VSaLn0xP7V8Lbs2r44=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F4ED6063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
 <153143904032.48062.5226250425566383129@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <98f5ec2c-c3f1-2f4f-c551-7a37722471b0@codeaurora.org>
Date:   Wed, 18 Jul 2018 11:05:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153143904032.48062.5226250425566383129@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the review comments.

On 7/13/2018 5:14 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-12 11:05:45)
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 52f5f1a..141ec3e 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -312,3 +312,13 @@ config ARM_PXA2xx_CPUFREQ
>>            This add the CPUFreq driver support for Intel PXA2xx SOCs.
>>
>>            If in doubt, say N.
>> +
>> +config ARM_QCOM_CPUFREQ_HW
>> +       bool "QCOM CPUFreq HW driver"
> 
> Why can't it be a module?
> 

I am of the opinion to keep it in-built.

>> +       help
>> +        Support for the CPUFreq HW driver.
>> +        Some QCOM chipsets have a HW engine to offload the steps
>> +        necessary for changing the frequency of the CPUs. Firmware loaded
>> +        in this engine exposes a programming interafce to the High-level OS.
> 
> typo on interface. Why is High capitalized? Just say OS?
> Taken care in the next patch.

>> +        The driver implements the cpufreq driver interface for this HW engine.
> 
> So much 'driver'.
> 
Taken care in the next patch.

>> +        Say Y if you want to support CPUFreq HW.
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..fa25a95
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -0,0 +1,344 @@
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
>> +#define INIT_RATE                      300000000UL
> 
> This doesn't need to be configured from DT? Or more likely be specified
> as some sort of PLL that is part of the clocks property so we know what
> the 'safe' or 'default' frequency is?
> 
The source is RCG which is pre-configured by HW and is not modeled in SW 
code. That is the reason to keep it as a macro.

>> +#define XO_RATE                                19200000UL
> 
> This should come from DT via some clocks property.
> 
This would be taken as an input from DT clocks.

>> +#define LUT_MAX_ENTRIES                        40U
>> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE                   32
>> +
>> +enum {
>> +       REG_ENABLE,
>> +       REG_LUT_TABLE,
>> +       REG_PERF_STATE,
>> +
>> +       REG_ARRAY_SIZE,
>> +};
>> +
>> +struct cpufreq_qcom {
>> +       struct cpufreq_frequency_table *table;
>> +       struct device *dev;
>> +       const u16 *reg_offset;
>> +       void __iomem *base;
>> +       cpumask_t related_cpus;
>> +       unsigned int max_cores;
>> +};
>> +
>> +static u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
> 
> const?
> 
Updated to use const.
>> +       [REG_ENABLE]            = 0x0,
>> +       [REG_LUT_TABLE]         = 0x110,
>> +       [REG_PERF_STATE]        = 0x920,
> 
> Is the register map going to change again for the next device? It may be
> better to precalculate the offset for the fast switch so that the
> addition isn't in the hotpath.
> 

Taken care in the next patch set.

>> +};
>> +
>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>> +
>> +static int
>> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>> +                            unsigned int index)
>> +{
>> +       struct cpufreq_qcom *c = policy->driver_data;
>> +       unsigned int offset = c->reg_offset[REG_PERF_STATE];
>> +
>> +       writel_relaxed(index, c->base + offset);
>> +
>> +       return 0;
>> +}
>> +
>> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>> +{
>> +       struct cpufreq_qcom *c;
>> +       struct cpufreq_policy *policy;
>> +       unsigned int index, offset;
>> +
>> +       policy = cpufreq_cpu_get_raw(cpu);
>> +       if (!policy)
>> +               return 0;
>> +
>> +       c = policy->driver_data;
>> +       offset = c->reg_offset[REG_PERF_STATE];
>> +
>> +       index = readl_relaxed(c->base + offset);
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
>> +       unsigned int offset;
>> +       int index;
>> +
>> +       index = cpufreq_table_find_index_l(policy, target_freq);
> 
> It's unfortunate that we have to search the table in software again.
> Why can't we use policy->cached_resolved_idx to avoid this search twice?
> 

Yeah, I just checked the call flow
get_next_freq(already determines the idx and keeps a cached copy of the 
index) and then invokes the 'sugov_update_commit' for fast switch.

My understanding is we could use policy->cached_resolved_idx instead of 
searching again.

>> +       if (index < 0)
>> +               return 0;
>> +
>> +       offset = c->reg_offset[REG_PERF_STATE];
>> +
>> +       writel_relaxed(index, c->base + offset);
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
>> +static int qcom_read_lut(struct platform_device *pdev,
>> +                        struct cpufreq_qcom *c)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       unsigned int offset;
>> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
>> +
>> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +                               sizeof(*c->table), GFP_KERNEL);
>> +       if (!c->table)
>> +               return -ENOMEM;
>> +
>> +       offset = c->reg_offset[REG_LUT_TABLE];
>> +
>> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +               data = readl_relaxed(c->base + offset + i * LUT_ROW_SIZE);
>> +               src = ((data & GENMASK(31, 30)) >> 30);
> 
> One too many parenthesis.
> 

Removed.

>> +               lval = (data & GENMASK(7, 0));
> 
> One too many parenthesis.
> 

Removed.

>> +               core_count = CORE_COUNT_VAL(data);
>> +
>> +               if (src == 0)
>> +                       c->table[i].frequency = INIT_RATE / 1000;
>> +               else
>> +                       c->table[i].frequency = XO_RATE * lval / 1000;
>> +
>> +               cur_freq = c->table[i].frequency;
>> +
>> +               dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
>> +                       i, c->table[i].frequency, core_count);
>> +
>> +               if (core_count != c->max_cores)
>> +                       cur_freq = CPUFREQ_ENTRY_INVALID;
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
>> +               prev_cc = core_count;
>> +               prev_freq = cur_freq;
>> +       }
>> +
>> +       c->table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
>> +{
>> +       struct device_node *cpu_np, *freq_np;
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               cpu_np = of_cpu_device_node_get(cpu);
>> +               if (!cpu_np)
>> +                       continue;
>> +               freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
> 
> Put the of_node_put(cpu_np) here? And then remove it from the other two
> places below?
>

Fixed it in the next patch.

>> +               if (!freq_np) {
>> +                       of_node_put(cpu_np);
>> +                       continue;
>> +               }
>> +               if (freq_np == np)
>> +                       cpumask_set_cpu(cpu, m);
>> +
>> +               of_node_put(cpu_np);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +                                  struct device_node *np, unsigned int cpu)
>> +{
>> +       struct cpufreq_qcom *c;
>> +       struct resource res;
>> +       struct device *dev = &pdev->dev;
>> +       unsigned int offset, cpu_r;
>> +       int ret;
>> +
>> +       c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +       if (!c)
>> +               return -ENOMEM;
>> +
>> +       c->reg_offset = of_device_get_match_data(&pdev->dev);
>> +       if (!c->reg_offset)
>> +               return -EINVAL;
>> +
>> +       if (of_address_to_resource(np, 0, &res))
> 
> This is unfortunate that it can't use platform APIs.
> 
>> +               return -ENOMEM;
>> +
>> +       c->base = devm_ioremap(dev, res.start, resource_size(&res));
> 
> No devm_ioremap_resource? And we don't put the reg properties in the
> top-level node?
> 

Moved to use devm_ioremap_resource. There is no reg property in the top 
level node.

>> +       if (!c->base) {
>> +               dev_err(dev, "Unable to map %s base\n", np->name);
> 
> We don't need error messages like this for mapping failures when it will
> spew a kmalloc error.
> 

removed the error message.

>> +               return -ENOMEM;
>> +       }
>> +
>> +       offset = c->reg_offset[REG_ENABLE];
>> +
>> +       /* HW should be in enabled state to proceed */
>> +       if (!(readl_relaxed(c->base + offset) & 0x1)) {
>> +               dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = qcom_get_related_cpus(np, &c->related_cpus);
>> +       if (ret) {
>> +               dev_err(dev, "%s failed to get related CPUs\n", np->name);
>> +               return ret;
>> +       }
>> +
>> +       c->max_cores = cpumask_weight(&c->related_cpus);
>> +       if (!c->max_cores)
>> +               return -ENOENT;
>> +
>> +       ret = qcom_read_lut(pdev, c);
> 
> qcom_cpufreq_hw_read_lut?
> 

Renamed the function to 'qcom_cpufreq_hw_read_lut'.

>> +       if (ret) {
>> +               dev_err(dev, "%s failed to read LUT\n", np->name);
>> +               return ret;
>> +       }
>> +
>> +       qcom_freq_domain_map[cpu] = c;
>> +
>> +       /* Related CPUs to keep a single copy */
> 
> What does this comment mean?
> 

All related CPUs to use first cpu of the cluster structure.

>> +       cpu_r = cpumask_first(&c->related_cpus);
>> +       if (cpu != cpu_r) {
>> +               qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
>> +               devm_kfree(dev, c);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_resources_init(struct platform_device *pdev)
>> +{
>> +       struct device_node *np, *cpu_np;
>> +       unsigned int cpu;
>> +       int ret;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               cpu_np = of_cpu_device_node_get(cpu);
>> +               if (!cpu_np) {
>> +                       dev_err(&pdev->dev, "Failed to get cpu %d device\n",
>> +                               cpu);
>> +                       continue;
> 
> An error, but we continue? Why not dev_dbg level?
> 

Moved to dev_dbg.

>> +               }
>> +
>> +               np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
>> +               if (!np) {
>> +                       dev_err(&pdev->dev, "Failed to get freq-domain device\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               of_node_put(cpu_np);
>> +
>> +               ret = qcom_cpu_resources_init(pdev, np, cpu);
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
>> +
>> +       rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>> +       if (rc) {
>> +               dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
>> +               return rc;
>> +       }
>> +
>> +       dev_info(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> 
> Move to dev_dbg? We have other ways to know if a driver probes
> successfully so the whole line isn't really needed.
> 

Moved it to dev_dbg.

>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id match_table[] = {
> 
> Please call it something besides 'match_table'. qcom_cpufreq_hw_match?
> 

Renamed to use 'qcom_cpufreq_hw_match'.

>> +       { .compatible = "qcom,cpufreq-hw", .data = &cpufreq_qcom_std_offsets },
>> +       {}
>> +};
>> +
>> +static struct platform_driver qcom_cpufreq_hw_driver = {
>> +       .probe = qcom_cpufreq_hw_driver_probe,
>> +       .driver = {
>> +               .name = "qcom-cpufreq-hw",
>> +               .of_match_table = match_table,
>> +               .owner = THIS_MODULE,
> 
> platform_driver_register() already assigns this. This should be dropped
> from here.
> 

Removed.

>> +       },
>> +};
>> +
>> +static int __init qcom_cpufreq_hw_init(void)
>> +{
>> +       return platform_driver_register(&qcom_cpufreq_hw_driver);
>> +}
>> +subsys_initcall(qcom_cpufreq_hw_init);
>> +
>> +MODULE_DESCRIPTION("QCOM firmware-based CPU Frequency driver");
>> +MODULE_LICENSE("GPL v2");
> 
> It should be tristate then in the Kconfig.
> 

Removed the module license and want to keep it inbuilt.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
