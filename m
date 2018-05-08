Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeEHQLA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:11:00 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:63348 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932127AbeEHQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:10:58 -0400
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
To: "Andrew F. Davis" <afd@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180508141704.24271-1-dmurphy@ti.com>
 <554b283f-7c27-e2de-3052-e5119dba9396@ti.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <70e9b1ef-495b-a1ee-7abe-f7c719438b72@ti.com>
Date: Tue, 8 May 2018 11:10:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <554b283f-7c27-e2de-3052-e5119dba9396@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 10:32 AM, Andrew F. Davis wrote:
> On 05/08/2018 09:17 AM, Dan Murphy wrote:
>> Introduce the device tree bindings for the lm3601x
>> family of LED torch, flash and IR drivers.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v2 - No changes - https://patchwork.kernel.org/patch/10384587/
>>
>>  .../devicetree/bindings/leds/leds-lm3601x.txt | 51 +++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>> new file mode 100644
>> index 000000000000..38cdabf6ca7e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>> @@ -0,0 +1,51 @@
>> +* Texas Instruments - lm3601x Single-LED Flash Driver
>> +
>> +The LM3601X are ultra-small LED flash drivers that
>> +provides a high level of adjustability.
>> +
>> +Required properties:
>> +	- compatible : Can be one of the following
>> +		"ti,lm3601x"
> 
> 
> No wildcard compatibles, drop this.

Yeah I hmm and hawed about keeping this so I figured I would get community feedback on this.
I can remove it.

> 
> 
>> +		"ti,lm36010"
>> +		"ti,lm36011"
>> +	- reg : I2C slave address
>> +	- #address-cells : 1
>> +	- #size-cells : 0
>> +
>> +Required child properties:
>> +	- reg : 0 - Indicates to support and register a torch interface
>> +		1 - Indicates to support and register a strobe interface
>> +		2 - Indicates to support and register an ir interface
>> +
>> +Optional child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +
> 
> 
> Relative path might work better here.

I was following the other LED documentation.

Pretty much a copy and paste

> 
> 
>> +Example:
>> +led-controller@64 {
>> +	compatible = "ti,lm3601x";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	reg = <0x64>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		label = "white:torch";
>> +		led-max-microamp=<10000>;
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		label = "white:strobe";
>> +		flash-max-microamp=<10000>;
>> +		flash-max-timeout-us=<800>;
>> +	};
>> +
>> +	led@2 {
>> +		reg = <2>;
>> +		label = "invisible:ir";
>> +	};
>> +}
>> +
>> +For more product information please see the links below:
>> +http://www.ti.com/product/LM36010
>> +http://www.ti.com/product/LM36011
>>


-- 
------------------
Dan Murphy
