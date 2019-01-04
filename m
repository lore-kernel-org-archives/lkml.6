Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCACC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90079218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNRL6SKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfADTNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:13:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44360 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfADTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:13:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so33231716lji.11;
        Fri, 04 Jan 2019 11:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73Q8cNz5hasJf/8oqZBTZzwSIYakJgxe/p4WVHgEhng=;
        b=rNRL6SKK7gObRn6OTGhTBQi+EIpafgpqciOO1oqxtjsA8hdq2iNuQVZWQ39XTY+4jB
         uKul3i+ExUc0YvTKuLnt5gF+sJz8ltPLiPHcThL6Or4BHGboeDL+trm4JGZ5ns30LUyL
         pXmEONGGJG5QZCZtpq+bCWcCiC63A+G5A5CAXtn4Jl/gKR1pFjmVzPn8Lm/lyvOo6fPY
         V88/2cCVLMGU1MBHYZMlBVQn79jwUZphVgCfL4j5RU3khN8YrlvHryrXE+SAFuWYFp6O
         GUZX0EjN35CIysOY4fNHduaz5cZ2wkAOiFnoCTt5MicUVf5quyqIDn1ANptAfpkMGPg9
         oKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73Q8cNz5hasJf/8oqZBTZzwSIYakJgxe/p4WVHgEhng=;
        b=DWAuE0YQiJbwSpYEPjt12SmQYw6KkR6Q5Oz/ASY9Cev7gT3nspYOoCYqujSaQ68HOe
         VACcKEMREIdhGJq5Ak5fCwyles0ayRoip2c8zLxQ86LnQAmeG9S/qaMNDJtisbyAQC/E
         CwrxWKmzUjmYt2kIV1hSsWiEkRQyG2qhCULmBlORlFjs/0nzWIKs0IoxMR0KnLuDehBW
         SMVUdzqdMcw/frQIiY1nCn5aGasj4gSVWsJywOrnBDOqbMEGmzuQ3TOCIkaLYClU5QrU
         bKWAYVlE2RhKPKgdoElf7IPe47Xx2e9wvqdvmTSTe8Ng5b9W/sxnQaULARg/WfdZqvQH
         tPBw==
X-Gm-Message-State: AA+aEWbi/8pJAWScX0JXyjMUWN0WE39Cj8OzU/fMtPxlTgeG6fdUyuhh
        Hegl+kzJpEsfM607yCeFQSvkd+Ky
X-Google-Smtp-Source: ALg8bN53E3Wd9bwvibSZa6iUEhcAYT/y/lafZNB/sUIdixi6lO4Cb9VXZbC8T/GFMOVxnF8nQHEVwQ==
X-Received: by 2002:a2e:9655:: with SMTP id z21-v6mr32588793ljh.136.1546629177115;
        Fri, 04 Jan 2019 11:12:57 -0800 (PST)
Received: from [192.168.1.18] (bgt246.neoplus.adsl.tpnet.pl. [83.28.83.246])
        by smtp.gmail.com with ESMTPSA id c133sm12537045lfc.45.2019.01.04.11.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 11:12:56 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com>
Date:   Fri, 4 Jan 2019 20:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vesa,

