Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A330275A0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsFUBUzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A330275A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935082AbeF1PMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:12:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38973 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeF1PMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:12:14 -0400
Received: by mail-lf0-f68.google.com with SMTP id q6-v6so4484002lfh.6;
        Thu, 28 Jun 2018 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwoP7VfNufKz3AdcDP4rD7DzhJl/EoWElJvzO8qQKuw=;
        b=XsFUBUzGxmG9KAjtIQyNsuAR85yb+Ph1BW+VhToYP0EMh0ddmsQJopq4Ths/b4Fydx
         P2M5j+a7cU5ph0F2EtuCU0pBkkyThwVV9x6F6RExXktBwW5DXF7KwKd2LRKdiXeT2b2A
         YENraQQ2lYwhotLKFB00s0XzOlAY3Xsy4BzBUASjS+/zThvmVlxuhsIwnDeacHkQi1B/
         X2Jdb2L6pvFN7ORn57XVLo9cN2g187H0al3f17HIrd+g1dHCkggHu7ZroAd1o1AcRybZ
         KiTAAx7WpqY/yR5I4JC7kDQ8JK3quNGc3I99q0fe9RCl1jQVQwuRlwUESlNmlM7LHU1t
         vv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YwoP7VfNufKz3AdcDP4rD7DzhJl/EoWElJvzO8qQKuw=;
        b=uPKPCYKgMUhdA3olFkD6LOgQd4eidamVVJaoPJ9z8MxFTPZ+zyHowLV+tVmjUwxcjd
         /01uDFiJTxez7Z0U+FylXxPQQa9DuC8NRIaiDi9M/t97moHC2OHhUpSaLv/wyc11wa8N
         BcBa/Bw+b9b5Lpzvctta6noIuxnPPB/3K2Wyt6/Ep1X5vV8hFXtAUp8u+fAwsiulFOkC
         N0vGWtMafAxrS/z7xDtsNkD7Il0BbvB07+iuNtUbgpH4m3HqzWCaP+lHSukB9k/lnNbj
         5RAfyoy/0LBIl35D7VJrKb6n65YTRa6ytHYtjJnt8NJtvrnJaIemeyjP+nIuHCLtAwUY
         suBg==
X-Gm-Message-State: APt69E2hKVJYe6AnbM5Z3j3h5UV0IvwmTb6c2iFvzsxolCyskNeHky7v
        LANTk+QjoRC2oLvOgdpuP00=
X-Google-Smtp-Source: AAOMgped+A63nYS9xXQsCT5KEgfHJeFsv0u1EadY3FaAQsamrZRcMO1NjgJeLlVeIXhyAVDNLtHJwA==
X-Received: by 2002:a19:7707:: with SMTP id s7-v6mr7137005lfc.8.1530198732106;
        Thu, 28 Jun 2018 08:12:12 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.gmail.com with ESMTPSA id r77-v6sm1381732lfi.34.2018.06.28.08.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:12:11 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v2 02/10] ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
