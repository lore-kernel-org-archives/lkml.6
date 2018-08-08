Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4529A2178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE9VzCTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4529A2178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbeHHUUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:20:14 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45874 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHHUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:20:13 -0400
Received: by mail-ua0-f196.google.com with SMTP id k8-v6so3313342uaq.12;
        Wed, 08 Aug 2018 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F5Jn5ThbdGMN/ntBl9eM8Z1tLeSTGI/KD270MYviaFk=;
        b=aE9VzCTT9EiZSsDzfT4P0A9eEEYgeV8t7gv/ETwz82iMTz3Ud9uljeXOtZW2Pv7FJw
         Qw3toECwSIi9e7O963W2RxgyZlG/12fbhKI1msqBzV14msLWYRttGw8588CjzVLyXvqN
         zSiWtvWLxXh9qDo2+m5mY6xe52tflui1KcblIiFP5w6zQ90k0ay7FTRnKIYzobYUMgS3
         wsBM7RRzIr2Dga8vP7cGYz1p/tvyI0em/fbVtbgpbFDHcqjraP9UniO26Vd7uPRKi869
         lKaXC4Hk4E1SVxFqskLnfUKaCrx7ANUVC2aJonfq9w40uZN4UoDQWeyGg7oSeM5yObXp
         O64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F5Jn5ThbdGMN/ntBl9eM8Z1tLeSTGI/KD270MYviaFk=;
        b=lJLjkxAXG2enlKOk5WFgcKyfuf822cu/akjudLip7mKWWlPvNVM/wPbs+2oyFGJgnL
         q6rmdxzJo3tsF/vJESXxtM6aK4q08PA9LegxjbeLYqe4BKGXNdlj1s54Ei/O+ub21ujY
         ok502nc091oM/oO8b+Gfvp58wmj1yE4lDKC6sqpqZbi6DttK8knxuUTybWzBXjs2SimG
         Ittvp98T/ETKav3dQ8xY/frPC3Kh4JPMFreyJQ0rpx++a5eGcv2dJo0KezmlBccWpihh
         3INJxRIg9516/3UDAXQwsRFW2X81sNi8EwZaCNmsBeCssKDzo6QmW5wqPm80Q31nwzq6
         SjTg==
X-Gm-Message-State: AOUpUlELobFDClRFtEpalqbaUedWH2VY/Jenc7jULiaUnj5NGFCB0JCG
        U4lhZflxmwiqt/QXwlOOjPnFLv9H+ovtA1OQlkg=
X-Google-Smtp-Source: AA+uWPxKYshhjBug0zprFFmuDV9srTClctPPxDQDGxOcsBmpSm6sbUxP6di9C7dZoGB+qzmsb3XkpMs66p3lWGsuk3s=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr2710329uae.47.1533751165264;
 Wed, 08 Aug 2018 10:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:59:24 -0700 (PDT)
In-Reply-To: <CAHp75VewdvD2D2BpyKAptFecr+hrW5O5YUcSzu9X4wGgV-oJ3A@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-22-brgl@bgdev.pl>
 <CAHp75VewdvD2D2BpyKAptFecr+hrW5O5YUcSzu9X4wGgV-oJ3A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:59:24 +0300
Message-ID: <CAHp75Vdh0qfyutF6stPe1=eREg5iEHeUfE6MZO-nwsuhcNFTrg@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 8:55 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want to work towards phasing out the at24_platform_data structure.
>> There are few users and its contents can be represented using generic
>> device properties. Using device properties only will allow us to
>> significantly simplify the at24 configuration code.
>>
>> Remove the at24_platform_data structure and replace it with an array
>> of property entries. Drop the byte_len/size property, as the model name
>> already implies the EEPROM's size.
>>
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/board-dm644x-evm.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
>> index 6d35c6e1b0bd..abfcf42da6fb 100644
>> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
>> @@ -16,8 +16,8 @@
>>  #include <linux/gpio/machine.h>
>>  #include <linux/i2c.h>
>>  #include <linux/platform_data/pcf857x.h>
>> -#include <linux/platform_data/at24.h>
>>  #include <linux/platform_data/gpio-davinci.h>
>> +#include <linux/property.h>
>>  #include <linux/mtd/mtd.h>
>>  #include <linux/mtd/rawnand.h>
>>  #include <linux/mtd/partitions.h>
>> @@ -486,12 +486,8 @@ static struct nvmem_cell_lookup dm6446evm_mac_address_cell = {
>>         .nvmem_name = "1-00500",
>>  };
>>
>> -static struct at24_platform_data eeprom_info = {
>> -       .byte_len       = (256*1024) / 8,
>> -       .page_size      = 64,
>> -       .flags          = AT24_FLAG_ADDR16,
>> -       .setup          = davinci_get_mac_addr,
>> -       .context        = (void *)0x7f00,
>> +static const struct property_entry eeprom_properties[] = {
>> +       PROPERTY_ENTRY_U32("pagesize", 64),

Missed terminator, though

>>  };
>>
>>  /*
>> @@ -601,7 +597,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
>>         },
>>         {
>>                 I2C_BOARD_INFO("24c256", 0x50),
>> -               .platform_data  = &eeprom_info,
>> +               .properties = eeprom_properties,
>>         },
>>         {
>>                 I2C_BOARD_INFO("tlv320aic33", 0x1b),
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
