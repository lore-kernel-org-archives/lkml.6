Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757280AbeEJMEP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:04:15 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:57572 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757264AbeEJMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:04:13 -0400
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
To: Pavel Machek <pavel@ucw.cz>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180508141704.24271-1-dmurphy@ti.com>
 <20180510112807.GF6977@amd>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <1c4dc2a1-2d3e-d282-7d94-8301d0e9dd83@ti.com>
Date: Thu, 10 May 2018 07:04:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510112807.GF6977@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review

On 05/10/2018 06:28 AM, Pavel Machek wrote:
> On Tue 2018-05-08 09:17:03, Dan Murphy wrote:
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
> 
> "provide".

Data sheet says provides.

It reads fine either way but I will change it.

> 
>> +Required properties:
>> +	- compatible : Can be one of the following
>> +		"ti,lm3601x"
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
> 
> I'd delete "to support and register" -- we are describing hardware here.

OK

> 
>> +Optional child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +
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
> 
> Title says this is single-LED driver chip, but it controls three chips
> in this example?

3 chips?  It technically controls 3 LED methods and only 2 LEDs.  The torch can be used as the strobe
and the IR is controlled independently.

> 
> I'd put " " around "=" for consistency.

OK

> 
> We use "flash" elsewhere, I'd replace "strobe" with that. Userspace
> would like consistency, too.

Labels are meant to be examples only not absolutes.  I will change it to say flash
but the label can be anything the customer wants it to be.

> 
> What is the IR led good for? Taking videos in the dark?

Yes.  That is one application.
And hunting ghosts ;)

> 
> I guess for consistency, it is "ir:torch" :-).

OK

> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
