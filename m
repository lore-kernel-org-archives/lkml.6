Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D480FECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78916206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP50T4iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78916206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbeGQWOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:14:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34356 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbeGQWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:14:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so2267016ljk.1;
        Tue, 17 Jul 2018 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOEMzI7bIyDO97aGhrhjWaH3xdUtBlwMzqsAbxCTHho=;
        b=aP50T4iQjgsm4avWER04QzyYGmMbNPPljnRBD5rH7PUW921d7bIkYq2/FzGkcm0C6E
         z4RvD5cx52cPaexRD/yKiqUB3Oi885NYrS1VoCEnop3LiCLh06Vs1bXAc/QQH9xFAlyx
         bNhJ0YSypSkrztty9Vqqq4X351aj3cKtY/P9AuiCdbvj4ee+yl6WY9mQwMLRhVwxWGf1
         uD7Plw3Upq1tBmc08+BkOnWDWl0XUXKhcvgzLSbTzJELqTfoyHPM8jgPzYynWgNtfFlV
         mmTuybzXO5ibebNgP7gpg7L7S6WDpn/Ev6yYdCPFQzVmawLJUB+0sLjlg5mn41x/YqLx
         WmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOEMzI7bIyDO97aGhrhjWaH3xdUtBlwMzqsAbxCTHho=;
        b=gZCqR7ORTDaMUEI52XJBnxMgIq4n1R3c2SrHhD4Lz2Esv4knLLo+FPzfAu8xfR/GNS
         GoBL+obvXJKzkqosYPXqBVM6YYdVD/K8u/HhaDpvnzKQXY6MTQsuo3C3XgSUvZb2IGiC
         vd44KGscqoiq7vfeFliIKYA8CAV1/LNB0P4TiIvSEuTRfrqw0t5UK1Culbt2E0idtE63
         VuHu8AhEKZPr9w91qua8vJeU4/kMPSI3xlKjdieco+AYAMhrZiDx7+UlO/aQliHOz0p9
         y+yD+sWu0+vtgkUH2H07erL5DdgD+eh7SLzfim/HjMZJ11Aovp7nYf1pCurHbD5zJwqr
         yIMQ==
X-Gm-Message-State: AOUpUlFgZ2H8D75CDasYe+7e730Z4B0NGUGPhVtQPaFzySd4I8ZFMvqC
        l7msYOe1hrms8TZyqA5Osl7UaPDm
X-Google-Smtp-Source: AAOMgpeI3zVAZ4XrwKT0+6s+4Fz+tWxsPv30xtdwvQFMYtYo6jX3Xm21aTHINvrmb6ix5XWLcnHhKA==
X-Received: by 2002:a2e:5f5b:: with SMTP id t88-v6mr2697402ljb.140.1531863592463;
        Tue, 17 Jul 2018 14:39:52 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o13-v6sm322720lja.23.2018.07.17.14.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:39:51 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RESEND v2] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
Date:   Tue, 17 Jul 2018 23:40:36 +0200
Message-ID: <3393268.aPIcKqDIFV@z50>
In-Reply-To: <20180717165400.17565-1-jmkrzyszt@gmail.com>
References: <20180709191601.18681-1-jmkrzyszt@gmail.com> <20180717165400.17565-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this submission, I'm going to send this patch with two others in 
a single series.

Thanks,
Janusz

