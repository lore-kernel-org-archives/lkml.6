Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757413AbeD0LUH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:20:07 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:13988 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeD0LUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:20:02 -0400
Subject: Re: [PATCH v3 04/15] ARM: dts: dra74x-mmc-iodelay: Add a new pinctrl
 group for clk line without pullup
To: Tony Lindgren <tony@atomide.com>
References: <20180425125449.19755-1-kishon@ti.com>
 <20180425125449.19755-5-kishon@ti.com> <20180425133529.GU5671@atomide.com>
CC: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <859a6ba4-3dd7-2507-d536-e6b559372f32@ti.com>
Date: Fri, 27 Apr 2018 16:49:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180425133529.GU5671@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wednesday 25 April 2018 07:05 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [180425 12:57]:
>> --- a/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
>> +++ b/arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
>> @@ -49,6 +49,17 @@
>>  		>;
>>  	};
>>  
>> +	mmc1_pins_default_no_clk_pu: mmc1_pins_default_no_clk_pu {
>> +		pinctrl-single,pins = <
>> +			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLDOWN | MUX_MODE0) /* mmc1_clk.clk */
>> +			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
>> +			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
>> +			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
>> +			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
>> +			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
>> +		>;
>> +	};
>> +
>>  	mmc1_pins_sdr12: mmc1_pins_sdr12 {
>>  		pinctrl-single,pins = <
>>  			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc1_clk.clk */
>> -- 
> 
> If this data is the same for all of them, why don't you add something
> like dra7-iodelay.dtsi that can be included as needed?

okay, I'll add dra7-mmc-iodelay.dtsi and send a new revision.

Thanks
Kishon
