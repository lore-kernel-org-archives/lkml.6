Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xBueB0ncGFuWZAAAmS7hNA
	; Thu, 07 Jun 2018 07:18:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D8B076089E; Thu,  7 Jun 2018 07:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528355913;
	bh=JcBuc6n5A2Mw2/HLwglWgKC9Bmg5/VxUikBr+m/2pgY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mRC77zC5uYCbXVYmyTG1xejo9cz53wrJVhyxAUKPB8SF63MaB835PT8HUBLJ6o4Tc
	 qPVREw71iIVUrA32khDnJYzO5DkIUfw9vuEX8IYTs5GhIRylK5k3sQYOyfuj6R9nkP
	 p9QqeosVRH3L3os4eWSrP+Z79nN+IunWSOrjw8Y4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B40D5608B8;
	Thu,  7 Jun 2018 07:18:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fenBg6AN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JDlTRbR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B40D5608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeFGHSa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:18:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeFGHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:18:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 021AE605A2; Thu,  7 Jun 2018 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528355908;
        bh=JcBuc6n5A2Mw2/HLwglWgKC9Bmg5/VxUikBr+m/2pgY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fenBg6ANElEr2RAgtpkpjTPPWReJVqXgbgucI2AQEmGgyPwEMl1hFJwBjPcyD0nFH
         N0EpeOlGoBPgj3wjEpEDCcVfn9WFc0F73nedcko4Tu4UNptXlzv13q40KnyoimiODL
         foaHCvoyuLA12zSVWEtTI7OqfKxv0kskF0qI1+f4=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFC1F607DC;
        Thu,  7 Jun 2018 07:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528355906;
        bh=JcBuc6n5A2Mw2/HLwglWgKC9Bmg5/VxUikBr+m/2pgY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JDlTRbR6rgkb72plcSrvQ3S7/U1/6Z9yW6zHtA2hguAi2btCnpx6+Awba+JYmRu3H
         +yyNOYcWKybHdcuuE6SsGfw+P2xAIZLtbUGdifcSYqoBd2oZDPtrMH9GoprHPP10Do
         1Aap+rN/F/p44MBTpREaGzo5eLWmoJqN67jeP0Ww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFC1F607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, robh@kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
References: <1528109194-16864-1-git-send-email-tdas@codeaurora.org>
 <1528109194-16864-3-git-send-email-tdas@codeaurora.org>
 <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <3cd5944b-d2ca-e7d7-f315-c3e5f230701b@codeaurora.org>
Date: Thu, 7 Jun 2018 12:48:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606060119.yzl24vhqff6btvrk@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

Thank you for the review comments.

On 6/6/2018 11:31 AM, Viresh Kumar wrote:
> On 04-06-18, 16:16, Taniya Das wrote:
>> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this firmware.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |   9 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-fw.c | 316 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 326 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index c7ce928..82c391e 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -312,3 +312,12 @@ config ARM_PXA2xx_CPUFREQ
>>   	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
>>
>>   	  If in doubt, say N.
>> +
>> +config ARM_QCOM_CPUFREQ_FW
>> +	bool "QCOM CPUFreq FW driver"
>> +	help
>> +	 Support for the CPUFreq FW driver.
>> +	 The CPUfreq FW preset in some QCOM chipsets offloads the steps
>> +	 necessary for changing the frequency of CPUs. The driver
>> +	 implements the cpufreq driver interface for this firmware.
>> +	 Say Y if you want to support CPUFreq FW.
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index fb4a2ec..34691a2 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>>   obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>>   obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>>   obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)	+= qcom-cpufreq-fw.o
>>
>>
>>   ##################################################################################
>> diff --git a/drivers/cpufreq/qcom-cpufreq-fw.c b/drivers/cpufreq/qcom-cpufreq-fw.c
>> new file mode 100644
>> index 0000000..2135a08
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-fw.c
>> @@ -0,0 +1,316 @@
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
>> +#define INIT_RATE			300000000UL
>> +#define XO_RATE				19200000UL
>> +#define LUT_MAX_ENTRIES			40U
>> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE			32
>> +
>> +struct cpufreq_qcom {
>> +	struct cpufreq_frequency_table *table;
>> +	struct device *dev;
>> +	void __iomem *perf_base;
>> +	void __iomem *lut_base;
>> +	cpumask_t related_cpus;
>> +	unsigned int max_cores;
>> +};
>> +
>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
>> +
>> +static int
>> +qcom_cpufreq_fw_target_index(struct cpufreq_policy *policy,
>> +			     unsigned int index)
>> +{
>> +	struct cpufreq_qcom *c = policy->driver_data;
>> +
>> +	writel_relaxed(index, c->perf_base);
>> +
>> +	return 0;
>> +}
>> +
>> +static unsigned int qcom_cpufreq_fw_get(unsigned int cpu)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	unsigned int index;
>> +
>> +	c = qcom_freq_domain_map[cpu];
>> +	if (!c)
>> +		return 0;
>> +
>> +	index = readl_relaxed(c->perf_base);
>> +	index = min(index, LUT_MAX_ENTRIES - 1);
>> +
>> +	return c->table[index].frequency;
>> +}
>> +
>> +static int qcom_cpufreq_fw_cpu_init(struct cpufreq_policy *policy)
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
>> +	policy->freq_table = c->table;
>> +	policy->driver_data = c;
> 
> What about fast cpufreq switching ? I think you can enable that option as well
> here..
> 
Sure I will take a look and update.

