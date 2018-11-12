Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28CEC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B004C20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGsJ+NP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B004C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeKLJwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:52:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41478 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbeKLJw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:52:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so6025861ljb.8;
        Sun, 11 Nov 2018 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuPkZaHgfK6A1aJXUeef24skGo7joEngbW6jE5ck6+w=;
        b=RGsJ+NP0KkuXwTygHn8TU3X2uTWwK7n7MT24IJsefYerDk6YleZS165Dyr0Nd5mc3J
         zdBtFQUEYXfwyWArmrS8vEuM4tMnsHOQc8QZ5p647YZcLN8enMHWjjnD4SV2C5Yqa9nf
         cUMO0VwUxjR2yTEY12PHr5D43v1fOYY2yfhCEryGJiEC3rTUkUb23zMgy7h6ys6swH/9
         DuCbBN1tNW63OYt+A5Gx1cQNla86GOfy4pxKODDwJ4+tfUr96wABoQz07048m/CiScCu
         7t2oxONTztAsWcs575jJXhHJa7BOgs/y2uJp+lvWATnBowE+QPl1r9YM24rd0tem3q8D
         IVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuPkZaHgfK6A1aJXUeef24skGo7joEngbW6jE5ck6+w=;
        b=XPoXawDUNhZu+dBBFSyCiPsK6dr2XbfEesNQlJzpLn+4oE+me33yywC/iJgHQr8YDM
         q87Ow43orvSB/6oQYVbXuxY6NcHGmVcR527Ioq+zBKO2dPdgB+KQkjt3FhZ2LvF+zkGj
         7P+4AEIUGZ8ygwSav8FiGg9Bbo7k399R/Fc4h7081K5z6k0cWv/4o5pE2+578sp4UJXn
         T7jfuDB2iGiZ+bOFyGt5bFirJHhotxdL1e/2mvByNvkVKNnDx4lKNFbz9fDGPtZKbx5U
         OBTNhtMfJh2HnfyfjbmQg0PV72itgn4eKnhpmjpVm+oME6uJU+ajgOFlpWIxmHtX1IFv
         zoUQ==
X-Gm-Message-State: AGRZ1gIa0eUJz9yzg5J/bUaYETGTIQ9wELgmvVtr9byyoMtaMqRcaBmX
        EBde02m4xfDAO6YGX62qFTI=
X-Google-Smtp-Source: AJdET5eykAAlNa+oYMm7cAgX0K0rHiOPSsida4vXaD8eCbe23UKPuXGSEenQ4cYSVr27I9FcbbbBPg==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr10904240ljg.22.1541980922274;
        Sun, 11 Nov 2018 16:02:02 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:f0d2:e35:c9b8:94be? (dtynxhyjt6kjdnwq4ww-y-3.rev.dnainternet.fi. [2001:14ba:8017:3300:f0d2:e35:c9b8:94be])
        by smtp.googlemail.com with ESMTPSA id x5-v6sm2728890lfe.58.2018.11.11.16.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 16:02:01 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
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
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <e72ac342-5253-851a-e54f-b1bd752be628@gmail.com>
Date:   Mon, 12 Nov 2018 02:01:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/2018 23.14, Jacek Anaszewski wrote:
> On 11/11/2018 09:16 PM, Pavel Machek wrote:
>> Hi!
>>
>>>>> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
>>>>> index 836cb16..e9009c4 100644
>>>>> --- a/Documentation/leds/leds-class.txt
>>>>> +++ b/Documentation/leds/leds-class.txt
>>>>> @@ -43,7 +43,7 @@ LED Device Naming
>>>>>   
>>>>>   Is currently of the form:
>>>>>   
>>>>> -"devicename:colour:function"
>>>>> +"colour:function"

Couldn't we have here multiple variants that would then be chosen based 
on device tree definition?

"devicename:colour:function"
"devicename:function"
"devicename:label"
"colour:function"
"function"
"label"

If "label" would be specified then just use that as a led name, giving name:
- label

If "function" would be defined then go to special formatting with 
optional "color", giving names:
- color:function
- function

I suppose 'devicename' would then be automatically filled based on 
driver instance unless one defines 'no-devicename' or something like 
that for led definition.

Personally I do not see the need for "color" in any led name. In my 
opinion the only thing needed here would be location prefix (where 
needed -- and it should be possible to disable that) and then logical 
name for the led.

>>>> I don't think we want to do it in all cases.
>>>>
>>>> So, on my cellphone seeing lp5523:green:led is indeed not useful.
>>>>
>>>> But on notebook with usb keyboard attached, you need to keep the
>>>> devicename to be able to distinguish capslock on internal keyboard and
>>>> capslock on first USB keyboard and capslock on second USB keyboard.
>>>>
>>>> Taking look at the list of functions, here's stuff like "hdd" and
>>>> "hdderr". I assume the first means hdd activity... If we can do it, it
>>>> would be nicest to have "sda:green:activity" and maybe
>>>> "sda:red:error". For a raid array with 8 drives...
>>>>
>>>> For example I have a router running linux. It has 4 lan ports, with
>>>> correspondings LED, and an wan led.
>>>>
>>>> Having "green:lan1" to "green:lan4" and "green:wan" plus
>>>> "red:wanerror" would work, but I'd really preffer
>>>> "eth0:green:link"... "adsl0:green:link", "adsl0:red:error".
>>>>
>>>> There are now phones with flashes on both main and selfie
>>>> cameras. Again, knowing which device is which is important. As is
>>>> knowing which display is controlled by particular backlight.
>>>
>>> It's overcomplicating the naming again. In every case you can tweak
>>> the function name to eth0_link, eth1_link etc.
>>
>> Well, but in such case it would be good to keep existing scheme.
>>
>> My system looks like this:
>>
>> input16::capslock    tpacpi::bay_active    tpacpi::standby
>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
>> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
>> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3
>>
>> I agree that we should get rid of "tpacpi:" part in some cases. But
>> it does not make sense to get rid of "input16:" part -- it tells you
>> if the LED is on USB or on built-in keyboard.
>>
>> Ideally, tpacpi::thinklight would be input5::frontlight (as it is
>> frontlight for the keyboard).
>>
>> Yes we should simplify, but it still needs to work in all cases.
> 
> Well, label is not being removed. You still can use it an the old
> fashion, even when using new led_compose_name().
> 
> Maybe removing the description of the old LED naming from
> Documentation/leds/leds-class.txt was too drastic move.
> I'll keep it next to the new one, and only add a note that
> it is kept only for backwards compatibility.

With above proposal for naming it should match more or less everyone's 
needs?

Simple naming for embedded device makers and more advanced for server 
system makers.

No need to say that something is legacy or backwards compatibility feature.

Thanks,
Vesa Jääskeläinen
