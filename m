Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC168C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915A920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TZjMC8tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfAHVW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:22:26 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33874 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfAHVW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:22:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x08LMJsl082398;
        Tue, 8 Jan 2019 15:22:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546982539;
        bh=MsHQtkwLXUI3WBqPfrpBYwiiCJ88XzkKOtwR8kg6qMU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TZjMC8tQOkFPNGSNiKYR7ruC02erKF4DM0tqqxu9AEycMNH1cJG9O/fTtFKDAJbSf
         Rtk/cj/PJKfWAWil3R8gkwMCC9V75wrdgBiFTGlBQ1pJJHlLWXS2Nk+5jGXc56eOMb
         Q0u24bfP5d614t4musta6ZueFIDWmYFWAHy9fPAc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x08LMJ2S060488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jan 2019 15:22:19 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 8
 Jan 2019 15:22:19 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 8 Jan 2019 15:22:19 -0600
Received: from [172.22.122.210] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x08LMIDg004113;
        Tue, 8 Jan 2019 15:22:18 -0600
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
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <366cbf6d-94fa-fea9-be58-07ddb09cff3a@ti.com>
Date:   Tue, 8 Jan 2019 15:22:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6c62956e-7789-58ba-5437-f2e033f2825c@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 3:16 PM, Jacek Anaszewski wrote:
> On 1/8/19 9:53 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 1/8/19 2:33 PM, Jacek Anaszewski wrote:
>>> Dan,
>>>
>>> On 12/19/18 5:26 PM, Dan Murphy wrote:
>>>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>>>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>>>> or as part of a control bank group.  These devices have the ability
>>>> to adjust the mixing control for the RGB LEDs to obtain different colors
>>>> independent of the overall brightness of the LED grouping.
>>>>
>>>> Datasheet:
>>>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>>>    1 file changed, 63 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>> new file mode 100644
>>>> index 000000000000..9567aa6f7813
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>> @@ -0,0 +1,63 @@
>>>> +* Texas Instruments - LP5024/18 RGB LED driver
>>>> +
>>>> +The LM3692x is an ultra-compact, highly efficient,
>>>> +white-LED driver designed for LCD display backlighting.
>>>> +
>>>> +The main difference between the LP5024 and L5018 is the number of
>>>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>>>> +LP5018 supports eighteen strings.
>>>> +
>>>> +Required properties:
>>>> +    - compatible:
>>>> +        "ti,lp5018"
>>>> +        "ti,lp5024"
>>>> +    - reg :  I2C slave address
>>>> +    - #address-cells : 1
>>>> +    - #size-cells : 0
>>>> +
>>>> +Optional properties:
>>>> +    - enable-gpios : gpio pin to enable/disable the device.
>>>> +    - vled-supply : LED supply
>>>> +
>>>> +Required child properties:
>>>> +    - reg : Is the child node iteration.
>>>> +    - led-sources : LP5024 - 0 - 7
>>>> +            LP5018 - 0 - 5
>>>> +            Declares the LED string or strings that the child node
>>>> +            will control.  If ti,control-bank is set then this
>>>> +            property will contain multiple LED IDs.
>>>> +
>>>> +Optional child properties:
>>>> +    - label : see Documentation/devicetree/bindings/leds/common.txt
>>>> +    - linux,default-trigger :
>>>> +       see Documentation/devicetree/bindings/leds/common.txt
>>>> +    - ti,control-bank : Indicates that the LED strings declared in the
>>>> +                led-sources property are grouped within a control
>>>> +                bank for brightness and mixing control.
>>>> +
>>>> +Example:
>>>> +
>>>> +led-controller@28 {
>>>> +    compatible = "ti,lp5024";
>>>> +    reg = <0x28>;
>>>> +    #address-cells = <1>;
>>>> +    #size-cells = <0>;
>>>> +
>>>> +    enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>>> +    vled-supply = <&vbatt>;
>>>> +
>>>> +    led@0 {
>>>> +        reg = <0>;
>>>> +        led-sources = <1>;
>>>> +    };
>>>> +
>>>> +    led@1 {
>>>> +        reg = <1>;
>>>> +        led-sources = <0 6>;
>>>> +        ti,control-bank;
>>>
>>> Do you really need ti,control-bank? Doesn't led-sources array size
>>> greater than 1 mean that the node describes control bank?
>>>
>>
>> That will work too.
> 
>>> Also, does it make sense to have only two LEDs in the bank?
>>
>> The array can populate all 7 LEDs in a single node.  I only show 2 here as the example.
>> See the description above of the led-sources
> 
> OK, I confused RGB LED modules with banks.
> 
> Shouldn't we allow for defining either strings or RGB LED
> triplets somehow then?
> 

Well that is what this should be doing.  If you define a single LED in LED sources then
the triplet is controlled via the associated LEDx_brightness register.

If you have multiple LED sources defined in the led-sources then those LEDs would be grouped in the bank.
I guess I need to provide some protection or a warning if a DT defines two banks because there is only one bank control.

Dan

-- 
------------------
Dan Murphy
