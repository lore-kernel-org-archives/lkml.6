Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4AEECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A8F208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ufEQgzW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A8F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbeISKip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:38:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54878 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISKio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:38:44 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8J52ZYA075016;
        Wed, 19 Sep 2018 00:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537333355;
        bh=aC1sM/PyfLRU56qHDRITJl1miWVqk57C8PDuU6uBn5s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ufEQgzW43u+gbWaw4aHDSmOxUK96m0P6p0X8LjAGSgKh1rT8xavqaBX/9fvaQT0/f
         Bj0dCvRfJDhhZjB3puvYWFKVAPCXrg0pF1G1ns/EdHn2KvFdnpZVLptG8SEVvAEv1I
         9dDa2kWr4Tj3LR0I8q1L9xGWY0Xq8qSLilLXQ6Z0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J52YkQ025765;
        Wed, 19 Sep 2018 00:02:34 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 19
 Sep 2018 00:02:35 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 19 Sep 2018 00:02:34 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J52WPO023343;
        Wed, 19 Sep 2018 00:02:32 -0500
Subject: Re: [PATCH 4/5] gpio: davinci: Remove unneeded GPIO macro
To:     "Andrew F. Davis" <afd@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180831191326.25106-1-afd@ti.com>
 <20180831191326.25106-4-afd@ti.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <699a7da7-1a4f-427a-b89e-aa082f77102a@ti.com>
Date:   Wed, 19 Sep 2018 10:32:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180831191326.25106-4-afd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 01 September 2018 12:43 AM, Andrew F. Davis wrote:
> This macro does nothing and has only one user, remove it.

Tested for gpio interrupts on k2g and da850-lcdk

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  arch/arm/mach-davinci/board-neuros-osd2.c  | 8 ++++----
>  include/linux/platform_data/gpio-davinci.h | 5 -----
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
> index 353f9e5a1454..efdaa27241c5 100644
> --- a/arch/arm/mach-davinci/board-neuros-osd2.c
> +++ b/arch/arm/mach-davinci/board-neuros-osd2.c
> @@ -130,10 +130,10 @@ static struct platform_device davinci_fb_device = {
>  };
>  
>  static const struct gpio_led ntosd2_leds[] = {
> -	{ .name = "led1_green", .gpio = GPIO(10), },
> -	{ .name = "led1_red",   .gpio = GPIO(11), },
> -	{ .name = "led2_green", .gpio = GPIO(12), },
> -	{ .name = "led2_red",   .gpio = GPIO(13), },
> +	{ .name = "led1_green", .gpio = 10, },
> +	{ .name = "led1_red",   .gpio = 11, },
> +	{ .name = "led2_green", .gpio = 12, },
> +	{ .name = "led2_red",   .gpio = 13, },
>  };
>  
>  static struct gpio_led_platform_data ntosd2_leds_data = {
> diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
> index b8e4957e7568..47695b342883 100644
> --- a/include/linux/platform_data/gpio-davinci.h
> +++ b/include/linux/platform_data/gpio-davinci.h
> @@ -45,11 +45,6 @@ struct davinci_gpio_controller {
>  	int			irqs[MAX_INT_PER_BANK];
>  };
>  
> -/*
> - * basic gpio routines
> - */
> -#define	GPIO(X)		(X)	/* 0 <= X <= (DAVINCI_N_GPIO - 1) */
> -
>  /* Convert GPIO signal to GPIO pin number */
>  #define GPIO_TO_PIN(bank, gpio)	(16 * (bank) + (gpio))
>  
> 
