Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5600AC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75A42087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DBX3aWvb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kafBnz2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75A42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeJKSqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:46:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKSqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:46:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DEB8960C7D; Thu, 11 Oct 2018 11:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539256774;
        bh=VblFLL0PU8ONHPrlwgpjsaOc/BeWq9SjqSCOpHgAn20=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DBX3aWvbapVwRNeia/s9H8FIAihJNmuPTHIU4HiSIZjQHVcQHD+hiHLpJXvgI7yZE
         JvECSLO730Qe83dnLlDAhOvcC/axFSVmM3xCBgCJbaC1tupjqbTSkVAy1+HlE0PfnX
         Zljo73UpAJFzycL3PNfZTQnprDlKIAFfpUxNA8yY=
Received: from [10.79.167.189] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 169E0600C1;
        Thu, 11 Oct 2018 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539256773;
        bh=VblFLL0PU8ONHPrlwgpjsaOc/BeWq9SjqSCOpHgAn20=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kafBnz2vRFhO5MpCu1prLwrCtWvai25mhi0Ftvv5RfIvIKm9l9GEKCYlcxPtoQQ2A
         tLZIa8U0Mlanb4U3FB8lVz0jccTljaJDMmcqyPu8LW9LdKK+xbbPgsUOHGEw0B712k
         Pz6NI2Sgr0DdvW7S7cXXQDIKVI/IXhNoPqvvGj88=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 169E0600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181005105506.neri7niyelz2ahc5@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <14e5ca05-0388-2414-0a56-d73fc23ab4cc@codeaurora.org>
Date:   Thu, 11 Oct 2018 16:49:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181005105506.neri7niyelz2ahc5@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

Thanks for your review comments.

