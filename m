Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B742178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDI2+epP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B742178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeHHUQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:16:34 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33512 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:16:34 -0400
Received: by mail-ua0-f195.google.com with SMTP id i4-v6so3371533uak.0;
        Wed, 08 Aug 2018 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e1FNzDKQits+JaxkH4ViuZXmWJrlqCDWrsxJtCz89RM=;
        b=sDI2+epP755QKp69KXgS0999rLJKVTrMHX44nJO2vIlzgH28hEP54bZYqgrNb4DACa
         GinSYri68z6uA9T5FF1tUNCFqsIXbxq1PvjJ9IMs4AQT/jMJTEomQCr04ZDMpvG+dR09
         17yvHrmn4skgyoF+99B2Cbc6z73hoG5XILmSs1UHeY06CiwdHHYYx5Cjz3XSIWVkgWmu
         xGCYRzCgpSLgjEOQuA6wGFyYg1EDyOhjK3/MTUANZZJP6TbOvanW/7a01DvEXQ5O3MMH
         2pP8xmbw80zFjnZdfIAjLO+IOj8P1k/i3XGivTltwRSgBWQULX9lJuA1GPAQIgjlhzjp
         wD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e1FNzDKQits+JaxkH4ViuZXmWJrlqCDWrsxJtCz89RM=;
        b=jNG/LePkUIxf3P37/PUsfpe7qXApYamlEaCnQmRP94GbzsFv2yOy3mfbZOPkv/mxyR
         kUgczIMjNgLYeq8PgYyTD2CM7n9a/l8AZ0MT2/pN0M9RDkvAY50E+anOXOsCO8JPLNHF
         /gS0L/Yk26+WkZlQc5Mwmaf4fdnO26Rlt7fssZG4xnZsBxAAzQu/O2nCyTZIEPZUNb5D
         /CRMZaPZO00pw5GwGOnYgW6tk1jEwVX4d3JkEU4hdW6JD5ap+je/g6n+VcNB+/NMVMcN
         ss7v/386k4APykLvachYuqlswFQOVPS6JrsiwUY657iBrIFw9aiHylG6Uh+E2oU9bcca
         g09A==
X-Gm-Message-State: AOUpUlHLNzKmqtb8z6Dc3e8YyFPY8K7srfqiVCIUa06bWCUFwkMtkjc4
        0yK9Y2lvJitLCyf85qfhQowaX03GDmVA/+1egBU=
X-Google-Smtp-Source: AA+uWPxlrmseF8Z3hbtDjTGwzUs5hfmYvEcJzOOH3sOjs+Rdwo33/wt1MHURfC555M6fGJ++Jcr2mo5YM81yJvW5pSQ=
X-Received: by 2002:a1f:c884:: with SMTP id y126-v6mr2441325vkf.76.1533750946682;
 Wed, 08 Aug 2018 10:55:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:55:46 -0700 (PDT)
In-Reply-To: <20180808153150.23444-22-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-22-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:55:46 +0300
Message-ID: <CAHp75VewdvD2D2BpyKAptFecr+hrW5O5YUcSzu9X4wGgV-oJ3A@mail.gmail.com>
Subject: Re: [PATCH 21/28] ARM: davinci: dm644x-evm: use device properties for
 at24 eeprom
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index 6d35c6e1b0bd..abfcf42da6fb 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -16,8 +16,8 @@
>  #include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/pcf857x.h>
> -#include <linux/platform_data/at24.h>
>  #include <linux/platform_data/gpio-davinci.h>
> +#include <linux/property.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -486,12 +486,8 @@ static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
>         .nvmem_name = "1-00500",
>  };
>
> -static struct at24_platform_data eeprom_info = {
> -       .byte_len       = (256*1024) / 8,
> -       .page_size      = 64,
> -       .flags          = AT24_FLAG_ADDR16,
> -       .setup          = davinci_get_mac_addr,
> -       .context        = (void *)0x7f00,
> +static const struct property_entry eeprom_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 64),
>  };
>
>  /*
> @@ -601,7 +597,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
>         },
>         {
>                 I2C_BOARD_INFO("24c256", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties = eeprom_properties,
>         },
>         {
>                 I2C_BOARD_INFO("tlv320aic33", 0x1b),
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
