Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C8F213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlDcxgFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfAJT55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:57:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46252 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAJT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:57:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so10802306ljh.13;
        Thu, 10 Jan 2019 11:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wWVyYEKWO+Gc0O/KX4WY0IEqqhuUbP+zK9JXSOr9Am8=;
        b=VlDcxgFWZ3h4pd7lXk86oeLsaquYvfUM6XLmeDLc+HYG5vF9FJzcdSKK6H9pxaX693
         3yTHzGAHOKxJLs7FKaO5nKwpBq9fktRrhK6AJ/vxskKX/Ln8Px7uMCTc4drzZRbI6PEx
         xpF+ijdDZXMhy0ncntXrJTDyxYEBvC9DhqUzXjp9NMpsg5W8kr9K2UI7qvq3xSLxBAio
         g81xl5K+in0JP8u2aIg+IebwHfrWP9Hli4fkBnBDWbF+FfPVFMp/8yrCyTQxC9yRjJGk
         xfkKp3gmKfPcudUKlBsT0qVwCtC2AcjchFZrkJmfQqBIws2SJPUc7ug/INnVFNgiVUS2
         bhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wWVyYEKWO+Gc0O/KX4WY0IEqqhuUbP+zK9JXSOr9Am8=;
        b=Nhy1N+JxMIMrvHBAWWbu5KRIpY3y9icju+DWytdhLRTlSI969YAHHZFeh2Wj7BZb/n
         wFvLHcPXUnpzY/j6RX58kTAuKeA44PAyR1CevehCL04rPkOnISBM+RgGSabehkiZhOqn
         T+2Csj2Wk8cplbr03gL6lHH5rpiQ4l4FAAHPdwAEsnGVkqWQOc6awFhvt/jLBw1d/a/4
         0V6wF/3r73hTfqudrDon3IFhKdqghtBW1q32Q5rGjh8YM+gfmPYN5jaZNkO2KizIlJJ+
         HU6vcS8bygKJqEKRT3DrCCkGu0bkJvszGF8YiQ298+ZHM6HN7I2Q7coMzQ2Qrlar3+ik
         31Ag==
X-Gm-Message-State: AJcUukeMWiZOJbnCQTz2ZSJQY6KdmwdHJsighBr82FCBhywNyQ2UaFCF
        VqBd6NSQ03BZSSGGse3ZV+3PWmJm
X-Google-Smtp-Source: ALg8bN4GLtFOyaKzoBsteogdhmrkj2793CMXg+7nU/eQFuYTf8562GQS7tm0E4XNBV/+Q4Ii6V/DBg==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr6703727ljw.75.1547150273240;
        Thu, 10 Jan 2019 11:57:53 -0800 (PST)
Received: from [192.168.1.18] (che161.neoplus.adsl.tpnet.pl. [83.31.2.161])
        by smtp.gmail.com with ESMTPSA id j18-v6sm15333814ljc.52.2019.01.10.11.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 11:57:52 -0800 (PST)
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-2-dmurphy@ti.com>
 <dc2283f9-db85-1eaf-f046-3fbbd4adcace@gmail.com>
 <2d2d5dcd-9c23-e901-daac-9b79aa5a5e82@ti.com>
 <6c62956e-7789-58ba-5437-f2e033f2825c@gmail.com>
 <366cbf6d-94fa-fea9-be58-07ddb09cff3a@ti.com>
 <df59c10d-7038-cb4a-45f0-7420254c6398@gmail.com>
 <ec0393b7-118e-1f3b-d5af-86ecdf66412a@ti.com>
 <ae700129-7b59-c92b-0c0a-b57a6f230ff7@gmail.com>
 <adcd7987-f7fc-ae1f-9aa4-cebcbf01ad58@ti.com>
 <1702dfd6-b08f-c1ff-e46d-1366618bedb0@gmail.com>
 <72112839-11d4-54be-df94-b2322f77cb0f@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8b126077-c200-ed34-03b7-6d43a22fb0c9@gmail.com>
Date:   Thu, 10 Jan 2019 20:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <72112839-11d4-54be-df94-b2322f77cb0f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 1/10/19 8:22 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/10/19 12:44 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> On 1/9/19 10:31 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/9/19 3:28 PM, Jacek Anaszewski wrote:
>>>> On 1/9/19 10:12 PM, Dan Murphy wrote:
>>>>> On 1/9/19 2:12 PM, Jacek Anaszewski wrote:
>>>>>> Hi Dan,
>>>>>>
>>>>>> On 1/8/19 10:22 PM, Dan Murphy wrote:
>>>>>>> On 1/8/19 3:16 PM, Jacek Anaszewski wrote:
>>>>>>>> On 1/8/19 9:53 PM, Dan Murphy wrote:
>>>>>>>>> Jacek
>>>>>>>>>
>>>>>>>>> On 1/8/19 2:33 PM, Jacek Anaszewski wrote:
>>>>>>>>>> Dan,
>>>>>>>>>>
>>>>>>>>>> On 12/19/18 5:26 PM, Dan Murphy wrote:
>>>>>>>>>>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>>>>>>>>>>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>>>>>>>>>>> or as part of a control bank group.  These devices have the ability
>>>>>>>>>>> to adjust the mixing control for the RGB LEDs to obtain different colors
>>>>>>>>>>> independent of the overall brightness of the LED grouping.
>>>>>>>>>>>
>>>>>>>>>>> Datasheet:
>>>>>>>>>>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>>>>>>>>>>        1 file changed, 63 insertions(+)
>>>>>>>>>>>        create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>>>>>> new file mode 100644
>>>>>>>>>>> index 000000000000..9567aa6f7813
>>>>>>>>>>> --- /dev/null
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>>>>>> @@ -0,0 +1,63 @@
>>>>>>>>>>> +* Texas Instruments - LP5024/18 RGB LED driver
>>>>>>>>>>> +
>>>>>>>>>>> +The LM3692x is an ultra-compact, highly efficient,
>>>>>>>>>>> +white-LED driver designed for LCD display backlighting.
>>>>>>>>>>> +
>>>>>>>>>>> +The main difference between the LP5024 and L5018 is the number of
>>>>>>>>>>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>>>>>>>>>>> +LP5018 supports eighteen strings.
>>>>>>>>>>> +
>>>>>>>>>>> +Required properties:
>>>>>>>>>>> +    - compatible:
>>>>>>>>>>> +        "ti,lp5018"
>>>>>>>>>>> +        "ti,lp5024"
>>>>>>>>>>> +    - reg :  I2C slave address
>>>>>>>>>>> +    - #address-cells : 1
>>>>>>>>>>> +    - #size-cells : 0
>>>>>>>>>>> +
>>>>>>>>>>> +Optional properties:
>>>>>>>>>>> +    - enable-gpios : gpio pin to enable/disable the device.
>>>>>>>>>>> +    - vled-supply : LED supply
>>>>>>>>>>> +
>>>>>>>>>>> +Required child properties:
>>>>>>>>>>> +    - reg : Is the child node iteration.
>>>>>>>>>>> +    - led-sources : LP5024 - 0 - 7
>>>>>>>>>>> +            LP5018 - 0 - 5
>>>>>>>>>>> +            Declares the LED string or strings that the child node
>>>>>>>>>>> +            will control.  If ti,control-bank is set then this
>>>>>>>>>>> +            property will contain multiple LED IDs.
>>>>>>>>>>> +
>>>>>>>>>>> +Optional child properties:
>>>>>>>>>>> +    - label : see Documentation/devicetree/bindings/leds/common.txt
>>>>>>>>>>> +    - linux,default-trigger :
>>>>>>>>>>> +       see Documentation/devicetree/bindings/leds/common.txt
>>>>>>>>>>> +    - ti,control-bank : Indicates that the LED strings declared in the
>>>>>>>>>>> +                led-sources property are grouped within a control
>>>>>>>>>>> +                bank for brightness and mixing control.
>>>>>>>>>>> +
>>>>>>>>>>> +Example:
>>>>>>>>>>> +
>>>>>>>>>>> +led-controller@28 {
>>>>>>>>>>> +    compatible = "ti,lp5024";
>>>>>>>>>>> +    reg = <0x28>;
>>>>>>>>>>> +    #address-cells = <1>;
>>>>>>>>>>> +    #size-cells = <0>;
>>>>>>>>>>> +
>>>>>>>>>>> +    enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>>>>>>>>>> +    vled-supply = <&vbatt>;
>>>>>>>>>>> +
>>>>>>>>>>> +    led@0 {
>>>>>>>>>>> +        reg = <0>;
>>>>>>>>>>> +        led-sources = <1>;
>>>>>>>>>>> +    };
>>>>>>>>>>> +
>>>>>>>>>>> +    led@1 {
>>>>>>>>>>> +        reg = <1>;
>>>>>>>>>>> +        led-sources = <0 6>;
>>>>>>>>>>> +        ti,control-bank;
>>>>>>>>>>
>>>>>>>>>> Do you really need ti,control-bank? Doesn't led-sources array size
>>>>>>>>>> greater than 1 mean that the node describes control bank?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> That will work too.
>>>>>>>>
>>>>>>>>>> Also, does it make sense to have only two LEDs in the bank?
>>>>>>>>>
>>>>>>>>> The array can populate all 7 LEDs in a single node.  I only show 2 here as the example.
>>>>>>>>> See the description above of the led-sources
>>>>>>>>
>>>>>>>> OK, I confused RGB LED modules with banks.
>>>>>>>>
>>>>>>>> Shouldn't we allow for defining either strings or RGB LED
>>>>>>>> triplets somehow then?
>>>>>>>>
>>>>>>>
>>>>>>> Well that is what this should be doing.  If you define a single LED in LED sources then
>>>>>>> the triplet is controlled via the associated LEDx_brightness register.
>>>>>>
>>>>>> led-sources should map to iouts directly.
>>>>>> So, for RGB LED modules I would expect:
>>>>>>
>>>>>> LED0: led-sources = <0 1 2>;
>>>>>> LED1: led-sources = <3 4 5>;
>>>>>> LED2: led-sources = <6 7 8>;
>>>>>> and so on.
>>>>>
>>>>>>
>>>>>> for banks:
>>>>>>
>>>>>> Bank A with iouts 0,3,6,9: led-sources<0 3 6 9>;
>>>>>> Bank B with iouts 2,4,10:  led-sources<2 4 10>;
>>>>>> Bank C with iouts 5,8,11,14,17: led-sources<5 8 11 14 17>;
>>>>>>
>>>>>
>>>>> Ok the led-sources would need to be different then this as I don't define the sources for banks.
>>>>>
>>>>> The led-sources for the banks and the individual groups will have different meanings within the same
>>>>> document.  I was attempting to keep the led-sources mapped to the LEDx_brightness registers as opposed to
>>>>> the hardware outputs since the RGB LEDs are controlled and grouped by a single brightness register and if banked then
>>>>> it would be controlled by the bank brightness register.
>>>>>
>>>>> Describing these in the DT seems wrought with potential issues as the data sheet defines what outputs map to what bank and LED
>>>>> registers.
>>>>
>>>> Yes, that's why I mentioned the need for validation of led-sources.
>>>> But they have to be iouts. This property was introduced specifically
>>>> for such purposes.
>>>>
>>>
>>> Yes Pavel also mentioned that as well.
>>>
>>> I will look into validating the sources.  But there will be no mapping of the sources to the output that is done
>>> in the hardware.  This would just be a data sheet mapping since the outputs are not configurable.
>>
>> Hmm, isn't the mapping defined in the hardware via LED_CONFIG0 register?
>> I have an impression that it defines whether LED belongs to an RGB LED
>> module or to a bank. Basing on that I created my DT example above.
>>
> 
> Yes so if you turn on the bank control for LED0 and LED1 then
> out 0, 3 are mapped to BANK A
> out 1, 4 are mapped to BANK B

Just noticed that I made a mistake in my example, it should have been:

Bank B with iouts 1,4,10:  led-sources<1 4 10>;

> out 2, 5 are mapped to BANK C

Correct.

> All done automatically in the hardware and the LED0_BRIGHTNESS and LED1_BRIGHTNESS registers have no affect on the brightness

That's right.

> If we grouped the LEDs into a bank the led-sources would look more like this
> led-sources = < 0 1 2 3 4 5 >;

Why? This would be a mix of three banks. Like you listed above.
I'm still interpreting led-sources elements as iout identifiers.

> ti,control-bank; // But this can be omitted as led-sources is greater then 3
> 
> non-banked case would be
> led-sources = < 0 1 2 >;

Agreed here. It would be LED0 RGB LED module.
> But the actual OUT numbers don't matter in the bank case unless we do the validation.  There would need to be an algorithim
> that translates these output to the correct LEDx register and CONFIG0 bits.  Basically if OUT0 is mapped to the bank then OUT1 and OUT2
> are inherently mapped to the bank.  

To three separate banks, right?
OUT0 - bank A, OUT1 - bank B, OUT2 - bank C.

> They cannot be separated so the device theoretically treats the RGB group as a single LED.  And
> when banked it treats the groups of RGBs that are defined as a single LED.
> 
> This is why it was easier use the LEDx out as the virtual out as we only need to define the group number(s) that are controled by the
> LED file presented to the user space.

I suspect there is logical clash here due to interpreting
led-sources elements as iouts in one case and LEDn modules
in the other case.

-- 
Best regards,
Jacek Anaszewski