>> +
>> +	return 0;
>> +}
>> +
>> +static struct freq_attr *qcom_cpufreq_fw_attr[] = {
>> +	&cpufreq_freq_attr_scaling_available_freqs,
>> +	&cpufreq_freq_attr_scaling_boost_freqs,
>> +	NULL
>> +};
>> +
>> +static struct cpufreq_driver cpufreq_qcom_fw_driver = {
>> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
>> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
>> +	.verify		= cpufreq_generic_frequency_table_verify,
>> +	.target_index	= qcom_cpufreq_fw_target_index,
>> +	.get		= qcom_cpufreq_fw_get,
>> +	.init		= qcom_cpufreq_fw_cpu_init,
> 
> What about CPU hotplug ? We can still do that, right ? So what will happen if
> all CPUs of a freq-domain are removed (hence cpufreq policy is removed) and then
> someone calls qcom_cpufreq_fw_get() ? You should really work on cpufreq_policy
> there to get 'c'.
> 

You want the _get to do something as below.
Please correct me if my understanding is wrong.
....

  policy = cpufreq_cpu_get_raw(cpu);
  if (!policy)
     return 0;

  c = policy->driver_data;

  index = readl_relaxed(c->perf_base);
  index = min(index, LUT_MAX_ENTRIES - 1);

  return c->table[index].frequency;

....

>> +	.name		= "qcom-cpufreq-fw",
>> +	.attr		= qcom_cpufreq_fw_attr,
>> +	.boost_enabled	= true,
>> +};
>> +
>> +static int qcom_read_lut(struct platform_device *pdev,
>> +			 struct cpufreq_qcom *c)
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
>> +		data = readl_relaxed(c->lut_base + i * LUT_ROW_SIZE);
>> +		src = ((data & GENMASK(31, 30)) >> 30);
>> +		lval = (data & GENMASK(7, 0));
>> +		core_count = CORE_COUNT_VAL(data);
>> +
>> +		if (!src)
>> +			c->table[i].frequency = INIT_RATE / 1000;
>> +		else
>> +			c->table[i].frequency = XO_RATE * lval / 1000;
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
> 
> Looks like there are many problems here.
> - You are assigning prev_freq with cur_freq (which may be uninitialized local
>    variable here).
> - In this version, you never write CPUFREQ_ENTRY_INVALID to table[i].frequency,
>    which looks wrong as well.
> 

- The code to detect boost, would only enter for i > 0 and the prev_freq 
   would be initialized with the cur_freq.
- In the case where the core_count != max_cores, the cur_freq is marked 
INVALID, and when both prev_freq == cur_freq && prev_cc && cur_cc match, 
that is the time the prev table flags need to be updated. Marking the 
table[i].frequency as INVALID is not required as cur_freq is already 
marked with the same. Please correct me if you think otherwise.

