Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F276EAB1B7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75EF208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z9qCNTRo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mEviPQ1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75EF208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbeGLSRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:17:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeGLSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:17:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20B7360555; Thu, 12 Jul 2018 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531418795;
        bh=6HnNr7KL+rtOv3GG8FZDR001ExfULSFGa8s5wCjbqAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z9qCNTRoMjLAR+196IQ24bdIBpO9xPZsojOcNBgdd8lPo8gdlLo0kxAkLmqHhOy0Q
         PgsgnD+4pwBd+jjZjP5c6DOorU8Zkk1d33zhyMcS/WUCNf2aVEz+d7yY+uqfti02Tm
         d9ZQdaua0Ogz6INuuZYeZ00VPBHQgXpAC7lrMBO4=
Received: from [10.79.173.52] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 345856019F;
        Thu, 12 Jul 2018 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531418793;
        bh=6HnNr7KL+rtOv3GG8FZDR001ExfULSFGa8s5wCjbqAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mEviPQ1ytMfbfepn+zdoTN6kTTw0t1d+nwILl4aIEmBZlJQQcwB4gBWaQsgDvIJbw
         WaV25XrQP+K6WbhzL/19MSBv4wqkfsh0bdL1ANNHdxOF4SjG70AGHYPPyII6XMTkF6
         XNwMnhE2fEXsoaw0qiQ+iJluU+DV9fGwKXl3i10M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 345856019F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW
 driver
To:     Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, robh@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org>
 <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
 <20180711203717.GS129942@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <b22d3507-e023-a21b-06c0-788af155e7f7@codeaurora.org>
Date:   Thu, 12 Jul 2018 23:36:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180711203717.GS129942@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please help review of the new series[v5] which takes care of the below.

- Remove mapping different register regions of perf/lut/enable,
   instead map the entire HW region.
- Add reg_offset/cpufreq_qcom_std_offsets to be supplied as device data.
- Check of src == 0 during lut read.
- Add of_node_put(cpu_np) in qcom_get_related_cpus
- Update the qcom_cpu_resources_init for register offset data,
   and cleanup the related cpus to keep a single copy of CPUfreq.
- Replace FW with HW, update Kconfig, rename filename qcom-cpufreq-hw.c

On 7/12/2018 2:07 AM, Matthias Kaehlcke wrote:
> Hi,
> 
> On Tue, Jun 12, 2018 at 04:32:35PM +0530, Taniya Das wrote:
>> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this firmware.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |   9 +
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-fw.c | 336 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 346 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
>>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 52f5f1a..2683716 100644
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
>> index 0000000..62f4452
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-fw.c
>> @@ -0,0 +1,336 @@
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
> 
> Why *max*_cores? This seems to be the number of CPUs in a cluster and
> qcom_read_lut() expects the core count read from the LUT to match
> exactly.
> 
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
> 
> nit: any particular reason to use negative logic here? Why not check
> for 'src[ != NULL]', which also seems to be the more common case.
> 
>> +static int qcom_get_related_cpus(struct device_node *np, struct cpumask *m)
>> +{
>> +	struct device_node *cpu_np, *freq_np;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpu_np = of_cpu_device_node_get(cpu);
>> +		if (!cpu_np)
>> +			continue;
>> +		freq_np = of_parse_phandle(cpu_np, "qcom,freq-domain", 0);
>> +		if (!freq_np)
>> +			continue;
>> +		if (freq_np == np)
>> +			cpumask_set_cpu(cpu, m);
> 
> missing 'of_node_put(cpu_np)'. You might want to do it at the end of
> the loop and use a 'goto' above instead of 'continue'.
> 
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *en_base;
>> +	int index, ret;
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
> 
> The of_property_match_string() - of_address_to_resource() -
> devm_ioremap() pattern is repeated 3x. In case the binding doesn't
> change (there is discussion on the DT patch) you might want to move
> this to a helper.
> 
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
> 			of_node_put(cpu_np);
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
> 
> Cheers
> 
> Matthias
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
