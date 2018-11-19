Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E1C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80B020989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2fLeeq2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80B020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbeKTCKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeKTCKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:10:16 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377EE20C01;
        Mon, 19 Nov 2018 15:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542642375;
        bh=tl5a+NVLB6a4CbyqKNrS0ivii6C1e2k3gh+G9YGKrSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2fLeeq2rtm2Og4fLjoNnlKhgMmpdeTrwGMgoL/2fa25Zovi2PfNWS3Zb1Bh0Soj8r
         lnLXvZi4J7CyWuqR1iswqSzUS5yqOVOxMVXM7Lc12yf5IZFA5BD3ad6md7L4MpaSLA
         JycgVxts3VSc0GhrTa8rfN5E3zf4AAfanrSCJhV8=
Received: by mail-qk1-f175.google.com with SMTP id 131so49245743qkd.4;
        Mon, 19 Nov 2018 07:46:15 -0800 (PST)
X-Gm-Message-State: AGRZ1gJLilpIJRwedFKdRThk7OXYMK+UPUV1ZoVlizLF2+mHh6/Wn+EM
        W4vkg/0eNHhDroLsZNFDL2NK+tIbyg3j8AKsGQ==
X-Google-Smtp-Source: AJdET5fEE+/ZeUN06R9Qcc9wTqhEP4zNyua4Cq7NqjZwmjE9oCiYJWKRrCdmzd/4EapF61tgeSNztd5WqjDC2QNyu4o=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr21738135qtf.26.1542642374154;
 Mon, 19 Nov 2018 07:46:14 -0800 (PST)
MIME-Version: 1.0
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com> <1542589336-13925-3-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1542589336-13925-3-git-send-email-sugaya.taichi@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Nov 2018 09:46:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJiZnoUK7sgNYGpxzcF+rjpj6cV54jW2z4_7hui-WWenA@mail.gmail.com>
Message-ID: <CAL_JsqJiZnoUK7sgNYGpxzcF+rjpj6cV54jW2z4_7hui-WWenA@mail.gmail.com>
Subject: Re: [PATCH 12/14] ARM: dts: milbeaut: Add device tree set for the
 Milbeaut M10V board
To:     sugaya.taichi@socionext.com, ARM-SoC Maintainers <arm@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 7:01 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Add devicetree for Milbeaut M10V SoC and M10V Evaluation board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/milbeaut-m10v-evb.dts  |  35 +++
>  arch/arm/boot/dts/milbeaut-m10v-evb.dtsi |  17 ++
>  arch/arm/boot/dts/milbeaut-m10v.dtsi     | 510 +++++++++++++++++++++++++++++++

I'm not seeing why you need this split into 3 files instead of 2.

>  4 files changed, 563 insertions(+)
>  create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dts
>  create mode 100644 arch/arm/boot/dts/milbeaut-m10v-evb.dtsi
>  create mode 100644 arch/arm/boot/dts/milbeaut-m10v.dtsi

Build your dtb with 'W=12' and fix any warnings.

>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d..ee6220b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1207,6 +1207,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>         mt7623n-bananapi-bpi-r2.dtb \
>         mt8127-moose.dtb \
>         mt8135-evbp1.dtb
> +dtb-$(CONFIG_MACH_M10V_EVB) += milbeaut-m10v-evb.dtb

ARM SoC maintainers,

Can we start at least start putting new SoCs in vendor subdirs? This
one doesn't appear to share anything.

