Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D8021908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk7H9RQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfBHVhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:37:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46550 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfBHVhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:37:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id x25-v6so582010ljj.13;
        Fri, 08 Feb 2019 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xD0Dub7bKus5fTfqC5u8tW6bm5mg0ZIu6GbjmhHNvNM=;
        b=Kk7H9RQxLuwsbXoBKGDT+nvwdH2UmlnNHEmDael7PbPoL3TqcJsPG0/DHY+lwJH/+z
         5a91NMcxLTtxdTn2LSZSFApp83djSdKL4+kZdXzlKGJtbWoAX6rN9TBc7VMxSl2SsUfV
         UhVR52GXvmra4FEtgyypfksHXbUc24+Y7bRgJPH1FX7EfvaECDCY5wtpXX/Cd5iPInkq
         Phdv71pMI/sy+MnEoN6y2341Mx3UFUQLUKQEwmlBzpHwG1VeAcfgJ7IXT1/vZ9Yb39QN
         QZHfpr0dOME0bDFvxHFABXI+PAj9chtBRcHaICdhLj4agMNTHg1kphnJH3lyQCKdxzIj
         5mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xD0Dub7bKus5fTfqC5u8tW6bm5mg0ZIu6GbjmhHNvNM=;
        b=A5qHGi228gJ5DQmTMi2eJUtbW9dM9MBhhJbqK9XIRdYKsDtm+enABOUz7VebYsv/Vz
         tBr8DeNIPiC3d4WtplGL/ctD2nahQpzJwM1W9CQ3clY1e6BtX02SLYx+BwlGWRqk78SR
         QqXvWrZInhI7hkDhoNcW9nnO4MxOYdzFc7xFoTfYTcpOtLc4eM+xM9j+2po/8XA1+hAk
         ZJCHQt3/zFltzoFgGQIZik+HEbxCQUvaGH8qUIkJcXwjdHrnxBtl+V++jfF3hOlhJkNv
         kSR7bB+evvgHzZ4bxtemiC4iPZbijGE0xDYeI8sld16PFpme10/PRii8Rz7iJlzZ2Smy
         FevA==
X-Gm-Message-State: AHQUAuZxPB7YWqVMOEJwmHg21JXxY99pWKYq2GOszbQ80MVSYlfcuhn/
        8MkyjTrtYQegNAM416xVYMB+0bUO
X-Google-Smtp-Source: AHgI3Ia5giCtkyxrKBXwVSHOvfVxzUnU+QC/iSMuZ0FgqEIHY7R3YgOLMPg3m+wmjejnTnH0vhOqFA==
X-Received: by 2002:a2e:98d4:: with SMTP id s20-v6mr9994667ljj.172.1549661823118;
        Fri, 08 Feb 2019 13:37:03 -0800 (PST)
Received: from [192.168.1.18] (bkx6.neoplus.adsl.tpnet.pl. [83.28.191.6])
        by smtp.gmail.com with ESMTPSA id o5-v6sm591061ljh.75.2019.02.08.13.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 13:37:02 -0800 (PST)
Subject: Re: [PATCH v2] Input: cap11xx - switch to using
 set_brightness_blocking()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sven Van Asbroeck <TheSven73@googlemail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190208075739.GA95091@dtor-ws>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1a610ebf-6fbd-2846-b57c-ef4e1f4e2dd5@gmail.com>
Date:   Fri, 8 Feb 2019 22:37:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208075739.GA95091@dtor-ws>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the update.

On 2/8/19 8:57 AM, Dmitry Torokhov wrote:
> Updating LED state requires access to regmap and therefore we may sleep,
> so we could not do that directly form set_brightness() method.
> Historically we used private work to adjust the brightness, but with the
> introduction of set_brightness_blocking() we no longer need it.
> 
> As a bonus, not having our own work item means we do not have
> use-after-free issue as we neglected to cancel outstanding work on
> driver unbind.
> 
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: no longer checking current brightness before trying to update since
>      regmap should take care of caching and skipping updates when needed
>      (Jacek).
> 
>   drivers/input/keyboard/cap11xx.c | 35 ++++++++++----------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 312916f99597..73686c2460ce 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -75,9 +75,7 @@
>   struct cap11xx_led {
>   	struct cap11xx_priv *priv;
>   	struct led_classdev cdev;
> -	struct work_struct work;
>   	u32 reg;
> -	enum led_brightness new_brightness;
>   };
>   #endif
>   
> @@ -233,30 +231,21 @@ static void cap11xx_input_close(struct input_dev *idev)
>   }
>   
>   #ifdef CONFIG_LEDS_CLASS
> -static void cap11xx_led_work(struct work_struct *work)
> +static int cap11xx_led_set(struct led_classdev *cdev,
> +			    enum led_brightness value)
>   {
> -	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
> +	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
>   	struct cap11xx_priv *priv = led->priv;
> -	int value = led->new_brightness;
>   
>   	/*
> -	 * All LEDs share the same duty cycle as this is a HW limitation.
> -	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
> +	 * All LEDs share the same duty cycle as this is a HW
> +	 * limitation. Brightness levels per LED are either
> +	 * 0 (OFF) and 1 (ON).
>   	 */
> -	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
> -				BIT(led->reg), value ? BIT(led->reg) : 0);
> -}
> -
> -static void cap11xx_led_set(struct led_classdev *cdev,
> -			   enum led_brightness value)
> -{
> -	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
> -
> -	if (led->new_brightness == value)
> -		return;
> -
> -	led->new_brightness = value;
> -	schedule_work(&led->work);
> +	return regmap_update_bits(priv->regmap,
> +				  CAP11XX_REG_LED_OUTPUT_CONTROL,
> +				  BIT(led->reg),
> +				  value ? BIT(led->reg) : 0);
>   }
>   
>   static int cap11xx_init_leds(struct device *dev,
> @@ -299,7 +288,7 @@ static int cap11xx_init_leds(struct device *dev,
>   		led->cdev.default_trigger =
>   			of_get_property(child, "linux,default-trigger", NULL);
>   		led->cdev.flags = 0;
> -		led->cdev.brightness_set = cap11xx_led_set;
> +		led->cdev.brightness_set_blocking = cap11xx_led_set;
>   		led->cdev.max_brightness = 1;
>   		led->cdev.brightness = LED_OFF;
>   
> @@ -312,8 +301,6 @@ static int cap11xx_init_leds(struct device *dev,
>   		led->reg = reg;
>   		led->priv = priv;
>   
> -		INIT_WORK(&led->work, cap11xx_led_work);
> -
>   		error = devm_led_classdev_register(dev, &led->cdev);
>   		if (error) {
>   			of_node_put(child);
> 

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
