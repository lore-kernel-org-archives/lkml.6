Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F32C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1E320869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEzn0+z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBHObN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:31:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43905 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:31:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so3134680lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mq5ytE8YvrnuKCi4oHqQ2eQ6EX3egsfJA6B8csLpkkM=;
        b=dEzn0+z4WBb38MQDNyBvu0SwurTYoIsX8SnLxqN/IhEIWhZa+tORAWOsHQNIWVqqie
         08bW4qEH3SL9P7rXi3Hzxy1v7/cbnUAqyBzEI2e/BIc6g3ybA2pr7xu/h6ew1N45tAm0
         1FQLPpiedXHnHuJO30bpVxmCwBQMWaznLNgmxfLsmK2Hjxo7XyoCptJxgne505VCM9fT
         tFWpDroxDmSiLG7ue9+tdnsCmD4WX7E28iK4wgdrZE6EIpYOI4PoHx79VxiTvg3k9GJm
         a7F4lfoRg0R6/ZN0UYFETsUrU0cCYJn+d5npO/mO3meM4+cDnryyUDMQFqS0+s5TdsvM
         dFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mq5ytE8YvrnuKCi4oHqQ2eQ6EX3egsfJA6B8csLpkkM=;
        b=XrJWwidFj5DUyrmvgGqLA4Doo1UEQuh32H6EaSLsFnzJZvem5CzDGzIhH+Y6Hvg2FI
         R1MZbYdDTG7jxLaznwOjRdXk2/GbmbqfC2G6NEHPxWnM7Uj3uVPv/c29OTKZheIr6AJ+
         YZYeKB183kQ5blMXPHtfNUo0Pabnvu0Ys64eyDdFU8dbY/tkXQTx4rLJ4ZmlHGS0o8Xa
         fPUmiVQH3MzavGBRefy1A/WcCxfzz2tLvHRDm6Vekq81ZHbyq7HqKrrUc/cfpifataCL
         cNHLZTXWJfDkqDyl59rzYOsctu17Zl/qRItvV9FzBg9OOPTmMw9E5jryRDmap217jhcV
         mguQ==
X-Gm-Message-State: AHQUAuakoX/8IU/zDODMRPmcum05XVZWsXelFMZFQN3MCTTQUkA4lC3/
        roFXS9csGEFxpdfyHYddMrnc268BiBDLYNohoBrAVQ==
X-Google-Smtp-Source: AHgI3IZE0vZzD/UDSmJnPiMjAYT7bMMCqQHe7/MzIPsMFGF6h9slHF8CL1qv8Gr2REzP09LFVcAP9km44+NvxKoSfRQ=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr13205870ljt.107.1549636271237;
 Fri, 08 Feb 2019 06:31:11 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net> <1549588593-4856-2-git-send-email-lkml@metux.net>
In-Reply-To: <1549588593-4856-2-git-send-email-lkml@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:30:59 +0100
Message-ID: <CACRpkdaFJyGYeDZ83LQBG4pr3tgtYPkDQ3RGrrGPM==Sw1vE2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 2:16 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> From: "Enrico Weigelt, metux IT consult" <info@metux.net>
>
> Driver for PCengines APUv2 board that supports GPIOs via AMD PCH
> and attached LEDs and keys.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: linus.walleij@linaro.org
> Cc: bgolaszewski@baylibre.com
> Cc: dvhart@infradead.org
> Cc: andy@infradead.org
> Cc: platform-driver-x86@vger.kernel.org
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Andy can provide more details on this patch here are some quick
remarks:

> +#define GPIO_BASE              100
> +
> +#define GPIO_LED1              (GPIO_BASE+0)
> +#define GPIO_LED2              (GPIO_BASE+1)
> +#define GPIO_LED3              (GPIO_BASE+2)
> +#define GPIO_MODESW            (GPIO_BASE+3)
> +#define GPIO_SIMSWAP           (GPIO_BASE+4)

Instead of hardcoding the GPIO base and offsets like this, use:

#include <linux/gpio/machine.h>

and define a descriptor table using the name of your gpiochip.
There should be examples of other board quirks doing this.
I have already patched gpio-leds.c to accept LEDs from
descriptor tables, see commit
commit 45d4c6de4e497e5b0026c77044ae5fcddf8fecd8
"leds: gpio: Try to lookup gpiod from device"

Yours,
Linus Walleij
