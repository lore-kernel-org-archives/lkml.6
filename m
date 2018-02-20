Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeBTJlj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:41:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13997 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751314AbeBTJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:41:24 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Rob Herring <robh@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
Thread-Topic: [PATCH 1/2] dt-bindings: phy: add support for STM32 USB PHY
 Controller (USBPHYC)
Thread-Index: AQHTo/35DxClXv8/Z02Rq+VIT7B65aOq73gAgAIVkoA=
Date: Tue, 20 Feb 2018 09:40:51 +0000
Message-ID: <05225cb4-6584-a003-380f-bb9ca5f2da85@st.com>
References: <1518438929-5254-1-git-send-email-amelie.delaunay@st.com>
 <1518438929-5254-2-git-send-email-amelie.delaunay@st.com>
 <20180219015108.bxt6qn7tz53ydguv@rob-hp-laptop>
In-Reply-To: <20180219015108.bxt6qn7tz53ydguv@rob-hp-laptop>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B75EC419CE37AE4489CF6546838474EA@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1K9fhbd018373



On 02/19/2018 02:51 AM, Rob Herring wrote:
> On Mon, Feb 12, 2018 at 01:35:28PM +0100, Amelie Delaunay wrote:
>> This patch adds the device tree bindings description for STM32 USBPHYC
>> (USB PHY Controller).
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   .../devicetree/bindings/phy/phy-stm32-usbphyc.txt  | 46 ++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
>> new file mode 100644
>> index 0000000..1e65e0a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.txt
>> @@ -0,0 +1,46 @@
>> +STMicroelectronics STM32 USB HS PHY controller
>> +
>> +The STM32 USBPHYC block contains a dual port High Speed UTMI+ PHY and a UTMI
>> +switch. It controls PHY configuration and status, and the UTMI+ switch that
>> +selects either OTG or HOST controller for the second PHY port. It also sets
>> +PLL configuration.
>> +
>> +USBPHYC
>> +  |_ PLL
>> +  |
>> +  |_ PHY port#1 _________________ HOST controller
>> +  |                                      |
>> +  |_ PHY port#2_______                   |
>> +  |                   |_                 |
>> +  |_ UTMI switch_____/ 1|________________|
>> +                    |   |________________
>> +                     \_0|                |
>> +		                  OTG controller
>> +
>> +Required properties:
>> +- compatible: must be "st,stm32mp1-usbphyc"
>> +- reg: address and length of the usb phy control register set
>> +- clocks: phandle + clock specifier for the PLL phy clock
>> +- phy-supply: from the generic phy bindings, phandle to the regulator
>> +  providing 3V3 power to the PHY, see phy-bindings.txt
>> +- vdda1v1-supply: phandle to the regulator providing 1V1 power to the PHY
>> +- vdda1v8-supply: phandle to the regulator providing 1V8 power to the PHY
>> +
>> +Optional properties:
>> +- assigned-clocks: phandle + clock specifier for the PLL phy clock
>> +- assigned-clock-parents: the PLL phy clock parent
>> +- resets: phandle + reset specifier
>> +- st,port2-switch-to-host: select HOST controller on UTMI switch for port#2
> 
> This one seems very specific. If another device had the mux on a
> different port number you'd need a new property for example.
> 

You're right. I will update the scheme with the following:

USBPHYC
      |_ PLL
      |
      |_ PHY port#1 _________________ HOST controller
      |                    _                 |
      |                  / 1|________________|
      |_ PHY port#2 ----|   |________________
      |                  \_0|                |
      |_ UTMI switch_______|          OTG controller


This way would be more generic:
st,utmi-switch = <0>; //To select the controller connected to UTMI 
switch #0 output.
st,utmi-switch = <1>; //To select the controller connected to UTMI 
switch #1 output.

> But really I think this should be determined by either a USB connector
> node (a binding is in the works) or cable detection.
>

This needs to be further studied. Could it be an upcoming evolution ?

Thanks for review,
Amelie
>> +
>> +
>> +Example:
>> +		usbphyc: usbphyc@5a006000 {
> 
> usb-phy@...
> 
>> +			compatible = "st,stm32mp1-usbphyc";
>> +			reg = <0x5a006000 0x1000>;
>> +			clocks = <&rcc_clk USBPHY_K>;
>> +			resets = <&rcc_rst USBPHY_R>;
>> +			st,port2-switch-to-host;
>> +			phy-supply = <&vdd_usb>;
>> +			vdda1v1-supply = <&reg11>;
>> +			vdda1v8-supply = <&reg18>
>> +		};
>> -- 
>> 2.7.4
>>
