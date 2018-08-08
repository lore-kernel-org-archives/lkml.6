Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE1C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81152216F2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHQcLzTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81152216F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbeHHULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:11:45 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33099 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:11:45 -0400
Received: by mail-ua0-f193.google.com with SMTP id i4-v6so3355401uak.0;
        Wed, 08 Aug 2018 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngxSF88L3UPmGJiFCLGrUmz76gNbLrC+CIojozODNoU=;
        b=CHQcLzTfBE62taG8EKKEpED36TtIvBYBKcU7MxitLbwbaTTtOQ8iiyO1xc26oMHjMX
         wlyxa3heJx44p6scDp1kglvY+Fkq/zM+NGMmH6JcRu1j5P7TwpaR1knNIiR3xKIfc+u2
         4kUFY4jd82OGKNy+c1SKwTqdW5nou9bVpfQzLb816O79lPEQH8PRZO87jiCMSifJAJ/x
         0uFWHnJ/NO7Zd2wPIzSRWe1iTGoCnhDfRAgW2GmkvuAiU0mjsHqDDJ7TZendYOZ3J61z
         Irwzg7y6A+SlMQaHHVav74qL8jpeBayKTP3DToqVwiRwHtGXWLZ8mPyN8tQDSPF28eob
         nUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngxSF88L3UPmGJiFCLGrUmz76gNbLrC+CIojozODNoU=;
        b=bDzHMKEKrSU9lMTlLGwdCFySHQpV1L8gNVWpJNSrL2hnblUl5/vFt3S6mf7e0WEFiE
         ofDpOjdCM5H6IjoawhKjUAQr6aCM8C3uPk6lufKrS2n6pF7B4AhVL86d69s7r+8hgQO4
         zEadgWSNauGp7aF1sgcyCKgKdB2XBBmSeEJ9y+1bLYextjYm67QbGTwlJ6BdujHS5yeB
         AfhCym7H1xnGQlpJoyosQq4eMVAlcGyo5j3G68FP3DULcGv6VpP23b/+aCe0MiQu3oRK
         bMGlEcnw2njor/xrY5hoJFT2OPL6nFlhRA/ExQj25gX5+IqArm+Hb5UkwfgZjiC8UsE4
         L2DQ==
X-Gm-Message-State: AOUpUlFUxlru50cdOzzuaKm03SHs99l8niMny00xGTLwmL161qX9b+5y
        huP193ZVnEWtURb7tQcH+OFtrfgJn0S+y35jv1E=
X-Google-Smtp-Source: AA+uWPxVjZdd5z1dGYPEUDpn4NgSIsb6z7r/ftShyIM5joIWKbyezPSR30K/8geKZg5FORE026R9+tFMiVTwmkJEDfw=
X-Received: by 2002:a1f:4c7:: with SMTP id 190-v6mr2488178vke.63.1533750659079;
 Wed, 08 Aug 2018 10:50:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 10:50:58 -0700 (PDT)
In-Reply-To: <20180808153150.23444-15-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl> <20180808153150.23444-15-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Aug 2018 20:50:58 +0300
Message-ID: <CAHp75VfxVOPzAtBgTe4RSax1Ki+323WDBTSmh=j7LV_c+vsXDA@mail.gmail.com>
Subject: Re: [PATCH 14/28] net: split eth_platform_get_mac_address() into subroutines
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
> We want do add more sources from which to read the MAC address. In
> order to avoid bloating this function too much, start by splitting it
> into subroutines, each of which takes care of reading the MAC from
> one source.

> +static int mac_address_from_of(struct device *dev, u8 *mac_addr)
>  {
>         const unsigned char *addr;
> +       struct device_node *np;
>

> +       np = dev_is_pci(dev) ? pci_device_to_OF_node(to_pci_dev(dev))
> +                            : dev->of_node;

I didn't get these manipulations.

What the scenario when pci_dev->dev.of_node != dev->of_node?

-- 
With Best Regards,
Andy Shevchenko
