Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DAAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4E208D4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dppKh2de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB4E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeHHSqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:46:55 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46702 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeHHSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:46:54 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so4699621oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lP4mi9PPJIm1zUwCtC6JByBe2u0Q/YYzzEUq968p+Is=;
        b=dppKh2deWupMOrlpH7s2uvh1H2QCEOgG4CLxeEHNssWChTbkPe7LNOf3IdJhuaQ388
         b5oSrZtkRhxbgKt8I75g63VFNsXuG1TgYXtNFhN6tph4us1cdoxA2SD4awE7MZZs/8FH
         xbE0SjEMFg1wH5gKX+Ar0fWUFTuKSYFFh5/QamhFru7SYehvzUDp8ZXC1Xn2uF+4ChYH
         iV54U3sVJ7JHhVQnuRT3KDLJBNcAgemNV4uzJeMJmqvoZn/ztwnMY7cSk5HsGIDAR7ah
         6BYaYHH+ObSWPrWJTf+CXKuT86bhWdpiIprtYjlyX47Ct8gx14v5RLKd1AlINZalo2tJ
         kNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lP4mi9PPJIm1zUwCtC6JByBe2u0Q/YYzzEUq968p+Is=;
        b=WxBOIAGuAp3W+boLtt8cAJ7FpB6/Qa0FCiBmWfxeBNtNVwN6ZulKSpt9IcJSXNXNwL
         BULDevzsTgksNH/PmAXgQwsc4VerNj7XQW73rUpNmi9IopKm47vxBxhRIxr3+CFfZPVH
         QztTb4K8rw1a+FZlDXc4yBeeEM30GYXIcTH+m7KK/pbkIzJSHiyQ2OonVn4/uEXdF8EE
         t5ZgMJIX/EM+ojJLB6/utveTgwg4jVbIgKKEyA3Vlik9pSrba7Qj2EW++e+71nTEONGc
         KML2NOqBKHFOMso6bcHS/i7E9Wc2IqV3cnMMo9LojPiY2l8krSvNQm8PcNB/4TNJAqFT
         4Obg==
X-Gm-Message-State: AOUpUlHRAFl6TDbrMyEQDDHeY6Wv7gpS1cYeLvESLLyfcLBZxhUBaJ1N
        iBvqpvHnDw9FJb8gbRvcDVMOt2AOla6Z6HEjGGecFg==
X-Google-Smtp-Source: AA+uWPy/YzJXAjYM52NifsEdmm8P3gTej++7sQbGoLn1kkBIp91tGGbdhPKPOG1VK1PXOTil9b/wBrC257LGv7qN3DY=
X-Received: by 2002:aca:5e42:: with SMTP id s63-v6mr3418116oib.134.1533745588176;
 Wed, 08 Aug 2018 09:26:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c03:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 09:26:27 -0700 (PDT)
In-Reply-To: <20180808162042.GG7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-7-brgl@bgdev.pl>
 <20180808162042.GG7275@lunn.ch>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 8 Aug 2018 18:26:27 +0200
Message-ID: <CAMpxmJXpx69oOjVccTLiDLus+gCXtMegc329udX99s1rZ2VJFQ@mail.gmail.com>
Subject: Re: [PATCH 06/28] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
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
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-08 18:20 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Aug 08, 2018 at 05:31:28PM +0200, Bartosz Golaszewski wrote:
>> From: Alban Bedel <albeu@free.fr>
>>
>> Allow drivers that use the nvmem API to read data stored on MTD devices.
>> For this the mtd devices are registered as read-only NVMEM providers.
>> On OF systems only devices that have the 'nvmem-provider' property
>> are registered, on non-OF system all MTD devices are registered.
>> @@ -570,6 +613,11 @@ int add_mtd_device(struct mtd_info *mtd)
>>       if (error)
>>               goto fail_added;
>>
>> +     /* Add the nvmem provider */
>> +     error = mtd_nvmem_add(mtd);
>> +     if (error)
>> +             goto fail_nvmem_add;
>> +
>
> Hi Bartosz
>
> Maybe it is hiding somewhere, but i don't see any code looking into
> device tree looking for the 'nvmem-provider' property.
>
>        Andrew

Ugh, I copied the commit message from Alban's patch. For the moment
there's no such thing, you're right. I'll fix it for v2.

Bart
