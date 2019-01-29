Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2CC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8F52177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3AX2478"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfA2A0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:26:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40178 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA2A0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:26:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so8514070plq.7;
        Mon, 28 Jan 2019 16:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tkAmkW6+O8lwaIXlC7KKsWzv1ehiI1Q+Mnv5n+nuoYs=;
        b=P3AX2478tFAt3I549N96NKeobqS6QEXmhA1JBr8yw96hlDjgN250GdFjdcLPMrXFhw
         Flme0LYsNxsuIuaqe2y8RSRSlSwK8zXJmvAhCrIayAvOaCzTrCO4SpU310lIH0Ia9Blb
         Nbaz5sYHfp5NcqPg5VlHs3FFE5IsV4V9mDrxtOrlQoj9HW+6kj8201niRC/1oFx8i9cJ
         NdEm1+VGzzlfDve2X5/tqBJqDiNM+WRWD9zZDGx0ApdowbbJtgt/C/cPKrUxrMIQJD0/
         Sggg5+T3ZHKnTChJKC6w4jlSy3BsSH7ejuJkd3SFoE3W54JfKnVsFIm3Xzjy6h5oixkT
         ByhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tkAmkW6+O8lwaIXlC7KKsWzv1ehiI1Q+Mnv5n+nuoYs=;
        b=FFixSa4I+hOoMBS+oySPqm9+CGHDhgpNIrwFoH+NZCr6ELt63W96CV5i6IKhCwowTP
         VaG/XyCAgisaHq0YF3MsrWRhUhqNpZ9NpZcEy0j5KbWFs/IugCrIqJcXjH7nJShMhgKn
         rns5/vr0aUWCMxz54GNis0gOCFIm/1iFjD06q+Hv37cr3Croa4ke4VLJ/hSCt392V2mx
         VapvVIicKoq6xrlfyDqNs0A4LMpySC7iKe0ksnA0yLTFGMpWSLGMnYP6NAjUxjcXxUv/
         SicrED89sXX30kJDeuHrVji4zuH/NLrBUGsSb+3VF4lFgU59Ez+xejHcsLj8d0aS3vYP
         xprg==
X-Gm-Message-State: AJcUukdiCGkCCMXHuHxsKSrsr70dGk7gHszGAbuJGCyLuV6dHLEIsZr2
        CXK1mb0+1QHEow017lCYztM=
X-Google-Smtp-Source: ALg8bN5aSRhs2vEBjo/Hu5e21lUNes9d/yZK1DldhzmRfHkUrpHzvtmff49Z9P2Xw+Aiay2YHBKJgA==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr24065786pls.155.1548721579990;
        Mon, 28 Jan 2019 16:26:19 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v191sm63989000pgb.77.2019.01.28.16.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 16:26:19 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:26:17 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/8] Input: sx8654 - add reset-gpio support
Message-ID: <20190129002617.GJ34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218083606.25795-3-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218083606.25795-3-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:36:00AM +0100, Richard Leitner wrote:
> The sx8654 features a NRST input which may be connected to a GPIO.
> Therefore add support for hard-resetting the sx8654 via this NRST.
> 
> If the reset-gpio property is provided the sx8654 is resetted via NRST
> instead of the soft-reset via I2C.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 40 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index ed29db3ec731..238f56b1581b 100644
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

I rearranged code a bit to avoid this early return and applied. Thank
you.

> +	}
> +
> +	dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
> +	err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
> +					SOFTRESET_VALUE);
> +	if (err)
> +		return err;
> +	else
> +		return 0;
> +}
> +
>  static int sx8654_open(struct input_dev *dev)
>  {
>  	struct sx8654 *sx8654 = input_get_drvdata(dev);
> @@ -186,6 +210,17 @@ static int sx8654_probe(struct i2c_client *client,
>  	if (!sx8654)
>  		return -ENOMEM;
>  
> +	sx8654->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(sx8654->gpio_reset)) {
> +		error = PTR_ERR(sx8654->gpio_reset);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev, "unable to get reset-gpio: %d\n",
> +				error);
> +		return error;
> +	}
> +	dev_dbg(&client->dev, "got GPIO reset pin\n");
> +
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
> @@ -206,10 +241,9 @@ static int sx8654_probe(struct i2c_client *client,
>  
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
> -- 
> 2.11.0
> 

-- 
Dmitry
