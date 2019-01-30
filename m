Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8101DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACB22184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azOq5qT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbfA3UUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:20:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33560 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfA3UUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:20:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so659298lfc.0;
        Wed, 30 Jan 2019 12:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHh6R0cj+Zd+YyixiSqQDixoTsB4Kn6GO0L0R/czJN8=;
        b=azOq5qT2yRtd2binatQwsCftpQyd4nj1G7iyzsW20eig4DFdXaAemGHih4k4OMHMno
         yVCtO+G7lpSopBR9drCaX0qtO6AJFGfRvJYjhlUaFj/Pu11dwXfYEA3jr2cEO8G6u1Oy
         Lvwr9zsrQRU3mZq+Hl26znFuheCE4Vc24gyG7KeRFAOsaoh+tw9xoYi7CfBKhbOTLDIg
         8KWTMo/a3lT7uADgwsGxuFj2wlU8Wm4aHypFu0FgamDQ0myUcfk6iMtCxp3X1HM2UEQN
         +wRE4H0Gjtgi5qJ6m7noHPkjDSjhA2hdzdipSPDFwUIhYDQ1OsmoQLNOCoLOqxpsKd51
         +UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHh6R0cj+Zd+YyixiSqQDixoTsB4Kn6GO0L0R/czJN8=;
        b=oKjyQFCfYHjre8hrkoDZeE8fbspdKyS6mPpBytE6ne20/FAyIiSdKmXNb+hRCW38UT
         0e0QWimbg/szpTdjVWM6IZ+HKEA5M1QQG2jPcXbc8NzjX997zCeMf5BsmOcdU+/jWh4I
         LlO8D62CbLiyIHNI6V/MEahZtL4Q5GiXq7JQ1EToJTyGw7v5R3XkGH1bkhxNlVTAwN6B
         PkX8Kd7d5DcS17oavGe/DbSLZ7jjsxc4H8S4WqNvpM+lIGxj5dPltsEdgnKU1rY3jHHk
         7U+nr5Wg6UMo+vQC4EkNAmHZi0tzGYDL7agErkWiRKwAdqYP83JRc60HaAL78uzmCd8m
         uX8g==
X-Gm-Message-State: AJcUukfXPe548rnS5pGu2reyCXui74SqJJG6VcLmFbMehxGJk6ZJW4k1
        0mpjrUege5MQugIYBpQ68yk0gFQx
X-Google-Smtp-Source: ALg8bN6zQAP7H2zlx+RHisI+8/HNmUImTfj0lcAeLJxZ+7ewf4Yn8/Ax7bZwDXYL9d9FF0v5Bl7fhA==
X-Received: by 2002:a19:4849:: with SMTP id v70mr26429604lfa.62.1548879612483;
        Wed, 30 Jan 2019 12:20:12 -0800 (PST)
Received: from [192.168.1.18] (dks71.neoplus.adsl.tpnet.pl. [83.24.22.71])
        by smtp.gmail.com with ESMTPSA id p23sm453685lfh.47.2019.01.30.12.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:20:11 -0800 (PST)
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190130183005.833-1-dmurphy@ti.com>
 <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
 <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c65ca84d-8054-2244-1899-e4a9cb0842da@gmail.com>
Date:   Wed, 30 Jan 2019 21:20:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 1/30/19 8:59 PM, Dan Murphy wrote:
> Jacek
> 
> On 1/30/19 1:37 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> Thank you for the RFC.
>>
>> One vital thing is missing - documentation of brightness file must
>> be updated to define its semantics for LED multi color class.
>>
>> Either we need brightness-model file returning only "onoff" option
>> available, or, for time being, fix the max_brightness for LED multi
>> color class to 1 (which will map to max intensity level for each color).
>>
> 
> I can make max_brightness default to 1 if not set by the LED driver.
> 
> But the LP50xx has brightness controls so setting max_brightness from the driver should over ride
> the max of 1 in the upper level.

Yes, so the max_brightness should be updated basing on current
brightness-model. For LEDn_BRIGHTNESS of LP50xx we could have
"hw" or maybe even better just "lp50xx-linear" and "lp50xx-logarithmic"
- I just forgot about that capability of the device.

> For devices that do not support brightness as a separate control we can create a file called
> max_brightness_<color> that defines the max that a specific color can be set to.  If max_brightness
> is set to 1 then create max_brightness_<color>.  If max_brightness > 1 then do not create the files.

Right. We will need dedicated max_brightness for each color.
They should be placed also in the colors directory, next to the color
files.

> I don't think we have fully vetted the brightness-model yet so I prefer to omit
> it and possibly introduce that later.

We need to start from something. It will give better overview of the
whole idea.

Best regards,
Jacek Anaszewski

> Dan
> 
>> Best regards,
>> Jacek Anaszewski
>>
>> On 1/30/19 7:30 PM, Dan Murphy wrote:
>>> Add a documentation of LED Multicolor LED class specific
>>> sysfs attributes.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>    .../ABI/testing/sysfs-class-led-multicolor    | 38 +++++++++++++++++++
>>>    1 file changed, 38 insertions(+)
>>>    create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
>>> new file mode 100644
>>> index 000000000000..19f8da9b150e
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
>>> @@ -0,0 +1,38 @@
>>> +What:        /sys/class/leds/<led>/color/sync_enable
>>> +Date:        January 2019
>>> +KernelVersion:    5.0
>>> +Contact:    Dan Murphy <dmurphy@ti.com>
>>> +Description:    read/write
>>> +        Writing a 1 to this file will enable the sychronization of all
>>> +        the defined color LEDs within the LED node.  Writing a 0 to
>>> +        this file will disable syncing.
>>> +
>>> +What:        /sys/class/leds/<led>/color/sync
>>> +Date:        January 2019
>>> +KernelVersion:    5.0
>>> +Contact:    Dan Murphy <dmurphy@ti.com>
>>> +Description:    write only
>>> +        Writing a 1 to this file while sync_enable is set to 1 will
>>> +        synchronize all defined LEDs within the LED node.  All LEDs
>>> +        defined will be configured based on the brightness that has
>>> +        been requested.
>>> +
>>> +        If sync_enable is set to 0 then writing a 1 to sync has no
>>> +        affect on the LEDs.
>>> +
>>> +What:        /sys/class/leds/<led>/color/<led color>
>>> +Date:        January 2019
>>> +KernelVersion:    5.0
>>> +Contact:    Dan Murphy <dmurphy@ti.com>
>>> +Description:    read/write
>>> +        These files are dynamically created based on the colors defined
>>> +        by the registrar of the class.
>>> +        The led color(s) can be but not limited to red, green, blue,
>>> +        white, amber and violet.  If sync is enabled then writing the
>>> +        brightness value of the LED is deferred until a 1 is
>>> +        written to /sys/class/leds/<led>/color/sync.  If syncing is
>>> +        disabled then the LED brightness value will be written
>>> +        immediately to the LED driver.
>>> +
>>> +        The value of the color is from 0 to
>>> +        /sys/class/leds/<led>/max_brightness.
>>>
>>
> 
> 


