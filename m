Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95A8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825A720693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="icra8ysF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825A720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbeGSI41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:56:27 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33725 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbeGSI41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:56:27 -0400
Received: by mail-io0-f179.google.com with SMTP id z20-v6so6383979iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bm1G+fUXII+2uTc5vTIF3YvFG/E6LMV8RgVIqKQehH0=;
        b=icra8ysF6OCrRW+XpEbWMyUGZVmXKuBH5Yks/BypmKOHn5+oAVHw6E/yJCpQTU4Emy
         FjUx4H1dv5YSIiR8qzjM6UVNiPN4qy8A0U0cEe1TkFydZyYqPKGqUkn6H4pN3OUukxys
         5ewtY5f6/Yy9FGdyZpYs8p/Hn+eRGGxnVZpJ+T4q+iGabaKUl0Plht6M7fxdpe9VQhYG
         a6k5QzR3LpGlEmXCuYBgGGE7DYqimGs7ckwVyTR30bv6ylCTWKtuTMMmig4WwbIj+T/l
         gZntuBHogQ/+PVIAZYNhr2QCurxs8yp9eM6t3+7t1cA5npx4z7TIYNkOVUfSS9P7ZJ2l
         5qNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bm1G+fUXII+2uTc5vTIF3YvFG/E6LMV8RgVIqKQehH0=;
        b=f7EKoBtj1isUYgry72SATSRde06jlu80quzdqbI9v7EHXPhzJ5qisNE69opH+N6hEc
         KTDzpUPXkyDbFnhJBeHDytRWFoYr2CG/ZjAvFARW8JmeKTH3NhcLH3K6Od45yWW8j0M/
         9IRZmEnqRDqzyaenUfq35uLLWKxAMYfAcBEGgDQs/qBdqdxn1TUOrxNyS3lTb8HBohWR
         WBZV10J4WmH2T1GSRAGoGS6HrNE15ypveD34wcW+WgGc07ElsfdmmDVdeuHEUF0NU3io
         K87FH7Cpj8KqgosBH4p+iNLCqunsRE8GTeHq/Gj+TWvNksL/OSsVdrPmgAB8ADqG5TMg
         spHw==
X-Gm-Message-State: AOUpUlEVtOak4FLz0ETQMwfbtb5cCXuaxdYLdMV1j+GZGQetR7EFdiVO
        S1+0LnrMQEj9fGv0oSGGtXP+tMdq2ce0q3nwDVDU/g==
X-Google-Smtp-Source: AA+uWPxuryXohyIPbSqokJFn4rc/+0oPDY2y+bKsm1NGoahnqx93T1Fpj5voiKRxjGSiedPx2/Rg2FUvLf+axrKpcZY=
X-Received: by 2002:a6b:c844:: with SMTP id y65-v6mr7685708iof.187.1531988069852;
 Thu, 19 Jul 2018 01:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 01:14:29
 -0700 (PDT)
In-Reply-To: <20180718170352.GF12477@lunn.ch>
References: <20180718161035.7005-1-brgl@bgdev.pl> <20180718161035.7005-6-brgl@bgdev.pl>
 <20180718164737.GE12477@lunn.ch> <CAMRc=MeRv3_C8_R-Awfr1zjLa3G_CVAACc-2t_ihB+1v+BCTGw@mail.gmail.com>
 <20180718170352.GF12477@lunn.ch>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Jul 2018 10:14:29 +0200
Message-ID: <CAMRc=Md3oeEktzrA9UZyNPX6pB4bG+Gv0o6cjbs0UUKb3sYTsA@mail.gmail.com>
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
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-18 19:03 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
>> >> +#ifdef CONFIG_MTD
>> >> +     /* NOTE: this should go away as soon as MTD gets nvmem support. */
>> >> +     if (!addr) {
>> >> +             struct mtd_info *mtd;
>> >> +             int rv;
>> >> +
>> >> +             mtd = get_mtd_device_nm("MAC-Address");
>> >
>> > In order for this to go away, you need to keep backwards
>> > compatibility. When using nvmem, you look for a cell called
>> > "mac-address". Here you are looking for "MAC-Address". That is going
>> > to make backwards compatibility harder. How do you plan to do it?
>> >
>> >    Andrew
>>
>> I'm trying to adjust to already existing users. The only user of
>> get_mtd_device_nm() who calls it to read the MAC address registers a
>> partition called "MAC-Address". We can't change it since it's visible
>> from user space. In the future we'd just have to have a list of
>> supported string that we'd use to do the nvmem lookup.
>
> Why not have the nvmem cell called "MAC-Address"? When you add nvmem
> support to MTD, i assume you are going to map each MTD partition to an
> nvmem cell?

Because all existing users of nvmem use "mac-address" as the name of
this cell already. I guess we will need to live with both in this
particular function.

Bart
