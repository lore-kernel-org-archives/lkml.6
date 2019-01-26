Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD7CC282C0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4FE21902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 01:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS1QWiGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAZBRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 20:17:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAZBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 20:17:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so5498286pfd.12;
        Fri, 25 Jan 2019 17:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zFUPyiecKChK/e0u1mqAoiYkxRi+n9AALMCCHtZq21E=;
        b=eS1QWiGCW57PTbymz4aexvUE8gvvCdzeS0ozTrSoN3cGtux9Yj5RIlgWhqn37EDhjB
         xCu6nLE6s6COoGqGGxijWE07wutpgvfYCc4ldY7qtKdIeLYfH09Dpx5NEiZ2FCYf9KVX
         FSqlZ6NZGmpNcw2IIAITyg05GKuSricdSSTfuwMcfZaLNrDm/668HtyB40HuCcgrikmj
         IiBBH8pVViFpssKoxF5u8n7+l+L3Y6wqfm1Y+qRep8qA0tXuM0WtfEVmAs7a/lJlblZk
         78zwHhsg6K93jZ97VjlYFxSVKz4jqr6RQZD0HtV1wXPYXj3oM6PM2yvqCu5SlR/+Z4w6
         a45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zFUPyiecKChK/e0u1mqAoiYkxRi+n9AALMCCHtZq21E=;
        b=Gxkdv+ZHqgFFp0HrL0oO+KRGH2gf6s5eGooGfH6HL6Ium05xklTp9sPe5ftYEJe3Lp
         Ab7b7b82Dl6zXbHMNreKsNTbT53f5+CMM42oodlfgO+P6g9T1ctVI3qvil52g2UEo/v+
         D1akZkvYiPLZ1EWJr2CsXu0lWDSTs0CIvqmZb2+zRm97muKSS5TwBmAx+qx8vG2o53Y0
         +hSmr1PdGuuFwrak6qxY9zJOQs5fqnIdTzZDEiCK0d4h4Ki5elfUfBud8EMMz4txPBoT
         Ba5vstm1oqHAdCAlu64/LuxHdXEUWMpy6fgovVsMEILkRf3W1bDLn4EzMW9Tcej49TdY
         Dq1A==
X-Gm-Message-State: AJcUukeVebGzNo/6rl6faI+eI2Qsnr4I9jWXtBSZuxMKe3so1ThjJBsu
        BI3z1x5t3jWqzb+snUSOi8I=
X-Google-Smtp-Source: ALg8bN4HqvELvehjR7nGNb3LnGADpP5rH0YCC2K40KQUGkzv86ZXtsCc2Zc1BDJbJ1t/RHfGKDDHBQ==
X-Received: by 2002:a63:ed42:: with SMTP id m2mr12048524pgk.147.1548465426156;
        Fri, 25 Jan 2019 17:17:06 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id d25sm36516349pfe.40.2019.01.25.17.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 17:17:05 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:17:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] input: misc: gp2a: Use managed resource helpers
Message-ID: <20190126011702.GB212026@dtor-ws>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
 <20190125175045.22576-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125175045.22576-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:50:42PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Simplify cleanup of failures by using managed resource helpers
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/input/misc/gp2ap002a00f.c | 37 ++++++++++---------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
> index c6a29e57b5e4..79c8c4c56d1a 100644
> --- a/drivers/input/misc/gp2ap002a00f.c
> +++ b/drivers/input/misc/gp2ap002a00f.c
> @@ -138,14 +138,15 @@ static int gp2a_probe(struct i2c_client *client,
>  			return error;
>  	}
>  
> -	error = gpio_request_one(pdata->vout_gpio, GPIOF_IN, GP2A_I2C_NAME);
> +	error = devm_gpio_request_one(&client->dev, pdata->vout_gpio,
> +				      GPIOF_IN, GP2A_I2C_NAME);
>  	if (error)
>  		goto err_hw_shutdown;
>  
> -	dt = kzalloc(sizeof(struct gp2a_data), GFP_KERNEL);
> +	dt = devm_kzalloc(&client->dev, sizeof(struct gp2a_data), GFP_KERNEL);
>  	if (!dt) {
>  		error = -ENOMEM;
> -		goto err_free_gpio;
> +		goto err_hw_shutdown;
>  	}
>  
>  	dt->pdata = pdata;
> @@ -153,12 +154,12 @@ static int gp2a_probe(struct i2c_client *client,
>  
>  	error = gp2a_initialize(dt);
>  	if (error < 0)
> -		goto err_free_mem;
> +		goto err_hw_shutdown;
>  
> -	dt->input = input_allocate_device();
> +	dt->input = devm_input_allocate_device(&client->dev);
>  	if (!dt->input) {
>  		error = -ENOMEM;
> -		goto err_free_mem;
> +		goto err_hw_shutdown;
>  	}
>  
>  	input_set_drvdata(dt->input, dt);
> @@ -171,19 +172,18 @@ static int gp2a_probe(struct i2c_client *client,
>  
>  	input_set_capability(dt->input, EV_SW, SW_FRONT_PROXIMITY);
>  
> -	error = request_threaded_irq(client->irq, NULL, gp2a_irq,
> -			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> -				IRQF_ONESHOT,
> -			GP2A_I2C_NAME, dt);
> +	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +			gp2a_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
> +			IRQF_ONESHOT, GP2A_I2C_NAME, dt);
>  	if (error) {
>  		dev_err(&client->dev, "irq request failed\n");
> -		goto err_free_input_dev;
> +		goto err_hw_shutdown;
>  	}
>  
>  	error = input_register_device(dt->input);
>  	if (error) {
>  		dev_err(&client->dev, "device registration failed\n");
> -		goto err_free_irq;
> +		goto err_hw_shutdown;
>  	}
>  
>  	device_init_wakeup(&client->dev, pdata->wakeup);
> @@ -191,14 +191,6 @@ static int gp2a_probe(struct i2c_client *client,
>  
>  	return 0;
>  
> -err_free_irq:
> -	free_irq(client->irq, dt);
> -err_free_input_dev:
> -	input_free_device(dt->input);
> -err_free_mem:
> -	kfree(dt);
> -err_free_gpio:
> -	gpio_free(pdata->vout_gpio);
>  err_hw_shutdown:
>  	if (pdata->hw_shutdown)
>  		pdata->hw_shutdown(client);
> @@ -210,12 +202,7 @@ static int gp2a_remove(struct i2c_client *client)
>  	struct gp2a_data *dt = i2c_get_clientdata(client);
>  	const struct gp2a_platform_data *pdata = dt->pdata;
>  
> -	free_irq(client->irq, dt);
> -
>  	input_unregister_device(dt->input);

You do not need explicitly unregister input device if it is managed
(allocated with devm).

> -	kfree(dt);
> -
> -	gpio_free(pdata->vout_gpio);
>  
>  	if (pdata->hw_shutdown)
>  		pdata->hw_shutdown(client);

This is however is wrong, as you can't shutdown hardware before
disapling/freeing IRQ, etc. Given that there are no users of
gp2a_platform_data in kernel I'd recommend creating a preparatory patch
removing platform data support from the driver.

Thanks.

-- 
Dmitry
