Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71022178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSjTQbnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71022178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeHHUUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:20:55 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36792 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeHHUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:20:55 -0400
Received: by mail-ua0-f195.google.com with SMTP id c12-v6so3375171uan.3;
        Wed, 08 Aug 2018 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QlrxmH2OfZkWCPu/JDILLtLL8fGPu0Km/c9e1TkaC+4=;
        b=mSjTQbncu/eNETdbyE/bWAPiCGlbRCQXtKcT9D9jZ0u4GhKEXrn/JxJMTt/1AfYkw5
         lyWVTV6jV9pLbThsSUuaxQTYICeVsOy/8SCzdKL9vfK9RDC2i74l2YgrxBLRf+YCDddD
         h+Gc3vfQp21GAyNqivKT2tSCkfzpNq9gq4XrV3GKAzFgr+0bdAPyMiInRB00Tr6KQKlo
         lCApS6SJEAjyPQGhw+3f0qPVa5Ax7rl0pqWLJw6z4HdSPaVJLlutcgS9Y25kz8yjEtkT
         rzQ0YxJ1thQ3Yd2gRbpBegT8r+0Cxx3VofNWWRAPMlUux8BRop269RrMnyG9okoh6Z9d
         cByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QlrxmH2OfZkWCPu/JDILLtLL8fGPu0Km/c9e1TkaC+4=;
        b=udRov11fRRLLzTgogVtVhVYC8xDG/gsqqG6dbtpn0A+pFyuNQGrfkeCPeFs1Qe4wPW
         BQe8QwY4OJxQDg63nl1RXpTegEiOiB6t3eUYzQGjNtGd7NgJLyLcAQY5WTczQCRWFWR5
         rKxGbB9aDC+v+I7Er4sAVCL++9R5QCFN18Q++TyS5vw9abFgPRPoTD4RjsG1rAq4G5Cn
         FuaPvbb9xEwtn/74lUVnIa5Q68M0QC/kqCJm523Xdb4rRUEyd7SK0otRKohKptMkvMwV
         rltzmbZqdS1PLR9H8RefX8txrlm3p964J4BPMgy82OJneGN4I+1WJ2tu9TX+dCNDLfcr
         x7YQ==
X-Gm-Message-State: AOUpUlGGiFT/EGOzr0Rwe23BdQN3QGhr4aQ6ZO9Atq4a0WnAsmzKKRcO
        2QHN9PScXBLTqJ6dXNXN1xG7FTGMbbk3x8FbvPU=
X-Google-Smtp-Source: AA+uWPxW1xNytMWfti7sWjfwzmzPxOldCUgo56PK8ksryjmNNVJdyVEfUxc7L2SuuDJaY+hd9KDKdt73YieHzIoHf1Q=
X-Received: by 2002:a1f:844e:: with SMTP id g75-v6mr2645386vkd.16.1533751206641;
 Wed, 08 Aug 2018 11:00:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 11:00:05 -0700 (PDT)
In-Reply-To: <CAHp75VfU6Dsge0XX5h18zjY9kJ73kFPevLT9j7vZBO__tNronw@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-25-brgl@bgdev.pl>
 <CAHp75VfU6Dsge0XX5h18zjY9kJ73kFPevLT9j7vZBO__tNronw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 21:00:05 +0300
Message-ID: <CAHp75VfVVn5jMp9E5-d7K+x=_ZtWO9kV3nxn=NDqTpQyjp3sdQ@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 8:57 PM, Andy Shevchenko
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
>>  arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
>> index f6a4d094cbc3..680e5d7628a8 100644
>> --- a/arch/arm/mach-davinci/board-sffsdr.c
>> +++ b/arch/arm/mach-davinci/board-sffsdr.c
>> @@ -26,7 +26,7 @@
>>  #include <linux/init.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/i2c.h>
>> -#include <linux/platform_data/at24.h>
>> +#include <linux/property.h>
>>  #include <linux/mtd/mtd.h>
>>  #include <linux/mtd/rawnand.h>
>>  #include <linux/mtd/partitions.h>
>> @@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
>>         .resource       = davinci_sffsdr_nandflash_resource,
>>  };
>>
>> -static struct at24_platform_data eeprom_info = {
>> -       .byte_len       = (64*1024) / 8,
>> -       .page_size      = 32,
>> -       .flags          = AT24_FLAG_ADDR16,
>> +static const struct property_entry eeprom_properties[] = {
>> +       PROPERTY_ENTRY_U32("pagesize", 32),
>> +       { },

No comma needed

>>  };
>>
>>  static struct i2c_board_info __initdata i2c_info[] =  {
>>         {
>>                 I2C_BOARD_INFO("24c64", 0x50),
>> -               .platform_data  = &eeprom_info,
>> +               .properties = eeprom_properties,
>>         },
>>         /* Other I2C devices:
>>          * MSP430,  addr 0x23 (not used)
>> --
>> 2.18.0
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
