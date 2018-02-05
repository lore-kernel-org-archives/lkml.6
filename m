Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeBEHQA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:16:00 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:47197 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750935AbeBEHPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:15:55 -0500
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Rob Herring <robh@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>,
        Olivier BIDEAU <olivier.bideau@st.com>
Subject: Re: [PATCH 01/14] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
Thread-Topic: [PATCH 01/14] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
Thread-Index: AQHTnC6xOopTFeaJM06WENWOkBZn+aOVRqYAgAASaoA=
Date: Mon, 5 Feb 2018 07:15:28 +0000
Message-ID: <1f0de7b8-6607-e0f0-0f77-59be53328f7a@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-2-git-send-email-gabriel.fernandez@st.com>
 <20180205042238.64xjrrguls2drtrg@rob-hp-laptop>
In-Reply-To: <20180205042238.64xjrrguls2drtrg@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BE1487968192A4D9D3030A7354312A9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w157G8S7005033



On 02/05/2018 07:09 AM, Rob Herring wrote:
> On Fri, Feb 02, 2018 at 03:03:29PM +0100, gabriel.fernandez@st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> The RCC block is responsible of the management of the clock and reset
>> generation for the complete circuit.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   .../devicetree/bindings/mfd/st,stm32-rcc.txt       | 85 ++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>> new file mode 100644
>> index 0000000..28017a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>> @@ -0,0 +1,85 @@
>> +STMicroelectronics STM32 Peripheral Reset Clock Controller
>> +==========================================================
>> +
>> +The RCC IP is both a reset and a clock controller.
>> +
>> +Please also refer to reset.txt for common reset controller binding usage.
>> +
>> +Please also refer to clock-bindings.txt for common clock controller
>> +binding usage.
>> +
>> +
>> +Required properties:
>> +- compatible: "simple-mfd", "syscon"
>
>> +- reg: should be register base and length as documented in the datasheet
>> +
>> +- Sub-nodes:
>> +  - compatible: "st,stm32mp1-rcc-clk"
>> +	- #clock-cells: 1, device nodes should specify the clock in their
>> +	  "clocks" property, containing a phandle to the clock device node,
>> +	  an index specifying the clock to use.
>> +
>> +  - compatible: "st,stm32mp1-rcc-rst"
>> +	- #reset-cells: Shall be 1
>> +
>> +Example:
>> +	rcc: rcc@50000000 {
>> +		compatible = "syscon", "simple-mfd";
>> +		reg = <0x50000000 0x1000>;
>> +
>> +		rcc_clk: rcc-clk@50000000 {
>> +			#clock-cells = <1>;
>> +			compatible = "st,stm32mp1-rcc-clk";
>> +		};
>> +
>> +		rcc_rst: rcc-reset@50000000 {
> You should not have the same unit-address twice.
i can change if you want into:

         rcc: rcc@50000000 {
             compatible = "syscon", "simple-mfd";

             reg = <0x50000000 0x1000>;

             rcc_clk: rcc-clk {
                 #clock-cells = <1>;
                 compatible = "st,stm32mp1-rcc-clk";
             };

             rcc_rst: rcc-reset {
                 #reset-cells = <1>;
                 compatible = "st,stm32mp1-rcc-rst";
             };
BR
Gabriel

> IMO, this should just be:
>
> 	rcc: rcc@50000000 {
> 		compatible = "st-stm32mp1-rcc";
> 		reg = <0x50000000 0x1000>;
> 		#clock-cells = <1>;
> 		#reset-cells = <1>;
> 	};
>
> There's no reason a node can't provide more than 1 function.
>
>
>> +			#reset-cells = <1>;
>> +			compatible = "st,stm32mp1-rcc-rst";
>> +		};
>> +	};
>> +
>> +Specifying clocks
>> +=================
>> +
>> +All available clocks are defined as preprocessor macros in
>> +dt-bindings/clock/stm32mp1-clks.h header and can be used in device
>> +tree sources.
>> +
>> +Example:
>> +
>> +	/* Accessing DMA1 clock */
>> +	... {
>> +		clocks = <&rcc_clk DMA1>
>> +	};
>> +
>> +	/* Accessing SPI6 kernel clock */
>> +	... {
>> +		clocks = <&rcc_clk SPI6_K>
>> +	};
> Other than the path to header, the clock binding explains all this. No
> need to duplicate here.
>
>> +
>> +Specifying softreset control of devices
>> +=======================================
>> +
>> +Device nodes should specify the reset channel required in their "resets"
>> +property, containing a phandle to the reset device node and an index specifying
>> +which channel to use.
>> +The index is the bit number within the RCC registers bank, starting from RCC
>> +base address.
>> +It is calculated as: index = register_offset / 4 * 32 + bit_offset.
>> +Where bit_offset is the bit offset within the register.
>> +
>> +For example on STM32MP1, for LTDC reset:
>> + ltdc = APB4_RSTSETR_offset / 4 * 32 + LTDC_bit_offset
>> +      = 0x180 / 4 * 32 + 0 = 3072
>> +
>> +The list of valid indices for STM32MP1 is available in:
>> +include/dt-bindings/reset-controller/stm32mp1-resets.h
>> +
>> +This file implements defines like:
>> +#define LTDC_R	3072
>> +
>> +example:
>> +
>> +	ltdc {
>> +		resets = <&rcc_rst LTDC_R>;
>> +	};
>> -- 
>> 1.9.1
>>
