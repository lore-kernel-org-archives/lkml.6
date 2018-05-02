Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEBLe7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:34:59 -0400
Received: from hermes.aosc.io ([199.195.250.187]:47106 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751377AbeEBLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:34:58 -0400
Date: Wed, 02 May 2018 19:34:21 +0800
In-Reply-To: <20180502113250.5i2eyzv237t5oyl6@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com> <20180430114058.5061-3-jagan@amarulasolutions.com> <20180502113250.5i2eyzv237t5oyl6@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH 02/21] arm64: dts: allwinner: a64: Add DE2 CCU
To: maxime.ripard@bootlin.com, Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>
CC: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <DF02AB5F-D4A5-4198-B455-FEE880CF83CE@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年5月2日 GMT+08:00 下午7:32:50, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Mon, Apr 30, 2018 at 05:10:39PM +0530, Jagan Teki wrote:
>> DE2 in A64 has clock control unit and behavior is
>> same like H3/H5, so reuse the same in A64.
>> 
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index 1b2ef28c42bd..67b80bbe5bf5 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -43,9 +43,11 @@
>>   */
>>  
>>  #include <dt-bindings/clock/sun50i-a64-ccu.h>
>> +#include <dt-bindings/clock/sun8i-de2.h>
>>  #include <dt-bindings/clock/sun8i-r-ccu.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/reset/sun50i-a64-ccu.h>
>> +#include <dt-bindings/reset/sun8i-de2.h>
>>  
>>  / {
>>  	interrupt-parent = <&gic>;
>> @@ -168,6 +170,19 @@
>>  		#size-cells = <1>;
>>  		ranges;
>>  
>> +		display_clocks: clock@1000000 {
>> +			compatible = "allwinner,sun50i-a64-de2-clk",
>> +				     "allwinner,sun50i-h5-de2-clk";
>
>The A64 was released before the H5, so that should be the other way
>around.
>
>> +			reg = <0x01000000 0x100000>;
>> +			clocks = <&ccu CLK_DE>,
>> +				 <&ccu CLK_BUS_DE>;
>> +			clock-names = "mod",
>> +				      "bus";
>> +			resets = <&ccu RST_BUS_DE>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>
>So it turns out we don't need the SRAM to access the CCU driver?

As now U-Boot claims SRAM, people may forget thus :-(

>
>Maxime
