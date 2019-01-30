Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2781EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56762082C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mt1rbyKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfA3Jxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:53:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40068 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfA3Jxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:53:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so20784335wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dpepguYKa93uvnR9U774spYX7Jjb1lKwQhQj5NL8T8o=;
        b=Mt1rbyKoGoxQYnEWLFHU3eq8avrS5CPT+Ek81W4bOApyp/KHaPJuetQOhiVgwwhe9O
         cSsokr6elQvFfPTX+afMgVyp0HtyhtVVMqgEyypjAhBOxnSvPs0Xpp6+kpOSjnAv3upo
         f1k3rZdIrzUIkt4peOnsHE9aQPuj5/wgY/ITs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dpepguYKa93uvnR9U774spYX7Jjb1lKwQhQj5NL8T8o=;
        b=tacanGyA/D+XY+FSHpCvgGa3tM7+/K3wlLGbjCZ+SvA3O18U3AqfkEOyfpo1MmzHlS
         l5r1GNjVyAf0ifMrvxyjiblrq20hw1xEXBvSpShXNbY0nhzqinTfIzG3TA2ND6IH21YY
         H8D5u4YFimEGKLAk2+hountfuxjXDFRGELwvEcrbEVtcOn/UgQEnW9yxUU3VHff0T1+g
         QXnUlC+KenkSCF5xQBI4qK3NC1N6Idp4FnThv+CeNuAYxmscW0JPCksR2AWKSAcNLDlr
         W2exMUwCqHwIUQ30H8hwB1xPrkTE7tFUjXt7Idgedx7f39iFrMIYfRq9Nt7xm/L5PZ8B
         z8Aw==
X-Gm-Message-State: AJcUukd0CCIMIBNO2O9LlZOrK+oxQYHe7yTfoIDytb89RF72GaDGyMlY
        SwRKZsEq0r31/NuREJiNeXQu2sbsrPE=
X-Google-Smtp-Source: ALg8bN68jFqOKOKYbDdVyzzHZFayG4Pd/yCnV6XLbBUaBk1F9G3f6bYb012FxUfcrUaNkvX0Vdl6pg==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr26117385wmf.18.1548842014776;
        Wed, 30 Jan 2019 01:53:34 -0800 (PST)
