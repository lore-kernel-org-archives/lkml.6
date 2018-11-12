Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C1A224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ4IhiPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C1A224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeKMBxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:53:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33731 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKMBxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:53:51 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so6550145lfc.0;
        Mon, 12 Nov 2018 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HV/2ceGKC9p7NP5tR3iaBwf/wCAB/BJguaqkPFUgs20=;
        b=GZ4IhiPdiKFXSxxVvI31lNiiewoJaoZW88C9oZ8a4WQjHHxPbFMZ6hlmYoehVImiMG
         sqKFTfxyi64bEfI9pPJFh3eOQ5S07/DuHPKmqjjdRyBPdSKyjar2jEuuM7356h0KRLZz
         RuHbTAONgoavuD1plaBsBvbxnxv4nAQOEp1C4nWN7xV3ZvI7HbtquKxWtlDg3Bb24d8r
         hdjpvCwhDQIlBZAW2kEfrTkUVkdeg0rfVSMUY2kWAsC8tdZz5Hj9Wm57F/IpDqIXyVsT
         mjHOU2xQod5a8lALXMrQlW0j8i3SEiVkGovF4BL5X5P61SL/lQosXqfQYG3n2DeLbP08
         rkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HV/2ceGKC9p7NP5tR3iaBwf/wCAB/BJguaqkPFUgs20=;
        b=FkFc9hF589YMZkgQ2k+/2rQaCPgEtNEnzXRsfJ/ZwBmCUGe/n0zWkR+OEkAmQRDTNf
         3oEZCeebLtGjkCmf6RHi6Qd8MadDLRXnC5eXpoK5ryCAENEES2aEBOxMdXZtRpyiTul3
         t5sWElBDqq1VkLQkJUhJttP2lX9e5ErEVeGI3C+BIaOsAUMCOu6VK59tGNKoZf9Brxax
         FWNRYhQ9CkdzE3hZdR3KTI3XUBfdIOqclLxktF4evvVed8oAJLMnR7IEmhSbGgdN/4dW
         XCcJyC0+c9Hy3lIVJSi/0EY4EuAsi+BE/Naz6CogxuF+SNuvIdE0diCTOULi9s5HMhO2
         aZXA==
X-Gm-Message-State: AGRZ1gIXd9fhqbp4cSDX8hdAQM+O1jxVuIseE+j6xxRLyszBMzOyWjhh
        o9f096n5lB6mthN72H8vSMw=
X-Google-Smtp-Source: AJdET5eVf9l7f/S4+VFLGPltduUaukZsLUnL4RT7w6RX9fElMkSxbJTfMANQnRasIsi6R/3r51+ITg==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr953578lfj.12.1542038398257;
        Mon, 12 Nov 2018 07:59:58 -0800 (PST)
Received: from [192.168.1.18] (bgt69.neoplus.adsl.tpnet.pl. [83.28.83.69])
        by smtp.gmail.com with ESMTPSA id o5-v6sm3091338ljh.75.2018.11.12.07.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:59:57 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd> <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd> <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <e72ac342-5253-851a-e54f-b1bd752be628@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e1b5411c-37ea-91f0-522a-8a6e2303c70f@gmail.com>
Date:   Mon, 12 Nov 2018 16:59:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e72ac342-5253-851a-e54f-b1bd752be628@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 01:01 AM, Vesa Jääskeläinen wrote:
> Hi,
> 
> On 11/11/2018 23.14, Jacek Anaszewski wrote:
>> On 11/11/2018 09:16 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> diff --git a/Documentation/leds/leds-class.txt
>>>>>> b/Documentation/leds/leds-class.txt
>>>>>> index 836cb16..e9009c4 100644
>>>>>> --- a/Documentation/leds/leds-class.txt
>>>>>> +++ b/Documentation/leds/leds-class.txt
>>>>>> @@ -43,7 +43,7 @@ LED Device Naming
>>>>>>     Is currently of the form:
>>>>>>   -"devicename:colour:function"
>>>>>> +"colour:function"
> 
> Couldn't we have here multiple variants that would then be chosen based
> on device tree definition?
> 
> "devicename:colour:function"
> "devicename:function"
> "devicename:label"
> "colour:function"
> "function"
> "label"

Documentation/leds/leds-class.txt in a description of
"devicename:colour:function" naming scheme states the following:

"If sections of the name don't apply, just leave that section blank"

Currently not many Device Tree nodes follow that recommendation but with
the led_compose_name() I'm going to enforce it (only for the
devicename-less naming scheme), which is needed for reliable parsing of
LED color and function, which with naming schemes you proposed it
wouldn't be possible.

But, even with led_compose_name(), it will be possible to get the
names listed by you:

