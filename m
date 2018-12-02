Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585AC04EB9
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF8820881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 03:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W9R2tgu8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dYBFuPef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF8820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBDrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:47:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLBDrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:47:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20C4260B1E; Sun,  2 Dec 2018 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722421;
        bh=gDz7aq79th5X3JqOkECbiDJxE7SvH2QZeJOeNj1seFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W9R2tgu81tY9xfWfpQBUwBhoOGucRNd5O8bSSTjriV6BkAwbxI48Q7dJgKKgMZ97P
         BBWrqT3fG+1zcZgX0zMd02Ox17GfmZEuivQqI/mSGp5MnlslleKovmovq9LbctJTW+
         Etd60WLm7pbfx6d0ZLjIDQCFDJUH3ehZpwRme8PM=
Received: from [192.168.225.247] (unknown [49.33.158.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDA5D60481;
        Sun,  2 Dec 2018 03:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543722418;
        bh=gDz7aq79th5X3JqOkECbiDJxE7SvH2QZeJOeNj1seFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dYBFuPeffDdLYmREGk1jbTU922jig8eY5ej2FVlwCe9BarY/92o2ysGzP2XkM50mM
         et/7EwaVLRHIWGbYAHCBtmaO6A5yeHAtHb2SVTwdoCzq/FCiq44ZHlptfLPiIQ2uKU
         JGqs9kvqKq5u4LOSm8zM5aIqsNZTBKKSc417x/oI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDA5D60481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v10 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-3-git-send-email-tdas@codeaurora.org>
 <20181121184106.GT22824@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <8b4d03da-85e9-d4d6-8c7f-cbeb47e35886@codeaurora.org>
Date:   Sun, 2 Dec 2018 09:16:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181121184106.GT22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

On 11/22/2018 12:11 AM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
> thanks for respinning, a few nits inline.
> 
> On Wed, Nov 21, 2018 at 04:12:47PM +0530, Taniya Das wrote:
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |  11 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 346 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 358 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 4e1131e..688f102 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -114,6 +114,17 @@ config ARM_QCOM_CPUFREQ_KRYO
>>
>>   	  If in doubt, say N.
>>
>> +config ARM_QCOM_CPUFREQ_HW
>> +	tristate "QCOM CPUFreq HW driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  Support for the CPUFreq HW driver.
>> +	  Some QCOM chipsets have a HW engine to offload the steps
>> +	  necessary for changing the frequency of the CPUs. Firmware loaded
>> +	  in this engine exposes a programming interface to the OS.
>> +	  The driver implements the cpufreq interface for this HW engine.
>> +	  Say Y if you want to support CPUFreq HW.
>> +
>>   config ARM_S3C_CPUFREQ
>>   	bool
>>   	help
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index d5ee456..789b2e0 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>>   obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>>   obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>>   obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
>>   obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>>   obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>>   obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
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
>> +#define LUT_MAX_ENTRIES			40U
>> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE			32
>> +#define CLK_HW_DIV			2
>> +
>> +/* Register offsets */
>> +#define REG_ENABLE			0x0
>> +#define REG_LUT_TABLE			0x110
>> +#define REG_PERF_STATE			0x920
>> +
>> +struct cpufreq_qcom {
>> +	struct cpufreq_frequency_table *table;
>> +	void __iomem *perf_base;
> 
> nit: is this really a base address? It's the address of the perf state
> register, right? Better name it 'perf_state_reg'/'reg_perf_state' or
> similar (just 'perf_state' might be confusing, I'd expect a variable
> with this name to hold a state, not an address).
> 

I have updated the name to "perf_state_reg".

>> +	cpumask_t related_cpus;
>> +	unsigned int max_cores;
>> +	unsigned long xo_rate;
>> +	unsigned long cpu_hw_rate;
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
>> +	writel_relaxed(index, c->perf_base);
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
>> +	index = readl_relaxed(c->perf_base);
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
>> +	writel_relaxed(index, c->perf_base);
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
>> +				    struct cpufreq_qcom *c, void __iomem *base)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
>> +
>> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +				sizeof(*c->table), GFP_KERNEL);
>> +	if (!c->table)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
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
>> +
>> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>> +						 "#freq-domain-cells", 0,
>> +						  &args);
>> +		of_node_put(cpu_np);
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
>> +	void __iomem *base;
>> +	int ret, cpu_r;
>> +
>> +	if (qcom_freq_domain_map[cpu])
>> +		return 0;
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
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
>> +	c->perf_base = base + REG_PERF_STATE;
>> +
>> +	ret = qcom_cpufreq_hw_read_lut(pdev, c, base);
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
>> +	clk = clk_get(&pdev->dev, "xo");
>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	xo_rate = clk_get_rate(clk);
>> +
>> +	clk_put(clk);
>> +
>> +	clk = clk_get(&pdev->dev, "gcc_cpuss_gpll0_clk_src");
> 
> As commented on the binding patch, I'm not sure if this is the correct
> name for this clock input from the POV of this IP block. Just a doubt
> at this point, I don't have/find the hardware documentation to suggest
> something better.
> 

The clock name used in the latest series is "alternate".

>> +	if (IS_ERR(clk))
>> +		return PTR_ERR(clk);
>> +
>> +	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
>> +
>> +	clk_put(clk);
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_np = of_cpu_device_node_get(cpu);
>> +		if (!cpu_np) {
>> +			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
>> +				cpu);
>> +			continue;
>> +		}
>> +
>> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
>> +						 "#freq-domain-cells", 0,
>> +						  &args);
>> +		of_node_put(cpu_np);
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
>> +	{ .compatible = "qcom,cpufreq-hw" },
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
> 
> I'm still not convinced that a subsys_initcall is needed (instead of
> module_init or device_initcall), as mentioned in the review of v7
> it causes problems when registering CPU cooling devices, but we can
> also fix this when support for cooling devices is added ;-)
> 

Yes, sure, we could revisit this.

>> +static void __exit qcom_cpufreq_hw_exit(void)
>> +{
>> +	cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
>> +	platform_driver_unregister(&qcom_cpufreq_hw_driver);
>> +}
>> +module_exit(qcom_cpufreq_hw_exit);
>> +
>> +MODULE_DESCRIPTION("QTI CPUFREQ HW Driver");
> 
> nit: make it 'QCOM CPUFreq HW driver' for consistency?
> 

Thanks, have taken care in the latest patch.

> Cheers
> 
> Matthias
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
