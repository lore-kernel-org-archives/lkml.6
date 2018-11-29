Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4960C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D422145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D422145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeK3Kxe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:53:34 -0500
Received: from hermes.aosc.io ([199.195.250.187]:52358 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK3Kxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:53:34 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C1AD611EC13;
        Thu, 29 Nov 2018 23:46:09 +0000 (UTC)
Date:   Fri, 30 Nov 2018 07:45:34 +0800
In-Reply-To: <20181129214730.6d6aju4jurai6rmv@plaes.org>
References: <cover.1543443475.git.mesihkilinc@gmail.com> <20181129214730.6d6aju4jurai6rmv@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] [PATCH v5 00/17] initial support for "suniv" Allwinner new ARM9 SoC
To:     plaes@plaes.org, Priit Laes <plaes@plaes.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <3CE89E4F-BDE2-4715-8B15-B0167273C613@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年11月30日 GMT+08:00 上午5:47:30, Priit Laes <plaes@plaes.org> 写到:
>On Thu, Nov 29, 2018 at 01:33:10AM +0300, Mesih Kilinc wrote:
>> This is the fifth version of patchset for Allwinner ARMv5 F1C100s
>> SoC. Addressed comments from Maxime Ripard and Rob Herring, added
>signatures.
>
>IIRC, the original author of these patches was Icenowy, what happened
>to this?

I lost interest on maintaining this.

