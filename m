Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438E5206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWKWU+Zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438E5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeKNFCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:02:01 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:45736 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725750AbeKNFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:02:01 -0500
Received: by mail-lf1-f52.google.com with SMTP id b20so9628329lfa.12;
        Tue, 13 Nov 2018 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+DD0dZ1QmqZM/8X3A2as94pDSt+U0wRI8dLBS9D9n0k=;
        b=LWKWU+Zs6ySvGxOfJ6PwF1oNJ/2ELlUnLBwXFz7LZY9RC6MQpsJ/MqZVic8YfIay6c
         FYg0jDMKap50CjDkocrw0YVwEy6u36py6mte4mZPzqeI2Ql6v4L5iWadqnjzOjlFgbwy
         nSjw90S1Vm8EFZopoZAnmTJFVjq46Hhe6g7iSn7VZs2cxJ1ENhiedpvSFLD6cJdnlDTy
         TsgFy6ziTrRIb3CgaOL3tph11S7uj49XGuay3Scm7XjquPjBnD8HGY5SCBj8x7FIH5SC
         1cS3kgajb7koFjyySuJL5AHvFY4DSuPIsFFuRBrmWR6soNBCYB5Q9uSL+U+g4EKftIw1
         aIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+DD0dZ1QmqZM/8X3A2as94pDSt+U0wRI8dLBS9D9n0k=;
        b=Yr72S4pZ+8RVUyarW/cf7PE4kUWmfoi/jasK2VtDrxAkMQH0SGTJMEd3lzakIBZCWD
         XzLM4grYeKTkCFlhwsjXx3L2I+d6RRwN2HewDk6MggpjrvJYNgZ1PdgKIPU/IhQiHa97
         TilOlLn36BbrACY62oiHEHkQ5V3FoB88NPfXgRcFuwmTZITOUL5y4OYo9mGhSleXiY+T
         CSCOdC8qoqaeUlqU1buaJKe4nGY/EMod/Q5B5nxyCs7v+Ljy2zvGhqmzGmbzmzJl4af4
         o1AAYatovAoOzdesxEkUEJaKPdbCnxZCu86UzPRuk2DM8tV80tWl61AqLKtS1zbjEEqC
         yciw==
X-Gm-Message-State: AGRZ1gJlkSclpI36yiB/W4gf4CaoO9GgW7WBe0dQ1VKMtwQ9cZHEq2Kx
        0DUpjTsTqOzlNJXEpBfc2wk=
X-Google-Smtp-Source: AJdET5cqRxYJJx7F2LA9s7ODBgVrQVN31y86yfG6c8argKDPFxCUOcErEtX6rAjKYCkNqRpzN3BsfA==
X-Received: by 2002:a19:a302:: with SMTP id m2mr3849952lfe.108.1542135751938;
        Tue, 13 Nov 2018 11:02:31 -0800 (PST)
Received: from [192.168.1.18] (dma68.neoplus.adsl.tpnet.pl. [83.24.56.68])
        by smtp.gmail.com with ESMTPSA id y9sm391838lfe.75.2018.11.13.11.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:02:31 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <bdd18dc6-0dee-5957-81d4-39254c7ad74d@gmail.com>
 <be4e75ed-746e-ed55-0bbe-0fd710bd4162@gmail.com>
 <12fb34ec-7175-1ac4-a96e-e1d5d424c9eb@gmail.com>
 <d1ef315d-1216-7e63-f24f-5c6fee8793be@gmail.com>
 <95bcc400-da1a-1334-1f4f-f628eca926b3@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4ceaea73-45f1-d5a3-0702-078c5bb3e3be@gmail.com>
