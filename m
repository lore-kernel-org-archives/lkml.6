Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965417AbeEXI2w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:28:52 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33475 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965401AbeEXI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:28:46 -0400
X-Google-Smtp-Source: AB8JxZqZZOpkpv8AqMs8W8DMLumUFJcC8I4hA/hPtdvxBFvk9QTopMiCfwL92XO155g6cBbshpVJ6+dQC9Hl70TEcCM=
MIME-Version: 1.0
In-Reply-To: <1685755.J6GI985WX3@diego>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn> <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
 <1685755.J6GI985WX3@diego>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:28:44 +0200
Message-ID: <CACRpkdYCdNZ=ASw1uz4zKXC4AMd1EGbvG_G5K5cwSpH5eGPgKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Levin Du <djw@t-chip.com.cn>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4O8SuUw005251

On Wed, May 23, 2018 at 5:12 PM, Heiko Stübner <heiko@sntech.de> wrote:

> So the gpio controller should definitly also be a subnode.
>
> The gpio in question is called "mute", so I'd think the gpio-syscon driver
> should just define a "rockchip,rk3328-gpio-mute" compatible and contain
> all the register voodoo in the driver itself and not define it in the dt.
>
> So it should probably look like
>
> grf: syscon at ff100000 {
>         compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
>
>         [all the other syscon sub-devices]
>
>         gpio_mute: gpio-mute {
>                 compatible = "rockchip,rk3328-gpio-mute";
>                 gpio-controller;
>                 #gpio-cells = <2>;
>         };

I'm sceptic.

That doesn't sound like "general purpose input output" at all.

It sounds like special purpose, for a mute button.

Does it use IRQ? I would recommend implementing
drivers/input/keyboard/syscon-keys.c in the same vein
as drivers/leds/leds-syscon.c so you can avoid indirection
through GPIO for no good reason at all.

I already have other good uses for such a generic
input driver.

Yours,
Linus Walleij
