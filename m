Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF8ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370D02081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMbE9E4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370D02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKIGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:24:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39830 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeKIGY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:24:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so16062016ljh.6;
        Thu, 08 Nov 2018 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnbchMLIDcjqSfR1Io6ecYB8sfiy4Kl7kr2DkbMD1g4=;
        b=LMbE9E4Aq9J2Kbk9w71wHgX8qb09qT8IShHXfzDWig5hnorVLQsggzFdDivhxYp8H1
         zfjYdnP8cakYxmf0W+hE+6egH/iehjGwRKXdf5f99+6AOApKUQSMpLyhwk2PS62s2dC2
         SyxnG/ME8F+OvFo9KPSu+a39eZS8Sts/Yo5JBt9JHGx8FRTIsd3jaYJ1VZ48b81Ijqjw
         7cYUSh8UQ4gzYNodeZd+iyaONu//GKAYXdzXspxtbXXe+/eQE+rDqZ5XG7x8IPfBIWO7
         gZfh5lsJ+NLB0FClGLg0ksbmzpAY7QqqnU5MdzH2kMhymWtZ8TEJZlYMcbacrpn9czFT
         hCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnbchMLIDcjqSfR1Io6ecYB8sfiy4Kl7kr2DkbMD1g4=;
        b=ULctiiaTCS4dSw/FD6HT9/3jb1XOico6Ure+C5xENzcnkAwYAiIF4dkJxlvYbhPV5k
         ACE08ej/uC20XkURyJDuQZnzNEsIVcqCw97xxUM/wDofkiAPBuQcDu8tyjAxKPknwFM5
         d/H75uj/0X+nPM79wSjhKJssWyq9YxKJNG3bwN54zM+19oOiEAzIzxNt5dESh8z842S2
         mvfLLoy7CmbteBq6C49nPpTZwHrDaB0NlZT04OT/coQ0jYBlXOqI/+Dhs6UhrvPyExsM
         gQ6cG/dNF19W9RWz8w4LgtCN21ZSSbSeu67InJja+/LZVBtJ+SO3sX0isF8IhCCNMurR
         PtAg==
X-Gm-Message-State: AGRZ1gIpOuHftaQwcYXVG8WZoTrT9eW+dDyWPgwE66I5qa8b2r4GttTe
        UALyfrMdc0rgnLtwjB9efD2BFgOU
X-Google-Smtp-Source: AJdET5epeLxtxjAFmbxv8AS7vlvDXzSPd87jq1WZcAGDUItpGtsQqiWK4AdIRacL9g/tMiBcnh4gYg==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr4056132ljb.52.1541710062555;
        Thu, 08 Nov 2018 12:47:42 -0800 (PST)
