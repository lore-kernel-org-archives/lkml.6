Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654A3C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED03F24B12
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1C2r3Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED03F24B12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753626AbeF1Hsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeF1Hsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:48:51 -0400
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com [209.85.128.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C801924997;
        Thu, 28 Jun 2018 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530172131;
        bh=Q6SFDNBBCYPX07Z9ZGOmFTB+aqrBX89jdvqoYto9jU4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=V1C2r3DlZdS/taHcwBlDicwYtJpYLq72TBCXIP61Xlymb4lYY6+dgHBXkw2R+MrXa
         a3Kwz6oqUSDn1qxAuMroru7TrgnRd4hesko+YDOJmihgAfKHcsXSYpQyyQzma2+OdH
         pknPTo/MBQEsetL08oHFvDBMTDeYokjdLXWxgs/0=
Received: by mail-wr0-f173.google.com with SMTP id c5-v6so4431793wrs.10;
        Thu, 28 Jun 2018 00:48:50 -0700 (PDT)
X-Gm-Message-State: APt69E2Utz3pe5NbxrCgb1kN1jmTTUuP+BQlNJGwuzqFVCab8AP1I7UQ
        5t0ZM7Dq7fVjC+OPw3/TbGjkdxgL1mjq6NIq5EY=
X-Google-Smtp-Source: AAOMgpcMw16/KSg7YNNTssA/L1dWcj67sX9fqbeDMpFtwvi5wM3rRh+ErsMQp0kR2nsPy63CoHbFKX8hPxPDCoHLrRE=
X-Received: by 2002:adf:9d93:: with SMTP id p19-v6mr7953824wre.12.1530172129223;
 Thu, 28 Jun 2018 00:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 00:48:48
 -0700 (PDT)
In-Reply-To: <CAJKOXPdxdwmCcXNnYNCc81hZVi=YUs_+CNKev_gPZbXoMPPepg@mail.gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530119544-30023-3-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPdxdwmCcXNnYNCc81hZVi=YUs_+CNKev_gPZbXoMPPepg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 28 Jun 2018 09:48:48 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf5MMAwEEt8xZ2mcTUCmrZiOTgGOJuuo5yHmh8UWE6ULA@mail.gmail.com>
Message-ID: <CAJKOXPf5MMAwEEt8xZ2mcTUCmrZiOTgGOJuuo5yHmh8UWE6ULA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] ARM: dts: s5pv210: Add initial DTS for Samsung
 Aries based phones
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 09:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27 June 2018 at 19:12, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.c=
om> wrote:
>> This DTS file have initial support Samsung Aries based phones.
>> Initial version have support for:
>> - sdcard
>> - internal memory (present only on non 4g variant)
>> - max8998 pmic and rtc
>> - max17040 fuel gauge
>> - gpio keys
>> - fimd (no panel driver yet)
>> - usb (peripherial mode)
>> - wifi
>>
>> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
>> ---
>>
>> Changes from v1:
>>   - Removed duplicated and unneeded headers
>>   - Corrected node names
>>   - Added missing spaces
>>   - Removed unneeded pinctrl and sorted entries
>>   - Set correct interrupt type for max8998 pmic
>>   - Add missing regulators
>> ---
>> ---
>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 423 ++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 423 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5=
pv210-aries.dtsi
>> new file mode 100644
>> index 000000000000..61b6cf76265f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> @@ -0,0 +1,423 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Samsung's S5PV210 based Galaxy Aries board device tree source
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include "s5pv210.dtsi"
>> +
>> +/ {
>> +       compatible =3D "samsung,aries", "samsung,s5pv210";
>> +
>> +       aliases {
>> +               i2c6 =3D &i2c_pmic;
>> +               i2c9 =3D &i2c_fuel;
>> +       };
>> +
>> +       memory@30000000 {
>> +               device_type =3D "memory";
>> +               reg =3D <0x30000000 0x05000000
>> +                       0x40000000 0x10000000
>> +                       0x50000000 0x08000000>;
>> +       };
>> +
>> +       wifi_pwrseq: wifi-pwrseq {
>> +               compatible =3D "mmc-pwrseq-simple";
>> +               reset-gpios =3D <&gpg1 2 GPIO_ACTIVE_LOW>;
>> +               pinctrl-names =3D "default";
>> +               pinctrl-0 =3D <&wlan_gpio_rst>;
>> +               post-power-on-delay-ms =3D <500>;
>> +               power-off-delay-us =3D <500>;
>> +       };
>> +
>> +       i2c_pmic: i2c-gpio-0 {
>> +               compatible =3D "i2c-gpio";
>> +               sda-gpios =3D <&gpj4 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRA=
IN)>;
>> +               scl-gpios =3D <&gpj4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRA=
IN)>;
>> +               i2c-gpio,delay-us =3D <2>;
>> +               #address-cells =3D <1>;
>> +               #size-cells =3D <0>;
>> +
>> +               pmic@66 {
>> +                       compatible =3D "maxim,max8998";
>> +                       reg =3D <0x66>;
>> +                       interrupt-parent =3D <&gph0>;
>> +                       interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +                       max8998,pmic-buck1-default-dvs-idx =3D <1>;
>> +                       max8998,pmic-buck1-dvs-gpios =3D <&gph0 3 GPIO_A=
CTIVE_HIGH>,
>> +                                                       <&gph0 4 GPIO_AC=
TIVE_HIGH>;
>> +                       max8998,pmic-buck1-dvs-voltage =3D <1275000>, <1=
200000>,
>> +                                                       <1050000>, <9500=
00>;
>> +
>> +                       max8998,pmic-buck2-default-dvs-idx =3D <0>;
>> +                       max8998,pmic-buck2-dvs-gpio =3D <&gph0 5 GPIO_AC=
TIVE_HIGH>;
>> +                       max8998,pmic-buck2-dvs-voltage =3D <1100000>, <1=
000000>;
>> +
>> +                       regulators {
>> +                               ldo2_reg: LDO2 {
>> +                                       regulator-name =3D "VALIVE_1.2V"=
;
>> +                                       regulator-min-microvolt =3D <120=
0000>;
>> +                                       regulator-max-microvolt =3D <120=
0000>;
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-on-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo3_reg: LDO3 {
>> +                                       regulator-name =3D "VUSB_1.1V";
>> +                                       regulator-min-microvolt =3D <110=
0000>;
>> +                                       regulator-max-microvolt =3D <110=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo4_reg: LDO4 {
>> +                                       regulator-name =3D "VADC_3.3V";
>> +                                       regulator-min-microvolt =3D <330=
0000>;
>> +                                       regulator-max-microvolt =3D <330=
0000>;
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo5_reg: LDO5 {
>> +                                       regulator-name =3D "VTF_2.8V";
>> +                                       regulator-min-microvolt =3D <280=
0000>;
>> +                                       regulator-max-microvolt =3D <280=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo6_reg: LDO6 {
>> +                                       regulator-name =3D "LDO6";
>> +                                       regulator-min-microvolt =3D <160=
0000>;
>> +                                       regulator-max-microvolt =3D <360=
0000>;
>> +                               };
>> +
>> +                               ldo7_reg: LDO7 {
>> +                                       regulator-name =3D "VLCD_1.8V";
>> +                                       regulator-min-microvolt =3D <180=
0000>;
>> +                                       regulator-max-microvolt =3D <180=
0000>;
>> +                                       /* Till we get panel driver */
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo8_reg: LDO8 {
>> +                                       regulator-name =3D "VUSB_3.3V";
>> +                                       regulator-min-microvolt =3D <330=
0000>;
>> +                                       regulator-max-microvolt =3D <330=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo9_reg: LDO9 {
>> +                                       regulator-name =3D "VCC_2.8V_PDA=
";
>> +                                       regulator-min-microvolt =3D <280=
0000>;
>> +                                       regulator-max-microvolt =3D <280=
0000>;
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               ldo10_reg: LDO10 {
>> +                                       regulator-name =3D "VPLL_1.2V";
>> +                                       regulator-min-microvolt =3D <120=
0000>;
>> +                                       regulator-max-microvolt =3D <120=
0000>;
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-on-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo11_reg: LDO11 {
>> +                                       regulator-name =3D "CAM_AF_3.0V"=
;
>> +                                       regulator-min-microvolt =3D <300=
0000>;
>> +                                       regulator-max-microvolt =3D <300=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo12_reg: LDO12 {
>> +                                       regulator-name =3D "CAM_SENSOR_C=
ORE_1.2V";
>> +                                       regulator-min-microvolt =3D <120=
0000>;
>> +                                       regulator-max-microvolt =3D <120=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo13_reg: LDO13 {
>> +                                       regulator-name =3D "VGA_VDDIO_2.=
8V";
>> +                                       regulator-min-microvolt =3D <280=
0000>;
>> +                                       regulator-max-microvolt =3D <280=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo14_reg: LDO14 {
>> +                                       regulator-name =3D "VGA_DVDD_1.8=
V";
>> +                                       regulator-min-microvolt =3D <180=
0000>;
>> +                                       regulator-max-microvolt =3D <180=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo15_reg: LDO15 {
>> +                                       regulator-name =3D "CAM_ISP_HOST=
_2.8V";
>> +                                       regulator-min-microvolt =3D <280=
0000>;
>> +                                       regulator-max-microvolt =3D <280=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo16_reg: LDO16 {
>> +                                       regulator-name =3D "VGA_AVDD_2.8=
V";
>> +                                       regulator-min-microvolt =3D <280=
0000>;
>> +                                       regulator-max-microvolt =3D <280=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ldo17_reg: LDO17 {
>> +                                       regulator-name =3D "VCC_3.0V_LCD=
";
>> +                                       regulator-min-microvolt =3D <300=
0000>;
>> +                                       regulator-max-microvolt =3D <300=
0000>;
>> +                                       /* Till we get panel driver */
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               buck1_reg: BUCK1 {
>> +                                       regulator-name =3D "vddarm";
>> +                                       regulator-min-microvolt =3D <750=
000>;
>> +                                       regulator-max-microvolt =3D <150=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                               regulator-suspend-microv=
olt =3D <1250000>;
>> +                                       };
>> +                               };
>> +
>> +                               buck2_reg: BUCK2 {
>> +                                       regulator-name =3D "vddint";
>> +                                       regulator-min-microvolt =3D <750=
000>;
>> +                                       regulator-max-microvolt =3D <150=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                               regulator-suspend-microv=
olt =3D <1100000>;
>> +                                       };
>> +                               };
>> +
>> +                               buck3_reg: BUCK3 {
>> +                                       regulator-name =3D "VCC_1.8V";
>> +                                       regulator-min-microvolt =3D <180=
0000>;
>> +                                       regulator-max-microvolt =3D <180=
0000>;
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               buck4_reg: BUCK4 {
>> +                                       regulator-name =3D "CAM_ISP_CORE=
_1.2V";
>> +                                       regulator-min-microvolt =3D <120=
0000>;
>> +                                       regulator-max-microvolt =3D <120=
0000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend=
;
>> +                                       };
>> +                               };
>> +
>> +                               ap32khz_reg: EN32KHz-AP {
>> +                                       regulator-name =3D "32KHz AP";
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               cp32khz_reg: EN32KHz-CP {
>> +                                       regulator-name =3D "32KHz CP";
>> +                               };
>> +
>> +                               vichg_reg: ENVICHG {
>> +                                       regulator-name =3D "VICHG";
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               safe1_sreg: ESAFEOUT1 {
>> +                                       regulator-name =3D "SAFEOUT1";
>> +                               };
>> +
>> +                               safe2_sreg: ESAFEOUT2 {
>> +                                       regulator-name =3D "SAFEOUT2";
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       i2c_fuel: i2c-gpio-1 {
>> +               compatible =3D "i2c-gpio";
>> +               sda-gpios =3D <&mp05 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRA=
IN)>;
>> +               scl-gpios =3D <&mp05 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRA=
IN)>;
>> +               i2c-gpio,delay-us =3D <2>;
>> +               #address-cells =3D <1>;
>> +               #size-cells =3D <0>;
>> +
>> +               fuelgauge@36 {
>> +                       compatible =3D "maxim,max17040";
>> +                       interrupt-parent =3D <&vic0>;
>> +                       interrupts =3D <7>;
>> +                       reg =3D <0x36>;
>> +               };
>> +       };
>> +};
>> +
>> +&xusbxti {
>> +       clock-frequency =3D <24000000>;
>> +};
>> +
>> +&pinctrl0 {
>
> Thanks for changes. You missed one part - ordering the labels here
> alphabetically, so:
>
> &fimd {}
> &hsotg {}
> ...
> &xusbxti {}

Ah, now I see that you changed the order of nodes inside pinctrl. No
need. These were good - ordered by pin names (so gpb, gpg, gph, gpj).
I was referring only to the top-level overrides by label. The point is
when people add new overrides, they tend to add them to the end... and
this brings conflicts with multiple edits at the same time. When node
overrides are ordered and new entries are being added, the chance of
conflicts is reduced.

BR,
Krzysztof
