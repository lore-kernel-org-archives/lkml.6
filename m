Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619ECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F1D20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxAeSKDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F1D20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeKLHEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:04:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39077 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeKLHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:04:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id b13so7177227wrx.6;
        Sun, 11 Nov 2018 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KzKbmgQOHEUMOV11svP0AwRyRVgawseosvEBMGAj11k=;
        b=UxAeSKDsqnMOKsWThxUT1BhHmFdaHIT3jEPNdPuAhGHHcueG8GsZb8J+DhyuW1mC6r
         sc82OV/Kwv0ucmkH5DRRV+oL1PnGfKk6gINXaKazrLu2kWK01gbM+gV6+DuwZdiiyX8J
         xFHLIibWcTzdk/D6Z9p32iOlJodHuuKgG2A7yNKtlKJ2cngygjKOqFJichli0SYtIb/V
         GI1XbnaQ5uy8BA7AB8M96GdsvfTED8x6F8chjPCJ53pUVV7SsE+iWI4itPngN2eDwUhA
         6/qUJmOYaUaWu04dW91550DPAMVQiFbRQd0Py6INpckMJB9wE7WRwL3Lv8xkVhH/AX23
         Tu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KzKbmgQOHEUMOV11svP0AwRyRVgawseosvEBMGAj11k=;
        b=FjPNN5tuBkRZivSy0y6DVtLGfcwxWLbsknP4HCVbinu3BGtcwpD6G3kYq+n3qt9uDr
         jvdx0qDPgdtLCgaRSNIvT8ym3WKzbyOvL8vy08U/IDhV1zWgXawtm97tezEziJAR6EB4
         XbiR0sz+u1kWePncnOPsMtzPhEDjuOqj9n+B9PZ6MuAJW8IExybn1Kp4Af+zTNMQaKYD
         68Odz4TvA0EUKVJwmM/ct4rWUIzgW9H0ALVLUUXuW+MlFlUx1ZRaAbCSqvHYCOe6KzNs
         d4d8L0x0+khrQeMnZuqWKfjsHxOljxrxmDaRD6lM3YP+DTjkhGkqCfRFbQJzhAr7Uytm
         vQoA==
X-Gm-Message-State: AGRZ1gKvQnoKebe4+GkBTc3baFAIPTyJaViYOLuXYegbXQgiupTD+93L
        U1IeCJL/EfJqS5N9nBsimkw=
X-Google-Smtp-Source: AJdET5cQMZhRtF4DvVo3P/AMeYygbnwxe0cKFjKVHx3I92jCpJ6iI5P+ceNIghWkCTvm/pNl7G6eww==
X-Received: by 2002:adf:826b:: with SMTP id 98-v6mr15484110wrb.312.1541970880532;
        Sun, 11 Nov 2018 13:14:40 -0800 (PST)
Received: from [192.168.1.18] (cjk171.neoplus.adsl.tpnet.pl. [83.31.60.171])
        by smtp.gmail.com with ESMTPSA id w11-v6sm17638544wrr.96.2018.11.11.13.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 13:14:40 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Pavel Machek <pavel@ucw.cz>
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
 <20181111201605.GA20160@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
Date:   Sun, 11 Nov 2018 22:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181111201605.GA20160@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2018 09:16 PM, Pavel Machek wrote:
> Hi!
> 
>>>> diff --git a/Documentation/leds/leds-class.txt b/Documentation/leds/leds-class.txt
>>>> index 836cb16..e9009c4 100644
>>>> --- a/Documentation/leds/leds-class.txt
>>>> +++ b/Documentation/leds/leds-class.txt
>>>> @@ -43,7 +43,7 @@ LED Device Naming
>>>>  
>>>>  Is currently of the form:
>>>>  
>>>> -"devicename:colour:function"
>>>> +"colour:function"
>>>>  
>>>
>>> I don't think we want to do it in all cases.
>>>
>>> So, on my cellphone seeing lp5523:green:led is indeed not useful.
>>>
>>> But on notebook with usb keyboard attached, you need to keep the
>>> devicename to be able to distinguish capslock on internal keyboard and
>>> capslock on first USB keyboard and capslock on second USB keyboard.
>>>
>>> Taking look at the list of functions, here's stuff like "hdd" and
>>> "hdderr". I assume the first means hdd activity... If we can do it, it
>>> would be nicest to have "sda:green:activity" and maybe
>>> "sda:red:error". For a raid array with 8 drives...
>>>
>>> For example I have a router running linux. It has 4 lan ports, with
>>> correspondings LED, and an wan led.
>>>
>>> Having "green:lan1" to "green:lan4" and "green:wan" plus
>>> "red:wanerror" would work, but I'd really preffer
>>> "eth0:green:link"... "adsl0:green:link", "adsl0:red:error".
>>>
>>> There are now phones with flashes on both main and selfie
>>> cameras. Again, knowing which device is which is important. As is
>>> knowing which display is controlled by particular backlight.
>>
>> It's overcomplicating the naming again. In every case you can tweak
>> the function name to eth0_link, eth1_link etc.
> 
> Well, but in such case it would be good to keep existing scheme.
> 
> My system looks like this:
> 
> input16::capslock    tpacpi::bay_active    tpacpi::standby
> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3
> 
> I agree that we should get rid of "tpacpi:" part in some cases. But
> it does not make sense to get rid of "input16:" part -- it tells you
> if the LED is on USB or on built-in keyboard.
> 
> Ideally, tpacpi::thinklight would be input5::frontlight (as it is
> frontlight for the keyboard).
> 
> Yes we should simplify, but it still needs to work in all cases.

Well, label is not being removed. You still can use it an the old
fashion, even when using new led_compose_name().

Maybe removing the description of the old LED naming from
Documentation/leds/leds-class.txt was too drastic move.
I'll keep it next to the new one, and only add a note that
it is kept only for backwards compatibility.

-- 
Best regards,
Jacek Anaszewski