On 1/4/19 12:19 AM, Vesa Jääskeläinen wrote:
> Hi Jacek,
> 
> Comments below.
> 
> On 04/01/2019 0.05, Jacek Anaszewski wrote:
>> Hi Vesa,
>>
>> Thank you for sharing your ideas.
>>
>> Please find my comment below.
>>
>> On 1/1/19 2:45 PM, Vesa Jääskeläinen wrote:
>>> Hi All,
>>>
>>> On 20/12/2018 14.40, Vesa Jääskeläinen wrote:
>>>> Idea was to define preset colors in device tree as an example when 
>>>> you are dealing with multi-color LEDs without PWM. In that case you 
>>>> only have GPIOs to control and then have a problem what does those 
>>>> GPIO's mean.
>>>>
>>>> With preset definitions one can use color names to act as a shortcut 
>>>> to configure GPIO's to proper state for that particular color.
>>>>
>>>> For more flexible setups where you have PWM or such control you have 
>>>> larger space of available colors. In this case you need to somehow 
>>>> define also meaning of those controls.
>>>>
>>>> Also we may not have LED with only red, green and blue elements. 
>>>> There might in example be amber, ultraviolet, white elements.
>>>>
>>>> This is where device tree is concerned. It helps us craft the 
>>>> logical definition for LED so that we can control it from user space 
>>>> in common way.
>>>>
>>>> Now the next problem then is how does user space work then.
>>>>
>>>> For multi-color LEDs it it important to change the color atomically 
>>>> so that no wrong colors are being shown as user space got 
>>>> interrupted when controlling it.
>>>>
>>>> Also we have brightness setting that would be useful for PWM 
>>>> controlled LEDs.
>>>>
>>>> Setting color is easy when you use preset names then you only need 
>>>> to deal with brightness value (eg. RGB -> HSV * brightness -> RGB). 
>>>> Of course here additional problem is other color elements are they 
>>>> then scaled according to brightness value?.
>>>>
>>>> Setting color as "raw" values is then next problem. In order to do 
>>>> it atomically it needs to be one atomic activation and could be eg. 
>>>> one write to "color" sysfs entry with combination of all color 
>>>> elements and perhaps additionally also brightness value. Next 
>>>> question is then what is the format for such entry then? What are 
>>>> the value ranges? In here we can utilize device tree definition to 
>>>> help define what kind of LED we do have and what kind of 
>>>> capabilities it does have.
>>>>
>>>> Additional problem risen also in discussion was non-linearity of 
>>>> some control mechanisms vs. perceived color. So there might be a 
>>>> need for curve mapping similarly what is with backlight control and 
>>>> that would be defined either in device tree and possibly in user 
>>>> space if there is a need for that. I suppose golden curve definition 
>>>> in device tree should be good enough.
>>>>
>>>> Then there was additional discussion about possible animation 
>>>> support but I would leave that for future design as that would then 
>>>> be utilizing the same framework.
>>>>
>>>> I suppose color space handling and that kind of stuff should be in 
>>>> some led core functionality and then raw control should be part of 
>>>> physical led driver.
>>>>
>>>> I was planning to play with it during holiday season but lets see 
>>>> how it goes. Feel free to also experiment with the idea.
>>>
>>> I was playing with this and got some results with PWM LED driver. I 
>>> would like to get feedback now even thou it is not yet ready for 
>>> patch sending.
>>>
>>> They still need more work but the idea can be seen here:
>>> https://github.com/vesajaaskelainen/linux/tree/wip-multi-color-led
>>>
>>> This branch is now based on Linux kernel 4.20 release.
>>>
>>> Consider that branch as volatile as I will forcibly update it when 
>>> there are updates.
>>>
>>>  From there specifically in commits (while they last):
>>>
>>> drivers: leds: Add core support for multi color element LEDs
>>> https://github.com/vesajaaskelainen/linux/commit/55d553906d0a158591435bb6323a318462079d59 
>>>
>>>
>>> WIP: drivers: leds: leds-pwm: Add multi color element LED support.
>>> https://github.com/vesajaaskelainen/linux/commit/efccef08cbf3b2e1e49b95b69ff81cd380519fe3 
>>>
>>>
>>> What is there now:
>>>
>>> - led-core supports color elements
>>> - led-class supports users space configuration
>>> - both led-core and led-class are driver agnostic so they should be 
>>> treated as generic code.
>>> - leds-pwm: my testing code with PWM led.
>>> - no HSV support for brightness as there could be multiple color 
>>> elements out from traditional red-green-blue space or odd 
>>> combinations of colors and they are a bit hard to map to HSV formula 
>>> (and it needs fixed point math).
>>> - no color presets that could be optionally be selected
>>> - when I configure led trigger to heartbeat it actually blinks with 
>>> color specified -- thou trigger gets zeroed out with one sets new 
>>> color or brightness as that was previous functionality with brightness.
>>> - some documentation added
>>> - code should pass checkpatch
>>>
>>> What I was planning to do next:
>>>
>>> - cleanup PWM LED driver so that it works with and without 
>>> LED_MULTI_COLOR_LED being defined.
>>> - improve documentation
>>> - try out how my other device behaves which have dual color element 
>>> LED controlled with GPIO's and see how it would integrate to gpio-led 
>>> driver.
>>>
>>> I would like to get feedback on:
>>> - Device tree idea
>>> - Internal logic
>>> - Should the trigger be really reseted when one changes value of 
>>> brightness? I would think it should function like setting brightness 
>>> entry from sysfs would set current brightness for trigger when it is 
>>> lit. Setting color should change color and brightness and it should 
>>> be active from there one until trigger is disabled from trigger sysfs 
>>> node.
>>>
>>> My testing device has RGB LED with all color elements controlled with 
>>> individual PWM channels from TI's AM335x's integrated PWM controller.
>>>
>>> In device tree I have following:
>>>
>>>      multi-color-leds {
>>>          compatible = "pwm-leds";
>>>
>>>          status-led {
>>>              label = "status";
>>>
>>>              element-red {
>>>                  pwms = <&ehrpwm0 0 100000 0>;
>>>              };
>>>              element-green {
>>>                  pwms = <&ehrpwm1 0 100000 0>;
>>>              };
>>>              element-blue {
>>>                  pwms = <&ehrpwm1 1 100000 0>;
>>>              };
>>>          };
>>>      };
>>>
>>> For my second test device I was planning to replace "pwms" with 
>>> "gpios" or such entries.
>>>
>>> In user space one can use it like:
>>>
>>> # --- start of snippet ---
>>>
>>> hostname ~ # cd /sys/class/leds/
>>> hostname leds # ls
>>> status
>>> hostname leds # cd status
>>> hostname status # ls
>>> brightness      color           device          max_brightness 
>>> max_color       power           subsystem       trigger         uevent
>>> hostname status # cat color
>>> brightness=0 red=0 green=0 blue=0
>>
>> This breaks one-value-per-file sysfs rule.
> 
> I believe you are referring to this text in:
> https://www.kernel.org/doc/Documentation/filesystems/sysfs.txt
> 
> "Attributes should be ASCII text files, preferably with only one value
> per file. It is noted that it may not be efficient to contain only one
> value per file, so it is socially acceptable to express an array of
> values of the same type."
> 
> I suppose if one would just make it an array of values (separated by 
> space) and then one file with string array of color element names and on 
> file with maximum value array it could be within those words.
> 
> The it would be something like:
> 
> $ echo "23 54 32" > color