Received: from [192.168.1.2] (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id x81sm1125240wmg.17.2019.01.30.01.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:53:34 -0800 (PST)
Subject: Re: [PATCH v2 2/2] phy: qualcomm: usb: Add Super-Speed PHY driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org,
        shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190129202726.GA3036@builder>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <fbd70494-e2f1-ae04-8b14-2cc97cead8b9@linaro.org>
Date:   Wed, 30 Jan 2019 10:53:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190129202726.GA3036@builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 21:27, Bjorn Andersson wrote:
> On Tue 29 Jan 03:35 PST 2019, Jorge Ramirez-Ortiz wrote:
>> diff --git a/drivers/phy/qualcomm/phy-qcom-usb-ss.c b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>> new file mode 100644
>> index 0000000..e6ae96e
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-usb-ss.c
>> @@ -0,0 +1,347 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2012-2014,2017 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2018, Linaro Limited
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +#define PHY_CTRL0			0x6C
>> +#define PHY_CTRL1			0x70
>> +#define PHY_CTRL2			0x74
>> +#define PHY_CTRL4			0x7C
>> +
>> +/* PHY_CTRL bits */
>> +#define REF_PHY_EN			BIT(0)
>> +#define LANE0_PWR_ON			BIT(2)
>> +#define SWI_PCS_CLK_SEL			BIT(4)
>> +#define TST_PWR_DOWN			BIT(4)
>> +#define PHY_RESET			BIT(7)
>> +
>> +enum phy_vdd_ctrl { ENABLE, DISABLE, };
> 
> Use bool to describe boolean values.

um, ok, but these are not booleans, they are actions (ie ctrl = action
not true or false).

anyway will change it to something else

> 
>> +enum phy_regulator { VDD, VDDA1P8, };
> 
> It doesn't look like you need either of these if you remove the
> set_voltage calls.

we need to point to the regulator in the array so we need an index to it
somehow.

> 
>> +
>> +struct ssphy_priv {
>> +	void __iomem *base;
>> +	struct device *dev;
>> +	struct reset_control *reset_com;
>> +	struct reset_control *reset_phy;
>> +	struct regulator *vbus;
>> +	struct regulator_bulk_data *regs;
>> +	int num_regs;
>> +	struct clk_bulk_data *clks;
>> +	int num_clks;
>> +	enum phy_mode mode;
>> +};
>> +
>> +static inline void qcom_ssphy_updatel(void __iomem *addr, u32 mask, u32 val)
>> +{
>> +	writel((readl(addr) & ~mask) | val, addr);
>> +}
>> +
>> +static inline int qcom_ssphy_vbus_enable(struct regulator *vbus)
>> +{
>> +	return !regulator_is_enabled(vbus) ? regulator_enable(vbus) : 0;
> 
> regulator_is_enabled() will check if the actual regulator is on, not if
> you already voted for it.
> 
> So if something else is enabling the vbus regulator you will skip your
> enable and be in the mercy of them not releasing it. Presumably there's
> only one consumer of this particular regulator, but it's a bad habit.

yep

> 
> Please keep track of this drivers requested state in this driver, if
> qcom_ssphy_vbus_ctrl() is called not only for the state changes.

um, there is not such a function: the ctrl function is not for vbus but
for vdd

> 
>> +}
>> +
>> +static inline int qcom_ssphy_vbus_disable(struct regulator *vbus)
>> +{
>> +	return regulator_is_enabled(vbus) ? regulator_disable(vbus) : 0;
>> +}
>> +
>> +static int qcom_ssphy_vdd_ctrl(struct ssphy_priv *priv, enum phy_vdd_ctrl ctrl)
> 
> As discussed on IRC, I think you should just leave the voltage
> constraints to DeviceTree.

yes

> 
>> +{
>> +	const int vdd_min = ctrl == ENABLE ? 1050000 : 0;
>> +	const int vdd_max = 1050000;
>> +	int ret;
>> +
>> +	ret = regulator_set_voltage(priv->regs[VDD].consumer, vdd_min, vdd_max);
>> +	if (ret)
>> +		dev_err(priv->dev, "Failed to set regulator vdd to %d\n",
>> +			vdd_min);
>> +
>> +	return ret;
>> +}
> [..]
>> +static int qcom_ssphy_power_on(struct phy *phy)
>> +{
>> +	struct ssphy_priv *priv = phy_get_drvdata(phy);
>> +	int ret;
>> +
>> +	ret = qcom_ssphy_vdd_ctrl(priv, ENABLE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regulator_bulk_enable(priv->num_regs, priv->regs);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
>> +	if (ret)
>> +		goto err2;
>> +
>> +	ret = qcom_ssphy_vbus_ctrl(priv->vbus, priv->mode);
>> +	if (ret)
>> +		goto err3;
>> +
>> +	ret = qcom_ssphy_do_reset(priv);
>> +	if (ret)
>> +		goto err4;
>> +
>> +	writeb(SWI_PCS_CLK_SEL, priv->base + PHY_CTRL0);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, LANE0_PWR_ON);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, REF_PHY_EN);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, 0);
>> +
>> +	return 0;
>> +err4:
> 
> Name your labels based on what they do, e.g. err_disable_vbus.

ok

> 
>> +	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
>> +		qcom_ssphy_vbus_disable(priv->vbus);
> 
> qcom_ssphy_vbus_ctrl() above was either enabling or disabling vbus, but
> here you're directly calling disable to unroll that. It think the result
> is correct (in host this reverts to disabled and in gadget it's a
> no-op), but I'm not sure I like the design of sometimes calling straight
> to the vbus enable/disable and sometimes to the wrapper function.

I think you misread: we have vbus enable/disable and vdd control
(different regulators)


I have to admit that the only reason I had separate functions for vbus
enable/disable was cosmetic (and "if" on the control variable + another
"if" to check that the regulator was already voted was taking me beyond
the 80 lines character and I hate when that happens on simple
operations). anyway will redo

