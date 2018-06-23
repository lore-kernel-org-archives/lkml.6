Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A81C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1475724A50
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNwzfo9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1475724A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeFWAoJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:44:09 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934489AbeFWAoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:44:07 -0400
Received: by mail-pg0-f65.google.com with SMTP id r21-v6so3644025pgv.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yDLAwaRpuA3UkijOdJXbauhTVLbnt63CLMjQ9DWJ2/M=;
        b=VNwzfo9GquTNiK2wyOIzvrSoLwxgYGY3VI4ikCZ5J9KNpGz09JfiG6xeo20zturdvu
         Guf2e5SOmFz7A1ET2eSuK5Ca66vGKc2QyOAQnov3igRS6i8J5uPuydpYmPvtk/tbeLVf
         zwc7ysPqWGqIk5qGjSEzyBRVCihWV9oJIJ11U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yDLAwaRpuA3UkijOdJXbauhTVLbnt63CLMjQ9DWJ2/M=;
        b=pI8/4JvAQTJTJucxqE92FK1uKjcyZEE3vZ6CNbvixqwggQuZBYcUd52IvZLCpvyaej
         59MhjLU94x9P6zaG1QNNwbuz/qg3VYK0ydngisBJc9tiTTSDDVoLYnQPlvvVhmwYP9N5
         ft/LSvefNWgUDwP5Zy+JOguIzYc1H1ikdY1haQTDQFWwS76135k9HCVGRnIzmIEOp342
         3B6cZxYjnM4nOlpILzWOYx3//SuEiSBnHyTmILgo+tfo5xRcZAaXB0guJ73vVfkCcWRO
         Y5ULgkcGGBEGI+2F60Dgj0uf5FGj2IWoHUsapXDLMCWHGtJJPdpIoJPXoDr/LDxS+HvS
         PDWw==
X-Gm-Message-State: APt69E29XV2fVW1wYJiLFIR28RRS0FzUHIuX+IsdszbuJQd2G4+18T/h
        381xLd6Sci7tZvyDxRtj4fYQ9w==
X-Google-Smtp-Source: ADUXVKI2EemLY3RXDS8sWk6EU+0CP0yGVtz8jDl1Lje37HqoCfgGLZd76g+nbLGIUq+jhiRi32Bq6w==
X-Received: by 2002:a63:8dca:: with SMTP id z193-v6mr3172541pgd.451.1529714646243;
        Fri, 22 Jun 2018 17:44:06 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y23-v6sm18509614pfa.73.2018.06.22.17.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 17:44:05 -0700 (PDT)
Date:   Fri, 22 Jun 2018 17:46:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v5 2/8] reset: qcom: AOSS (always on subsystem) reset
 controller
Message-ID: <20180623004626.GR3402@tuxbook-pro>
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-3-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521172714.8551-3-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 May 10:27 PDT 2018, Sibi Sankar wrote:

> Add reset controller driver for Qualcomm SDM845 SoC to
> control reset signals provided by AOSS for Modem, Venus
> ADSP, GPU, Camera, Wireless, Display subsystem
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

