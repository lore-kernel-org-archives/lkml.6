Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6316ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC3C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGHGqcM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC3C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeKIGZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:25:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39884 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:25:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so16063545ljh.6;
        Thu, 08 Nov 2018 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZEAb8a06qInxWuiMjjmz5pzpMnMpEyz+usuJwsrzs2o=;
        b=JGHGqcM19zsHm0lBsqXTxHkZJOwJHfAQcIcf3fDk5Ruwz6gffo8T7cQKLy6R4fHg+7
         f4tuIfn5tarSC8txr8YTWPwJ3JyqqpXdmJfnV5YFzpq6EuInrkCRpCBRDw7e1Ovbtb3w
         obatWGBtn/J333SXU6DJTh/evAoXShdHx5aOXFB9j+G/Dy7zjOQsWQWimR91hKVvG4CO
         AnpWgizE9hw1FaHtkSJU6mrBQ8z6+GrtkoI1ibs9WmO4Uu9cfrT7nBeaAb/qNaCYNZsS
         5ekTKvC4PciwRWIVGmKa5YUYmKgjk2bpZMyLOuS+saq5uE7GO1HECLRew4WeVZFaufp1
         SIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZEAb8a06qInxWuiMjjmz5pzpMnMpEyz+usuJwsrzs2o=;
        b=KfLfRCHtHgdj2JwMytVTQjAbf8eDvK5vQAJA1O3vGp0QaHPvx3GR/EtL9NsWtey9F/
         WQPTmX2zwLxea51AJoxbPgdyLg1wuUpCOBT0Tuwy3qiwRxQmjC4TpK67cp7jY96Z2PtT
         gX97VE1ozqb6YOIuQrsAQhBWY4KSdFvpcC0gTM8hOoPsZzCLH+uYdO6fxOCX3DEpRvmj
         4XMnTFcL1HiQEoDwXSPLaX92GRLXGqpA96iLXwuOWt0Q3HhnILDhGXIAWCgxAie3xQKl
         JJv5tnpMpwIuJi7xgfjIbvWWqlj48IF4mMmvotOwexDkmgB8Q4A4GNGJt+muPqQslC8O
         lsuQ==
X-Gm-Message-State: AGRZ1gI9m7TcZbUIPScnlROtq9fAKWBE1Sdml65lad6/Di46fU8JtaTA
        X4P2Bo3uTeiKSAE37GWHYMw=
X-Google-Smtp-Source: AJdET5fP6pugFqVVN+vClT0FX2H27M9UUrHEsO4+BBeC7GnijX78fbmhL579xEhr+dqSgdbfIBaapg==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr3987514ljg.22.1541710102533;
        Thu, 08 Nov 2018 12:48:22 -0800 (PST)
Received: from [192.168.1.18] (dkl219.neoplus.adsl.tpnet.pl. [83.24.15.219])
        by smtp.gmail.com with ESMTPSA id r76-v6sm870436ljr.83.2018.11.08.12.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 12:48:21 -0800 (PST)
Subject: Re: [PATCH 10/24] leds: lp8860: Use led_compose_name()
To:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-11-git-send-email-jacek.anaszewski@gmail.com>
 <d0d4eff7-5840-95d7-a1a1-104188d1b619@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <bfa4cf6d-1d78-3d48-4846-eb4bcc9e8a98@gmail.com>
