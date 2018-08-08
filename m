Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13641C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C102178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3mIny6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C102178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeHHUQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:16:06 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38124 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHUQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:16:06 -0400
Received: by mail-ua0-f193.google.com with SMTP id o11-v6so3350376uak.5;
        Wed, 08 Aug 2018 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M5KPGqBhcrYdLyfiISomvfg2yofXFnJ4H7wQe8OlzM4=;
        b=d3mIny6WpYeSYwofi8LkJ+LjiIojjfizojwmjIjK2jKfD8+Xux87I1l9Bgt8VVmt/J
         fjvCFkL7LogIW3qMvWaMWVQXqKGFYka1TDVNpRMCltJ9VPx5wNTRzkuIxHgpVjselNkB
         21bqtfBFqT1GXRluBg/gt2/e2ixzBOiH5a7+DKFmyywt4QrrbOmXcDDsUndRIaUm1O6z
         qd4v2WVQxNWmYRtHJR8cUM2nZf1A4KpC8tYGRqXUgWq1ptFJfUpMqCj94d3pYoBdKwMS
         qAtX5vh/gVlsUShpyc6bOuTG9puNAVc/ujik+KL84YDDpszaAXXZyVoNQzOFA58deUuX
         8osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M5KPGqBhcrYdLyfiISomvfg2yofXFnJ4H7wQe8OlzM4=;
        b=un5rCaQ62S8UGebLPf5f52YuEwJOLWCTgC4DRa9B7d1a25FdH5zxEUtcZEWKkV8HzS
         Zx0LoDvAEIOhWkh8twB8rCxQHcyVp5KODDu668aUYQG1aN3mSyKmML/ZgI+1eblWYDuT
         zpYvv2la9doogW1uIiFQMAtXooy9AGyZnGcRLaqX3MhL+BQDVWJnEsaiNN1kLthgDz4c
         W2FKZwWcMwuLjiA2radm6Zl6/0PgnYr8h+zx4Tj1il+1UyitFLHX3zHMqeS9Y25OYACz
         ljQZA/LvBX20gc8i0Z8F3FgTs2/gEhsqfoKPoVips8Ujmn6xZOE3Ampkt3R2saSt93cD
         6pAA==
X-Gm-Message-State: AOUpUlGK5MWNGr5xXzjOTUTJRMwqNTSUlIhI3SiTKwyMPoerIs+/WoXT
        eIJ7kYxwbz0uRiw45LnbVWy2JaHPaLooGUcv+I8=
X-Google-Smtp-Source: AA+uWPwyf8P8Xy9bae40CxQfdecGcYMjPSbwffbY00dA94U74oXG5lrpK3GjQ8+78PXrK/CTCOywcJleRPc7mHbqUfQ=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr2713938ual.28.1533750919011;
 Wed, 08 Aug 2018 10:55:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:55:18 -0700 (PDT)
In-Reply-To: <20180808153150.23444-21-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-21-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:55:18 +0300
Message-ID: <CAHp75VeUWbJ37SV+V4X-6dxUvL3H0Kt9+HY7=5xBYujnZ37z2w@mail.gmail.com>
Subject: Re: [PATCH 20/28] ARM: davinci: da830-evm: use device properties for
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
>  arch/arm/mach-davinci/board-da830-evm.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 4a2fe8142a2f..08a23e777eca 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -18,7 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/pcf857x.h>
> -#include <linux/platform_data/at24.h>
> +#include <linux/property.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/spi/spi.h>
> @@ -419,12 +419,9 @@ static struct nvmem_cell_lookup da830_evm_mac_address_cell = {
>         .nvmem_name = "1-00500",
>  };
>
> -static struct at24_platform_data da830_evm_i2c_eeprom_info = {
> -       .byte_len       = SZ_256K / 8,
> -       .page_size      = 64,
> -       .flags          = AT24_FLAG_ADDR16,
> -       .setup          = davinci_get_mac_addr,
> -       .context        = (void *)0x7f00,
> +static const struct property_entry da830_evm_i2c_eeprom_properties[] = {
> +       PROPERTY_ENTRY_U32("pagesize", 64),
> +       { }
>  };
>
>  static int __init da830_evm_ui_expander_setup(struct i2c_client *client,
> @@ -458,7 +455,7 @@ static struct pcf857x_platform_data __initdata da830_evm_ui_expander_info = {
>  static struct i2c_board_info __initdata da830_evm_i2c_devices[] = {
>         {
>                 I2C_BOARD_INFO("24c256", 0x50),
> -               .platform_data  = &da830_evm_i2c_eeprom_info,
> +               .properties = da830_evm_i2c_eeprom_properties,
>         },
>         {
>                 I2C_BOARD_INFO("tlv320aic3x", 0x18),
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
