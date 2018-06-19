Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F05C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53869205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFeMQ9lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53869205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966762AbeFSPaA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:30:00 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43107 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966406AbeFSP35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:29:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so32761plj.10;
        Tue, 19 Jun 2018 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mytgSp/FbhvKC/26GfAI0A19GZKlQ6xjJOoPQg/UAPY=;
        b=lFeMQ9lRkX06lvolCospO5nY9xIebSaLOJaVVFcDXZ/KIIu54wlfFRoIDkKTsOMaMG
         AHJSvtH/N5p0X8i009815xOuHEhYMH75VgDV1MTbqYeN2VAVJ8ByCpm3gVDbnjOtePjN
         wR7ll/ppzceVWJ7jZ+oI2gM5snqMaUpka7XR4ETr70j3Jo5X9kUw33HHgWYZv7Ru/RN+
         E2/9dhtIR9BrQ6nqHa2HVFKs71Oa+Nmbhf9F7doyZf/rCEcxaEPL8zuzk8l/PDbw45wj
         uBDoJlJpWMrIqkI1xm7F3E1NNy6R+EaxIzqOaG6Kj3XpqoaJ9EVNj/hjM+Z6ugo1kjfu
         R1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mytgSp/FbhvKC/26GfAI0A19GZKlQ6xjJOoPQg/UAPY=;
        b=FFJr7DZM2jIrIhOm4P9MQqKNr7OST8pkEFcTEVmTtNl8lWW+lHJz5LLKkyS87+V4MX
         UYPNmhAf9iCIZVoZlWhJK3DexJ0Ia0MBUQYWQu0O0H9CBImRf+gfhpE838KxT9mb7Ibn
         S1II33HpllRVd7NqGn/2+qYYpLMb0DcpiEei6YuqlCHrPS3jGfWBFXW0YqNppFZV1TQs
         XZvQ/wXHFoRs5C4gkGxOYA1QqxN71HWB9fKuPYFnoXfbo4KKL3MrJorDq64ZDGSTk3ti
         2HeAqCm2R4QxdwskMNo4p9AklmBzvZodt3m6c9kq4U6Rs8bgp9hvows/LX58LkXxe/vi
         D2Ig==
X-Gm-Message-State: APt69E1k9v8mNWxJNDLRbv5J1aJ3oo0ROiv+/twc/SNw9+rvH+5GOh+M
        Gy2sBp/5qK23Z1pF77QUCA==
X-Google-Smtp-Source: ADUXVKLVXMOesWyGawyyCtsP6MJOkJmMfwxWcB4A/N8osCwE0ngZxQsvkZVFYoAPq2uiA+WwnXqaPw==
X-Received: by 2002:a17:902:5a09:: with SMTP id q9-v6mr19218364pli.300.1529422196576;
        Tue, 19 Jun 2018 08:29:56 -0700 (PDT)
Received: from arch (host86-168-6-54.range86-168.btcentralplus.com. [86.168.6.54])
        by smtp.gmail.com with ESMTPSA id j21-v6sm13351472pfn.121.2018.06.19.08.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 08:29:56 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:29:27 +0100
From:   Craig Tatlor <ctatlor97@gmail.com>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org
Subject: Re: [PATCH v10 13/14] cpufreq: Add module to register cpufreq on
 Krait CPUs
Message-ID: <20180619152927.GA6139@arch>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
 <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529415925-28915-14-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pvs refuse check is incorrect... With downstream it says it isn't
blown and that it is 11, which also happens on upstream if I import it's
efuse reading code from an older revision, or comment out the check.

Also, I'm still getting my issue about clocks above 2,147,483,647hz
however I think this may be related to the division in the hfpll driver
so I'll have a debug around there.

