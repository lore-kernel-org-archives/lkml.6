Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB220859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGzAqKVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfAIUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:12:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50394 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:12:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so9042210wmd.0;
        Wed, 09 Jan 2019 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QoKPM71EVonZG4/FyzOFXF6S56rv0kzUARvk+gy0T+Q=;
        b=bGzAqKVCtuTOfUFuMgQQ0FP0tW+Y7mwFPcVTGyUcWqSMcEpElMLPvuxrTIlcUsm+wG
         33ryf6K3sxXSbpZTrMLiavYQCmyPJVeS4lYaV8/SlwpbsdyPMJ2032V0nwgwwNpRscvt
         xOUV2SMmIAzL7HPtVB1DwslOg8M76A+gnb7chse4YB/ITjPeM3JFqk6uj7MG+ScClH3H
         ZXAaMlcG+YJ4+YsqiYjzhoAXoHIoiUm6zZl+mCslNKjsRHZDypMfzfyEl879YjOYrHwG
         V2ErG67X5spOad1WPo67blavN3KWf85IHwiGcvzxDeS09eJ5CwCJyKHCt8GqnCVhY/3c
         2RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QoKPM71EVonZG4/FyzOFXF6S56rv0kzUARvk+gy0T+Q=;
        b=dyl30/XlkPjIxQvT27vTzA+gTSsYDddc3Hd7kjCn9eYUi+XKV8/Urihz+DXbfBUoQ9
         HAUmYYXBxB0zF6XbbWALM32W5zWbOq8xkf6r8zYcuC3C/laaAPyUcXeW4x9Q90i4JGhZ
         oXeo1Csp2OQ3g6qiXVp9DPq1bNfLaUxB+d7RA58N5ZbRrGb0mAJ6OnHZcUHhK9pITdnI
         KPU6H2Q871LmBklcZ8dN3NTkLcGRh1LNpb9xmXHy31tgtqU7O/yhUNpN6E/CPB2Mf2xK
         GS6UMV9bqygkiD3YsUhrJUixfPsqjarnCcT8BLht/GU094gyC4oO/VDyAm7pzPR6IPAn
         eCQA==
X-Gm-Message-State: AJcUukdQ0Om88CtRksXqfqDBNp479op9Z6DnLdvw+nlS+A4E6xVo/4H6
        V/Fg2HNE7XoUw2LFbNIJfQdCzbdq
X-Google-Smtp-Source: ALg8bN73708JZltPiHyEfVbYxGi8Uokuiqp7q/zteqIcri+9VQ6AoT0DS89koM0u4kl6EyUIrDAGEQ==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr7505633wmg.48.1547064739429;
        Wed, 09 Jan 2019 12:12:19 -0800 (PST)
