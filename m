Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462BEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F23E224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSjrxQyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F23E224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeKMBz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:55:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43063 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbeKMBz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:55:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so6533135lff.10;
        Mon, 12 Nov 2018 08:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iHARkkcpWI1aYE4SY2b7mAcbIynGpF9Vg+t2AvXBvXU=;
        b=lSjrxQyt9WIFpJy3Wqg9EyBiaA5rv/8RQna+pJhV+tRuwFkAmTj/6Fa3Pe7yeJUCoE
         pXqWlh/I3FT4Jebq5at/qm//ubATv9eIXBAELnRy1qrjwf+1gKLvOsr3sB9ovczTVqnV
         jLY3ScCdIxN+3jsKD5ZwNYfC9BwIx1hSZhgmA9P1vJDq7NmEFZUiwJ+Jrmj30FqRUBsq
         8XHXxkS0UkyejOLFDFNkL7Z3zfkOmAN6B+nfAk72+JZFDYEdXrzrfRIrTSss7mrUEufw
         G/rPEYro0E/fXSkNBOzhyaSSi4u0OF0eCttvnGbnpjjtGOLmWe+8/x8CsmtgkAF5AXho
         XtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iHARkkcpWI1aYE4SY2b7mAcbIynGpF9Vg+t2AvXBvXU=;
        b=Tiwt7EKwNzVuoR1AqdbTFT+qJQjp1L2fKSDyVjuBsLfMKb03c3d0yQQNlCNtSozeoQ
         lYQy20UpyBqXbgDdPfntQunDfRP9O6Q85ie0OmlsgWn9BF4h+ZaeEXOqzG0k1Fv3UO6m
         Qq8icMcOblITdzI86ZPSiwpGTSPpseX9bGe3b7cKjWOpero3ycqu0o1oOeX5iCaEFLIo
         b2dNY7itQPC/MM/Xe43EdCZw16Rf8O6erSm0/oiW6VyfHJQ4ADAeC71tIwD2anHJffJB
         cDM8/0BC143aDV9ypaHIN1D+C0o9xqdmgVw1t2hVLdo9wwoxxrbuKiOA1zreoQojNWHP
         9rpg==
X-Gm-Message-State: AGRZ1gJCeSj1iR5PDTFKcrtES0megfC8QsrlT7HR5qWoKLHvOjaXAdhQ
        muUg9BKqYsJaIjjT/70jV+k=
X-Google-Smtp-Source: AJdET5dSIQCCP5ULhY4qcB4JPh8a3j7O54KfghOEgk1pA+Mhj1RIPGR9negqyGKlUkjJ9/Bh3Q6i4A==
X-Received: by 2002:a19:3b12:: with SMTP id i18mr1030792lfa.28.1542038522472;
        Mon, 12 Nov 2018 08:02:02 -0800 (PST)
Received: from [192.168.1.18] (bgt69.neoplus.adsl.tpnet.pl. [83.28.83.69])
        by smtp.gmail.com with ESMTPSA id t6-v6sm2981158ljd.2.2018.11.12.08.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:02:01 -0800 (PST)
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
 <20181111201605.GA20160@amd> <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
Date:   Mon, 12 Nov 2018 17:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181112103513.GB5695@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/12/2018 11:35 AM, Pavel Machek wrote:
> Hi!
> 
>>>> It's overcomplicating the naming again. In every case you can tweak
>>>> the function name to eth0_link, eth1_link etc.
>>>
>>> Well, but in such case it would be good to keep existing scheme.
>>>
>>> My system looks like this:
>>>
>>> input16::capslock    tpacpi::bay_active    tpacpi::standby
>>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
>>> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
>>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
>>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
>>> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3
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
> I agree that removing it is "just too drastic".
> 
> But it is not just for backwards compatibility. See my examples above,
> it is needed to tell which device the LED is asociated with, and it is
> absolutely required for USB devices (for example).

For USB devices there is already ledtrig-usbport available, which
provides sysfs interface for defining and reading the usb ports,
the status of which the LED indicates. Since the USB devices can be
attached/removed dynamically, it would be impossible to reflect
the associations in the LED class device name.

> And even for "embedded" stuff like routers, we want eth0:green:link,
> eth0:yellow:activity and not some kind of hack.

eth0 is not something you can be certain of at the stage of defining DT
node.

> Ideally, colors would come from fixed list, functions would come from
> fixed list, and device part would come from name used elsewhere in the
> kernel.
> 
> (And yes, it probably means we should have something in device tree to
> link LED to its device. device = "name" would be good start...)

Why would you need such link?

-- 
Best regards,
Jacek Anaszewski
