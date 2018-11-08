Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30145ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E822081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GMfWyq+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E822081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKIGsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:48:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46566 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeKIGsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:48:30 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8LB66U078519;
        Thu, 8 Nov 2018 15:11:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541711466;
        bh=TV7x3WCU22TIU4GajKiEiF9JKQgo58Q/s81rAT3Gfms=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GMfWyq+iNnKa5wq2eOxxc2IeNZA1xNFWrNHm1En9TynJo5bl8EK8cadNvvTeC09vu
         0wK95Z/iNfevaFbMnhulFtwO2yI9Oili/8JznDLQ7wjoNzBlYOLSN3zy/R5agAwyge
         Aey+giXqiZKnCsfzp/hKkXKiRi+lnuB3N3ZyE4ss=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8LB6CB071854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 15:11:06 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 15:11:06 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 15:11:06 -0600
Received: from [172.22.187.225] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8LB6k1006809;
        Thu, 8 Nov 2018 15:11:06 -0600
Subject: Re: [PATCH 12/24] leds: lm3692x: Use led_compose_name()
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-13-git-send-email-jacek.anaszewski@gmail.com>
 <d1267477-e000-f392-290f-2546f8ee379c@ti.com>
 <a58cdce3-3d15-0ab4-de98-01e526a142a1@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8584e8a2-44df-33b1-4d9e-9fb3fb2cb98d@ti.com>
Date:   Thu, 8 Nov 2018 15:11:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a58cdce3-3d15-0ab4-de98-01e526a142a1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 11/08/2018 02:48 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 11/08/2018 07:14 PM, Dan Murphy wrote:
>> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
>>> Switch to using generic LED support for composing LED class
>>> device name.
>>>
>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>  drivers/leds/leds-lm3692x.c | 39 ++++++++++++++++++++-------------------
>>>  1 file changed, 20 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
>>> index 4f413a7..9dfc0f2 100644
>>> --- a/drivers/leds/leds-lm3692x.c
>>> +++ b/drivers/leds/leds-lm3692x.c
>>> @@ -13,7 +13,6 @@
>>>  #include <linux/regmap.h>
>>>  #include <linux/regulator/consumer.h>
>>>  #include <linux/slab.h>
>>> -#include <uapi/linux/uleds.h>
>>>  
>>>  #define LM36922_MODEL	0
>>>  #define LM36923_MODEL	1
>>> @@ -95,6 +94,9 @@
>>>  #define LM3692X_FAULT_FLAG_SHRT BIT(3)
>>>  #define LM3692X_FAULT_FLAG_OPEN BIT(4)
>>>  
>>> +#define LM36922_NAME "lm36922"
>>> +#define LM36923_NAME "lm36923"
>>> +
>>>  /**
>>>   * struct lm3692x_led -
>>>   * @lock - Lock for reading/writing the device
>>> @@ -103,7 +105,6 @@
>>>   * @regmap - Devices register map
>>>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>>>   * @regulator - LED supply regulator pointer
>>> - * @label - LED label
>>>   * @led_enable - LED sync to be enabled
>>>   * @model_id - Current device model ID enumerated
>>>   */
>>> @@ -114,7 +115,6 @@ struct lm3692x_led {
>>>  	struct regmap *regmap;
>>>  	struct gpio_desc *enable_gpio;
>>>  	struct regulator *regulator;
>>> -	char label[LED_MAX_NAME_SIZE];
>>>  	int led_enable;
>>>  	int model_id;
>>>  };
>>> @@ -325,7 +325,8 @@ static int lm3692x_init(struct lm3692x_led *led)
>>>  static int lm3692x_probe_dt(struct lm3692x_led *led)
>>>  {
>>>  	struct fwnode_handle *child = NULL;
>>> -	const char *name;
>>> +	struct led_init_data init_data;
>>> +	char *model_name;
>>>  	int ret;
>>>  
>>>  	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
>>> @@ -346,17 +347,20 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>>>  		dev_err(&led->client->dev, "No LED Child node\n");
>>>  		return -ENODEV;
>>>  	}
>>> +	init_data.fwnode = child;
>>>  
>>> -	fwnode_property_read_string(child, "linux,default-trigger",
>>> -				    &led->led_dev.default_trigger);
>>> +	if (led->model_id == LM36922_MODEL)
>>> +		model_name =  LM36922_NAME;
>>> +	else
>>> +		model_name =  LM36923_NAME;
>>>  
>>> -	ret = fwnode_property_read_string(child, "label", &name);
>>> +	ret = led_compose_name(child, model_name, ":backlight_cluster",
>>> +			       init_data.name);
>>>  	if (ret)
>>> -		snprintf(led->label, sizeof(led->label),
>>> -			"%s::", led->client->name);
>>> -	else
>>> -		snprintf(led->label, sizeof(led->label),
>>> -			 "%s:%s", led->client->name, name);
>>> +		return ret;
>>> +
>>> +	fwnode_property_read_string(child, "linux,default-trigger",
>>> +				    &led->led_dev.default_trigger);
>>>  
>>>  	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
>>>  	if (ret) {
>>> @@ -364,16 +368,13 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
>>>  		return ret;
>>>  	}
>>>  
>>> -	led->led_dev.name = led->label;
>>> -
>>> -	ret = devm_led_classdev_register(&led->client->dev, &led->led_dev);
>>> +	ret = devm_led_classdev_register_ext(&led->client->dev, &led->led_dev,
>>> +					     &init_data);
>>>  	if (ret) {
>>>  		dev_err(&led->client->dev, "led register err: %d\n", ret);
>>>  		return ret;
>>>  	}
>>>  
>>> -	led->led_dev.dev->of_node = to_of_node(child);
>>> -
>>>  	return 0;
>>>  }
>>>  
>>> @@ -439,8 +440,8 @@ static int lm3692x_remove(struct i2c_client *client)
>>>  }
>>>  
>>>  static const struct i2c_device_id lm3692x_id[] = {
>>> -	{ "lm36922", LM36922_MODEL },
>>> -	{ "lm36923", LM36923_MODEL },
>>> +	{ LM36922_NAME, LM36922_MODEL },
>>> +	{ LM36923_NAME, LM36923_MODEL },
>>
>> How is this change relevant?
>> No mention in the comments about this change.
> 
> Unrelated. It is a remnant from the stage of development, where I had
> an impression that i2c_client name is taken from this array
> somehow. Only later I learned that it is taken from OF compatible
> property after removing vendor prefix with comma.
> 
> Afterwards I decide to abide by this change since it seems to be
> just an improvement - if I'm adding the string definition anyway,
> then why not replace other matching literals?
> 
> I will add the explanation if the commit message if there are no
> other objections.

That works for me.  Just did not want the change to be "hidden" even without
the intent of hiding it.

Dan

> 
>>>  	{ }
>>>  };
>>>  MODULE_DEVICE_TABLE(i2c, lm3692x_id);
>>>
>>
>>
> 


-- 
------------------
Dan Murphy
