Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7408C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7608E2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7608E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeIDTgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:36:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42026 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:36:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id l5so3538773edw.9;
        Tue, 04 Sep 2018 08:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5B6inshpXhdDnhT7XOIr2+uU0jzgCeVxUNISHbQ3Lo=;
        b=ZJq/CujbsP6nWcNijrAtFtglA9BSyUg+FZYTnxcyCmwaAhGHvc26xr94cc/lNXGAeh
         037NTrAYWUNxtEaxVeVREb91aHvKqW5h6u6lQlUPIZopZ1S0NTfC6VCUZZK87V/YjIuQ
         O3gt5HTkSgJyEMVKdXsXn7L/H2S+UpxEp0i8w+XO3vAuyujZ6qyjbesIgu2lvgmULiPO
         NQ7NyLjYlRookXx/Q3fG/S64rn0LL30m1SaQXOVafrkhegbU7L2ulQhLo3+xgYZxtDeS
         8Xequ3uxbAS4VqWEMhH5gnyCNMi91xwGEELtr/9s4U7aKGEjcdWq2jWbes46AhDIsQ+A
         OpMw==
X-Gm-Message-State: APzg51DOklR4tzaoXkM/TpK+U85pwKOHObsnOksUqULT9qT+XQX4JNyO
        t3jONq6Odo6P6R2EdrE45fm16UXnd54=
X-Google-Smtp-Source: ANB0VdYffQ7QH9TjHWWf8B5rrWP8bFYFxO4NRewpO3oCnqZtD70ESyxi//56U/0yI74G2ivuduq8Cw==
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr37841770edk.12.1536073849800;
        Tue, 04 Sep 2018 08:10:49 -0700 (PDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id d3-v6sm9210347edi.80.2018.09.04.08.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:10:49 -0700 (PDT)
Received: by mail-wm0-f46.google.com with SMTP id o18-v6so4680194wmc.0;
        Tue, 04 Sep 2018 08:10:49 -0700 (PDT)
X-Received: by 2002:a1c:114:: with SMTP id 20-v6mr2827401wmb.4.1536073848838;
 Tue, 04 Sep 2018 08:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180728182615.20845-1-jagan@amarulasolutions.com>
 <20180730090048.gl7fkduztjkxacqq@flea> <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
 <CAMty3ZBNM7mdtkBSq5BGuGoa5jKdSuuSVxkOoqPhDJZ-NM2THQ@mail.gmail.com>
 <CAGb2v66Br9-KB-AD+N9mqRQ7rhrzYqUAQDkiepf2+3=FOgWKLg@mail.gmail.com>
 <CAGb2v670WNu8tz+e0DqO5eiSvi8EEfhCrz3ksaAzvyxQvCGkgQ@mail.gmail.com> <3f31bff7-689a-3cf6-8e55-cfd98a19ad50@openedev.com>
In-Reply-To: <3f31bff7-689a-3cf6-8e55-cfd98a19ad50@openedev.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 4 Sep 2018 23:10:37 +0800
X-Gmail-Original-Message-ID: <CAGb2v66zT++sakwB5WEmhXJad3CH9Fr4P06TRnM7g_etqsvRug@mail.gmail.com>
Message-ID: <CAGb2v66zT++sakwB5WEmhXJad3CH9Fr4P06TRnM7g_etqsvRug@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] arm64: allwinner: h6: Add OrangePi One
 Plus initial support
