Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68329C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C06A2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB+qce/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C06A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLCTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:13:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeLCTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:13:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so6856374pfi.8;
        Mon, 03 Dec 2018 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qnASkkUVzay1X6I35mt8jop4Y9+o9JyVXsgOZofm6Vs=;
        b=tB+qce/ZOpXQCRdc+/4AQjwVDx3uZd+nOn9OZLXHCNkt8aGZuI0s67M62/wQnE+XzS
         eLkFJUhJR+HjUZr6KyM2eog2yjYavGX/dngEuM7pyQhAlSYC/J3sPhKUQBiWS/Q3DCQW
         NKgWKmksWjqLGlzPbItwUDniedVS5jlQS68VLYnEr3kQAY8dZ0cG6/6Sb9cNS2VN1Nqu
         1+/qVhMz/7Hl1xGIFjhkR2D6Grjg2ZAmtWU7IEHp5l88lqb7mJ0/NWh8U3EZdrlseZ3n
         zTbUdM9mRYkThjEgyHRVyeeJg2Wd9RjKBR2y6Og+8IDJZAkWc4cIHJJlofpjU6QQNfby
         C/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qnASkkUVzay1X6I35mt8jop4Y9+o9JyVXsgOZofm6Vs=;
        b=dpX1hoKc5SKhlnEWZuztwFGnhOUMRRDQdwK8sw8D8NkMih3DoH8jjZ1rSUe3ETPfEK
         44mPUH21HkT4gJeRVNgOU+lMw4hVqxd1dOKRO/dXpjwhRhJW6M9PpHLYl4h4uPP3uGHZ
         uixLD4HfX+yFp41ElW/AkxO8ZKUviHi/VeqBBHTMYqg+Zth7iX44aAiQk0GsUZ4Rkik1
         yufKCYl+7lUPboMrQUAR2d6EP+igaGCGbmpb81FRdyznNgt2eTEX2HQQf+q+fkUdDqqo
         RnqY5FH2ptL+Cll340VnzKHtCOGibJ0A03wfIckt+ib/6rB6wsm77UeWfmiG503h8f/g
         yCUA==
X-Gm-Message-State: AA+aEWZMxdHKidbZ921+3BNNzIXifNkvnn4jQJ3NDXq++Bz06ZdvrVIO
        c1QLzHjeFR2U9h2d04H+hMs=
X-Google-Smtp-Source: AFSGD/WhMTQSZ7N26qIrRlb9gM8kTEWwLXOXVFT8mH3d+bAe+R+FzC0Qvvo6vZJ9GTaYEXhjJXcDwQ==
X-Received: by 2002:a63:a401:: with SMTP id c1mr14336354pgf.403.1543864407902;
        Mon, 03 Dec 2018 11:13:27 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d129sm23610379pfc.31.2018.12.03.11.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 11:13:26 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:13:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 6/9] Input: goodix - Add vcc-supply regulator support
Message-ID: <20181203191324.GA257010@dtor-ws>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203101547.16835-6-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 03:45:44PM +0530, Jagan Teki wrote:
> vcc-supply property is need for some Goodix CTP controller like GT5663
> where 3.3V external pull-up regulator connected via controller VCC pin.
> 
> So, enable the regulator for those it attached the vcc-supply.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/input/touchscreen/goodix.c | 39 ++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f2d9c2c41885..7adcf1491609 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> @@ -47,6 +48,7 @@ struct goodix_ts_data {
>  	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	struct regulator *vcc;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -58,6 +60,7 @@ struct goodix_ts_data {
>  
>  #define GOODIX_GPIO_INT_NAME		"irq"
>  #define GOODIX_GPIO_RST_NAME		"reset"
> +#define GOODIX_VCC_CTP_NAME		"vcc"
>  
>  #define GOODIX_MAX_HEIGHT		4096
>  #define GOODIX_MAX_WIDTH		4096
> @@ -525,12 +528,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  {
>  	int error;
>  	struct device *dev;
> +	struct regulator *regulator;
>  	struct gpio_desc *gpiod;
>  
>  	if (!ts->client)
>  		return -EINVAL;
>  	dev = &ts->client->dev;
>  
> +	regulator = devm_regulator_get(dev, GOODIX_VCC_CTP_NAME);
> +	if (IS_ERR(regulator)) {
> +		error = PTR_ERR(regulator);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vcc regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	ts->vcc = regulator;
> +
>  	/* Get the interrupt GPIO pin number */
>  	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
>  	if (IS_ERR(gpiod)) {
> @@ -786,25 +801,34 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	/* power the controller */
> +	if (ts->vcc) {

ts->vcc is never NULL.

> +		error = regulator_enable(ts->vcc);
> +		if (error) {
> +			dev_err(&client->dev, "Controller fail to enable vcc\n");
> +			return error;
> +		}
> +	}
> +
>  	if (ts->gpiod_int && ts->gpiod_rst) {
>  		/* reset the controller */
>  		error = goodix_reset(ts);
>  		if (error) {
>  			dev_err(&client->dev, "Controller reset failed.\n");
> -			return error;
> +			goto error;
>  		}
>  	}
>  
>  	error = goodix_i2c_test(client);
>  	if (error) {
>  		dev_err(&client->dev, "I2C communication failure: %d\n", error);
> -		return error;
> +		goto error;
>  	}
>  
>  	error = goodix_read_version(ts);
>  	if (error) {
>  		dev_err(&client->dev, "Read version failed.\n");
> -		return error;
> +		goto error;
>  	}
>  
>  	ts->chip = goodix_get_chip_data(ts->id);
> @@ -823,17 +847,22 @@ static int goodix_ts_probe(struct i2c_client *client,
>  			dev_err(&client->dev,
>  				"Failed to invoke firmware loader: %d\n",
>  				error);
> -			return error;
> +			goto error;
>  		}
>  
>  		return 0;
>  	} else {
>  		error = goodix_configure_dev(ts);
>  		if (error)
> -			return error;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	if (ts->vcc)
> +		regulator_disable(ts->vcc);

Same here.

> +	return error;
>  }
>  
>  static int goodix_ts_remove(struct i2c_client *client)

You need to disable regulator on removal as well.

Thanks.

-- 
Dmitry
