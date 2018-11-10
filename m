Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9836B20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3mR4Bgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9836B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeKKDE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:04:59 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46708 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKDE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:04:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so3460555lfc.13;
        Sat, 10 Nov 2018 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UBeIG5pLr0Dg+OdVPBZ2BFz/7EgoqBl5mh970C43Bfo=;
        b=D3mR4BghpFJ1TpyjgpVNnl0wrz8FtDpfVRnmBeJKWZDP0ayzJDr1wIClIUc8zyk3tZ
         qPqjDuD08vgRzPhlZ6yVnqPES2YSQjIXfCrP1M7TK4vTK6+/2PweyzIlsrKlk93l3eDK
         BfsMmX5XrEo0JcIf2dOpzSgr21+wxbxKoW9x4wDsDpZgzqimghpGK5MpjL4nei7RTo3Z
         ikSM9vABp4c0PE2Bu4tcgbSXQalWoh5im1CZUlWX/oFtWH4ndtgCDlSxlcOU0QMYxDAH
         jonXCDzwXsH8bDiwGpKh/auPdK8A8Vnx3PHIaNpz50tciB0VDdLQVfzZMhyydka8qnvi
         GuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UBeIG5pLr0Dg+OdVPBZ2BFz/7EgoqBl5mh970C43Bfo=;
        b=PX4g0UDw6B2x8sbfxA7X87sMn1EfXPn/Cpe4GRU+Ak/OXm2mDAKbBO2glvMdt24jGg
         9JQcPUNu2XL6YpzAGS5OiVqSl+kUczPJAOscrpDDYEMK7YdOyYV1DtqXfwtqzBBFsZKC
         R+kCoyTPqYMI49oHehXLXsLN657fGJ5JcZGI4ztk59McfvzMUEZG5ztiCuhTbGuyCDw8
         0VegEK2s6vFTvrwbbjT2Q1JrYhZEi/Oio/zM3XCCmvPEsi7WeiaDFcwvKUL4/z7GBFEk
         Lza3myaFexzvyTYyO39WlXUuSQH/Ndpzpn5yM9PPwHeYJK4/XLbEQoOQdUJ/3XErjQfP
         AW3w==
X-Gm-Message-State: AGRZ1gKoVcKzq26IRDumFoXgXf3SykiMxmFoEFWzLkTsJkRoQ3I27Iuc
        Pq731uhj58u+LOpxP49FG3o=
X-Google-Smtp-Source: AJdET5eegYj9N0yC0YrWW478fRK5ulr8IAIFQFCId1ZMLckR5hx8WlI1jjrSwXdwgwTvctwSYrazpQ==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr7507807lfd.74.1541870352535;
        Sat, 10 Nov 2018 09:19:12 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:58f8:2a29:cd37:bd01? (dtynxhyc4-y1cxxl33zyt-3.rev.dnainternet.fi. [2001:14ba:8017:3300:58f8:2a29:cd37:bd01])
        by smtp.googlemail.com with ESMTPSA id h16-v6sm2263465lfc.0.2018.11.10.09.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 09:19:11 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <12fb34ec-7175-1ac4-a96e-e1d5d424c9eb@gmail.com>