To:     Jagan Teki <jagan@openedev.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 10:31 PM Jagan Teki <jagan@openedev.com> wrote:
>
> On Monday 03 September 2018 11:05 AM, Chen-Yu Tsai wrote:
> > On Tue, Jul 31, 2018 at 9:42 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >>
> >> On Tue, Jul 31, 2018 at 9:41 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >>> On Mon, Jul 30, 2018 at 2:47 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> >>>> On Mon, Jul 30, 2018 at 5:00 PM, Maxime Ripard
> >>>> <maxime.ripard@bootlin.com> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Sat, Jul 28, 2018 at 11:56:15PM +0530, Jagan Teki wrote:
> >>>>>> OrangePi One Plus is Allwinner H6 based open-source SBC,
> >>>>>> which support:
> >>>>>> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> >>>>>> - GPU Mali-T720
> >>>>>> - 1GB LPDDR3 RAM
> >>>>>> - AXP805 PMIC
> >>>>>> - 1Gbps GMAC via RTL8211
> >>>>>> - USB 2.0 Host, OTG
> >>>>>> - HDMI port
> >>>>>> - 5V/2A DC power supply
> >>>>>>
> >>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >>>>>> ---
> >>>>>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>>>>>   .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
> >>>>>>   2 files changed, 151 insertions(+)
> >>>>>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> >>>>>> index 9ffa7a038791..c38f326e7fec 100644
> >>>>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >>>>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >>>>>> @@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
> >>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
> >>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
> >>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
> >>>>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
> >>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
> >>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..0612c19cd994
> >>>>>> --- /dev/null
> >>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
> >>>>>> @@ -0,0 +1,150 @@
> >>>>>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> >>>>>> +/*
> >>>>>> + * Copyright (C) 2018 Amarula Solutions
> >>>>>> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> >>>>>> + */
> >>>>>> +
> >>>>>> +/dts-v1/;
> >>>>>> +
> >>>>>> +#include "sun50i-h6.dtsi"
> >>>>>> +
> >>>>>> +#include <dt-bindings/gpio/gpio.h>
> >>>>>> +
> >>>>>> +/ {
> >>>>>> +     model = "OrangePi One Plus";
> >>>>>> +     compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
> >>>>>> +
> >>>>>> +     aliases {
> >>>>>> +             serial0 = &uart0;
> >>>>>> +     };
> >>>>>> +
> >>>>>> +     chosen {
> >>>>>> +             stdout-path = "serial0:115200n8";
> >>>>>> +     };
> >>>>>> +};
> >>>>>> +
> >>>>>> +&mmc0 {
> >>>>>> +     pinctrl-names = "default";
> >>>>>> +     pinctrl-0 = <&mmc0_pins>;
> >>>>>> +     vmmc-supply = <&reg_cldo1>;
> >>>>>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
> >>>>>> +     bus-width = <4>;
> >>>>>> +     status = "okay";
> >>>>>> +};
> >>>>>> +
> >>>>>> +&r_i2c {
> >>>>>> +     status = "okay";
> >>>>>> +
> >>>>>> +     axp805: pmic@36 {
> >>>>>> +             compatible = "x-powers,axp805", "x-powers,axp806";
> >>>>>> +             reg = <0x36>;
> >>>>>> +             interrupt-parent = <&r_intc>;
> >>>>>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> >>>>>> +             interrupt-controller;
> >>>>>> +             #interrupt-cells = <1>;
> >>>>>> +             x-powers,self-working-mode;
> >>>>>> +
> >>>>>> +             regulators {
> >>>>>> +                     reg_aldo1: aldo1 {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <3300000>;
> >>>>>> +                             regulator-max-microvolt = <3300000>;
> >>>>>> +                             regulator-name = "vcc-pl";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_aldo2: aldo2 {
> >>>>>> +                             regulator-min-microvolt = <3300000>;
> >>>>>> +                             regulator-max-microvolt = <3300000>;
> >>>>>> +                             regulator-name = "vcc-ac200";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_aldo3: aldo3 {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <3300000>;
> >>>>>> +                             regulator-max-microvolt = <3300000>;
> >>>>>> +                             regulator-name = "vcc25-dram";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_bldo1: bldo1 {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <1800000>;
> >>>>>> +                             regulator-max-microvolt = <1800000>;
> >>>>>> +                             regulator-name = "vcc-bias-pll";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_bldo2: bldo2 {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <1800000>;
> >>>>>> +                             regulator-max-microvolt = <1800000>;
> >>>>>> +                             regulator-name = "vcc-efuse-pcie-hdmi-io";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_bldo3: bldo3 {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <1800000>;
> >>>>>> +                             regulator-max-microvolt = <1800000>;
> >>>>>> +                             regulator-name = "vcc-dcxoio";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     bldo4 {
> >>>>>> +                             /* unused */
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_cldo1: cldo1 {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <3300000>;
> >>>>>> +                             regulator-max-microvolt = <3300000>;
> >>>>>> +                             regulator-name = "vcc-3v3";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_cldo2: cldo2 {
> >>>>>> +                             regulator-min-microvolt = <3300000>;
> >>>>>> +                             regulator-max-microvolt = <3300000>;
> >>>>>> +                             regulator-name = "vcc-wifi-1";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_cldo3: cldo3 {
> >>>>>> +                             regulator-min-microvolt = <3300000>;
> >>>>>> +                             regulator-max-microvolt = <3300000>;
> >>>>>> +                             regulator-name = "vcc-wifi-2";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_dcdca: dcdca {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <810000>;
> >>>>>> +                             regulator-max-microvolt = <1080000>;
> >>>>>> +                             regulator-name = "vdd-cpu";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_dcdcc: dcdcc {
> >>>>>> +                             regulator-min-microvolt = <810000>;
> >>>>>> +                             regulator-max-microvolt = <1080000>;
> >>>>>> +                             regulator-name = "vdd-gpu";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_dcdcd: dcdcd {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <960000>;
> >>>>>> +                             regulator-max-microvolt = <960000>;
> >>>>>> +                             regulator-name = "vdd-sys";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     reg_dcdce: dcdce {
> >>>>>> +                             regulator-always-on;
> >>>>>> +                             regulator-min-microvolt = <1200000>;
> >>>>>> +                             regulator-max-microvolt = <1200000>;
> >>>>>> +                             regulator-name = "vcc-dram";
> >>>>>> +                     };
> >>>>>> +
> >>>>>> +                     sw {
> >>>>>> +                             /* unused */
> >>>>>> +                     };
> >>>>>
> >>>>> Can't we have a DTSI for this PMIC too?
> >>>>
> >>>> Back when we started adding the regulators, Mark wasn't too happy with
> >>>> all the placeholders we put in the dtsi. I think we got away with it
> >>>> because we had other things in there as well. That's not true for this
> >>>> particular PMIC.
> >>>
> >>> So we need separate dtsi for this PMIC as well?
> >>
> >> I don't think we do. We don't gain much.
> >
> > Merged with Maxime's ack, and the subject prefix fixed.
> > Also squashed in the Ethernet patch for this board.
>
> H6 EMAC node changes still in ML.

Oops. Dropped that part. Sorry about that.

ChenYu
