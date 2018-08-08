Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EB7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD0D208D4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rK7eTX7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD0D208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeHHSrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:47:52 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42640 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:47:52 -0400
Received: by mail-oi0-f67.google.com with SMTP id b16-v6so4735070oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YhaKZIqjDESWe1+0KnHRsmtXQnZ2TdYFXQzMb7Qioag=;
        b=rK7eTX7pZwFt2PI8Siw2vJ8Uy2Zrs/Dci6By62CMdd6RHvtof7k9w30Ir+66AAmFKB
         EpVN16JjoFu9e8NfFvHbg498V+8QSLKZBCnhfw/tlsLPDcUYns4OR3kl5jWFYgi0OWMV
         dTFlWAwMI4pJ5RCB7WucI5VLLNdgRMyImqplRo4qac4py8sWqcCvfHtjYHnz8PoJIj4v
         OHpO/nbTcyUZhKGL26yPHSSjCj4DBKK99ThT5UN3/OEAq3OiBQgY0PNkoEmzPKrXtsJz
         FhdO4CorjnkChpH4m7r+Ykg/nopZPtmXHqObpnOLFsaTcN7l9NKmEe64vuZmgJ8/bUTZ
         WxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YhaKZIqjDESWe1+0KnHRsmtXQnZ2TdYFXQzMb7Qioag=;
        b=UXGsb0afOGONLRSwNxGRaoBt+Y80PQUNFdPavTi9MbZSww4n2797aPTff2u4PzOSuw
         7jerKMHSUrNn+qojO/cTGP/QS+4ctk7BLgaIkT3s0F8U3uopHOreaDIGlri3Tr85ifFy
         eBkw/eSm7nQ6VRVDTQ+GUQKaEdJ3cmpePANm2jCH37EWFulDjL6LSrYr2MG+RMzE9ADW
         7wDyP5t13ley1gJcymsn1EZ4eoaAwsiQug93GW9upK/MejmDta8U7lqJuQAcoGYqlbvV
         dI3Tc2dYS2tI6MQJwqr5MYadqJPSahO0YJj1P+RpXWoSbTeWgw0ZuTYn+XhCKW4FW9b2
         rcZw==
X-Gm-Message-State: AOUpUlGkTr1MwusTNjE4wJ3MyzMOfU47J0QAmKCs36ygCjzABmpIDcbo
        lHkEDtBarGrBwxhTunJDYrJ+qNDczieOsvnRRq1nvg==
X-Google-Smtp-Source: AA+uWPx6GI3obp4nlQVlqCr2olTkJ8HBgcT2mgpv1CNv4tfahVf1M2EoPRKC1BnPNCg5gloBVSG4Z9tYjQT5x6XnEfg=
X-Received: by 2002:aca:5e42:: with SMTP id s63-v6mr3421427oib.134.1533745645996;
 Wed, 08 Aug 2018 09:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c03:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 09:27:25 -0700 (PDT)
In-Reply-To: <20180808155548.s7p4xqsjywz3psrj@ninjato>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808155548.s7p4xqsjywz3psrj@ninjato>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 8 Aug 2018 18:27:25 +0200
Message-ID: <CAMpxmJXVNiyqF4qaYtNhPUG3mSZVdvBSGUqDYK-nh59BKeh=Gw@mail.gmail.com>
Subject: Re: [PATCH 00/28] at24: remove at24_platform_data
To:     Wolfram Sang <wsa@the-dreams.de>
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
        Andrew Lunn <andrew@lunn.ch>,
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

2018-08-08 17:55 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Aug 08, 2018 at 05:31:22PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This is a follow-up to the previously rejected series[1] which partially
>> removed the at24_platform_data structure. After further development and
>> taking reviews into account, this series finally removes that struct
>> completely but not without touching many different parts of the code
>> base.
>>
>> Since I took over maintainership of the at24 driver I've been working
>> towards removing at24_platform_data in favor for device properties.
>
> Wooha, nice work. I can't really comment on it but wondered how you want
> to upstream it (after reviews)? Pull request of an immutable branch for
> nvmem-tree sounds best to me. Then I could also pull it in if i2c needs
> it. Probably same situation for arm-soc...
>

I initially wanted to merge small parts of it starting with v4.18, but
there were some voices against merging APIs without users. I'm not
sure how it should go in. There'll be a need for multiple immutable
branches most probably...

Bart
