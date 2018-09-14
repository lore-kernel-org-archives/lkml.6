Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F8ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2EA20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fTHZZPgy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sa4nt4V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2EA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeINSH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:07:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57690 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeINSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:07:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6F43608C9; Fri, 14 Sep 2018 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536929615;
        bh=PbJ9Qwh6/14CfAMHLYNV1jf8m7MxovqM3biHARCR+L8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTHZZPgywnIlVpaVCnKueqdOpZQCM95sPXRcdJ5OPAWS63mBhECiTTvt6ChcQtHsg
         Pmta2HEdIOeADNWUm0Nxc9T7v2Pk9p0sch6LXRol53q48O+zmk3za0K2MXZOEGztuE
         diYxNgLns/hfzGc4amAP8SrsysfFZPs2X5qVzLe8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3C8EF6081C;
        Fri, 14 Sep 2018 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536929614;
        bh=PbJ9Qwh6/14CfAMHLYNV1jf8m7MxovqM3biHARCR+L8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sa4nt4V15UTG9yFCnlfYF20Wu8TdUu746iZQVEPGvksLrjJPq3B7hogD+TqMBztj5
         MTnXTthAJyueT684QntXUmHfy+P0TaI0339I+My3h3rkPuZZ0WxoysIjrbhNxkAsAo
         qNePWMHe/aq0g2nM7oSiYkhkewF8UJzWYYdf3ARM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Sep 2018 18:23:34 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, georgi.djakov@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, rnayak@codeaurora.org
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
In-Reply-To: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
Message-ID: <66c67d0b0e551aba11a83ce6a840ad29@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 2018-08-02 06:27, Saravana Kannan wrote:
> This driver registers itself as a devfreq device that allows devfreq
> governors to make bandwidth votes for an interconnect path. This allows
> applying various policies for different interconnect paths using 
> devfreq
> governors.
> 
> Example uses:
> * Use the devfreq performance governor to set the CPU to DDR 
> interconnect
>   path for maximum performance.
> * Use the devfreq performance governor to set the GPU to DDR 
> interconnect
>   path for maximum performance.
> * Use the CPU frequency to device frequency mapping governor to scale 
> the
>   DDR frequency based on the needs of the CPUs' current frequency.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++
>  drivers/devfreq/Kconfig                            |  13 +++
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq_icbw.c                     | 116 
> +++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>  create mode 100644 drivers/devfreq/devfreq_icbw.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt
> b/Documentation/devicetree/bindings/devfreq/icbw.txt
> new file mode 100644
> index 0000000..36cf045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
> @@ -0,0 +1,21 @@
> +Interconnect bandwidth device
> +
> +icbw is a device that represents an interconnect path that connects 
> two
> +devices. This device is typically used to vote for BW requirements 
> between
> +two devices. Eg: CPU to DDR, GPU to DDR, etc
> +
> +Required properties:
> +- compatible:		Must be "devfreq-icbw"
> +- interconnects:	Pairs of phandles and interconnect provider specifier
> +			to denote the edge source and destination ports of
> +			the interconnect path. See also:
> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
> +- interconnect-names:	Must have one entry with the name "path".
> +
> +Example:
> +
> +	qcom,cpubw {
> +		compatible = "devfreq-icbw";
> +		interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
> +		interconnect-names = "path";
> +	};
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 3d9ae68..590370e 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -121,6 +121,19 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads
> the usage counts
>            from hardware.
> 
> +config DEVFREQ_ICBW
> +	bool "DEVFREQ device for making bandwidth votes on interconnect 
> paths"
> +	select DEVFREQ_GOV_PERFORMANCE
> +	select DEVFREQ_GOV_POWERSAVE
> +	select DEVFREQ_GOV_USERSPACE
> +	default n
> +	help
> +	  Different devfreq governors use this devfreq device to make
> +	  bandwidth votes for interconnect paths between different devices
> +	  (Eg: CPU to DDR, GPU to DDR, etc). This driver provides a generic
> +	  interface so that the devfreq governors can be shared across SoCs
> +	  and architectures.
> +
>  source "drivers/devfreq/event/Kconfig"
> 
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index e9dc3e9..b302c5cf 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_DEVFREQ_GOV_CPUFREQ_MAP)	+=
> governor_cpufreq_map.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_DEVFREQ_ICBW)		+= devfreq_icbw.o
> 
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/devfreq_icbw.c 
> b/drivers/devfreq/devfreq_icbw.c
> new file mode 100644
> index 0000000..231fb21
> --- /dev/null
> +++ b/drivers/devfreq/devfreq_icbw.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights 
> reserved.
> + */
> +
> +#define pr_fmt(fmt) "icbw: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/devfreq.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/interconnect.h>
> +
> +struct dev_data {
> +	struct icc_path *path;
> +	u32 cur_ab;
> +	u32 cur_pb;
> +	unsigned long gov_ab;
> +	struct devfreq *df;
> +	struct devfreq_dev_profile dp;
> +};
> +
> +static int icbw_target(struct device *dev, unsigned long *freq, u32 
> flags)
> +{
> +	struct dev_data *d = dev_get_drvdata(dev);
> +	int ret;
> +	u32 new_pb = *freq, new_ab = d->gov_ab;
> +
> +	if (d->cur_pb == new_pb && d->cur_ab == new_ab)
> +		return 0;
> +
> +	dev_dbg(dev, "BW KBps: AB: %u PB: %u\n", new_ab, new_pb);
> +
> +	ret = icc_set(d->path, new_ab, new_pb);
> +	if (ret) {
> +		dev_err(dev, "bandwidth request failed (%d)\n", ret);
> +	} else {
> +		d->cur_pb = new_pb;
> +		d->cur_ab = new_ab;
> +	}
> +
> +	return ret;
> +}
> +
> +static int icbw_get_dev_status(struct device *dev,
> +				struct devfreq_dev_status *stat)
> +{
> +	struct dev_data *d = dev_get_drvdata(dev);
> +
> +	stat->private_data = &d->gov_ab;
> +	return 0;
> +}
> +
> +static int devfreq_icbw_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dev_data *d;
> +	struct devfreq_dev_profile *p;
> +
> +	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, d);
> +
> +	p = &d->dp;
> +	p->polling_ms = 50;
> +	p->target = icbw_target;
> +	p->get_dev_status = icbw_get_dev_status;
> +
> +	d->path = of_icc_get(dev, "path");
> +	if (IS_ERR(d->path)) {
> +		dev_err(dev, "Unable to register interconnect path\n");
> +		return -ENODEV;
> +	}

