Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC742C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922F120656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3vjjF/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfANULq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:11:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41551 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:11:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so268729ljc.8;
        Mon, 14 Jan 2019 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WiYRynAHHFjrysXhiL/s4v3xINIhibwO9kQySErKkr4=;
        b=a3vjjF/JCgC/6J7Ze6U/8VLl4lt7Mly6Ebl0HFfFDkE+2v2OyQ86kS+aCz7sSvEvqn
         fyLmyJms46mnp+6wXdRWIA6J/bS2QTBdP4Sz6VI5+L4wLxriqzgm0h1DEGmgpdPYlHyk
         HFzagUEok/tfSByji74dpT92KmhbqpyQp6ykyzXQR7CcOenHmysnRIT3YlZy30F6wzOS
         88rg6Ed89XZFlaXUg8hfahAh9W/AJ3aLxILdIscBMEMX/TTPkZTRU0IaQayL9jVraKmg
         hx/JOxTk/8xCpI2Iaq5m2VnwzOcPDSy0RplRZIEtHY7PeYVos5l+KJiNgVOprHDFY29V
         2yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WiYRynAHHFjrysXhiL/s4v3xINIhibwO9kQySErKkr4=;
        b=iELasYj3tjULvu65RtDOiU28kTwqH/Ddi8rhZcsZw1lSyN060tp6aUWKxqVsqHYKV+
         Oo2vgEYxwXuDfxVx6bsCMwM19LAQ4cjIUxa+sjKBu6VB72o4jaC2iN+4AVSv8OJiM5XU
         MpQ3I137+GiGQYtwL7EHOG9pgtQgFdUjlaDLck3+OeJ+b8yaBINX/CdZiGn09sVJzRv7
         dnkxZAfdyXu+KCl7SdfeP1Jnlh5mDf+WSMcY/t/ek0+oo5W+IqZP8lfs4+ve/Qa5ffpU
         tjcdsXpiOrVyHlGGU/vKJKBqpspqLvoSU8EuKAAbTvNyiq6ioo/QIX6TMNxTEvwk6OXE
         3wvw==
X-Gm-Message-State: AJcUukc2CoDX/7p003RSRIGyT9FKQUFe/wGe++Mtu2DwLqyvCi4O22Fm
        9q8HgTme5eVM4JS6KFaqa03v83mm
X-Google-Smtp-Source: ALg8bN7xfPYTPkJALxmscVmzPJuHlHLUAi7/Jd6eLpllzUsHt+Ugw4LXN/cXb/sMkxjKOQ0JwU02AA==
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr125769ljg.151.1547496699448;
        Mon, 14 Jan 2019 12:11:39 -0800 (PST)
Received: from [192.168.1.18] (dnr9.neoplus.adsl.tpnet.pl. [83.24.99.9])
        by smtp.gmail.com with ESMTPSA id d10sm237998lfa.71.2019.01.14.12.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:11:38 -0800 (PST)
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
 <8b126077-c200-ed34-03b7-6d43a22fb0c9@gmail.com>
 <92cc81dc-7280-8bf0-9536-9c4d990eaf3b@ti.com>
 <459a4d7a-980b-5a46-9bd8-7a7afb37e1c3@gmail.com>
 <76577ad1-8c29-c5f6-e253-a8541a150dc0@ti.com>
 <3674d644-ccf6-d545-fc41-6bdf8960df44@gmail.com>
 <0140ad64-432e-7723-2415-0b3a8ac4d8dc@ti.com>
 <ed78b2fd-7ab8-d7c3-cf28-4d5b06783fb3@gmail.com>
 <1c452daa-d77e-5d31-3694-b9dfda9cc8f3@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9c129b00-39e6-dd29-c2a7-0506a1780fb8@gmail.com>
