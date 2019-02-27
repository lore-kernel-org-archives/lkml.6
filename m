Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5449521850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMjsrcOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfB0UBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:01:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42964 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfB0UBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:01:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id p1so13369057lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8R3huocdSzzjKvajFCrbuq/U9qtT8qNxJTewVBXs2M=;
        b=lMjsrcOg0/PcCM7TqmpF+eRHpvemBM4CAWOgxqvOAI4p8vkf7MujH6ExeeOmUbnaFP
         cV1ZqcijI5bozQEHM8o7hats4Aej/iEIUk1SZCv5PpOuPVW2RbzzDDIjABz6dF/PgXWV
         q1w9GTQDJm2jr11XTheDQRdmovqBJ0pemi7hw09rEOTXxli4WP/2Lwxu65sib3MlZrw3
         HkbgB8BaQbrK/h/zLz2mzoKoNGryOB6E012RO0Zuq1H6WPCYe6PZG/yLFp1eXsa6wP2T
         65iRJV1+UJa+PyFlN5JFeRkohkbFecd1oG4LAya1oEnjWANCFYm+ukIwbOmiM8ft+BgG
         KxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8R3huocdSzzjKvajFCrbuq/U9qtT8qNxJTewVBXs2M=;
        b=qxj2CJxM+ysly0Q9jRLshB50ijoeONOjc8UKLNsjTzJN2YSl7neyCDb7il0tWUqfxd
         RcMtIYIEBRwBw9nUet5x3vhOlChX1dIfIGpBrlt70x6CxoH5Dx7gxHdsSZarY7jcqU/u
         /WZQNEduIydsDzUzI3FgBL2k9tqyIHvBBCOYyhRYEQxA654oXzeb1LAOQJ3sSlGnlqq7
         xhhc3yo2vELw+YEyawMq6Kx4RcCrSvJDKuBdwCpC7hr1o+osT9qeUrf4KDgUcHxFgOn2
         8ij+RwA2+q6uNDlwBYtMnuNH9O2ymKS6s8wuQKJy9UJexI9OBI+CwMJVjj5tTZD8J/Re
         WFPA==
X-Gm-Message-State: AHQUAuYFj53bZimzDF642FAC6mROMrMRNBYWjDTsaOlAJ0OH7W21U3Dm
        OoR0H6P2xzIeH6dFD19MLMMRs2MMUbaNjC6cLeMz4w==
