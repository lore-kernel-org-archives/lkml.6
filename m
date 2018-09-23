Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75434ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01FD20645
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 09:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U3ooMq+b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eNW6YE5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01FD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeIWPiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 11:38:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeIWPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 11:38:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A90160C89; Sun, 23 Sep 2018 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537695672;
        bh=oLDYy5//Agc3UwWLBhsk097EDq/i/3qLSNpnlCKmon4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U3ooMq+bTNr9yiRIj6q/i0i5qxp/FVPVOw3tH/nFJThAac8ufroNDVnNwskOmFN3+
         a2x6Tlymh+hBZfuYrD6QARIuR25sLDnRmcwBNwmobnguJ/eJ9dsVi4d1xvb1P7eS9d
         kroePYwLH+lqES1MzxS8LhDGxChnqGYUG4NHL2Os=
Received: from [10.79.169.181] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF97960C84;
        Sun, 23 Sep 2018 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537695671;
        bh=oLDYy5//Agc3UwWLBhsk097EDq/i/3qLSNpnlCKmon4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eNW6YE5AR7VbejZZZNQ9oEG6smp3QlnwJdvcue8LU3lQdVRFYDY0yjCokdZMXEI2v
         oeRi6qIcuKDegRvy7+6ano5bjBrMhbsUZpaZrmwQ6mRIr5+J7vKbQQhJM0rMFdhaQa
         rOhtm3fhnJKiIDON594eVsMxqWDgdpwt9D/4hayg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF97960C84
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
 <20180829180122.GC10879@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <8c19c840-292c-a5c4-f3d3-0c6fb14b15fb@codeaurora.org>
Date:   Sun, 23 Sep 2018 15:10:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829180122.GC10879@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

Thanks for your review comments.

On 8/29/2018 11:31 PM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
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
> 
> 'dev' is not used and can be removed.
> 

Thanks, would remove in the next patch.

>> ...
>>
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu,
>> +				   unsigned long xo_rate)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	const u16 *offsets;
>> +	int ret, i, cpu_first, cpu_r;
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
>> +	if (of_address_to_resource(np, 0, &res))
>> +		return -ENOMEM;
>> +
>> +	base = devm_ioremap_resource(dev, &res);
>> +	if (!base)
>> +		return -ENOMEM;
>> +
>> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
>> +		c->reg_bases[i] = base + offsets[i];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
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
>> +	c->xo_rate = xo_rate;
>> +
>> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	qcom_freq_domain_map[cpu] = c;
>> +
>> +	/* Related CPUs */
>> +	cpu_first = cpumask_first(&c->related_cpus);
>> +
>> +	for_each_cpu(cpu_r, &c->related_cpus) {
>> +		if (cpu_r != cpu_first)
>> +			qcom_freq_domain_map[cpu_r] =
>> +				qcom_freq_domain_map[cpu_first];
>> +	}
> 
> The above ten lines could be simplified to:
> 
> 	for_each_cpu(cpu_r, &c->related_cpus)
> 		qcom_freq_domain_map[cpu_r] = c;
> 

Would clean it up in the next patch.

>> ...
>>
>> +static int __init qcom_cpufreq_hw_init(void)
>> +{
>> +	return platform_driver_register(&qcom_cpufreq_hw_driver);
>> +}
>> +subsys_initcall(qcom_cpufreq_hw_init);
> 
> Is subsys_initcall used for a particular reason? It will cause
> problems when registering cooling devices, since the thermal device
> class is initialized through an fs_initcall, which are executed
> later.
> 
> Most cpufreq drivers use module_init, device_initcall or
> late_initcall, can't this driver use one of those?
> 

We want the CPU to be scaling to the highest frequency at the earliest.

> Cheers
> 
> Matthias
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
