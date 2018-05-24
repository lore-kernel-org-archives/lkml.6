Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965585AbeEXIsW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:48:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50646 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965559AbeEXIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:48:00 -0400
X-Google-Smtp-Source: AB8JxZqkHVGomVZcy19kUOlACPzd2f8la+luxdhsXpeqEueXHndQXOPp74mOVpQCWJNvNTnIccYx3uNnqNIrawlHf7k=
MIME-Version: 1.0
In-Reply-To: <2044895.BqI5yRtle6@diego>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1685755.J6GI985WX3@diego> <CACRpkdYCdNZ=ASw1uz4zKXC4AMd1EGbvG_G5K5cwSpH5eGPgKA@mail.gmail.com>
 <2044895.BqI5yRtle6@diego>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:47:59 +0200
Message-ID: <CACRpkdYrHyGmMOi-qNTRxC=TR1wMnM30PxdHfNAApmZ0ucnjJg@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4O8mTW9008794

On Thu, May 24, 2018 at 10:35 AM, Heiko Stübner <heiko@sntech.de> wrote:
> Am Donnerstag, 24. Mai 2018, 10:28:44 CEST schrieb Linus Walleij:
>> On Wed, May 23, 2018 at 5:12 PM, Heiko Stübner <heiko@sntech.de> wrote:
>> > So the gpio controller should definitly also be a subnode.
>> >
>> > The gpio in question is called "mute", so I'd think the gpio-syscon driver
>> > should just define a "rockchip,rk3328-gpio-mute" compatible and contain
>> > all the register voodoo in the driver itself and not define it in the dt.
>> >
>> > So it should probably look like
>> >
>> > grf: syscon at ff100000 {
>> >
>> >         compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
>> >
>> >         [all the other syscon sub-devices]
>> >
>> >         gpio_mute: gpio-mute {
>> >
>> >                 compatible = "rockchip,rk3328-gpio-mute";
>> >                 gpio-controller;
>> >                 #gpio-cells = <2>;
>> >
>> >         };
>>
>> I'm sceptic.
>>
>> That doesn't sound like "general purpose input output" at all.
>>
>> It sounds like special purpose, for a mute button.
>>
>> Does it use IRQ? I would recommend implementing
>> drivers/input/keyboard/syscon-keys.c in the same vein
>> as drivers/leds/leds-syscon.c so you can avoid indirection
>> through GPIO for no good reason at all.
>
> To quote Levin from the other mail:
> --------
> The "mute" pin is a output only GPIO, which is already supported by
> setting flags in the gpio-syscon
>   driver. And yes, this pin has a defined function, but can also be used
> for general purpose operation.
> --------
>
> So to summarize, the documentation calls it "mute", but it is usable as
> a general pin, which is the reason Levin is working on it - because on his
> board this pin is used to switch between two voltages (aka a gpio-regulator)
> for the sdmmc controller [3.3V + 1.8V].

OK then, I was wrong! :)

Go ahead with this, sorry for the fuzz.

Yours,
Linus Walleij
