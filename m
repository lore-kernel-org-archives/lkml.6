Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F8FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E6C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaM9t5wN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBFTJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:09:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34538 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:09:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so6253452lfc.1;
        Wed, 06 Feb 2019 11:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z9/L5xLef89DemN1BvcwL+9BVsQ+FwKg4/NO/PuWn0s=;
        b=YaM9t5wNLbvV1s+/YIyOD6l+RRqqhj2TulgDZppKiemc+uJ5J7jFFQEKp60cot4ZIi
         hvNpNiaOzIBAC8d84wMx3x58+4liRDFRxobw6nMnTBRFJOjkC9qaa7GvvZwr+P1P4S+8
         FHsHE91lLK33UOIiigghubu0GX1aOvHbaJ+ePiau6Z/F/fskoPiEnIA/Z7LDzxFmyCAm
         TORCmZb5i2qWCix85E0HJWbK4AMuSaid/z07wdaGse+bGv9BQFciv78xTQV5whVbBQoD
         3IBO+N2NfqoAo5u9RK+Knk9P80DmRV80u7D95GzInm4mckJouIbdE9O2dUnjpJ49CQ62
         MtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z9/L5xLef89DemN1BvcwL+9BVsQ+FwKg4/NO/PuWn0s=;
        b=aXkJ9hUBfdmyvTNJx0VVe4QIWmCbPyh+nZVfOCGCPY59DfQmvBsWZWfaAZZ/iQV6E8
         lzCEKMWUTAQRtXCeij40GMRKx2O/Lc9p8XZ8C5UicwD209k/WysHuXO9Uch0GGvSMn4q
         t7I+U4pRIfvALi2gfcbBc+E3HWy4d7x3j2hb+vcXdkdzDCa8zyYceaLHLWIUhBw0K7XU
         KpGWvji/G+fW/pkayNRIPK2FEMnkwEx5kKOCv6D6ZHUpyzTur9AqbwPT2uLah0JPi3TD
         iJiAfjnZ3hQHXEh+MKVza2NAUaPUrntEg8P76T8mgAzrFe7WR8dMvjcmGa1zoL46H2ww
         GkFQ==
X-Gm-Message-State: AHQUAubPpDbfMKX1IzaEKiCA9/bf3Mjc0HINy+268n7FsHM4V63wM+hS
        HEqJyFVN0k5EnDA9GY40spvrK6yW
X-Google-Smtp-Source: AHgI3Ia3C8I2GaE5ahFjqbdzfF5gZ50kupoRR0ZsRzwWeZu+ySeIka6Hvr2gPokNPBKVgtA+91WO4A==
X-Received: by 2002:a19:5e54:: with SMTP id z20mr5798066lfi.148.1549480157178;
        Wed, 06 Feb 2019 11:09:17 -0800 (PST)
Received: from [192.168.1.18] (dkk109.neoplus.adsl.tpnet.pl. [83.24.14.109])
        by smtp.gmail.com with ESMTPSA id c133sm4894312lfc.45.2019.02.06.11.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 11:09:16 -0800 (PST)
Subject: Re: [PATCH] Input: cap11xx - switch to using
 set_brightness_blocking()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190205222050.GA145676@dtor-ws>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <5a8a3929-d64e-da93-d0e0-eabcbcfc214d@gmail.com>
Date:   Wed, 6 Feb 2019 20:09:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205222050.GA145676@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 2/5/19 11:20 PM, Dmitry Torokhov wrote:
> Updating LED state requires access to regmap and therefore we may sleep, so
> we could not do that directly form set_brightness() method. Historically
> we used private work to adjust the brightness, but with the introduction of
> set_brightness_blocking() we no longer need it.
> 
> As a bonus, not having our own work item means we do not have
> use-after-free issue as we neglected to cancel outstanding work on driver
> unbind.
> 
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/keyboard/cap11xx.c | 47 ++++++++++++++------------------
>   1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 312916f99597..c0baf323ddda 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -75,9 +75,8 @@
>   struct cap11xx_led {
>   	struct cap11xx_priv *priv;
>   	struct led_classdev cdev;
> -	struct work_struct work;
>   	u32 reg;
> -	enum led_brightness new_brightness;
> +	enum led_brightness brightness;
>   };
>   #endif
>   
> @@ -233,30 +232,28 @@ static void cap11xx_input_close(struct input_dev *idev)
>   }
>   
>   #ifdef CONFIG_LEDS_CLASS
> -static void cap11xx_led_work(struct work_struct *work)
> -{
> -	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
> -	struct cap11xx_priv *priv = led->priv;
> -	int value = led->new_brightness;
> -
> -	/*
> -	 * All LEDs share the same duty cycle as this is a HW limitation.
> -	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
> -	 */
> -	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
> -				BIT(led->reg), value ? BIT(led->reg) : 0);
> -}
> -
> -static void cap11xx_led_set(struct led_classdev *cdev,
> -			   enum led_brightness value)
> +static int cap11xx_led_set(struct led_classdev *cdev,
> +			    enum led_brightness value)
>   {
>   	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
> +	struct cap11xx_priv *priv = led->priv;
> +	int error = 0;
> +
> +	if (led->brightness != value) {

I'd say this check is not needed. If registers are not marked volatile
then regmap should not do the actual write to the hardware if the value
is equal to the cached one.

> +		/*
> +		 * All LEDs share the same duty cycle as this is a HW
> +		 * limitation. Brightness levels per LED are either
> +		 * 0 (OFF) and 1 (ON).
> +		 */
> +		error = regmap_update_bits(priv->regmap,
> +					   CAP11XX_REG_LED_OUTPUT_CONTROL,
> +					   BIT(led->reg),
> +					   value ? BIT(led->reg) : 0);
> +		if (!error)
> +			led->brightness = value;
> +	}
>   
> -	if (led->new_brightness == value)
> -		return;
> -
> -	led->new_brightness = value;
> -	schedule_work(&led->work);
> +	return error;
>   }
>   
>   static int cap11xx_init_leds(struct device *dev,
> @@ -299,7 +296,7 @@ static int cap11xx_init_leds(struct device *dev,
>   		led->cdev.default_trigger =
>   			of_get_property(child, "linux,default-trigger", NULL);
>   		led->cdev.flags = 0;
> -		led->cdev.brightness_set = cap11xx_led_set;
> +		led->cdev.brightness_set_blocking = cap11xx_led_set;
>   		led->cdev.max_brightness = 1;
>   		led->cdev.brightness = LED_OFF;
>   
> @@ -312,8 +309,6 @@ static int cap11xx_init_leds(struct device *dev,
>   		led->reg = reg;
>   		led->priv = priv;
>   
> -		INIT_WORK(&led->work, cap11xx_led_work);
> -
>   		error = devm_led_classdev_register(dev, &led->cdev);
>   		if (error) {
>   			of_node_put(child);
> 

-- 
Best regards,
Jacek Anaszewski
