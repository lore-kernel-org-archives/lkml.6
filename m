Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B159C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59542178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ1qlbPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59542178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeHHUD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:03:27 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34401 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHUD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:03:27 -0400
Received: by mail-ua0-f194.google.com with SMTP id r15-v6so3332525uao.1;
        Wed, 08 Aug 2018 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uzUvgscPNw8M3trWj2cQxWMQo/CdhT1fRSE/rXdxwrQ=;
        b=RZ1qlbPdGsoC5/3jTpYFz0SwEO1MWyHMHsZyqkAdvnfC3IOl7K4bcJcobr/Q2tqZyp
         jy0/gwZU1xJnNZbvtm+8BdL+770fVvR1VoW5VakehVN1Xq3ePk2nl1htVevRS3tEx4A3
         gGr5cN1GoQ0SXUfNe8P1vxMyiV4aJStUZmEz5NeZEdUDqvtKaQaaQUnFs11KXI05EfXq
         FjAQOu1r6JX+2uUHkg9Z1xPfxrssKEKguZ9DK+7aAaWu12Qrke1hrvsemuS7wZOKsN6s
         qLvaEbdAQdq/1z2mqx/gIxeGRWejgW83yUeOBDE2LF+ZcdO0VD06RjOf4cnu4b79zNN9
         6/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uzUvgscPNw8M3trWj2cQxWMQo/CdhT1fRSE/rXdxwrQ=;
        b=GW1gBt/TAScOs/xu4a+plk593cZ/ywCLv0Z4U2OdJErqyleWW1SL3kTrddnhhX4WyA
         SUmLkE2qucY3XWQsSQUkPxhO6esH2fve8Y8WD7UTEsrrle4LqVnagYEaroTI2Du204cQ
         rPOO8Enkj6hHDm9FP7lr26mMqAI+KvqvxGsrz6EcTx0ilf5ua+hXUKBjmFLD0rSrkEjG
         dOhFrN/od9Bgx+8bB463xm2T0BwBVhOSahgRouBiYGDhvRSx+o3fCLu5zG28JAdMn1uR
         +rKV+2yGmZLzsx4I3Ijy7PD+rFv4y+3gcqdJwf9JEo+Lv3IFmcUit0QsITxCdPjBnej4
         KGNQ==
X-Gm-Message-State: AOUpUlEIiX6FXrZkvpD8JSRl4KspDJRCpHab7n6rPJBnk4j79fdSX2UZ
        YbSkbFSbg0WxatL1nYWXYMzAVfN2rj89/YsZ29g=
X-Google-Smtp-Source: AA+uWPyeReVilhhxxKVMrMb07Day2cm7mMeS1fgh3CwJvvUzkokKc5kNs5LG8MGK3naGr5Rqk87oPPWwy4jDrlvEYFQ=
X-Received: by 2002:ab0:4025:: with SMTP id h34-v6mr2688667uad.12.1533750162575;
 Wed, 08 Aug 2018 10:42:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:42:42 -0700 (PDT)
In-Reply-To: <20180808153150.23444-5-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-5-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:42:42 +0300
Message-ID: <CAHp75Ve6ugVGJ9JqCYri0_k93DgkPMua7g8dC5CMhT4uFHMgoA@mail.gmail.com>
Subject: Re: [PATCH 04/28] nvmem: provide nvmem_device_name()
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

On Wed, Aug 8, 2018 at 6:31 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Kernel users don't have any means of checking the names of nvmem
> devices. Add a routine that returns the name of the nvmem provider.
>
> This will be useful for nvmem notifier subscribers - otherwise they
> can't check what device is being added/removed.

> +const char *nvmem_device_name(struct nvmem_device *nvmem)
> +{
> +       return dev_name(&nvmem->dev);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_device_name);

Just wondering if *_dev_name() is more common pattern in the kernel
(at least pci_dev_name() comes immediately to mind).


-- 
With Best Regards,
Andy Shevchenko