On 10/5/2018 4:25 PM, Viresh Kumar wrote:
> On 23-09-18, 16:03, Taniya Das wrote:
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |  11 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 354 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 366 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 0cd8eb7..93a9d72 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -298,3 +298,14 @@ config ARM_PXA2xx_CPUFREQ
>>   	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
>>
>>   	  If in doubt, say N.
>> +
>> +config ARM_QCOM_CPUFREQ_HW
>> +	bool "QCOM CPUFreq HW driver"
>> +	depends on ARCH_QCOM
>> +	help
>> +	 Support for the CPUFreq HW driver.
>> +	 Some QCOM chipsets have a HW engine to offload the steps
>> +	 necessary for changing the frequency of the CPUs. Firmware loaded
>> +	 in this engine exposes a programming interface to the OS.
>> +	 The driver implements the cpufreq interface for this HW engine.
>> +	 Say Y if you want to support CPUFreq HW.
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index c1ffeab..ca48a1d 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>>   obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>>   obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>>   obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
>>
>>
>>   ##################################################################################
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..43107ab
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -0,0 +1,354 @@
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
>> +#define LUT_MAX_ENTRIES			40U
>> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE			32
>> +#define CLK_HW_DIV			2
>> +
>> +enum {
>> +	REG_ENABLE,
>> +	REG_LUT_TABLE,
>> +	REG_PERF_STATE,
>> +
>> +	REG_ARRAY_SIZE,
>> +};
>> +
>> +struct cpufreq_qcom {
>> +	struct cpufreq_frequency_table *table;
>> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
>> +	cpumask_t related_cpus;
>> +	unsigned int max_cores;
>> +	unsigned long xo_rate;
>> +	unsigned long cpu_hw_rate;
>> +};
>> +
>> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
>> +	[REG_ENABLE]		= 0x0,
>> +	[REG_LUT_TABLE]		= 0x110,
>> +	[REG_PERF_STATE]	= 0x920,
>> +};
>> +
>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>> +
>> +static int
>> +qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>> +			     unsigned int index)
>> +{
>> +	struct cpufreq_qcom *c = policy->driver_data;
>> +
>> +	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
>> +
>> +	return 0;
>> +}
>> +
>> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct cpufreq_policy *policy;
>> +	unsigned int index;
>> +
>> +	policy = cpufreq_cpu_get_raw(cpu);
>> +	if (!policy)
>> +		return 0;
>> +
>> +	c = policy->driver_data;
>> +
>> +	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
>> +	index = min(index, LUT_MAX_ENTRIES - 1);
>> +
>> +	return policy->freq_table[index].frequency;
>> +}
>> +
>> +static unsigned int
>> +qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>> +			    unsigned int target_freq)
>> +{
>> +	struct cpufreq_qcom *c = policy->driver_data;
>> +	int index;
>> +
>> +	index = policy->cached_resolved_idx;
>> +	if (index < 0)
>> +		return 0;
>> +
>> +	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
>> +
>> +	return policy->freq_table[index].frequency;
>> +}
>> +
>> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>> +{
>> +	struct cpufreq_qcom *c;
>> +
>> +	c = qcom_freq_domain_map[policy->cpu];
>> +	if (!c) {
>> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpumask_copy(policy->cpus, &c->related_cpus);
>> +
>> +	policy->fast_switch_possible = true;
>> +	policy->freq_table = c->table;
>> +	policy->driver_data = c;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct freq_attr *qcom_cpufreq_hw_attr[] = {
>> +	&cpufreq_freq_attr_scaling_available_freqs,
>> +	&cpufreq_freq_attr_scaling_boost_freqs,
>> +	NULL
>> +};
>> +
>> +static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
>> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
>> +	.verify		= cpufreq_generic_frequency_table_verify,
>> +	.target_index	= qcom_cpufreq_hw_target_index,
>> +	.get		= qcom_cpufreq_hw_get,
>> +	.init		= qcom_cpufreq_hw_cpu_init,
>> +	.fast_switch    = qcom_cpufreq_hw_fast_switch,
>> +	.name		= "qcom-cpufreq-hw",
>> +	.attr		= qcom_cpufreq_hw_attr,
>> +	.boost_enabled	= true,
>> +};
>> +
>> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
>> +				    struct cpufreq_qcom *c)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *base;
>> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
>> +
>> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +				sizeof(*c->table), GFP_KERNEL);
>> +	if (!c->table)
>> +		return -ENOMEM;
>> +
>> +	base = c->reg_bases[REG_LUT_TABLE];
>> +
>> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +		data = readl_relaxed(base + i * LUT_ROW_SIZE);
>> +		src = (data & GENMASK(31, 30)) >> 30;
>> +		lval = data & GENMASK(7, 0);
>> +		core_count = CORE_COUNT_VAL(data);
>> +
>> +		if (src)
>> +			c->table[i].frequency = c->xo_rate * lval / 1000;
>> +		else
>> +			c->table[i].frequency = c->cpu_hw_rate / 1000;
>> +
>> +		cur_freq = c->table[i].frequency;
>> +
>> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
>> +			i, c->table[i].frequency, core_count);
>> +
>> +		if (core_count != c->max_cores)
>> +			cur_freq = CPUFREQ_ENTRY_INVALID;
>> +
>> +		/*
>> +		 * Two of the same frequencies with the same core counts means
>> +		 * end of table.
>> +		 */
>> +		if (i > 0 && c->table[i - 1].frequency ==
>> +		   c->table[i].frequency && prev_cc == core_count) {
>> +			struct cpufreq_frequency_table *prev = &c->table[i - 1];
>> +
>> +			if (prev_freq == CPUFREQ_ENTRY_INVALID)
>> +				prev->flags = CPUFREQ_BOOST_FREQ;
>> +			break;
>> +		}
>> +		prev_cc = core_count;
>> +		prev_freq = cur_freq;
>> +	}
> 
> The logic here always surprises me, why does the firmware keeps the
> table this way instead of simplifying it  ?
> 

Unfortunately that is the only way to identify.

