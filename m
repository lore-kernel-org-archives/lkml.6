Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41098C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD123208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="COcOt6vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD123208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbeGaPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:22:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52773 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732160AbeGaPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:22:14 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so4507841itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=heJwGme1lwHEqWtXyW4lW/rErWbjaOr3SjTUMuqs3X4=;
        b=COcOt6vwVQkQRQ/wdQkflo58VSugpI0vzTmYQxJW328yfugR1a4nDunxFfYc+IgcsF
         Ew8R915JwNQ9tiIzKYbsUJji2La7YZDaeIzmLEG1PELvp2mZs6MM3B67olcPXOoQmmLR
         ZrUER/EqKdkIxbTnH8BZccL7LHwfPUytQNMdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=heJwGme1lwHEqWtXyW4lW/rErWbjaOr3SjTUMuqs3X4=;
        b=AR0jhhDs6TsaA/6vGQOJY1aRogdIa/bTt39EGBmcw2JmIpLe9FxPUSLSFqVJnmN0c1
         7ao/OYydbYOZGi4sw5QIYyGb218IRrM/caysDMnI6wFOBwOf9fTplFKUKSzdddLDeJVP
         on3eZ6f9N4zJvBH2Ya8INO7v51AW6+Cqv7fYYWkpRQChbVCNQGECMQzalkOM5EapRw8l
         iaScX+iyjAwz9PVBxrY4fPAVmc2+AdQnHY1H0ViavYqtP7JDB2pEheIc8MI2DJvE5PTv
         hzyaJNzaj5Dhkl04B766C9CztLei8MHe8jyAybTypPeBINf9t+xOuRY5mnaAXl07oMH/
         Nxlg==
X-Gm-Message-State: AOUpUlEolDYY8e1jiVendkTXXmPZGTDzQi/EGRVxTMzGAxygXqcJlnIZ
        A7IgC1D932T30TeHCT1YK7dlEdZNoUIX1IAPcHtNug==
X-Google-Smtp-Source: AAOMgpf+cDFewObEsqSYAIf8XBAEMSGIHBKg536R84I8mTUi1Xd9Et3qPjVM+lzvgs9U+LWH3DcleDTNLalsDzBQFQI=
X-Received: by 2002:a24:7503:: with SMTP id y3-v6mr2995318itc.70.1533044510526;
 Tue, 31 Jul 2018 06:41:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 06:41:49
 -0700 (PDT)
In-Reply-To: <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
References: <20180728182615.20845-1-jagan@amarulasolutions.com>
 <20180730090048.gl7fkduztjkxacqq@flea> <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 31 Jul 2018 19:11:49 +0530
Message-ID: <CAMty3ZBNM7mdtkBSq5BGuGoa5jKdSuuSVxkOoqPhDJZ-NM2THQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: allwinner: h6: Add OrangePi One Plus initial support
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
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

