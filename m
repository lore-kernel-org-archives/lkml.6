Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4900C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5833220B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM8yxklm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5833220B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeHVVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:32:01 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41984 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeHVVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:32:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so3162660qto.9;
        Wed, 22 Aug 2018 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sr7ajUTsaxUybc4Os3m7kob3hReiDx94MMKePsRx2V8=;
        b=TM8yxklmW9YoARZ0YxJEv8MzJnHMVI9+pDHvKlrg/y52Ookx3Th247MFHQK8shQDyO
         MDpv2BYqOI4VZ3KT/rWdf8i3zaeUGT6DrGDxKFIAc/fjv3B4U6byNeGSrjfNDOCg5V9A
         mt+xEVzNer7TxsdoDyuMcWsXh93BFGkQ2JJ4JnSp95RtzZysgD56V/TqqBaQgLnlZ4Eg
         DPjw6HZkc38uPp8yC5Z86pA8Ftjg8O4iTYHagUU52OHAibkMyWkUQHajXQu/0KIwJ9e5
         /U8cUAY6kpZT/ZIzVyJAoCZuYNyW9zs+3yFES37b62E/CZvKGVxi+0QlyXb/rC0GhQEm
         RHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Sr7ajUTsaxUybc4Os3m7kob3hReiDx94MMKePsRx2V8=;
        b=mqV3L6FP6Ns02nbmdHa/J3qUMZP77DmMy+tEZTIh3HZnoetadJkpleoLKBwSVpQOKn
         SYFBl/WRJ4LX2NR6FKnaIjiGKk93zsVc1+Zxzd32POET/fPiyZ4Lq+EQH0UbvYTL0n1J
         saZXzW6mXhWaPGMEI1YSyKEnNErlPWgl8Urj6ZP2vCN7/bmcC314Aoa+28H9S95sa+xd
         WJqr8slWDU9kJGqTaIeDOQbticjMcFggATO6YYM6f1eZUwtBajfzzXNI4BxWB/lcvUKf
         6TiERuZNpspqmluSyeSqx7H+Bmc6yoZVTvCTBFASxp11pJNT/mroi8Q09EUOxcCMZHQf
         AvrQ==
X-Gm-Message-State: AOUpUlFqHPGe/hxrvRxf25eo0U8Q7DTXBxlRG4nTEsCKINX89fL5+S87
        j0wtXHvpp5bHWIFsCEypgkQ=
X-Google-Smtp-Source: AA+uWPx1SKAW0MqmTXDMtkp9OT6o92ce/wfI+ff5qoY+iC/42la8SayKaf6A7lYqgiKzBGOSYSv5gA==
X-Received: by 2002:ac8:2943:: with SMTP id z3-v6mr55844599qtz.149.1534961165724;
        Wed, 22 Aug 2018 11:06:05 -0700 (PDT)
Received: from gandalf.middle.earth.net (pool-173-48-42-19.bstnma.fios.verizon.net. [173.48.42.19])
        by smtp.gmail.com with ESMTPSA id v72-v6sm1371337qkb.84.2018.08.22.11.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 11:06:05 -0700 (PDT)
From:   "George G. Davis" <ggdavisiv@gmail.com>
X-Google-Original-From: "George G. Davis" <george_davis@mentor.com>
Date:   Wed, 22 Aug 2018 14:06:03 -0400
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     nick@shmanahar.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] Input: atmel_mxt_ts: Add support for optional
 regulators.
Message-ID: <20180822180603.GA4102@gandalf.middle.earth.net>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1533050291-11502-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533050291-11502-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paweł,


I would suggest dropping sentence punctuation in the patch subject line:

Input: atmel_mxt_ts: Add support for optional regulators.

More below...