>> +
>> +	c->table[i].frequency = CPUFREQ_TABLE_END;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_get_related_cpus(int index, struct cpumask *m)
>> +{
>> +	struct device_node *cpu_np;
>> +	struct of_phandle_args args;
>> +	int cpu, ret;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_np = of_cpu_device_node_get(cpu);
>> +		if (!cpu_np)
>> +			continue;
>> +		of_node_put(cpu_np);
> 
> Heh, you can't do that here :)
> 

Yes, I would take care to put it in the right place.

>> +
>> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> 
> As this code still needs to use the same pointer. It is possible that
> the memory associated with cpu_np gets freed as soon as you call
> of_node_put() on that. You should call of_node_put() anytime after
> this routine is called.
> 
>> +				"#freq-domain-cells", 0, &args);
>> +		if (ret < 0)
>> +			continue;
>> +
>> +		if (index == args.args[0])
>> +			cpumask_set_cpu(cpu, m);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   unsigned int cpu, int index,
>> +				   unsigned long xo_rate,
>> +				   unsigned long cpu_hw_rate)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource *res;
>> +	struct device *dev = &pdev->dev;
>> +	const u16 *offsets;
>> +	int ret, i, cpu_r;
>> +	void __iomem *base;
>> +
>> +	if (qcom_freq_domain_map[cpu])
>> +		return 0;
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	offsets = of_device_get_match_data(&pdev->dev);
>> +	if (!offsets)
>> +		return -EINVAL;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
>> +		c->reg_bases[i] = base + offsets[i];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
>> +		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = qcom_get_related_cpus(index, &c->related_cpus);
>> +	if (ret) {
>> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
>> +		return ret;
>> +	}
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
>> +	if (!c->max_cores)
>> +		return -ENOENT;
>> +
>> +	c->xo_rate = xo_rate;
>> +	c->cpu_hw_rate = cpu_hw_rate;
>> +
>> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "Domain-%d failed to read LUT\n", index);
>> +		return ret;
>> +	}
>> +
>> +	for_each_cpu(cpu_r, &c->related_cpus)
>> +		qcom_freq_domain_map[cpu_r] = c;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_resources_init(struct platform_device *pdev)
>> +{
>> +	struct device_node *cpu_np;
>> +	struct of_phandle_args args;
>> +	struct clk *clk;
>> +	unsigned int cpu;
>> +	unsigned long xo_rate, cpu_hw_rate;
>> +	int ret;
>> +
>> +	clk = devm_clk_get(&pdev->dev, "xo");
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	xo_rate = clk_get_rate(clk);
>> +
>> +	devm_clk_put(&pdev->dev, clk);
> 
> Why use devm_ variants if you want to put the clock anyway ?
> 

Would move to non devm_ variants.

>> +	clk = devm_clk_get(&pdev->dev, "cpu_clk");
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
>> +
>> +	devm_clk_put(&pdev->dev, clk);
> 
> same here.
> 
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_np = of_cpu_device_node_get(cpu);
> 
> Where is the of_node_put() corresponding to this ?
> 
>> +		if (!cpu_np) {
>> +			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
>> +				cpu);
>> +			continue;
>> +		}
>> +
>> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>> +				"#freq-domain-cells", 0, &args);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = qcom_cpu_resources_init(pdev, cpu, args.args[0],
>> +					      xo_rate, cpu_hw_rate);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>> +{
>> +	int rc;
>> +
>> +	/* Get the bases of cpufreq for domains */
>> +	rc = qcom_resources_init(pdev);
>> +	if (rc) {
>> +		dev_err(&pdev->dev, "CPUFreq resource init failed\n");
>> +		return rc;
>> +	}
>> +
>> +	rc = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
>> +	if (rc) {
>> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
>> +		return rc;
>> +	}
>> +
>> +	dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
>> +	{ .compatible = "qcom,cpufreq-hw", .data = &cpufreq_qcom_std_offsets },
>> +	{}
>> +};
>> +
>> +static struct platform_driver qcom_cpufreq_hw_driver = {
>> +	.probe = qcom_cpufreq_hw_driver_probe,
>> +	.driver = {
>> +		.name = "qcom-cpufreq-hw",
>> +		.of_match_table = qcom_cpufreq_hw_match,
>> +	},
>> +};
>> +
>> +static int __init qcom_cpufreq_hw_init(void)
>> +{
>> +	return platform_driver_register(&qcom_cpufreq_hw_driver);
>> +}
>> +subsys_initcall(qcom_cpufreq_hw_init);
>> +
>> +MODULE_DESCRIPTION("QCOM firmware-based CPU Frequency driver");
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
