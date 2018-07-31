Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFAAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449E1208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RoBdZkmb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OD7/Iw5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449E1208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbeGaOk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:40:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732080AbeGaOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:40:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0B016071C; Tue, 31 Jul 2018 13:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533042044;
        bh=Z2MUjHHPtX+GN6s9vOTKRHcb+2g3fGQz1E2OlO/iMJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RoBdZkmbxsnTmhQgfaHTEm8+79pm1Dlh92spKSTI2c+Z+C9FLG+B5+bk3BJ05KjAh
         3C2VjIuXIiUMwBlZ6y78/Xm2hgEW11J/X9aTJcDUu2YP3oNECLUCEFH3DprlXFgm01
         L3/DwJIrcPkm1qP8QyZxpepn8xI7TIUA1e9lBy5c=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AC7360264;
        Tue, 31 Jul 2018 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533042043;
        bh=Z2MUjHHPtX+GN6s9vOTKRHcb+2g3fGQz1E2OlO/iMJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OD7/Iw5KjRMk/OaeVjOE+mYjpX7XdxVe3vQ15XfTW92t/JeA0Pq3fcwvAoNKRGbSa
         3f79RjTOGuk+VdDl+3KfTriZm4B6F6JHBEEzdMsuof0QgPsXuSJUuoOFFKBWNC4Ck9
         HXW03LkXEtZ/xCSXdET7tL/rijrZNHjCAXRFBcZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AC7360264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH 2/4] reset: qcom: PDC (Power Domain Controller) reset
 controller
To:     Philipp Zabel <p.zabel@pengutronix.de>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-2-sibis@codeaurora.org>
 <1533027087.3444.7.camel@pengutronix.de>
From:   Sibi S <sibis@codeaurora.org>
Message-ID: <72f17bfc-9b19-7cfa-2aa7-8d45cd1ed39e@codeaurora.org>
Date:   Tue, 31 Jul 2018 18:30:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533027087.3444.7.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,
Thanks for the review!