Received: from [192.168.1.18] (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id r1-v6sm879021ljb.64.2018.11.08.12.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:47:41 -0800 (PST)
Subject: Re: [PATCH 01/24] leds: class: Improve LED and LED flash class
 registration API
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-2-git-send-email-jacek.anaszewski@gmail.com>
 <166969ae-f5db-cb5f-9334-9934e23aa406@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <81b0ce3f-702f-952b-6f6f-336078a7008f@gmail.com>
Date:   Thu, 8 Nov 2018 21:47:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <166969ae-f5db-cb5f-9334-9934e23aa406@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the review.

On 11/08/2018 06:50 PM, Dan Murphy wrote:
> Jacek
> 
> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
[...]
>>  
>>  /**
>> - * of_led_classdev_register - register a new object of led_classdev class.
>> + * led_classdev_register_ext - register a new object of led_classdev class.
> 
> For this should the comment indicate a different between the extended and non-extended calls?
> Like the _ext might say register a new object of led_classdev with init_data?
> 
> Same comments for each addition below.

Agreed, I will amend it as you propose.

> Otherwise with Baolin's comments for 1/24
> 
> Acked-by: Dan Murphy <dmurphy@ti.com>
> 
> Dan
> 
>>   *
>>   * @parent: parent of LED device
>>   * @led_cdev: the led_classdev structure for this device.
>> - * @np: DT node describing this LED
>> + * @init_data: LED class device initialization data
>>   */
>> -int of_led_classdev_register(struct device *parent, struct device_node *np,
>> -			    struct led_classdev *led_cdev)
>> +int led_classdev_register_ext(struct device *parent,
>> +			      struct led_classdev *led_cdev,
>> +			      struct led_init_data *init_data)
>>  {
>>  	char name[LED_MAX_NAME_SIZE];
>>  	int ret;
>>  
>> +	if (init_data && init_data->name) {
>> +		led_cdev->name = init_data->name;
>> +	} else {
>> +		dev_info(parent, "init_data not available");
>> +	}
>> +
>>  	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
>>  	if (ret < 0)
>>  		return ret;
>> @@ -268,7 +276,8 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>>  		mutex_unlock(&led_cdev->led_access);
>>  		return PTR_ERR(led_cdev->dev);
>>  	}
>> -	led_cdev->dev->of_node = np;
>> +	if (init_data && init_data->fwnode)
>> +		led_cdev->dev->of_node = to_of_node(init_data->fwnode);
>>  
>>  	if (ret)
>>  		dev_warn(parent, "Led %s renamed to %s due to name collision",
>> @@ -313,7 +322,7 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
>>  
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL_GPL(of_led_classdev_register);
>> +EXPORT_SYMBOL_GPL(led_classdev_register_ext);
>>  
>>  /**
>>   * led_classdev_unregister - unregisters a object of led_properties class.
>> @@ -358,14 +367,15 @@ static void devm_led_classdev_release(struct device *dev, void *res)
>>  }
>>  
>>  /**
>> - * devm_of_led_classdev_register - resource managed led_classdev_register()
>> + * devm_led_classdev_register_ext - resource managed led_classdev_register_ext()
>>   *
>>   * @parent: parent of LED device
>>   * @led_cdev: the led_classdev structure for this device.
>> + * @init_data: LED class device initialization data
>>   */
>> -int devm_of_led_classdev_register(struct device *parent,
>> -				  struct device_node *np,
>> -				  struct led_classdev *led_cdev)
>> +int devm_led_classdev_register_ext(struct device *parent,
>> +				   struct led_classdev *led_cdev,
>> +				   struct led_init_data *init_data)
>>  {
>>  	struct led_classdev **dr;
>>  	int rc;
>> @@ -374,7 +384,7 @@ int devm_of_led_classdev_register(struct device *parent,
>>  	if (!dr)
>>  		return -ENOMEM;
>>  
>> -	rc = of_led_classdev_register(parent, np, led_cdev);
>> +	rc = led_classdev_register_ext(parent, led_cdev, init_data);
>>  	if (rc) {
>>  		devres_free(dr);
>>  		return rc;
>> @@ -385,7 +395,7 @@ int devm_of_led_classdev_register(struct device *parent,
>>  
>>  	return 0;
>>  }
>> -EXPORT_SYMBOL_GPL(devm_of_led_classdev_register);
>> +EXPORT_SYMBOL_GPL(devm_led_classdev_register_ext);
>>  
>>  static int devm_led_classdev_match(struct device *dev, void *res, void *data)
>>  {
>> diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
>> index 0e42624..1c82152 100644
>> --- a/drivers/leds/leds-cr0014114.c
>> +++ b/drivers/leds/leds-cr0014114.c
>> @@ -207,8 +207,7 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
>>  		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
>>  		led->ldev.brightness_set_blocking = cr0014114_set_sync;
>>  
>> -		ret = devm_of_led_classdev_register(priv->dev, np,
>> -						    &led->ldev);
>> +		ret = devm_led_classdev_register(priv->dev, &led->ldev);
>>  		if (ret) {
>>  			dev_err(priv->dev,
>>  				"failed to register LED device %s, err %d",
>> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
>> index 32fa752..c87fbd3 100644
>> --- a/drivers/leds/leds-gpio.c
>> +++ b/drivers/leds/leds-gpio.c
>> @@ -112,7 +112,7 @@ static int create_gpio_led(const struct gpio_led *template,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	return devm_of_led_classdev_register(parent, np, &led_dat->cdev);
>> +	return devm_led_classdev_register(parent, &led_dat->cdev);
>>  }
>>  
>>  struct gpio_leds_priv {
>> diff --git a/include/linux/led-class-flash.h b/include/linux/led-class-flash.h
>> index 700efaa..28a73d0 100644
>> --- a/include/linux/led-class-flash.h
>> +++ b/include/linux/led-class-flash.h
>> @@ -90,15 +90,20 @@ static inline struct led_classdev_flash *lcdev_to_flcdev(
>>  }
>>  
>>  /**
>> - * led_classdev_flash_register - register a new object of led_classdev class
>> - *				 with support for flash LEDs
>> + * fwnode_led_classdev_flash_register - register a new object of led_classdev
>> + *					class with support for flash LEDs
>>   * @parent: the flash LED to register
>> + * @fwnode: the flash LED fwnode handle
>>   * @fled_cdev: the led_classdev_flash structure for this device
>>   *
>>   * Returns: 0 on success or negative error value on failure
>>   */
>> -extern int led_classdev_flash_register(struct device *parent,
>> -				struct led_classdev_flash *fled_cdev);
>> +extern int led_classdev_flash_register_ext(struct device *parent,
>> +					struct led_classdev_flash *fled_cdev,
>> +					struct led_init_data *init_data);
>> +
>> +#define led_classdev_flash_register(parent, fled_cdev)		\
>> +	led_classdev_flash_register_ext(parent, fled_cdev, NULL)
>>  
>>  /**
>>   * led_classdev_flash_unregister - unregisters an object of led_classdev class
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index 834683d..646c49a 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -20,6 +20,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/timer.h>
>>  #include <linux/workqueue.h>
>> +#include <uapi/linux/uleds.h>
>>  
>>  struct device;
>>  /*
>> @@ -33,6 +34,13 @@ enum led_brightness {
>>  	LED_FULL	= 255,
>>  };
>>  
>> +struct led_init_data {
>> +	/* Device fwnode handle */
>> +	struct fwnode_handle *fwnode;
>> +	/* Requested LED class device name */
>> +	char name[LED_MAX_NAME_SIZE];
>> +};
>> +
>>  struct led_classdev {
>>  	const char		*name;
>>  	enum led_brightness	 brightness;
>> @@ -73,6 +81,7 @@ struct led_classdev {
>>  	 */
>>  	int (*brightness_set_blocking)(struct led_classdev *led_cdev,
>>  				       enum led_brightness brightness);
>> +
>>  	/* Get LED brightness level */
>>  	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
>>  
>> @@ -123,16 +132,16 @@ struct led_classdev {
>>  	struct mutex		led_access;
>>  };
>>  
>> -extern int of_led_classdev_register(struct device *parent,
>> -				    struct device_node *np,
>> -				    struct led_classdev *led_cdev);
>> -#define led_classdev_register(parent, led_cdev)				\
>> -	of_led_classdev_register(parent, NULL, led_cdev)
>> -extern int devm_of_led_classdev_register(struct device *parent,
>> -					 struct device_node *np,
>> -					 struct led_classdev *led_cdev);
>> -#define devm_led_classdev_register(parent, led_cdev)			\
>> -	devm_of_led_classdev_register(parent, NULL, led_cdev)
>> +extern int led_classdev_register_ext(struct device *parent,
>> +				     struct led_classdev *led_cdev,
>> +				     struct led_init_data *init_data);
>> +#define led_classdev_register(parent, led_cdev)			\
>> +	led_classdev_register_ext(parent, led_cdev, NULL)
>> +extern int devm_led_classdev_register_ext(struct device *parent,
>> +					  struct led_classdev *led_cdev,
>> +					  struct led_init_data *init_data);
>> +#define devm_led_classdev_register(parent, led_cdev)		\
>> +	devm_led_classdev_register_ext(parent, led_cdev, NULL)
>>  extern void led_classdev_unregister(struct led_classdev *led_cdev);
>>  extern void devm_led_classdev_unregister(struct device *parent,
>>  					 struct led_classdev *led_cdev);
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
