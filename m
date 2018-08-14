Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D1C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00EA2173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00EA2173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbeHNQlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:41:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51994 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbeHNQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:41:49 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7EDsRKV033285;
        Tue, 14 Aug 2018 08:54:27 -0500
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7EDsRuw007372;
        Tue, 14 Aug 2018 08:54:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 14
 Aug 2018 08:54:27 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 14 Aug 2018 08:54:27 -0500
Received: from [172.22.172.27] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7EDsQkQ030453;
        Tue, 14 Aug 2018 08:54:27 -0500
Subject: Re: [PATCH v2 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180807160442.8937-2-dmurphy@ti.com> <20180808195909.GC20912@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d76cb536-7ac0-6616-4979-8706ef22e9f3@ti.com>
Date:   Tue, 14 Aug 2018 08:54:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808195909.GC20912@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review

On 08/08/2018 02:59 PM, Pavel Machek wrote:
> Hi!
> 
>> Introduce the lm3697 LED driver for
>> backlighting and display.
>>
>> Datasheet location:
>> http://www.ti.com/lit/ds/symlink/lm3697.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
>> +
>> +#define LM3697_HVLED1_2_3_A		0
>> +#define LM3697_HVLED1_B_HVLED2_3_A	1
>> +#define LM3697_HVLED2_B_HVLED1_3_A	2
>> +#define LM3697_HVLED1_2_B_HVLED3_A	3
>> +#define LM3697_HVLED3_B_HVLED1_2_A	4
>> +#define LM3697_HVLED1_3_B_HVLED2_A	5
>> +#define LM3697_HVLED1_A_HVLED2_3_B	6
>> +#define LM3697_HVLED1_2_3_B		7
> 
> That's rather long and verbose way to describe a bitmap, right?

It will be removed with v3

> 
>> +static const struct regmap_config lm3697_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.max_register = LM3697_CTRL_ENABLE,
>> +	.reg_defaults = lm3697_reg_defs,
>> +	.num_reg_defaults = ARRAY_SIZE(lm3697_reg_defs),
>> +	.cache_type = REGCACHE_RBTREE,
>> +};
> 
> Is rbtree good idea? You don't have that many registers.

ack

> 
>> +static int lm3697_init(struct lm3697 *priv)
>> +{
>> +	int ret;
>> +
> ....
>> +		regmap_write(priv->regmap, LM3697_RESET, LM3697_SW_RESET);
> 
> No error checking required here?

Ack

> 
>> +	if (priv->control_bank_config < LM3697_HVLED1_2_3_A ||
>> +	    priv->control_bank_config > LM3697_HVLED1_2_3_B) {
>> +		dev_err(&priv->client->dev, "Control bank configuration is out of range\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	device_for_each_child_node(priv->dev, child) {
>> +		led = &priv->leds[i];
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &led->control_bank);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "reg DT property missing\n");
>> +			goto child_out;
>> +		}
>> +
>> +		fwnode_property_read_string(child, "linux,default-trigger",
>> +					    &led->led_dev.default_trigger);
>> +
>> +		ret = fwnode_property_read_string(child, "label", &name);
>> +		if (ret)
>> +			snprintf(led->label, sizeof(led->label),
>> +				"%s::", priv->client->name);
>> +		else
>> +			snprintf(led->label, sizeof(led->label),
>> +				 "%s:%s", priv->client->name, name);
>> +
>> +
>> +		led->priv = priv;
>> +		led->led_dev.name = led->label;
>> +		led->led_dev.brightness_set_blocking = lm3697_brightness_set;
>> +
>> +		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "led register err: %d\n", ret);
>> +			goto child_out;
>> +		}
>> +
>> +		if (priv->control_bank_config == LM3697_HVLED1_2_3_A ||
>> +		    priv->control_bank_config == LM3697_HVLED1_2_3_B)
>> +			goto child_out;
> 
> This checks if we have just one bank, I see it. Should it also check
> the led actually uses the correct bank?

It will be removed with v3

> 
>> +		i++;
>> +		fwnode_handle_put(child);
>> +	}
>> +
>> +child_out:
>> +	fwnode_handle_put(child);
> 
> Is not the fwnode_handle_put() done twice for non-error case?

Ack

> 
>> +	ret = lm3697_init(led);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ret;
>> +}
> 
> The if is not needed here.
> 

Ack

>> +static int lm3697_remove(struct i2c_client *client)
>> +{
>> +	struct lm3697 *led = i2c_get_clientdata(client);
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(led->regmap, LM3697_CTRL_ENABLE,
>> +				 LM3697_CTRL_A_B_EN, 0);
>> +	if (ret) {
>> +		dev_err(&led->client->dev, "Failed to disable regulator\n");
>> +		return ret;
> 
> Misleading, this does nothing with regulators.

Ack

> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
