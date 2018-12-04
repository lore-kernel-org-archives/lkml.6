Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719B8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9B20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB9B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeLDMpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:45:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:53750 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbeLDMpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:45:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 04:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="126960776"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 04 Dec 2018 04:45:09 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 04 Dec 2018 14:45:08 +0200
Date:   Tue, 4 Dec 2018 14:45:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        John Stultz <john.stultz@linaro.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v1 12/12] dts: hi3660: Add support for usb on Hikey960
Message-ID: <20181204124508.GB10657@kuha.fi.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-13-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203034515.91412-13-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:45:15AM +0800, Yu Chen wrote:
> This patch adds support for usb on Hikey960.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 56 ++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 72 +++++++++++++++++++++++
>  2 files changed, 128 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c98bcbc8dfba..066c558154ea 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	model = "HiKey960";
> @@ -196,6 +197,28 @@
>  			method = "smc";
>  		};
>  	};
> +
> +	hisi_hikey_usb: hisi_hikey_usb {
> +		compatible = "hisilicon,hikey960_usb";
> +		typec-vbus-gpios = <&gpio25 2 0>;
> +		typc-vbus-enable-val = <1>;
> +		otg-switch-gpios = <&gpio25 6 0>;
> +		hub-vdd33-en-gpios = <&gpio5 6 0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				device_type = "usb-role-switch";
> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +	};
> +
>  };
>  
>  /*
> @@ -526,6 +549,39 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	rt1711h: rt1711h@4e {
> +		compatible = "richtek,rt1711h";
> +		reg = <0x4e>;
> +		status = "ok";
> +		interrupt-parent = <&gpio27>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_cfg_func>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> +				PDO_VAR(5000, 5000, 1000)>;
> +			op-sink-microwatt = <10000000>;
> +		};
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rt1711h_ep: endpoint@0 {
> +				reg = <0>;
> +				device_type = "usb-role-switch";

device_type is deprecated, no?

In any case, I don't think we can use the endpoint subnode for
matching. To play it safe, I think we should use the remote port
parent for matching. See below..

> +				remote-endpoint = <&dwc3_role_switch>;
> +			};
> +		};
> +	};
> +
>  	adv7533: adv7533@39 {
>  		status = "ok";
>  		compatible = "adi,adv7533";
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index f432b0a88c65..e6583bd7efdb 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -349,6 +349,12 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		pmctrl: pmctrl@fff31000 {
> +			compatible = "hisilicon,hi3660-pmctrl", "syscon";
> +			reg = <0x0 0xfff31000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
>  		pmuctrl: crg_ctrl@fff34000 {
>  			compatible = "hisilicon,hi3660-pmuctrl", "syscon";
>  			reg = <0x0 0xfff34000 0x0 0x1000>;
> @@ -1122,5 +1128,71 @@
>  				};
>  			};
>  		};
> +
> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> +			compatible = "syscon";
> +			reg = <0x0 0xff200000 0x0 0x1000>;
> +		};
> +
> +		usb_phy: usb-phy {
> +			compatible = "hisilicon,hi3660-usb-phy";
> +			#phy-cells = <0>;
> +			hisilicon,pericrg-syscon = <&crg_ctrl>;
> +			hisilicon,pctrl-syscon = <&pctrl>;
> +			hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> +			hisilicon,eye-diagram-param = <0x22466e4>;
> +		};
> +
> +		usb3: hisi_dwc3 {
> +			compatible = "hisilicon,hi3660-dwc3";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
> +
> +			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			assigned-clock-rates = <229000000>;
> +			resets = <&crg_rst 0x90 8>,
> +				 <&crg_rst 0x90 7>,
> +				 <&crg_rst 0x90 6>,
> +				 <&crg_rst 0x90 5>;
> +
> +			dwc3: dwc3@ff100000 {
> +				compatible = "snps,dwc3";

Can we use the compatible property?

        compatible = "snps,dwc3", "usb-role-switch"

> +				reg = <0x0 0xff100000 0x0 0x100000>;
> +				interrupts = <0 159 4>, <0 161 4>;
> +				phys = <&usb_phy>;
> +				phy-names = "usb3-phy";
> +				dr_mode = "otg";
> +				maximum-speed = "super-speed";
> +				phy_type = "utmi";
> +				snps,dis-del-phy-power-chg-quirk;
> +				snps,lfps_filter_quirk;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +				snps,tx_de_emphasis_quirk;
> +				snps,tx_de_emphasis = <1>;
> +				snps,dis_enblslpm_quirk;
> +				snps,gctl-reset-quirk;
> +
> +				port {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					dwc3_role_switch: endpoint@0 {
> +						reg = <0>;
> +						remote-endpoint = <&rt1711h_ep>;
> +					};
> +
> +					dwc3_role_switch_notify: endpoint@1 {
> +						reg = <1>;
> +						remote-endpoint = <&hikey_usb_ep>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
> -- 
> 2.15.0-rc2

-- 
heikki
