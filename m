Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D125AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DF2177D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="gBf9msOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8DF2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbeHINhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:37:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40034 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeHINhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:37:11 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so1984503ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lah9RiRar2mkn3FzoHAkaxdIBc+cCvpeSzfLtPuGlQY=;
        b=gBf9msOmRSV2ZRLe2JtvoC1DyxEgyJ8L9JebfRd2GPp7HYnGqYhPi3/hp0+zcH4Q6g
         vRx3dOyJbFY7QGqAYvr1OlF5mjLTH18RA2db5VJPo9vvcD3myJaqZ45qc48x/roVEnnr
         JzF0xY335Ub2rAW+IiykLcBBWN7jikDbQpEVT77ocP3G/ja7vEjGB/16v89K4pQQy7Bo
         8zeNuTq7Gy2DRvMM+fuqAw+e3Rhfx80n7UuRLfd1aQFiKwY2uQCTS1rZrS7xzsiBdBr8
         jlIq1uD2mAk7DTRO8AzaZ7XHEeqO3JXzC7hn4LjVASe+j7hKFhC6ounQzIuRRK2tb+IX
         oNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lah9RiRar2mkn3FzoHAkaxdIBc+cCvpeSzfLtPuGlQY=;
        b=DzTx/Ipkl3KbkS0J1kn+JZW3h5Uzh3bXGAqAgqHhjoNzZ1hXujrwWOu99FwbDtm07l
         rd/UXwIDtppjcOa/KWbz/J1Ybc8tirM7D7y9ptJq8+lcU5gYohFWkYR7epn/YbVIx0au
         LEaGxMyLKgBoxE4He0e4U3ki9SBz0IICosSzDua+pQjgRhOJJRiQBEn6WDObdx5tYxSk
         T5rv98h3Wd4YMHpCTZ0/DacYA8mtUmTJbGVqeMKlt/UJ1FuG74xmiswgDLJka1kuepHb
         M9EZES1jRqW1205yFeaGNJTTChjazQXkXlf9ir1ZTj1PFLItWodjMVBQzF0NrUDkhSxi
         a1sQ==
X-Gm-Message-State: AOUpUlFmc9CRSER/o5T3aI4wbtGMZ7E/YPUuUNQhZLFjqeMrbt/1VbPR
        ejmv47n1BZBQutWtR8R73iCmrsNREzSAkuASZmbPuw==
X-Google-Smtp-Source: AA+uWPzb2UWAzUPh+nBGLNILzuc2MIdjEyoLJSFseezuV3dlT+OvkJi94LFxXHQCmGhQNwEaIwmM/Sd9tFJm8IQkY3Y=
X-Received: by 2002:a02:b70b:: with SMTP id g11-v6mr1449345jam.34.1533813168441;
 Thu, 09 Aug 2018 04:12:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9403:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 04:12:47 -0700 (PDT)
In-Reply-To: <CAHp75VfxVOPzAtBgTe4RSax1Ki+323WDBTSmh=j7LV_c+vsXDA@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-15-brgl@bgdev.pl>
 <CAHp75VfxVOPzAtBgTe4RSax1Ki+323WDBTSmh=j7LV_c+vsXDA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 9 Aug 2018 13:12:47 +0200
Message-ID: <CAMRc=MfgoCt1BvRx1jJrYp_258_Z9NTNs7waEiOCvdTsK+KWFg@mail.gmail.com>
Subject: Re: [PATCH 14/28] net: split eth_platform_get_mac_address() into subroutines
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

2018-08-08 19:50 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We want do add more sources from which to read the MAC address. In
>> order to avoid bloating this function too much, start by splitting it
>> into subroutines, each of which takes care of reading the MAC from
>> one source.
>
>> +static int mac_address_from_of(struct device *dev, u8 *mac_addr)
>>  {
>>         const unsigned char *addr;
>> +       struct device_node *np;
>>
>
>> +       np = dev_is_pci(dev) ? pci_device_to_OF_node(to_pci_dev(dev))
>> +                            : dev->of_node;
>
> I didn't get these manipulations.
>
> What the scenario when pci_dev->dev.of_node != dev->of_node?
>
> --
> With Best Regards,
> Andy Shevchenko

I'll add an additional patch that addresses it.

Bart
