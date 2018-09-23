Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0415C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C0214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gDbcO7tc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVLKJ8uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755C0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbeIWPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:45:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:45:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B29D60C8D; Sun, 23 Sep 2018 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537696115;
        bh=pbumnF3PPhxgOS2gZ51O+iyxfy4oAFLDIpLNUFEmYcE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gDbcO7tca3J+QqGzVCCq2qV626zdd4gByzAgBh1GvcJtdk62hkUydjlSAYVbkLpiP
         eqBZrTSBpn20kHRblc6vVmVQiDGII+pZXZcvj8nw3pCqnEbc/1WquRTtIRFzpV6YtH
         ESY04+JhvcQOYcmc+H5uqn11XTIFehaimSE0yVD4=
Received: from [10.79.169.181] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FF5160C65;
        Sun, 23 Sep 2018 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537696113;
        bh=pbumnF3PPhxgOS2gZ51O+iyxfy4oAFLDIpLNUFEmYcE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aVLKJ8uVlHaN1tT2AHNg9j+lDoHpR9z38T8I5gYNjTFiYpVRQSlxUvlxrShXfYUIa
         o/0bXaf37I3ECBmipgmCt9Mmry1T8Iera3jMX1sPCGydLhnEUvuQAQadGRgo6we5cB
         Z4/7y5VXN65i0ET8h1OeFpJpnvLycgStPBFVkjzc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FF5160C65
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
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
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <20180910193016.GG22824@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <97b9cde0-b33e-503e-ad29-e3c85adc26c4@codeaurora.org>
Date:   Sun, 23 Sep 2018 15:18:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910193016.GG22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2018 1:00 AM, Matthias Kaehlcke wrote:
> On Tue, Jul 24, 2018 at 04:12:50PM +0530, Taniya Das wrote:
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |  11 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 360 insertions(+)
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
>> index 0000000..ea8f7d1
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -0,0 +1,348 @@
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
>> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
>> +	cpumask_t related_cpus;
>> +	unsigned int max_cores;
>> +	unsigned long xo_rate;
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
>> +			c->table[i].frequency = INIT_RATE / 1000;
>> +
>> +		cur_freq = c->table[i].frequency;
>> +
>> +		dev_dbg(dev, "index=%d freq=%d, core_count %d\n",
>> +			i, c->table[i].frequency, core_count);
>> +
>> +		if (core_count != c->max_cores)
>> +			cur_freq = CPUFREQ_ENTRY_INVALID;
>> +
> 
> I noticed that the 'power_allocator' thermal governor currently can't
> be used with this driver since there is no OPP table with frequency and
> voltage information. Does the LUT contain information about the
> voltage or is there another mechanism to retrieve it?
> 

No, currently there is no way of reading the voltage information.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