> 
>> +err3:
> 
> err_clk_disable
> 
>> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>> +err2:
>> +	regulator_bulk_disable(priv->num_regs, priv->regs);
>> +err1:
>> +	qcom_ssphy_vdd_ctrl(priv, DISABLE);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qcom_ssphy_power_off(struct phy *phy)
>> +{
>> +	struct ssphy_priv *priv = phy_get_drvdata(phy);
>> +
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, LANE0_PWR_ON, 0);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL2, REF_PHY_EN, 0);
>> +	qcom_ssphy_updatel(priv->base + PHY_CTRL4, TST_PWR_DOWN, TST_PWR_DOWN);
>> +
>> +	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
>> +	regulator_bulk_disable(priv->num_regs, priv->regs);
>> +
>> +	if (priv->vbus && priv->mode != PHY_MODE_INVALID)
>> +		qcom_ssphy_vbus_disable(priv->vbus);
>> +
>> +	qcom_ssphy_vdd_ctrl(priv, DISABLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_ssphy_init_clock(struct ssphy_priv *priv)
>> +{
>> +	const char * const clk_id[] = { "ref", "phy", "pipe", };
>> +	int i;
>> +
>> +	priv->num_clks = ARRAY_SIZE(clk_id);
>> +	priv->clks = devm_kcalloc(priv->dev, priv->num_clks,
>> +				  sizeof(*priv->clks), GFP_KERNEL);
> 
> You know num_clks is 3, so I would suggest that you just change the
> sshphy_priv to clks[3] and skip the dynamic allocation.


ok

> 
> 
> Also, as num_clks always is ARRAY_SIZE(priv->clks) I would suggest using
> the latter, to make that clear throughout the driver.

maybe then just define NBR_CLKS (I find long lines a pain to read)

> 
>> +	if (!priv->clks)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < priv->num_clks; i++)
>> +		priv->clks[i].id = clk_id[i];
> 
> There's no harm in just writing this on three lines:
> 
> 	priv->clks[0].id = "ref";
> 	priv->clks[1].id = "phy";
> 	priv->clks[2].id = "pipe";
> 
>> +
>> +	return devm_clk_bulk_get(priv->dev, priv->num_clks, priv->clks);
>> +}
>> +
>> +static int qcom_ssphy_init_regulator(struct ssphy_priv *priv)
>> +{
>> +	const char * const reg_supplies[] = {
>> +		[VDD] = "vdd",
>> +		[VDDA1P8] = "vdda1p8",
>> +	};
>> +	int ret, i;
>> +
>> +	priv->num_regs = ARRAY_SIZE(reg_supplies);
>> +	priv->regs = devm_kcalloc(priv->dev, priv->num_regs,
>> +				  sizeof(*priv->regs), GFP_KERNEL);
> 
> As with clocks, you know there will only be 2 of these, make it fixed
> size in ssphy_priv.

well ok

> 
> And as with clocks, I would suggest using ARRAY_SIZE(priv->regs)
> throughout the driver to make it obvious that's it's a static number. 
> 
>> +	if (!priv->regs)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < priv->num_regs; i++)
>> +		priv->regs[i].supply = reg_supplies[i];
> 
> As with clocks, just unroll this and fill in the 2 supplies directly.

um, ok, I find the above more readable but I see where you are going
with these sort of recomendations...will just follow them

> 
>> +
>> +	ret = devm_regulator_bulk_get(priv->dev, priv->num_regs, priv->regs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->vbus = devm_regulator_get_optional(priv->dev, "vbus");
> 
> get_optional means that if vbus-supply is not found, rather than
> returning a dummy regulator object this will fail with -ENODEV.

yes I messed this up.

> 
> Given the rest of the logic related to vbus you should set vbus to NULL
> if the returned PTR_ERR(value) is -ENODEV, and fail for other errors.
> 
> 
> Or just drop the _optional, and let your vbus controls operate on the
> dummy regulator you get back.

yes will do this. thanks for the suggestion and the review!

> 
> (Right now vbus can't be NULL, so these checks are not very useful)
> 
>> +	if (IS_ERR(priv->vbus))
>> +		return PTR_ERR(priv->vbus);
>> +
>> +	return 0;
> 
> return PTR_ERR_OR_ZERO(priv->vbus)
> 
> (Although that might change based on above comment)
> 
>> +}
> 
> Regards,
> Bjorn
> 

