Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A10C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788CD20645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjBcqykK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788CD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJQBkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:40:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37575 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeJQBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:40:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id u6-v6so8631787plz.4;
        Tue, 16 Oct 2018 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJ7jlu6CXYBRJ32jnYN+KjBfwTl1or5fEQ64D/tbQmY=;
        b=OjBcqykKspT44N0iEChnWu9Po+K9c2mGDzFH0vGAS3KtJkvk3ivadE8TqAGUX+faMY
         a+dZ2XZUotX6sKDiautmpmXxVTmQX4N5hy6F3aRVXCftMqgkI7aRU6lv7l6P/nmOA0Cs
         MjXi/EuOLPDzsbROeI5usK+rk1eFGC5lzB1nU9OE6gFUF49+G6U6Hu5IbZ3jYOB09Ilt
         irQcdeRoYc+6Joi4qGd3d+Yi9lKtNWffWhppDV0EkTETVz5wWTn6M4zt0SHCO4YdmMqn
         y+wle+3JCVzK8TnB2RY12noIihsaHFC/Ri+WKKZRRVFIDN7elYqotv9KJR1clb7sVw0Q
         5bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJ7jlu6CXYBRJ32jnYN+KjBfwTl1or5fEQ64D/tbQmY=;
        b=jZV74E7LBr8euTyd7oDqYzkpS5xMOyNSwJNTcA+kq8SvnhifSglcS02GcutHXoZpCf
         C2t5RQGKLF8g6JpJZZgKE+rm97pBSrdI5acxAo64jj1lnLVs3riCxsB0XztnO85+yRq+
         haULqpbTQbzj2xw9zADterH6A/quLAaZE4htme7yq9l0wdf0B6M6zh4Rqj11x8JfY1At
         X2hLIY/1ir/2avduGPGIfxoWOegbpeGuYXI1V+L6MAv609wmSC0IrcAHWa1XAWuiqEAj
         9t/m0kmqTHA/4jAALRfsHvfOrlX3sXM+GlzRPM1U9qts8L6Hpz3h5xK5V+OIB8Ao5AGS
         bThQ==
X-Gm-Message-State: ABuFfog6CDJB8AH55rIdvKZ2prhf3+KHDf3ww8D054ftznW6lbYOY3Sj
        qd9Qe77rM0e6hxCICHj2C50=
X-Google-Smtp-Source: ACcGV63/KobcMZR9GdOqrVamvvogp0MIDmT534i2lWju+oAhBI7r6m4e9gJQkSPHnHN87HjleOKdLQ==
X-Received: by 2002:a17:902:22cc:: with SMTP id o12-v6mr22598421plg.108.1539712121860;
        Tue, 16 Oct 2018 10:48:41 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id t85-v6sm23269071pfi.73.2018.10.16.10.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 10:48:40 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:48:38 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Input: sx8654 - add sx8650 support
Message-ID: <20181016174838.GD230131@dtor-ws>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016092248.27288-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016092248.27288-1-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:22:48AM +0200, Richard Leitner wrote:
> The sx8654 and sx8650 are quite similar, therefore add support for the
> sx8650 within the sx8654 driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 186 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 163 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 622283b49d7c..33f7a0be4ef8 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -29,12 +29,13 @@
>  
>  #include <linux/input.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
> +#include <linux/hrtimer.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -44,9 +45,11 @@
>  #define I2C_REG_IRQSRC			0x23
>  #define I2C_REG_SOFTRESET		0x3f
>  
> +#define I2C_REG_SX8650_STAT		0x05
> +#define SX8650_STAT_CONVIRQ		BIT(7)
> +
>  /* commands */
>  #define CMD_READ_REGISTER		0x40
> -#define CMD_MANUAL			0xc0
>  #define CMD_PENTRG			0xe0
>  
>  /* value for I2C_REG_SOFTRESET */
> @@ -58,11 +61,12 @@
>  
>  /* bits for RegTouch1 */
>  #define CONDIRQ				0x20
> +#define RPDNT_100K			0x00
>  #define FILT_7SA			0x03
>  
>  /* bits for I2C_REG_CHANMASK */
> -#define CONV_X				0x80
> -#define CONV_Y				0x40
> +#define CONV_X				BIT(7)
> +#define CONV_Y				BIT(6)

If you are using BIT() you need to include include/linux/bitops.h

I also would prefer conversion to using BIT() as a separate patch.

