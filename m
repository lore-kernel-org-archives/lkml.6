Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB21C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FA3206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QPlp0L7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbeLNRaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:30:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41144 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeLNRaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:30:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so1360388pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCMJnv/8TopEp5Ur3v15RtFMvPv7LWMP7+jtECQcPOc=;
        b=QPlp0L7jH0nz46lHOvITqfpXx6zalDTA1C+97r67o/rkrl7ynryBp5GyV4+6Q+K2SN
         KYTJnBCFVU8EYDTHfA73jGyC9gEwk3tg8AH8LISkLGYd5wePPLNK91vWGJ9jTqwGaaGY
         Cq9DxapGKqhn7yMhlFtTO2XynqJsZAOdy0Qpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCMJnv/8TopEp5Ur3v15RtFMvPv7LWMP7+jtECQcPOc=;
        b=U8Ihd51+JkHHiDPaxObxWrIgD0VRtULXvXs/7Jo0j2AL+L4m3DamlDuYjnxwGyORVL
         1APm8wXk116JTJCecEx6grE56I5v5ISL66jvkRfBFoXfEsDbtiTBEA19KBjQaU7HHJIL
         E2h0NXzH/tN7cFIXIxJPCKRWPIjE+3U9bdThSpvPUJBbfYP3CCu9VLclZ8O/UMh+iCUC
         CR5I/RbpnS1oGAnP4lAvsWOEak1YZ+igVWQySyNZtCNaeS+GNzi4GZ7EQS67YPPpQBgs
         9y5yHBYkWI9bGgJBKetVaFcD6BjSuBzT+fCtb5YdBtRflhh0INhS/pvzBCpnzRI+NcFS
         mFRA==
X-Gm-Message-State: AA+aEWa7UAFy++36N5wGV8hMwoO7VTgMcziYL6jlYKwwPqs+7aFeNBjI
        DujKCVXPrA3jyFWP+HkBTm3ueg==
X-Google-Smtp-Source: AFSGD/XJVnxxODDEG4FXTDQjEgHHeIBjVZ0q0TK2tyR22sRgzFxzoET19EY7Y9H0/BONL3rqOhLcew==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr3781638pfd.40.1544808615218;
        Fri, 14 Dec 2018 09:30:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 128sm8401301pfu.129.2018.12.14.09.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 09:30:14 -0800 (PST)
Date:   Fri, 14 Dec 2018 09:30:13 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v13 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181214173013.GA109358@google.com>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
 <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:40:24AM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

I think it's common practice to carry over tags like 'Reviewed-by' or
'Acked-by' for trivial changes.

> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 308 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 4e1131e..688f102 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -114,6 +114,17 @@ config ARM_QCOM_CPUFREQ_KRYO
> 
>  	  If in doubt, say N.
> 
> +config ARM_QCOM_CPUFREQ_HW
> +	tristate "QCOM CPUFreq HW driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  Support for the CPUFreq HW driver.
> +	  Some QCOM chipsets have a HW engine to offload the steps
> +	  necessary for changing the frequency of the CPUs. Firmware loaded
> +	  in this engine exposes a programming interface to the OS.
> +	  The driver implements the cpufreq interface for this HW engine.
> +	  Say Y if you want to support CPUFreq HW.
> +
>  config ARM_S3C_CPUFREQ
>  	bool
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index d5ee456..08c071b 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)	+= qcom-cpufreq-hw.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-kryo.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..d83939a
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +#define LUT_MAX_ENTRIES			40U
> +#define LUT_SRC				GENMASK(31, 30)
> +#define LUT_L_VAL			GENMASK(7, 0)
> +#define LUT_CORE_COUNT			GENMASK(18, 16)
> +#define LUT_ROW_SIZE			32
> +#define CLK_HW_DIV			2
> +
> +/* Register offsets */
> +#define REG_ENABLE			0x0
> +#define REG_LUT_TABLE			0x110
> +#define REG_PERF_STATE			0x920
> +
> +static unsigned long cpu_hw_rate, xo_rate;
> +static struct platform_device *global_pdev;
> +
> +static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +					unsigned int index)
> +{
> +	void __iomem *perf_state_reg = policy->driver_data;
> +
> +	writel_relaxed(index, perf_state_reg);
> +
> +	return 0;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +{
> +	void __iomem *perf_state_reg;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;
> +
> +	perf_state_reg = policy->driver_data;
> +
> +	index = readl_relaxed(perf_state_reg);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +						unsigned int target_freq)
> +{
> +	void __iomem *perf_state_reg = policy->driver_data;
> +	int index;
> +
> +	index = policy->cached_resolved_idx;
> +	if (index < 0)
> +		return 0;
> +
> +	writel_relaxed(index, perf_state_reg);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int qcom_cpufreq_hw_read_lut(struct device *dev,
> +				    struct cpufreq_policy *policy,
> +				    void __iomem *base)
> +{
> +	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +	unsigned int max_cores = cpumask_weight(policy->cpus);
> +	struct cpufreq_frequency_table	*table;
> +
> +	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
> +	if (!table)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> +		src = FIELD_GET(LUT_SRC, data);
> +		lval = FIELD_GET(LUT_L_VAL, data);
> +		core_count = FIELD_GET(LUT_CORE_COUNT, data);
> +
> +		if (src)
> +			freq = xo_rate * lval / 1000;
> +		else
> +			freq = cpu_hw_rate / 1000;
> +
> +		/* Ignore boosts in the middle of the table */
> +		if (core_count != max_cores) {
> +			table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +		} else {
> +			table[i].frequency = freq;
> +			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +				freq, core_count);
> +		}
> +
> +		/*
> +		 * Two of the same frequencies with the same core counts means
> +		 * end of table
> +		 */
> +		if (i > 0 && prev_freq == freq && prev_cc == core_count) {
> +			struct cpufreq_frequency_table *prev = &table[i - 1];
> +
> +			/*
> +			 * Only treat the last frequency that might be a boost
> +			 * as the boost frequency
> +			 */
> +			if (prev_cc != max_cores) {
> +				prev->frequency = prev_freq;
> +				prev->flags = CPUFREQ_BOOST_FREQ;
> +			}
> +
> +			break;
> +		}
> +
> +		prev_cc = core_count;
> +		prev_freq = freq;
> +	}
> +
> +	table[i].frequency = CPUFREQ_TABLE_END;
> +	policy->freq_table = table;
> +
> +	return 0;
> +}
> +
> +static void qcom_get_related_cpus(int index, struct cpumask *m)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	int cpu, ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +						 "#freq-domain-cells", 0,
> +						 &args);
> +		of_node_put(cpu_np);
> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0])
> +			cpumask_set_cpu(cpu, m);
> +	}
> +}
> +
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct device *dev = &global_pdev->dev;
> +	struct of_phandle_args args;
> +	struct device_node *cpu_np;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret, index;
> +
> +	cpu_np = of_cpu_device_node_get(policy->cpu);
> +	if (!cpu_np)
> +		return -EINVAL;
> +
> +	ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +					 "#freq-domain-cells", 0, &args);
> +	of_node_put(cpu_np);
> +	if (ret)
> +		return ret;
> +
> +	index = args.args[0];
> +
> +	res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!base)
> +		return -ENOMEM;
> +
> +	/* HW should be in enabled state to proceed */
> +	if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> +		dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +
> +	qcom_get_related_cpus(index, policy->cpus);
> +	if (!cpumask_weight(policy->cpus)) {
> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +		ret = -ENOENT;
> +		goto error;
> +	}
> +
> +	policy->driver_data = base + REG_PERF_STATE;
> +
> +	ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to read LUT\n", index);
> +		goto error;
> +	}
> +
> +	policy->fast_switch_possible = true;
> +
> +	return 0;
> +error:
> +	devm_iounmap(dev, base);
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +
> +	kfree(policy->freq_table);
> +	devm_iounmap(&global_pdev->dev, base);
> +
> +	return 0;
> +}
> +
> +static struct freq_attr *qcom_cpufreq_hw_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	&cpufreq_freq_attr_scaling_boost_freqs,
> +	NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= qcom_cpufreq_hw_target_index,
> +	.get		= qcom_cpufreq_hw_get,
> +	.init		= qcom_cpufreq_hw_cpu_init,
> +	.exit		= qcom_cpufreq_hw_cpu_exit,
> +	.fast_switch    = qcom_cpufreq_hw_fast_switch,
> +	.name		= "qcom-cpufreq-hw",
> +	.attr		= qcom_cpufreq_hw_attr,
> +};
> +
> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = clk_get(&pdev->dev, "xo");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	xo_rate = clk_get_rate(clk);
> +	clk_put(clk);
> +
> +	clk = clk_get(&pdev->dev, "alternate");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
> +	clk_put(clk);
> +
> +	global_pdev = pdev;
> +
> +	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> +	if (ret)
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +	else
> +		dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> +
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
> +{
> +	return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
> +}
> +
> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> +	{ .compatible = "qcom,cpufreq-hw" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> +
> +static struct platform_driver qcom_cpufreq_hw_driver = {
> +	.probe = qcom_cpufreq_hw_driver_probe,
> +	.remove = qcom_cpufreq_hw_driver_remove,
> +	.driver = {
> +		.name = "qcom-cpufreq-hw",
> +		.of_match_table = qcom_cpufreq_hw_match,
> +	},
> +};
> +
> +static int __init qcom_cpufreq_hw_init(void)
> +{
> +	return platform_driver_register(&qcom_cpufreq_hw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_hw_init);
> +
> +static void __exit qcom_cpufreq_hw_exit(void)
> +{
> +	platform_driver_unregister(&qcom_cpufreq_hw_driver);
> +}
> +module_exit(qcom_cpufreq_hw_exit);
> +
> +MODULE_DESCRIPTION("QCOM CPUFREQ HW Driver");
> +MODULE_LICENSE("GPL v2");

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
