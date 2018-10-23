Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82901C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEA920665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t80ChzhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEA920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeJXDPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:15:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38122 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeJXDPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:15:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id x24-v6so1999360lfe.5;
        Tue, 23 Oct 2018 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogHnNczkZeaBs2BrhCd07HgzaZjUBSu0c9t22YKR0D4=;
        b=t80ChzhH7LvoLXaqhRHD4ND2kuP5s4zaAKqie9tbpIVGIzS/mXAGxqMN17/zGGSB5d
         Pz3+xqxZRAmBR1/W6Bf2Yqd2X/4EKzlJ70uupNb580ZldH84MMo1HVrVXtfGJCn3BFgl
         lM2AfBfG3BsYcFAH1qGZq/k082L8JT+tJhJ+BjBQzeM9NJkVxpN7wcbE6uCZf6byvDD4
         tdwGMdZmpdtk0cdWbGVDKeF8bJejBD2Igqj9ak0D68joN42mT7GzzLe5fZuZM2j+n7L1
         z5xb9bKI023JKtd8CTyMe7Pjm5GnSY/VNdKLg69ZqUpPTdwNaTNvqZ6HKYmXwzh3Or15
         pZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogHnNczkZeaBs2BrhCd07HgzaZjUBSu0c9t22YKR0D4=;
        b=LlNzaN1kRb3nsE5AhahNtksgtyOfpIqIFVjbRMYqBHBSeDA7yYgqwk1CSZZWycTCI/
         yDZjLhl7GkHI3sljqA90eGK3Q2225zAFSjaMNr04HZKmtPxWcuU7xpk4EXMuQx71zR7h
         Hq2LTBYZLbJWAdrLIwn9LOh6YoTkJ6J1Ar+5Yy7k2e0Bq9nGVlGzNvAXUGcithEb/8mq
         rHsYO3gIrHicD8ibj5ERy4AxfM52w22nD/yIe+yEb9cNykhAj/FB81X+8JHaR9+Q/fZb
         H2ucXLCVyJasPXImr+xZxVaz+IJBQ5cQTV66oEDaDT3HfkHXQg5LYEZKM1o/jZ0I+BHN
         3DYQ==
X-Gm-Message-State: ABuFfoixxhbt+R8Ubc4Ef6cvqSSaepaa4BvWytPyG4A/nMPDSK23MKgo
        2a4957Bvn21t/rrRVCZ7gsk=
X-Google-Smtp-Source: ACcGV61EIiQC4m1tF7+IKa+tfzPMzbjG6AVHS+5MS7hiwDAmIEczLHyAYsGKp9unuxrQz3vIKLDnnA==
X-Received: by 2002:a19:2c15:: with SMTP id s21-v6mr12823810lfs.0.1540320651941;
        Tue, 23 Oct 2018 11:50:51 -0700 (PDT)
Received: from [192.168.1.18] (dks61.neoplus.adsl.tpnet.pl. [83.24.22.61])
        by smtp.gmail.com with ESMTPSA id q62-v6sm307684ljq.22.2018.10.23.11.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 11:50:51 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
To:     Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
Date:   Tue, 23 Oct 2018 20:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539969334-24577-3-git-send-email-dan@emutex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Thank you for the patch.

I have few trivial issues below, please take a look.

On 10/19/2018 07:15 PM, Dan O'Donovan wrote:
> From: Javier Arteaga <javier@emutex.com>
> 
> Allow userspace to use the on-board LEDs as "upboard:<color>:".
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  drivers/leds/Kconfig        |  10 +++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-upboard.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/leds/leds-upboard.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 44097a3..0ed8857 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -756,6 +756,16 @@ config LEDS_NIC78BX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-nic78bx.
>  
> +config LEDS_UPBOARD
> +	tristate "LED support for the UP Squared"
> +	depends on LEDS_CLASS
> +	depends on MFD_UPBOARD
> +	help
> +	  This option enables support for the LEDs on the UP Squared board.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called leds-upboard.
> +
>  comment "LED Triggers"
>  source "drivers/leds/trigger/Kconfig"
>  
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 420b5d2..c85f18f 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
>  obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
>  obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
>  obj-$(CONFIG_LEDS_LM3601X)		+= leds-lm3601x.o
> +obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
>  
>  # LED SPI Drivers
>  obj-$(CONFIG_LEDS_CR0014114)		+= leds-cr0014114.o
> diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
> new file mode 100644
> index 0000000..34a6973
> --- /dev/null
> +++ b/drivers/leds/leds-upboard.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// UP Board LED driver
> +//
> +// Copyright (c) 2018, Emutex Ltd.
> +//
> +// Author: Javier Arteaga <javier@emutex.com>
> +//
> +
> +#include <linux/kernel.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/upboard.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/acpi.h>

The last include should go first to keep alphabetical order.

> +
> +#define to_upboard_led(cdev) container_of(cdev, struct upboard_led, cdev)
> +
> +static const char * const upboard_led_names[] = {
> +	"upboard:blue:",
> +	"upboard:yellow:",
> +	"upboard:green:",
> +	"upboard:red:",
> +};
> +
> +struct upboard_led {
> +	struct regmap_field *field;
> +	struct led_classdev cdev;
> +};
> +
> +static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
> +{
> +	struct upboard_led *led = to_upboard_led(cdev);
> +	int brightness = 0;
> +
> +	regmap_field_read(led->field, &brightness);

Please check the return value.

> +	return brightness;
> +}
> +
> +static void upboard_led_brightness_set(struct led_classdev *cdev,
> +				       enum led_brightness brightness)
> +{
> +	struct upboard_led *led = to_upboard_led(cdev);
> +
> +	regmap_field_write(led->field, brightness);

Ditto.

> +}
> +
> +static int upboard_led_probe(struct platform_device *pdev)
> +{
> +	unsigned int led_index = pdev->id;
> +	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev;
> +	struct upboard_led *led;
> +	struct regmap *regmap;
> +	struct reg_field conf = {
> +		.reg = UPBOARD_REG_FUNC_EN0,
> +		.lsb = led_index,
> +		.msb = led_index,
> +	};
> +
> +	adev = ACPI_COMPANION(dev);
> +	if (!adev || strcmp(acpi_device_hid(adev), "AANT0F01"))
> +		return -ENODEV;
> +
> +	if (led_index >= ARRAY_SIZE(upboard_led_names))
> +		return -EINVAL;
> +
> +	if (!dev->parent)
> +		return -EINVAL;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -EINVAL;
> +
> +	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	led->field = devm_regmap_field_alloc(dev, regmap, conf);
> +	if (IS_ERR(led->field))
> +		return PTR_ERR(led->field);
> +
> +	led->cdev.max_brightness = 1;

s/1/LED_ON/

> +	led->cdev.brightness_get = upboard_led_brightness_get;
> +	led->cdev.brightness_set = upboard_led_brightness_set;
> +	led->cdev.name = upboard_led_names[led_index];
> +
> +	return devm_led_classdev_register(dev, &led->cdev);
> +}
> +
> +static struct platform_driver upboard_led_driver = {
> +	.driver = {
> +		.name = "upboard-led",
> +	},
> +};
> +
> +module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
> +
> +MODULE_ALIAS("platform:upboard-led");
> +MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
> +MODULE_DESCRIPTION("UP Board LED driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski
