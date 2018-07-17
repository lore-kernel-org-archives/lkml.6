Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D49ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B1420844
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GnMoGiPh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ndjqs0Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B1420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeGQG2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:28:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeGQG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:28:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7523060791; Tue, 17 Jul 2018 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531807050;
        bh=qp6bp3K9bOHUwqAoWvM98ouJoX7Rsi/0Zr3a8LIbDvs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GnMoGiPh4RX3nf+TXZCX5PfLw/qDWv07vbTYJPR6/1jK52tSLz0qb1cAcv7qSPDv1
         2kLhEzaJrY8eQfQDjj2cadBaTaDutyRLIYinlBcDET3rOop0M9DuExMlRqzGSFoZbu
         mIt9r8nHBQ16Mk/C6Mo5KNT9VTHs+aLzqZaKEjrU=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E316602BC;
        Tue, 17 Jul 2018 05:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531807048;
        bh=qp6bp3K9bOHUwqAoWvM98ouJoX7Rsi/0Zr3a8LIbDvs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ndjqs0Hj5kzNGOW6lOKievHNphiEqdANCLDWfcABsI2Yz8TkHovpQhQ5W3PPw5naI
         m1jSpfZuoxiT1jIH7rqJ1lweg4fVGW/A4fef1V/WvpNlH72ysVAWc2Dxax0hXojIde
         WPpwbARy50coTdqlD+vRcwuWnqxSl6o9GJIjyBjw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E316602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
 <20180713001959.GV129942@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a88dfc5b-49b4-a2ea-d451-368157337ed5@codeaurora.org>
Date:   Tue, 17 Jul 2018 11:27:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713001959.GV129942@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

Thanks for your review comments.

On 7/13/2018 5:49 AM, Matthias Kaehlcke wrote:
> Hi,
> 
> On Thu, Jul 12, 2018 at 11:35:45PM +0530, Taniya Das wrote:
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |  10 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 344 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 355 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 52f5f1a..141ec3e 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -312,3 +312,13 @@ config ARM_PXA2xx_CPUFREQ
>>   	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
>>
>>   	  If in doubt, say N.
>> +
>> +config ARM_QCOM_CPUFREQ_HW
>> +	bool "QCOM CPUFreq HW driver"
>> +	help
>> +	 Support for the CPUFreq HW driver.
>> +	 Some QCOM chipsets have a HW engine to offload the steps
>> +	 necessary for changing the frequency of the CPUs. Firmware loaded
>> +	 in this engine exposes a programming interafce to the High-level OS.
>> +	 The driver implements the cpufreq driver interface for this HW engine.
>> +	 Say Y if you want to support CPUFreq HW.
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index fb4a2ec..1226a3e 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>>   obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
>>   obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>>   obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
>>
>>
>>   ##################################################################################
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
>> +#define INIT_RATE			300000000UL
>> +#define XO_RATE				19200000UL
>> +#define LUT_MAX_ENTRIES			40U
>> +#define CORE_COUNT_VAL(val)		(((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE			32
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
>> +	struct device *dev;
>> +	const u16 *reg_offset;
>> +	void __iomem *base;
>> +	cpumask_t related_cpus;
>> +	unsigned int max_cores;
> 
> Same comment as on v4:
> 
> Why *max*_cores? This seems to be the number of CPUs in a cluster and
> qcom_read_lut() expects the core count read from the LUT to match
> exactly. Maybe it's the name from the datasheet? Should it still be
> 'num_cores' or similer?
>

Your understanding is correct. I would prefer to leave the naming as 
'max_cores'.

>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> 
> It would be an option to limit this to the number of CPU clusters and
> allocate it dynamically when the driver is initialized (key = first
> core in the cluster). Probably not worth the hassle with the limited
> number of cores though.
> 
>> +static int qcom_read_lut(struct platform_device *pdev,
>> +			 struct cpufreq_qcom *c)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	unsigned int offset;
>> +	u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
>> +
>> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
>> +				sizeof(*c->table), GFP_KERNEL);
>> +	if (!c->table)
>> +		return -ENOMEM;
>> +
>> +	offset = c->reg_offset[REG_LUT_TABLE];
>> +
>> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>> +		data = readl_relaxed(c->base + offset + i * LUT_ROW_SIZE);
>> +		src = ((data & GENMASK(31, 30)) >> 30);
>> +		lval = (data & GENMASK(7, 0));
>> +		core_count = CORE_COUNT_VAL(data);
>> +
>> +		if (src == 0)
>> +			c->table[i].frequency = INIT_RATE / 1000;
>> +		else
>> +			c->table[i].frequency = XO_RATE * lval / 1000;
> 
> You changed the condition from '!src' to 'src == 0'. My suggestion on
> v4 was in part about a negative condition, but also about the
> order. If it doesn't obstruct the code otherwise I think for an if-else
> branch it is good practice to handle the more common case first and
> then the 'exception'. I would expect most entries to have an actual
> rate. Just a nit in any case, feel free to ignore if you prefer as is.
> 

Thanks, Sure, I would take care of it in the next series.

>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	unsigned int offset, cpu_r;
>> +	int ret;
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	c->reg_offset = of_device_get_match_data(&pdev->dev);
>> +	if (!c->reg_offset)
>> +		return -EINVAL;
>> +
>> +	if (of_address_to_resource(np, 0, &res))
>> +		return -ENOMEM;
>> +
>> +	c->base = devm_ioremap(dev, res.start, resource_size(&res));
>> +	if (!c->base) {
>> +		dev_err(dev, "Unable to map %s base\n", np->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	offset = c->reg_offset[REG_ENABLE];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->base + offset) & 0x1)) {
>> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
>> +	if (!c->max_cores)
>> +		return -ENOENT;
>> +
>> +	ret = qcom_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	qcom_freq_domain_map[cpu] = c;
> 
> If the general code structure remains as is (see my comment below)
> the assignment could be done in a 'if (cpu == cpu_r)' branch instead
> of first assigning and then overwriting it for 'cpu != cpu_r'.
> 
>> +
>> +	/* Related CPUs to keep a single copy */
>> +	cpu_r = cpumask_first(&c->related_cpus);
>> +	if (cpu != cpu_r) {
>> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
>> +		devm_kfree(dev, c);
>> +	}
> 
> Couldn't we do this at the beginning of the function instead of going
> through allocation, ioremap, read_lut for every core only to throw the
> information away later for the 'related' CPUs?
> 
> qcom_cpu_resources_init() is called with increasing 'cpu' values, hence the
> 'first' CPU of the cluster is already initialized when the 'related'
> ones are processed.
> 

I would be moving the code to the beginning of the function.

>> +	return 0;
>> +}
>> +
>> +static int qcom_resources_init(struct platform_device *pdev)
>> +{
>> +	struct device_node *np, *cpu_np;
>> +	unsigned int cpu;
>> +	int ret;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_np = of_cpu_device_node_get(cpu);
>> +		if (!cpu_np) {
>> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
>> +				cpu);
>> +			continue;
>> +		}
>> +
>> +		np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
>> +		if (!np) {
>> +			dev_err(&pdev->dev, "Failed to get freq-domain device\n");
> 
> 			of_node_put(cpu_np);
> 
>> +			return -EINVAL;
>> +		}
>> +
>> +		of_node_put(cpu_np);
>> +
>> +		ret = qcom_cpu_resources_init(pdev, np, cpu);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Thanks
> 
> Matthias
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
