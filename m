Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744BCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB5220823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHqnWIuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfBFSxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:53:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33448 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfBFSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:52:59 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so3309549pgu.0;
        Wed, 06 Feb 2019 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cno90ohGQF2JbsUysofMjjNYUwQpuoQ2IBziIabjw8I=;
        b=WHqnWIuki9bScM9UcPIvDJZoiD/fcZtja2RP2J6sFbXPGyJPH4hxTJ00Xbz1ZOg5qF
         NAo878Ukun5YZdLUwecYWHFrFZQuBHXXutCLicbGIztMwE1p3DCxFJlC3xkSZmsWas5Y
         ntEvhYCeO/hkNNAGIF9TjEW1Y48sD8h/WWeXVty0zFSYqrBG91bXKQMmJRkHu7Jm9OAG
         AMQjvBfnHZMQSSFHOxENYLOYfeYSg865bsznkmVmZk3c7p22xQ+/T6cKOP7A6BuzAf05
         gowhXOudkrsWIRIyInCzzcR4P/Qf0IK6aNSz7GP28X9PH3NObT/xBm5xqVLWojqRctVF
         ZVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cno90ohGQF2JbsUysofMjjNYUwQpuoQ2IBziIabjw8I=;
        b=kYKIvRcb3I+7xDAK1VlpWJ5w+U8NnXWuwGxnRVZKHOP5DWcDe/R3g0eZMP+44YJn8g
         EQhFIQFAEszBLsSKfOn56Hyz+FdV6wDXmLkjIcKQEencA+okvrt4EkgzEa76kU7PvTWy
         t9lq20OFb4JyLpw0Kv6plFGz5IA9NZ7JPRuXkrdne8G9KpLDeBRF+P7nztXBWQFn/rsL
         Ndb8f7CqlkJjgbqpCkaSHZCYuKpmh/F0e5qhYvqGvI4vk893hbGE0sjWlZmsEPcrvoLj
         VC5KP2q0VjT2sW/Rxqf8CBjZXHY2J6WMgQT9gQ2RAjLx7qvXgPsKXOEu4XAb4QJ7Epl/
         +ngw==
X-Gm-Message-State: AHQUAuacu4RsaBEURmTtYpo2alz7vQVOAxPhTePHLVYuFlvd31XDXT/s
        Us0tI6x5ZOZvMQUqTgbim3Y=
X-Google-Smtp-Source: AHgI3IaejXDWgbwDf4WngWEDQ6D4/qex53qubFd8t8ezyZftZqBmNj6fMcV8ondYz+hBA2H9Txv6tQ==
X-Received: by 2002:aa7:8a4d:: with SMTP id n13mr5489183pfa.81.1549479178341;
        Wed, 06 Feb 2019 10:52:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id i5sm9706011pfg.34.2019.02.06.10.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:52:57 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:52:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] input: misc: bma150: Use managed resources helpers
Message-ID: <20190206185255.GC174258@dtor-ws>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
 <20190202151806.9064-3-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190202151806.9064-3-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 04:18:03PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> The driver can be cleaned up by using managed resource helpers
> 
> Changes from v1:
>  - Correct devm input unregistering
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/bma150.c | 44 ++++++++++---------------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index 1efcfdf9f8a8..79acaaf86b7e 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -471,7 +471,7 @@ static int bma150_register_input_device(struct bma150_data *bma150)
>  	struct input_dev *idev;
>  	int error;
>  
> -	idev = input_allocate_device();
> +	idev = devm_input_allocate_device(&bma150->client->dev);
>  	if (!idev)
>  		return -ENOMEM;
>  
> @@ -482,10 +482,8 @@ static int bma150_register_input_device(struct bma150_data *bma150)
>  	input_set_drvdata(idev, bma150);
>  
>  	error = input_register_device(idev);
> -	if (error) {
> -		input_free_device(idev);
> +	if (error)
>  		return error;
> -	}
>  
>  	bma150->input = idev;
>  	return 0;
> @@ -496,7 +494,7 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
>  	struct input_polled_dev *ipoll_dev;
>  	int error;
>  
> -	ipoll_dev = input_allocate_polled_device();
> +	ipoll_dev = devm_input_allocate_polled_device(&bma150->client->dev);
>  	if (!ipoll_dev)
>  		return -ENOMEM;
>  
> @@ -511,10 +509,8 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
>  	bma150_init_input_device(bma150, ipoll_dev->input);
>  
>  	error = input_register_polled_device(ipoll_dev);
> -	if (error) {
> -		input_free_polled_device(ipoll_dev);
> +	if (error)
>  		return error;
> -	}
>  
>  	bma150->input_polled = ipoll_dev;
>  	bma150->input = ipoll_dev->input;
> @@ -543,7 +539,8 @@ static int bma150_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	bma150 = kzalloc(sizeof(struct bma150_data), GFP_KERNEL);
> +	bma150 = devm_kzalloc(&client->dev, sizeof(struct bma150_data),
> +			      GFP_KERNEL);
>  	if (!bma150)
>  		return -ENOMEM;
>  
> @@ -556,7 +553,7 @@ static int bma150_probe(struct i2c_client *client,
>  				dev_err(&client->dev,
>  					"IRQ GPIO conf. error %d, error %d\n",
>  					client->irq, error);
> -				goto err_free_mem;
> +				return error;
>  			}
>  		}
>  		cfg = &pdata->cfg;
> @@ -566,14 +563,14 @@ static int bma150_probe(struct i2c_client *client,
>  
>  	error = bma150_initialize(bma150, cfg);
>  	if (error)
> -		goto err_free_mem;
> +		return error;
>  
>  	if (client->irq > 0) {
>  		error = bma150_register_input_device(bma150);
>  		if (error)
> -			goto err_free_mem;
> +			return error;
>  
> -		error = request_threaded_irq(client->irq,
> +		error = devm_request_threaded_irq(&client->dev, client->irq,
>  					NULL, bma150_irq_thread,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					BMA150_DRIVER, bma150);
> @@ -581,13 +578,12 @@ static int bma150_probe(struct i2c_client *client,
>  			dev_err(&client->dev,
>  				"irq request failed %d, error %d\n",
>  				client->irq, error);
> -			input_unregister_device(bma150->input);
> -			goto err_free_mem;
> +			return error;
>  		}
>  	} else {
>  		error = bma150_register_polled_device(bma150);
>  		if (error)
> -			goto err_free_mem;
> +			return error;
>  	}
>  
>  	i2c_set_clientdata(client, bma150);
> @@ -595,28 +591,12 @@ static int bma150_probe(struct i2c_client *client,
>  	pm_runtime_enable(&client->dev);
>  
>  	return 0;
> -
> -err_free_mem:
> -	kfree(bma150);
> -	return error;
>  }
>  
>  static int bma150_remove(struct i2c_client *client)
>  {
> -	struct bma150_data *bma150 = i2c_get_clientdata(client);
> -
>  	pm_runtime_disable(&client->dev);
>  
> -	if (client->irq > 0) {
> -		free_irq(client->irq, bma150);
> -		input_unregister_device(bma150->input);
> -	} else {
> -		input_unregister_polled_device(bma150->input_polled);
> -		input_free_polled_device(bma150->input_polled);
> -	}
> -
> -	kfree(bma150);
> -
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Dmitry
