Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37350ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5849208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcIzc70/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5849208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeGOKsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:48:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53884 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeGOKsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:48:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so5097143wmh.3;
        Sun, 15 Jul 2018 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=X2azfd1lM3KzIHTSMsX4c59WH4f4bGbISp/OEWI4Mf4=;
        b=OcIzc70/lGNCoJ0j/hOBoV3ROk8Wzde1/azABZIvTT5Dtz6fyEUIutKmC9is9bolOk
         stM+BVtyUUAsnBnY12GLblfJb4C5uP8d8KTSqmUUcll58j+vd02ukbN3Dx88vLbN14Hu
         mKtH+9oCffGqbseFq1LypsUINAUj0WR+cSCy9opkgxdFU+PdmfSlW831LBtr/Qxb3tO3
         jOhuddFef0Q5UcfBXRxsbXgXVjbIevGYy1Jf3PjgQh9UZqxOKY/WPcm2KKwnOzJarP8F
         Qq+H4khIToV2A1iVEW5G0sK0dngay6Vrr0gc/owtOraU8L0sDFC8Bj+vvs0sbuuhhp3v
         Z15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X2azfd1lM3KzIHTSMsX4c59WH4f4bGbISp/OEWI4Mf4=;
        b=my9hICxazCtai6XEVDRgm6FRad2v3ivZUw+WdYxcbSw3h8Yj2dwvK1Rbz1pctwOC2L
         +2eEAkpqmFTnYjLExokuYP6Hi5AGQCtaJsdSotZ8Cw8e/R/Xk3WPIFSfr1QhBlBmEEc2
         xWJJdgjAaFRJ33hmcYdRbZEhDJx5a/s+sNrOyz85qN+UgIs5U/7yNmR7WMYoUSP1Cqsn
         phLlB4YD+6Jfh5Xa7foEWx07WytzZ6+8Fx1lmXhQVk6jXc5HT6PTjd/DPEIAtW6rRes9
         uN9MJbiLdKCUFTXPylciYtiPXKdBaxl6cADKduFPmedZmAVWVRZGbS9MRMPfWn9HJ7p/
         FfNA==
X-Gm-Message-State: AOUpUlFvXggHKtbrh6OVrzkKOFdPLbepewJPzSmHYJqIfy0qsxnYoRsT
        Z/7jsDi+9RUPw3p3ydLhT8A=
X-Google-Smtp-Source: AAOMgpfp/i+pL5K8RtCXGga0xeGqmDAULCic2c+QtQlP+mpgmdM+X91Duw0IE/pUTi4aCImc9beYKw==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr7063796wmd.7.1531650351554;
        Sun, 15 Jul 2018 03:25:51 -0700 (PDT)
Received: from localhost ([195.46.23.67])
        by smtp.gmail.com with ESMTPSA id t2-v6sm17069518wrg.25.2018.07.15.03.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 03:25:50 -0700 (PDT)
Date:   Sun, 15 Jul 2018 10:25:47 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts: Add support for optional
 regulators.
Message-ID: <20180715102547.afu57hbjcbizn3kc@penguin>
References: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531506608-24479-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531506608-24479-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

On Fri, Jul 13, 2018 at 08:30:07PM +0200, Paweł Chmiel wrote:
> This patch adds optional regulators, which can be used to power
> up touchscreen. After enabling regulators, we need to wait 150msec.
> This value is taken from official driver.
> 
> It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 45 ++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 54fe190fd4bc..a7625ec8fb9f 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -27,6 +27,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/property.h>
> @@ -198,6 +199,7 @@ enum t100_type {
>  #define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
> +#define MXT_REGULATOR_DELAY	150	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> @@ -310,6 +312,8 @@ struct mxt_data {
>  	struct t7_config t7_cfg;
>  	struct mxt_dbg dbg;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator *vdd_reg;
> +	struct regulator *avdd_reg;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -3076,6 +3080,40 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return error;
>  	}
>  
> +	data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_reg)) {
> +		error = PTR_ERR(data->vdd_reg);
> +		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	if (data->vdd_reg) {
> +		error = regulator_enable(data->vdd_reg);
> +		if (error) {
> +			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +
> +	data->avdd_reg = devm_regulator_get_optional(&client->dev, "avdd");
> +	if (IS_ERR(data->avdd_reg)) {
> +		error = PTR_ERR(data->avdd_reg);
> +		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	if (data->avdd_reg) {

devm_regulator_get_optional() does not return NULL for regulators
not present in device tree, but rather -ENOENT, so this code is not
correct; neither is the simple IS_ERR() check above.

Moreover, the optional regulators should be used when there is a part of
IP block that can be optionally powered up, but the device can work
(with limited functionality) even when it is powered down. They should
not be used in cases when supplies are mandatory (such as vdd/avdd) but
may not be exposed to the kernel by the firmware.

Simply use devm_regulator_get() and rely on the fact that on fully
constrained system you will get a dummy regulator.

> +		error = regulator_enable(data->avdd_reg);
> +		if (error) {
> +			dev_err(&client->dev, "Failed to enable avdd regulator: %d\n",
> +				error);
> +			return error;
> +		}
> +	}
> +
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, mxt_interrupt, IRQF_ONESHOT,
>  					  client->name, data);
> @@ -3086,6 +3124,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	disable_irq(client->irq);
>  
> +	if (!IS_ERR(data->vdd_reg) || !IS_ERR(data->avdd_reg))
> +		msleep(MXT_REGULATOR_DELAY);
> +
>  	if (data->reset_gpio) {

I think you should require that if regulators are exposed then reset
gpio should also be present to ensure proper power up timings.

>  		msleep(MXT_RESET_GPIO_TIME);
>  		gpiod_set_value(data->reset_gpio, 1);
> @@ -3116,6 +3157,10 @@ static int mxt_remove(struct i2c_client *client)
>  	struct mxt_data *data = i2c_get_clientdata(client);
>  
>  	disable_irq(data->irq);
> +	if (!IS_ERR(data->avdd_reg))
> +		regulator_disable(data->avdd_reg);
> +	if (!IS_ERR(data->vdd_reg))
> +		regulator_disable(data->vdd_reg);
>  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
>  	mxt_free_input_device(data);
>  	mxt_free_object_table(data);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
