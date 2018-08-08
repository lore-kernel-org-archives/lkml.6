Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159AAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C541A2178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVrXdtXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C541A2178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeHHURu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:17:50 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34602 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHHURu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:17:50 -0400
Received: by mail-ua0-f194.google.com with SMTP id r15-v6so3381420uao.1;
        Wed, 08 Aug 2018 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KjckqdiAJEN3CT7mUoRT1yi7ouoDnMc9Nbti6etxTN8=;
        b=KVrXdtXx3fllq2/Fwsssu551PoM5RYUV4JfFNiXEaP++5yNrR610XVjBSUSXqWQ1/Z
         eN+4OMv1Cn0VtJOpI3V+EMgHrH6GWoThBAs7GG81sv0UvlNSqvopvwXnsWpfdUTfB0sl
         iR6cnOOduDCVHK5iPh8ljT/x6nlfQBXx49qIoNwveSBQE/9rh3XW/r2J/jY2HlqvxjX3
         nk3mobcewZRT38VXxwkkc01SW4k0uidON8kIbu3cptEvSSSGs8ESgP5hktgr6lrk4Y8X
         FW+AJOpaZ1Yvdwm0Pol6JrSuvobmnd9zxWj51BuuxMt5OcbZsM5k+SfLdSBI+7Ohpye1
         8fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KjckqdiAJEN3CT7mUoRT1yi7ouoDnMc9Nbti6etxTN8=;
        b=RLDjzAisAYeZfIFU3MzWGuzl6wLD+rIZ+BBv/UORjC3urgROUqmXqbOPIyEHdhVyrs
         l1aQuaRa2DTuUGT7QhVYNcsja97/quQdoWwN9YP2sMmNFCEkH+Y0FSTNHd05sEE8za0e
         NuJe5oGwQvFcJpbB5YWMxcCiBS9YEmNKCXTuf051O2meA1T5PJeB0PpLOnEI3zZuyMZD
         3KIP0sjlQ5a2XZxvVIhvMMP1sP+g72pzKq398bQAc+8wWA1MN4NkyhgGF51ytmIxuVaS
         Hbrp9Hq3mnySE3+a+3isJdnRqHqRvYY9ryONnj2/QAIvWxbim1ig8b4sZN6d/1Tq+uPf
         quJA==
X-Gm-Message-State: AOUpUlHlzrbjzHh2piVRuFqYsAU1Z90ww1lVRuChHWvEXJVlmdfjbjEM
        N2VjgosULoVMUSk6xmAIe1R7W5AjJK/MKr7Fyl4=
X-Google-Smtp-Source: AA+uWPxtyynt0K+Mv9vhMfe0JzxdAuXNfnYsHrGEY9bk/zvbkWxUbYzonS18XAuWzBSfk/lp22QkG5ok20stu3+7UXw=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr2757802uai.122.1533751023062;
 Wed, 08 Aug 2018 10:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:57:02 -0700 (PDT)
In-Reply-To: <20180808153150.23444-25-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-25-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:57:02 +0300
Message-ID: <CAHp75VfU6Dsge0XX5h18zjY9kJ73kFPevLT9j7vZBO__tNronw@mail.gmail.com>
Subject: Re: [PATCH 24/28] ARM: davinci: sffsdr: use device properties for
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
>  arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
> index f6a4d094cbc3..680e5d7628a8 100644
> --- a/arch/arm/mach-davinci/board-sffsdr.c
> +++ b/arch/arm/mach-davinci/board-sffsdr.c
> @@ -26,7 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> -#include <linux/platform_data/at24.h>
> +#include <linux/property.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
>         .resource       = davinci_sffsdr_nandflash_resource,
>  };
>
> -static struct at24_platform_data eeprom_info = {
> -       .byte_len       = (64*1024) / 8,
> -       .page_size      = 32,
> -       .flags          = AT24_FLAG_ADDR16,
> +static const struct property_entry eeprom_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 32),
> +       { },
>  };
>
>  static struct i2c_board_info __initdata i2c_info[] =  {
>         {
>                 I2C_BOARD_INFO("24c64", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties = eeprom_properties,
>         },
>         /* Other I2C devices:
>          * MSP430,  addr 0x23 (not used)
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
