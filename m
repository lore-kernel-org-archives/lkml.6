Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626A822407
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="flyoUZwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626A822407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbeFVHlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeFVHlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:41:06 -0400
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com [209.85.128.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91772249A;
        Fri, 22 Jun 2018 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529653265;
        bh=0rOwM6CwVRZHCrFgx5/TI6yI9rTydo3hl78V6xZaGgI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=flyoUZwhO3j/fnTg/03ENnNOGxtrwbSaFkX3+cfuN+DhmUFPhbPAiIRjrO/0vC+lc
         ckE5RMWqJyb7g1EoGD9prop9DTEMENeU06DpSB1dv7iXQknK2bj7l4TEiiLVWK4Tm6
         xRUGeI3F050ty4M+sUgvHHsl9Oz2bDDmRZpcpgYw=
Received: by mail-wr0-f180.google.com with SMTP id a12-v6so5680916wro.1;
        Fri, 22 Jun 2018 00:41:04 -0700 (PDT)
X-Gm-Message-State: APt69E37zzgIovRc/ex7to8ICWTZTGxoXn6tEsOj3zILCiJ9Zd6raFJg
        mNfCRlhLWa0RcB34dE5GqpMSOCu9WwD9JQoIAfg=
X-Google-Smtp-Source: ADUXVKLRhiPcAmZBLTatpsYz9mtCZnSBh2VzQAadLxeLSmAmM30pVAinkbU6Nvlmduk9zl6d34fflD1LGFh/fUOrBq0=
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr535391wro.279.1529653263368;
 Fri, 22 Jun 2018 00:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:41:02
 -0700 (PDT)
In-Reply-To: <1529608199-5583-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1529608199-5583-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 09:41:02 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf9BVXP19Yt36uEKz=bzMh3cDd6_wdyxoRRX3itk9kuhw@mail.gmail.com>
Message-ID: <CAJKOXPf9BVXP19Yt36uEKz=bzMh3cDd6_wdyxoRRX3itk9kuhw@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: dts: s5pv210: Add initial DTS for Samsung Aries
 based phones.
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

On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com=
> wrote:
> This DTS file have initial support Samsung Aries based phones.
> Initial version have support for:
> - sdcard
> - internal memory (present only on non 4g variant)
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>

Hi Pawel,

Nice job in mainlining!

Below you'll find some comments for improvement.

> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 397 +++++++++++++++++++++++++++++=
++++++
>  1 file changed, 397 insertions(+)
>  create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
>
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5p=
v210-aries.dtsi
> new file mode 100644
> index 000000000000..6e8ac3615765
> --- /dev/null
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's S5PV210 based Galaxy Aries board device tree source
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>

Is the input header used here?

> +#include <dt-bindings/interrupt-controller/irq.h>

Duplicated inclusion.

> +#include "s5pv210.dtsi"
> +
> +/ {
> +       compatible =3D "samsung,aries", "samsung,s5pv210";
> +
> +       aliases {
> +               i2c6 =3D &i2c_pmic;
> +               i2c9 =3D &i2c_fuel;
> +       };
> +
> +       memory@30000000 {
> +               device_type =3D "memory";
> +               reg =3D <0x30000000 0x05000000
> +                       0x40000000 0x10000000
> +                       0x50000000 0x08000000>;
> +       };
> +
> +       wifi_pwrseq: wifi-pwrseq {
> +               compatible =3D "mmc-pwrseq-simple";
> +               reset-gpios =3D <&gpg1 2 GPIO_ACTIVE_LOW>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&wlan_gpio_rst>;
> +               post-power-on-delay-ms =3D <500>;
> +               power-off-delay-us =3D <500>;
> +       };
> +
> +       i2c_pmic: i2c-pmic {

s/i2c-pmic/ to /i2c-gpio-0/
to reflect generic class of this node. Change only the node name. The
label can stay as is.

> +               compatible =3D "i2c-gpio";
> +               sda-gpios =3D <&gpj4 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)=
>;
> +               scl-gpios =3D <&gpj4 3 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)=
>;

Spaces around pipe |.

> +               i2c-gpio,delay-us =3D <2>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               pmic@66 {
> +                       compatible =3D "maxim,max8998";
> +                       reg =3D <0x66>;
> +                       interrupt-parent =3D <&gph0>;
> +                       interrupts =3D <7 0>;

If you really wanted 0 then IRQ_TYPE_NONE... but this should be a
proper interrupt type.

> +
> +                       max8998,pmic-buck1-default-dvs-idx =3D <1>;
> +                       max8998,pmic-buck1-dvs-gpios =3D <&gph0 3 GPIO_AC=
TIVE_HIGH>,
> +                                                       <&gph0 4 GPIO_ACT=
IVE_HIGH>;
> +                       max8998,pmic-buck1-dvs-voltage =3D <1275000>, <12=
00000>,
> +                                                       <1050000>, <95000=
0>;
> +
> +                       max8998,pmic-buck2-default-dvs-idx =3D <0>;
> +                       max8998,pmic-buck2-dvs-gpio =3D <&gph0 5 GPIO_ACT=
IVE_HIGH>;
> +                       max8998,pmic-buck2-dvs-voltage =3D <1100000>, <10=
00000>;
> +
> +                       regulators {
> +                               ldo2_reg: LDO2 {
> +                                       regulator-name =3D "VALIVE_1.2V";
> +                                       regulator-min-microvolt =3D <1200=
000>;
> +                                       regulator-max-microvolt =3D <1200=
000>;
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-on-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo3_reg: LDO3 {
> +                                       regulator-name =3D "VUSB_1.1V";
> +                                       regulator-min-microvolt =3D <1100=
000>;
> +                                       regulator-max-microvolt =3D <1100=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo4_reg: LDO4 {
> +                                       regulator-name =3D "VADC_3.3V";
> +                                       regulator-min-microvolt =3D <3300=
000>;
> +                                       regulator-max-microvolt =3D <3300=
000>;
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo5_reg: LDO5 {
> +                                       regulator-name =3D "VTF_2.8V";
> +                                       regulator-min-microvolt =3D <2800=
000>;
> +                                       regulator-max-microvolt =3D <2800=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };

LDO6?

All regulators should be defined in general. Most of the drivers would
anyway register all of them and use driver-specific defaults for the
ones which are missing in DT. I see that max8998 behaves differently
and silently ignores missing regulators leaving them at bootloader
settings. That's also not good because their initial settings might
not be correct for current load and kernel cannot turn them off if
needed. Also we want in general to have full description of HW in DT.

The same applies to LDO10, clocks and ESAFEOUT2 later.


> +
> +                               ldo7_reg: LDO7 {
> +                                       regulator-name =3D "VLCD_1.8V";
> +                                       regulator-min-microvolt =3D <1800=
000>;
> +                                       regulator-max-microvolt =3D <1800=
000>;
> +                                       /* Till we get panel driver */
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo8_reg: LDO8 {
> +                                       regulator-name =3D "VUSB_3.3V";
> +                                       regulator-min-microvolt =3D <3300=
000>;
> +                                       regulator-max-microvolt =3D <3300=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo9_reg: LDO9 {
> +                                       regulator-name =3D "VCC_2.8V_PDA"=
;
> +                                       regulator-min-microvolt =3D <2800=
000>;
> +                                       regulator-max-microvolt =3D <2800=
000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo11_reg: LDO11 {
> +                                       regulator-name =3D "CAM_AF_3.0V";
> +                                       regulator-min-microvolt =3D <3000=
000>;
> +                                       regulator-max-microvolt =3D <3000=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo12_reg: LDO12 {
> +                                       regulator-name =3D "CAM_SENSOR_CO=
RE_1.2V";
> +                                       regulator-min-microvolt =3D <1200=
000>;
> +                                       regulator-max-microvolt =3D <1200=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo13_reg: LDO13 {
> +                                       regulator-name =3D "VGA_VDDIO_2.8=
V";
> +                                       regulator-min-microvolt =3D <2800=
000>;
> +                                       regulator-max-microvolt =3D <2800=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo14_reg: LDO14 {
> +                                       regulator-name =3D "VGA_DVDD_1.8V=
";
> +                                       regulator-min-microvolt =3D <1800=
000>;
> +                                       regulator-max-microvolt =3D <1800=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo15_reg: LDO15 {
> +                                       regulator-name =3D "CAM_ISP_HOST_=
2.8V";
> +                                       regulator-min-microvolt =3D <2800=
000>;
> +                                       regulator-max-microvolt =3D <2800=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo16_reg: LDO16 {
> +                                       regulator-name =3D "VGA_AVDD_2.8V=
";
> +                                       regulator-min-microvolt =3D <2800=
000>;
> +                                       regulator-max-microvolt =3D <2800=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo17_reg: LDO17 {
> +                                       regulator-name =3D "VCC_3.0V_LCD"=
;
> +                                       regulator-min-microvolt =3D <3000=
000>;
> +                                       regulator-max-microvolt =3D <3000=
000>;
> +                                       /* Till we get panel driver */
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               buck1_reg: BUCK1 {
> +                                       regulator-name =3D "vddarm";
> +                                       regulator-min-microvolt =3D <7500=
00>;
> +                                       regulator-max-microvolt =3D <1500=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                               regulator-suspend-microvo=
lt =3D <1250000>;
> +                                       };
> +                               };
> +
> +                               buck2_reg: BUCK2 {
> +                                       regulator-name =3D "vddint";
> +                                       regulator-min-microvolt =3D <7500=
00>;
> +                                       regulator-max-microvolt =3D <1500=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                               regulator-suspend-microvo=
lt =3D <1100000>;
> +                                       };
> +                               };
> +
> +                               buck3_reg: BUCK3 {
> +                                       regulator-name =3D "VCC_1.8V";
> +                                       regulator-min-microvolt =3D <1800=
000>;
> +                                       regulator-max-microvolt =3D <1800=
000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               buck4_reg: BUCK4 {
> +                                       regulator-name =3D "CAM_ISP_CORE_=
1.2V";
> +                                       regulator-min-microvolt =3D <1200=
000>;
> +                                       regulator-max-microvolt =3D <1200=
000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               safe1_sreg: ESAFEOUT1 {
> +                                       regulator-name =3D "SAFEOUT1";
> +                               };
> +                       };
> +               };
> +       };
> +
> +       i2c_fuel: i2c-fuel {

s/i2c-fuel/ to /i2c-gpio-1/


> +               compatible =3D "i2c-gpio";
> +               sda-gpios =3D <&mp05 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)=
>;
> +               scl-gpios =3D <&mp05 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)=
>;

Spaces around | please.

> +               i2c-gpio,delay-us =3D <2>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               fuel@36 {

Name: fuelgauge

> +                       compatible =3D "maxim,max17040";
> +                       interrupt-parent =3D <&vic0>;
> +                       interrupts =3D <7>;
> +                       reg =3D <0x36>;
> +               };
> +       };
> +};
> +
> +&xusbxti {
> +       clock-frequency =3D <24000000>;
> +};
> +
> +&pinctrl0 {

Please order all labels alphabetically. It reduces conflicts later
with multiple changes.

> +       wlan_bt_en: wlan-bt-en {
> +               samsung,pins =3D "gpb-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
> +               samsung,pin-val =3D <1>;
> +       };
> +
> +       wlan_gpio_rst: wlan-gpio-rst {
> +               samsung,pins =3D "gpg1-2";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
> +       };
> +
> +       wifi_host_wake: wifi-host-wake {
> +               samsung,pins =3D "gph2-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_DOWN>;
> +               samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +
> +       tf_detect: tf-detect {
> +               samsung,pins =3D "gph3-4";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_DOWN>;
> +               samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +
> +       wifi_wake: wifi-wake {
> +               samsung,pins =3D "gph3-5";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
> +       };
> +
> +       massmemory_en: massmemory-en {
> +               samsung,pins =3D "gpj2-7";
> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
> +               samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> +
> +&uart1 {
> +       status =3D "okay";
> +};
> +
> +&uart2 {
> +       status =3D "okay";
> +};
> +
> +&sdhci1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +
> +       bus-width =3D <4>;
> +       max-frequency =3D <38400000>;
> +       pinctrl-0 =3D <&sd1_clk &sd1_cmd &sd1_bus4 &wifi_wake &wifi_host_=
wake &wlan_bt_en>;
> +       pinctrl-names =3D "default";
> +       cap-sd-highspeed;
> +       cap-mmc-highspeed;
> +
> +       mmc-pwrseq =3D <&wifi_pwrseq>;
> +       non-removable;
> +       status =3D "okay";
> +
> +       brcmf: bcrmf@1 {

Name of node should describe generic class of the device so maybe
"wlan" or "wlanbt"? Label is okay.

Best regards,
Krzysztof