On Tuesday, July 17, 2018 6:54:00 PM CEST Janusz Krzysztofik wrote:
> Now as Amstrad Delta board - the only user of this driver - provides
> GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
> use the table to locate required GPIO pins.
> 
> Declare static variables for storing GPIO descriptors and replace
> gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
> to the driver probe function so device initialization can be deferred
> instead of aborted if a GPIO pin is not yet available.
> 
> Pin naming used by the driver should be followed while respective GPIO
> lookup table is initialized by a board init code.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> Changelog:
> v2: Remove problematic error code conversion, no longer needed if used
>     on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
>     devices back to init_machine") and commit 8853daf3b4ac ("gpiolib:
>     Defer on non-DT find_chip_by_name() failure") already in linux-next.
> 
>  drivers/video/fbdev/omap/lcd_ams_delta.c | 55 +++++++++++++-------------------
>  1 file changed, 22 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
> index e8c748a0dfe2..cddbd00cbf9f 100644
> --- a/drivers/video/fbdev/omap/lcd_ams_delta.c
> +++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
> @@ -24,11 +24,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/lcd.h>
> -#include <linux/gpio.h>
>  
>  #include <mach/hardware.h>
> -#include <mach/board-ams-delta.h>
>  
>  #include "omapfb.h"
>  
> @@ -41,6 +40,8 @@
>  /* LCD class device section */
>  
>  static int ams_delta_lcd;
> +static struct gpio_desc *gpiod_vblen;
> +static struct gpio_desc *gpiod_ndisp;
>  
>  static int ams_delta_lcd_set_power(struct lcd_device *dev, int power)
>  {
> @@ -99,41 +100,17 @@ static struct lcd_ops ams_delta_lcd_ops = {
>  
>  /* omapfb panel section */
>  
> -static const struct gpio _gpios[] = {
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_LCD_VBLEN,
> -		.flags	= GPIOF_OUT_INIT_LOW,
> -		.label	= "lcd_vblen",
> -	},
> -	{
> -		.gpio	= AMS_DELTA_GPIO_PIN_LCD_NDISP,
> -		.flags	= GPIOF_OUT_INIT_LOW,
> -		.label	= "lcd_ndisp",
> -	},
> -};
> -
> -static int ams_delta_panel_init(struct lcd_panel *panel,
> -		struct omapfb_device *fbdev)
> -{
> -	return gpio_request_array(_gpios, ARRAY_SIZE(_gpios));
> -}
> -
> -static void ams_delta_panel_cleanup(struct lcd_panel *panel)
> -{
> -	gpio_free_array(_gpios, ARRAY_SIZE(_gpios));
> -}
> -
>  static int ams_delta_panel_enable(struct lcd_panel *panel)
>  {
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 1);
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 1);
> +	gpiod_set_value(gpiod_ndisp, 1);
> +	gpiod_set_value(gpiod_vblen, 1);
>  	return 0;
>  }
>  
>  static void ams_delta_panel_disable(struct lcd_panel *panel)
>  {
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 0);
> -	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 0);
> +	gpiod_set_value(gpiod_vblen, 0);
> +	gpiod_set_value(gpiod_ndisp, 0);
>  }
>  
>  static struct lcd_panel ams_delta_panel = {
> @@ -154,8 +131,6 @@ static struct lcd_panel ams_delta_panel = {
>  	.pcd		= 0,
>  	.acb		= 37,
>  
> -	.init		= ams_delta_panel_init,
> -	.cleanup	= ams_delta_panel_cleanup,
>  	.enable		= ams_delta_panel_enable,
>  	.disable	= ams_delta_panel_disable,
>  };
> @@ -166,9 +141,23 @@ static struct lcd_panel ams_delta_panel = {
>  static int ams_delta_panel_probe(struct platform_device *pdev)
>  {
>  	struct lcd_device *lcd_device = NULL;
> -#ifdef CONFIG_LCD_CLASS_DEVICE
>  	int ret;
>  
> +	gpiod_vblen = devm_gpiod_get(&pdev->dev, "vblen", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod_vblen)) {
> +		ret = PTR_ERR(gpiod_vblen);
> +		dev_err(&pdev->dev, "VBLEN GPIO request failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_ndisp = devm_gpiod_get(&pdev->dev, "ndisp", GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod_ndisp)) {
> +		ret = PTR_ERR(gpiod_ndisp);
> +		dev_err(&pdev->dev, "NDISP GPIO request failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +#ifdef CONFIG_LCD_CLASS_DEVICE
>  	lcd_device = lcd_device_register("omapfb", &pdev->dev, NULL,
>  						&ams_delta_lcd_ops);
>  
> 