>  
>  /* coordinates rate: higher nibble of CTRL0 register */
>  #define RATE_MANUAL			0x00
> @@ -71,14 +75,110 @@
>  /* power delay: lower nibble of CTRL0 register */
>  #define POWDLY_1_1MS			0x0b
>  
> +/* for sx8650, as we have no pen release IRQ there: timeout in ns following the
> + * last PENIRQ after which we assume the pen is lifted.
> + */
> +#define SX8650_PENIRQ_TIMEOUT		(80 * 1100 * 1000)
> +
>  #define MAX_12BIT			((1 << 12) - 1)
> +#define MAX_I2C_READ_LEN		10 /* see datasheet section 5.1.5 */
> +
> +/* channel definition */
> +#define CH_X				0x00
> +#define CH_Y				0x01
> +
> +struct sx865x_data {
> +	u8 cmd_manual;
> +	u8 chan_mask;
> +	u8 has_irq_penrelease;
> +	u8 has_reg_irqmask;
> +	irq_handler_t irqh;
> +};
>  
>  struct sx8654 {
>  	struct input_dev *input;
>  	struct i2c_client *client;
>  	struct gpio_desc *gpio_reset;
> +	struct hrtimer timer;

Does this have to be hrtimer? Can regular timer be used?

> +
> +	const struct sx865x_data *data;
>  };
>  
> +static enum hrtimer_restart sx865x_penrelease_timer_handler(struct hrtimer *h)
> +{
> +	struct sx8654 *ts = container_of(h, struct sx8654, timer);
> +
> +	input_report_key(ts->input, BTN_TOUCH, 0);
> +	input_sync(ts->input);
> +	dev_dbg(&ts->client->dev, "penrelease by timer\n");
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t sx8650_irq(int irq, void *handle)
> +{
> +	struct sx8654 *ts = handle;
> +	struct device *dev = &ts->client->dev;
> +	int len, i, ret;
> +	u8 stat;
> +	u16 x, y;
> +	u8 data[MAX_I2C_READ_LEN];
> +	u16 ch;
> +	u16 chdata;
> +	u8 readlen = hweight32(ts->data->chan_mask) * 2;
> +
> +	stat = i2c_smbus_read_byte_data(ts->client, CMD_READ_REGISTER
> +						    | I2C_REG_SX8650_STAT);
> +
> +	if (!(stat & SX8650_STAT_CONVIRQ)) {
> +		dev_dbg(dev, "%s ignore stat [0x%02x]", __func__, stat);
> +		return IRQ_HANDLED;
> +	}
> +
> +	len = i2c_master_recv(ts->client, data, readlen);
> +	if (len != readlen) {
> +		dev_dbg(dev, "ignore short recv (%d)\n", len);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = hrtimer_try_to_cancel(&ts->timer);
> +
> +	x = 0;
> +	y = 0;
> +	for (i = 0; (i + 1) < len; i++) {
> +		chdata = data[i] << 8;
> +		i++;
> +		chdata += data[i];
> +
> +		if (unlikely(chdata == 0xFFFF)) {
> +			dev_dbg(dev, "invalid qualified data @ %d\n", i);
> +			continue;
> +		} else if (unlikely(chdata & 0x8000)) {
> +			dev_warn(dev, "hibit @ %d [0x%04x]\n", i, chdata);
> +			continue;
> +		}
> +
> +		ch = chdata >> 12;
> +		if      (ch == CH_X)
> +			x = chdata & MAX_12BIT;
> +		else if (ch == CH_Y)
> +			y = chdata & MAX_12BIT;
> +		else
> +			dev_warn(dev, "unknown channel %d [0x%04x]\n", ch,
> +				 chdata);
> +	}
> +
> +	input_report_abs(ts->input, ABS_X, x);
> +	input_report_abs(ts->input, ABS_Y, y);
> +	input_report_key(ts->input, BTN_TOUCH, 1);
> +	input_sync(ts->input);
> +	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
> +
> +	hrtimer_start(&ts->timer, ktime_set(0, SX8650_PENIRQ_TIMEOUT),
> +		      HRTIMER_MODE_REL);
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t sx8654_irq(int irq, void *handle)
>  {
>  	struct sx8654 *sx8654 = handle;
> @@ -127,6 +227,22 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct sx865x_data sx8650_data = {
> +	.cmd_manual = 0xb0,
> +	.has_irq_penrelease = 0,
> +	.has_reg_irqmask = 0,
> +	.chan_mask = (CONV_X | CONV_Y),
> +	.irqh = sx8650_irq,
> +};
> +
> +static const struct sx865x_data sx8654_data = {
> +	.cmd_manual = 0xc0,
> +	.has_irq_penrelease = 1,
> +	.has_reg_irqmask = 1,
> +	.chan_mask = (CONV_X | CONV_Y),
> +	.irqh = sx8654_irq,
> +};
> +
>  static int sx8654_reset(struct sx8654 *ts)
>  {
>  	int err;
> @@ -182,13 +298,13 @@ static void sx8654_close(struct input_dev *dev)
>  	disable_irq(client->irq);
>  
>  	/* enable manual mode mode */
> -	error = i2c_smbus_write_byte(client, CMD_MANUAL);
> +	error = i2c_smbus_write_byte(client, sx8654->data->cmd_manual);
>  	if (error) {
>  		dev_err(&client->dev, "writing command CMD_MANUAL failed");
>  		return;
>  	}
>  
> -	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, 0);
> +	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH0, RATE_MANUAL);
>  	if (error) {
>  		dev_err(&client->dev, "writing to I2C_REG_TOUCH0 failed");
>  		return;
> @@ -196,10 +312,30 @@ static void sx8654_close(struct input_dev *dev)
>  }
>  
>  #ifdef CONFIG_OF
> +static const struct of_device_id sx8654_of_match[] = {
> +	{
> +		.compatible = "semtech,sx8650",
> +		.data = &sx8650_data,
> +	}, {
> +		.compatible = "semtech,sx8654",
> +		.data = &sx8654_data,
> +	}, {
> +		.compatible = "semtech,sx8655",
> +		.data = &sx8654_data,
> +	}, {
> +		.compatible = "semtech,sx8656",
> +		.data = &sx8654_data,
> +	}, {},
> +};
> +MODULE_DEVICE_TABLE(of, sx8654_of_match);
> +
>  static int sx8654_get_ofdata(struct sx8654 *ts)
>  {
>  	struct device *dev = &ts->client->dev;
>  	struct device_node *node = dev->of_node;
> +	const struct of_device_id *of_id = of_match_device(sx8654_of_match,
> +							   dev);

If you use of_device_get_match_data() you do not need to move device
table around.

> +	const struct sx865x_data *data = (struct sx865x_data *)of_id->data;
>  	int err;
>  
>  	if (!node) {
> @@ -207,6 +343,8 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
>  		return 0;
>  	}
>  
> +	ts->data = data;
> +
>  	ts->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (PTR_ERR(ts->gpio_reset) == -EPROBE_DEFER) {
>  		return -EPROBE_DEFER;
> @@ -219,18 +357,11 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
>  
>  	return 0;
>  }
> -
> -static const struct of_device_id sx8654_of_match[] = {
> -	{ .compatible = "semtech,sx8654", },
> -	{ .compatible = "semtech,sx8655", },
> -	{ .compatible = "semtech,sx8656", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, sx8654_of_match);
>  #else /* CONFIG_OF */
>  static int sx8654_get_ofdata(struct sx8654 *ts)
>  {
>  	ts->gpio_reset = NULL;
> +	ts->data = &sx8654_data;
>  	return 0;
>  }
>  #endif /* CONFIG_OF */
> @@ -258,6 +389,12 @@ static int sx8654_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	if (!sx8654->data->has_irq_penrelease) {
> +		dev_dbg(&client->dev, "use timer for penrelease\n");
> +		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		sx8654->timer.function = sx865x_penrelease_timer_handler;
> +	}
> +
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
> @@ -284,29 +421,31 @@ static int sx8654_probe(struct i2c_client *client,
>  	}
>  
>  	error = i2c_smbus_write_byte_data(client, I2C_REG_CHANMASK,
> -					  CONV_X | CONV_Y);
> +					  sx8654->data->chan_mask);
>  	if (error) {
>  		dev_err(&client->dev, "writing to I2C_REG_CHANMASK failed");
>  		return error;
>  	}
>  
> -	error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
> -					  IRQ_PENTOUCH_TOUCHCONVDONE |
> -						IRQ_PENRELEASE);
> -	if (error) {
> -		dev_err(&client->dev, "writing to I2C_REG_IRQMASK failed");
> -		return error;
> +	if (sx8654->data->has_reg_irqmask) {
> +		error = i2c_smbus_write_byte_data(client, I2C_REG_IRQMASK,
> +						  IRQ_PENTOUCH_TOUCHCONVDONE |
> +							IRQ_PENRELEASE);
> +		if (error) {
> +			dev_err(&client->dev, "writing I2C_REG_IRQMASK failed");
> +			return error;
> +		}
>  	}
>  
>  	error = i2c_smbus_write_byte_data(client, I2C_REG_TOUCH1,
> -					  CONDIRQ | FILT_7SA);
> +					  CONDIRQ | RPDNT_100K | FILT_7SA);
>  	if (error) {
>  		dev_err(&client->dev, "writing to I2C_REG_TOUCH1 failed");
>  		return error;
>  	}
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
> -					  NULL, sx8654_irq,
> +					  NULL, sx8654->data->irqh,
>  					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					  client->name, sx8654);
>  	if (error) {
> @@ -327,6 +466,7 @@ static int sx8654_probe(struct i2c_client *client,
>  }
>  
>  static const struct i2c_device_id sx8654_id_table[] = {
> +	{ "semtech_sx8650", 0 },

Can we add the data here as well?

>  	{ "semtech_sx8654", 0 },
>  	{ "semtech_sx8655", 0 },
>  	{ "semtech_sx8656", 0 },
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
