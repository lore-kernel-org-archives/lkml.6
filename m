Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18271ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BE02081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doGygrGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BE02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeKIGZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:25:30 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46046 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIGZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:25:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so15201761lfa.12;
        Thu, 08 Nov 2018 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3wsP2JtGnKSq/godFFtWR5Osbsc3a+r/om6gSb8p+yI=;
        b=doGygrGrtRM0vWOcIM0Sii/3qKNXOV2AR0ViYWj6L9NaxafZmEPDk7JhWjfjmEcQ13
         zCweQWB8gazofzlKXuJZhXVQ2CkOdIC2jgZnEZg6fSnj6TL/G8C1W0S9yfCGvfn5CM8p
         fv8H2kniehHyR8a3RsbJ5kLMQuuJzcfXsHdA+zBlN1TL9WZJrEXMhsgzIiIeCt/skNi4
         /zeQjprY4gSfMAvBrvQICBrmiXC8DEVaPtG7hoXw2mSmvQ2SB7v8gT6mzussZvMst+ci
         vhvCEEKCf4P//XhOuqtJ/EHBvcKCf6KfQyV7jEU4J9+pcIbXysqz7+CpWvhoUHXyTKik
         qsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3wsP2JtGnKSq/godFFtWR5Osbsc3a+r/om6gSb8p+yI=;
        b=BrmJcsniJy4hDX4i0+ywjVhKAVOwcgOjUOo/HvgS6CAmBw+TUGrcrK5eAKDNiDt9W0
         RdWoImMfAlz52e5jwf2WTPnkJQGZkgNBsKaRRan09WUUXRQrMNWFlrIZvw5VqTVtSnsD
         rUgPeQZ+FNqG+ylnAHXQfOZ5rZf+7TEkJDu99HIgtxifdEeLQkvIPnLJV3XSIWn02nWU
         upzlKD9UAzUYjC7IfbimW1Hfoq6Z4Rd7raVp5nmEaqb5uDwsjelW4BYE/YAB1W4nLVnP
         cwu0UHQgzh8t5XdjN0k3x1dAlQbmLXiJ5AT8vqYNMw7KVr52uYCIAu+P7z0Zqxb1h6md
         Xhdg==
X-Gm-Message-State: AGRZ1gK/7DhnNnS2KiqoUdQ9j6Mesl2j9Ly/TRp6bhp9A/FNT5/ssalu
        0GRPpnijF1KX1wW7979nLEk=
X-Google-Smtp-Source: AJdET5dVOfoU/ezCbjPaaDT2Rc8A8CxU36LImtOM9zTiD+sG5rdEmwJZMmcQdw/BVC8tm0pAMBkr2w==
X-Received: by 2002:a19:5a84:: with SMTP id y4mr1195353lfk.156.1541710095217;
        Thu, 08 Nov 2018 12:48:15 -0800 (PST)
