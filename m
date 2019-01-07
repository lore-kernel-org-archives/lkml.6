Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C4D20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r93Vecd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfAIHkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:40:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32777 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIHkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:40:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so3215211plo.0;
        Tue, 08 Jan 2019 23:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rI8Kflf9OfARMFM2U37LlEjaQELuvzt3WLUyIo/638s=;
        b=r93Vecd8879HeJcV3VrwX0nvl+y2wCKLWCdobVzguO8V0X8fNY76Au+X914MdxCqKn
         jTw5JJLUrj/whI0gF7HW+UzxMX6KYm67psCAxbhMNCTW9zHxQUg5OqbvBWgZFRUFhO6l
         DDWmoIYu9gy6KKQ9Szu5Jo/+wYhOcgZzQw2aj8lIPHdLO6hrjWuWc12RIBzderD2a2MF
         1VGPNfSuHQHshWscINn74sFS3svOfIH0QUjmtUwRK47VqwekUhnRWaA7dT7PnhALvRuv
         vYhFPtomqOVtKFG0WA8I2FPwrprja8XQgy0kN0tlXcP7/KW6NR7QVwqoLIZiHzQM75il
         Pn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rI8Kflf9OfARMFM2U37LlEjaQELuvzt3WLUyIo/638s=;
        b=LmUcaeNu4BfyJhbwbgNEoB8VDz3LCZVG5GSfzRyQLdAHG4CPzmI5FeH4/YtWnSqL66
         u/xOINjSjmtJRd8KNLt6jl0CzvBGDEF9uCJQ88m0zBbg+66RyRdgFeoDlpSN5WytuTdm
         nmJkg/6rEHZZsp5Cxn+l+c676Ug3QYIXv06tJPaqERXhhz8bJhvhwdCDLydaDtUPTY8z
         C3JfWaBSVLHFQE6s/EOsEe0+T8MxPW1SI/LQGBliZgtDm+/anO5w260JJnno7d165F9D
         Zf6b/wgJXexKwXKPppf+BvpFUNuU69VdlwAkvov29QuVH+aYgTMDqd2Ona3S/vtFHoNO
         tSSQ==
X-Gm-Message-State: AJcUukcIinep0RUykaew0Npia6ejCKfurWVXnL7XJK5dotA2RrL0R2xA
        UQaxQAtRtYuFUHF0OSSbUBw=
X-Google-Smtp-Source: ALg8bN72/+TQWrIHAbRu6sTom0/+fxGDuGh5+9FcEuhkWZLdE17l+NGVhWXNmO7y5RNwZRpdWHCs3w==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr5029835plf.233.1547019609180;
        Tue, 08 Jan 2019 23:40:09 -0800 (PST)
Received: from localhost (c-73-158-250-148.hsd1.ca.comcast.net. [73.158.250.148])
        by smtp.gmail.com with ESMTPSA id m9sm83572037pgd.32.2019.01.08.23.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 23:40:08 -0800 (PST)
Date:   Mon, 7 Jan 2019 23:00:09 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 2/4] Input: goodix - Add AVDD28-supply regulator
 support
Message-ID: <20190107230009.wfzozb6g6ucymngw@penguin>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215151802.18592-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Sat, Dec 15, 2018 at 08:48:00PM +0530, Jagan Teki wrote:
> Goodix CTP controllers have AVDD28 pin connected to voltage
> regulator which may not be turned on by default, like for GT5663.
> 
> Add support for such ctp used boards by adding voltage regulator
> handling code to goodix ctp driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/input/touchscreen/goodix.c | 33 +++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f2d9c2c41885..7371f6946098 100644
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
> +	struct regulator *avdd28;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -786,25 +788,41 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
> +	if (IS_ERR(ts->avdd28)) {
> +		error = PTR_ERR(ts->avdd28);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev,
> +				"Failed to get AVDD28 regulator: %d\n", error);
> +		return error;
> +	}
> +
> +	/* power the controller */
> +	error = regulator_enable(ts->avdd28);
> +	if (error) {
> +		dev_err(&client->dev, "Controller fail to enable AVDD28\n");
> +		return error;
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
> @@ -823,23 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
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
> +	regulator_disable(ts->avdd28);
> +	return error;
>  }
>  
>  static int goodix_ts_remove(struct i2c_client *client)
>  {
>  	struct goodix_ts_data *ts = i2c_get_clientdata(client);
>  
> +	regulator_disable(ts->avdd28);

This may be disabling the regulator too early. Please use
devm_add_action_or_reset() to install a custom devm handler that would
disable the regulator in line with the rest of devm unwinding flow.

>  	if (ts->gpiod_int && ts->gpiod_rst)
>  		wait_for_completion(&ts->firmware_loading_complete);
>  
> -- 
> 2.18.0.321.gffc6fa0e3
> 

Thanks.

-- 
Dmitry