Received: from [192.168.1.18] (chc231.neoplus.adsl.tpnet.pl. [83.31.0.231])
        by smtp.gmail.com with ESMTPSA id z7sm56752780wrw.22.2019.01.09.12.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:12:18 -0800 (PST)
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
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <df59c10d-7038-cb4a-45f0-7420254c6398@gmail.com>
Date:   Wed, 9 Jan 2019 21:12:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <366cbf6d-94fa-fea9-be58-07ddb09cff3a@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 1/8/19 10:22 PM, Dan Murphy wrote:
> On 1/8/19 3:16 PM, Jacek Anaszewski wrote:
>> On 1/8/19 9:53 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/8/19 2:33 PM, Jacek Anaszewski wrote:
>>>> Dan,
>>>>
>>>> On 12/19/18 5:26 PM, Dan Murphy wrote:
>>>>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>>>>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>>>>> or as part of a control bank group.  These devices have the ability
>>>>> to adjust the mixing control for the RGB LEDs to obtain different colors
>>>>> independent of the overall brightness of the LED grouping.
>>>>>
>>>>> Datasheet:
>>>>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>> ---
>>>>>     .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>>>>     1 file changed, 63 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>> new file mode 100644
>>>>> index 000000000000..9567aa6f7813
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>>>> @@ -0,0 +1,63 @@
>>>>> +* Texas Instruments - LP5024/18 RGB LED driver
>>>>> +
>>>>> +The LM3692x is an ultra-compact, highly efficient,
>>>>> +white-LED driver designed for LCD display backlighting.
>>>>> +
>>>>> +The main difference between the LP5024 and L5018 is the number of
>>>>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>>>>> +LP5018 supports eighteen strings.
>>>>> +
>>>>> +Required properties:
>>>>> +    - compatible:
>>>>> +        "ti,lp5018"
>>>>> +        "ti,lp5024"
>>>>> +    - reg :  I2C slave address
>>>>> +    - #address-cells : 1
>>>>> +    - #size-cells : 0
>>>>> +
>>>>> +Optional properties:
>>>>> +    - enable-gpios : gpio pin to enable/disable the device.
>>>>> +    - vled-supply : LED supply
>>>>> +
>>>>> +Required child properties:
>>>>> +    - reg : Is the child node iteration.
>>>>> +    - led-sources : LP5024 - 0 - 7
>>>>> +            LP5018 - 0 - 5
>>>>> +            Declares the LED string or strings that the child node
>>>>> +            will control.  If ti,control-bank is set then this
>>>>> +            property will contain multiple LED IDs.
>>>>> +
>>>>> +Optional child properties:
>>>>> +    - label : see Documentation/devicetree/bindings/leds/common.txt
>>>>> +    - linux,default-trigger :
>>>>> +       see Documentation/devicetree/bindings/leds/common.txt
>>>>> +    - ti,control-bank : Indicates that the LED strings declared in the
>>>>> +                led-sources property are grouped within a control
>>>>> +                bank for brightness and mixing control.
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +led-controller@28 {
>>>>> +    compatible = "ti,lp5024";
>>>>> +    reg = <0x28>;
>>>>> +    #address-cells = <1>;
>>>>> +    #size-cells = <0>;
>>>>> +
>>>>> +    enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>>>> +    vled-supply = <&vbatt>;
>>>>> +
>>>>> +    led@0 {
>>>>> +        reg = <0>;
>>>>> +        led-sources = <1>;
>>>>> +    };
>>>>> +
>>>>> +    led@1 {
>>>>> +        reg = <1>;
>>>>> +        led-sources = <0 6>;
>>>>> +        ti,control-bank;
>>>>
>>>> Do you really need ti,control-bank? Doesn't led-sources array size
>>>> greater than 1 mean that the node describes control bank?
>>>>
>>>
>>> That will work too.
>>
>>>> Also, does it make sense to have only two LEDs in the bank?
>>>
>>> The array can populate all 7 LEDs in a single node.  I only show 2 here as the example.
>>> See the description above of the led-sources
>>
>> OK, I confused RGB LED modules with banks.
>>
>> Shouldn't we allow for defining either strings or RGB LED
>> triplets somehow then?
>>
> 
> Well that is what this should be doing.  If you define a single LED in LED sources then
> the triplet is controlled via the associated LEDx_brightness register.

led-sources should map to iouts directly.
So, for RGB LED modules I would expect:

LED0: led-sources = <0 1 2>;
LED1: led-sources = <3 4 5>;
LED2: led-sources = <6 7 8>;
and so on.

for banks:

Bank A with iouts 0,3,6,9: led-sources<0 3 6 9>;
Bank B with iouts 2,4,10:  led-sources<2 4 10>;
Bank C with iouts 5,8,11,14,17: led-sources<5 8 11 14 17>;

We could additionally mark banks with ti,control-bank,
but I'm not sure if it would ease parsing, since
you will have to validate iouts configuration anyway.

> If you have multiple LED sources defined in the led-sources then those LEDs would be grouped in the bank.
> I guess I need to provide some protection or a warning if a DT defines two banks because there is only one bank control.

Does the hardware allow the IOUT to belong to an RGB LED module
and to a bank in the same time?

-- 
Best regards,
Jacek Anaszewski