Received: from [192.168.1.18] (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id d23sm817801lfc.11.2018.11.08.12.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:48:14 -0800 (PST)
Subject: Re: [PATCH 12/24] leds: lm3692x: Use led_compose_name()
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-13-git-send-email-jacek.anaszewski@gmail.com>
 <d1267477-e000-f392-290f-2546f8ee379c@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a58cdce3-3d15-0ab4-de98-01e526a142a1@gmail.com>
Date:   Thu, 8 Nov 2018 21:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d1267477-e000-f392-290f-2546f8ee379c@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 11/08/2018 07:14 PM, Dan Murphy wrote:
> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/leds/leds-lm3692x.c | 39 ++++++++++++++++++++-------------------
>>  1 file changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
>> index 4f413a7..9dfc0f2 100644
>> --- a/drivers/leds/leds-lm3692x.c
>> +++ b/drivers/leds/leds-lm3692x.c
>> @@ -13,7 +13,6 @@
>>  #include <linux/regmap.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/slab.h>
>> -#include <uapi/linux/uleds.h>
>>  
>>  #define LM36922_MODEL	0
>>  #define LM36923_MODEL	1
>> @@ -95,6 +94,9 @@
>>  #define LM3692X_FAULT_FLAG_SHRT BIT(3)
>>  #define LM3692X_FAULT_FLAG_OPEN BIT(4)
>>  
>> +#define LM36922_NAME "lm36922"
>> +#define LM36923_NAME "lm36923"
>> +
>>  /**
>>   * struct lm3692x_led -
>>   * @lock - Lock for reading/writing the device
>> @@ -103,7 +105,6 @@
>>   * @regmap - Devices register map
>>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>>   * @regulator - LED supply regulator pointer
>> - * @label - LED label
>>   * @led_enable - LED sync to be enabled
>>   * @model_id - Current device model ID enumerated
>>   */
>> @@ -114,7 +115,6 @@ struct lm3692x_led {
>>  	struct regmap *regmap;
>>  	struct gpio_desc *enable_gpio;
>>  	struct regulator *regulator;
>> -	char label[LED_MAX_NAME_SIZE];
>>  	int led_enable;
>>  	int model_id;
>>  };
>> @@ -325,7 +325,8 @@ static int lm3692x_init(struct lm3692x_led *led)
>>  static int lm3692x_probe_dt(struct lm3692x_led *led)
>>  {
>>  	struct fwnode_handle *child = NULL;
>> -	const char *name;
>> +	struct led_init_data init_data;
>> +	char *model_name;
>>  	int ret;
>>  
>>  	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
>> @@ -346,17 +347,20 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>>  		dev_err(&led->client->dev, "No LED Child node\n");
>>  		return -ENODEV;
>>  	}
>> +	init_data.fwnode = child;
>>  
>> -	fwnode_property_read_string(child, "linux,default-trigger",
>> -				    &led->led_dev.default_trigger);
>> +	if (led->model_id == LM36922_MODEL)
>> +		model_name =  LM36922_NAME;
>> +	else
>> +		model_name =  LM36923_NAME;
>>  
>> -	ret = fwnode_property_read_string(child, "label", &name);
>> +	ret = led_compose_name(child, model_name, ":backlight_cluster",
>> +			       init_data.name);
>>  	if (ret)
>> -		snprintf(led->label, sizeof(led->label),
>> -			"%s::", led->client->name);
>> -	else
>> -		snprintf(led->label, sizeof(led->label),
>> -			 "%s:%s", led->client->name, name);
>> +		return ret;
>> +
>> +	fwnode_property_read_string(child, "linux,default-trigger",
>> +				    &led->led_dev.default_trigger);
>>  
>>  	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
>>  	if (ret) {
>> @@ -364,16 +368,13 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>>  		return ret;
>>  	}
>>  
>> -	led->led_dev.name = led->label;
>> -
>> -	ret = devm_led_classdev_register(&led->client->dev, &led->led_dev);
>> +	ret = devm_led_classdev_register_ext(&led->client->dev, &led->led_dev,
>> +					     &init_data);
>>  	if (ret) {
>>  		dev_err(&led->client->dev, "led register err: %d\n", ret);
>>  		return ret;
>>  	}
>>  
>> -	led->led_dev.dev->of_node = to_of_node(child);
>> -
>>  	return 0;
>>  }
>>  
>> @@ -439,8 +440,8 @@ static int lm3692x_remove(struct i2c_client *client)
>>  }
>>  
>>  static const struct i2c_device_id lm3692x_id[] = {
>> -	{ "lm36922", LM36922_MODEL },
>> -	{ "lm36923", LM36923_MODEL },
>> +	{ LM36922_NAME, LM36922_MODEL },
>> +	{ LM36923_NAME, LM36923_MODEL },
> 
> How is this change relevant?
> No mention in the comments about this change.

Unrelated. It is a remnant from the stage of development, where I had
an impression that i2c_client name is taken from this array
somehow. Only later I learned that it is taken from OF compatible
property after removing vendor prefix with comma.

Afterwards I decide to abide by this change since it seems to be
just an improvement - if I'm adding the string definition anyway,
then why not replace other matching literals?

I will add the explanation if the commit message if there are no
other objections.

>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(i2c, lm3692x_id);
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