The probe fails if the provider is not registered yet. Worked around it 
using -EPROBE_DEFER
but this should probably come from of_icc_get itself.

> +
> +	d->df = devfreq_add_device(dev, p, "performance", NULL);
> +	if (IS_ERR(d->df)) {
> +		icc_put(d->path);
> +		return PTR_ERR(d->df);
> +	}

devfreq_add_device will fail with -EINVAL for set_table_freq, 
find_available_min_freq and
find_available_max_freq. If you end up working your way around it, I 
still ended up getting
multiple errors like "Couldn't update frequency transition information" 
after probing.

> +
> +	return 0;
> +}
> +
> +static int devfreq_icbw_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dev_data *d = dev_get_drvdata(dev);
> +
> +	devfreq_remove_device(d->df);
> +	icc_put(d->path);
> +	return 0;
> +}
> +
> +static const struct of_device_id icbw_match_table[] = {
> +	{ .compatible = "devfreq-icbw" },
> +	{}
> +};
> +
> +static struct platform_driver icbw_driver = {
> +	.probe = devfreq_icbw_probe,
> +	.remove = devfreq_icbw_remove,
> +	.driver = {
> +		.name = "devfreq-icbw",
> +		.of_match_table = icbw_match_table,
> +	},
> +};
> +
> +module_platform_driver(icbw_driver);
> +MODULE_DESCRIPTION("Interconnect bandwidth voting driver");
> +MODULE_LICENSE("GPL v2");

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
