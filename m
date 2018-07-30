Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57378FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE70F20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70F20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeG3Kvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:51:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45451 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeG3Kvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:51:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so2104532wrv.12;
        Mon, 30 Jul 2018 02:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i9H3ShOvaDIgo3A99Qr04YiLcx8I21okTsLBNRkGo8k=;
        b=asSBjLHsSYEDJJJ/fa+c87v7w8SBPZl9p0N3UqY0NCRJ4F1VB+uDDWc1B0VXUxvu7u
         h8EFXJ/UyJ8uTGxM/nkMxpiQTfD3UNEymNLzo5z8vAzF+DQ3RUOfHHM5jHqHon5Ngw+h
         hlt0d6bSS3ek+lmZVurgEVm675eE/BSa26e2YZMekKptDJ1CtHaxiF6vnaKFPTijLsDt
         qpRaHCO+DzpML/BvlEVb5+q5X/nfkpImNSteyXsc7Xo7O54fYemPUCj3S0DtADUV8Qm4
         GggMvVl+Rs1JxkC2OCXMpOTotlmxHy9jG6OeGGRDPlWUATVQ12sy2mfzjOiOXhTUsw4k
         ZDOQ==
X-Gm-Message-State: AOUpUlEsMdbDKaIf670yeRE2x0G9nB9zghjbCvsgmGc/2LSm/5CFYCPi
        OPXHr/8/s1zEW7eziJJtYRBBvA8lq+s=
X-Google-Smtp-Source: AAOMgpdxBeA0esiW1YIgTXC8o/w3UehCifPs0+kZ9iagYnCMunnnKFssCj7H8mE0Q65E9m8bar20UQ==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr16797855wrb.81.1532942255007;
        Mon, 30 Jul 2018 02:17:35 -0700 (PDT)
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com. [74.125.82.53])
        by smtp.gmail.com with ESMTPSA id l15-v6sm10139307wrt.67.2018.07.30.02.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 02:17:34 -0700 (PDT)
Received: by mail-wm0-f53.google.com with SMTP id f21-v6so12300718wmc.5;
        Mon, 30 Jul 2018 02:17:34 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr14665301wma.143.1532942254179;
 Mon, 30 Jul 2018 02:17:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 02:17:13
 -0700 (PDT)
In-Reply-To: <20180730090048.gl7fkduztjkxacqq@flea>
References: <20180728182615.20845-1-jagan@amarulasolutions.com> <20180730090048.gl7fkduztjkxacqq@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 30 Jul 2018 17:17:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
Message-ID: <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
Subject: Re: [PATCH] arm64: allwinner: h6: Add OrangePi One Plus initial support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
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

On Mon, Jul 30, 2018 at 5:00 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> Hi,
>
> On Sat, Jul 28, 2018 at 11:56:15PM +0530, Jagan Teki wrote:
>> OrangePi One Plus is Allwinner H6 based open-source SBC,
>> which support:
>> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
>> - GPU Mali-T720
>> - 1GB LPDDR3 RAM
>> - AXP805 PMIC
>> - 1Gbps GMAC via RTL8211
>> - USB 2.0 Host, OTG
>> - HDMI port
>> - 5V/2A DC power supply
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>  .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
>>  2 files changed, 151 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index 9ffa7a038791..c38f326e7fec 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>> new file mode 100644
>> index 000000000000..0612c19cd994
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2018 Amarula Solutions
>> + * Author: Jagan Teki <jagan@amarulasolutions.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h6.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     model = "OrangePi One Plus";
>> +     compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +};
>> +
>> +&mmc0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc0_pins>;
>> +     vmmc-supply = <&reg_cldo1>;
>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>> +     bus-width = <4>;
>> +     status = "okay";
>> +};
>> +
>> +&r_i2c {
>> +     status = "okay";
>> +
>> +     axp805: pmic@36 {
>> +             compatible = "x-powers,axp805", "x-powers,axp806";
>> +             reg = <0x36>;
>> +             interrupt-parent = <&r_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <1>;
>> +             x-powers,self-working-mode;
>> +
>> +             regulators {
>> +                     reg_aldo1: aldo1 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc-pl";
>> +                     };
>> +
>> +                     reg_aldo2: aldo2 {
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc-ac200";
>> +                     };
>> +
>> +                     reg_aldo3: aldo3 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc25-dram";
>> +                     };
>> +
>> +                     reg_bldo1: bldo1 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc-bias-pll";
>> +                     };
>> +
>> +                     reg_bldo2: bldo2 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc-efuse-pcie-hdmi-io";
>> +                     };
>> +
>> +                     reg_bldo3: bldo3 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc-dcxoio";
>> +                     };
>> +
>> +                     bldo4 {
>> +                             /* unused */
>> +                     };
>> +
>> +                     reg_cldo1: cldo1 {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc-3v3";
>> +                     };
>> +
>> +                     reg_cldo2: cldo2 {
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc-wifi-1";
>> +                     };
>> +
>> +                     reg_cldo3: cldo3 {
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc-wifi-2";
>> +                     };
>> +
>> +                     reg_dcdca: dcdca {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <810000>;
>> +                             regulator-max-microvolt = <1080000>;
>> +                             regulator-name = "vdd-cpu";
>> +                     };
>> +
>> +                     reg_dcdcc: dcdcc {
>> +                             regulator-min-microvolt = <810000>;
>> +                             regulator-max-microvolt = <1080000>;
>> +                             regulator-name = "vdd-gpu";
>> +                     };
>> +
>> +                     reg_dcdcd: dcdcd {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <960000>;
>> +                             regulator-max-microvolt = <960000>;
>> +                             regulator-name = "vdd-sys";
>> +                     };
>> +
>> +                     reg_dcdce: dcdce {
>> +                             regulator-always-on;
>> +                             regulator-min-microvolt = <1200000>;
>> +                             regulator-max-microvolt = <1200000>;
>> +                             regulator-name = "vcc-dram";
>> +                     };
>> +
>> +                     sw {
>> +                             /* unused */
>> +                     };
>
> Can't we have a DTSI for this PMIC too?

Back when we started adding the regulators, Mark wasn't too happy with
all the placeholders we put in the dtsi. I think we got away with it
because we had other things in there as well. That's not true for this
particular PMIC.

ChenYu

> It looks good otherwise, thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