Date:   Mon, 14 Jan 2019 21:11:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1c452daa-d77e-5d31-3694-b9dfda9cc8f3@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 1/14/19 1:27 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/12/19 1:48 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> On 1/12/19 6:09 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/11/19 3:52 PM, Jacek Anaszewski wrote:
>>>> Dan,
>>>>
>>>> On 1/11/19 1:38 PM, Dan Murphy wrote:
>>>>> Jacek
>>>>>
>>>>> Sorry I missed some replies
>>>>>
>>>>> On 1/10/19 4:03 PM, Jacek Anaszewski wrote:
>>>>>> On 1/10/19 9:43 PM, Dan Murphy wrote:
>>>>>>> Jacek
>>>>>>>
>>>>>>> On 1/10/19 1:57 PM, Jacek Anaszewski wrote:
>>>>>>>> Dan,
>>>>>>>>
>>>>>>>> On 1/10/19 8:22 PM, Dan Murphy wrote:
>>>>>>>>> Jacek
>>>>>>>>>
>>>>>>>>> On 1/10/19 12:44 PM, Jacek Anaszewski wrote:
>>>>>>>>>> Hi Dan,
>>>>>>>>>>
>>>>>>>>>> On 1/9/19 10:31 PM, Dan Murphy wrote:
>>>>>>>>>>> Jacek
>>>>>>>>>>>
>>>>>>>>>>> On 1/9/19 3:28 PM, Jacek Anaszewski wrote:
>>>>>>>>>>>> On 1/9/19 10:12 PM, Dan Murphy wrote:
>>>>>>>>>>>>> On 1/9/19 2:12 PM, Jacek Anaszewski wrote:
>>>>>>>>>>>>>> Hi Dan,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 1/8/19 10:22 PM, Dan Murphy wrote:
>>>>>>>>>>>>>>> On 1/8/19 3:16 PM, Jacek Anaszewski wrote:
>>>>>>>>>>>>>>>> On 1/8/19 9:53 PM, Dan Murphy wrote:
>>>>>>>>>>>>>>>>> Jacek
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 1/8/19 2:33 PM, Jacek Anaszewski wrote:
>>>>>>>>>>>>>>>>>> Dan,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On 12/19/18 5:26 PM, Dan Murphy wrote:
>>>>>>>>>>>>>>>>>>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>>>>>>>>>>>>>>>>>>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>>>>>>>>>>>>>>>>>>> or as part of a control bank group.  These devices have the ability
>>>>>>>>>>>>>>>>>>> to adjust the mixing control for the RGB LEDs to obtain different colors
>>>>>>>>>>>>>>>>>>> independent of the overall brightness of the LED grouping.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Datasheet:
>>>>>>>>>>>>>>>>>>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>            .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>>>>>>>>>>>>>>>>>>            1 file changed, 63 insertions(+)
>>>>>>>>>>>>>>>>>>>            create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>>>>>>>>>>>>>> new file mode 100644
>>>>>>>>>>>>>>>>>>> index 000000000000..9567aa6f7813
>>>>>>>>>>>>>>>>>>> --- /dev/null
>>>>>>>>>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>>>>>>>>>>>>>>> @@ -0,0 +1,63 @@
>>>>>>>>>>>>>>>>>>> +* Texas Instruments - LP5024/18 RGB LED driver
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +The LM3692x is an ultra-compact, highly efficient,
>>>>>>>>>>>>>>>>>>> +white-LED driver designed for LCD display backlighting.
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +The main difference between the LP5024 and L5018 is the number of
>>>>>>>>>>>>>>>>>>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>>>>>>>>>>>>>>>>>>> +LP5018 supports eighteen strings.
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +Required properties:
>>>>>>>>>>>>>>>>>>> +    - compatible:
>>>>>>>>>>>>>>>>>>> +        "ti,lp5018"
>>>>>>>>>>>>>>>>>>> +        "ti,lp5024"
>>>>>>>>>>>>>>>>>>> +    - reg :  I2C slave address
>>>>>>>>>>>>>>>>>>> +    - #address-cells : 1
>>>>>>>>>>>>>>>>>>> +    - #size-cells : 0
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +Optional properties:
>>>>>>>>>>>>>>>>>>> +    - enable-gpios : gpio pin to enable/disable the device.
>>>>>>>>>>>>>>>>>>> +    - vled-supply : LED supply
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +Required child properties:
>>>>>>>>>>>>>>>>>>> +    - reg : Is the child node iteration.
>>>>>>>>>>>>>>>>>>> +    - led-sources : LP5024 - 0 - 7
>>>>>>>>>>>>>>>>>>> +            LP5018 - 0 - 5
>>>>>>>>>>>>>>>>>>> +            Declares the LED string or strings that the child node
>>>>>>>>>>>>>>>>>>> +            will control.  If ti,control-bank is set then this
>>>>>>>>>>>>>>>>>>> +            property will contain multiple LED IDs.
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +Optional child properties:
>>>>>>>>>>>>>>>>>>> +    - label : see Documentation/devicetree/bindings/leds/common.txt
>>>>>>>>>>>>>>>>>>> +    - linux,default-trigger :
>>>>>>>>>>>>>>>>>>> +       see Documentation/devicetree/bindings/leds/common.txt
>>>>>>>>>>>>>>>>>>> +    - ti,control-bank : Indicates that the LED strings declared in the
>>>>>>>>>>>>>>>>>>> +                led-sources property are grouped within a control
>>>>>>>>>>>>>>>>>>> +                bank for brightness and mixing control.
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +Example:
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +led-controller@28 {
>>>>>>>>>>>>>>>>>>> +    compatible = "ti,lp5024";
>>>>>>>>>>>>>>>>>>> +    reg = <0x28>;
>>>>>>>>>>>>>>>>>>> +    #address-cells = <1>;
>>>>>>>>>>>>>>>>>>> +    #size-cells = <0>;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>>>>>>>>>>>>>>>>>> +    vled-supply = <&vbatt>;
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    led@0 {
>>>>>>>>>>>>>>>>>>> +        reg = <0>;
>>>>>>>>>>>>>>>>>>> +        led-sources = <1>;
>>>>>>>>>>>>>>>>>>> +    };
>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>> +    led@1 {
>>>>>>>>>>>>>>>>>>> +        reg = <1>;
>>>>>>>>>>>>>>>>>>> +        led-sources = <0 6>;
>>>>>>>>>>>>>>>>>>> +        ti,control-bank;
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Do you really need ti,control-bank? Doesn't led-sources array size
>>>>>>>>>>>>>>>>>> greater than 1 mean that the node describes control bank?
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> That will work too.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Also, does it make sense to have only two LEDs in the bank?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The array can populate all 7 LEDs in a single node.  I only show 2 here as the example.
>>>>>>>>>>>>>>>>> See the description above of the led-sources
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> OK, I confused RGB LED modules with banks.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Shouldn't we allow for defining either strings or RGB LED
>>>>>>>>>>>>>>>> triplets somehow then?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Well that is what this should be doing.  If you define a single LED in LED sources then
>>>>>>>>>>>>>>> the triplet is controlled via the associated LEDx_brightness register.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> led-sources should map to iouts directly.
>>>>>>>>>>>>>> So, for RGB LED modules I would expect:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> LED0: led-sources = <0 1 2>;
>>>>>>>>>>>>>> LED1: led-sources = <3 4 5>;
>>>>>>>>>>>>>> LED2: led-sources = <6 7 8>;
>>>>>>>>>>>>>> and so on.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> for banks:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Bank A with iouts 0,3,6,9: led-sources<0 3 6 9>;
>>>>>>>>>>>>>> Bank B with iouts 2,4,10:  led-sources<2 4 10>;
>>>>>>>>>>>>>> Bank C with iouts 5,8,11,14,17: led-sources<5 8 11 14 17>;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Ok the led-sources would need to be different then this as I don't define the sources for banks.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The led-sources for the banks and the individual groups will have different meanings within the same
>>>>>>>>>>>>> document.  I was attempting to keep the led-sources mapped to the LEDx_brightness registers as opposed to
>>>>>>>>>>>>> the hardware outputs since the RGB LEDs are controlled and grouped by a single brightness register and if banked then
>>>>>>>>>>>>> it would be controlled by the bank brightness register.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Describing these in the DT seems wrought with potential issues as the data sheet defines what outputs map to what bank and LED
>>>>>>>>>>>>> registers.
>>>>>>>>>>>>
>>>>>>>>>>>> Yes, that's why I mentioned the need for validation of led-sources.
>>>>>>>>>>>> But they have to be iouts. This property was introduced specifically
>>>>>>>>>>>> for such purposes.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Yes Pavel also mentioned that as well.
>>>>>>>>>>>
>>>>>>>>>>> I will look into validating the sources.  But there will be no mapping of the sources to the output that is done
>>>>>>>>>>> in the hardware.  This would just be a data sheet mapping since the outputs are not configurable.
>>>>>>>>>>
>>>>>>>>>> Hmm, isn't the mapping defined in the hardware via LED_CONFIG0 register?
>>>>>>>>>> I have an impression that it defines whether LED belongs to an RGB LED
>>>>>>>>>> module or to a bank. Basing on that I created my DT example above.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yes so if you turn on the bank control for LED0 and LED1 then
>>>>>>>>> out 0, 3 are mapped to BANK A
>>>>>>>>> out 1, 4 are mapped to BANK B
>>>>>>>>
>>>>>>>> Just noticed that I made a mistake in my example, it should have been:
>>>>>>>>
>>>>>>>> Bank B with iouts 1,4,10:  led-sources<1 4 10>;
>>>>>>>>
>>>>>>>>> out 2, 5 are mapped to BANK C
>>>>>>>>
>>>>>>>> Correct.
>>>>>>>>
>>>>>>>>> All done automatically in the hardware and the LED0_BRIGHTNESS and LED1_BRIGHTNESS registers have no affect on the brightness
>>>>>>>>
>>>>>>>> That's right.
>>>>>>>>
>>>>>>>>> If we grouped the LEDs into a bank the led-sources would look more like this
>>>>>>>>> led-sources = < 0 1 2 3 4 5 >;
>>>>>>>>
>>>>>>>> Why? This would be a mix of three banks. Like you listed above.
>>>>>>>> I'm still interpreting led-sources elements as iout identifiers.
>>>>>>>>
>>>>>>>
>>>>>>> I am as well but as I tried to explain that if you define OUT0 as bank controlled then OUT1 and OUT2 are also bank controlled
>>>>>>> within the hardware.  We have no control of that.  If BIT(0) and BIT(1) are set in the LED_CONFIG0 register then OUT0, 1, 2, 3, 4 and 5 are all bank controlled.
>>>>>>
>>>>>> There is naming conflict I noticed just now - LEDn_BANK_EN bits
>>>>>> in LED_CONFIG0 register enable RGB LED modules, and not BANKs (A,B,C).
>>>>>>
>>>>>>> These OUTPUTs will appear as a single RGB LED grouping.
>>>>>>
>>>>>> Single? W would rather expect that we get two RGB LED modules, whose
>>>>>> brightness will be controlled via LED0_BRIGHTNESS and LED1_BRIGHTNESS
>>>>>> registers respectively.
>>>>>>
>>>>>>>>> ti,control-bank; // But this can be omitted as led-sources is greater then 3
>>>>>>>>>
>>>>>>>>> non-banked case would be
>>>>>>>>> led-sources = < 0 1 2 >;
>>>>>>>>
>>>>>>>> Agreed here. It would be LED0 RGB LED module.
>>>>>>>>> But the actual OUT numbers don't matter in the bank case unless we do the validation.  There would need to be an algorithim
>>>>>>>>> that translates these output to the correct LEDx register and CONFIG0 bits.  Basically if OUT0 is mapped to the bank then OUT1 and OUT2
>>>>>>>>> are inherently mapped to the bank.
>>>>>>>>
>>>>>>>> To three separate banks, right?
>>>>>>>> OUT0 - bank A, OUT1 - bank B, OUT2 - bank C.
>>>>>>>
>>>>>>> Yes but there is no BANK output pin just like there is no dedicated LEDn output pin.  The banks are grouped internally to the device
>>>>>>> so again if OUT0 and OUT3 are defined as banked then 1, 2, 4, and 5 are all mapped to the bank.  1 BANK brightness register and 3 bank
>>>>>>> color adjustment registers.
>>>>>>
>>>>>> Here as above, I would expect two separate banks - LED0 and LED1.
>>>>>> Moreover - not 3 color adjustment registers, but six - one per iout:
>>>>>> OUT0_COLOR to OUT5_COLOR.
>>>>>>
>>>>>
>>>>> When the LEDs are banked the banked LEDs are controlled by the bank registers not the LEDx registers
>>>>> so you should only see 3 color adjustments on the banked LEDs.
>>>>>
>>>>>>>>> They cannot be separated so the device theoretically treats the RGB group as a single LED.  And
>>>>>>>>> when banked it treats the groups of RGBs that are defined as a single LED.
>>>>>>>>>
>>>>>>>>> This is why it was easier use the LEDx out as the virtual out as we only need to define the group number(s) that are controled by the
>>>>>>>>> LED file presented to the user space.
>>>>>>>>
>>>>>>>> I suspect there is logical clash here due to interpreting
>>>>>>>> led-sources elements as iouts in one case and LEDn modules
>>>>>>>> in the other case.
>>>>>>>>
>>>>>>>
>>>>>>> Yes.  When the RGBs are banked you have to think of them as a single RGB LED cluster and not as separate RGB LED clusters.
>>>>>>
>>>>>> We have RGB LED modules (enabled with LEDn_Bank_EN bits) and three
>>>>>> banks (A,B,C), which are enabled by default, am I right?
>>>>>
>>>>> No.  Independent LED modules are enabled by default.  You have to explicitly enable the banks.
>>>>>
>>>>>>
>>>>>> Bank A iouts: 0, 3 ,6, 9, 12, 15
>>>>>> Bank B iouts: 1, 4, 7, 10, 13, 16
>>>>>> Bank C iouts: 2, 5, 8, 11, 14, 17
>>>>>>
>>>>>> When RGB LED module is enabled (via LEDn_Bank_EN bit),
>>>>>> the BANK_{A.B,C}_COLOR and BANK_BRIGHTNESS registers
>>>>>> lose control over related IOUTs in favour of LEDn_BRIGHTNESS and
>>>>>> related OUTn_COLOR registers. Is it correct?
>>>>>
>>>>> No it is the opposite.  When the bit is enabled LED banking is enabled and the BANK brightness and color registers over
>>>>> ride the LEDx color and brightness registers.
>>>>>
>>>>> Default is independent control of the RGB via the LEDx color and brightness registers.
>>>>>
>>>>>>
>>>>>>> As you know the brightness is controlled by the single BANK_BRIGHTNESS register.  So identifying each output in the led-sources is
>>>>>>> misleading as the hardware does this all on the chip.  This is why I just mapped each output to the Virtual LEDx module.
>>>>>>
>>>>>> Ekhm, I messed something here.
>>>>>>
>>>>>> So for this I would define a single LED class device.
>>>>>> Related DT node would not need led-sources at all,
>>>>>> but only ti,control-bank. The semantics would be:
>>>>>> controls all iouts not taken by RGB LED modules.
>>>>>>
>>>>>
>>>>> Hmm.  I guess I will put that on hold until you read the responses.  I am not sure that would work or
>>>>> that would be really clean.  I still believe that mapping led-sources to the LEDx module number is the cleanest
>>>>> simplest solution since the driver cannot inter mix different outputs for enablement.
>>>>
>>>> I've read the doc again more carefully and hopefully I finally have
>>>> proper understanding. Let's check it.
>>>>
>>>> 1. On reset LED_CONFIG0 bits are zeroed, which means
>>>>      LEDn module independent control mode.
>>>> 2. LEDn modules (i.e. IOUT triplets) are controlled independently,
>>>>      with use of LEDn_BRIGHTNESS registers, and each IOUT color can
>>>>      be adjusted using OUTn_CONTROL registers.
>>>> 3. LEDn_Bank_EN bits, when set to 1, assign given RGB LED module
>>>>      to one global bank, controlled via BANK_BRIGHTNESS and BANK_n_COLOR
>>>>      registers.
>>>>
>>>> Having that, I'd see led-sources definitions as follows
>>>> (led-sources element is IOUT identifier)
>>>>
>>>> 1.
>>>>
>>>> - LED0, LED1, LED2, LED3 modules controlled by separate
>>>>     LED class devices
>>>>
>>>> led-sources = <0 1 2>   // LED0
>>>> led-sources = <3 4 5>   // LED1
>>>> led-sources = <6 7 8>   // LED2
>>>> led-sources = <9 10 11> // LED3
>>>>
>>>> 2.
>>>>
>>>> - LED0 and LED3 modules assigned to the bank, and controlled
>>>>     by one LED class device,
>>>> - LED1 and LED2 modules controlled by separate LED class devices
>>>>
>>>> led-sources = <0 1 2 9 10 11> // Bank with LED0 and LED3
>>>> led-sources = <3 4 5>         // LED1
>>>> led-sources = <6 7 8>         // LED2
>>>>
>>>>
>>>> So now I see your point. It would be indeed easier
>>>> to switch to LEDn module identifiers for led-sources
>>>> elements. With that the definitions would look like
>>>> this:
>>>>
>>>>
>>>> 1.
>>>>
>>>> - LED0, LED1, LED2, LED3 modules controlled by separate
>>>>     LED class devices
>>>>
>>>> led-sources = <0>   // LED0
>>>> led-sources = <1>   // LED1
>>>> led-sources = <2>   // LED2
>>>> led-sources = <3>   // LED3
>>>>
>>>> 2.
>>>>
>>>> - LED0 and LED3 modules assigned to the bank, and controlled
>>>>     by one LED class device,
>>>> - LED1 and LED2 modules controlled by separate LED class devices
>>>>
>>>> led-sources = <0 3> // Bank with LED0 and LED3
>>>> led-sources = <1>   // LED1
>>>> led-sources = <2>   // LED2
>>>>
>>>
>>> This is exactly how I submitted the code.
>>>
>>>>
>>>> But, I don't think use of led-sources is justified in
>>>> this case. I propose to introduce device specific properties:
>>>>
>>>> ti,led-module and ti,led-bank
>>>>
>>>> With that we would have:
>>>>
>>>> ti,led-bank = <0 3>   // Bank with LED0 and LED3 modules
>>>> ti,led-module = <1>   // LED1
>>>> ti.led-module = <2>   // LED2
>>>>
>>>
>>> We are now aligned.  I can change the led-sources to the TI specific if there are no further objections.
>>> In doing this I can eliminate the ti,control-bank property.
>>>
>>>>
>>>>>> I would also add Table 1 contents (Bank Number and LED Number
>>>>>> Assignment) to the DT bindings.
>>>>>>
>>>>>
>>>>> Should I add that to the DT binding or reference the data sheet table since this driver will support 4 different devices
>>>>> with varying number of outputs from 18-36.
>>>>
>>>> My first thought was to show full table, but four different
>>>> mappings would add too much noise. So the reference to the data
>>>> sheet should suffice.
>>>>
>>>
>>> OK
>>>
>>> One last question I am going to add the LP5036 and 30 which have the same technology but slightly different register maps.
>>> Should I rename the driver to LP5036.c as the 30, 24 and 18 would technically be subsets?
>>
>> How about leds-lp50xx.c ? You can also create a library like
>> drivers/leds/leds-lp55xx-common.c if that would simplify the code.
>>
> 
> A library would be overkill.
> Is it just the DT that we don't want to use wild cards in naming?

DT is for concrete board and cpu, so it doesn't make sense to
use wildcards in *.dts file names.

> leds-lp50xx.c is a fine name to me.

Apart of that, I've been also mulling over if we shouldn't go for single
"color" sysfs file for setting r,g,b components at one go.
I don't see any downsides. There is no risk that number of elements will
grow, and the benefit will be an atomic way of setting color - the
feature people are looking for. Vesa was mentioning the case where lack
of it had been a real problem [0].

Let's check the usability of such interface.

[0] https://lkml.org/lkml/2019/1/4/519

-- 
Best regards,
Jacek Anaszewski
