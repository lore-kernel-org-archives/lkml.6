Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73CEC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D4B20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEiz/uMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D4B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLIEWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:22:39 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34842 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeLIEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:22:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so3657135plo.2;
        Sat, 08 Dec 2018 20:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tF/HmfuYyXRuZl2fwaPDrE9wWRtMGoYsXgSlpP2vWuA=;
        b=YEiz/uMGeOchpypNxqoqEK3B7KNDboNLm06jeHbUu6hivO7LoQzeYWe1mWcVulYUsd
         WnOClsTGqj+BSg3fbE9KZ2LREZvlc3+3QQ7kZk+HU/cNtN6ab8pnMqXkf0AdKWMTN4NQ
         iZZxxn2GlnfvGOTG4gtXWbwV0IUlU3POtru+eF+fhuzMiH4FgTU63pZOlNMavNqT/28o
         qClw+lYjKARuH5RgJTLoV8VUStjVQsOlzEJP2VnIO5z+IEycGmI8pMZvltX5DQn85oK5
         dlHpeDt3rbyeASkAT5JqTgnfZNBue+vjajsn24AsHsNIVqnpfNBwNKWx3vtx3HS/dUBa
         EcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tF/HmfuYyXRuZl2fwaPDrE9wWRtMGoYsXgSlpP2vWuA=;
        b=oKF1v5xWJaS7bzqEPwy50vmsORMPan2tTm1YEjzs2X4zTNG1NBoAlKZlXUvU0a3aTv
         KjMUsjoEMfbRxr+K5tzZFySb+QxRUfTTip4FwsroJiPAfU/UQyHsTVw2atqnekkZ7r6r
         sDq9QqhgSnN017Ze/us65jYRct7fvMlk+kK49v+8vcor4NfQ7UEEZlpjIlm/NyuG9m1O
         CGWh+i4oeS6ctxAw43HdXNiXmfv6TU+mkxuGL3QWvqTEF5M59QWxhIACSf4wBZ5fnH4K
         SH18Xp9kydkTzI/T1ayIbYUcnNx9AhL1JussyygE1D4xsH/bT2dR6KB1IZM6FN+Cu+ze
         9VxA==
X-Gm-Message-State: AA+aEWZ8f3fDviblaHw1/dxFWCFwjX8HoK9OAywe9PqRVDwBaZyOcedA
        thm7Ic1VP/RAQUOP7bpXq/M=
X-Google-Smtp-Source: AFSGD/VksRc17JZMJQBS6PlIsofnQmOZdcMsbAoh9RNKTdVL0VMk2+1duk9k+Y+FU2/oSJaRrdjAqA==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr7489319plr.207.1544329357525;
        Sat, 08 Dec 2018 20:22:37 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d11sm7562067pgi.25.2018.12.08.20.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:22:36 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:22:34 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH 1/8] Input: tm2-touchkey: Add support for midas touchkey
Message-ID: <20181209042234.GB211094@dtor-ws>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207105811.1831-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181207105811.1831-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

On Fri, Dec 07, 2018 at 11:58:04AM +0100, Paweł Chmiel wrote:
> From: Simon Shields <simon@lineageos.org>
> 
> The touchkey on midas boards is almost identical.
> The only real difference is that it uses the same register for both
> keycode and base.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/keyboard/tm2-touchkey.c | 48 ++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
> index abc266e40e17..37a5ced24009 100644
> --- a/drivers/input/keyboard/tm2-touchkey.c
> +++ b/drivers/input/keyboard/tm2-touchkey.c
> @@ -22,12 +22,13 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/pm.h>
>  #include <linux/regulator/consumer.h>
>  
> -#define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
> -#define TM2_TOUCHKEY_KEYCODE_REG	0x03
> -#define TM2_TOUCHKEY_BASE_REG		0x00
> +#define TM2_TOUCHKEY_DEV_NAME "tm2-touchkey"
> +#define MIDAS_TOUCHKEY_DEV_NAME "midas-touchkey"

I am not sure why we need to bother with name changes... We can get to
compatible if it is that interesting, but other than that it seems
only complicate things. Also, you use MIDAS_TOUCHKEY_DEV_NAME in only
one place and open-code it in others.