>> +
>> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
>> +{
>> +	struct device_node  *cpu_dev;
> 
> s/cpu_dev/cpu_np/
> 
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_dev = of_cpu_device_node_get(cpu);
>> +		if (!cpu_dev)
>> +			continue;
>> +		cpu_dev = of_parse_phandle(cpu_dev, "qcom,freq-domain", 0);
> 
> What's returned here is a pointer to the qcom,freq-domain node, and you assign
> that to a variable named cpu_dev. Either use two variables for different node
> types, or rename it to temp_np or something similar.
> 

I would use a different node.

>> +		if (!cpu_dev)
>> +			continue;
>> +		if (cpu_dev == np)
>> +			cpumask_set_cpu(cpu, m);
>> +	}
>> +
>> +	if (cpumask_empty(m))
>> +		return -ENOENT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *en_base;
>> +	int cpu, index, ret;
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	index = of_property_match_string(np, "reg-names", "enable");
>> +	if (index < 0)
>> +		return index;
>> +
>> +	if (of_address_to_resource(np, index, &res))
>> +		return -ENOMEM;
>> +
>> +	en_base = devm_ioremap(dev, res.start, resource_size(&res));
>> +	if (!en_base) {
>> +		dev_err(dev, "Unable to map %s enable-base\n", np->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* FW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(en_base) & 0x1)) {
>> +		dev_err(dev, "%s firmware not enabled\n", np->name);
>> +		return -ENODEV;
>> +	}
>> +	devm_iounmap(&pdev->dev, en_base);
>> +
>> +	index = of_property_match_string(np, "reg-names", "perf");
>> +	if (index < 0)
>> +		return index;
>> +
>> +	if (of_address_to_resource(np, index, &res))
>> +		return -ENOMEM;
>> +
>> +	c->perf_base = devm_ioremap(dev, res.start, resource_size(&res));
>> +	if (!c->perf_base) {
>> +		dev_err(dev, "Unable to map %s perf-base\n", np->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	index = of_property_match_string(np, "reg-names", "lut");
>> +	if (index < 0)
>> +		return index;
>> +
>> +	if (of_address_to_resource(np, index, &res))
>> +		return -ENOMEM;
>> +
>> +	c->lut_base = devm_ioremap(dev, res.start, resource_size(&res));
>> +	if (!c->lut_base) {
>> +		dev_err(dev, "Unable to map %s lut-base\n", np->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to get core phandles\n", np->name);
> 
> Maybe write a more relevant error message here ?
> 

Sure, would take care of it in the next patch.

>> +		return ret;
>> +	}
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
> 
> Maybe remove the error checking conditional from qcom_get_related_cpus() and
> check !c->max_cores here for the same.
> 

I would update it in the next patch.

>> +
>> +	ret = qcom_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
> 
> Enter a blank line here.

I would update in the next patch.
> 
>> +	for_each_cpu(cpu, &c->related_cpus)
>> +		qcom_freq_domain_map[cpu] = c;
> 
> This whole setup looks a bit confusing to me. This is what you are doing
> essentially:
> 
> qcom_resources_init()
> {
>          for_each_possible_cpu() {
>                  qcom_cpu_resources_init()
>                  {
>                          populate c->related_cpus;
> 
>                          for_each_related_cpu() {
>                                  qcom_freq_domain_map[cpu] = c;
>                          }
>                  }
>          }
> }
> 
> So if there are 4 CPUs that share a freq domain, then you are allocating 'c' 4
> times and (over)writing qcom_freq_domain_map[] for all these CPUs 4 times and
> finally keeping value of 'c' only once.
> 
> You must be running most of the work done in qcom_resources_init() only once per
> freq-domain.
> 

Thanks, you are correct, I carried the earlier logic, would cleanup in 
the next patch.

>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_resources_init(struct platform_device *pdev)
>> +{
>> +	struct device_node *np, *cpu_dev;
> 
> cpu_dev is normally used in kernel for struct device *, maybe use cpu_np ?

I would update it in the next patch.
> 
>> +	unsigned int cpu;
>> +	int ret;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_dev = of_cpu_device_node_get(cpu);
>> +		if (!cpu_dev) {
>> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
>> +				cpu);
>> +			continue;
>> +		}
>> +
>> +		np = of_parse_phandle(cpu_dev, "qcom,freq-domain", 0);
>> +		if (!np) {
>> +			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
>> +			continue;
> 
> I am not sure if we should continue or error out here. Why would you want only a
> group of CPUs to have this property set ? Or if you really have a case for that
> currently ?
> 

I don't have any usecase, but I was of the opinion in case there is no 
freq domains attached to a cluster. But it might be better I error out.

>> +		}
>> +
>> +		of_node_put(cpu_dev);
>> +
>> +		ret = qcom_cpu_resources_init(pdev, np);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_cpufreq_fw_driver_probe(struct platform_device *pdev)
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
>> +	rc = cpufreq_register_driver(&cpufreq_qcom_fw_driver);
>> +	if (rc) {
>> +		dev_err(&pdev->dev, "CPUFreq FW driver failed to register\n");
>> +		return rc;
>> +	}
>> +
>> +	dev_info(&pdev->dev, "QCOM CPUFreq FW driver inited\n");
> 
> s/inited/initialized/ ?
> 

Sure, will fix in the next patch.

>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id match_table[] = {
>> +	{ .compatible = "qcom,cpufreq-fw" },
>> +	{}
>> +};
>> +
>> +static struct platform_driver qcom_cpufreq_fw_driver = {
>> +	.probe = qcom_cpufreq_fw_driver_probe,
>> +	.driver = {
>> +		.name = "qcom-cpufreq-fw",
>> +		.of_match_table = match_table,
>> +		.owner = THIS_MODULE,
>> +	},
>> +};
>> +
>> +static int __init qcom_cpufreq_fw_init(void)
>> +{
>> +	return platform_driver_register(&qcom_cpufreq_fw_driver);
>> +}
>> +subsys_initcall(qcom_cpufreq_fw_init);
>> +
>> +MODULE_DESCRIPTION("QCOM CPU Frequency FW");
>> +MODULE_LICENSE("GPL v2");
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
