Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36669C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB21A2178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPiM4VA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB21A2178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbeHHUQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:16:59 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38205 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHHUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:16:59 -0400
Received: by mail-ua0-f195.google.com with SMTP id o11-v6so3353310uak.5;
        Wed, 08 Aug 2018 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kdW4plKMIQQhNaI7LPKzOKebFz8NFpVhTmmHSHDBbUM=;
        b=RPiM4VA9GhCPgoRSRE8H6j4Tfdeg9PyXaWMNfkh03JgatV4ewPIs6MjCqe1YycP0dw
         S2UGdXspuHrdnxwjGAvktb6lT8TFHg20+oSYAH0/kbCh9wWuUXutfHMamph5WGYl6o3i
         aQjCUj9Yt8Vl/MPa3wB8QI/RPbh1wXmYuPpiBCKuqGG0Cq6S2EUqlePaAdEOZSwxdqpq
         vwiY7X4/gNwzRU5+XDMNSGGJAA2B5s/uW6+7sxAnxnY65JcoyLFdZlXq5wmudS74oxlw
         Qqfoi6NNnb3N7F+PamImZ7IuLASzq17boUGjLz1KfVCcNACqT8xHlnuJlGu4W13TLUBE
         Mv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kdW4plKMIQQhNaI7LPKzOKebFz8NFpVhTmmHSHDBbUM=;
        b=uZyHj60wR00JwYnkJk8MAIdTuV57Usdr0poRa6TSPbnkUkKI8N/0B567D1PXlMl445
         lshUVyqo07Q37apMDPJje95ZSFFb6fXEd0Y/BAuOzGWN3Nzo0vphZYa5HfXAJAesq+XU
         0CMniPP81AzRg80wvpUqBndvpIUZWuNbnrInYUEvyclQDoZDF7j0l17vx8cy9g6w+1gw
         sp3JVWFJijBK7bMOWcEZthbEgvLeLSjIMZistsvmxJqz5pqeLbDhWAYC/1ThdT2aD98+
         bIuL8fQqUSKe5BfXmaPCwvvdJgTR0qADTa5fsMuBRHMOOjzcI/5SxwG5ARuvfKw4erfQ
         0wVA==
X-Gm-Message-State: AOUpUlFEf5fF/JtEeAdMuzBTIIada2qzmAEv4DKT5CaSZHLF3F3N8RTP
        gPe9ds3JvtHWEKqvuUZnXLJwc91aXxi+w3fyx9o=
X-Google-Smtp-Source: AA+uWPzbge+Ndalh7CBhXzfHFREQYyeryGUPU/uVPCiBhkxbz11AnryvZCHWczl5DI2kFNjQTgjO6UML9i4MnmC1UCs=
X-Received: by 2002:a1f:4c7:: with SMTP id 190-v6mr2498318vke.63.1533750971890;
 Wed, 08 Aug 2018 10:56:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:56:11 -0700 (PDT)
In-Reply-To: <20180808153150.23444-23-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-23-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:56:11 +0300
Message-ID: <CAHp75VeGFr9e-pNeoo7HdvnGLud49wwKvFhFotFyQnwCh0d0iA@mail.gmail.com>
Subject: Re: [PATCH 22/28] ARM: davinci: dm646x-evm: use device properties for
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
>  arch/arm/mach-davinci/board-dm646x-evm.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
> index 5a9de47bc8a2..5049f0c6cd1a 100644
> --- a/arch/arm/mach-davinci/board-dm646x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm646x-evm.c
> @@ -22,7 +22,7 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/at24.h>
> +#include <linux/property.h>
>  #include <linux/platform_data/pcf857x.h>
>
>  #include <media/i2c/tvp514x.h>
> @@ -320,12 +320,9 @@ static struct nvmem_cell_lookup dm646x_evm_mac_address_cell = {
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
> +       { }
>  };
>  #endif
>
> @@ -396,7 +393,7 @@ static void evm_init_cpld(void)
>  static struct i2c_board_info __initdata i2c_info[] =  {
>         {
>                 I2C_BOARD_INFO("24c256", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties  = eeprom_properties,
>         },
>         {
>                 I2C_BOARD_INFO("pcf8574a", 0x38),
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
