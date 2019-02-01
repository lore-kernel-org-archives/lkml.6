Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92E7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755A520844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y5NNbbsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbfBAUPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:15:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBAUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:15:12 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x11KEwfZ029965;
        Fri, 1 Feb 2019 14:14:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549052098;
        bh=KQ/ri78qUxwGmANMO4zY+yUEqMgaOkUb5p0HVI+f6pw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y5NNbbsYDVWS3nh/Nz3WtM5bZXVX+4Mf7ue5JoVmNn9ikJWlNW+NI8TBa2MB7QV1K
         yDaGA9GcwSbhUvkzbPSxB2VeZ7E83bi87doVGbabrf0/1Q3zbwiVlY+qJZzla/a/Py
         vaSoR5Hh331BAF5ip9XmoorAF/8n9shkzLLl4I54=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x11KEv8O076435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 14:14:57 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Feb 2019 14:14:57 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Feb 2019 14:14:57 -0600
Received: from [172.22.124.64] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x11KEu8W008387;
        Fri, 1 Feb 2019 14:14:56 -0600
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-10-brgl@bgdev.pl>
 <78b99abb-f367-1533-0690-8da26957a664@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d86adc21-627f-0350-72e0-f6f10b023413@ti.com>
Date:   Fri, 1 Feb 2019 14:14:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <78b99abb-f367-1533-0690-8da26957a664@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2/1/19 1:45 PM, Jacek Anaszewski wrote:
> Hi Bartosz,
> 
> Thanks for the update.
> 
> On 2/1/19 10:47 AM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This adds basic support for LEDs for the max77650 PMIC. The device has
>> three current sinks for driving LEDs.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/leds/Kconfig         |   6 ++
>>   drivers/leds/Makefile        |   1 +
>>   drivers/leds/leds-max77650.c | 147 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 154 insertions(+)
>>   create mode 100644 drivers/leds/leds-max77650.c
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index a72f97fca57b..6e7a8f51eccc 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -608,6 +608,12 @@ config LEDS_TLC591XX
>>         This option enables support for Texas Instruments TLC59108
>>         and TLC59116 LED controllers.
>>   +config LEDS_MAX77650
>> +    tristate "LED support for Maxim MAX77650 PMIC"
>> +    depends on MFD_MAX77650
>> +    help
>> +      LEDs driver for MAX77650 family of PMICs from Maxim Integrated."
>> +
>>   config LEDS_MAX77693
>>       tristate "LED support for MAX77693 Flash"
>>       depends on LEDS_CLASS_FLASH
>> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
>> index 4c1b0054f379..f48b2404dbb7 100644
>> --- a/drivers/leds/Makefile
>> +++ b/drivers/leds/Makefile
>> @@ -61,6 +61,7 @@ obj-$(CONFIG_LEDS_MC13783)        += leds-mc13783.o
>>   obj-$(CONFIG_LEDS_NS2)            += leds-ns2.o
>>   obj-$(CONFIG_LEDS_NETXBIG)        += leds-netxbig.o
>>   obj-$(CONFIG_LEDS_ASIC3)        += leds-asic3.o
>> +obj-$(CONFIG_LEDS_MAX77650)        += leds-max77650.o
>>   obj-$(CONFIG_LEDS_MAX77693)        += leds-max77693.o
>>   obj-$(CONFIG_LEDS_MAX8997)        += leds-max8997.o
>>   obj-$(CONFIG_LEDS_LM355x)        += leds-lm355x.o
>> diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
>> new file mode 100644
>> index 000000000000..6b74ce9cac12
>> --- /dev/null
>> +++ b/drivers/leds/leds-max77650.c
>> @@ -0,0 +1,147 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2018 BayLibre SAS
>> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> +//
>> +// LED driver for MAXIM 77650/77651 charger/power-supply.
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/leds.h>
>> +#include <linux/mfd/max77650.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define MAX77650_LED_NUM_LEDS        3
>> +
>> +#define MAX77650_LED_A_BASE        0x40
>> +#define MAX77650_LED_B_BASE        0x43
>> +
>> +#define MAX77650_LED_BR_MASK        GENMASK(4, 0)
>> +#define MAX77650_LED_EN_MASK        GENMASK(7, 6)
>> +
>> +#define MAX77650_LED_MAX_BRIGHTNESS    MAX77650_LED_BR_MASK
>> +
>> +/* Enable EN_LED_MSTR. */
>> +#define MAX77650_LED_TOP_DEFAULT    BIT(0)
>> +
>> +#define MAX77650_LED_ENABLE        GENMASK(7, 6)
>> +#define MAX77650_LED_DISABLE        0x00
>> +
>> +#define MAX77650_LED_A_DEFAULT        MAX77650_LED_DISABLE
>> +/* 100% on duty */
>> +#define MAX77650_LED_B_DEFAULT        GENMASK(3, 0)
>> +
>> +struct max77650_led {
>> +    struct led_classdev cdev;
>> +    struct regmap *map;
>> +    unsigned int regA;
>> +    unsigned int regB;

Please don't use camel case.

>> +};
>> +
>> +static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
>> +{
>> +    return container_of(cdev, struct max77650_led, cdev);
>> +}
>> +
>> +static int max77650_led_brightness_set(struct led_classdev *cdev,
>> +                       enum led_brightness brightness)
>> +{
>> +    struct max77650_led *led = max77650_to_led(cdev);
>> +    int val, mask;
>> +

The register value and bits are only 8 bit why an int?

>> +    mask = MAX77650_LED_BR_MASK | MAX77650_LED_EN_MASK;
>> +
>> +    if (brightness == LED_OFF)
>> +        val = MAX77650_LED_DISABLE;
>> +    else
>> +        val = MAX77650_LED_ENABLE | brightness;
>> +
>> +    return regmap_update_bits(led->map, led->regA, mask, val);
>> +}
>> +
>> +static int max77650_led_probe(struct platform_device *pdev)
>> +{
>> +    struct device_node *of_node, *child;
>> +    struct max77650_led *leds, *led;
>> +    struct device *parent;
>> +    struct device *dev;
>> +    struct regmap *map;
>> +    const char *label;
>> +    int rv, num_leds;
>> +    u32 reg;
>> +
>> +    dev = &pdev->dev;
>> +    parent = dev->parent;
>> +    of_node = dev->of_node;
>> +
>> +    if (!of_node)
>> +        return -ENODEV;
>> +
>> +    leds = devm_kcalloc(dev, sizeof(*leds),
>> +                MAX77650_LED_NUM_LEDS, GFP_KERNEL);
>> +    if (!leds)
>> +        return -ENOMEM;
>> +
>> +    map = dev_get_regmap(dev->parent, NULL);
>> +    if (!map)
>> +        return -ENODEV;
>> +
>> +    num_leds = of_get_child_count(of_node);
>> +    if (!num_leds || num_leds > MAX77650_LED_NUM_LEDS)
>> +        return -ENODEV;
>> +
>> +    for_each_child_of_node(of_node, child) {
>> +        rv = of_property_read_u32(child, "reg", &reg);

Can we use the fwnode_property_read_u32 call here?
And the same for all below as well?


>> +        if (rv || reg >= MAX77650_LED_NUM_LEDS)
>> +            return -EINVAL;
>> +
>> +        led = &leds[reg];
>> +        led->map = map;
>> +        led->regA = MAX77650_LED_A_BASE + reg;
>> +        led->regB = MAX77650_LED_B_BASE + reg;
>> +        led->cdev.brightness_set_blocking = max77650_led_brightness_set;
>> +        led->cdev.max_brightness = MAX77650_LED_MAX_BRIGHTNESS;
>> +
>> +        label = of_get_property(child, "label", NULL);
>> +        if (!label) {
>> +            led->cdev.name = "max77650::";
>> +        } else {
>> +            led->cdev.name = devm_kasprintf(dev, GFP_KERNEL,
>> +                            "max77650:%s", label);
>> +            if (!led->cdev.name)
>> +                return -ENOMEM;
>> +        }
>> +
>> +        of_property_read_string(child, "linux,default-trigger",
>> +                    &led->cdev.default_trigger);
>> +
>> +        rv = devm_of_led_classdev_register(dev, child, &led->cdev);
>> +        if (rv)
>> +            return rv;
>> +
>> +        rv = regmap_write(map, led->regA, MAX77650_LED_A_DEFAULT);
>> +        if (rv)
>> +            return rv;
>> +
>> +        rv = regmap_write(map, led->regB, MAX77650_LED_B_DEFAULT);
>> +        if (rv)
>> +            return rv;
>> +    }
>> +
>> +    return regmap_write(map,
>> +                MAX77650_REG_CNFG_LED_TOP,
>> +                MAX77650_LED_TOP_DEFAULT);
>> +}
>> +
>> +static struct platform_driver max77650_led_driver = {
>> +    .driver = {
>> +        .name = "max77650-led",
>> +    },
>> +    .probe = max77650_led_probe,
>> +};
>> +module_platform_driver(max77650_led_driver);
>> +
>> +MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
>> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
>> +MODULE_LICENSE("GPL v2");
>>
> 
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> 


-- 
------------------
Dan Murphy
