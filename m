Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB359C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C25222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nv02ZIJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfBMJf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:35:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46131 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfBMJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:35:26 -0500
Received: by mail-lj1-f196.google.com with SMTP id v16so1369711ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6W125vmE79Uw+6Mv8wXGpTfxHccsp8RuPWiHXRGfpm8=;
        b=nv02ZIJMVJAq5hWxOGv5wFspy7OZW8zBjuyKr4ZegVgmogdK7y31PNzprj3hyDJu1W
         uhzED+U4HMuk3nS5oWA0fyngfQhqo3GYPdvVdAs+97XNWXRWpArtt7YodYI5gX/rgGeb
         qE5y8LVMOtjassqgyH/aLXrK6ZnJ1aasZDOR/yFOuG0ZHQgLLtNiudgJwxzj/XEtoaAI
         vVjcJMMUOOWtmQS4HgeDpC1nEyh8gNEFcjuDIKxNCj6WeXr5tawpOnt0SFwJwZQ4vkr7
         hL7gPkk6KziX8gO6Jksd05P3lA5qI7sBtQOF3O829vjE6Fo82XeBDcdhFjnmi/XwwTEt
         +hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6W125vmE79Uw+6Mv8wXGpTfxHccsp8RuPWiHXRGfpm8=;
        b=LsCqOrCbAdv2xRMnC66jjwYI2P9J2hYa0pVgAfBK/TVnf3CjXijGkwIR4gtepTN5aW
         F1zeg4AcspAk/5Hfnn+VFzf2WYrrabk3Y2ReJd2QLPfL8myCPGiTnSJYzOMKa2vkTiRt
         a0undL6pFi9xk0mDFGyiNP8QOuUQaULvFomNuJ19cvnZ4pzci7F4PGWqOmIFSBjjlys6
         Xd4IhXjFHGy+zbOIHIv8/i1eRn2wuu+kAqIYDou8Qq2Ecgof5kRnkTJTbMIUw50nzVNR
         7ONb6Ey1GqjJfDLHZY4xyH3GH7HbRVJ8FNqwqqCs867VK+hZGvtz94Sn+e0kfUzb6ACP
         vWxw==
X-Gm-Message-State: AHQUAubLPb6xh+yWSIW8ntKgLoTwbD8z2vu6RbPQ8M7JP7pZQH/Kp7pB
        kvNrosnR6lZv/zr8rwMhnIsfX/U07ofzLSjIMOeWhwBTuv0=
X-Google-Smtp-Source: AHgI3IYlyXY5m0cjkW4aVSyGhpa26fTJG5cLmR6Mv244t4ZqIXLhDl0wx+E4iqToMVbOtVtr+fItOYuzY4AMq/s8Ryw=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr5006317ljb.126.1550050524202;
 Wed, 13 Feb 2019 01:35:24 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <1549588593-4856-2-git-send-email-lkml@metux.net> <CACRpkdaFJyGYeDZ83LQBG4pr3tgtYPkDQ3RGrrGPM==Sw1vE2w@mail.gmail.com>
 <39fe843d-feba-c871-7b2d-407ab3a35082@metux.net>
In-Reply-To: <39fe843d-feba-c871-7b2d-407ab3a35082@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Feb 2019 10:35:11 +0100
Message-ID: <CACRpkdajLnMY3w40xx6jNEPqr-DYg2FjNgipt6tNBPgRoTx__w@mail.gmail.com>
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

On Mon, Feb 11, 2019 at 11:39 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> struct gpiod_lookup_table gpios_led_table[] = {
>     .dev_id = "leds-gpio.0",
>     .table = {
>         GPIO_LOOKUP_IDX("gpio.0", 0, "led", 0, GPIO_ACTIVE_LOW),
>         GPIO_LOOKUP_IDX("gpio.0", 1, "led", 1, GPIO_ACTIVE_LOW),
>         GPIO_LOOKUP_IDX("gpio.0", 2, "led", 2, GPIO_ACTIVE_LOW),
>     }
> };
>
> But unsure now to determine the correct names for dev_id (the
> leds-gpio instance ?) and the gpio chip. In the example, these
> seem to be autogenerated - how can I retrieve them from my
> actual devices ?

It is a bit tricky.

For the dev_id you need to be aware of the following from
<linux/platform_device.h>:
#define PLATFORM_DEVID_NONE     (-1)
#define PLATFORM_DEVID_AUTO     (-2)

If the platform device has .id set to -1 it will be just "leds-gpio",
if it is -2 it will be whatever, take a chance on .0 or ideally fix
it up. Any positive number like .id = 4 becomes "leds-gpio.4".

So figure out the .id field on the platform device.

Yours,
Linus Walleij