On Tue, Jun 19, 2018 at 07:15:24PM +0530, Sricharan R wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> [Sricharan: updated to use dev_pm_opp_set_prop_name and
> 	    nvmem apis]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [Thierry Escande: update to add support for opp-supported-hw]
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  [v10] updated to add support for opp-supported-hw given by
>        Thierry Escande <thierry.escande@linaro.org>
> 
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   5 +
>  drivers/cpufreq/qcom-cpufreq.c       | 201 +++++++++++++++++++++++++++++++++++
>  4 files changed, 217 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 7f56fe5..87e5d8d 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -134,6 +134,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	depends on ARCH_OMAP2PLUS
>  	default ARCH_OMAP2PLUS
>  
> +config ARM_QCOM_CPUFREQ
> +	bool "CPUfreq driver for the QCOM SoCs with KRAIT processors"
> +	depends on ARCH_QCOM
> +	select PM_OPP
> +	help
> +	  This enables the CPUFreq driver for Qualcomm SoCs with
> +	  KRAIT processors.
> +
> +	  If in doubt, say N.
> +
>  config ARM_S3C_CPUFREQ
>  	bool
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d24ade..c591e1e 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ)		+= qcom-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 3b585e4..e2e9a99 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -127,6 +127,11 @@
>  	{ .compatible = "ti,am43", },
>  	{ .compatible = "ti,dra7", },
>  
> +	{ .compatible = "qcom,ipq8064", },
> +	{ .compatible = "qcom,apq8064", },
> +	{ .compatible = "qcom,msm8974", },
> +	{ .compatible = "qcom,msm8960", },
> +
>  	{ }
>  };
>  
> diff --git a/drivers/cpufreq/qcom-cpufreq.c b/drivers/cpufreq/qcom-cpufreq.c
> new file mode 100644
> index 0000000..1d4ab54
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include <linux/cpu.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +static void __init get_krait_bin_format_a(int *speed, int *pvs, int *pvs_ver,
> +					  struct nvmem_cell *pvs_nvmem, u8 *buf)
> +{
> +	u32 pte_efuse;
> +
> +	pte_efuse = *((u32 *)buf);
> +
> +	*speed = pte_efuse & 0xf;
> +	if (*speed == 0xf)
> +		*speed = (pte_efuse >> 4) & 0xf;
> +
> +	if (*speed == 0xf) {
> +		*speed = 0;
> +		pr_warn("Speed bin: Defaulting to %d\n", *speed);
> +	} else {
> +		pr_info("Speed bin: %d\n", *speed);
> +	}
> +
> +	*pvs = (pte_efuse >> 10) & 0x7;
> +	if (*pvs == 0x7)
> +		*pvs = (pte_efuse >> 13) & 0x7;
> +
> +	if (*pvs == 0x7) {
> +		*pvs = 0;
> +		pr_warn("PVS bin: Defaulting to %d\n", *pvs);
> +	} else {
> +		pr_info("PVS bin: %d\n", *pvs);
> +	}
> +
> +	kfree(buf);
> +}
> +
> +static void __init get_krait_bin_format_b(int *speed, int *pvs, int *pvs_ver,
> +					  struct nvmem_cell *pvs_nvmem, u8 *buf)
> +{
> +	u32 pte_efuse, redundant_sel;
> +
> +	pte_efuse = *((u32 *)buf);
> +	redundant_sel = (pte_efuse >> 24) & 0x7;
> +	*speed = pte_efuse & 0x7;
> +
> +	/* 4 bits of PVS are in efuse register bits 31, 8-6. */
> +	*pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
> +	*pvs_ver = (pte_efuse >> 4) & 0x3;
> +
> +	switch (redundant_sel) {
> +	case 1:
> +		*speed = (pte_efuse >> 27) & 0xf;
> +		break;
> +	case 2:
> +		*pvs = (pte_efuse >> 27) & 0xf;
> +		break;
> +	}
> +
> +	/* Check SPEED_BIN_BLOW_STATUS */
> +	if (pte_efuse & BIT(3)) {
> +		pr_info("Speed bin: %d\n", *speed);
> +	} else {
> +		pr_warn("Speed bin not set. Defaulting to 0!\n");
> +		*speed = 0;
> +	}
> +
> +	/* Check PVS_BLOW_STATUS */
> +	pte_efuse = *(((u32 *)buf) + 4);
> +	if (pte_efuse) {
> +		pr_info("PVS bin: %d\n", *pvs);
> +	} else {
> +		pr_warn("PVS bin not set. Defaulting to 0!\n");
> +		*pvs = 0;
> +	}
> +
> +	pr_info("PVS version: %d\n", *pvs_ver);
> +	kfree(buf);
> +}
> +
> +static int __init qcom_cpufreq_populate_opps(struct nvmem_cell *pvs_nvmem,
> +					     struct opp_table **tbl1,
> +					     struct opp_table **tbl2)
> +{
> +	int speed = 0, pvs = 0, pvs_ver = 0, cpu, ret;
> +	struct device *cpu_dev;
> +	u8 *buf;
> +	size_t len;
> +	char pvs_name[] = "speedXX-pvsXX-vXX";
> +	u32 hw_version;
> +
> +	buf = nvmem_cell_read(pvs_nvmem, &len);
> +	if (len == 4)
> +		get_krait_bin_format_a(&speed, &pvs, &pvs_ver, pvs_nvmem, buf);
> +	else if (len == 8)
> +		get_krait_bin_format_b(&speed, &pvs, &pvs_ver, pvs_nvmem, buf);
> +	else
> +		pr_warn("Unable to read nvmem data. Defaulting to 0!\n");
> +
> +	snprintf(pvs_name, sizeof(pvs_name), "speed%d-pvs%d-v%d",
> +		 speed, pvs, pvs_ver);
> +
> +	hw_version = (1 << speed);
> +
> +	for (cpu = 0; cpu < num_possible_cpus(); cpu++) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev)
> +			return -ENODEV;
> +
> +		tbl1[cpu] = dev_pm_opp_set_prop_name(cpu_dev, pvs_name);
> +		if (IS_ERR(tbl1[cpu])) {
> +			ret = PTR_ERR(tbl1[cpu]);
> +			tbl1[cpu] = 0;
> +			pr_warn("failed to add OPP name %s\n", pvs_name);
> +			return ret;
> +		}
> +
> +		tbl2[cpu] = dev_pm_opp_set_supported_hw(cpu_dev, &hw_version,
> +							1);
> +		if (IS_ERR(tbl2[cpu])) {
> +			ret = PTR_ERR(tbl2[cpu]);
> +			tbl2[cpu] = 0;
> +			pr_warn("failed to set supported hw version\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init qcom_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	struct nvmem_cell *pvs_nvmem;
> +	struct opp_table *tbl1[NR_CPUS] = { NULL }, *tbl2[NR_CPUS] = { NULL };
> +	int ret, cpu = 0;
> +
> +	cpu_dev = get_cpu_device(0);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> +	if (!np)
> +		return -ENOENT;
> +
> +	if (!of_device_is_compatible(np, "operating-points-v2-krait-cpu")) {
> +		ret = -ENOENT;
> +		goto free_np;
> +	}
> +
> +	pvs_nvmem = of_nvmem_cell_get(np, NULL);
> +	if (IS_ERR(pvs_nvmem)) {
> +		dev_err(cpu_dev, "Could not get nvmem cell\n");
> +		ret = PTR_ERR(pvs_nvmem);
> +		goto free_np;
> +	}
> +
> +	ret = qcom_cpufreq_populate_opps(pvs_nvmem, tbl1, tbl2);
> +	if (ret)
> +		goto free_opp_name;
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		ret = PTR_ERR(pdev);
> +		goto free_opp_name;
> +	}
> +
> +	of_node_put(np);
> +
> +	return 0;
> +
> +free_opp_name:
> +	while (tbl1[cpu]) {
> +		dev_pm_opp_put_prop_name(tbl1[cpu]);
> +		cpu++;
> +	}
> +
> +	cpu = 0;
> +	while (tbl2[cpu]) {
> +		dev_pm_opp_put_supported_hw(tbl2[cpu]);
> +		cpu++;
> +	}
> +
> +free_np:
> +	of_node_put(np);
> +
> +	return ret;
> +}
> +late_initcall(qcom_cpufreq_driver_init);
> +
> +MODULE_DESCRIPTION("Qualcomm CPUfreq driver");
> +MODULE_AUTHOR("Stephen Boyd <sboyd@codeaurora.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 
