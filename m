Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7DA20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YReHMyrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7DA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeGSWJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:09:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39079 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSWJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:09:34 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so9554889ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nIydwmEJRfC1iY/XxQZdQgFy5RjeAHvX3a9Q7CJ/gJ4=;
        b=YReHMyrR+KUiZrWpwDl3fZ8wnmmz8V9jRsR+s0c6IeonnDLwEOX6LEvDJQpWJLs3vb
         EXHnwYHuKRFE7IXjuPbVA6TuVQvkqCsr9m7b9fyHH+ZCUmMclVoqPzu+AVMhNinNBa46
         /XGWov8Y2h/83pwDZ88HdooKp/t1RGwhiBTnAC2IZQA3F5WMr86tiBMylAcY8K98UEWJ
         rDlHn5oQo4D7K6GgtET2uyUpy6S+/sLZdU2orN+AoWklPR9/x2SX0N6eqPLCVNKQNFeg
         RxTjUYkptMXYGpV6hRSjebHoq1tii+AcLmQM+YEoBFodlBfPwf197SCK7ZXpeWYvEOTo
         qpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nIydwmEJRfC1iY/XxQZdQgFy5RjeAHvX3a9Q7CJ/gJ4=;
        b=MB/PrC8w47JGJeHmKiwO9byDUm2BKBiXChZ/qVk9i3SLl6777Xzon4BHXMatxFXT2D
         jgnAXa06O3x4CThbEApzTjdAoky7VR3bpWsO2O2opEef7W3jl2MiXbrWFzOk2pBDzsAK
         qk1Uli97U+GSsjs+pGIfHKSVFSYwRmv2WocahdEAM3bpLDO7cEyfXVeXJRZr7eGGf3tt
         SvCDgs7BDsmrp3s59mTzJ+lC5UaEFPQlh2y7947cVMz1t9NmQrBFc78L1CocfYhh6UXz
         6zG2EH8bxKyW0yjlHpUvq2zKvvtDbI3SgeyB9PyqL+PE4dqMgB0pES4sXkIIfhmb3yhp
         d5uQ==
X-Gm-Message-State: AOUpUlEyJBhqSPiUcx8uiiYiEicpwyWxquSGb5hKxE4cGnMEL3/7q0Wb
        ScSeO1ku3/JMr8pXa1yQ5iUL0KeHqOT58sQP8dL66A==
X-Google-Smtp-Source: AAOMgpdQfiEqJgsRcjU4etuJ8XO3o1enRzwykB0aueHSgD4vQ0NjALvbLu43m70+Q2C0RyDUe/rW0a7w2JCwW5AS8tY=
X-Received: by 2002:a24:5e0b:: with SMTP id h11-v6mr7030199itb.80.1532035477764;
 Thu, 19 Jul 2018 14:24:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 14:24:37
 -0700 (PDT)
In-Reply-To: <20180719174728.GK6920@n2100.armlinux.org.uk>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-5-brgl@bgdev.pl>
 <20180719174728.GK6920@n2100.armlinux.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Jul 2018 23:24:37 +0200
Message-ID: <CAMRc=MfYp8Q4KNUMhLqf5jgd+C-_bWnfHworTbaCj0CZgRqMeA@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: add support for nvmem to eth_platform_get_mac_address()
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-19 19:47 GMT+02:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Wed, Jul 18, 2018 at 06:10:34PM +0200, Bartosz Golaszewski wrote:
>> @@ -544,6 +548,31 @@ int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>>                       from = "arch callback";
>>       }
>>
>> +     if (!addr) {
>> +             nvmem = nvmem_cell_get(dev, "mac-address");
>> +             if (IS_ERR(nvmem) && PTR_ERR(nvmem) == -EPROBE_DEFER)
>
> This is way too verbose.  To quote Al Viro from earlier today:
>
> <viro> sigh...
> <viro>         if (IS_ERR(link) && PTR_ERR(link) == -EEXIST)
> <viro> what the hell is wrong with if (link == ERR_PTR(-EEXIST))?
>
> I wonder why so many people haven't heard of pointer comparison... ;)
>
> IS_ERR(ERR_PTR(-EPROBE_DEFER)) is always true - if it wasn't, then
> we'd be in for problems.
>
> So, if you're asserting that nvmem is ERR_PTR(-EPROBE_DEFER) then
> there's no need to do the IS_ERR(nvmem) must also be true.  Hence, a
> simple pointer comparison is sufficient:
>
>                 if (nvmem == ERR_PTR(-EPROBE_DEFER))
>                         return -EPROBE_DEFER;
>

Hi Russell,

this issue is gone now in v3 but thanks for the example - I somehow
never thought about it.

Bart