Date:   Sat, 10 Nov 2018 19:19:10 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <be4e75ed-746e-ed55-0bbe-0fd710bd4162@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 09/11/2018 22.42, Jacek Anaszewski wrote:
> Hi Vesa,
> 
> On 11/09/2018 09:32 AM, Vesa Jääskeläinen wrote:
>> On 07/11/2018 0.07, Jacek Anaszewski wrote:
>>> Introduce dedicated properties for conveying information about
>>> LED function and color. Mark old "label" property as deprecated.
>>>
>>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>>> Cc: Baolin Wang <baolin.wang@linaro.org>
>>> Cc: Daniel Mack <daniel@zonque.org>
>>> Cc: Dan Murphy <dmurphy@ti.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> Cc: Simon Shields <simon@lineageos.org>
>>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>>> ---
>>>    Documentation/devicetree/bindings/leds/common.txt | 52
>>> +++++++++++++++++++----
>>>    1 file changed, 44 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>>> b/Documentation/devicetree/bindings/leds/common.txt
>>> index aa13998..3efc826 100644
>>> --- a/Documentation/devicetree/bindings/leds/common.txt
>>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>>> @@ -10,14 +10,20 @@ can influence the way of the LED device
>>> initialization, the LED components
>>>    have to be tightly coupled with the LED device binding. They are
>>> represented
>>>    by child nodes of the parent LED device binding.
>>>    +
>>>    Optional properties for child nodes:
>>>    - led-sources : List of device current outputs the LED is connected
>>> to. The
>>>            outputs are identified by the numbers that must be defined
>>>            in the LED device binding documentation.
>>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed
>>> definitions
>>> +        from the header include/dt-bindings/leds/functions.h.
>>> +        If there is no matching LED_FUNCTION available, add a new one.
>>> +- color : Color of the LED.
>>
>> We have had for years out-of-tree patch for multi color gpio led driver
>> which extends this concept with multiple colors. Then in sysfs there has
>> been possibility to control the color and otherwise use blinking or
>> other features.
>>
>> Our need is multi color status led of the device which includes
>> different kind of blinkings and colors on different situations.
>>
>> Current in-tree gpio led driver just wasn't atomic enough and a bit
>> clumsy interface for handling this.
>>
>> Now that this is being looked at could we come up with solution that we
>> could define multiple colors for one led in device tree and then we
>> could work on getting the driver upstreamed?
>>
>> What we did was generally:
>>
>> leds-multi {
>>      compatible = "gpio-multi-leds";
>>
>>      status {
>>          gpios = <...>;
>>          linux,default-trigger = "none";
>>          deafult-state = "keep";
>>
>>          color-red {
>>              pin-mask = <0x01>;
>>          };
>>
>>          color-green {
>>              pin-mask = <0x02>;
>>          };
>>
>>          color-orange {
>>              pin-mask = <0x03>;
>>          };
>>      };
>> };
>>
> 
> Device Tree node implementation doesn't actually say too much
> about the sysfs interface you came up with, which is most vital
> in this case.

In our case it is very simple. There is "color" named sysfs node under 
gpio instance.

It creates own led instance for each children in this case it is named 
as "status" and then uses properties under it to define operation.

Currently we do have fixed list of color names in driver to require 
"standardized" names but that could be easily changed to be dynamic.

Driver registers all GPIOs defined in "gpios" under the instance.

So one can say:

echo "orange" > color

This setting goes to the driver, it figures out logical name "orange" 
and the configure all listed GPIO's to its "pin-mask" state. Polarity of 
the GPIO's is configured in GPIO definition so this is more or less turn 
this particular pin to activate state.

So in this case it changes led's color to orange and still lets one to 
use standard led triggers. Eg. set periodic blinking or so.

If one cat's "color" it lists all available colors for user and shows 
which one is active.

When brightness is configured as zero the all registered go to off state 
and when non-zero then it goes to state what ever is configured with 
"color" sysfs entry.

> Support for RGB LEDs, or other variations of LED synchronization
> have been approached several times, but without satisfying result
> so far.
> 
> Generally the problem boils down to the issue of how triggers
> should handle multiple synchronized LED class devices in a backwards
> compatible way with monochrome LEDs.
> 
> At some point the HSV [0] approach was proposed, but there was a problem
> with getting uniform colors across devices. Especially white.
> Certainly a calibration mechanism would be required.
> 
> [0] https://lkml.org/lkml/2017/8/30/423

We do not usually use PWM controlled leds so our calibration has been HW 
engineer tuning the resistors for the leds to get acceptable color for 
different colors variations.

If one wants to have fixed colors for such device then one could use 
this similar method to define them or/and free form interface to enter 
RGB values there. Thou with PWM RGB leds you probably want to have more 
animation there which probably would require some additional support code.

One way to do atomic PWM RGB color change with sysfs could be:

echo "21 223 242" > color

or

echo "21 223 242" > rgb

or:

echo "r:21 g:232 b:242" > color (or something similar)

and if there is know registered name then just write it to "color" which 
would pick registered color rgb values to led instances rgb value.

Now for PWM RGB led one could use "brightness" and "rgb" value to 
calculate actual color with some color space formula (like hsv in [0]).

Doing white with RGB LED is a bit hard so usually you want to get RGBW 
LED (or RGBAW LED) if "real" white is something that is needed. This 
could then be "rgbw" entry and "color" to pick from fixed set.

These presets in device tree for "color" could be considered one way of 
doing calibration for particular hardware.

So in device tree for RGB PWM led it could be like:

color-orange {
     rgb = <249 197 9>
}

color-warm-white {
     rgb = <255 253 249>
}

How would that sound like?

Thanks,
Vesa Jääskeläinen
