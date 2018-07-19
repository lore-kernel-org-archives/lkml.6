Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D63C2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NPcVZAzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D63C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbeGSPvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:51:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52618 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeGSPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:51:17 -0400
Received: by mail-it0-f67.google.com with SMTP id p4-v6so10262999itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xoXy4rAgjtfSqJVCQe2lr+UCSuYMA4N4rRr9iY1+DdE=;
        b=NPcVZAzdsz5HMeNXiMFm07ynAZzaL60zjUaL4bFyMU8htNfjnYtO/Nx/ft50RNCqZa
         RmkC+/NAfXFXkqD46xwfwuN5TwuRErVKmBPQ8viBXvunxyZwy3fjtIbFXKGAjosOeDxv
         JCZQpVH3qMG+gNwKzZ59QUpd6X03Jr9CKkY8jkhnioFxCT/tDbGlzOEY2E8aFPwWTRtk
         b95fTV86wnC5s8wVhmSIc3qRofcDskdKenhD0CdXoJ8Ac+5fQGE5dZMZkoHFisz0D8+o
         4uT0DSX1XqZD2nwvmhv0WGbxh9zZ9vb9TvxMij+RL97cXEJ2wCNKOsrCVf88/8Lrebxi
         HeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xoXy4rAgjtfSqJVCQe2lr+UCSuYMA4N4rRr9iY1+DdE=;
        b=Vp+r0DNwCI2lttDc2TJM0Chww657L9598i6gwq7+yut625zBuraOOrs4DUwejLURGb
         NABYLromjwYGfd5dvnripODu5V93yabMuloPXU7RvGQIF5FWtZyJnRyau2BSMCHYMCdN
         1UHb9uwiw86ijzzFY/JKbUrtlXTwLLwh8n3T+qZXpS2cCjKAFKt1c9T1HOSuvQM8IdOb
         hAQ4QqxmaWhOdmupBo7G8qblF785p25tLegMrHag2KXprqroxjeUcdwCmBbOm5gdN/Tq
         YqNQ/v1BkXvKQb3sqcyklrmUg+l/rJ1rnJAS2sx+KssBmrIVnY7e3au+XdSn+E/UZhL1
         UytA==
X-Gm-Message-State: AOUpUlFoMfkuZ0hP+PoMcghhKQUen5l38pJOEaiz0Zw6mzhpmu5tjxyD
        OFsBjn9R4NBVl1bZ9+gkp8goVXfgH2SBhMkCwHaiZw==
X-Google-Smtp-Source: AAOMgpeEqQgF57+S8w0EMZ7Xl3EdDfYI606n0ldYfzUTqXwVIlHTIFevf+xT6tWb5p96LUrixiJ/pIjfr/LjiI5BQ8c=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr5874579itg.141.1532012861196;
 Thu, 19 Jul 2018 08:07:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 08:07:40
 -0700 (PDT)
In-Reply-To: <20180719150138.GC9119@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch> <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch> <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
 <20180719150138.GC9119@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Jul 2018 17:07:40 +0200
Message-ID: <CAMRc=MfKedvD2OXes02op2ErGR2HKkzJwjHtv5i4NkbJAVg3dw@mail.gmail.com>
Subject: Re: [PATCH 5/5] net: add MTD support to eth_platform_get_mac_address()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 17:01 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Thu, Jul 19, 2018 at 10:14:29AM +0200, Bartosz Golaszewski wrote:
>> 2018-07-18 19:03 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> >> >> +#ifdef CONFIG_MTD
>> >> >> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
>> >> >> +     if (!addr) {
>> >> >> +             struct mtd_info *mtd;
>> >> >> +             int rv;
>> >> >> +
>> >> >> +             mtd = get_mtd_device_nm("MAC-Address");
>> >> >
>> >> > In order for this to go away, you need to keep backwards
>> >> > compatibility. When using nvmem, you look for a cell called
>> >> > "mac-address". Here you are looking for "MAC-Address". That is going
>> >> > to make backwards compatibility harder. How do you plan to do it?
>> >> >
>> >> >    Andrew
>> >>
>> >> I'm trying to adjust to already existing users. The only user of
>> >> get_mtd_device_nm() who calls it to read the MAC address registers a
>> >> partition called "MAC-Address". We can't change it since it's visible
>> >> from user space. In the future we'd just have to have a list of
>> >> supported string that we'd use to do the nvmem lookup.
>> >
>> > Why not have the nvmem cell called "MAC-Address"? When you add nvmem
>> > support to MTD, i assume you are going to map each MTD partition to an
>> > nvmem cell?
>>
>> Because all existing users of nvmem use "mac-address" as the name of
>> this cell already. I guess we will need to live with both in this
>> particular function.
>
> So i'm not convinced this last patch is making things better. I would
> prefer if it was dropped for the moment. Wait until MTD via nvmem is
> actually implemented and there is a concrete concept of how a MAC
> address would be looked up without having lots of ugly code.
>
>         Andrew

Unfortunately: this would effectively block me from improving the
support for older davinci boards. Having a (subjectively) ugly but
generalized way of reading the MAC address from MTD is still better
than using the MTD notifier from board files IMO.

Bart
