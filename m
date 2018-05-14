Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeENQJC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:09:02 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:32828 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbeENQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:08:59 -0400
X-Google-Smtp-Source: AB8JxZo8ilStsN4s2h/GUtaHX+yup00Oyn1HrgmJaWNVw2TAYGFDII+VJ47pmX9lXZfiYxwGLusoLz7KnH2shF3XOZw=
MIME-Version: 1.0
In-Reply-To: <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4@arm.com>
References: <20180225135134.GA14529@arx-s1> <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4@arm.com>
From: Hao Zhang <hao5781286@gmail.com>
Date: Tue, 15 May 2018 00:08:57 +0800
Message-ID: <CAJeuY7876=WEpg9M240ygNv6KW68_+tpP9PxpSQfKHNR7=FO-Q@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
To: =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux@armlinux.org.uk, linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4EG9M0Q008089

2018-02-28 9:53 GMT+08:00 André Przywara <andre.przywara@arm.com>:
> Hi,
>
> The subject line should mention the R40, there are far too many sun8i SoCs.

Okey.

>
> On 25/02/18 13:51, hao_zhang wrote:
>> This patch adds pwm node for sun8i.
>>
>> Signed-off-by: hao_zhang <hao5781286@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
>> index 173dcc1..99a0261 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -295,6 +295,11 @@
>>                               bias-pull-up;
>>                       };
>>
>> +                     pwm_ch0_pin: pwm-ch0-pin {
>> +                             pins = "PB2";
>> +                             function = "pwm";
>> +                     };
>> +
>>                       uart0_pb_pins: uart0-pb-pins {
>>                               pins = "PB22", "PB23";
>>                               function = "uart0";
>> @@ -306,6 +311,14 @@
>>                       reg = <0x01c20c90 0x10>;
>>               };
>>
>> +             pwm: pwm@1c23400 {
>> +                          compatible = "allwinner,sun8i-r40-pwm";
>> +                          reg = <0x01c23400 0x154>;
>
> Following my comments on the binding document:
>                         interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>
>> +                          clocks = <&osc24M>;
>
> And possibly multiple clocks here (though I fail to find the APB1 clock
> being exposed by our CCU).

It seem CCU dosen't support APB1 clock for R40 PWM...

>
> Cheers,
> Andre.
>
>> +                          #pwm-cells = <3>;
>> +                          status = "disabled";
>> +             };
>> +
>>               uart0: serial@1c28000 {
>>                       compatible = "snps,dw-apb-uart";
>>                       reg = <0x01c28000 0x400>;
>>
>
