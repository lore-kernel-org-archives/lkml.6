Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F89C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD4D2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i56RBHBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD4D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbeISKi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:38:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISKi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:38:59 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8J52ncX047043;
        Wed, 19 Sep 2018 00:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537333369;
        bh=NTNgFT/KLaAcUBILpix8F48SuVxZhf3RH0/o4O+I8Js=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=i56RBHBorVmLBnJ7OkHc8IxDho9N52wD6zwaIAl9OG+2W1pchRSRj7JVp8qn2twIB
         N8pZcWyobzW6NqUw6gz4+48/DF/EL3/Xtc8x1ImSu7T3iHs45qQkLdS9KDPOlOd6up
         E60W+lX7YBJsW1K68it6kwuKJM+Sudn5beATQeIk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J52nVk026043;
        Wed, 19 Sep 2018 00:02:49 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 19
 Sep 2018 00:02:49 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 19 Sep 2018 00:02:49 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J52ki3018367;
        Wed, 19 Sep 2018 00:02:47 -0500
Subject: Re: [PATCH 5/5] gpio: davinci: Move driver local definitions to
 driver
To:     "Andrew F. Davis" <afd@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-5-afd@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <a90eb795-753f-2b45-2c90-cda6f8acf238@ti.com>
Date:   Wed, 19 Sep 2018 10:32:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180831191326.25106-5-afd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
> These defines, structs and inline functions are used only internally by
> the driver, they do not belong in platform_data. Move them.

Tested for gpio interrupts on k2g and da850-lcdk

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-davinci.c                | 28 ++++++++++++++++++++++
>  include/linux/platform_data/gpio-davinci.h | 28 ----------------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 121a7948f785..5c1564fcc24e 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -9,6 +9,7 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> +
>  #include <linux/gpio/driver.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> @@ -24,6 +25,12 @@
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/gpio-davinci.h>
>  #include <linux/irqchip/chained_irq.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm-generic/gpio.h>
> +
> +#define MAX_REGS_BANKS 5
> +#define MAX_INT_PER_BANK 32
>  
>  struct davinci_gpio_regs {
>  	u32	dir;
> @@ -45,6 +52,27 @@ typedef struct irq_chip *(*gpio_get_irq_chip_cb_t)(unsigned int irq);
>  static void __iomem *gpio_base;
>  static unsigned int offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
>  
> +struct davinci_gpio_irq_data {
> +	void __iomem			*regs;
> +	struct davinci_gpio_controller	*chip;
> +	int				bank_num;
> +};
> +
> +struct davinci_gpio_controller {
> +	struct gpio_chip	chip;
> +	struct irq_domain	*irq_domain;
> +	/* Serialize access to GPIO registers */
> +	spinlock_t		lock;
> +	void __iomem		*regs[MAX_REGS_BANKS];
> +	int			gpio_unbanked;
> +	int			irqs[MAX_INT_PER_BANK];
> +};
> +
> +static inline u32 __gpio_mask(unsigned gpio)
> +{
> +	return 1 << (gpio % 32);
> +}
> +
>  static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
>  {
>  	struct davinci_gpio_regs __iomem *g;
> diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
> index 47695b342883..f92a47e18034 100644
> --- a/include/linux/platform_data/gpio-davinci.h
> +++ b/include/linux/platform_data/gpio-davinci.h
> @@ -16,40 +16,12 @@
>  #ifndef __DAVINCI_GPIO_PLATFORM_H
>  #define __DAVINCI_GPIO_PLATFORM_H
>  
> -#include <linux/io.h>
> -#include <linux/spinlock.h>
> -
> -#include <asm-generic/gpio.h>
> -
> -#define MAX_REGS_BANKS		5
> -#define MAX_INT_PER_BANK 32
> -
>  struct davinci_gpio_platform_data {
>  	u32	ngpio;
>  	u32	gpio_unbanked;
>  };
>  
> -struct davinci_gpio_irq_data {
> -	void __iomem			*regs;
> -	struct davinci_gpio_controller	*chip;
> -	int				bank_num;
> -};
> -
> -struct davinci_gpio_controller {
> -	struct gpio_chip	chip;
> -	struct irq_domain	*irq_domain;
> -	/* Serialize access to GPIO registers */
> -	spinlock_t		lock;
> -	void __iomem		*regs[MAX_REGS_BANKS];
> -	int			gpio_unbanked;
> -	int			irqs[MAX_INT_PER_BANK];
> -};
> -
>  /* Convert GPIO signal to GPIO pin number */
>  #define GPIO_TO_PIN(bank, gpio)	(16 * (bank) + (gpio))
>  
> -static inline u32 __gpio_mask(unsigned gpio)
> -{
> -	return 1 << (gpio % 32);
> -}
>  #endif
> 
