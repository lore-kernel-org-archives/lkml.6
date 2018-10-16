Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952C621477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnliSksN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952C621477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJQBni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:43:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44633 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:43:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so11192514pgu.11;
        Tue, 16 Oct 2018 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kn7I0Ez1LpEX4Rz4JbMuLmCPWSS9RClg6de8L5AxGPI=;
        b=VnliSksN6ZE1kdDWM84jdtphQjLLVlnBgLUUx6aARZUbdTGlfdfqQAmJvqwolhvBgX
         Li9g7g+WLPIk/eRIy1GYz0j/GQtEghzAF343TSnp+T7UkLUAEFIJI7pxwOKd16q41Dxb
         LJfGCpBnhFKu1udBr2lLlCwAOzNn0RRntKqQaJDzZRL2V3IZXzLEj7O0ofseX2L7XpDp
         KUesI2djUbYPOJxZEeznYiV+rd6/uDmQQhAMCuS5b2BZl7auEU1KLZx1SNpmIbsBf/gu
         sjVnxWyiInsXVg949pZzBzlTnw/0+RXI3PKmPizpy5KpoTLkd5F1vT8T9n1RtmQeJllO
         P9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kn7I0Ez1LpEX4Rz4JbMuLmCPWSS9RClg6de8L5AxGPI=;
        b=U5SV3sCUy16LZJmpnBZYQXemdrUczRwHoMC6mcBTgbPLnnKQ21IKcLQlVRW+vjdCkz
         8AL2vdnKp68y1KyUIAkKKYtRCmxckAgsaQXW2C4WliQbOIwkRnc4tSBbzhIQwACHqE3t
         XtjyruApVowzzp3DPuGTswCDvqG3A2fC1ifyQCAPijTmTZm5nzi2wCYh5QCpL3FCSEPE
         cIk9tjAHtBzvRZrpFVOOQn7dQZhPb3vLQEs6sKX+p4wTcfPuIOmWvLMbbFxyzmscsXiM
         aizsNoV0UKcrmdDr6jDF4lntCU9GKdJH2s3nj2FXY/godBeGjMHk2mlDaU9gaxgaFF0Y
         F2gg==
X-Gm-Message-State: ABuFfohmnYLcdzonxPl2M/CTxy/jjFHzSf9w0Jyn3AlYPPm9cxGgB8PC
        lf71iWLrMidKPD11HFTBLpI=
X-Google-Smtp-Source: ACcGV62AexGXxMhDSXZqd5xHdWeLE0LhuZyZnaEDxedHIEnhNb2XotfLcc9vjNfm6AZhyvYCfGCJKA==
X-Received: by 2002:a62:3a84:: with SMTP id v4-v6mr22803103pfj.118.1539712323766;
        Tue, 16 Oct 2018 10:52:03 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y10-v6sm22991365pgi.85.2018.10.16.10.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 10:52:02 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:52:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Input: sx8654 - use common of_touchscreen functions
Message-ID: <20181016175200.GE230131@dtor-ws>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016092310.27346-1-richard.leitner@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016092310.27346-1-richard.leitner@skidata.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:23:10AM +0200, Richard Leitner wrote:
> of_touchscreen.c provides a common interface for a axis invertion and
> swapping of touchscreens. Therefore use it in the sx8654 driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 33f7a0be4ef8..08b064f96b4e 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -36,6 +36,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/hrtimer.h>
> +#include <linux/input/touchscreen.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -100,6 +101,7 @@ struct sx8654 {
>  	struct i2c_client *client;
>  	struct gpio_desc *gpio_reset;
>  	struct hrtimer timer;
> +	struct touchscreen_properties props;
>  
>  	const struct sx865x_data *data;
>  };
> @@ -168,8 +170,7 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
>  				 chdata);
>  	}
>  
> -	input_report_abs(ts->input, ABS_X, x);
> -	input_report_abs(ts->input, ABS_Y, y);
> +	touchscreen_report_pos(ts->input, &ts->props, x, y, false);
>  	input_report_key(ts->input, BTN_TOUCH, 1);
>  	input_sync(ts->input);
>  	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
> @@ -215,8 +216,8 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  		x = ((data[0] & 0xf) << 8) | (data[1]);
>  		y = ((data[2] & 0xf) << 8) | (data[3]);
>  
> -		input_report_abs(sx8654->input, ABS_X, x);
> -		input_report_abs(sx8654->input, ABS_Y, y);
> +		touchscreen_report_pos(sx8654->input, &sx8654->props, x, y,
> +				       false);
>  		input_report_key(sx8654->input, BTN_TOUCH, 1);
>  		input_sync(sx8654->input);
>  
> @@ -355,6 +356,8 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
>  	}
>  	dev_dbg(dev, "got GPIO reset pin\n");
>  

You need to mark axes used by the device before calling
touchscreen_parse_properties(), otherwise you'll get warnings if
corresponding property is present in DT.

> +	touchscreen_parse_properties(ts->input, false, &ts->props);
> +
>  	return 0;
>  }
>  #else /* CONFIG_OF */
> @@ -380,25 +383,11 @@ static int sx8654_probe(struct i2c_client *client,
>  	sx8654 = devm_kzalloc(&client->dev, sizeof(*sx8654), GFP_KERNEL);
>  	if (!sx8654)
>  		return -ENOMEM;
> -
>  	sx8654->client = client;
>  
> -	error = sx8654_get_ofdata(sx8654);
> -	if (error) {
> -		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
> -		return error;
> -	}
> -
> -	if (!sx8654->data->has_irq_penrelease) {
> -		dev_dbg(&client->dev, "use timer for penrelease\n");
> -		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -		sx8654->timer.function = sx865x_penrelease_timer_handler;
> -	}
> -
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
> -
>  	sx8654->input = input;
>  
>  	input->name = "SX8654 I2C Touchscreen";
> @@ -414,6 +403,18 @@ static int sx8654_probe(struct i2c_client *client,
>  
>  	input_set_drvdata(sx8654->input, sx8654);
>  
> +	error = sx8654_get_ofdata(sx8654);
> +	if (error) {
> +		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
> +		return error;
> +	}
> +
> +	if (!sx8654->data->has_irq_penrelease) {
> +		dev_dbg(&client->dev, "use timer for penrelease\n");
> +		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		sx8654->timer.function = sx865x_penrelease_timer_handler;
> +	}
> +
>  	error = sx8654_reset(sx8654);
>  	if (error) {
>  		dev_err(&client->dev, "reset failed");
> -- 
> 2.11.0
> 

-- 
Dmitry
