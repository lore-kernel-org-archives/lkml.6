Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0139C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D1922AE5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+f6lepw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D1922AE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeFVAHp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:07:45 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46718 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeFVAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:07:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so2127201pga.13;
        Thu, 21 Jun 2018 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=poppFcGIVdmV2yYummKW8RDQvdOg5eyHPJGjhPk0dqo=;
        b=I+f6lepwfeGNzdy9RaByZOOxBnHGa+SsnslcGHWDgQAipNXG8AzoakrRpwJtCZnSd1
         gRdpKv1jk7J9b9FzMzaxQFVdQHnHz4CMF7bApJ+j3tvvDidlFuDggwQuvV3w7wOD6Q4F
         BZj4myQlsHNWiPx2sz7ScG64iy00P4qoeY+aKPN13yazfwAtd0y8A+5IsAHffdi32vaK
         mCcylRThV2iMbFYv3OPlT8kApHVYm/ZYMScGLgVzuRkrTvSBkjBywYLdnCa9SpBLN/ej
         SXWSNVfC868nSor2QaQ9UyFY6d5ly3u/ASGNlvKCBVUeQa7Du+dPxZPYW2blyXCmR9sw
         FJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=poppFcGIVdmV2yYummKW8RDQvdOg5eyHPJGjhPk0dqo=;
        b=fwNTtXo6fjapHLFfpLOow/1Q4o6jFK+4Yj1zYtzgGmXhyEEbWNSJrvL/TgB1UBtMsk
         EiSyCmc/Mmhr/AkPZjiZVFS8wo5J1IYikiiZ5LQeJ6OyXsR+LcjsrBAB1gMEeFZ64fdN
         20zosAoeWQhPxaLBHVUYTXV1Pb7qHeq6NHIxrWDfLgrnHNK/1Q8HdMhHarJ0AUcwFO3A
         SfBmIS3Kjd2BH/nwH8+bPMH5lvkmgSkDlpAGboh6LdBsGFOzaf6prf0LGdlDCj1RWdZR
         QOqukBsAhjVBrUKpOPd5zG4msZ8730ikLFYfL6a1rxqiEKrRY0+eG8K79nI65zlNZcCO
         dhNA==
X-Gm-Message-State: APt69E3UvjKHiiOaRKxUIGUdDGdA8SHJNIcreEgefVR4zJTfMQhDz+lT
        /5j3zLW7LSHgunAKOfhO+bi1UMY1
X-Google-Smtp-Source: ADUXVKKtbPgGBOK+iRkqmgl5VbNl1ORnzZlpjurSH2EGBDYPUffQVLma0FiGccqsuuPPidIyRV9ciQ==
X-Received: by 2002:a62:4a0c:: with SMTP id x12-v6mr29651903pfa.142.1529626062211;
        Thu, 21 Jun 2018 17:07:42 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id a22-v6sm9312320pfi.124.2018.06.21.17.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 17:07:41 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:07:39 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] Input: ams_delta_serio: use private structure