>> 
>> Changes since v4:
>> - Patch "dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl"
>>   - This patch applied for 4.21.
>> - Patch "pinctrl: sunxi: add support for suniv F1C100s (newer
>F-series SoCs)"
>>   - This patch applied for 4.21.
>> - Patch "dt-bindings: clock: Add Allwinner suniv F1C100s CCU"
>>   - Fixed license identifier position
>>   - Added DMA fields.
>> - Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
>>   - Added DMA reset and clock support.
>> - Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
>>   - Remove dt-binding headers. 
>>   - Fix uart0 pin label.
>> - Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
>>   - Fix uart0 pin label.
>> 
>> Changes since v3:
>> - Patch "ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner
>SoCs"
>>   - Remove CONFIG_ARCH_SUNXI_Vx. Use ARCH_MULTI_Vx to differentiate
>SoC's
>>   - Change KConfig ARCH_SUNXI selection: 'select' to 'default'. 
>> - Patch "irqchip/sun4i: Add a struct to hold global variables"
>>   - Split irq_sun4i.c changes to 3 patch.
>> - Patch "pinctrl: sunxi: add support for suniv F1C100s (newer
>F-series SoCs)"
>>   - pinctrl-suniv-f1c100s: remove: disable_strict_mode = true
>> - Patch "ARM: dts: suniv: add initial DTSI file for F1C100s"
>>   - suniv-f1c100s.dtsi: remove unnecessary componenets.
>>   - Instead of patching drivers, add original compatible string with 
>> f1c100s compatibles.
>>   - Add Acked-by signatures.
>> 
>> Changes since v2:
>> - Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
>>   - Move SUN4I_TIMER option to ARCH_SUNXI
>>   - Added help text for MACH_SUNIV
>> - Patch "irqchip/sun4i: add support for suniv interrupt controller"
>>   - Defined sunxi_irq_chip_data struct and used it to differentiate
>>     registers between different chips.
>> - Patch " ARM: dts: suniv: add initial DTSI file for F1C100s"
>>   - Removed unnecessary fake clock.
>>   - Fixed compatible strings.
>> 
>> Changes since v1:
>> - Patch "ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate ARMv5/v7
>>   Allwinner SoCs"
>>   - Instead of using a common bool config use a common menuconfig. 
>>   - Use ARCH_MULTI_V7 to differentiate V7 SoCs.
>>   - Addressed comment from Julian Calaby
>> - Patch "ARM: sunxi: add Allwinner ARMv5 SoCs"
>>   - Use ARCH_MULTI_V5 to differentiate V5 SoCs.
>>   - removed "allwinner,suniv" board compatible string
>>   - Added dt-bindings
>> - Patch "irqchip/sun4i: add support for suniv interrupt controller"
>>   - Added dt-bindings
>>   - Changed "allwinner,suniv-ic" to "allwinner,suniv-f1c100s-ic"
>> - Patch "clocksource: sun4i: add a compatible for suniv"
>>   - Added dt-bindings
>>   - Changed "allwinner,suniv-timer" to
>"allwinner,suniv-f1c100s-timer"
>> - Patch "pinctrl: sunxi: add support for suniv F1C100s (newer
>F-series SoCs)"
>>   - Added dt-bindings
>>   - Renamed suniv-pinctrl to suniv-f1c100s-pinctrl
>> - Patch "clk: sunxi-ng: add support for suniv F1C100s SoC"
>>   - Added dt-bindings
>>   - Renamed suniv-ccu to suniv-f1c100s-ccu
>> - Patch "ARM: suniv: f1c100s: add device tree for Lichee Pi Nano"
>>   - Addressed comment from Rask Ingemann Lambertsen
>> 
>> Thanks!
>> 
>> Mesih Kilinc (17):
>>   ARM: Check ARCH_MULTI_V7 to differentiate ARMv5/v7 Allwinner SoCs
>>   dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
>>   ARM: sunxi: add Allwinner ARMv5 SoCs
>>   dt-bindings: interrupt-controller: Add suniv interrupt-controller
>>   irqchip/sun4i: Add a struct to hold global variables
>>   irqchip/sun4i: Move IC specific register offsets to struct
>>   irqchip/sun4i: Add support for Allwinner ARMv5 F1C100s
>>   dt-bindings: timer: Add Allwinner suniv timer
>>   clocksource: sun4i: add a compatible for suniv
>>   dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
>>   pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)
>>   dt-bindings: clock: Add Allwinner suniv F1C100s CCU
>>   clk: sunxi-ng: add support for suniv F1C100s SoC
>>   dt-bindings: sram: Add Allwinner suniv F1C100s
>>   dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
>>   ARM: dts: suniv: add initial DTSI file for F1C100s
>>   ARM: suniv: f1c100s: add device tree for Lichee Pi Nano
>> 
>>  Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
>>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>>  .../interrupt-controller/allwinner,sun4i-ic.txt    |   4 +-
>>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>>  .../devicetree/bindings/sram/sunxi-sram.txt        |   4 +
>>  .../bindings/timer/allwinner,sun4i-timer.txt       |   4 +-
>>  .../devicetree/bindings/watchdog/sunxi-wdt.txt     |   1 +
>>  arch/arm/boot/dts/Makefile                         |   2 +
>>  arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  |  26 +
>>  arch/arm/boot/dts/suniv-f1c100s.dtsi               | 147 ++++++
>>  arch/arm/mach-sunxi/Kconfig                        |  19 +-
>>  arch/arm/mach-sunxi/sunxi.c                        |  10 +
>>  drivers/clk/sunxi-ng/Kconfig                       |   5 +
>>  drivers/clk/sunxi-ng/Makefile                      |   1 +
>>  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c           | 541
>+++++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h           |  34 ++
>>  drivers/clocksource/sun4i_timer.c                  |   5 +-
>>  drivers/irqchip/irq-sun4i.c                        | 106 ++--
>>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>>  drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      | 416
>++++++++++++++++
>>  include/dt-bindings/clock/suniv-ccu-f1c100s.h      |  70 +++
>>  include/dt-bindings/reset/suniv-ccu-f1c100s.h      |  38 ++
>>  23 files changed, 1408 insertions(+), 33 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
>>  create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
>>  create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
>>  create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
>> 
>> -- 
>> 2.7.4
>> 
>> -- 
>> You received this message because you are subscribed to the Google
>Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
