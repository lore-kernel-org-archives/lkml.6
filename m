Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394FD20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqx58eb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfAaUy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:54:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38406 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:54:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so3905072lja.5;
        Thu, 31 Jan 2019 12:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFk/DX/ULfEl8X+0P94v0NQvGoL8TGkJJxtD0i8lWqM=;
        b=Qqx58eb/6BvzGPrh2FJfu5eWZ3yLTuxsEHY7EqWRBmMPc9R1N9mnKBgyhSFZui/Oty
         f5vho2V9r1OthLt6CjZNyFIw4FVjghzhaxMBvrBnU8KKS49RypTsAjq2yrncNmNaaM5H
         ShzQTij3arcRXRHUnm/5fHGtFKzZML6n5OZivYOgHeuduCDkFtUaySgR5z+5g6U86xZF
         9oeFGMlUgaVCt8HawjGDlYxAlAfzvxmmp9/5vPQGneTzgrZHztNKb48FanECI1N1f57n
         jZ9SOC2sRhFtzNjS1Xo/FLzyKK4eivD3yOCIjveQmHYlPV0UbFsXl9S3Z1rz9w4h9rCc
         NbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFk/DX/ULfEl8X+0P94v0NQvGoL8TGkJJxtD0i8lWqM=;
        b=Jgwm/sFAHCW7kmjW3GT5qizsQ3s0yNsX1ZWgFPYH19j2lycRRigAloNM2CzqJOQ1rl
         +6IvkD1mlhZZw39cRGEEVPzTGhM6zXfHEn88rs2hNVtYMUJAHg1n8Z+kXNyZ61rZ8RDp
         RPLMkACMwkyINXWYFfRkETk0cSEJ8/3moh70+g9hzBBdbFtbeUg8h3j2x1+waUFn9hPZ
         yshMk6T35JLNt7D9dWbwaWVM11lpiJ2Ujz+fyUHH7kAzJExvQJUrpA3cBpoc5cTBTc3w
         lnRt6AtEpcfj3BoGWiF0D7T3wOA75BXwVf4o5KKuul8doqp1TrUS2qpTeGlI9eicB+yO
         h0MA==
X-Gm-Message-State: AJcUukct/mdxFc+SRPjPUK5ksfCs2EP2ynwC9URkzzxN9qZDAjmtxjSK
        03PEztaHQbZQLTUoB0K4kpU3gXn6
X-Google-Smtp-Source: ALg8bN4PH+2HgVOkCzUssVc1X4ZSzSc1LsOMio7SFW/Xg/ubms0TTazGPQrxd2zt4uRHva5oA/nFNQ==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr29347297ljb.52.1548968064799;
        Thu, 31 Jan 2019 12:54:24 -0800 (PST)
Received: from [192.168.1.18] (chf233.neoplus.adsl.tpnet.pl. [83.31.3.233])
        by smtp.gmail.com with ESMTPSA id a2-v6sm981832lji.13.2019.01.31.12.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 12:54:24 -0800 (PST)
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190130183005.833-1-dmurphy@ti.com>
 <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
 <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
 <c65ca84d-8054-2244-1899-e4a9cb0842da@gmail.com>
 <138450e2-9082-6986-a89b-0028dca0d365@ti.com>
 <8b701a97-f945-488d-8bf3-d2efe400e30c@gmail.com>
 <385e4fc9-91cc-176c-730b-c27628027e2e@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9c813441-378b-b404-c364-ee8271aca4d9@gmail.com>
Date:   Thu, 31 Jan 2019 21:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <385e4fc9-91cc-176c-730b-c27628027e2e@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 1/31/19 2:48 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/30/19 4:14 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> On 1/30/19 10:07 PM, Dan Murphy wrote:
>>> Jacek
>>>
>>> On 1/30/19 2:20 PM, Jacek Anaszewski wrote:
>>>> Dan,
>>>>
>>>> On 1/30/19 8:59 PM, Dan Murphy wrote:
>>>>> Jacek
>>>>>
>>>>> On 1/30/19 1:37 PM, Jacek Anaszewski wrote:
>>>>>> Hi Dan,
>>>>>>
>>>>>> Thank you for the RFC.
>>>>>>
>>>>>> One vital thing is missing - documentation of brightness file must
>>>>>> be updated to define its semantics for LED multi color class.
>>>>>>
>>>>>> Either we need brightness-model file returning only "onoff" option
>>>>>> available, or, for time being, fix the max_brightness for LED multi
>>>>>> color class to 1 (which will map to max intensity level for each color).
>>>>>>
>>>>>
>>>>> I can make max_brightness default to 1 if not set by the LED driver.
>>>>>
>>>>> But the LP50xx has brightness controls so setting max_brightness from the driver should over ride
>>>>> the max of 1 in the upper level.
>>>>
>>>> Yes, so the max_brightness should be updated basing on current
>>>> brightness-model. For LEDn_BRIGHTNESS of LP50xx we could have
>>>> "hw" or maybe even better just "lp50xx-linear" and "lp50xx-logarithmic"
>>>> - I just forgot about that capability of the device.
>>>>
>>>
>>> OK maybe "hw" would make sense as there may be other devices that have dedicated brightness controls
>>> over color controls.
>>
>> Single "hw" doesn't address both linear and logarithmic.
>> This is device specific, so I don't see anything wrong in
>> "lp50xx-*", provided that it will be documented.
>>
> 
> OK.  This would need to be lp50xx specific.

Thinking more of it - "hw_logarithmic" and "hw_linear" should also do.
It would be even better option as it is generic.

My only concern here is how to document them. I we chose lp50xx-*
prefixed names, then we could just refer to the data sheet.

