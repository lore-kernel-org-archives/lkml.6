Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFECC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C922922433
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jzZVqEAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C922922433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeHJSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:48:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33403 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbeHJSsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:48:19 -0400
Received: by mail-it0-f66.google.com with SMTP id d16-v6so5110002itj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qpDChSEoVOJBPGx9YmxkwlUonMQ7vT7RN3awaNxdtiA=;
        b=jzZVqEAaMmIH2ybo1dK0Fx0LdoATYIo8pEwHs3ChBJMYx0VdKlF2Iu75Lm7yflPCC9
         RrVTUTphMA/O7ZnVzsvTOKco1FY+JwKhtevTgeU3z5poo56HVg5b08tx/fCezH7Si6E1
         koel88l99C3elXlb7VRWLdjApI2O1s+g1LWVZB3p+JQFe7NqmvovWt69KNrQ6LJMxf0I
         saCmBeGEQzSjIc0UAtHPTfurEsVKiDmL7ad8d3+JklSg+yeHesmiOCavnBzExzJHgNWt
         IczNUjCE7FsPIdOWwsG+8RqKl0/8GdqFyOR4UzwRf3DgACnFdmajmFZQ+BroXCcg6yHr
         FFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qpDChSEoVOJBPGx9YmxkwlUonMQ7vT7RN3awaNxdtiA=;
        b=uLmWmsmzJUEDcVxxrW47QS3MjyumTnmJlECeza0E7NyIL+WxH0/3F62eeJmLEA2R8t
         XqTDmqQnMqcBoBjSjSndtqIU9XneEyU9ZgLyL5jAxmMcI4pxHfiS+JsCYiG2aK8v8nop
         9cBnIPxkYtaauG5aLFJNCJacRdWZfwkWiALchHETi2jCXW8AUgpcwmrz2itrSZqygXlD
         ujnvREXs2aFWA62xGAFntSA8p9NKIqLc9qNUNUHFI36JVLT7h8zukK6/oFsCxXjPPvrh
         EF3GLx9Ad2NSFPMhj3betL/2dYhqPnqNbTZsTScIhTZUrSDGa2ApGlzqHIfinh4gfxdf
         wujg==
X-Gm-Message-State: AOUpUlFRfXBc9cztvAuVeHMZLtHzdEVYtz8Apm/HRJlbERocBaxgwe63
        75tJZ7ACki5OienjTu4n1jsZbfBMfC9kVa7ty8WEZw==
X-Google-Smtp-Source: AA+uWPzpeb/2JVSgNeJasnJYXgD7ZXD42sYm44M8NAkM6aadB9hAPMQZexX4qqmVX3WBXtilV3YULLku+p5eZcjZyPs=
X-Received: by 2002:a24:1013:: with SMTP id 19-v6mr2722355ity.141.1533917868345;
 Fri, 10 Aug 2018 09:17:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9403:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:17:47
 -0700 (PDT)
In-Reply-To: <CAHp75Ve28aNe+FCK3p4OLsDf7dNo-iJ1VR=pyx+Y9OUn3sjYBw@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-15-brgl@bgdev.pl>
 <CAHp75Ve28aNe+FCK3p4OLsDf7dNo-iJ1VR=pyx+Y9OUn3sjYBw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Aug 2018 18:17:47 +0200
Message-ID: <CAMRc=Mc536v+L_u0garWbeyQ78Q6tyEEzhR9pRGf5mBU+daE+w@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] net: simplify eth_platform_get_mac_address()
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

2018-08-10 16:39 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Fri, Aug 10, 2018 at 11:05 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We don't need to use pci_device_to_OF_node() - we can retrieve
>> dev->of_node directly even for pci devices.
>>
>
>>         struct device_node *dp;
>>
>> -       if (dev_is_pci(dev))
>> -               dp = pci_device_to_OF_node(to_pci_dev(dev));
>> -       else
>> -               dp = dev->of_node;
>> -
>> +       dp = dev->of_node;
>>         addr = NULL;
>>         if (dp)
>>                 addr = of_get_mac_address(dp);
>
> Looking more at this I could even propose to change all above by
>
> addr = device_get_mac_address(dev, mac_addr, ETH_ALEN);
>
> Thoughts?
>
> --
> With Best Regards,
> Andy Shevchenko

Indeed seems like it's even more generalized. Thanks for spotting that.

Bart
