Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2879C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC8C21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkUgJd4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC8C21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJQBbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:31:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38538 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQBbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:31:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so8279731pll.5;
        Tue, 16 Oct 2018 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pkuHJt+fSq9QL8V1hOpl+hs5fE2TEWjgqL5N0xigV74=;
        b=RkUgJd4XJg+fbzsJ3jcdB+ijVFYunUPqcKyQv18x5R/P0z2thvw0IJK0bnC4ysHOYH
         ukQ7aGyvvhqvwFcijfyWLq/c0SurAuqz/HSFyZAaR7zE4a+unlXOzUtQkPJyrwqiog59
         quiBfqB0a7Cu7VRo6KSLl+4gIhIz7cvr45LlS/lVF+TTxwfPwYa15GLUmpL1cTn6ZZP6
         /fr9u44B1pCnZxI7CZAn/ErXcDRJCElNdTCoI9GydGZO++ka5UnhQYPbZfIMK2Ylhhms
         R+s6yfih+LR1PLZwqHxubqXaLuX0LRSfDZ1339nxQfHULntdt9YMKITP4+vEYm2BfDRP
         5S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pkuHJt+fSq9QL8V1hOpl+hs5fE2TEWjgqL5N0xigV74=;
        b=B+HwoAlpr6M/ifiTuRTOJvxnkT2cHdq/5KiDTYJIEuHyvpvQep5F00U7QUkfcHbaB/
         WnHmLCJpVd/FuOp3UGSWXXIihQtKdX67PPhAAYlG6QBxFYGx8G8Kt4ge7txco3gP2pH5
         7ujSSCPYq98YRcNCQnOsYzbvSpmFVuizUmnReptLspHjK6A7hFQLYN97WJWgS+jsqJON
         cJwl3h0ibJX96+L4N30myP/urBwHdxF0B69NSsf5Z0mwRfq4wGSvWteVmuSJ1oHgpaMe
         Y1gNrnASVUPCxClKfppKOiZ3FoadLceCwMtA4QzVaHuSsYv+G3ZzfRNtQ8Ifg6FjVnQe
         BKuw==
X-Gm-Message-State: ABuFfoizjRKYZc9Fxg3P8d6CZ7QRSybXdD/ssTaI7rmExJDo7pXarPdp
        BLu12U4/CXF8XJtH6IM/cUg=
X-Google-Smtp-Source: ACcGV639ro3Mz43jJw+VmCAwBTo+hDp0OpQ+X2Ba2/LYxSUkQlKN6KqbWtFmGr4u9iGEXnOyBFX88g==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr22195065pli.220.1539711575330;
        Tue, 16 Oct 2018 10:39:35 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a5-v6sm17084663pfo.53.2018.10.16.10.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 10:39:34 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:39:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: sx8654 - add reset-gpio support
Message-ID: <20181016173931.GC230131@dtor-ws>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016091653.26896-3-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016091653.26896-3-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, Oct 16, 2018 at 11:16:48AM +0200, Richard Leitner wrote:
> The sx8654 features a NRST input which may be connected to a GPIO.
> Therefore add support for hard-resetting the sx8654 via this NRST.
> 
> If the reset-gpio property is provided the sx8654 is resetted via NRST
> instead of the soft-reset via I2C.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 88 ++++++++++++++++++++++++++++++++------
>  1 file changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index ed29db3ec731..059127490c8d 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -33,6 +33,8 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -74,6 +76,7 @@
>  struct sx8654 {
>  	struct input_dev *input;
>  	struct i2c_client *client;
> +	struct gpio_desc *gpio_reset;
>  };
>  
>  static irqreturn_t sx8654_irq(int irq, void *handle)
> @@ -124,6 +127,27 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> +static int sx8654_reset(struct sx8654 *ts)
> +{
> +	int err;
> +
> +	if (ts->gpio_reset) {
> +		gpiod_set_value_cansleep(ts->gpio_reset, 1);
> +		udelay(2); /* Tpulse > 1µs */
> +		gpiod_set_value_cansleep(ts->gpio_reset, 0);
> +
> +		return 0;
> +	}
> +
> +	dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
> +	err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
> +					SOFTRESET_VALUE);
> +	if (err)
> +		return err;

Have this in an "else" branch?

> +
> +	return 0;
> +}
> +
>  static int sx8654_open(struct input_dev *dev)
>  {
>  	struct sx8654 *sx8654 = input_get_drvdata(dev);
> @@ -171,6 +195,44 @@ static void sx8654_close(struct input_dev *dev)
>  	}
>  }
>  
> +#ifdef CONFIG_OF
> +static int sx8654_get_ofdata(struct sx8654 *ts)
> +{
> +	struct device *dev = &ts->client->dev;
> +	struct device_node *node = dev->of_node;
> +	int err;
> +
> +	if (!node) {
> +		ts->gpio_reset = NULL;
> +		return 0;
> +	}

There is no need to wrap this into CONFIG_OF or test "node". Just use
devm_gpiod_get_optional() and it will work equally well on DT, ACPI, and
static board systems.

> +
> +	ts->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (PTR_ERR(ts->gpio_reset) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(ts->gpio_reset)) {
> +		err = PTR_ERR(ts->gpio_reset);

I'd do:

		if (err != -EPROBE_DEFER)
			dev_err(...)

here instead of separate branch.

> +		dev_err(dev, "unable to request GPIO reset pin (%d)\n", err);
> +		return err;
> +	}
> +	dev_dbg(dev, "got GPIO reset pin\n");

Also, I'd move all this code directly into probe() since all this
#ifdefery is not needed.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sx8654_of_match[] = {
> +	{ .compatible = "semtech,sx8654", },
> +	{ },
> +};

Please keep the device table wehere it was.

> +MODULE_DEVICE_TABLE(of, sx8654_of_match);
> +#else /* CONFIG_OF */
> +static int sx8654_get_ofdata(struct sx8654 *ts)
> +{
> +	ts->gpio_reset = NULL;
> +	return 0;
> +}
> +#endif /* CONFIG_OF */
> +
>  static int sx8654_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -186,10 +248,20 @@ static int sx8654_probe(struct i2c_client *client,
>  	if (!sx8654)
>  		return -ENOMEM;
>  
> +	sx8654->client = client;
> +
> +	error = sx8654_get_ofdata(sx8654);
> +	if (error) {
> +		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
> +		return error;
> +	}
> +
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
>  
> +	sx8654->input = input;
> +
>  	input->name = "SX8654 I2C Touchscreen";
>  	input->id.bustype = BUS_I2C;
>  	input->dev.parent = &client->dev;
> @@ -201,15 +273,11 @@ static int sx8654_probe(struct i2c_client *client,
>  	input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
>  	input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);
>  
> -	sx8654->client = client;
> -	sx8654->input = input;
> -

Why do we need to move this?

>  	input_set_drvdata(sx8654->input, sx8654);
>  
> -	error = i2c_smbus_write_byte_data(client, I2C_REG_SOFTRESET,
> -					  SOFTRESET_VALUE);
> +	error = sx8654_reset(sx8654);
>  	if (error) {
> -		dev_err(&client->dev, "writing softreset value failed");
> +		dev_err(&client->dev, "reset failed");
>  		return error;
>  	}
>  
> @@ -256,14 +324,6 @@ static int sx8654_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id sx8654_of_match[] = {
> -	{ .compatible = "semtech,sx8654", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, sx8654_of_match);
> -#endif
> -
>  static const struct i2c_device_id sx8654_id_table[] = {
>  	{ "semtech_sx8654", 0 },
>  	{ },
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