On Tue, Jul 31, 2018 at 05:18:09PM +0200, Paweł Chmiel wrote:
> This patch adds optional regulators, which can be used to power
> up touchscreen. After enabling regulators, we need to wait 150msec.
> This value is taken from official driver.
> 
> It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Move code enabling regulators into separate method,
>     to make code more readable.
> 
> Changes from v1:
>   - Enable regulators only if reset_gpio is present.
>   - Switch from devm_regulator_get_optional to devm_regulator_get
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 54fe190fd4bc..2cd7f6db6ba9 100644
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
> @@ -194,10 +195,10 @@ enum t100_type {
>  
>  /* Delay times */
>  #define MXT_BACKUP_TIME		50	/* msec */
> -#define MXT_RESET_GPIO_TIME	20	/* msec */
>  #define MXT_RESET_INVALID_CHG	100	/* msec */
>  #define MXT_RESET_TIME		200	/* msec */
>  #define MXT_RESET_TIMEOUT	3000	/* msec */
> +#define MXT_REGULATOR_DELAY	150	/* msec */
>  #define MXT_CRC_TIMEOUT		1000	/* msec */
>  #define MXT_FW_RESET_TIME	3000	/* msec */
>  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> @@ -310,6 +311,8 @@ struct mxt_data {
>  	struct t7_config t7_cfg;
>  	struct mxt_dbg dbg;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator *vdd_reg;
> +	struct regulator *avdd_reg;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -3016,6 +3019,38 @@ static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
>  	{ }
>  };
>  
> +static int mxt_regulator_enable(struct mxt_data *data)
> +{
> +	int error;
> +
> +	if (data->reset_gpio) {
> +		error = regulator_enable(data->vdd_reg);
> +		if (error) {
> +			dev_err(&data->client->dev, "Failed to enable vdd regulator: %d\n",
> +				error);
> +			return error;
> +		}
> +
> +		error = regulator_enable(data->avdd_reg);
> +		if (error) {
> +			dev_err(&data->client->dev, "Failed to enable avdd regulator: %d\n",
> +				error);
> +			return error;
> +		}
> +
> +		/*
> +		 * According to maXTouch power sequencing specification, RESET line

Please fix the following checkpatch issue:

drivers/input/touchscreen/atmel_mxt_ts.c:3065: WARNING:LONG_LINE_COMMENT: line over 80 characters

Thanks!

--
Regards,
George

> +		 * must be kept low until some time after regulators come up to
> +		 * voltage
> +		 */
> +		msleep(MXT_REGULATOR_DELAY);
> +		gpiod_set_value(data->reset_gpio, 1);
> +		msleep(MXT_RESET_INVALID_CHG);
> +	}
> +
> +	return 0;
> +}
> +
>  static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
>  	struct mxt_data *data;
> @@ -3076,6 +3111,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return error;
>  	}
>  
> +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->vdd_reg)) {
> +		error = PTR_ERR(data->vdd_reg);
> +		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	data->avdd_reg = devm_regulator_get(&client->dev, "avdd");
> +	if (IS_ERR(data->avdd_reg)) {
> +		error = PTR_ERR(data->avdd_reg);
> +		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
> +			error);
> +		return error;
> +	}
> +
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, mxt_interrupt, IRQF_ONESHOT,
>  					  client->name, data);
> @@ -3086,11 +3137,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	disable_irq(client->irq);
>  
> -	if (data->reset_gpio) {
> -		msleep(MXT_RESET_GPIO_TIME);
> -		gpiod_set_value(data->reset_gpio, 1);
> -		msleep(MXT_RESET_INVALID_CHG);
> -	}
> +	error = mxt_regulator_enable(data);
> +	if (error)
> +		return error;
>  
>  	error = mxt_initialize(data);
>  	if (error)
> @@ -3116,6 +3165,10 @@ static int mxt_remove(struct i2c_client *client)
>  	struct mxt_data *data = i2c_get_clientdata(client);
>  
>  	disable_irq(data->irq);
> +	if (data->reset_gpio) {
> +		regulator_disable(data->avdd_reg);
> +		regulator_disable(data->vdd_reg);
> +	}
>  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
>  	mxt_free_input_device(data);
>  	mxt_free_object_table(data);
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
