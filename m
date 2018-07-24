Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DD0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8866F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr5xoPVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8866F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbeGXK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:59:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44430 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGXK7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:59:32 -0400
Received: by mail-qk0-f196.google.com with SMTP id v17-v6so2202231qkb.11;
        Tue, 24 Jul 2018 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7C09KQTCccaSsvLC2hqGEapaku6BAwwCsNJmPous7s=;
        b=Wr5xoPVep2cMqlElp4JmSIvZ0wZYyQSxLxwdeFL8/L0eISbBta7IXmj+sDg7UruKwU
         qm+7wfNNWzm6Ykj5de5oKMUBXcF2gJX+HP0NtMb+b0HrO2IbdGgu1IGp6hG/EXqT00Ub
         HpKm9tG3VC1y3t6NkjsZINhfjGx0zMq+nBPYk7Y3smVlbdmRJiwtgdv0HS0XdeqNnyZ7
         95fEXdf5ptaoztIGQqxh9V4803SH08D1mSUx4TS+GZ28vqdwe49vdCfXkx2a12i1M6s/
         7twh9S0fRTUm/icmeA4zoweMwXD6Y4DTuWuNu/TnTacZWu0EWuMYnsFPkQlrlstts/cb
         sLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7C09KQTCccaSsvLC2hqGEapaku6BAwwCsNJmPous7s=;
        b=kfq2KN6v6Iq3lAt0y87oZEumpjpS2SpRRPxJywyslo2N0RwQrrgGt18e/zdZh1mH5y
         kcsxIpd1SelEZXcS4dq0B7e+cas2nyNIkwHHkdFpMlKLqQGV6isTwUVAwFYfrWe5n+K5
         adyX4LK+NBkEPEZs3h50zkUuoRuAYciNj4j2kluLQsWre+iNjXSVX0szULjO7HiwyNit
         OrRMt0E0U65qMzSr0+8Hpa7HOPBe6uI81sgmSVyI1X7dvPpg8F5d5CxKpOg8mPwdd900
         AsLCX/6l2xGfNkKre7vNz86yq0ZI6pIo8iayvvx4KF4PDjmx+H2XComAN1Iy/2wFLYcu
         Ff9g==
X-Gm-Message-State: AOUpUlG4ODZA0d/dDynT7A4igI+DSwvS3bDV1J//CjKG0SngS2+dC8th
        8KxXXynBw9pvX3X2KliEmou7GZvRC8b3ZGWZuyY=
X-Google-Smtp-Source: AAOMgpfW/dSAh+1NDZQZXpubk1rtMHv26oyVQlv5pltoeYsZofHDcKKXJJQmpi5IXIJ8fghiq5Wyd3SDKiH7x/BUhFg=
X-Received: by 2002:a37:7004:: with SMTP id l4-v6mr13987870qkc.83.1532426031958;
 Tue, 24 Jul 2018 02:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <1532161826-2537-1-git-send-email-djw@t-chip.com.cn> <139327780.KNaNigg5Hs@phil>
In-Reply-To: <139327780.KNaNigg5Hs@phil>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 24 Jul 2018 11:53:40 +0200
Message-ID: <CAFqH_52baP9yt35yfAdU5wk8DiK67_etPALsmb5K1JPmnW_kqQ@mail.gmail.com>
Subject: Re: [PATCH v0] arm64: dts: rockchip: add support for ROC-RK3399-PC board
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     djw@t-chip.com.cn, Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        zxf@t-chip.com.cn, Masahiro Yamada <yamada.masahiro@socionext.com>,
        ezequiel@collabora.com, xypron.glpk@gmx.de,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        jacob-chen@iotwrt.com, klaus.goger@theobroma-systems.com,
        jagan@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        jay.xu@rock-chips.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Missatge de Heiko Stuebner <heiko@sntech.de> del dia dt., 24 de jul.
