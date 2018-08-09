Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AE8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EFC21D66
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GC25dIrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EFC21D66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeHIN7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:59:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40723 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIN7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:59:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so9211915oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cBafueCHsJmipnJWAo3Im9OxRhjKYsdI+ng1bPqUiIs=;
        b=GC25dIrtvYPeoesfojuZWrLW4bNxgvHcs60o+gya6qWXd2yunXhhOJaAXaSC2l5sCz
         +p0tvTuQN2mZX4UGm7/R5dv8zw5HzZh+oviIY1NEwCYf+rttOayx+y+gAL6TIZtYa1Zw
         7a8m/MFpdARxDQVHNPgr5qZ8JPrTdGWGTP7JqhuYM48wKzIXM01FuAEq4eam5an7cEst
         8jz22uXcoJE1HzoCM83BmZAocxBB4NG+I04G1BdZFUhnyGb8QMxnyNMwbjNSnEVLJcUw
         234XAePa0VYazDx7l0v6RdgXtEnCFb1LE0i0KZjqfqkvpfp3FD9cmeN84nYeVm/hA3MJ
         5Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cBafueCHsJmipnJWAo3Im9OxRhjKYsdI+ng1bPqUiIs=;
        b=Xft07k5CKWbBy2Xrvi6i9xjyhJxeIw4u5G13kxC28pLINa4VsV+e9qhQuTT3AM/hvf
         Qx4jH9udH1ca+Qgno52ovnmxzv4Y/QkT0mXIbO8YVXS1+/0FyAMdnRmOXvidzlaDBlqg
         TosQUMkeqmOlb1YvzYdQvfbwqKhz+xd85fmDLCSyvsrhmDe3nu+Yjq8PbUHn/syf+tYu
         Hg+aipHUxMSQZP6NSThnblnib4jW5IAlxowUsgSAOsIIdgLP8bG19imBpHCC3ziHw29R
         E23weNzq9ObrmNdvoDrEw/5GkZSt5eb8peSTFZDKKc5t9cH7XhsBDDX9ZkUE9GmgAniB
         ShuQ==
X-Gm-Message-State: AOUpUlGWwZ8fY9tC0/tBzePA7t8OvJQesiu3qpqjMAeZgA7oBTrd1VO6
        sU+tnjyLuw3BVmA7hhf3LxtuHGhVOHsh9sYSFL6m2A==
X-Google-Smtp-Source: AA+uWPysqNHJ4P+ZfoiHEyl64/H8IIRuDkafiTBxFtvuvwdp1ydX2sSxWzXvyMH6O6Lj6rQFNrNEKKVICxN82ZLQtO0=
X-Received: by 2002:aca:cf0e:: with SMTP id f14-v6mr1825262oig.356.1533814513313;
 Thu, 09 Aug 2018 04:35:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2c03:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 04:35:12 -0700 (PDT)
In-Reply-To: <CAMRc=MdTgr-CTia55cRS-Ob8eOVBQom-nXB670nxjf89U_ZEvg@mail.gmail.com>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-29-brgl@bgdev.pl>
 <CAHp75Veiop-0xAbs7MtdhOrX_vzDz7v=xAUSDnEhTYVfMovFQA@mail.gmail.com> <CAMRc=MdTgr-CTia55cRS-Ob8eOVBQom-nXB670nxjf89U_ZEvg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 9 Aug 2018 13:35:12 +0200
Message-ID: <CAMpxmJU83V_2m+_iipJXGFvj1wgjRp3KHQtZooUc4Ctu1Hw4MA@mail.gmail.com>
Subject: Re: [PATCH 28/28] eeprom: at24: kill at24_platform_data
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-09 13:33 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> 2018-08-08 20:03 GMT+02:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> There are no more users of at24_platform_data. Remove the relevant
>>> header and modify the driver code to not use it anymore.
>>>
>>
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> If you want me to test this on Intel Galileo Gen 2 board, give me a
>> public tree from where I can pull.
>> Thanks.
>>
>
> Yes, you can pull from git@github.com:brgl/linux.git
> davinci-remove-at24-platform-data
>

The branch is topic/davinci-remove-at24-platform-data

> Bart