> +
>  #define TM2_TOUCHKEY_CMD_LED_ON		0x10
>  #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
>  #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
> @@ -40,12 +41,31 @@ enum {
>  	TM2_TOUCHKEY_KEY_BACK,
>  };
>  
> +struct touchkey_variant {
> +	const char *name;
> +	u8 keycode_reg;
> +	u8 base_reg;
> +};
> +
>  struct tm2_touchkey_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
>  	struct led_classdev led_dev;
>  	struct regulator *vdd;
>  	struct regulator_bulk_data regulators[2];
> +	struct touchkey_variant *variant;

	const struct touchkey_variant *variant;

> +};
> +
> +static struct touchkey_variant tm2_touchkey_variant = {

static const

> +	.name = "tm2-touchkey",
> +	.keycode_reg = 0x03,
> +	.base_reg = 0x00,
> +};
> +
> +static struct touchkey_variant midas_touchkey_variant = {

static const

> +	.name = "midas-touchkey",
> +	.keycode_reg = 0x00,
> +	.base_reg = 0x00,
>  };
>  
>  static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
> @@ -66,7 +86,7 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
>  
>  	regulator_set_voltage(touchkey->vdd, volt, volt);
>  	i2c_smbus_write_byte_data(touchkey->client,
> -				  TM2_TOUCHKEY_BASE_REG, data);
> +				  touchkey->variant->base_reg, data);
>  }
>  
>  static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
> @@ -99,7 +119,7 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
>  	int key;
>  
>  	data = i2c_smbus_read_byte_data(touchkey->client,
> -					TM2_TOUCHKEY_KEYCODE_REG);
> +					touchkey->variant->keycode_reg);
>  	if (data < 0) {
>  		dev_err(&touchkey->client->dev,
>  			"failed to read i2c data: %d\n", data);
> @@ -153,6 +173,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
>  	touchkey->client = client;
>  	i2c_set_clientdata(client, touchkey);
>  
> +	touchkey->variant = (struct touchkey_variant *)


Is cast really needed?

> +		of_device_get_match_data(&client->dev);
> +
>  	touchkey->regulators[0].supply = "vcc";
>  	touchkey->regulators[1].supply = "vdd";
>  	error = devm_regulator_bulk_get(&client->dev,
> @@ -187,7 +210,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  	}
>  
> -	touchkey->input_dev->name = TM2_TOUCHKEY_DEV_NAME;
> +	touchkey->input_dev->name = touchkey->variant->name;
>  	touchkey->input_dev->id.bustype = BUS_I2C;
>  
>  	input_set_capability(touchkey->input_dev, EV_KEY, KEY_PHONE);
> @@ -203,7 +226,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, tm2_touchkey_irq_handler,
>  					  IRQF_ONESHOT,
> -					  TM2_TOUCHKEY_DEV_NAME, touchkey);
> +					  touchkey->variant->name, touchkey);
>  	if (error) {
>  		dev_err(&client->dev,
>  			"failed to request threaded irq: %d\n", error);
> @@ -211,7 +234,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
>  	}
>  
>  	/* led device */
> -	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
> +	touchkey->led_dev.name = touchkey->variant->name;
>  	touchkey->led_dev.brightness = LED_FULL;
>  	touchkey->led_dev.max_brightness = LED_ON;
>  	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
> @@ -257,12 +280,19 @@ static SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops,
>  
>  static const struct i2c_device_id tm2_touchkey_id_table[] = {
>  	{ TM2_TOUCHKEY_DEV_NAME, 0 },
> +	{ MIDAS_TOUCHKEY_DEV_NAME, 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table);
>  
>  static const struct of_device_id tm2_touchkey_of_match[] = {
> -	{ .compatible = "cypress,tm2-touchkey", },
> +	{
> +		.compatible = "cypress,tm2-touchkey",
> +		.data = &tm2_touchkey_variant,
> +	}, {
> +		.compatible = "cypress,midas-touchkey",
> +		.data = &midas_touchkey_variant,
> +	},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, tm2_touchkey_of_match);
> -- 
> 2.17.1
> 

Thanks.

-- 
Dmitry