For generic hw_{logarithmic|linear} brightness models we will need
precise description. Actually it will be needed also for DT provided
color levels. People must have good reference to know how to arrange DT
color arrays.

It would be best to refer to standards, e.g. CIECAM02 [0], description
of hue [1] and the overall relationship between "six technically defined
dimensions of color appearance: brightness (luminance), lightness,
colorfulness, chroma, saturation, and hue." I've found also interesting
presentation [2].

After we agree on the interface I can try to put these together.

>>> Probably need to create a model for non-modeled cases like "rgb-independent".  Dumb name but I could not
>>> think of anything better.
>>
>> There is no point in having any rgb* brightness model since increasing
>> rgb in an arbitrary way will not give the impression of increasing color
>> intensity (lightness of the same hue). With DT defined hsl-<color>
>> ranges there is no way to verify that levels arrangement makes sense
>> with regard to preserving hue, this is a matter of trust. But we should
>> state that it is highly recommended to obey this constraint so as to
>> not mislead users.
>>
> 
> OK.  I will document this in v2 for discussion
> 
>>>>> For devices that do not support brightness as a separate control we can create a file called
>>>>> max_brightness_<color> that defines the max that a specific color can be set to.  If max_brightness
>>>>> is set to 1 then create max_brightness_<color>.  If max_brightness > 1 then do not create the files.
>>>>
>>>> Right. We will need dedicated max_brightness for each color.
>>>> They should be placed also in the colors directory, next to the color
>>>> files.
>>>>
>>>
>>> OK will document this.
>>>
>>>>> I don't think we have fully vetted the brightness-model yet so I prefer to omit
>>>>> it and possibly introduce that later.
>>>>
>>>> We need to start from something. It will give better overview of the
>>>> whole idea.
>>>>
>>>
>>> OK.  Don't get me wrong I don't oppose this idea I am just trying to figure out how the user space would
>>> know what models and brightness levels are available.
>>
>> $ cat brightness-model
>> lp50xx-linear lp50xx-logarithmic onoff hsl-green hsl=blue
>>
>> max_brightness will return available number of brightness levels
>> for each brightness model.
>>
> 
> So max_brightness here would be dynamic?

Yes.

> Or could we read hsl-<color> and get the number of levels and not mess with the max_brightness definition?

For hw_{linear|logarithmic| it will return the brightness resolution
supported by the hardware.
For hsl-<color> (or whatever we will call it) it will return the number
of elements in the array the currently chosen brightness-model refers
to.

> Or should that be the current level?

Hmm? Current level will be available after executing "cat brightness".

>> I'd not bother with presenting whole range of available color
>> presets. Userspace can verify the brightness->color mapping
>> by reading colors/<color> files after setting given brightness
>> level.
>>
> 
> Userspace would have to have knowledge of the values set in order to verify the
> color values.

For the single element array:

some-color-model = <0xaabbcc>;

user will get this:

$ echo some-color-model > brightness-model
$ echo 1 > brightness
$ cat colors/red   // prints 0xaa
$ cat colors/green // prints 0xbb
$ cat colors/blue  // prints 0xcc

>> However, I'm not sure how useful it will be. This is a gist
>> of this whole discussion - we cannot be certain about exact
>> color effect produced with given settings.
>>
>>> I mean we can read the brightness-models and present the available models but then how does the user know
>>> what and how many levels are in each model?  And how do we govern putting them in the right order?
>>
>> `cat max_brightness` will return number of levels for the model
>> currently set. Regarding the order - we must rely on the DT array
>> arrangement. In case of hardware originated brightness model we
>> must trust hardware implementation.
>>
> 
> Another question on this is what is the proposed definition of the DT value?
> 
> is it supposed to be 0xrrggbb?  What about other colors like Amber?
> This was demonstrated in one of the videos you sent.
> 
> Maybe it should be rgb-<color> and not hsl-<color> because these values are not hsl values
> but instead RGB values.

Right, it should be possible to have even more than 4 LEDs
in the LED multi-color class device. We shouldn't also limit
the number of brightness levels for a single LED to one byte,
as current framework also doesn't do that.

For 5 LEDs in the cluster, the array containing three
brightness level would look like below (dummy values):

purple-linear-0 = <198 323 442 238 43 90>;
purple-linear-1 = <200 323 442 238 43 90>;
purple-linear-2 = <398 323 442 238 43 90>;

One more thing related to the brightness-model interface -
instead of a file it must be a directory with files named
after colors ranges defined in DT. There is PAGE_SIZE limit
imposed on the sysfs file size, and we already had a report
about crash caused by triggers file size that exceeded this
limit due to large number of cpus available on the platform,
that created equally large number of cpu triggers.

Also, if we will have those files, we will be able to report the number
of available brightness levels per each color range.

>>> The DT file can get messed up, per the previous example
>>> rgb-green = <0x277c33 0x37b048 0x47e45d>;
>>>
>>> This is assumed to be from dimmest to brightest.  But that is just an assumption
>>>
>>> What if the entry looked like this?
>>> rgb-green = <0x37b048 0x277c33 0x47e45d>;
>>
>> We can do nothing. It is just the cost of leaving some decisions to DT.
>>
> 
> <snip>
> 
>>
>> I intended that brightness-model location would be the main LED class
>> device directory.
>>
>> And the whole concept is simple. We allow to set what we get from DT
>> or from the hardware. Without verification exceeding beyond
>> max_brightness values defined per iout.
>>
> 
> Yes this is simple will put some documentation around it for discussion
> 
> Dan
> 

[0] https://en.wikipedia.org/wiki/CIECAM02
[1] https://en.wikipedia.org/wiki/Hue
[2] http://rit-mcsl.org/fairchild/PDFs/AppearanceLec.pdf

-- 
Best regards,
Jacek Anaszewski
