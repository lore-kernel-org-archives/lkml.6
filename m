Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B8C282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C77420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfA3QNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:13:33 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38483 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfA3QNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:13:33 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43qT1h70HFz1r5SJ;
        Wed, 30 Jan 2019 17:13:28 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43qT1h6R3Nz1qr5C;
        Wed, 30 Jan 2019 17:13:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2yVoJ6-yzk2g; Wed, 30 Jan 2019 17:13:27 +0100 (CET)
X-Auth-Info: Z2JAxDlh3ope7DZsp9QdUtl/1XAGL4c30Ph5hZcwK0k=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 30 Jan 2019 17:13:27 +0100 (CET)
Subject: Re: [PATCH] rtc: rv3028: new driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190130150014.29853-1-alexandre.belloni@bootlin.com>
From:   Marek Vasut <marex@denx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=marex@denx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a40fd8e7-bf76-5a1f-3015-b15b72ac78ee@denx.de>
Date:   Wed, 30 Jan 2019 17:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130150014.29853-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 4:00 PM, Alexandre Belloni wrote:
> Add a driver for the MicroCrystal RV-3028.

Some additional information in the commit message won't hurt.

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/rtc/rtc.txt |   1 +
>  drivers/rtc/Kconfig                           |   9 +
>  drivers/rtc/Makefile                          |   1 +
>  drivers/rtc/rtc-rv3028.c                      | 732 ++++++++++++++++++
>  4 files changed, 743 insertions(+)
>  create mode 100644 drivers/rtc/rtc-rv3028.c
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> index d86e2850fe1c..3e6a215e7304 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> @@ -52,6 +52,7 @@ emmicro,em3027		EM Microelectronic EM3027 Real-time Clock
>  isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
>  isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
>  isil,isl12022		Intersil ISL12022 Real-time Clock
> +microcrystal,rv3028	Real Time Clock Module with I2C-Bus

Shouldn't this be a separate patch ?

>  microcrystal,rv3029	Real Time Clock Module with I2C-Bus
>  microcrystal,rv8523	Real Time Clock
>  nxp,pcf2127		Real-time clock
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index faa9ae1a3062..845c7eef548a 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -626,6 +626,15 @@ config RTC_DRV_EM3027
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-em3027.
>  
> +config RTC_DRV_RV3028
> +	tristate "Micro Crystal RV3028"
> +	help
> +	  If you say yes here you get support for the Micro Crystal
> +	  RV3028.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-rv3028.
> +
>  config RTC_DRV_RV8803
>  	tristate "Micro Crystal RV8803, Epson RX8900"
>  	help
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index faca02109aaa..a701d68bb5ca 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -138,6 +138,7 @@ obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
>  obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
>  obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
>  obj-$(CONFIG_RTC_DRV_RTD119X)	+= rtc-rtd119x.o
> +obj-$(CONFIG_RTC_DRV_RV3028)	+= rtc-rv3028.o
>  obj-$(CONFIG_RTC_DRV_RV3029C2)	+= rtc-rv3029c2.o
>  obj-$(CONFIG_RTC_DRV_RV8803)	+= rtc-rv8803.o
>  obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
> new file mode 100644
> index 000000000000..cd1600feaed1
> --- /dev/null
> +++ b/drivers/rtc/rtc-rv3028.c
> @@ -0,0 +1,732 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RTC driver for the Micro Crystal RV3028
> + *
> + * Copyright (C) 2018 Micro Crystal SA

2019 ?

> + * Alexandre Belloni <alexandre.belloni@bootlin.com>
> + *
> + */
> +
> +#include <linux/bcd.h>
> +#include <linux/bitops.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +#define RV3028_SEC			0x00
> +#define RV3028_MIN			0x01
> +#define RV3028_HOUR			0x02
> +#define RV3028_WDAY			0x03
> +#define RV3028_DAY			0x04
> +#define RV3028_MONTH			0x05
> +#define RV3028_YEAR			0x06
> +#define RV3028_ALARM_MIN		0x07
> +#define RV3028_ALARM_HOUR		0x08
> +#define RV3028_ALARM_DAY		0x09
> +#define RV3028_STATUS			0x0E
> +#define RV3028_CTRL1			0x0F
> +#define RV3028_CTRL2			0x10
> +#define RV3028_EVT_CTRL			0x13
> +#define RV3028_TS_COUNT			0x14
> +#define RV3028_TS_SEC			0x15
> +#define RV3028_RAM1			0x1F
> +#define RV3028_EEPROM_ADDR		0x25
> +#define RV3028_EEPROM_DATA		0x26
> +#define RV3028_EEPROM_CMD		0x27
> +#define RV3028_CLKOUT			0x35
> +#define RV3028_OFFSET			0x36
> +#define RV3028_BACKUP			0x37
> +
> +#define RV3028_STATUS_PORF		BIT(0)
> +#define RV3028_STATUS_EVF		BIT(1)
> +#define RV3028_STATUS_AF		BIT(2)
> +#define RV3028_STATUS_TF		BIT(3)
> +#define RV3028_STATUS_UF		BIT(4)
> +#define RV3028_STATUS_BSF		BIT(5)
> +#define RV3028_STATUS_CLKF		BIT(6)
> +#define RV3028_STATUS_EEBUSY		BIT(7)
> +
> +#define RV3028_CTRL1_EERD		BIT(3)
> +#define RV3028_CTRL1_WADA		BIT(5)
> +
> +#define RV3028_CTRL2_RESET		BIT(0)
> +#define RV3028_CTRL2_12_24		BIT(1)
> +#define RV3028_CTRL2_EIE		BIT(2)
> +#define RV3028_CTRL2_AIE		BIT(3)
> +#define RV3028_CTRL2_TIE		BIT(4)
> +#define RV3028_CTRL2_UIE		BIT(5)
> +#define RV3028_CTRL2_TSE		BIT(7)
> +
> +#define RV3028_EVT_CTRL_TSR		BIT(2)
> +
> +#define RV3028_EEPROM_CMD_WRITE		0x21
> +#define RV3028_EEPROM_CMD_READ		0x22
> +
> +#define RV3028_EEBUSY_POLL		10000
> +#define RV3028_EEBUSY_TIMEOUT		100000
> +
> +#define RV3028_BACKUP_TCE		BIT(5)
> +#define RV3028_BACKUP_TCR_MASK		GENMASK(1,0)
> +
> +#define OFFSET_STEP_PPT			953674
> +
> +enum rv3028_type {
> +	rv_3028,
> +};
> +
> +struct rv3028_data {
> +	struct regmap *regmap;
> +	struct rtc_device *rtc;
> +	enum rv3028_type type;
> +};
> +
> +static u32 rv3028_trickle_resistors[] = {1000, 3000, 6000, 11000};

u16 ?

The rest looks good to me.

-- 
Best regards,
Marek Vasut
