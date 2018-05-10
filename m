Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeEJTHE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:07:04 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:17517 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeEJTHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:07:03 -0400
Subject: Re: [PATCH v5 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
To: Pavel Machek <pavel@ucw.cz>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180510174717.26540-1-dmurphy@ti.com>
 <20180510185401.GB12846@amd>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <80e7346f-e8cd-79d2-6d4e-d638c2be01eb@ti.com>
Date: Thu, 10 May 2018 14:06:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510185401.GB12846@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 05/10/2018 01:54 PM, Pavel Machek wrote:
> Hi!
> 
>> Introduce the device tree bindings for the lm3601x
>> family of LED torch, flash and IR drivers.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> Better, thanks.
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>> @@ -0,0 +1,50 @@
>> +* Texas Instruments - lm3601x Single-LED Flash Driver
> 
> Ok, so is it single-LED driver, or can it driver ir & white LEDs at
> the same time?

It is a single LED driver.  It can drive a Torch white LED or IR LED indefinitely or if the driver
is programmed to strobe mode the driver will drive the configured LED for the flash timeout specified.

Basically a flash and a flash light. IR or White LED.


> 
>> +Example:
>> +led-controller@64 {
>> +	compatible = "ti,lm36010";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	reg = <0x64>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		label = "white:torch";
>> +		led-max-microamp = <10000>;
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		label = "white:flash";
>> +		flash-max-microamp = <10000>;
>> +		flash-max-timeout-us = <800>;
>> +	};
> 
> Is this realistic config? I'd expect flash to use more power than
> torch, and would expect longer timeout than 0.8msec.

Timeout in the spreadsheet is ms I will update this example and code
Current in the spreadsheet is mA I will update this example and code

> 
> Also.. if this is physically one white LED, it should not be
> spread over reg = <0> and reg = <1>...

If the torch LED and strobe LED are the same LED how do I expose them both to the user.
It is up to consumer to configure the required interfaces they want to expose to the filesystem.

Maybe they don't want the strobe feature and just want LED on/off and switch between IR and White.

The IR is driven via a different output pin.

Dan

> 
> Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy
