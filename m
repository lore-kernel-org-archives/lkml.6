Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F1C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A757721771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugl6+L3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A757721771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbeHHUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:04:40 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40397 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeHHUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:04:40 -0400
Received: by mail-ua0-f194.google.com with SMTP id m13-v6so3299293uaq.7;
        Wed, 08 Aug 2018 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fudOnXwiyicpJhQkavPEDADRlehvB8IQIeG6e043V2s=;
        b=ugl6+L3tM9fD0k+gFVHnudzyBbjILu7fy6yCW0gy1owqYXIDlq1PxaWsUHjFIDnWJz
         fWeZHouO9gdJBD5N7yLD2A7HR6PdSN3wV4m7wK2f1b9G9w+H46W34ckZvOZKHT6rVxAm
         QRm07MB7K0d0hOpy5cf/MEqbA1AtXEweSK2YZmcgPYKYmoMkZT2I56eIi0wnuvFJkdMT
         ad6T5eSTaST+mPcO961pmGf211fXPalT9QjVW9BMVubq6k7PVAkafgLYODHSgJ/38DdD
         vWwnFQIZZowkdXAASrS90Nrf5stGKP3EY6cdpccrtLaxdwmv6Xxi5YF3KBJ/qzN9zkPL
         agNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fudOnXwiyicpJhQkavPEDADRlehvB8IQIeG6e043V2s=;
        b=c5xxefFPUwgehLUkhwsL1/+mejmWMp68d+BxNczgGGVlK1hTt6+lVeL6keIYf8q/hK
         znsDYZXH1b8pcOA1TSkN5Bgzy/gmkSC1CCeFvcC7IpShpppntWmr2Ui48SyG9EjUZfDp
         58LaaU7dNU3Rg3jLfjaN20riYbYgyD2PFUnGhJk28GSrgXZo1vKXJbwqxRPO4H1h0zU3
         u8yrmBYQQ7J6j6LeI0AiR3GoiX1DtIlWhjvNiNm8VjraFXbktMRenFfpkcOMCCrcvPew
         /ntCtLdwonJF1CLo45SPVo4f/7/YNr91NTeoeTKbYJbDDurIu80deQFWmM+hQcf0Kohd
         0l6g==
X-Gm-Message-State: AOUpUlE+vu1ggwPb4EQeiARxTCIN0oWRnS8PvdYurk+Qc0GtH2BdCEIf
        RIDci/yqPEBGxpXTKH1IJMuMhaY6TFTmaMIZjzA=
X-Google-Smtp-Source: AA+uWPwKpXl3Be6QW0/t3sBAtnvBrCdS7YRpc6uENnoBjBfHeW+bZJqMrrfj+yyLjYG7sGnbuI9mdgC3J/ffSGTqHO8=
X-Received: by 2002:a1f:920b:: with SMTP id u11-v6mr2483619vkd.58.1533750235483;
 Wed, 08 Aug 2018 10:43:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:43:54 -0700 (PDT)
In-Reply-To: <20180808153150.23444-8-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-8-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:43:54 +0300
Message-ID: <CAHp75VdXTS9kg5PF-YrTbi8f1U9qSKU+1D43-p0PgphKeJdVNA@mail.gmail.com>
Subject: Re: [PATCH 07/28] ARM: davinci: dm365-evm: use nvmem lookup for mac address
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
> We now support nvmem lookups for machine code. Add a lookup for
> mac-address.

>  #include <linux/spi/spi.h>
>  #include <linux/spi/eeprom.h>
>  #include <linux/v4l2-dv-timings.h>
> +#include <linux/nvmem-provider.h>

It looks from this context that your patch broke the order.

P.S. Can you verify all in the series for this?

-- 
With Best Regards,
Andy Shevchenko