Date:   Thu, 8 Nov 2018 21:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d0d4eff7-5840-95d7-a1a1-104188d1b619@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 11/08/2018 07:16 PM, Dan Murphy wrote:
> On 11/06/2018 04:07 PM, Jacek Anaszewski wrote:
>> Switch to using generic LED support for composing LED class
>> device name.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/leds/leds-lp8860.c | 38 +++++++++++++++++++-------------------
>>  1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
>> index 39c72a9..7c12ccd 100644
>> --- a/drivers/leds/leds-lp8860.c
>> +++ b/drivers/leds/leds-lp8860.c
>> @@ -22,7 +22,6 @@
>>  #include <linux/of_gpio.h>
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/slab.h>
>> -#include <uapi/linux/uleds.h>
>>  
>>  #define LP8860_DISP_CL1_BRT_MSB		0x00
>>  #define LP8860_DISP_CL1_BRT_LSB		0x01
>> @@ -87,6 +86,8 @@
>>  
>>  #define LP8860_CLEAR_FAULTS		0x01
>>  
>> +#define LP8860_NAME			"lp8860"
>> +
>>  /**
>>   * struct lp8860_led -
>>   * @lock - Lock for reading/writing the device
>> @@ -96,7 +97,6 @@
>>   * @eeprom_regmap - EEPROM register map
>>   * @enable_gpio - VDDIO/EN gpio to enable communication interface
>>   * @regulator - LED supply regulator pointer
>> - * @label - LED label
>>   */
>>  struct lp8860_led {
>>  	struct mutex lock;
>> @@ -106,7 +106,6 @@ struct lp8860_led {
>>  	struct regmap *eeprom_regmap;
>>  	struct gpio_desc *enable_gpio;
>>  	struct regulator *regulator;
>> -	char label[LED_MAX_NAME_SIZE];
>>  };
>>  
>>  struct lp8860_eeprom_reg {
>> @@ -387,25 +386,26 @@ static int lp8860_probe(struct i2c_client *client,
>>  	struct lp8860_led *led;
>>  	struct device_node *np = client->dev.of_node;
>>  	struct device_node *child_node;
>> -	const char *name;
>> +	struct led_init_data init_data;
>>  
>>  	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
>>  	if (!led)
>>  		return -ENOMEM;
>>  
>> -	for_each_available_child_of_node(np, child_node) {
>> -		led->led_dev.default_trigger = of_get_property(child_node,
>> -						    "linux,default-trigger",
>> -						    NULL);
>> -
>> -		ret = of_property_read_string(child_node, "label", &name);
>> -		if (!ret)
>> -			snprintf(led->label, sizeof(led->label), "%s:%s",
>> -				 id->name, name);
>> -		else
>> -			snprintf(led->label, sizeof(led->label),
>> -				"%s::display_cluster", id->name);
>> -	}
> 
> We need to keep a loop here looking for additional nodes as this device has string support and just
> not cluster support.
> 
> Just need to get the other LED patches done.

In the current shape only the properties from the last parsed child node
will be used for initializing the LED class device. So, this should be
meant also a fix removing this obscurity. Worth mentioning in the commit
message. Or I'm not getting it right?

>> +	child_node = of_get_next_available_child(np, NULL);
>> +	if (!child_node)
>> +		return -EINVAL;
>> +
>> +	init_data.fwnode = of_fwnode_handle(child_node),
>> +
>> +	led->led_dev.default_trigger = of_get_property(child_node,
>> +					    "linux,default-trigger",
>> +					    NULL);
>> +
>> +	ret = led_compose_name(init_data.fwnode, LP8860_NAME,
>> +			       ":display_cluster", init_data.name);
> 
> Should we use the #defines here for display_cluster?

Right, will fix in the next version.

>> +	if (ret)
>> +		return ret;
>>  
>>  	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
>>  						   "enable", GPIOD_OUT_LOW);
>> @@ -420,7 +420,6 @@ static int lp8860_probe(struct i2c_client *client,
>>  		led->regulator = NULL;
>>  
>>  	led->client = client;
>> -	led->led_dev.name = led->label;
>>  	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
>>  
>>  	mutex_init(&led->lock);
>> @@ -447,7 +446,8 @@ static int lp8860_probe(struct i2c_client *client,
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
>> +	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
>> +					     &init_data);
>>  	if (ret) {
>>  		dev_err(&client->dev, "led register err: %d\n", ret);
>>  		return ret;
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