On 07/31/2018 02:21 PM, Philipp Zabel wrote:
> On Fri, 2018-07-27 at 20:58 +0530, Sibi Sankar wrote:
>> Add reset controller for SDM845 SoC to control reset signals
>> provided by PDC for Modem, Compute, Display, GPU, Debug, AOP,
>> Sensors, Audio, SP and APPS
>>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>   drivers/reset/Kconfig          |   9 +++
>>   drivers/reset/Makefile         |   1 +
>>   drivers/reset/reset-qcom-pdc.c | 139 +++++++++++++++++++++++++++++++++
>>   3 files changed, 149 insertions(+)
>>   create mode 100644 drivers/reset/reset-qcom-pdc.c
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 13d28fdbdbb5..5344e202a630 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -98,6 +98,15 @@ config RESET_QCOM_AOSS
>>   	  reset signals provided by AOSS for Modem, Venus, ADSP,
>>   	  GPU, Camera, Wireless, Display subsystem. Otherwise, say N.
>>   
>> +config RESET_QCOM_PDC
>> +	bool "Qcom PDC Reset Driver"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  This enables the PDC (Power Domain Controller) reset driver
>> +	  for Qualcomm Technologies Inc SDM845 SoCs. Say Y if you want
>> +	  to control reset signals provided by PDC for Modem, Compute,
>> +	  Display, GPU, Debug, AOP, Sensors, Audio, SP and APPS.
>> +
>>   config RESET_SIMPLE
>>   	bool "Simple Reset Controller Driver" if COMPILE_TEST
>>   	default ARCH_SOCFPGA || ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 4243c38228e2..d08e8b90046a 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>>   obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
>>   obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
>>   obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
>> +obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
>>   obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
>>   obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
>>   obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>> diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
>> new file mode 100644
>> index 000000000000..64a0041e3452
>> --- /dev/null
>> +++ b/drivers/reset/reset-qcom-pdc.c
>> @@ -0,0 +1,139 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of_device.h>
>> +#include <dt-bindings/reset/qcom,sdm845-pdc.h>
>> +
>> +struct qcom_pdc_reset_map {
>> +	u8 bit;
>> +};
>> +
>> +struct qcom_pdc_desc {
>> +	const struct regmap_config *config;
>> +	const struct qcom_pdc_reset_map *resets;
>> +	size_t num_resets;
>> +};
>> +
>> +struct qcom_pdc_reset_data {
>> +	struct reset_controller_dev rcdev;
>> +	struct regmap *regmap;
>> +	const struct qcom_pdc_desc *desc;
>> +};
>> +
>> +static const struct regmap_config sdm845_pdc_regmap_config = {
>> +	.name		= "pdc-reset",
>> +	.reg_bits	= 32,
>> +	.reg_stride	= 4,
>> +	.val_bits	= 32,
>> +	.max_register	= 0x20000,
>> +	.fast_io	= true,
>> +};
>> +
>> +static const struct qcom_pdc_reset_map sdm845_pdc_resets[] = {
>> +	[PDC_APPS_SYNC_RESET] = {0},
>> +	[PDC_SP_SYNC_RESET] = {1},
>> +	[PDC_AUDIO_SYNC_RESET] = {2},
>> +	[PDC_SENSORS_SYNC_RESET] = {3},
>> +	[PDC_AOP_SYNC_RESET] = {4},
>> +	[PDC_DEBUG_SYNC_RESET] = {5},
>> +	[PDC_GPU_SYNC_RESET] = {6},
>> +	[PDC_DISPLAY_SYNC_RESET] = {7},
>> +	[PDC_COMPUTE_SYNC_RESET] = {8},
>> +	[PDC_MODEM_SYNC_RESET] = {9},
>> +};
>> +
>> +static const struct qcom_pdc_desc sdm845_pdc_desc = {
>> +	.config = &sdm845_pdc_regmap_config,
>> +	.resets = sdm845_pdc_resets,
>> +	.num_resets = ARRAY_SIZE(sdm845_pdc_resets),
>> +};
>> +
>> +static inline struct qcom_pdc_reset_data *to_qcom_pdc_reset_data(
>> +				struct reset_controller_dev *rcdev)
>> +{
>> +	return container_of(rcdev, struct qcom_pdc_reset_data, rcdev);
>> +}
>> +
>> +static int qcom_pdc_control_assert(struct reset_controller_dev *rcdev,
>> +					unsigned long idx)
>> +{
>> +	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
>> +	const struct qcom_pdc_reset_map *map = &data->desc->resets[idx];
>> +
>> +	return regmap_update_bits(data->regmap, 0x100,
> 
> Does this register have a name? If so, a #define would be preferable.
> Otherwise this driver looks fine to me.
> 

Yes will had a separate #define for it.

>> +					BIT(map->bit), BIT(map->bit));
>> +}
>> +
>> +static int qcom_pdc_control_deassert(struct reset_controller_dev *rcdev,
>> +					unsigned long idx)
>> +{
>> +	struct qcom_pdc_reset_data *data = to_qcom_pdc_reset_data(rcdev);
>> +	const struct qcom_pdc_reset_map *map = &data->desc->resets[idx];
>> +
>> +	return regmap_update_bits(data->regmap, 0x100, BIT(map->bit), 0);
>> +}
>> +
>> +static const struct reset_control_ops qcom_pdc_reset_ops = {
>> +	.assert = qcom_pdc_control_assert,
>> +	.deassert = qcom_pdc_control_deassert,
>> +};
>> +
>> +static int qcom_pdc_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct qcom_pdc_reset_data *data;
>> +	struct device *dev = &pdev->dev;
>> +	const struct qcom_pdc_desc *desc;
>> +	void __iomem *base;
>> +	struct resource *res;
>> +
>> +	desc = of_device_get_match_data(dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->desc = desc;
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	data->regmap = devm_regmap_init_mmio(dev, base, desc->config);
>> +	if (IS_ERR(data->regmap)) {
>> +		dev_err(dev, "Unable to get pdc-global regmap");
>> +		return PTR_ERR(data->regmap);
>> +	}
>> +
>> +	data->rcdev.owner = THIS_MODULE;
>> +	data->rcdev.ops = &qcom_pdc_reset_ops;
>> +	data->rcdev.nr_resets = desc->num_resets;
>> +	data->rcdev.of_node = dev->of_node;
>> +
>> +	return devm_reset_controller_register(dev, &data->rcdev);
>> +}
>> +
>> +static const struct of_device_id qcom_pdc_reset_of_match[] = {
>> +	{ .compatible = "qcom,sdm845-pdc-global", .data = &sdm845_pdc_desc },
>> +	{}
>> +};
>> +
>> +static struct platform_driver qcom_pdc_reset_driver = {
>> +	.probe = qcom_pdc_reset_probe,
>> +	.driver = {
>> +		.name = "qcom_pdc_reset",
>> +		.of_match_table = qcom_pdc_reset_of_match,
>> +	},
>> +};
>> +
>> +builtin_platform_driver(qcom_pdc_reset_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm PDC Reset Driver");
>> +MODULE_LICENSE("GPL v2");
> 
> regards
> Philipp
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
