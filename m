Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6AEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B9206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UOV2p7Mi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbfAPKyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:54:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43078 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfAPKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:54:46 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GAsiMw031448;
        Wed, 16 Jan 2019 04:54:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547636084;
        bh=xl+k7pJruERRlTwVkasOLoTeza4rWwaYN/sZWVuQyFE=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=UOV2p7Mi8AveFZ95GiPx6sDVKj2mQpvzj5+eC1JdJIitjN0Fh3L94flGkEy7fpvLt
         UbvrIJ0+7aab6VO1VZw1DhnZ/AD9uxGTfodGStTjBWiro5ZzN6DqqY87z0146Trqrn
         qqs/tF4kCelHeFEpl1jcSpbxz15r+RngC5VIcjdg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GAshl3042823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 04:54:43 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 04:54:43 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 04:54:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GAsfve007696;
        Wed, 16 Jan 2019 04:54:41 -0600
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-am6: add USB support
To:     Nishanth Menon <nm@ti.com>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
 <1547200861-17795-3-git-send-email-rogerq@ti.com>
 <20190115143641.m2cvwljr7rbtayi2@kahuna>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C3F0D70.4050903@ti.com>
Date:   Wed, 16 Jan 2019 12:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190115143641.m2cvwljr7rbtayi2@kahuna>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/19 16:36, Nishanth Menon wrote:
> On 12:01-20190111, Roger Quadros wrote:
>> Adds support for USB0 and USB1 instances on the AM6 SoC.
>> USB0 is limited to high-speed for now.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 80 ++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 8b55108..680cbc7 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -199,4 +199,84 @@
>>  		#size-cells = <1>;
>>  		ranges = <0x0 0x0 0x00100000 0x1c000>;
>>  	};
>> +
>> +	dwc3_0: dwc3@4000000 {
>> +		compatible = "ti,am654-dwc3";
>> +		reg = <0x0 0x4000000 0x0 0x4000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x4000000 0x20000>;
>> +		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>> +		dma-coherent;
>> +		status = "disabled";
> 
> NAK. -> in ARMV8, we dont do default disabled. Instead, please disable
> nodes in the board dts or overlay as necessary.

got it.

> 
>> +		power-domains = <&k3_pds 151>;
>> +		assigned-clocks = <&k3_clks 151 2>, <&k3_clks 151 7>;
>> +		assigned-clock-parents = <&k3_clks 151 4>,	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>> +					 <&k3_clks 151 9>;	/* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
>> +
>> +		usb0: usb@10000 {
>> +			compatible = "snps,dwc3";
>> +			reg = <0x10000 0x10000>;
>> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "peripheral",
>> +					  "host",
>> +					  "otg";
>> +			maximum-speed = "high-speed";
>> +			dr_mode = "otg";
>> +			phys = <&usb0_phy>;
>> +			phy-names = "usb2-phy";
>> +			snps,dis_u3_susphy_quirk;
>> +		};
>> +	};
>> +
>> +	usb0_phy: phy@4100000 {
>> +		compatible = "ti,am654-usb2", "ti,omap-usb2";
>> +		reg = <0x0 0x4100000 0x0 0x54>;
>> +		syscon-phy-power = <&scm_conf 0x4000>;
> 
> Just curious, dont we need a power domain as well?

Not for USB2.0 PHYs. Those are part of USB3SSn power domains.

> 
>> +		clocks = <&k3_clks 151 0>, <&k3_clks 151 1>;
>> +		clock-names = "wkupclk", "refclk";
>> +		#phy-cells = <0>;
>> +		status = "disabled";
> 
> same here -> please drop
> 
>> +	};
>> +
>> +	dwc3_1: dwc3@4020000 {
>> +		compatible = "ti,am654-dwc3";
>> +		reg = <0x0 0x4020000 0x0 0x4000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x4020000 0x20000>;
>> +		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
>> +		dma-coherent;
>> +		status = "disabled";
> 
> same here -> please drop
> 
>> +		power-domains = <&k3_pds 152>;
>> +		assigned-clocks = <&k3_clks 152 2>;
>> +		assigned-clock-parents = <&k3_clks 152 4>;	/* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>> +
>> +		usb1: usb@10000 {
>> +			compatible = "snps,dwc3";
>> +			reg = <0x10000 0x10000>;
>> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "peripheral",
>> +					  "host",
>> +					  "otg";
>> +			maximum-speed = "high-speed";
>> +			dr_mode = "otg";
>> +			phys = <&usb1_phy>;
>> +			phy-names = "usb2-phy";
>> +		};
>> +	};
>> +
>> +	usb1_phy: phy@4110000 {
>> +		compatible = "ti,am654-usb2", "ti,omap-usb2";
>> +		reg = <0x0 0x4110000 0x0 0x54>;
>> +		syscon-phy-power = <&scm_conf 0x4020>;
> 
> Same question on power domain..
> 
>> +		clocks = <&k3_clks 152 0>, <&k3_clks 152 1>;
>> +		clock-names = "wkupclk", "refclk";
>> +		#phy-cells = <0>;
>> +		status = "disabled";
> 
> same here -> please drop
> 
>> +	};
>>  };
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
> 

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