2018 a les 11:29:
>
> Hi Levin,
>
> Am Samstag, 21. Juli 2018, 10:30:26 CEST schrieb djw@t-chip.com.cn:
> > From: Levin Du <djw@t-chip.com.cn>
> >
> > ROC-RK3399-PC is the first power efficient 4GB DDR4 single board
>
> maybe "is a power efficient" instead of "the first" ;-)
>
> [...]
>
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> > new file mode 100644
> > index 0000000..207f2e3
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> > @@ -0,0 +1,717 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include "rk3399.dtsi"
> > +#include "rk3399-opp.dtsi"
> > +
> > +/ {
> > +     model = "Firefly ROC-RK3399-PC Board";
> > +     compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> > +
> > +     chosen {
> > +             bootargs = "earlycon=uart8250,mmio32,0xff1a0000 swiotlb=1";
>
> I don't think we want to hard-code linux bootargs in the generic devicetree
>
> > +             stdout-path = "serial2:1500000n8";
> > +     };
> > +
> > +     backlight: backlight {
> > +             compatible = "pwm-backlight";
> > +             enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> > +             pwms = <&pwm0 0 25000 0>;
> > +             brightness-levels = <
> > +                       0   1   2   3   4   5   6   7
>
> As Rob noted in the px30 evb patch, there is now a property helping
> to drop these long lists of brightness levels, see
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=1e5e7cc794b5a332c23216dade0a2e937d694b7f

Adding to the Heiko information. Did you try to just remove brightness-levels?
Without this property, the driver computes a default table with the
brightness levels filled with the numbers provided by the CIE 1931
algorithm. That algorithm is used to dim a led for human perception.

Note that the patches needed did not land yet, are in linux-next, and
you will also be interested in apply this patch [1].

[1] https://lkml.org/lkml/2018/7/24/116

>
>
> > +                       8   9  10  11  12  13  14  15
> > +                      16  17  18  19  20  21  22  23
> > +                      24  25  26  27  28  29  30  31
> > +                      32  33  34  35  36  37  38  39
> > +                      40  41  42  43  44  45  46  47
> > +                      48  49  50  51  52  53  54  55
> > +                      56  57  58  59  60  61  62  63
> > +                      64  65  66  67  68  69  70  71
> > +                      72  73  74  75  76  77  78  79
> > +                      80  81  82  83  84  85  86  87
> > +                      88  89  90  91  92  93  94  95
> > +                      96  97  98  99 100 101 102 103
> > +                     104 105 106 107 108 109 110 111
> > +                     112 113 114 115 116 117 118 119
> > +                     120 121 122 123 124 125 126 127
> > +                     128 129 130 131 132 133 134 135
> > +                     136 137 138 139 140 141 142 143
> > +                     144 145 146 147 148 149 150 151
> > +                     152 153 154 155 156 157 158 159
> > +                     160 161 162 163 164 165 166 167
> > +                     168 169 170 171 172 173 174 175
> > +                     176 177 178 179 180 181 182 183
> > +                     184 185 186 187 188 189 190 191
> > +                     192 193 194 195 196 197 198 199
> > +                     200 201 202 203 204 205 206 207
> > +                     208 209 210 211 212 213 214 215
> > +                     216 217 218 219 220 221 222 223
> > +                     224 225 226 227 228 229 230 231
> > +                     232 233 234 235 236 237 238 239
> > +                     240 241 242 243 244 245 246 247
> > +                     248 249 250 251 252 253 254 255>;
> > +             default-brightness-level = <200>;
> > +     };
>
> [...]
>
> > +     vcc_vbus_typec0: vcc-vbus-typec0 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc_vbus_typec0";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +     };
> > +
> > +     vcc12v_sys: mp8859-dcdc1 {
>
> The mp8859 seems to be an i2c-device, as also shown by the
> nearly empty mp8859 entry below, so shouldn't this regulator
> be defined there?
>
>
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "vcc12v_sys";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             regulator-min-microvolt = <12000000>;
> > +             regulator-max-microvolt = <12000000>;
> > +             vin-supply = <&vcc_vbus_typec0>;
> > +     };
>
> [...]
>
> > +     vcc_hub_en: vcc_hub_en-regulator {
> > +             compatible = "regulator-fixed";
> > +             enable-active-high;
> > +             gpio = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&hub_rst>;
> > +             regulator-name = "vcc_hub_en";
> > +             regulator-always-on;
>
> missing vin-supply
>
> > +     };
> > +
>
> [...]
>
> > +     vdd_cpu_b: regulator@40 {
> > +             compatible = "silergy,syr827";
> > +             reg = <0x40>;
> > +             fcs,suspend-voltage-selector = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&vsel1_gpio>;
> > +             regulator-name = "vdd_cpu_b";
> > +             regulator-min-microvolt = <712500>;
> > +             regulator-max-microvolt = <1500000>;
> > +             regulator-ramp-delay = <1000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             vsel-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
>
> vsel-gpios is not defined in the mainline dt-binding of the fan5355/syr82*
>
> > +             vin-supply = <&vcc3v3_sys>;
> > +
> > +             regulator-state-mem {
> > +                     regulator-off-in-suspend;
> > +             };
> > +     };
> > +
> > +     vdd_gpu: regulator@41 {
> > +             compatible = "silergy,syr828";
> > +             reg = <0x41>;
> > +             fcs,suspend-voltage-selector = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&vsel2_gpio>;
> > +             regulator-name = "vdd_gpu";
> > +             regulator-min-microvolt = <712500>;
> > +             regulator-max-microvolt = <1500000>;
> > +             regulator-ramp-delay = <1000>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +             vsel-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
>
> same as above
>
> > +             vin-supply = <&vcc3v3_sys>;
> > +
> > +             regulator-state-mem {
> > +                     regulator-off-in-suspend;
> > +             };
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     i2c-scl-rising-time-ns = <300>;
> > +     i2c-scl-falling-time-ns = <15>;
> > +     status = "okay";
> > +};
> > +
> > +&i2c3 {
> > +     i2c-scl-rising-time-ns = <450>;
> > +     i2c-scl-falling-time-ns = <15>;
> > +     status = "okay";
> > +};
> > +
> > +&i2c4 {
> > +     i2c-scl-rising-time-ns = <600>;
> > +     i2c-scl-falling-time-ns = <20>;
> > +     status = "okay";
> > +
> > +     mp8859: mp8859@66 {
> > +             compatible = "mps,mp8859";
>
> missing a dt-binding and also a real regulator implementation?
>
> > +             reg = <0x66>;
> > +     };
> > +
> > +     fusb1: usb-typec@22 {
> > +             compatible = "fcs,fusb302";
> > +             reg = <0x22>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&fusb1_int>;
> > +             fcs,int-n = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
>
> mainline binding expects an "interrupts" property not the
> fcs,int-n from above
>
> > +             status = "okay";
> > +     };
> > +
> > +};
> > +
> > +&i2c7 {
> > +     i2c-scl-rising-time-ns = <600>;
> > +     i2c-scl-falling-time-ns = <20>;
> > +     status = "okay";
> > +
> > +     fusb0: usb-typec@22 {
> > +             compatible = "fcs,fusb302";
> > +             reg = <0x22>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&fusb0_int>;
> > +             fcs,int-n = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
>
> same as above
>
> > +             status = "okay";
> > +     };
> > +};
> > +
> > +&i2s0 {
> > +     rockchip,playback-channels = <8>;
> > +     rockchip,capture-channels = <8>;
> > +     #sound-dai-cells = <0>;
>
> sound-dai-cells are in rk3399.dtsi now ... see
> https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?id=4486baca66e7a96a6ded3957cb522872a49870ce
>
> > +     status = "okay";
> > +};
> > +
> > +&i2s1 {
> > +     rockchip,playback-channels = <2>;
> > +     rockchip,capture-channels = <2>;
> > +     #sound-dai-cells = <0>;
>
> same as above
>
> > +     status = "okay";
> > +};
> > +
> > +&i2s2 {
> > +     #sound-dai-cells = <0>;
>
> same as above
>
> > +     status = "okay";
> > +};
> > +
>
> > +&tcphy0 {
> > +     extcon = <&fusb0>;
>
> the extcon is not described in the mainline fusb302 binding.
>
> > +     status = "okay";
> > +};
> > +
> > +&tcphy1 {
> > +     extcon = <&fusb1>;
>
> same as above
>
> > +     status = "okay";
> > +};
> > +
> > +&tsadc {
> > +     /* tshut mode 0:CRU 1:GPIO */
> > +     rockchip,hw-tshut-mode = <1>;
> > +     /* tshut polarity 0:LOW 1:HIGH */
> > +     rockchip,hw-tshut-polarity = <1>;
> > +     status = "okay";
> > +};
> > +
> > +&u2phy0 {
> > +     status = "okay";
> > +
> > +     u2phy0_otg: otg-port {
> > +             phy-supply = <&vcc5v0_host>;
> > +             //status = "disabled";
>
> don't leave commented stuff in the dt please.
>
> > +             status = "okay";
> > +     };
> > +
> > +     u2phy0_host: host-port {
> > +             phy-supply = <&vcc5v0_host>;
> > +             status = "okay";
> > +     };
> > +};
> > +
> > +&u2phy1 {
> > +     status = "okay";
> > +
> > +     u2phy1_otg: otg-port {
> > +             phy-supply = <&vcc5v0_host>;
> > +             //status = "disabled";
>
> same as above
>
> > +             status = "okay";
> > +     };
> > +
> > +     u2phy1_host: host-port {
> > +             phy-supply = <&vcc5v0_host>;
> > +             status = "okay";
> > +     };
> > +};
>
>
> Thanks
> Heiko
>

Best regards,
 Enric

>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
