Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeBSQAC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:00:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53565 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753106AbeBSP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:59:59 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Rob Herring <robh@kernel.org>
CC: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander
 driver
Thread-Topic: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander
 driver
Thread-Index: AQHToOkB1gg/oaB2TkqIj2Qyt+f60KOqy04AgAEXWgA=
Date: Mon, 19 Feb 2018 15:59:28 +0000
Message-ID: <b08ab2cd-d6a0-b5da-e33e-ad150370776b@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
 <20180218231938.goeht7tomfkab6uu@rob-hp-laptop>
In-Reply-To: <20180218231938.goeht7tomfkab6uu@rob-hp-laptop>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3744D2F3081EE41A9F5B31F9EB20487@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1JG06pe013447



On 02/19/2018 12:19 AM, Rob Herring wrote:
> On Thu, Feb 08, 2018 at 03:27:32PM +0100, Amelie Delaunay wrote:
>> This patch adds documentation of device tree bindings for the
>> STMicroelectronics Multi-Function eXpander (MFX).
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/st-mfx.txt | 51 ++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/st-mfx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/st-mfx.txt b/Documentation/devicetree/bindings/mfd/st-mfx.txt
>> new file mode 100644
>> index 0000000..423d800
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/st-mfx.txt
>> @@ -0,0 +1,51 @@
>> +STMicroelectronics Multi-Function eXpander
>> +
>> +ST Multi-Function eXpander (MFX) is a slave controller using I2C for
>> +communication with the main MCU. Its main features are gpio expansion, main
>> +MCU IDD measurement (IDD is the amount of current that flows through VDD)
>> +and resistive touchscreen controller.
> 
> You don't have to implement all the drivers now, but please completely
> describe the device. As is, there is no reason to have a child GPIO
> node.
>
The MFD driver will be abandoned as only GPIO part is used. I'll send a 
V2 soon.
>> +
>> +Required properties:
>> +- compatible: must be "st,mfx"
> 
> Kind of generic. Only 1 single version ever?
> 
"st-mfx" compatible will disappear in V2 (we keep only GPIO driver). MFX 
version can be read in MFX FW_VERSION register. So do I keep 
"st,mfx-gpio" compatible or you want to see mfx version ?

>> +- reg: I2C address of the device
>> +- interrupts: interrupt triggered by MFX_IRQ_OUT signal
>> +- interrupt-parent: interrupt controller MFX is connected to
>> +- interrupt-controller: marks the device as an interrupt controller
>> +- #interrupt-cells: should be <1>, index of the interrupt within the
>> +  controller, in accordance with the "one cell" variant of
>> +  <devicetree/bindings/interrupt-controller/interrupt.txt>
>> +
>> +Optional nodes:
>> +
>> +* GPIO eXpander
>> +MFX provides 16 programmable GPIOs, and it is also possible to recover 8
>> +alternate GPIOs if the main functions are not used (touchscreen controller and
>> +IDD measurement not enabled).
>> +
>> +Required properties:
>> +- compatible : must be "st,mfx-gpio"
>> +- interrupt-parent : must be <&mfx>
> 
> Not necessary. A parent node with 'interrupt-controller' property is the
> interrupt's parent.
> 
I will keep it in mind.
>> +- interrupts = must be <0>
>> +- gpio-controller: marks the device node as a GPIO controller
>> +- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
>> +  controller, the second cell is the gpio flags in accordance with
>> +  <dt-bindings/gpio/st-mfx-gpio.h>.
> 
> Custom flags? Use standard flags.
> 
> DT binding headers should be part of this patch.
> 
Custom flags because MFX GPIOs have several types:
- Output open drain with internal pull-up resistor
- Output open drain without internal pull-up resistor
- Output push pull without internal pull resistor
- Input with internal pull-up resistor
- Input with internal pull-down resistor
- Input floating
- Input analog.
Standard flags don't have pull up or down information. That's why I am 
using custom flags, they overloads standard flags.
I will add DT bindings header in this patch V2.
>> +
>> +Example:
>> +
>> +	mfx: mfx@42 {
>> +		compatible = "st,mfx";
>> +		reg = <0x42>;
>> +		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
>> +		interrupt-parent = <&gpioi>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +
>> +		mfxgpio: mfx_gpio {
> 
> gpio {
> 
OK. Will change it in V2.

Thanks,
Amelie
>> +			compatible = "st,mfx-gpio";
>> +			interrupt-parent = <&mfx>;
>> +			interrupts = <0>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