On Mon, Jul 30, 2018 at 2:47 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Mon, Jul 30, 2018 at 5:00 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
>> Hi,
>>
>> On Sat, Jul 28, 2018 at 11:56:15PM +0530, Jagan Teki wrote:
>>> OrangePi One Plus is Allwinner H6 based open-source SBC,
>>> which support:
>>> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
>>> - GPU Mali-T720
>>> - 1GB LPDDR3 RAM
>>> - AXP805 PMIC
>>> - 1Gbps GMAC via RTL8211
>>> - USB 2.0 Host, OTG
>>> - HDMI port
>>> - 5V/2A DC power supply
>>>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>>  .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
>>>  2 files changed, 151 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>> index 9ffa7a038791..c38f326e7fec 100644
>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>> @@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>> new file mode 100644
>>> index 000000000000..0612c19cd994
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>> @@ -0,0 +1,150 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>> +/*
>>> + * Copyright (C) 2018 Amarula Solutions
>>> + * Author: Jagan Teki <jagan@amarulasolutions.com>
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sun50i-h6.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +
>>> +/ {
>>> +     model = "OrangePi One Plus";
>>> +     compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
>>> +
>>> +     aliases {
>>> +             serial0 = &uart0;
>>> +     };
>>> +
>>> +     chosen {
>>> +             stdout-path = "serial0:115200n8";
>>> +     };
>>> +};
>>> +
>>> +&mmc0 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&mmc0_pins>;
>>> +     vmmc-supply = <&reg_cldo1>;
>>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>>> +     bus-width = <4>;
>>> +     status = "okay";
>>> +};
>>> +
>>> +&r_i2c {
>>> +     status = "okay";
>>> +
>>> +     axp805: pmic@36 {
>>> +             compatible = "x-powers,axp805", "x-powers,axp806";
>>> +             reg = <0x36>;
>>> +             interrupt-parent = <&r_intc>;
>>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>> +             interrupt-controller;
>>> +             #interrupt-cells = <1>;
>>> +             x-powers,self-working-mode;
>>> +
>>> +             regulators {
>>> +                     reg_aldo1: aldo1 {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <3300000>;
>>> +                             regulator-max-microvolt = <3300000>;
>>> +                             regulator-name = "vcc-pl";
>>> +                     };
>>> +
>>> +                     reg_aldo2: aldo2 {
>>> +                             regulator-min-microvolt = <3300000>;
>>> +                             regulator-max-microvolt = <3300000>;
>>> +                             regulator-name = "vcc-ac200";
>>> +                     };
>>> +
>>> +                     reg_aldo3: aldo3 {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <3300000>;
>>> +                             regulator-max-microvolt = <3300000>;
>>> +                             regulator-name = "vcc25-dram";
>>> +                     };
>>> +
>>> +                     reg_bldo1: bldo1 {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <1800000>;
>>> +                             regulator-max-microvolt = <1800000>;
>>> +                             regulator-name = "vcc-bias-pll";
>>> +                     };
>>> +
>>> +                     reg_bldo2: bldo2 {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <1800000>;
>>> +                             regulator-max-microvolt = <1800000>;
>>> +                             regulator-name = "vcc-efuse-pcie-hdmi-io";
>>> +                     };
>>> +
>>> +                     reg_bldo3: bldo3 {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <1800000>;
>>> +                             regulator-max-microvolt = <1800000>;
>>> +                             regulator-name = "vcc-dcxoio";
>>> +                     };
>>> +
>>> +                     bldo4 {
>>> +                             /* unused */
>>> +                     };
>>> +
>>> +                     reg_cldo1: cldo1 {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <3300000>;
>>> +                             regulator-max-microvolt = <3300000>;
>>> +                             regulator-name = "vcc-3v3";
>>> +                     };
>>> +
>>> +                     reg_cldo2: cldo2 {
>>> +                             regulator-min-microvolt = <3300000>;
>>> +                             regulator-max-microvolt = <3300000>;
>>> +                             regulator-name = "vcc-wifi-1";
>>> +                     };
>>> +
>>> +                     reg_cldo3: cldo3 {
>>> +                             regulator-min-microvolt = <3300000>;
>>> +                             regulator-max-microvolt = <3300000>;
>>> +                             regulator-name = "vcc-wifi-2";
>>> +                     };
>>> +
>>> +                     reg_dcdca: dcdca {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <810000>;
>>> +                             regulator-max-microvolt = <1080000>;
>>> +                             regulator-name = "vdd-cpu";
>>> +                     };
>>> +
>>> +                     reg_dcdcc: dcdcc {
>>> +                             regulator-min-microvolt = <810000>;
>>> +                             regulator-max-microvolt = <1080000>;
>>> +                             regulator-name = "vdd-gpu";
>>> +                     };
>>> +
>>> +                     reg_dcdcd: dcdcd {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <960000>;
>>> +                             regulator-max-microvolt = <960000>;
>>> +                             regulator-name = "vdd-sys";
>>> +                     };
>>> +
>>> +                     reg_dcdce: dcdce {
>>> +                             regulator-always-on;
>>> +                             regulator-min-microvolt = <1200000>;
>>> +                             regulator-max-microvolt = <1200000>;
>>> +                             regulator-name = "vcc-dram";
>>> +                     };
>>> +
>>> +                     sw {
>>> +                             /* unused */
>>> +                     };
>>
>> Can't we have a DTSI for this PMIC too?
>
> Back when we started adding the regulators, Mark wasn't too happy with
> all the placeholders we put in the dtsi. I think we got away with it
> because we had other things in there as well. That's not true for this
> particular PMIC.

So we need separate dtsi for this PMIC as well?