Message-ID: <20180622000739.GB79890@dtor-ws>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-3-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621224128.17623-3-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:41:21AM +0200, Janusz Krzysztofik wrote:
> Introduce a driver private structure and allocate it on device probe.
> For now, use it instead of a static variable for storing a pointer to
> serio structure.  Subsequent patches will populate it with more members
> as needed.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> Changelog:
> v2: rebased on v4.18-rc1, no conflicts
> 
>  drivers/input/serio/ams_delta_serio.c | 69 ++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
> index a2a7fa19bf49..551a4fa73fe4 100644
> --- a/drivers/input/serio/ams_delta_serio.c
> +++ b/drivers/input/serio/ams_delta_serio.c
> @@ -37,17 +37,17 @@ MODULE_AUTHOR("Matt Callow");
>  MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
>  MODULE_LICENSE("GPL");
>  
> -static struct serio *ams_delta_serio;
> +struct ams_delta_serio {
> +	struct serio *serio;
> +};
>  
> -static int check_data(int data)
> +static int check_data(struct serio *serio, int data)
>  {
>  	int i, parity = 0;
>  
>  	/* check valid stop bit */
>  	if (!(data & 0x400)) {
> -		dev_warn(&ams_delta_serio->dev,
> -				"invalid stop bit, data=0x%X\n",
> -				data);
> +		dev_warn(&serio->dev, "invalid stop bit, data=0x%X\n", data);
>  		return SERIO_FRAME;
>  	}
>  	/* calculate the parity */
> @@ -57,9 +57,9 @@ static int check_data(int data)
>  	}
>  	/* it should be odd */
>  	if (!(parity & 0x01)) {
> -		dev_warn(&ams_delta_serio->dev,
> -				"parity check failed, data=0x%X parity=0x%X\n",
> -				data, parity);
> +		dev_warn(&serio->dev,
> +			 "parity check failed, data=0x%X parity=0x%X\n", data,
> +			 parity);
>  		return SERIO_PARITY;
>  	}
>  	return 0;
> @@ -67,6 +67,7 @@ static int check_data(int data)
>  
>  static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
>  {
> +	struct ams_delta_serio *priv = dev_id;
>  	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
>  	int data, dfl;
>  	u8 scancode;
> @@ -84,9 +85,9 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
>  		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
>  			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
>  
> -		dfl = check_data(data);
> +		dfl = check_data(priv->serio, data);
>  		scancode = (u8) (data >> 1) & 0xFF;
> -		serio_interrupt(ams_delta_serio, scancode, dfl);
> +		serio_interrupt(priv->serio, scancode, dfl);
>  	}
>  	return IRQ_HANDLED;
>  }
> @@ -130,21 +131,14 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
>  
>  static int ams_delta_serio_init(struct platform_device *pdev)
>  {
> +	struct ams_delta_serio *priv;
> +	struct serio *serio;
>  	int err;
>  
> -	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
> -	if (!ams_delta_serio)
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
>  		return -ENOMEM;
>  
> -	ams_delta_serio->id.type = SERIO_8042;
> -	ams_delta_serio->open = ams_delta_serio_open;
> -	ams_delta_serio->close = ams_delta_serio_close;
> -	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
> -			sizeof(ams_delta_serio->name));
> -	strlcpy(ams_delta_serio->phys, dev_name(&pdev->dev),
> -			sizeof(ams_delta_serio->phys));
> -	ams_delta_serio->dev.parent = &pdev->dev;
> -
>  	err = gpio_request_array(ams_delta_gpios,
>  				ARRAY_SIZE(ams_delta_gpios));
>  	if (err) {
> @@ -154,7 +148,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  
>  	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
>  			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
> -			DRIVER_NAME, 0);
> +			DRIVER_NAME, priv);
>  	if (err < 0) {
>  		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
>  		goto gpio;
> @@ -167,21 +161,44 @@ static int ams_delta_serio_init(struct platform_device *pdev)
>  	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
>  			handle_simple_irq);
>  
> -	serio_register_port(ams_delta_serio);
> -	dev_info(&ams_delta_serio->dev, "%s\n", ams_delta_serio->name);
> +	serio = kzalloc(sizeof(*serio), GFP_KERNEL);
> +	if (!serio) {
> +		err = -ENOMEM;
> +		goto irq;
> +	}
> +
> +	priv->serio = serio;
> +
> +	serio->id.type = SERIO_8042;
> +	serio->open = ams_delta_serio_open;
> +	serio->close = ams_delta_serio_close;
> +	strlcpy(serio->name, "AMS DELTA keyboard adapter", sizeof(serio->name));
> +	strlcpy(serio->phys, dev_name(&pdev->dev), sizeof(serio->phys));
> +	serio->dev.parent = &pdev->dev;
> +	serio->port_data = priv;
> +
> +	serio_register_port(serio);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	dev_info(&serio->dev, "%s\n", serio->name);
>  
>  	return 0;
> +
> +irq:
> +	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
>  gpio:
>  	gpio_free_array(ams_delta_gpios,
>  			ARRAY_SIZE(ams_delta_gpios));
>  serio:
> -	kfree(ams_delta_serio);
>  	return err;
>  }
>  
>  static int ams_delta_serio_exit(struct platform_device *pdev)
>  {
> -	serio_unregister_port(ams_delta_serio);
> +	struct ams_delta_serio *priv = platform_get_drvdata(pdev);
> +
> +	serio_unregister_port(priv->serio);
>  	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
>  	gpio_free_array(ams_delta_gpios,
>  			ARRAY_SIZE(ams_delta_gpios));
> -- 
> 2.16.4
> 

-- 
Dmitry