X-Google-Smtp-Source: AHgI3IZG/TpASYBSGpRfeyDKu7xo6kSgVw0d75bwnDaMO1BNM2sK0FHJ9RSeWlx0U76cs9BebJ2K6lejNqrgEgGKtNk=
X-Received: by 2002:ac2:55ad:: with SMTP id y13mr1977318lfg.97.1551297661564;
 Wed, 27 Feb 2019 12:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20190227074009.19248-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190227074009.19248-1-bjorn.andersson@linaro.org>
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Wed, 27 Feb 2019 21:00:50 +0100
Message-ID: <CAP71Wjww2RLi_+tLRzxjSCxASwHZLvF1U0EFFfOSpjk=UFjLPA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add Dragonboard 845c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 8:39 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> This adds an initial dts for the Dragonboard 845. Supported
> functionality includes Debug UART, UFS, USB-C (peripheral), USB-A
> (host), Ethernet, microSD-card and Bluetooth.
>
> Initializing the SMMU is clearing the mapping used for the splash screen
> framebuffer, which causes the baord to reboot. This can be worked around
> using:
>
>   fastboot oem select-display-panel none
>
> Ethernet and the second USB-A port depends on a functional firmware
> loader for the uPD720201.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> This depends on the addition of the PCIe controller and PHY nodes, from
> https://lore.kernel.org/lkml/20190227070022.31975-1-bjorn.andersson@linaro.org/
>
>  arch/arm64/boot/dts/qcom/Makefile          |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 570 +++++++++++++++++++++
>  2 files changed, 571 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 21d548f02d39..b3fe72ff2955 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8998-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sdm845-db845c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sdm845-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> new file mode 100644
> index 000000000000..0a5cfab6f6e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +
> +/ {
> +       model = "Thundercomm Dragonboard 845c";
> +       compatible = "thundercomm,db845c", "qcom,sdm845";
> +
> +       aliases {
> +               serial0 = &uart9;
> +               hsuart0 = &uart6;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       dc12v: dc12v-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "DC12V";
> +               regulator-min-microvolt = <12000000>;
> +               regulator-max-microvolt = <12000000>;
> +               regulator-always-on;
> +       };
> +
> +       lt9611_1v8: lt9611-vdd18-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "LT9611_1V8";
> +
> +               vin-supply = <&vdc_5v>;
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +
> +               gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       lt9611_3v3: lt9611-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "LT9611_3V3";
> +
> +               vin-supply = <&vdc_3v3>;
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               // TODO: make it possible to drive same GPIO from two clients
> +               // gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
> +               // enable-active-high;
> +       };
> +
> +       pcie0_1p05v: pcie-0-1p05v-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "PCIE0_1.05V";
> +
> +               vin-supply = <&vbat>;
> +               regulator-min-microvolt = <1050000>;
> +               regulator-max-microvolt = <1050000>;
> +
> +               // TODO: make it possible to drive same GPIO from two clients
> +               // gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
> +               // enable-active-high;
> +       };
> +
> +       pcie0_3p3v_dual: vldo-3v3-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VLDO_3V3";
> +
> +               vin-supply = <&vbat>;
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +
> +               gpio = <&tlmm 90 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       gpio_keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               autorepeat;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&vol_up_pin_a>;
> +
> +               vol-up {
> +                       label = "Volume Up";
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               user4 {
> +                       label = "db845c:green:user4";

I think we've agreed to standardize on label names for 96boards
compatible boards.
https://lore.kernel.org/lkml/20190205192412.GG31919@minitux/

> +                       gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +                       default-state = "off";
> +               };
> +
> +               wlan {
> +                       label = "db845c:yellow:wlan";
> +                       gpios = <&pm8998_gpio 9 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "phy0tx";
> +                       default-state = "off";
> +               };
> +
> +               bt {
> +                       label = "db845c:blue:bt";
> +                       gpios = <&pm8998_gpio 5 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "bluetooth-power";
> +                       default-state = "off";
> +               };
> +       };
> +
> +       v5p0_hdmiout: v5p0-hdmiout-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "V5P0_HDMIOUT";
> +
> +               vin-supply = <&vdc_5v>;
> +               regulator-min-microvolt = <500000>;
> +               regulator-max-microvolt = <500000>;
> +
> +               // TODO: make it possible to drive same GPIO from two clients
> +               // gpio = <&tlmm 89 GPIO_ACTIVE_HIGH>;
> +               // enable-active-high;
> +       };
> +
> +       vbat: vbat-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VBAT";
> +
> +               vin-supply = <&dc12v>;
> +               regulator-min-microvolt = <4200000>;
> +               regulator-max-microvolt = <4200000>;
> +               regulator-always-on;
> +       };
> +
> +       vbat_som: vbat-som-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VBAT_SOM";
> +
> +               vin-supply = <&dc12v>;
> +               regulator-min-microvolt = <4200000>;
> +               regulator-max-microvolt = <4200000>;
> +               regulator-always-on;
> +       };
> +
> +       vdc_3v3: vdc-3v3-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VDC_3V3";
> +               vin-supply = <&dc12v>;
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +       };
> +
> +       vdc_5v: vdc-5v-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VDC_5V";
> +
> +               vin-supply = <&dc12v>;
> +               regulator-min-microvolt = <500000>;
> +               regulator-max-microvolt = <500000>;
> +               regulator-always-on;
> +       };
> +
> +       vreg_s4a_1p8: vreg-s4a-1p8 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vreg_s4a_1p8";
> +
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-always-on;
> +       };
> +
> +       vph_pwr: vph-pwr-regulator {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vph_pwr";
> +
> +               vin-supply = <&vbat_som>;
> +       };
> +};
> +
> +&apps_rsc {
> +       pm8998-rpmh-regulators {
> +               compatible = "qcom,pm8998-rpmh-regulators";
> +               qcom,pmic-id = "a";
> +               vdd-s1-supply = <&vph_pwr>;
> +               vdd-s2-supply = <&vph_pwr>;
> +               vdd-s3-supply = <&vph_pwr>;
> +               vdd-s4-supply = <&vph_pwr>;
> +               vdd-s5-supply = <&vph_pwr>;
> +               vdd-s6-supply = <&vph_pwr>;
> +               vdd-s7-supply = <&vph_pwr>;
> +               vdd-s8-supply = <&vph_pwr>;
> +               vdd-s9-supply = <&vph_pwr>;
> +               vdd-s10-supply = <&vph_pwr>;
> +               vdd-s11-supply = <&vph_pwr>;
> +               vdd-s12-supply = <&vph_pwr>;
> +               vdd-s13-supply = <&vph_pwr>;
> +               vdd-l1-l27-supply = <&vreg_s7a_1p025>;
> +               vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
> +               vdd-l3-l11-supply = <&vreg_s7a_1p025>;
> +               vdd-l4-l5-supply = <&vreg_s7a_1p025>;
> +               vdd-l6-supply = <&vph_pwr>;
> +               vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
> +               vdd-l9-supply = <&vreg_bob>;
> +               vdd-l10-l23-l25-supply = <&vreg_bob>;
> +               vdd-l13-l19-l21-supply = <&vreg_bob>;
> +               vdd-l16-l28-supply = <&vreg_bob>;
> +               vdd-l18-l22-supply = <&vreg_bob>;
> +               vdd-l20-l24-supply = <&vreg_bob>;
> +               vdd-l26-supply = <&vreg_s3a_1p35>;
> +               vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
> +
> +               vreg_s3a_1p35: smps3 {
> +                       regulator-min-microvolt = <1352000>;
> +                       regulator-max-microvolt = <1352000>;
> +               };
> +
> +               vreg_s5a_2p04: smps5 {
> +                       regulator-min-microvolt = <1904000>;
> +                       regulator-max-microvolt = <2040000>;
> +               };
> +
> +               vreg_s7a_1p025: smps7 {
> +                       regulator-min-microvolt = <900000>;
> +                       regulator-max-microvolt = <1028000>;
> +               };
> +
> +               vreg_l1a_0p875: ldo1 {
> +                       regulator-min-microvolt = <880000>;
> +                       regulator-max-microvolt = <880000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l12a_1p8: ldo12 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l7a_1p8: ldo7 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l13a_2p95: ldo13 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2960000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l17a_1p3: ldo17 {
> +                       regulator-min-microvolt = <1304000>;
> +                       regulator-max-microvolt = <1304000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l20a_2p95: ldo20 {
> +                       regulator-min-microvolt = <2960000>;
> +                       regulator-max-microvolt = <2968000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l21a_2p95: ldo21 {
> +                       regulator-min-microvolt = <2960000>;
> +                       regulator-max-microvolt = <2968000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l24a_3p075: ldo24 {
> +                       regulator-min-microvolt = <3088000>;
> +                       regulator-max-microvolt = <3088000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l25a_3p3: ldo25 {
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3312000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +
> +               vreg_l26a_1p2: ldo26 {
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +               };
> +       };
> +
> +       pmi8998-rpmh-regulators {
> +               compatible = "qcom,pmi8998-rpmh-regulators";
> +               qcom,pmic-id = "b";
> +
> +               vdd-bob-supply = <&vph_pwr>;
> +
> +               vreg_bob: bob {
> +                       regulator-min-microvolt = <3312000>;
> +                       regulator-max-microvolt = <3600000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +                       regulator-allow-bypass;
> +               };
> +       };
> +};
> +
> +&gcc {
> +       protected-clocks = <GCC_QSPI_CORE_CLK>,
> +                          <GCC_QSPI_CORE_CLK_SRC>,
> +                          <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
> +};
> +
> +&pcie0 {
> +       status = "okay";
> +       perst-gpio = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +       enable-gpio = <&tlmm 134 GPIO_ACTIVE_HIGH>;
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pcie0_perst_state>, <&pcie0_clkreq_state>, <&pcie0_wake_state>;
> +
> +       vddpe-3v3-supply = <&pcie0_3p3v_dual>;
> +};
> +
> +&pcie0_phy {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vreg_l1a_0p875>;
> +       vdda-pll-supply = <&vreg_l26a_1p2>;
> +};
> +
> +&pm8998_gpio {
> +       vol_up_pin_a: vol-up-active {
> +               pins = "gpio6";
> +               function = "normal";
> +               input-enable;
> +               bias-pull-up;
> +               qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +       };
> +};
> +
> +&pm8998_pon {
> +       resin {
> +               compatible = "qcom,pm8941-resin";
> +               interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +               debounce = <15625>;
> +               bias-pull-up;
> +               linux,code = <KEY_VOLUMEDOWN>;
> +       };
> +};
> +
> +&qupv3_id_0 {
> +       status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +       status = "okay";
> +};
> +
> +&sdhc_2 {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_card_det_n>;
> +
> +       vmmc-supply = <&vreg_l21a_2p95>;
> +       vqmmc-supply = <&vreg_l13a_2p95>;
> +
> +       bus-width = <4>;
> +       cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
> +};
> +
> +&tlmm {
> +       pcie0_pwren_state: pcie0-pwren {
> +               pins = "gpio90";
> +               function = "gpio";
> +
> +               drive-strength = <2>;
> +               bias-disable;
> +       };
> +
> +       pcie0_perst_state: pcie0-reset {
> +               pins = "gpio35";
> +               function = "gpio";
> +
> +               drive-strength = <2>;
> +               output-low;
> +               bias-pull-down;
> +       };
> +
> +       pcie0_clkreq_state: pcie0-clkreq {
> +               pins = "gpio36";
> +               function = "pci_e0";
> +               bias-pull-up;
> +       };
> +
> +       pcie0_wake_state: pcie0-wake {
> +               pins = "gpio37";
> +               function = "gpio";
> +
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
> +
> +       sdc2_clk: sdc2-clk {
> +               pins = "sdc2_clk";
> +               bias-disable;
> +
> +               /*
> +                * It seems that mmc_test reports errors if drive
> +                * strength is not 16 on clk, cmd, and data pins.
> +                */
> +               drive-strength = <16>;
> +       };
> +
> +       sdc2_cmd: sdc2-cmd {
> +               pins = "sdc2_cmd";
> +               bias-pull-up;
> +               drive-strength = <10>;
> +       };
> +
> +       sdc2_data: sdc2-data {
> +               pins = "sdc2_data";
> +               bias-pull-up;
> +               drive-strength = <10>;
> +       };
> +
> +       sd_card_det_n: sd-card-det-n {
> +               pins = "gpio126";
> +               function = "gpio";
> +               bias-pull-up;
> +       };
> +};
> +
> +&uart6 {
> +       status = "okay";
> +
> +       bluetooth {
> +               compatible = "qcom,wcn3990-bt";
> +
> +               vddio-supply = <&vreg_s4a_1p8>;
> +               vddxo-supply = <&vreg_l7a_1p8>;
> +               vddrf-supply = <&vreg_l17a_1p3>;
> +               vddch0-supply = <&vreg_l25a_3p3>;
> +               max-speed = <3200000>;
> +       };
> +};
> +
> +&uart9 {
> +       status = "okay";
> +};
> +
> +&usb_1 {
> +       status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +       dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +       status = "okay";
> +
> +       vdd-supply = <&vreg_l1a_0p875>;
> +       vdda-pll-supply = <&vreg_l12a_1p8>;
> +       vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> +
> +       qcom,imp-res-offset-value = <8>;
> +       qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
> +       qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
> +       qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> +};
> +
> +&usb_1_qmpphy {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vreg_l26a_1p2>;
> +       vdda-pll-supply = <&vreg_l1a_0p875>;
> +};
> +
> +&usb_2 {
> +       status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +       dr_mode = "host";
> +};
> +
> +&usb_2_hsphy {
> +       status = "okay";
> +
> +       vdd-supply = <&vreg_l1a_0p875>;
> +       vdda-pll-supply = <&vreg_l12a_1p8>;
> +       vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> +
> +       qcom,imp-res-offset-value = <8>;
> +       qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
> +};
> +
> +&usb_2_qmpphy {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vreg_l26a_1p2>;
> +       vdda-pll-supply = <&vreg_l1a_0p875>;
> +};
> +
> +&ufs_mem_hc {
> +       status = "okay";
> +
> +       vcc-supply = <&vreg_l20a_2p95>;
> +       vcc-max-microamp = <800000>;
> +};
> +
> +&ufs_mem_phy {
> +       status = "okay";
> +
> +       vdda-phy-supply = <&vreg_l1a_0p875>;
> +       vdda-pll-supply = <&vreg_l26a_1p2>;
> +};
> +
> +&wifi {
> +       status = "okay";
> +};
> +
> +/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> +
> +&qup_uart6_default {
> +       pinmux {
> +               pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +               function = "qup6";
> +       };
> +
> +       cts {
> +               pins = "gpio45";
> +               bias-disable;
> +       };
> +
> +       rts-tx {
> +               pins = "gpio46", "gpio47";
> +               drive-strength = <2>;
> +               bias-disable;
> +       };
> +
> +       rx {
> +               pins = "gpio48";
> +               bias-pull-up;
> +       };
> +};
> +
> +&qup_uart9_default {
> +       pinconf-tx {
> +               pins = "gpio4";
> +               drive-strength = <2>;
> +               bias-disable;
> +       };
> +
> +       pinconf-rx {
> +               pins = "gpio5";
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
> +};
> --
> 2.18.0
>
