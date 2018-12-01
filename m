Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC766C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AFB20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 21:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beHuVywt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AFB20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbeLBIbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:31:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeLBIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:31:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so2166510wml.3;
        Sat, 01 Dec 2018 13:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZ+w095pSRVZvRAtnUnLIHFWqiPT2Y8YqU8hAKjxXf4=;
        b=beHuVywtNuGvjyVo/Mvz8tRyc3arAeCJegSQnLqaAzizrcUsJUlhDG3KrFKcvfJTOf
         FGcT3O5+SJG/u9aQPybwo/7TDTu96f4GkemgWPancnr0u0J78S6BfKPj4TxzNqAGivQY
         uxaCnfCHw5DTvpnvANAjvU320jjeJbWLgc36vljsvmsJTVoEqakFndgtQ5x6ww4dYcYn
         Bb3d2seUAgXhWqzCqLpZp+bMjzIshsc2WiB6pzCr2TAA4I0IthppfQJtoWErri+JUb8q
         bexpbLl1OE1q4uONDBpa1GdUJrzyrIWuCyu2bbOUDmRtKw7vaujV1yZfwGa5mPWfN541
         BlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZ+w095pSRVZvRAtnUnLIHFWqiPT2Y8YqU8hAKjxXf4=;
        b=oKQUpdbBXuTc5SvgSRHGlI4FPdSSUHxIvdztIK/XJcfVajOG+iLn40qZdHRymvcXpg
         vVSlduhQjohGKxkhp6Li7unMEOisVRGUQOt+h1Yc0UaGquoZHQMqSW9bjRaMtJoy/Kod
         PdF9/8XhBQQXG5VLiVHfG+FySjfCwj9RmfpoRc8/IKaWG6C3KwIUARtGQY4+rPFHvnm3
         ksUI2vkfSzsjgwnVbYUPZ2dBrqbzO2poEkCOsE76dNZnXMFRz7xkeAW1CdBz6IoGHLyC
         ezkQS4LDcXp+axcWFaLunb1sUZAjmY07ZJBQaiB33QXBbsn7Tv7jCYIYl7P75DF0+8cF
         Edhg==
X-Gm-Message-State: AA+aEWZJP9xaLqvC3b5aJZ+k/pDoiYPYMUSr+uJCA4FxeoIfmNUusWK/
        Ccn6i5kWr/2QQSNNGv0r1C4=
X-Google-Smtp-Source: AFSGD/V4SdDgT7IP3FHMs7neN9FSYOtYkD9fgDmmiNvV/TwjXQMag3kJ+Php+PLFVG/FDukJiYwClA==
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr3059895wmg.132.1543699067076;
        Sat, 01 Dec 2018 13:17:47 -0800 (PST)
Received: from [192.168.1.18] (civ101.neoplus.adsl.tpnet.pl. [83.31.45.101])
        by smtp.gmail.com with ESMTPSA id x10sm7654034wrn.29.2018.12.01.13.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 13:17:46 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
 <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
 <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181130210814.GA5756@amd>
 <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <fa5add90-e1b7-d527-374f-175abdf88455@gmail.com>
Date:   Sat, 1 Dec 2018 22:17:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2018 11:19 PM, Rob Herring wrote:
> On Fri, Nov 30, 2018 at 3:08 PM Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Hi!
>>
>>>> Pavel gave following examples:
>>>>
>>>> eth0:green:link
>>>> adsl0:green:link
>>>> adsl0:red:error
>>>>
>>>> So we would have e.g.:
>>>>
>>>> associated-vl42-device = <&camera1>;
>>>> associated-network-device = <&phy1>;
>>>> associated-block-device = <&phy1>;
>>>
>>> Variable property names are kind of a pain to parse.
>>
>> Ok, would it be enough to have associated-device = <&whatever>?
> 
> Yeah, but I though you needed the device type name in there.
> 
>>> Perhaps when LEDs are associated with a device, we shouldn't care
>>> within the context of the LED subsystem what the name is. The
>>> association is more important and if you have that exposed, then you
>>> don't really need to care what the name is. You still have to deal
>>> with a device with more than 1 LED, but that becomes a problem local
>>> to that device.
>>>
>>> What I'm getting at is following a more standard binding pattern of
>>> providers and consumers like we have for gpios, clocks, etc. So we'd
>>> have something like this:
>>>
>>> ethernet {
>>>   ...
>>>   leds = <&green_led>, <&red_led>;
>>>   led-names = "link", "err";
>>> };
>>
>> Basically every single device could have a LED associated with it
>> ("activity"). Would doing it like this mean we'd have to modify every
>> single driver to parse leds / led-names properties?
> 
> Normally, that's how properties like this would work. A driver is also
> what knows how the leds should function. 

This is not true in case of associations where LED controller is
an independent device, as in Pavel's example [0].

> A driver can retrieve the led
> and associate it with the 'foo-bar' function. The 'foo-bar' function
> then doesn't have to be defined in DT nor exposed to userspace. It
> wouldn't even have to be driver specific. The driver's subsystem could
> handle it all if the led functions are standardized. Though then you'd
> be back to needing standard names for 'led-names', but that's no worse
> that trigger names. This model would also allow getting rid of
> 'linux,default-trigger' properties in a lot of cases which wouldn't be
> a bad thing.
> 
> However, having drivers handle this is not required. You can iterate
> thru the tree for nodes with 'leds' and find the node which has a
> phandle to the led node you care about. 

This way of discovering associations between devices and LEDs
would be more reliable than by devicename part of LED class device
as discussed previously.

However, I've just tried to verify how it works, but
I can't find the way to get the of_node phandle from sysfs.

The "of_node" link in per-device dirs in /sys/devices point
to the directories containing DT properties of the node, but
I see no way to obtain the node phandle.

> Sure, it's not that efficient,
> but it does work and it's only done once. Basically, as long as the
> linkage is there, we can make it work. I think using
> 'associated-device' might work better for the current implementation
> of Linux LED support, but leds/led-names would be more inline with
> other DT bindings. The current Linux implementation shouldn't dictate
> the binding design.

[0] https://lkml.org/lkml/2018/11/13/103

-- 
Best regards,
Jacek Anaszewski
