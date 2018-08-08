Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B02C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD9B2178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpTA+nnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD9B2178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeHHUOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:14:55 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37541 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHUOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:14:55 -0400
Received: by mail-ua0-f193.google.com with SMTP id y10-v6so3343550uao.4;
        Wed, 08 Aug 2018 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ptp2ZlwnEQ4oEXo2mWMG62LeI19gX7u/NAHavfAv9iA=;
        b=MpTA+nnhg+t85j0107IQWi1A0FMMIXAnKIkk1XITbxFcU+2KQLce4d8YzQjrS7LQ++
         sf0gYR0NMediqn8CJqE8KywL0gQ3t9eaI82v3uQwsUCZb2WHEFgvB1O1hg+GR9egP7jO
         S3aZ+Ek5+Qp1u9dMxg2Ik5TEdsxAvWg1PhOYK5j2z/PglwgYsDF1htG9HyzEsor7tt1d
         TGmo3hzhpXi1g/rVP2bIxzWVi6SpVVunM9ZQVkd7XWTdfGURJTeI34AEke+zffTg1MKo
         hrX6/TZvpK/H/6ltXkfboLoxoJW4RTFRltlZz+y5U34tddGu7omQEisYTXzhJnh0EY33
         nLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ptp2ZlwnEQ4oEXo2mWMG62LeI19gX7u/NAHavfAv9iA=;
        b=S0VWQlusUCnR7sa54UARvC3oX7l7+5AkXzRo/s3GbHGS9SxSOdbTyxefrFLU5vlYMl
         p8qzyu6mSmJbkY6ka0iiKq8KlVAuAnASk5aTVJhIAFclkRppTgp2/Fpa1gh9x3v39sc9
         HFmGkCQAQ7Av1kp9NI3LwVKCGK03zVXjQ9XgOiAAkp9a9hxjktOs2/x2Q+GW8eCLumSb
         ++sIA8+C3VbUmV9SXJbBrNUNcD348js9q7Dyn5aLkLy4sAL84L9KwvQ8fUaSkQye9dPP
         qbpgmF0nYr4pHoDzIRwIQd7It88blxfNZCyjE93EmtlEbHQMyFJhog6H0tJHDJ7lcVwE
         Lnqw==
X-Gm-Message-State: AOUpUlGsMinxvYQJ50WxnM2HGXWyT9MejPnZMDF3UpwbP3YTtm9+J2CX
        wDgtq/4G6v5AjwdbXlCr/BB82b0mByk8ojAkuAk=
X-Google-Smtp-Source: AA+uWPwgfnSutzNstLJMjqcH2pQZqgPF6HbPOaHvUPHnPYyOytmOgqE0OO2h5YIhTEjVz0Udna+03zwOwMtXatAh78M=
X-Received: by 2002:a1f:25c8:: with SMTP id l191-v6mr2612054vkl.66.1533750848390;
 Wed, 08 Aug 2018 10:54:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:54:07 -0700 (PDT)
In-Reply-To: <20180808153150.23444-20-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-20-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:54:07 +0300
Message-ID: <CAHp75VdKbXqd+pN7Ohyzy6_3SHf=reXZ2ZJ5wCkiAwekKSenew@mail.gmail.com>
Subject: Re: [PATCH 19/28] ARM: davinci: dm365-evm: use device properties for
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

Yes, that exactly how device properties should be used instead of
legacy platform data!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-dm365-evm.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index cb0ac92a278e..b360d26e6caa 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -18,7 +18,7 @@
>  #include <linux/i2c.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> -#include <linux/platform_data/at24.h>
> +#include <linux/property.h>
>  #include <linux/leds.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -179,18 +179,15 @@ static struct nvmem_cell_lookup dm365evm_mac_address_cell = {
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
>
>  static struct i2c_board_info i2c_info[] = {
>         {
>                 I2C_BOARD_INFO("24c256", 0x50),
> -               .platform_data  = &eeprom_info,
> +               .properties = eeprom_properties,
>         },
>         {
>                 I2C_BOARD_INFO("tlv320aic3x", 0x18),
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
