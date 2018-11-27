Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA85C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B62208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B62208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeK0LtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:49:10 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:48530 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeK0LtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:49:10 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 06:48:10 EST
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6BAAA99D;
        Tue, 27 Nov 2018 08:45:15 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id BF0A9460;
        Tue, 27 Nov 2018 08:45:13 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <64b93e9ecf14c125b0df44361d1d40fc>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 33167IKKQOA;
        Tue, 27 Nov 2018 08:45:14 +0800 (CST)
Cc:     Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: Add DT for nanopc-t4
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20181123073120.6250-1-tomeu.vizoso@collabora.com>
 <20181126145107.38222-1-tomeu.vizoso@collabora.com>
 <26178858.xdqtN7Rtck@phil>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e9ee8167-c398-c14e-d798-3b4233ba2ff2@rock-chips.com>
Date:   Tue, 27 Nov 2018 08:45:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <26178858.xdqtN7Rtck@phil>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/27 7:48, Heiko Stuebner wrote:
> Hi Tomeu,
> 
> Am Montag, 26. November 2018, 15:47:49 CET schrieb Tomeu Vizoso:
>> This adds a device tree for the NanoPC-T4 SBC, which is based on the
>> Rockchip RK3399 SoC and marketed by FriendlyELEC.
>>
>> Known working:
>>
>> - Serial
>> - Ethernet
>> - HDMI
>> - USB 2.0
>>
>> All of the interesting stuff is in a .dtsi because there are at least
>> two other boards that share most of it: NanoPi M4 and NanoPi NEO4.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> looks pretty good overall, just some more small-scale things
> below.
> 
>> ---
>>
>> v2: - Rename compatible from friendlyelec to friendlyarm, to match
>>        existing bindings
>>      - Remove superfluous node spi1
>>
>> v3: - Rewrite regulator tree to match the schematics (Heiko)
>>      - Sort top-level nodes alphabetically (Heiko)
>>      - Used defines for GPIO numbers (Heiko)
>>      - Enabled rga (Heiko)
>>      - Removed cdn_dp node (Heiko)
>>      - Removed dependencies to fusb0 as extcon (Heiko)
>>      - Removed superfluous properties (Heiko)
> 
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index 49042c477870..4cbd2c461052 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-evb-act8846.dtb
> 
> These are definitly sorted in the Makefile, so this should move between
> rk3399-gru-scarlet-kd.dtb and rk3399-puma-haikou.dtb :-)
> 
> 
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> new file mode 100644
>> index 000000000000..f102ff2317c3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> @@ -0,0 +1,740 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * RK3399-based FriendlyElec boards device tree source
>> + *
>> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * Copyright (c) 2018 FriendlyElec Computer Tech. Co., Ltd.
>> + * (http://www.friendlyarm.com)
>> + *
>> + * Copyright (c) 2018 Collabora Ltd.
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include "rk3399.dtsi"
>> +#include "rk3399-opp.dtsi"
>> +
>> +/ {
>> +	chosen {
>> +		stdout-path = "serial2:1500000n8";
>> +	};
>> +
>> +	clkin_gmac: external-gmac-clock {
>> +		compatible = "fixed-clock";
>> +		clock-frequency = <125000000>;
>> +		clock-output-names = "clkin_gmac";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	vdd_5v: vdd_5v {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_5v";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vcc5v0_core: vcc5v0_core {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_core";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		vin-supply = <&vdd_5v>;
>> +	};
>> +
>> +	vcc3v3_sys: vcc3v3_sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&vcc5v0_core>;
>> +	};
>> +
>> +	vcc5v0_sys: vcc5v0_sys {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&vdd_5v>;
>> +	};
>> +
>> +	vcc5v0_usb1: vcc5v0_usb1 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_usb1";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		vin-supply = <&vcc5v0_sys>;
>> +	};
>> +
>> +	vcc5v0_usb2: vcc5v0_usb2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc5v0_usb2";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		vin-supply = <&vcc5v0_sys>;
>> +	};
>> +
>> +	/* switched by pmic_sleep */
>> +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc1v8_s3";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		vin-supply = <&vcc_1v8>;
>> +	};
>> +
>> +	vcc3v0_sd: vcc3v0_sd {
> 
> dt-spec mandates node names with "-", so this should become
> 	vcc3v0_sd: vcc3v0-sd {
> 
> Same for most regulators above.
> 
>> +	rk808: pmic@1b {
>> +		compatible = "rockchip,rk808";
>> +		reg = <0x1b>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pmic_int_l>;
>> +		rockchip,system-power-controller;
>> +		wakeup-source;
>> +		#clock-cells = <1>;
>> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> 
> rename rk808-clkout1 to xin32k so that it hooks correctly into
> the rk3399 clock controller, as that signals is providing the 32kHz clock
> for the system. (see $debug/clk/clk_summary and rk3399-cru dt binding)
> 
> 
>> +&pinctrl {
>> +
> 
> unnecessary empty line
> 
>> +	pmic {
> 
> 
>> +&rga {
>> +	status = "okay";
>> +};
> 
> rga is not dependant on pinout, so is always enabled in rk3399.dtsi
> So this node can go away.
> 
>> +&sdhci {
>> +	bus-width = <8>;
>> +	mmc-hs400-1_8v;
>> +	supports-emmc;
> 
> remnant from the vendor-kernel?
> Should also go away.
> 
>> +	non-removable;
>> +	keep-power-in-suspend;

keep-power-in-suspend is for SDIO only.
Please remove this.

>> +	mmc-hs400-enhanced-strobe;
>> +	status = "okay";
>> +};
>> +
> 
>> +&usbdrd3_0 {
>> +	status = "okay";
>> +	extcon = <&fusb0>;
> 
> I still don't think that extcon gets defined at all and is also
> not specified in any dwc3 binding, so should probably go away.
> 
> 
> Heiko
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 