With the adaptions discussed in the DT binding patch (compatible and
register offsets) you have my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/reset/Kconfig           |   9 +++
>  drivers/reset/Makefile          |   1 +
>  drivers/reset/reset-qcom-aoss.c | 133 ++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>  create mode 100644 drivers/reset/reset-qcom-aoss.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index c0b292be1b72..756ad2b27d0f 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -82,6 +82,15 @@ config RESET_PISTACHIO
>  	help
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
> +config RESET_QCOM_AOSS
> +	bool "Qcom AOSS Reset Driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This enables the AOSS (always on subsystem) reset driver
> +	  for Qualcomm SDM845 SoCs. Say Y if you want to control
> +	  reset signals provided by AOSS for Modem, Venus, ADSP,
> +	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
> +
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
>  	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index c1261dcfe9ad..6881e4d287f0 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>  obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
> +obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>  obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>  obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
> new file mode 100644
> index 000000000000..d9ca7339c434
> --- /dev/null
> +++ b/drivers/reset/reset-qcom-aoss.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +
> +struct qcom_aoss_reset_map {
> +	unsigned int reg;
> +};
> +
> +struct qcom_aoss_desc {
> +	const struct qcom_aoss_reset_map *resets;
> +	size_t num_resets;
> +};
> +
> +struct qcom_aoss_reset_data {
> +	struct reset_controller_dev rcdev;
> +	void __iomem *base;
> +	const struct qcom_aoss_desc *desc;
> +};
> +
> +static const struct qcom_aoss_reset_map sdm845_aoss_resets[] = {
> +	[AOSS_CC_MSS_RESTART] = {0x0},
> +	[AOSS_CC_CAMSS_RESTART] = {0x1000},
> +	[AOSS_CC_VENUS_RESTART] = {0x2000},
> +	[AOSS_CC_GPU_RESTART] = {0x3000},
> +	[AOSS_CC_DISPSS_RESTART] = {0x4000},
> +	[AOSS_CC_WCSS_RESTART] = {0x10000},
> +	[AOSS_CC_LPASS_RESTART] = {0x20000},
> +};
> +
> +static const struct qcom_aoss_desc sdm845_aoss_desc = {
> +	.resets = sdm845_aoss_resets,
> +	.num_resets = ARRAY_SIZE(sdm845_aoss_resets),
> +};
> +
> +static inline struct qcom_aoss_reset_data *to_qcom_aoss_reset_data(
> +				struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct qcom_aoss_reset_data, rcdev);
> +}
> +
> +static int qcom_aoss_control_assert(struct reset_controller_dev *rcdev,
> +				    unsigned long idx)
> +{
> +	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
> +	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
> +
> +	writel(1, data->base + map->reg);
> +	/* Wait 6 32kHz sleep cycles for reset */
> +	usleep_range(200, 300);
> +	return 0;
> +}
> +
> +static int qcom_aoss_control_deassert(struct reset_controller_dev *rcdev,
> +				      unsigned long idx)
> +{
> +	struct qcom_aoss_reset_data *data = to_qcom_aoss_reset_data(rcdev);
> +	const struct qcom_aoss_reset_map *map = &data->desc->resets[idx];
> +
> +	writel(0, data->base + map->reg);
> +	/* Wait 6 32kHz sleep cycles for reset */
> +	usleep_range(200, 300);
> +	return 0;
> +}
> +
> +static int qcom_aoss_control_reset(struct reset_controller_dev *rcdev,
> +					unsigned long idx)
> +{
> +	qcom_aoss_control_assert(rcdev, idx);
> +
> +	return qcom_aoss_control_deassert(rcdev, idx);
> +}
> +
> +static const struct reset_control_ops qcom_aoss_reset_ops = {
> +	.reset = qcom_aoss_control_reset,
> +	.assert = qcom_aoss_control_assert,
> +	.deassert = qcom_aoss_control_deassert,
> +};
> +
> +static int qcom_aoss_reset_probe(struct platform_device *pdev)
> +{
> +	struct qcom_aoss_reset_data *data;
> +	struct device *dev = &pdev->dev;
> +	const struct qcom_aoss_desc *desc;
> +	struct resource *res;
> +
> +	desc = of_device_get_match_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->desc = desc;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(data->base))
> +		return PTR_ERR(data->base);
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.ops = &qcom_aoss_reset_ops;
> +	data->rcdev.nr_resets = desc->num_resets;
> +	data->rcdev.of_node = dev->of_node;
> +
> +	return devm_reset_controller_register(dev, &data->rcdev);
> +}
> +
> +static const struct of_device_id qcom_aoss_reset_of_match[] = {
> +	{ .compatible = "qcom,sdm845-aoss-reset", .data = &sdm845_aoss_desc },
> +	{}
> +};
> +
> +static struct platform_driver qcom_aoss_reset_driver = {
> +	.probe = qcom_aoss_reset_probe,
> +	.driver  = {
> +		.name = "qcom_aoss_reset",
> +		.of_match_table = qcom_aoss_reset_of_match,
> +	},
> +};
> +
> +builtin_platform_driver(qcom_aoss_reset_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm AOSS Reset Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