Date:   Thu, 28 Jun 2018 17:12:09 +0200
Message-ID: <2874389.2o2OQCEWau@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.13.0-45-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CAJKOXPf5MMAwEEt8xZ2mcTUCmrZiOTgGOJuuo5yHmh8UWE6ULA@mail.gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPdxdwmCcXNnYNCc81hZVi=YUs_+CNKev_gPZbXoMPPepg@mail.gmail.com> <CAJKOXPf5MMAwEEt8xZ2mcTUCmrZiOTgGOJuuo5yHmh8UWE6ULA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 28, 2018 9:48:48 AM CEST Krzysztof Kozlowski wrote:
> On 28 June 2018 at 09:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On 27 June 2018 at 19:12, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail=
=2Ecom> wrote:
> >> This DTS file have initial support Samsung Aries based phones.
> >> Initial version have support for:
> >> - sdcard
> >> - internal memory (present only on non 4g variant)
> >> - max8998 pmic and rtc
> >> - max17040 fuel gauge
> >> - gpio keys
> >> - fimd (no panel driver yet)
> >> - usb (peripherial mode)
> >> - wifi
> >>
> >> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> >> ---
> >>
> >> Changes from v1:
> >>   - Removed duplicated and unneeded headers
> >>   - Corrected node names
> >>   - Added missing spaces
> >>   - Removed unneeded pinctrl and sorted entries
> >>   - Set correct interrupt type for max8998 pmic
> >>   - Add missing regulators
> >> ---
> >> ---
> >>  arch/arm/boot/dts/s5pv210-aries.dtsi | 423 ++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 423 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
> >>
> >> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/=
s5pv210-aries.dtsi
> >> new file mode 100644
> >> index 000000000000..61b6cf76265f
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> >> @@ -0,0 +1,423 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Samsung's S5PV210 based Galaxy Aries board device tree source
> >> + */
> >> +
> >> +/dts-v1/;
> >> +#include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/interrupt-controller/irq.h>
> >> +#include "s5pv210.dtsi"
> >> +
> >> +/ {
> >> +       compatible =3D "samsung,aries", "samsung,s5pv210";
> >> +
> >> +       aliases {
> >> +               i2c6 =3D &i2c_pmic;
> >> +               i2c9 =3D &i2c_fuel;
> >> +       };
> >> +
> >> +       memory@30000000 {
> >> +               device_type =3D "memory";
> >> +               reg =3D <0x30000000 0x05000000
> >> +                       0x40000000 0x10000000
> >> +                       0x50000000 0x08000000>;
> >> +       };
> >> +
> >> +       wifi_pwrseq: wifi-pwrseq {
> >> +               compatible =3D "mmc-pwrseq-simple";
> >> +               reset-gpios =3D <&gpg1 2 GPIO_ACTIVE_LOW>;
> >> +               pinctrl-names =3D "default";
> >> +               pinctrl-0 =3D <&wlan_gpio_rst>;
> >> +               post-power-on-delay-ms =3D <500>;
> >> +               power-off-delay-us =3D <500>;
> >> +       };
> >> +
> >> +       i2c_pmic: i2c-gpio-0 {
> >> +               compatible =3D "i2c-gpio";
> >> +               sda-gpios =3D <&gpj4 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_D=
RAIN)>;
> >> +               scl-gpios =3D <&gpj4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_D=
RAIN)>;
> >> +               i2c-gpio,delay-us =3D <2>;
> >> +               #address-cells =3D <1>;
> >> +               #size-cells =3D <0>;
> >> +
> >> +               pmic@66 {
> >> +                       compatible =3D "maxim,max8998";
> >> +                       reg =3D <0x66>;
> >> +                       interrupt-parent =3D <&gph0>;
> >> +                       interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> >> +
> >> +                       max8998,pmic-buck1-default-dvs-idx =3D <1>;
> >> +                       max8998,pmic-buck1-dvs-gpios =3D <&gph0 3 GPIO=
_ACTIVE_HIGH>,
> >> +                                                       <&gph0 4 GPIO_=
ACTIVE_HIGH>;
> >> +                       max8998,pmic-buck1-dvs-voltage =3D <1275000>, =
<1200000>,
> >> +                                                       <1050000>, <95=
0000>;
> >> +
> >> +                       max8998,pmic-buck2-default-dvs-idx =3D <0>;
> >> +                       max8998,pmic-buck2-dvs-gpio =3D <&gph0 5 GPIO_=
ACTIVE_HIGH>;
> >> +                       max8998,pmic-buck2-dvs-voltage =3D <1100000>, =
<1000000>;
> >> +
> >> +                       regulators {
> >> +                               ldo2_reg: LDO2 {
> >> +                                       regulator-name =3D "VALIVE_1.2=
V";
> >> +                                       regulator-min-microvolt =3D <1=
200000>;
> >> +                                       regulator-max-microvolt =3D <1=
200000>;
> >> +                                       regulator-always-on;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-on-in-suspen=
d;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo3_reg: LDO3 {
> >> +                                       regulator-name =3D "VUSB_1.1V";
> >> +                                       regulator-min-microvolt =3D <1=
100000>;
> >> +                                       regulator-max-microvolt =3D <1=
100000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo4_reg: LDO4 {
> >> +                                       regulator-name =3D "VADC_3.3V";
> >> +                                       regulator-min-microvolt =3D <3=
300000>;
> >> +                                       regulator-max-microvolt =3D <3=
300000>;
> >> +                                       regulator-always-on;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo5_reg: LDO5 {
> >> +                                       regulator-name =3D "VTF_2.8V";
> >> +                                       regulator-min-microvolt =3D <2=
800000>;
> >> +                                       regulator-max-microvolt =3D <2=
800000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo6_reg: LDO6 {
> >> +                                       regulator-name =3D "LDO6";
> >> +                                       regulator-min-microvolt =3D <1=
600000>;
> >> +                                       regulator-max-microvolt =3D <3=
600000>;
> >> +                               };
> >> +
> >> +                               ldo7_reg: LDO7 {
> >> +                                       regulator-name =3D "VLCD_1.8V";
> >> +                                       regulator-min-microvolt =3D <1=
800000>;
> >> +                                       regulator-max-microvolt =3D <1=
800000>;
> >> +                                       /* Till we get panel driver */
> >> +                                       regulator-always-on;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo8_reg: LDO8 {
> >> +                                       regulator-name =3D "VUSB_3.3V";
> >> +                                       regulator-min-microvolt =3D <3=
300000>;
> >> +                                       regulator-max-microvolt =3D <3=
300000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo9_reg: LDO9 {
> >> +                                       regulator-name =3D "VCC_2.8V_P=
DA";
> >> +                                       regulator-min-microvolt =3D <2=
800000>;
> >> +                                       regulator-max-microvolt =3D <2=
800000>;
> >> +                                       regulator-always-on;
> >> +                               };
> >> +
> >> +                               ldo10_reg: LDO10 {
> >> +                                       regulator-name =3D "VPLL_1.2V";
> >> +                                       regulator-min-microvolt =3D <1=
200000>;
> >> +                                       regulator-max-microvolt =3D <1=
200000>;
> >> +                                       regulator-always-on;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-on-in-suspen=
d;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo11_reg: LDO11 {
> >> +                                       regulator-name =3D "CAM_AF_3.0=
V";
> >> +                                       regulator-min-microvolt =3D <3=
000000>;
> >> +                                       regulator-max-microvolt =3D <3=
000000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo12_reg: LDO12 {
> >> +                                       regulator-name =3D "CAM_SENSOR=
_CORE_1.2V";
> >> +                                       regulator-min-microvolt =3D <1=
200000>;
> >> +                                       regulator-max-microvolt =3D <1=
200000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo13_reg: LDO13 {
> >> +                                       regulator-name =3D "VGA_VDDIO_=
2.8V";
> >> +                                       regulator-min-microvolt =3D <2=
800000>;
> >> +                                       regulator-max-microvolt =3D <2=
800000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo14_reg: LDO14 {
> >> +                                       regulator-name =3D "VGA_DVDD_1=
=2E8V";
> >> +                                       regulator-min-microvolt =3D <1=
800000>;
> >> +                                       regulator-max-microvolt =3D <1=
800000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo15_reg: LDO15 {
> >> +                                       regulator-name =3D "CAM_ISP_HO=
ST_2.8V";
> >> +                                       regulator-min-microvolt =3D <2=
800000>;
> >> +                                       regulator-max-microvolt =3D <2=
800000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo16_reg: LDO16 {
> >> +                                       regulator-name =3D "VGA_AVDD_2=
=2E8V";
> >> +                                       regulator-min-microvolt =3D <2=
800000>;
> >> +                                       regulator-max-microvolt =3D <2=
800000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ldo17_reg: LDO17 {
> >> +                                       regulator-name =3D "VCC_3.0V_L=
CD";
> >> +                                       regulator-min-microvolt =3D <3=
000000>;
> >> +                                       regulator-max-microvolt =3D <3=
000000>;
> >> +                                       /* Till we get panel driver */
> >> +                                       regulator-always-on;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               buck1_reg: BUCK1 {
> >> +                                       regulator-name =3D "vddarm";
> >> +                                       regulator-min-microvolt =3D <7=
50000>;
> >> +                                       regulator-max-microvolt =3D <1=
500000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                               regulator-suspend-micr=
ovolt =3D <1250000>;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               buck2_reg: BUCK2 {
> >> +                                       regulator-name =3D "vddint";
> >> +                                       regulator-min-microvolt =3D <7=
50000>;
> >> +                                       regulator-max-microvolt =3D <1=
500000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                               regulator-suspend-micr=
ovolt =3D <1100000>;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               buck3_reg: BUCK3 {
> >> +                                       regulator-name =3D "VCC_1.8V";
> >> +                                       regulator-min-microvolt =3D <1=
800000>;
> >> +                                       regulator-max-microvolt =3D <1=
800000>;
> >> +                                       regulator-always-on;
> >> +                               };
> >> +
> >> +                               buck4_reg: BUCK4 {
> >> +                                       regulator-name =3D "CAM_ISP_CO=
RE_1.2V";
> >> +                                       regulator-min-microvolt =3D <1=
200000>;
> >> +                                       regulator-max-microvolt =3D <1=
200000>;
> >> +
> >> +                                       regulator-state-mem {
> >> +                                               regulator-off-in-suspe=
nd;
> >> +                                       };
> >> +                               };
> >> +
> >> +                               ap32khz_reg: EN32KHz-AP {
> >> +                                       regulator-name =3D "32KHz AP";
> >> +                                       regulator-always-on;
> >> +                               };
> >> +
> >> +                               cp32khz_reg: EN32KHz-CP {
> >> +                                       regulator-name =3D "32KHz CP";
> >> +                               };
> >> +
> >> +                               vichg_reg: ENVICHG {
> >> +                                       regulator-name =3D "VICHG";
> >> +                                       regulator-always-on;
> >> +                               };
> >> +
> >> +                               safe1_sreg: ESAFEOUT1 {
> >> +                                       regulator-name =3D "SAFEOUT1";
> >> +                               };
> >> +
> >> +                               safe2_sreg: ESAFEOUT2 {
> >> +                                       regulator-name =3D "SAFEOUT2";
> >> +                               };
> >> +                       };
> >> +               };
> >> +       };
> >> +
> >> +       i2c_fuel: i2c-gpio-1 {
> >> +               compatible =3D "i2c-gpio";
> >> +               sda-gpios =3D <&mp05 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_D=
RAIN)>;
> >> +               scl-gpios =3D <&mp05 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_D=
RAIN)>;
> >> +               i2c-gpio,delay-us =3D <2>;
> >> +               #address-cells =3D <1>;
> >> +               #size-cells =3D <0>;
> >> +
> >> +               fuelgauge@36 {
> >> +                       compatible =3D "maxim,max17040";
> >> +                       interrupt-parent =3D <&vic0>;
> >> +                       interrupts =3D <7>;
> >> +                       reg =3D <0x36>;
> >> +               };
> >> +       };
> >> +};
> >> +
> >> +&xusbxti {
> >> +       clock-frequency =3D <24000000>;
> >> +};
> >> +
> >> +&pinctrl0 {
> >
> > Thanks for changes. You missed one part - ordering the labels here
> > alphabetically, so:
> >
> > &fimd {}
> > &hsotg {}
> > ...
> > &xusbxti {}
>=20
> Ah, now I see that you changed the order of nodes inside pinctrl. No
> need. These were good - ordered by pin names (so gpb, gpg, gph, gpj).
> I was referring only to the top-level overrides by label. The point is
> when people add new overrides, they tend to add them to the end... and
> this brings conflicts with multiple edits at the same time. When node
> overrides are ordered and new entries are being added, the chance of
> conflicts is reduced.
>=20
Ok now it's clear for me, will fix this  (finally) in v3.

Thanks
> BR,
> Krzysztof
>=20


