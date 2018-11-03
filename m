Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB7C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C2F20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 03:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AbIIbZMy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GwJfblY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C2F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeKCMQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 08:16:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeKCMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 08:16:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F9636086A; Sat,  3 Nov 2018 03:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541214375;
        bh=qJmM3OTPSqiuVzE88spQcCcQ9y6AUqu5CuInhuOTkoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AbIIbZMyQORab64QUEDNYSYoJfzH+GGR6a1HxmMqPXFMTdQKxjjKo7rCbZiCjQBCo
         FSitTLiQUxf7cDFuYKilnyug86o1cUn35Sw7E1ts/UpqlhMMYaB36Gfp+0pzWMGamR
         mC3/jvi8zg4TkCDfvI1+VisimLz53k8TEF5tDYBs=
Received: from [10.79.172.169] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46C916053B;
        Sat,  3 Nov 2018 03:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541214374;
        bh=qJmM3OTPSqiuVzE88spQcCcQ9y6AUqu5CuInhuOTkoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GwJfblY9cbRPC3PpwlFyK4Nt/67htqbfrGefef5HmezG64wPZSfyIPQU0LeXbIkIF
         BMkr/OPdRZZHB+n8PJIcjDk1xn+HZb0F2WBV86HfUT3AcYQ1BMOIiPPfxHKw/f4Oi4
         /QCcr2CoM+6SiNcCFlZj9iUi1a8+OgcUEYv51dfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46C916053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org>
 <1539257761-23023-3-git-send-email-tdas@codeaurora.org>
 <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <0c51a12e-38d3-2df5-4f5f-6a687727e9bf@codeaurora.org>
Date:   Sat, 3 Nov 2018 08:36:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153981915373.5275.15971019914218464179@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 10/18/2018 5:02 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-11 04:36:01)
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -121,6 +121,17 @@ config ARM_QCOM_CPUFREQ_KRYO
>>
>>            If in doubt, say N.
>>
>> +config ARM_QCOM_CPUFREQ_HW
>> +       bool "QCOM CPUFreq HW driver"
> 
> Is there any reason this can't be a module?
> 

We do not have any use cases where we need to support it as module.

>> +       depends on ARCH_QCOM || COMPILE_TEST
>> +       help
>> +         Support for the CPUFreq HW driver.
>> +         Some QCOM chipsets have a HW engine to offload the steps
>> +         necessary for changing the frequency of the CPUs. Firmware loaded
>> +         in this engine exposes a programming interface to the OS.
>> +         The driver implements the cpufreq interface for this HW engine.
>> +         Say Y if you want to support CPUFreq HW.
>> +
>>   config ARM_S3C_CPUFREQ
>>          bool
>>          help
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..fe1c264
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
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +
>> +#define LUT_MAX_ENTRIES                        40U
>> +#define CORE_COUNT_VAL(val)            (((val) & (GENMASK(18, 16))) >> 16)
>> +#define LUT_ROW_SIZE                   32
>> +#define CLK_HW_DIV                     2
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
>> +       void __iomem *reg_bases[REG_ARRAY_SIZE];
>> +       cpumask_t related_cpus;
>> +       unsigned int max_cores;
>> +       unsigned long xo_rate;
>> +       unsigned long cpu_hw_rate;
>> +};
>> +
>> +static const u16 cpufreq_qcom_std_offsets[REG_ARRAY_SIZE] = {
> 
> Is this going to change in the future?
> 

Yes, they could change and that was the reason to introduce the offsets. 
This was discussed earlier too with Sudeep and was to add them.

>> +       [REG_ENABLE]            = 0x0,
>> +       [REG_LUT_TABLE]         = 0x110,
>> +       [REG_PERF_STATE]        = 0x920,
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
>> +       writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> 
> Why can't we avoid the indirection here and store the perf_state pointer
> in probe? Then we don't have to indirect through a table to perform the
> register write.
> 

As the offsets could change and that was the reason to add this.

>> +
>> +       return 0;
>> +}
>> +
> [..]
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
>> +       clk = clk_get(&pdev->dev, "cpu_clk");
> 
> Sad that the name is cpu_clk, instead of something like 'backup' or
> whatever the name really is in hardware.
> 

Sure, would update it.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
