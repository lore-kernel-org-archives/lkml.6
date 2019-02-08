Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E1BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C762084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuSo33ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBHQpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:45:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36826 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:45:14 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so10422677itj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeEHovmgDGSlo7V67n/82RvyDVEZ6zBna+m70ZH1cIE=;
        b=DuSo33ikESVvKcbUejA2PGYecGWNPux7vQRNWJwmgEgF0Tg++rxsyu9HAC0VblA/Kf
         IGEv8u8gTzvmwKGIqn4qmB/ZTgTh0jSR0hiQJDi5yGEXtMJ2/fk2NwQElD6OhAZOcRUJ
         5YwpaO8b29ChbLtBH/S38kri9tJ79rY1eJc5zfS1qV7uIY4exig/lvORgpLOVNtGfiBj
         8jxEnuHK1dwRZ1xT7YQrV1frhImEI+g0MaFge84stgJrZJ5SfZ3E9u+q+RUVqEVVdidm
         CjwuL/N3YFLt2oQuYardL2bSYxxhx6CXRdeAjJhwTjwaP3dmfHOuUXv2qmnVvPzqW8bC
         oRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeEHovmgDGSlo7V67n/82RvyDVEZ6zBna+m70ZH1cIE=;
        b=ka01VMgLM4HP0bli94+SvVYJXq0btIiBG58NQEuL2ocz+mynUFEW7FBL6zurS9dY6k
         uIo7fPXx619OoGGfN5LUMNdNahsCJuFVCAR2L9WWTMR0TWpsWZu1RxkB1y89WuP7hJDA
         B6zhb5PlZK0ykCKmWHqVDc7207Q4skFQ2EaOwvTwhvlbRvX6ApBrEjT9KGLrC6QspThi
         MnQoNtYmNvsMhJ7ITKOdBgP5QRL4UkoMwBgq83v6igDJ+Io8CdbUUMtXLRrmN03FZOlg
         TtlVPajwa2Xl6GeseCyn7Hk7MjtT3VPk/d6NUCIVzTLLoufXPWvPSSJm0kzbsieMCFd8
         YXdg==
X-Gm-Message-State: AHQUAubeZJ8TPabqXg5y9UKkBzX2ojfUs8xZ4obP3yiWpoWi1kzb/kdX
        yQu/BwIGfMjUKGDdcHTagoBwu4785RgXikg+Q/w=
X-Google-Smtp-Source: AHgI3IYZhGLS4MlKZGKQ44Bgb7+nS2f8kIAqfCnIGD0L/5Hm7cYvMxU0kST0UpyW2xNMt8vdkSoCiZFkN6Dabuwp4OY=
X-Received: by 2002:a24:100d:: with SMTP id 13mr8448922ity.58.1549644312961;
 Fri, 08 Feb 2019 08:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Fri, 8 Feb 2019 16:45:01 +0000
Message-ID: <CALeDE9MNa+CDJR8bvS05f2UTKrhwMRo8jzdS5o8Ndu7H8V8Ldg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        tom@vamrs.com, dev@vamrs.com, linux-kernel@vger.kernel.org,
        mani@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On Thu, Feb 7, 2019 at 5:54 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
> on AP6356S and Ficus based on AP6354 wireless modules.
>
> Firmwares for the respective boards are available here:
>
> http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
> http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

There's some warnings on building these I noticed in testing this on Fedora:

  DTC     arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
(reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
(4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (i2c_bus_reg):
Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (spi_bus_reg):
Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#address-cells value
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#size-cells value

  DTC     arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
(reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
(4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
(pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
(i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
(spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#address-cells value
arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
(avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
#size-cells value

> ---
>  .../boot/dts/rockchip/rk3399-rock960.dtsi     | 96 ++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index 56abbb08c133..1b2f7cd82244 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -9,6 +9,15 @@
>  #include "rk3399-opp.dtsi"
>
>  / {
> +       sdio_pwrseq: sdio-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               clocks = <&rk808 1>;
> +               clock-names = "ext_clock";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wifi_enable_h>;
> +               reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> +       };
> +
>         vcc1v8_s0: vcc1v8-s0 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "vcc1v8_s0";
> @@ -362,6 +371,20 @@
>  };
>
>  &pinctrl {
> +       bt {
> +               bt_enable_h: bt-enable-h {
> +                       rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               bt_host_wake_l: bt-host-wake-l {
> +                       rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +
> +               bt_wake_l: bt-wake-l {
> +                       rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
>         sdmmc {
>                 sdmmc_bus1: sdmmc-bus1 {
>                         rockchip,pins =
> @@ -387,6 +410,26 @@
>                 };
>         };
>
> +       sdio0 {
> +               sdio0_bus4: sdio0-bus4 {
> +                       rockchip,pins =
> +                               <2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
> +                               <2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
> +                               <2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
> +                               <2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
> +               };
> +
> +               sdio0_cmd: sdio0-cmd {
> +                       rockchip,pins =
> +                               <2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
> +               };
> +
> +               sdio0_clk: sdio0-clk {
> +                       rockchip,pins =
> +                               <2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
> +               };
> +       };
> +
>         pmic {
>                 pmic_int_l: pmic-int-l {
>                         rockchip,pins =
> @@ -403,6 +446,19 @@
>                                 <1 14 RK_FUNC_GPIO &pcfg_pull_down>;
>                 };
>         };
> +
> +       sdio-pwrseq {
> +               wifi_enable_h: wifi-enable-h {
> +                       rockchip,pins =
> +                               <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       wifi {
> +               wifi_host_wake_l: wifi-host-wake-l {
> +                       rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> +               };
> +       };
>  };
>
>  &pwm2 {
> @@ -413,6 +469,33 @@
>         status = "okay";
>  };
>
> +&sdio0 {
> +       clock-frequency = <50000000>;
> +       bus-width = <4>;
> +       cap-sdio-irq;
> +       cap-sd-highspeed;
> +       no-emmc;
> +       keep-power-in-suspend;
> +       mmc-pwrseq = <&sdio_pwrseq>;
> +       non-removable;
> +       num-slots = <1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> +       sd-uhs-sdr104;
> +
> +       status = "okay";
> +
> +       brcmf: wifi@1 {
> +               compatible = "brcm,bcm4329-fmac";
> +               reg = <1>;
> +               interrupt-parent = <&gpio0>;
> +               interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> +               interrupt-names = "host-wake";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wifi_host_wake_l>;
> +       };
> +};
> +
>  &sdhci {
>         bus-width = <8>;
>         mmc-hs400-1_8v;
> @@ -439,8 +522,19 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_xfer &uart0_cts>;
> +       pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
>         status = "okay";
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43438-bt";
> +               clocks = <&rk808 1>;
> +               clock-names = "ext_clock";
> +               device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> +               host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> +               shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> +       };
>  };
>
>  &uart2 {
> --
> 2.17.1
>
