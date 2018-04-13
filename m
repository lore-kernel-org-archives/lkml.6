Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeDMRNk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:13:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:52371 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeDMRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:13:38 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517900400";
   d="scan'208";a="13813770"
Subject: Re: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Radu Pirea <radu.pirea@microchip.com>
CC: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
Date: Fri, 13 Apr 2018 19:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413162327.GE22187@piout.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 at 18:23, Alexandre Belloni wrote:
> On 13/04/2018 19:11:16+0300, Radu Pirea wrote:
>> These are bindings for at91-usart IP in spi spi mode. There is no support for
>> internal chip select. Only kind of chip selects available are gpio chip
>> selects.
>>
>> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
>> ---
>>   .../bindings/spi/microchip,at91-usart-spi.txt | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
>> new file mode 100644
>> index 000000000000..92d33ccdffae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
>> @@ -0,0 +1,24 @@
>> +* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
>> +
>> +Required properties:
>> +- #size-cells      : Must be <0>
>> +- #address-cells   : Must be <1>
>> +- compatible: Should be "microchip,at91sam9g45-usart-spi" or "microchip,sama5d2-usart-spi"
>> +- reg: Should contain registers location and length
>> +- interrupts: Should contain interrupt
>> +- clocks: phandles to input clocks.
>> +- clock-names: tuple listing input clock names.
>> +	Required elements: "usart"
>> +- cs-gpios: chipselects (internal cs not supported)
>> +
>> +Example:
>> +	spi0: spi@f001c000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		compatible = "microchip,sama5d2-usart-spi", "microchip,at91sam9g45-usart-spi";
> 
> I'm pretty sure this will be considered configuration rather than
> hardware description. Why don't you do something like the flexcom mode
> selection?

Because we are not in the same situation as having a glue layer that 
would select one of the already existing peripherals with associated 
drivers above.
This layout of the hardware is completely different from the USART one 
and it seems to makes sense to address it with a different hardware 
description and so a different compatible string.

Regards,
   Nicolas

>> +		reg = <0xf001c000 0x100>;
>> +		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&usart0_clk>;
>> +		clock-names = "usart";
>> +		cs-gpios = <&pioB 3 0>;
>> +	};
>> -- 
>> 2.17.0
>>
> 


-- 
Nicolas Ferre
