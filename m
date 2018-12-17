Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C070C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82BF20449
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="jgJys7C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeLQH5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:57:12 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39072 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbeLQH5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:57:12 -0500
Received: by mail-vk1-f193.google.com with SMTP id s184so985495vkd.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuWvjGyIuclnQ7igmTQUgJ0taUWLnu5EzkLjZohievw=;
        b=jgJys7C0k0Cj88gBdS6Ux7JPFER0fTPf2wj+3WXWj0I+7WkSid9gQWV/1V/vsqVTsb
         o2qR0NhQ6HpbLX9/Y/UEyE/wtc5hFnqpsARBAoXtuqNJAlArBv4umG/FS7NI9Dw1MUP3
         4sNG3wfrSWTFL7r5IoBf3r0MRKB1SS+Kcw2bxMHJvoPAWesHR8nuOUCK4/AznJPQabnE
         Omm1e+/538dr9nJOTf7PkVRGD1nYTYoKgYfJesyEuh1lHiy9SSTrkpCaSVpvcKQqs6Fe
         RG0zXWBxC/IW28AsYTFxWQM/Ds4SC4894KHR5xYDggWfqhKcnVEgLaV4dp2bJ3xNoy8d
         cs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuWvjGyIuclnQ7igmTQUgJ0taUWLnu5EzkLjZohievw=;
        b=DXW81slu7/041kS3cwsDhw5PXY/jEHHXzCxnuTmAjwoU/5wF78ZKgX+C2U0Mj8gjTZ
         n1ueH6NBPo2ICVcRZvLa3pX4rOg5YmZHJG0RctKYJVjHNR/C4KDOvpESn8kBgIRzHxSV
         Nt2QyT6gl20TF/BgHLiEnCBHB/1atk//7TaTXyFo9v+oIep61c7YDCocEzMbQ6jF+L1C
         YdDBBL5ai9zt4Y7kSkAoplzrS5eqyCn0IXPxiiHLawX0Eu4PuEfJFwbZcEmOVJC6F2Zg
         HYhyUlsJi83mIzJXKRfGZkr+XFQP5TvX/nAJSNiO4kDeI0EUfTpqYj/2vVF9HyizJOU6
         SyAA==
X-Gm-Message-State: AA+aEWYwIGPDvmoE+uiOf5l4LyCptAU6gmu+9vbTYFKGZdTZhU4RY/Cp
        utRAnyyKMVMb1lSK6HnqY4piftpWuBYRwQosTAcAPw==
X-Google-Smtp-Source: AFSGD/Wmk0bxxZSX39Dcz7wtb8oePZtuPhNvmN8PEwLgz78ZgcggmDaY/jThIhT8S5E/AHI6g2NxtHpGVkmlf/j0eps=
X-Received: by 2002:a1f:a8c5:: with SMTP id r188mr5402651vke.44.1545033430489;
 Sun, 16 Dec 2018 23:57:10 -0800 (PST)
