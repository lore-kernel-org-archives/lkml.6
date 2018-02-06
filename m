Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBFCoN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:44:13 -0500
Received: from hermes.aosc.io ([199.195.250.187]:47444 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbeBFCoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:44:07 -0500
Date: Tue, 06 Feb 2018 10:43:48 +0800
In-Reply-To: <20180202194935.vdqkgch6mowqi2px@flea.lan>
References: <20180202140153.21549-1-icenowy@aosc.io> <20180202140153.21549-3-icenowy@aosc.io> <20180202194935.vdqkgch6mowqi2px@flea.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: add audio codec support into V3s DTSI
To: Maxime Ripard <maxime.ripard@bootlin.com>
CC: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <8F4EA09E-F5DC-4F7A-951B-25DA36848FD1@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年2月3日 GMT+08:00 上午3:49:35, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Fri, Feb 02, 2018 at 10:01:52PM +0800, Icenowy Zheng wrote:
>> Allwinner V3s SoC features an internal audio codec like the one in
>H3,
>> and a analog codec like the one in H3/A23 (but much simpler).
>> 
>> Add them in the DTSI file.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi
>b/arch/arm/boot/dts/sun8i-v3s.dtsi
>> index 20edebd983f0..f6c534efaef9 100644
>> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
>> @@ -354,6 +354,25 @@
>>  			status = "disabled";
>>  		};
>>  
>> +		codec: codec@01c22c00 {
>> +			#sound-dai-cells = <0>;
>> +			compatible = "allwinner,sun8i-v3s-codec";
>> +			reg = <0x01c22c00 0x400>;
>> +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
>> +			clock-names = "apb", "codec";
>> +			resets = <&ccu RST_BUS_CODEC>;
>> +			dmas = <&dma 15>, <&dma 15>;
>> +			dma-names = "rx", "tx";
>> +			allwinner,codec-analog-controls = <&codec_analog>;
>> +			status = "disabled";
>> +		};
>> +
>> +		codec_analog: codec-analog@01c23000 {
>> +			compatible = "allwinner,sun8i-v3s-codec-analog";
>> +			reg = <0x01c23000 0x4>;
>
>This should be the whole size of the memory region.

OK. (Although on the datasheet digital part and analog
part is listed as one region.)

>
>Maxime