Go ahead, but first convince Pavel, and then Greg :-)

I'd personally would not have much against, especially that the
list of values will not grow for that one like in case of old patch set
[0] where Pavel and Greg thwarted my similar attempt.

> $ cat max_color
> 255 255 255
> 
> $ cat color_names
> red green blue
> 
> In addition to this -- one could also export individual color element 
> files.
> 
>> Regarding led_scale_color_elements() - I checked it in GIMP and
>> the results are not satisfactory when increasing brightness.
>> Even if we managed to fix it, the result would not be guaranteed
>> to be the same across all devices.
> 
> No and they will never be the same. I was told by our hardware expert 
> that it is rather impossible to get linearly behaving LED control 
> without special curve fitting trimmed for particular hardware and LED 
> component in use. And if you go and change LED component/vendor it would 
> need to be "calibrated" again if such accuracy would be required. Also 
> LEDs age and that has also effect on this.
>> This is still the same problem.
>>
>> I have another proposal, being a mix of what has been discussed so far:
>>
>>     RGB LED class will expose following files:
>>     a) available by default:
>>       - red, green, blue
>>         Writing any of these file will result in writing corresponding
>>         device register.
> 
> Problem with this is that we are basically back at square one and one 
> cannot do "atomic" color change with this.
> 
> In order to set or activate new values one would need "load values" file 
> or such that when writing to it would activate new values. However it 
> becomes quite clumsy interface at that point as you need to handle 
> multiple writes to multiple files and makes those operations rather slow.
> 
> Then we have color presets left that could kinda solve the issue on 
> setting the color to fixed values atomically.

That's why I proposed "color_space" file that is also a part of my
proposed design below.

> Of course one direction is what happened with gpio driver was own device 
> node with ioctl's allowing more faster and more fancier control.
> 
>>       - color_space: it would accept color space, e,g. "hsv", that would
>>                      have to be supported by LED RGB core; setting color
>>                      space would create relevant files, e.g. for hsv
>>                      hue. saturation, brightness, and remove default ones
>>                      other "color spaces" could be defined in DT as
>>                      proposed by Vesa; reading this file would print
>>                      available color spaces
>>
>>     b) available conditionally:
>>       - brightness
>>        It will be exposed by devices that have hardware support for
>>        changing color brightness, like lp5024, or it will be made
>>        available after setting relevant color space, like "hsv", or
>>        other color presets defined in DT
>>
>> I think it will be flexible enough to meet everyone's needs.
>>
>> Current triggers would work only when brightness file is available.
> 
> Or we could transition it in that case to simulated "on/off" type of 
> thing. As that is what triggers more or less use.
> 
> When "on" LED would have its configured color and when "off" LED would 
> be turned off (eg. values of zero).

Yeah, it would be even better solution.

[0] https://www.spinics.net/lists/devicetree/msg69730.html

-- 
Best regards,
Jacek Anaszewski