Date:   Tue, 13 Nov 2018 20:02:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <95bcc400-da1a-1334-1f4f-f628eca926b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 11/13/2018 08:10 AM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> On 12/11/2018 18.02, Jacek Anaszewski wrote:
>>>> Support for RGB LEDs, or other variations of LED synchronization
>>>> have been approached several times, but without satisfying result
>>>> so far.
>>>>
>>>> Generally the problem boils down to the issue of how triggers
>>>> should handle multiple synchronized LED class devices in a backwards
>>>> compatible way with monochrome LEDs.
>>>>
>>>> At some point the HSV [0] approach was proposed, but there was a
>>>> problem
>>>> with getting uniform colors across devices. Especially white.
>>>> Certainly a calibration mechanism would be required.
>>>>
>>>> [0] https://lkml.org/lkml/2017/8/30/423
>>>
>>> We do not usually use PWM controlled leds so our calibration has been HW
>>> engineer tuning the resistors for the leds to get acceptable color for
>>> different colors variations.
>>>
>>> If one wants to have fixed colors for such device then one could use
>>> this similar method to define them or/and free form interface to enter
>>> RGB values there. Thou with PWM RGB leds you probably want to have more
>>> animation there which probably would require some additional support
>>> code.
>>>
>>> One way to do atomic PWM RGB color change with sysfs could be:
>>>
>>> echo "21 223 242" > color
>>>
>>> or
>>>
>>> echo "21 223 242" > rgb
>>>
>>> or:
>>>
>>> echo "r:21 g:232 b:242" > color (or something similar)
>>>
>>> and if there is know registered name then just write it to "color" which
>>> would pick registered color rgb values to led instances rgb value.
>>>
>>> Now for PWM RGB led one could use "brightness" and "rgb" value to
>>> calculate actual color with some color space formula (like hsv in [0]).
>>>
>>> Doing white with RGB LED is a bit hard so usually you want to get RGBW
>>> LED (or RGBAW LED) if "real" white is something that is needed. This
>>> could then be "rgbw" entry and "color" to pick from fixed set.
>>>
>>> These presets in device tree for "color" could be considered one way of
>>> doing calibration for particular hardware.
>>>
>>> So in device tree for RGB PWM led it could be like:
>>>
>>> color-orange {
>>>      rgb = <249 197 9>
>>> }
>>>
>>> color-warm-white {
>>>      rgb = <255 253 249>
>>> }
>>>
>>> How would that sound like?
>>
>> Thank you for the description of your approach.
>>
>> Predefined DT color definitions make an interesting option. Nonetheless,
>> your design assumes that for RGB LEDs max_brightness would have to be
>> always 1.
>>
>> While it would solve the issue, it wouldn't allow to benefit from
>> the whole potential of RGB LEDs - think of having adjustable "color
>> brightness" (like in HSV color model).
> 
> What I tried to describe above was that these could also work with HSV
> model also with larger brigtness values too.
> 
> Let's say we do following sequence to change from off state to user
> configured intensity value:
> 
> # Turn off leds
> echo 0 > brightness
> 
> # Select requested color
> echo "orange" > color
> 
> # Use configured LED intensity from user configuration
> echo 84 > brightness
> 
> Driver would now use rgb value <249 197 9> and brightness <84> to
> calculate (with HSV solution) real PWM values for the led component
> colors. With led controller this is probably easier to get linear
> feedback but for generic PWM controller you may want to utilize PWM
> curve feature like defined for backlight driver.
> 
> When thinking this I instantly see my self with thinking PS4's
> sliding/pulsing color animation for orange/blue/white. And controlling
> this animation steps manually from user space probably is not the best
> idea so like with blinking you would need more accurately timed action
> within kernel I suppose (or hardware with the support).
> 
> With that idea forward:
> 
> # Turning animation sequencer off causes instant changes for values
> echo "off" > animation-sequencer
> 
> # User 1 second for animation (no effect yet as sequencer is off)
> echo 1000 > animation-time-ms (or so)
> 
> # Turn off leds (instance change)
> echo 0 > brightness
> 
> # Select requested color (instant change)
> echo "orange" > color
> 
> # Change to linear animation sequencer
> echo "linear" > animation-sequencer
> 
> # Now everything from this point is subject to animation sequencer
> # Sequencer remember active state and next state (as seen in sysfs)
> 
> # Use configured LED intensity from user configuration (no effect yet)
> echo 84 > brightness
> 
> # Trigger transition sequence
> echo load > animation-sequencer
> 
> # This would cause 1 second animation from black to orange with user
> intensivity of 84
> 
> # Wait for transition to complete and some extra
> sleep 4
> 
> # Change color to blue with animation
> echo "blue" > color
> echo load > animation-sequencer
> 
> # This would cause driver to change from orange to blue in current
> intensivity level during 1 second period
> 
> # -- end --
> 
> Now that went a bit ahead of time but I believe it demonstrates the
> potential for this approach with combined with HSL functionality for
> future.

We have just contributed pattern trigger - it could be adjusted
to RGB LED purposes too.

See drivers/leds/trigger/ledtrig-pattern.c and
Documentation/ABI/testing/sysfs-class-led-trigger-pattern in
Linus' tree.

>> How abut allowing for providing an array of color intensity/brightness
>> levels per each color? In the simplest case there could be a single
>> level per color, but it should be possible to provide up to 255 levels.
> 
> I believe that brightness and color should be separate topics.

I didn't make myself clear enough - I like the approach with the
color sysfs file. By the "color brightness" I mean color arrays,
that would have to be defined per each color. Elements of such an
array would make the "color brightness/lightness" range.

> We have in our devices option in user interface to configure intesivity
> for backlight and in one device also intensivity for status led (this is
> the only PWM led we have :)). (I believe this might be currently
> implemented without actual led driver and directly use PWM interface)
> 
> Even in when reduced intensivity we want the color to be set to
> specified value even thou it would not be as bright as full intensivity
> would be.
> 
> What do you think?

I think that we've just agreed the preliminary requirements for
a new RGB LED class interface.

-- 
Best regards,
Jacek Anaszewski
