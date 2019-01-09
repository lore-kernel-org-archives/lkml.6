Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DB6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B882054F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JlTas0e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAIVM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:12:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60070 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfAIVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:12:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x09LCp8N057556;
        Wed, 9 Jan 2019 15:12:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547068371;
        bh=ZR4HacjN+m5pt61cNBcyaY2KNVJ3R57owuwTjcKo42s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JlTas0e0Ovs8dK7Zbb7vjHGhAXGoiIEcwjT8tO/TrYz/E7TitVr6letwxsu+8zJVy
         tAMn2eki92AoZtBkQeZJZ3OKKR4JJiqZ/RjhTKFOfknDKkasr8g5eRw3cz23FxiUze
         NRUycxNngKfxVuYI7Lg5FDJcsFbhDu7XDPbUVYR4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x09LCpWA106935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 15:12:51 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 15:12:51 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 15:12:51 -0600
Received: from [172.22.122.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x09LCpFD031452;
        Wed, 9 Jan 2019 15:12:51 -0600
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-2-dmurphy@ti.com>
 <dc2283f9-db85-1eaf-f046-3fbbd4adcace@gmail.com>
 <2d2d5dcd-9c23-e901-daac-9b79aa5a5e82@ti.com>
 <6c62956e-7789-58ba-5437-f2e033f2825c@gmail.com>
 <366cbf6d-94fa-fea9-be58-07ddb09cff3a@ti.com>
 <df59c10d-7038-cb4a-45f0-7420254c6398@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ec0393b7-118e-1f3b-d5af-86ecdf66412a@ti.com>
Date:   Wed, 9 Jan 2019 15:12:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <df59c10d-7038-cb4a-45f0-7420254c6398@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/19 2:12 PM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> On 1/8/19 10:22 PM, Dan Murphy wrote:
>> On 1/8/19 3:16 PM, Jacek Anaszewski wrote:
>>> On 1/8/19 9:53 PM, Dan Murphy wrote:
>>>> Jacek
>>>>
>>>> On 1/8/19 2:33 PM, Jacek Anaszewski wrote:
>>>>> Dan,
>>>>>
>>>>> On 12/19/18 5:26 PM, Dan Murphy wrote:
>>>>>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>>>>>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>>>>>> or as part of a control bank group.  These devices have the ability
>>>>>> to adjust the mixing control for the RGB LEDs to obtain different colors
>>>>>> independent of the overall brightness of the LED grouping.
>>>>>>
>>>>>> Datasheet:
>>>>>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>>>>>
>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>>>>>     1 file changed, 63 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..9567aa6f7813
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>> @@ -0,0 +1,63 @@
>>>>>> +* Texas Instruments - LP5024/18 RGB LED driver
>>>>>> +
>>>>>> +The LM3692x is an ultra-compact, highly efficient,
>>>>>> +white-LED driver designed for LCD display backlighting.
>>>>>> +
>>>>>> +The main difference between the LP5024 and L5018 is the number of
>>>>>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>>>>>> +LP5018 supports eighteen strings.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +    - compatible:
>>>>>> +        "ti,lp5018"
>>>>>> +        "ti,lp5024"
>>>>>> +    - reg :  I2C slave address
>>>>>> +    - #address-cells : 1
>>>>>> +    - #size-cells : 0
>>>>>> +
>>>>>> +Optional properties:
>>>>>> +    - enable-gpios : gpio pin to enable/disable the device.
>>>>>> +    - vled-supply : LED supply
>>>>>> +
>>>>>> +Required child properties:
>>>>>> +    - reg : Is the child node iteration.
>>>>>> +    - led-sources : LP5024 - 0 - 7
>>>>>> +            LP5018 - 0 - 5
>>>>>> +            Declares the LED string or strings that the child node
>>>>>> +            will control.  If ti,control-bank is set then this
>>>>>> +            property will contain multiple LED IDs.
>>>>>> +
>>>>>> +Optional child properties:
>>>>>> +    - label : see Documentation/devicetree/bindings/leds/common.txt
>>>>>> +    - linux,default-trigger :
>>>>>> +       see Documentation/devicetree/bindings/leds/common.txt
>>>>>> +    - ti,control-bank : Indicates that the LED strings declared in the
>>>>>> +                led-sources property are grouped within a control
>>>>>> +                bank for brightness and mixing control.
>>>>>> +
>>>>>> +Example:
>>>>>> +
>>>>>> +led-controller@28 {
>>>>>> +    compatible = "ti,lp5024";
>>>>>> +    reg = <0x28>;
>>>>>> +    #address-cells = <1>;
>>>>>> +    #size-cells = <0>;
>>>>>> +
>>>>>> +    enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>>>>> +    vled-supply = <&vbatt>;
>>>>>> +
>>>>>> +    led@0 {
>>>>>> +        reg = <0>;
>>>>>> +        led-sources = <1>;
>>>>>> +    };
>>>>>> +
>>>>>> +    led@1 {
>>>>>> +        reg = <1>;
>>>>>> +        led-sources = <0 6>;
>>>>>> +        ti,control-bank;
>>>>>
>>>>> Do you really need ti,control-bank? Doesn't led-sources array size
>>>>> greater than 1 mean that the node describes control bank?
>>>>>
>>>>
>>>> That will work too.
>>>
>>>>> Also, does it make sense to have only two LEDs in the bank?
>>>>
>>>> The array can populate all 7 LEDs in a single node.  I only show 2 here as the example.
>>>> See the description above of the led-sources
>>>
>>> OK, I confused RGB LED modules with banks.
>>>
>>> Shouldn't we allow for defining either strings or RGB LED
>>> triplets somehow then?
>>>
>>
>> Well that is what this should be doing.  If you define a single LED in LED sources then
>> the triplet is controlled via the associated LEDx_brightness register.
> 
> led-sources should map to iouts directly.
> So, for RGB LED modules I would expect:
> 
> LED0: led-sources = <0 1 2>;
> LED1: led-sources = <3 4 5>;
> LED2: led-sources = <6 7 8>;
> and so on.

> 
> for banks:
> 
> Bank A with iouts 0,3,6,9: led-sources<0 3 6 9>;
> Bank B with iouts 2,4,10:  led-sources<2 4 10>;
> Bank C with iouts 5,8,11,14,17: led-sources<5 8 11 14 17>;
> 

Ok the led-sources would need to be different then this as I don't define the sources for banks.

The led-sources for the banks and the individual groups will have different meanings within the same
document.  I was attempting to keep the led-sources mapped to the LEDx_brightness registers as opposed to
the hardware outputs since the RGB LEDs are controlled and grouped by a single brightness register and if banked then
it would be controlled by the bank brightness register.

Describing these in the DT seems wrought with potential issues as the data sheet defines what outputs map to what bank and LED
registers.

> We could additionally mark banks with ti,control-bank,

We would have to keep the ti,control-bank node based on the above.

> but I'm not sure if it would ease parsing, since
> you will have to validate iouts configuration anyway.
> 
>> If you have multiple LED sources defined in the led-sources then those LEDs would be grouped in the bank.
>> I guess I need to provide some protection or a warning if a DT defines two banks because there is only one bank control.
> 
> Does the hardware allow the IOUT to belong to an RGB LED module
> and to a bank in the same time?
> 

No it does not.  LED_CONFIG0 sets the bit if it is control bank or not.

Section 8.3.2 in the data sheet says
"When a channel is configured in
LED bank-control mode, the related color mixing and intensity control is governed by the bank control registers
(BANK_A_COLOR, BANK_B_COLOR, BANK_C_COLOR, and BANK_BRIGHTNESS) regardless of the inputs
on its own color-mixing and intensity-control registers."

-- 
------------------
Dan Murphy