MIME-Version: 1.0
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 17 Dec 2018 13:26:58 +0530
Message-ID: <CAHLCerO_pfPRjv+APKMjd_uw4q=xoyunoSJJi8kOFRQhBc-NHw@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 9:40 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

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
>           If in doubt, say N.
>
> +config ARM_QCOM_CPUFREQ_HW
> +       tristate "QCOM CPUFreq HW driver"
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       help
> +         Support for the CPUFreq HW driver.
> +         Some QCOM chipsets have a HW engine to offload the steps
> +         necessary for changing the frequency of the CPUs. Firmware loaded
> +         in this engine exposes a programming interface to the OS.
> +         The driver implements the cpufreq interface for this HW engine.
> +         Say Y if you want to support CPUFreq HW.
> +
>  config ARM_S3C_CPUFREQ
>         bool
>         help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index d5ee456..08c071b 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)           += mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)    += omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)       += pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)                   += pxa3xx-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_HW)      += qcom-cpufreq-hw.o
>  obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)    += qcom-cpufreq-kryo.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)      += s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)      += s3c2412-cpufreq.o
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
> +#define LUT_MAX_ENTRIES                        40U
> +#define LUT_SRC                                GENMASK(31, 30)
> +#define LUT_L_VAL                      GENMASK(7, 0)
> +#define LUT_CORE_COUNT                 GENMASK(18, 16)
> +#define LUT_ROW_SIZE                   32
> +#define CLK_HW_DIV                     2
> +
> +/* Register offsets */
> +#define REG_ENABLE                     0x0
> +#define REG_LUT_TABLE                  0x110
> +#define REG_PERF_STATE                 0x920
> +
> +static unsigned long cpu_hw_rate, xo_rate;
> +static struct platform_device *global_pdev;
> +
> +static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +                                       unsigned int index)
> +{
> +       void __iomem *perf_state_reg = policy->driver_data;
> +
> +       writel_relaxed(index, perf_state_reg);
> +
> +       return 0;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
> +{
> +       void __iomem *perf_state_reg;
> +       struct cpufreq_policy *policy;
> +       unsigned int index;
> +
> +       policy = cpufreq_cpu_get_raw(cpu);
> +       if (!policy)
> +               return 0;
> +
> +       perf_state_reg = policy->driver_data;
> +
> +       index = readl_relaxed(perf_state_reg);
> +       index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +       return policy->freq_table[index].frequency;
> +}
> +
> +static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +                                               unsigned int target_freq)
> +{
> +       void __iomem *perf_state_reg = policy->driver_data;
> +       int index;
> +
> +       index = policy->cached_resolved_idx;
> +       if (index < 0)
> +               return 0;
> +
> +       writel_relaxed(index, perf_state_reg);
> +
> +       return policy->freq_table[index].frequency;
> +}
> +
> +static int qcom_cpufreq_hw_read_lut(struct device *dev,
> +                                   struct cpufreq_policy *policy,
> +                                   void __iomem *base)
> +{
> +       u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +       unsigned int max_cores = cpumask_weight(policy->cpus);
> +       struct cpufreq_frequency_table  *table;
> +
> +       table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
> +       if (!table)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +               data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> +               src = FIELD_GET(LUT_SRC, data);
> +               lval = FIELD_GET(LUT_L_VAL, data);
> +               core_count = FIELD_GET(LUT_CORE_COUNT, data);
> +
> +               if (src)
> +                       freq = xo_rate * lval / 1000;
> +               else
> +                       freq = cpu_hw_rate / 1000;
> +
> +               /* Ignore boosts in the middle of the table */
> +               if (core_count != max_cores) {
> +                       table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +               } else {
> +                       table[i].frequency = freq;
> +                       dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +                               freq, core_count);
> +               }
> +
> +               /*
> +                * Two of the same frequencies with the same core counts means
> +                * end of table
> +                */
> +               if (i > 0 && prev_freq == freq && prev_cc == core_count) {
> +                       struct cpufreq_frequency_table *prev = &table[i - 1];
> +
> +                       /*
> +                        * Only treat the last frequency that might be a boost
> +                        * as the boost frequency
> +                        */
> +                       if (prev_cc != max_cores) {
> +                               prev->frequency = prev_freq;
> +                               prev->flags = CPUFREQ_BOOST_FREQ;
> +                       }
> +
> +                       break;
> +               }
> +
> +               prev_cc = core_count;
> +               prev_freq = freq;
> +       }
> +
> +       table[i].frequency = CPUFREQ_TABLE_END;
> +       policy->freq_table = table;
> +
> +       return 0;
> +}
> +
> +static void qcom_get_related_cpus(int index, struct cpumask *m)
> +{
> +       struct device_node *cpu_np;
> +       struct of_phandle_args args;
> +       int cpu, ret;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpu_np = of_cpu_device_node_get(cpu);
> +               if (!cpu_np)
> +                       continue;
> +
> +               ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +                                                "#freq-domain-cells", 0,
> +                                                &args);
> +               of_node_put(cpu_np);
> +               if (ret < 0)
> +                       continue;
> +
> +               if (index == args.args[0])
> +                       cpumask_set_cpu(cpu, m);
> +       }
> +}
> +
> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct device *dev = &global_pdev->dev;
> +       struct of_phandle_args args;
> +       struct device_node *cpu_np;
> +       struct resource *res;
> +       void __iomem *base;
> +       int ret, index;
> +
> +       cpu_np = of_cpu_device_node_get(policy->cpu);
> +       if (!cpu_np)
> +               return -EINVAL;
> +
> +       ret = of_parse_phandle_with_args(cpu_np, "qcom,freq-domain",
> +                                        "#freq-domain-cells", 0, &args);
> +       of_node_put(cpu_np);
> +       if (ret)
> +               return ret;
> +
> +       index = args.args[0];
> +
> +       res = platform_get_resource(global_pdev, IORESOURCE_MEM, index);
> +       if (!res)
> +               return -ENODEV;
> +
> +       base = devm_ioremap(dev, res->start, resource_size(res));
> +       if (!base)
> +               return -ENOMEM;
> +
> +       /* HW should be in enabled state to proceed */
> +       if (!(readl_relaxed(base + REG_ENABLE) & 0x1)) {
> +               dev_err(dev, "Domain-%d cpufreq hardware not enabled\n", index);
> +               ret = -ENODEV;
> +               goto error;
> +       }
> +
> +       qcom_get_related_cpus(index, policy->cpus);
> +       if (!cpumask_weight(policy->cpus)) {
> +               dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +               ret = -ENOENT;
> +               goto error;
> +       }
> +
> +       policy->driver_data = base + REG_PERF_STATE;
> +
> +       ret = qcom_cpufreq_hw_read_lut(dev, policy, base);
> +       if (ret) {
> +               dev_err(dev, "Domain-%d failed to read LUT\n", index);
> +               goto error;
> +       }
> +
> +       policy->fast_switch_possible = true;
> +
> +       return 0;
> +error:
> +       devm_iounmap(dev, base);
> +       return ret;
> +}
> +
> +static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       void __iomem *base = policy->driver_data - REG_PERF_STATE;
> +
> +       kfree(policy->freq_table);
> +       devm_iounmap(&global_pdev->dev, base);
> +
> +       return 0;
> +}
> +
> +static struct freq_attr *qcom_cpufreq_hw_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       &cpufreq_freq_attr_scaling_boost_freqs,
> +       NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> +       .flags          = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +                         CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +       .verify         = cpufreq_generic_frequency_table_verify,
> +       .target_index   = qcom_cpufreq_hw_target_index,
> +       .get            = qcom_cpufreq_hw_get,
> +       .init           = qcom_cpufreq_hw_cpu_init,
> +       .exit           = qcom_cpufreq_hw_cpu_exit,
> +       .fast_switch    = qcom_cpufreq_hw_fast_switch,
> +       .name           = "qcom-cpufreq-hw",
> +       .attr           = qcom_cpufreq_hw_attr,
> +};
> +
> +static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +       struct clk *clk;
> +       int ret;
> +
> +       clk = clk_get(&pdev->dev, "xo");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       xo_rate = clk_get_rate(clk);
> +       clk_put(clk);
> +
> +       clk = clk_get(&pdev->dev, "alternate");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       cpu_hw_rate = clk_get_rate(clk) / CLK_HW_DIV;
> +       clk_put(clk);
> +
> +       global_pdev = pdev;
> +
> +       ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> +       if (ret)
> +               dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +       else
> +               dev_dbg(&pdev->dev, "QCOM CPUFreq HW driver initialized\n");
> +
> +       return ret;
> +}
> +
> +static int qcom_cpufreq_hw_driver_remove(struct platform_device *pdev)
> +{
> +       return cpufreq_unregister_driver(&cpufreq_qcom_hw_driver);
> +}
> +
> +static const struct of_device_id qcom_cpufreq_hw_match[] = {
> +       { .compatible = "qcom,cpufreq-hw" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_cpufreq_hw_match);
> +
> +static struct platform_driver qcom_cpufreq_hw_driver = {
> +       .probe = qcom_cpufreq_hw_driver_probe,
> +       .remove = qcom_cpufreq_hw_driver_remove,
> +       .driver = {
> +               .name = "qcom-cpufreq-hw",
> +               .of_match_table = qcom_cpufreq_hw_match,
> +       },
> +};
> +
> +static int __init qcom_cpufreq_hw_init(void)
> +{
> +       return platform_driver_register(&qcom_cpufreq_hw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_hw_init);
> +
> +static void __exit qcom_cpufreq_hw_exit(void)
> +{
> +       platform_driver_unregister(&qcom_cpufreq_hw_driver);
> +}
> +module_exit(qcom_cpufreq_hw_exit);
> +
> +MODULE_DESCRIPTION("QCOM CPUFREQ HW Driver");
> +MODULE_LICENSE("GPL v2");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
