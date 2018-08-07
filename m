Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F637C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D14721757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkke3DrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D14721757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbeHGQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388872AbeHGQXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:23:42 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9553A218D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533650951;
        bh=ZWf1APqy+NBCV2bAW6dRT7dbi2FfAWAKPV2bW4qsYd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jkke3DrIdxorZEHnsHT1vwV4+Ks6ZRi+dOF9brhLxBSB84Q1Gsu67/i8PqvDxNc1n
         37UJRnpCXvD6eATo08T6b6623xpzR4iMuvGg8Vu/zP1KLTkczoXoUAoB7Oy7QLNbwS
         ypV0dpH6YBGABz4h+sc+fKWoNZ28szsO/1QDH7Ro=
Received: by mail-wr1-f54.google.com with SMTP id g6-v6so15948431wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:09:11 -0700 (PDT)
X-Gm-Message-State: AOUpUlGDyGW+AbdpZN5sz+LLwEQhB0lfG5SUNF+R523Ej05rito6tjgi
        zJ9RvK0+O52JvdO0spRZvSBhvG/GDgHWF4cdGcYhHw==
X-Google-Smtp-Source: AA+uWPyFuskW2cryhBlFb+dQVzqwex5EWHqSvBM4el3DKJu23/EhOV/Gc0YB1CBnSrtx00Vgq7kwrhwgHy8N01ImA0Q=
X-Received: by 2002:adf:a354:: with SMTP id d20-v6mr13011927wrb.31.1533650949947;
 Tue, 07 Aug 2018 07:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <1533646500-4028-1-git-send-email-patrice.chotard@st.com> <1533646500-4028-4-git-send-email-patrice.chotard@st.com>
In-Reply-To: <1533646500-4028-4-git-send-email-patrice.chotard@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Aug 2018 08:08:58 -0600
X-Gmail-Original-Message-ID: <CABGGisxNQgduwhpX_jt1d=gKasDFTGovvQeRLh0-dsjSU277bQ@mail.gmail.com>
Message-ID: <CABGGisxNQgduwhpX_jt1d=gKasDFTGovvQeRLh0-dsjSU277bQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: Fix DT dtc warnings for stm32f4
To:     patrice.chotard@st.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, alexandre.torgue@st.com,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 6:55 AM <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Fix the following DT dtc warnings for stm32f429 and
> stm32f469 boards:
>
> Warning (node_name_chars_strict): /soc/pin-controller/usbotg_fs@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/usbotg_fs@1: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/usbotg_hs@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /gpio_keys: Character '_' not recommended in node name
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller/usart1@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usart3@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_fs@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_fs@1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg_hs@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/mii@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/adc@200: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/pwm@1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/pwm@3: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/i2c1@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/ltdc@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/dcmi@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /gpio_keys/button@0: node has a unit name, but no reg property
> Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> Change since v1:
>         - update nodes name as following: <node_name>@0 to <node_name>-0
>
>
>  arch/arm/boot/dts/stm32429i-eval.dts     | 11 +++--
>  arch/arm/boot/dts/stm32f4-pinctrl.dtsi   | 30 ++++++-------
>  arch/arm/boot/dts/stm32f429-disco.dts    |  7 ++-
>  arch/arm/boot/dts/stm32f429-pinctrl.dtsi | 74 +++++++++++++++----------------
>  arch/arm/boot/dts/stm32f429.dtsi         |  8 ++--
>  arch/arm/boot/dts/stm32f469-disco.dts    | 11 +++--
>  arch/arm/boot/dts/stm32f469-pinctrl.dtsi | 76 +++++++++++++++-----------------
>  7 files changed, 102 insertions(+), 115 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 7eb786a2d624..116232b589e4 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -60,7 +60,7 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> -       memory {
> +       memory@0 {
>                 reg = <0x00000000 0x2000000>;
>         };
>
> @@ -111,17 +111,16 @@
>                 };
>         };
>
> -       gpio_keys {
> +       gpio-keys {
>                 compatible = "gpio-keys";
> -               #address-cells = <1>;
>                 #size-cells = <0>;

Think you forgot this line.

>                 autorepeat;
> -               button@0 {
> +               button-0 {
>                         label = "Wake up";
>                         linux,code = <KEY_WAKEUP>;
>                         gpios = <&gpioa 0 0>;
>                 };
> -               button@1 {
> +               button-1 {
>                         label = "Tamper";
>                         linux,code = <KEY_RESTART>;
>                         gpios = <&gpioc 13 0>;
> @@ -145,7 +144,7 @@
>                 };
>         };
>
> -       mmc_vcard: mmc_vcard {
> +       mmc_vcard: mmc-vcard {
>                 compatible = "regulator-fixed";
>                 regulator-name = "mmc_vcard";
>                 regulator-min-microvolt = <3300000>;
> diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> index 35202896c093..244c7ab8c76d 100644
> --- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> @@ -45,7 +45,7 @@
>
>  / {
>         soc {
> -               pinctrl: pin-controller {
> +               pinctrl: pin-controller@40020000 {

pinctrl is the documented node name, not pin-controller.

>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         ranges = <0 0x40020000 0x3000>;
> @@ -163,7 +163,7 @@
>                                 st,bank-name = "GPIOK";
>                         };
>
> -                       usart1_pins_a: usart1@0 {
> +                       usart1_pins_a: usart1-0 {

What's wrong with just "usart1"?

I think I would like to see "-pins" appended to the node names.

>                                 pins1 {
>                                         pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>                                         bias-disable;
> @@ -176,7 +176,7 @@
>                                 };
>                         };
>
> -                       usart3_pins_a: usart3@0 {
> +                       usart3_pins_a: usart3-0 {
>                                 pins1 {
>                                         pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
>                                         bias-disable;
> @@ -189,7 +189,7 @@
>                                 };
>                         };
>
> -                       usbotg_fs_pins_a: usbotg_fs@0 {
> +                       usbotg_fs_pins_a: usbotg-fs-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
>                                                  <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
> @@ -200,7 +200,7 @@
>                                 };
>                         };
>
> -                       usbotg_fs_pins_b: usbotg_fs@1 {
> +                       usbotg_fs_pins_b: usbotg-fs-1 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('B', 12, AF12)>, /* OTG_HS_ID */
>                                                  <STM32_PINMUX('B', 14, AF12)>, /* OTG_HS_DM */
> @@ -211,7 +211,7 @@
>                                 };
>                         };
>
> -                       usbotg_hs_pins_a: usbotg_hs@0 {
> +                       usbotg_hs_pins_a: usbotg-hs-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT*/
>                                                  <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -231,7 +231,7 @@
>                                 };
>                         };
>
> -                       ethernet_mii: mii@0 {
> +                       ethernet_mii: mii-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH_MII_TXD0_ETH_RMII_TXD0 */
>                                                  <STM32_PINMUX('G', 14, AF11)>, /* ETH_MII_TXD1_ETH_RMII_TXD1 */
> @@ -251,13 +251,13 @@
>                                 };
>                         };
>
> -                       adc3_in8_pin: adc@200 {
> +                       adc3_in8_pin: adc-0 {
>                                 pins {
>                                         pinmux = <STM32_PINMUX('F', 10, ANALOG)>;
>                                 };
>                         };
>
> -                       pwm1_pins: pwm@1 {
> +                       pwm1_pins: pwm-1 {

You have a mixture of the number suffix being a pin mode # and block
instance #. pwm1 or pwm1-pins?

Similar comments on the rest.

Rob
