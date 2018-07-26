Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE2CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA3120846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA3120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeGZLHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:07:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeGZLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:07:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6AC802608C5
Subject: Re: [PATCH v1] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
To:     djw@t-chip.com.cn, linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Brian Norris <briannorris@chromium.org>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d84ef7a6-8db0-ff71-8e11-a5f56c70d60d@collabora.com>
Date:   Thu, 26 Jul 2018 11:51:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Some few comments.

On 26/07/18 09:13, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
> computer with USB 3.0 and Gigabit Ethernet in a form factor
> compatible with the Raspberry Pi. It is based on the Rockchip
> RK3399 SoC, powered by the Type-C port.
> 
> The devicetree currently supports peripherals of:
> 
> - Ethernet
> - HDMI
> - SD Card
> - UART2 debug
> - TYPE-C
> - eMMC
> 
> USB3 in type-c port currently only works with normal orientation,
> not flip one.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> 
> ---
> 
> Changes in v1:
> - remove bootargs
> - use interpolation for brightness level
> - add vcc_vbus_typec1 regulator
> - fix phy-supply of u2phy0_otg and u2phy1_otg
> - remove vcc_hub_en dummy regualtor
> - add hub_rst (changed to output high) to pinctrl status of vcc5v0_host
> - remove vsel-gpios props in fan53xx
> - remove mp8859 in i2c
> - fusb302: fix interrupt setting
> - fusb302: add vbus-supply
> - remove extcon in tcphy0 and tcphy1
> - remove #sound-dai-cells in i2s*
> - use RK_PXX style bit number for cd-gpios in SDMMC
> - clean commented status lines
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts     | 687 +++++++++++++++++++++
>  3 files changed, 692 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index acfd3c7..ab5fde8 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -59,6 +59,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "firefly,roc-rk3328-cc", "rockchip,rk3328";
>  
> +- Firefly ROC-RK3399-PC board:
> +    Required root node properties:
> +      - compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> +
>  - ChipSPARK PopMetal-RK3288 board:
>      Required root node properties:
>        - compatible = "chipspark,popmetal-rk3288", "rockchip,rk3288";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b0092d9..06028db 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> new file mode 100644
> index 0000000..7d41a91
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -0,0 +1,687 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2017 T-Chip Intelligent Technology Co., Ltd
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/pwm/pwm.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-opp.dtsi"
> +
> +/ {
> +	model = "Firefly ROC-RK3399-PC Board";
> +	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 25000 0>;
> +
> +		brightness-levels = <0 255>;
> +		default-brightness-level = <200>;
> +		num-interpolated-steps = <1>;

Unless you want a custom brightness-levels for some reason and because of
default brightness table does not work for you I'd remove all these three
properties and just use the default table.

After commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
linearly to human eye") the pwm_bl driver is able to calculate a default
brightness table. The calculated table for this PWM will have more
granularity and will be adjusted to change the brightness linearly to
the human eye. So I think you can use that table instead of have a DT-defined
table with less granularity.

> +	};
> +
> +	clkin_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "clkin_gmac";
> +		#clock-cells = <0>;
> +	};

<snip>

> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host1_ohci {
> +	status = "okay";
> +};
> +
> +&usbdrd3_0 {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +	status = "okay";
> +	dr_mode = "otg";

dr_mode is already set in rk3399.dtsi so you can remove that from here.

> +};
> +
> +&usbdrd3_1 {
> +	status = "okay";
> +};
> +
> +&usbdrd_dwc3_1 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&vopb {
> +	status = "okay";
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&vopl {
> +	status = "okay";
> +};
> +
> +&vopl_mmu {
> +	status = "okay";
> +};
> 

Best regards,
 Enric