If you provide the 'label' property in the DT, then with the new
led_compose_name() you will get the LED class device name in one of the
two below forms, depending on the parameters passed to the function:
- If led_hw_name argument is not NULL:
	led_hw_name:label
- If led_hw_name argument is NULL then the label is taken as-is for
  for LED class device name (it may be appended a numerical suffix if
  the name is already taken)

This flexibility is for backwards compatibility with existing drivers,
where some of them add devicename section to the parsed DT label,
and others adopts the DT label as-is for LED class device name,
relying on DT to provide the devicename.

> If "label" would be specified then just use that as a led name, giving
> name:
> - label

Please get acquainted with the entire patch set, the commit messages,
and the documentation of led_compose_name(). You'll find out that
this is exactly how led_compose_name() is designed.

> If "function" would be defined then go to special formatting with
> optional "color", giving names:
> - color:function
> - function

Color must not be omitted as explained above. Of course in case 'label'
is provided, it won't be validated in any way, thus allowing for any
combination. With the 'color' and/or 'function' DT properties you'll
get one of the following:

- color:function
- :function
- color:

Having considered all the above, I'd even propose to change the
delimiter for the new naming convention from ":" to "-", to make it
possible to distinguish between old and new naming convention.

> I suppose 'devicename' would then be automatically filled based on
> driver instance unless one defines 'no-devicename' or something like
> that for led definition.

devicename section is problematic in the LED class device name,
since it doesn't allow for having uniform userspace interface across
different platforms. Think of Android - I've seen they have their own
LED naming scheme which doesn't contain devicename section.

Also, please refer to the DT maintainer's opinion in this regard [0],
which actually drew my attention to the problem.

Please keep in mind that devicename has been so far used for
board vendor name or LED controller name.

> Personally I do not see the need for "color" in any led name. In my
> opinion the only thing needed here would be location prefix (where
> needed -- and it should be possible to disable that) and then logical
> name for the led.

You mean we don't need the color information at all?

And could you please explain what do you mean by "location prefix"?

>>>>> I don't think we want to do it in all cases.
>>>>>
>>>>> So, on my cellphone seeing lp5523:green:led is indeed not useful.
>>>>>
>>>>> But on notebook with usb keyboard attached, you need to keep the
>>>>> devicename to be able to distinguish capslock on internal keyboard and
>>>>> capslock on first USB keyboard and capslock on second USB keyboard.
>>>>>
>>>>> Taking look at the list of functions, here's stuff like "hdd" and
>>>>> "hdderr". I assume the first means hdd activity... If we can do it, it
>>>>> would be nicest to have "sda:green:activity" and maybe
>>>>> "sda:red:error". For a raid array with 8 drives...
>>>>>
>>>>> For example I have a router running linux. It has 4 lan ports, with
>>>>> correspondings LED, and an wan led.
>>>>>
>>>>> Having "green:lan1" to "green:lan4" and "green:wan" plus
>>>>> "red:wanerror" would work, but I'd really preffer
>>>>> "eth0:green:link"... "adsl0:green:link", "adsl0:red:error".
>>>>>
>>>>> There are now phones with flashes on both main and selfie
>>>>> cameras. Again, knowing which device is which is important. As is
>>>>> knowing which display is controlled by particular backlight.
>>>>
>>>> It's overcomplicating the naming again. In every case you can tweak
>>>> the function name to eth0_link, eth1_link etc.
>>>
>>> Well, but in such case it would be good to keep existing scheme.
>>>
>>> My system looks like this:
>>>
>>> input16::capslock    tpacpi::bay_active    tpacpi::standby
>>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
>>> input16::scrolllock  tpacpi::dock_batt          tpacpi::thinkvantage
>>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
>>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
>>> input5::scrolllock   tpacpi:green:batt          tpacpi::unknown_led3
>>>
>>> I agree that we should get rid of "tpacpi:" part in some cases. But
>>> it does not make sense to get rid of "input16:" part -- it tells you
>>> if the LED is on USB or on built-in keyboard.
>>>
>>> Ideally, tpacpi::thinklight would be input5::frontlight (as it is
>>> frontlight for the keyboard).
>>>
>>> Yes we should simplify, but it still needs to work in all cases.
>>
>> Well, label is not being removed. You still can use it an the old
>> fashion, even when using new led_compose_name().
>>
>> Maybe removing the description of the old LED naming from
>> Documentation/leds/leds-class.txt was too drastic move.
>> I'll keep it next to the new one, and only add a note that
>> it is kept only for backwards compatibility.
> 
> With above proposal for naming it should match more or less everyone's
> needs?
> 
> Simple naming for embedded device makers and more advanced for server
> system makers.
> 
> No need to say that something is legacy or backwards compatibility feature.


[0]
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1559757.html

-- 
Best regards,
Jacek Anaszewski