>  dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>  dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-ast2500-evb.dtb \
> diff --git a/arch/arm/boot/dts/milbeaut-m10v-evb.dts b/arch/arm/boot/dts/milbeaut-m10v-evb.dts
> new file mode 100644
> index 0000000..af8d6e4
> --- /dev/null
> +++ b/arch/arm/boot/dts/milbeaut-m10v-evb.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Socionext Milbeaut M10V Evaluation Board */
> +/dts-v1/;
> +#include "milbeaut-m10v-evb.dtsi"
> +
> +/ {
> +       cpus {

cpus is not board specific.

> +               cpu@0 {

Unit-address is wrong. Should be '@f00' to match reg.

> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0xf00>;
> +               };
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0xf01>;
> +               };
> +
> +               cpu@2 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0xf02>;
> +               };
> +               cpu@3 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0xf03>;
> +               };
> +
> +       };
> +       trampoline: trampoline@0x0000F100 {

Also, not board specific.

This should be under a simple-bus node. The unit-address should be '@f100'.

> +               compatible = "socionext,smp-trampoline";
> +               reg = <0x0000F100 0x100>;

Use lowercase hex.

> +       };
> +};
> diff --git a/arch/arm/boot/dts/milbeaut-m10v-evb.dtsi b/arch/arm/boot/dts/milbeaut-m10v-evb.dtsi
> new file mode 100644
> index 0000000..fc35c0b
> --- /dev/null
> +++ b/arch/arm/boot/dts/milbeaut-m10v-evb.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "milbeaut-m10v.dtsi"
> +
> +/ {
> +       model = "Socionext M10V EVB";
> +       compatible = "socionext,sc2000a", "socionext,milbeaut-m10v-evb";

Wrong order. And these need to be documented.

> +       interrupt-parent = <&gic>;
> +       chosen {
> +               bootargs = "consoleblank=0 loglevel=8 init=/sbin/finit root=/dev/mmcblk0p2 rootwait ro console=ttyUSI0,115200n8 console=/dev/tty1 ";

Most of these options look user specific and should be dropped. Use
'stdout-path' to specify the default console.

> +               linux,initrd-start = <0x4A000000>;
> +               linux,initrd-end =   <0x4BF00000>;

initrd should be filled in by the bootloader.

> +       };
> +       memory {

Needs a unit-address.

> +               device_type = "memory";
> +               reg = <0x40000000  0x80000000>;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/milbeaut-m10v.dtsi
> new file mode 100644
> index 0000000..4745dc6
> --- /dev/null
> +++ b/arch/arm/boot/dts/milbeaut-m10v.dtsi
> @@ -0,0 +1,510 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "skeleton.dtsi"

Don't use skeleton.dtsi. It is deprecated.

> +
> +/ {
> +       compatible = "socionext,sc2000a";
> +       interrupt-parent = <&gic>;
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };

Just move this to the other file with the cpu nodes.

> +
> +
> +       gic: interrupt-controller@1d000000 {
> +               compatible = "arm,cortex-a7-gic";
> +               interrupt-controller;
> +               #interrupt-cells = <3>;
> +               reg = <0x1d001000 0x1000>, /* Distributer base and size */
> +                     <0x1d002000 0x1000>; /* CPU I/f base and size */
> +       };
> +
> +       m10v-clk-tree@ {

unit-address

> +               compatible = "socionext,milbeaut-m10v-clk-regs";
> +               reg = <0x1d021000 0x4000>;
> +
> +               clocks {
> +                       #address-cells = <0>;
> +                       #size-cells = <0>;
> +
> +                       uclk40xi: uclk40xi {
> +                               compatible = "fixed-clock";
> +                               #clock-cells = <0>;
> +                               clock-frequency = <40000000>;
> +                       };

Any fixed clocks from oscillators on the board should be at the top
level and defined as inputs to the clock controller node with a
'clocks' property.

> +
> +                       aumclki: aumclki {
> +                               compatible = "fixed-clock";
> +                               #clock-cells = <0>;
> +                               clock-frequency = <20000000>;
> +                       };
> +
> +                       rtc32k: rtc32k {
> +                               compatible = "fixed-clock";
> +                               #clock-cells = <0>;
> +                               clock-frequency = <32768>;
> +                       };
> +
> +                       pxrefclk: pxrefclk {
> +                               compatible = "fixed-clock";
> +                               #clock-cells = <0>;
> +                               clock-frequency = <100000000>;
> +                       };
> +
> +                       pcisuppclk: pcisuppclk {
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               clock-div = <20>;
> +                               clock-mult = <1>;
> +                       };

Please look at any recent example of clock bindings. We don't try to
describe every divider, mux, gate, etc. in DT, but just clock
controller blocks with all the output clocks enumerated in clock
cells.

> +
> +                       usb2_clk: usb2_clk {
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll1: pll1 {
> +                               compatible =
> +                               "socionext,milbeaut-m10v-pll-fixed-factor";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               offset = <1>;
> +                               clock-div = <1>;
> +                               clock-mult = <40>;
> +                       };
> +
> +                       pll2: pll2 {
> +                               compatible =
> +                               "socionext,milbeaut-m10v-pll-fixed-factor";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               offset = <2>;
> +                               clock-div = <1>;
> +                               clock-mult = <30>;
> +                       };
> +
> +                       pll6: pll6 { /* CLK 6-1 */
> +                               compatible =
> +                               "socionext,milbeaut-m10v-pll-fixed-factor";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               offset = <7>;
> +                               clock-div = <1>;
> +                               clock-mult = <35>;
> +                       };
> +
> +                       pll7: pll7 { /* CLK 7-1 */
> +                               compatible =
> +                               "socionext,milbeaut-m10v-pll-fixed-factor";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               offset = <8>;
> +                               clock-div = <1>;
> +                               clock-mult = <40>;
> +                       };
> +
> +                       pll9: pll9 { /* CA7CLK, ATCLK */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               clock-div = <1>;
> +                               clock-mult = <33>;
> +                       };
> +
> +                       pll10: pll10 {
> +                               compatible =
> +                               "socionext,milbeaut-m10v-pll-fixed-factor";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               offset = <10>;
> +                               clock-div = <5>;
> +                               clock-mult = <108>;
> +                       };
> +
> +                       pll11: pll11 { /* CLK 11-1 */
> +                               compatible =
> +                               "socionext,milbeaut-m10v-pll-fixed-factor";
> +                               #clock-cells = <0>;
> +                               clocks = <&uclk40xi>;
> +                               offset = <12>;
> +                               clock-div = <2>;
> +                               clock-mult = <75>;
> +                       };
> +
> +                       emmcclk: emmcclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll11>;
> +                               offset = <28>; /* EMMCCLK */
> +                               mask = <0x3>;
> +                               ratios = <15 0x7 10 0x6 9 0x5 8 0x4>;
> +                       };
> +
> +                       pll1_div_1_2: pll1_div_1_2 { /* CLK 1-2 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll2_div_1_2: pll2_div_1_2 { /* CLK 2-2 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll2>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll6_div_1_2: pll6_div_1_2 { /* CLK 6-2 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll6>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll6_div_1_3: pll6_div_1_3 { /* CLK 6-3 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll6>;
> +                               clock-div = <3>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll7_div_1_2: pll7_div_1_2 { /* CLK 7-2 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll7_div_1_5: pll7_div_1_5 { /* CLK 7-5 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7>;
> +                               clock-div = <5>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll10_div_1_2: pll10_div_1_2 { /* CLK 10-2 */
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll10>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       spiclk_mux_0: spiclk_mux_0 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll10_div_1_2>;
> +                               offset = <227>; /* SPICLK */
> +                               mask = <0x3>;
> +                               ratios = <4 0x5 2 0x4>;
> +                       };
> +
> +                       spiclk_mux_1: spiclk_mux_1 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7_div_1_2>;
> +                               offset = <227>; /* SPICLK */
> +                               mask = <0x3>;
> +                               ratios = <8 0x6>;
> +                       };
> +
> +                       spiclk: spiclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-mux";
> +                               #clock-cells = <0>;
> +                               clocks = <&spiclk_mux_0>, <&spiclk_mux_1>;
> +                       };
> +
> +                       ca7wdclk: ca7wdclk {
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll2_div_1_2>;
> +                               clock-div = <12>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       pll9_div_1_2: pll9_div_1_2 {
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll9>;
> +                               clock-div = <2>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       mclk400: mclk400 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <295>; /* MCLK400 */
> +                               mask = <0x3>;
> +                               ratios = <4 0x7 2 0x5>;
> +                       };
> +
> +                       mclk200: mclk200 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <291>; /* MCLK200 */
> +                               mask = <0x7>;
> +                               ratios = <8 0xf 4 0xb>;
> +                       };
> +
> +                       aclk400: aclk400 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <288>; /* ACLK400 */
> +                               mask = <0x3>;
> +                               ratios = <4 0x7 2 0x5>;
> +                       };
> +
> +                       aclk300: aclk300 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll2_div_1_2>;
> +                               offset = <352>; /* ACLK300 */
> +                               mask = <0x1>;
> +                               ratios = <6 0x3 4 0x2>;
> +                       };
> +
> +                       aclk: aclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <276>; /* ACLK */
> +                               mask = <0x7>;
> +                               ratios = <8 0xf 4 0xb>;
> +                       };
> +
> +                       aclkexs: aclkexs {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <272>; /* ACLKEXS */
> +                               mask = <0x7>;
> +                               ratios = <8 0xf 6 0xd 5 0xc 4 0xb>;
> +                       };
> +
> +                       hclk: hclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <263>; /* HCLK */
> +                               mask = <0xf>;
> +                               ratios = <16 0x1f 8 0x17>;
> +                       };
> +
> +                       hclkbmh: hclkbmh {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <268>; /* HCLKBMH */
> +                               mask = <0x7>;
> +                               ratios = <8 0xf 4 0xb>;
> +                       };
> +
> +                       pclk: pclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               offset = <256>; /* PCLK */
> +                               mask = <0x3f>;
> +                               ratios = <32 0x5f 16 0x4f>;
> +                       };
> +
> +                       pclkca7wd: pclkca7wd {
> +                               compatible = "fixed-factor-clock";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll1_div_1_2>;
> +                               clock-div = <16>;
> +                               clock-mult = <1>;
> +                       };
> +
> +                       rclk: rclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll10_div_1_2>;
> +                               offset = <0>; /* RCLK */
> +                               mask = <0x3>;
> +                               ratios = <64 0x7 48 0x6 32 0x5 16 0x4>;
> +                       };
> +
> +                       uhs1clk0: uhs1clk0 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7>;
> +                               offset = <3>; /* UHS1CLK0 */
> +                               mask = <0xf>;
> +                               ratios = <16 0x14 8 0x13 4 0x12 3 0x11 2 0x10>;
> +                       };
> +
> +                       uhs1clk1_div1: uhs1clk1_div1 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7>;
> +                               offset = <8>; /* UHS1CLK1 */
> +                               mask = <0xf>;
> +                               ratios = <16 0x14 8 0x13>;
> +                       };
> +
> +                       uhs1clk1_div2: uhs1clk1_div2 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll6_div_1_2>;
> +                               offset = <8>; /* UHS1CLK1 */
> +                               mask = <0xf>;
> +                               ratios = <1 0x18>;
> +                       };
> +
> +                       uhs1clk1: uhs1clk1 {
> +                               compatible = "socionext,milbeaut-m10v-clk-mux";
> +                               #clock-cells = <0>;
> +                               clocks = <&uhs1clk1_div1>, <&uhs1clk1_div2>;
> +                       };
> +
> +                       uhs1clk2_div1: uhs1clk2_div1 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7>;
> +                               offset = <13>; /* UHS1CLK2 */
> +                               mask = <0xf>;
> +                               ratios = <16 0x14 8 0x13 4 0x12>;
> +                       };
> +
> +                       uhs1clk2_div2: uhs1clk2_div2 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll6_div_1_2>;
> +                               offset = <13>; /* UHS1CLK2 */
> +                               mask = <0xf>;
> +                               ratios = <1 0x18>;
> +                       };
> +
> +                       uhs1clk2: uhs1clk2 {
> +                               compatible = "socionext,milbeaut-m10v-clk-mux";
> +                               #clock-cells = <0>;
> +                               clocks = <&uhs1clk2_div1>, <&uhs1clk2_div2>;
> +                       };
> +
> +                       uhs2clk: uhs2clk {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll6_div_1_3>;
> +                               offset = <18>; /* UHS2CLK */
> +                               mask = <0x7>;
> +                               ratios = <18 0xf 16 0xe 14 0xd 13 0xc
> +                                               12 0xb 11 0xa 10 0x9 9 0x8>;
> +                       };
> +
> +                       nfclk_div1: nfclk_div1 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7_div_1_2>;
> +                               offset = <22>; /* NFCLK */
> +                               mask = <0x1f>;
> +                               ratios = <40 0x24 16 0x23 13 0x22 10 0x21
> +                                               8 0x20>;
> +                       };
> +
> +                       nfclk_div2: nfclk_div2 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll7_div_1_5>;
> +                               offset = <22>; /* NFCLK */
> +                               mask = <0x1f>;
> +                               ratios = <10 0x28>;
> +                       };
> +
> +                       nfclk: nfclk {
> +                               compatible = "socionext,milbeaut-m10v-clk-mux";
> +                               #clock-cells = <0>;
> +                               clocks = <&nfclk_div1>, <&nfclk_div2>;
> +                       };
> +
> +                       clk5: clk5 {
> +                               compatible = "socionext,milbeaut-m10v-clk-div";
> +                               #clock-cells = <0>;
> +                               clocks = <&pll10_div_1_2>;
> +                               offset = <239>; /* NETAUSEL */
> +                               mask = <0x3>;
> +                               ratios = <64 0x7 48 0x6 32 0x5 16 0x4>;
> +                       };
> +               };
> +       };
> +
> +       peri-timer@1e000000 { /* 32-bit Reload Timers */

timer@1e000050

This and all memory mapped peripherals go under simple-bus nodes(s).

> +               compatible = "socionext,milbeaut-m10v-timer";
> +               reg = <0x1e000050 0x10>, <0x1e000060 0x10>;
> +               interrupts = <0 91 4>;
> +               clocks = <&rclk>;
> +       };
> +
> +       timer { /* The Generic Timer */
> +               compatible = "arm,armv7-timer";
> +               interrupts = <GIC_PPI 13
> +                               (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_PPI 14
> +                               (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_PPI 11
> +                               (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
> +                       <GIC_PPI 10
> +                               (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +               clock-frequency = <40000000>;//40M
> +               always-on;
> +               arm,cpu-registers-not-fw-configured;

This was a work-around for some existing platforms. New platforms
should fix the firmware/bootloader.

> +       };
> +
> +       dummy_clk: dummy_clk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <50000000>;
> +       };
> +
> +       pinctrl: pinctrl@1d022000 {
> +               compatible = "socionext,milbeaut-m10v-pinctrl";
> +               reg = <0x1d022000 0x1000>,
> +                     <0x1c26f000 0x1000>;
> +               reg-names = "pinctrl", "exiu";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +               clocks = <&dummy_clk>;

Please use a real clock or make clocks optional.

> +               interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
> +                               <0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
> +                               <0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
> +                               <0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
> +               interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
> +                               "pin-52", "pin-53", "pin-54", "pin-55",
> +                               "pin-56", "pin-57", "pin-58", "pin-59",
> +                               "pin-60", "pin-61", "pin-62", "pin-63";
> +
> +               usio1_pins: usio1_pins {
> +                       pins = "PE4", "PE5", "P87";
> +                       function = "usio1";
> +               };
> +       };
> +
> +       usio1: usio_uart@1e700010 { /* PE4, PE5 */

serial@...

> +               /* Enable this as ttyUSI0 */
> +               index = <0>;

Drop this. aliases node is the right way to do this.

> +               compatible = "socionext,milbeaut-m10v-usio-uart";
> +               reg = <0x1e700010 0x10>;
> +               interrupts = <0 141 0x4>, <0 149 0x4>;
> +               interrupt-names = "rx", "tx";
> +               clocks = <&hclk>;
> +       };
> +};
> --
> 1.9.1
>
