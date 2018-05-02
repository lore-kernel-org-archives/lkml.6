Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeEBLuY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:50:24 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34812 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:50:22 -0400
X-Google-Smtp-Source: AB8JxZpN0E7JJZYxDJ45P7H+PbNgJBh0GSs5HH41OpHtzDQOGUWFRvkWthO0bQWBKHDoFz1nstxnOuUajb2eZNLClvA=
MIME-Version: 1.0
In-Reply-To: <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-3-jagan@amarulasolutions.com> <20180502113250.5i2eyzv237t5oyl6@flea>
 <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
From: Jagan Teki <jagannadh.teki@gmail.com>
Date: Wed, 2 May 2018 17:20:19 +0530
Message-ID: <CAD6G_RQ3HmHBjwcUoCCth5TwVy5ygx_KwRmRjrkpwoOpvy7vvQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 02/21] arm64: dts: allwinner: a64: Add
 DE2 CCU
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42BoW32013865

On Wed, May 2, 2018 at 5:04 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> 于 2018年5月2日 GMT+08:00 下午7:32:50, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>>On Mon, Apr 30, 2018 at 05:10:39PM +0530, Jagan Teki wrote:
>>> DE2 in A64 has clock control unit and behavior is
>>> same like H3/H5, so reuse the same in A64.
>>>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> index 1b2ef28c42bd..67b80bbe5bf5 100644
>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>>> @@ -43,9 +43,11 @@
>>>   */
>>>
>>>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>>> +#include <dt-bindings/clock/sun8i-de2.h>
>>>  #include <dt-bindings/clock/sun8i-r-ccu.h>
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
>>> +#include <dt-bindings/reset/sun8i-de2.h>
>>>
>>>  / {
>>>      interrupt-parent = <&gic>;
>>> @@ -168,6 +170,19 @@
>>>              #size-cells = <1>;
>>>              ranges;
>>>
>>> +            display_clocks: clock@1000000 {
>>> +                    compatible = "allwinner,sun50i-a64-de2-clk",
>>> +                                 "allwinner,sun50i-h5-de2-clk";
>>
>>The A64 was released before the H5, so that should be the other way
>>around.
>>
>>> +                    reg = <0x01000000 0x100000>;
>>> +                    clocks = <&ccu CLK_DE>,
>>> +                             <&ccu CLK_BUS_DE>;
>>> +                    clock-names = "mod",
>>> +                                  "bus";
>>> +                    resets = <&ccu RST_BUS_DE>;
>>> +                    #clock-cells = <1>;
>>> +                    #reset-cells = <1>;
>>> +            };
>>> +
>>
>>So it turns out we don't need the SRAM to access the CCU driver?
>
> As now U-Boot claims SRAM, people may forget thus :-(

I've sent few mails about how we represent de2 with sram_c [1] but
none response after. Can I get further inputs so-that we can include
sram_c in proper manner.

[1] https://patchwork.kernel.org/patch/10289737/

Jagan.
