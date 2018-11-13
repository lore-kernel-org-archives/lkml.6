Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E351C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69BB223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfqqu0cL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69BB223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbeKNFzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:55:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40100 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNFzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:55:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so11009530edx.7;
        Tue, 13 Nov 2018 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwoFuAldS9odiU9TIbYEW6zjfFSPr2jCKBI0wPMos2U=;
        b=lfqqu0cL8xM1CDznoZElh2H9EDWgqRpO1UqA8oOBlwzQF/hyUJ90IvaefAxNwmU/qA
         z+uBAMVFRAbry/0wVxgqmxbm/A+R6cAENkfvfkeQjssYI9qsKeckzMZt0cjnysKX2vMS
         Jnmqhku/7E+tf18H3GQbqVHhaPPrEhkirvAcM6nG1hQf/PhwOSjMXP/PYwYExKcSqzqY
         cmn+SMdYZktLJ5mhpjT56/MfD384MhRaEWmdxTb7QUiR4GYEAAXScr6llTP1HMIKU/i6
         lmdau/j+zbpWJpsyhKfasmG+nyicWnFCvcRI85zd8eA7fGaeS3HfAH6u5RawFWAUISTW
         V7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwoFuAldS9odiU9TIbYEW6zjfFSPr2jCKBI0wPMos2U=;
        b=aY46gIi/vqmn7zxgMoRNnql8/tlvCuxr1mXJPnJYswn8j0I2DZBSkOyCRT4sVRpzTm
         rCcTc+dMAUGvqoFtipaI2gmjY7TsB3YlqthXtmxJH1b3kZdwMKXqbgLg8Kb+kJ+owWJ+
         981K5OoC+L1ZjQ0yHTJmI03zRCUbWwCER+ZwpYHhVKtg/yYUkdXZX6RXahS+H9ESOi6S
         VeeomCcfq7Uq6oE34OkJrSevNl9pjQ+D00KngPiBCIYLARFFVE/PZdSIXKIAJAvibr+7
         8KOZwa0MNwboIGT49MxtSfpq0+ev9+l/KTKvuyweQoGPJz/zx6ApJIRQPmc9YBSZsEsy
         6kUg==
X-Gm-Message-State: AGRZ1gI3rZoNelZI0blEMWHXBFyU5ElsqtPs8+b+AknwijxTMyRam0Wk
        dbk1QdJAD05RUD/Do6KMFEo=
X-Google-Smtp-Source: AJdET5fDLPnnwnodKmnoeVj2lJ2gwmXBU7LuPnOWc0IJU9Pxahdx0KsvLLLFb1rqs6HED3d0ycs17Q==
X-Received: by 2002:aa7:da45:: with SMTP id w5-v6mr17285879eds.54.1542138931599;
        Tue, 13 Nov 2018 11:55:31 -0800 (PST)
Received: from [192.168.1.18] (dma68.neoplus.adsl.tpnet.pl. [83.24.56.68])
        by smtp.gmail.com with ESMTPSA id a4-v6sm3090016eje.16.2018.11.13.11.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:55:30 -0800 (PST)
Subject: Re: [PATCH 02/24] leds: core: Add support for composing LED class
 device names
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, dmurphy@ti.com,
        oleg@kaa.org.ua, Sakari Ailus <sakari.ailus@linux.intel.com>,
        simon@lineageos.org, xiaotong.lu@spreadtrum.com
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd>
 <CACRpkdYJNWC3RZXjCu+3EfRbPy6OyLLw-FivpFoe1p3ckHTCmg@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <90914660-6add-a4d9-0dfe-7b82a7664bd8@gmail.com>
Date:   Tue, 13 Nov 2018 20:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdYJNWC3RZXjCu+3EfRbPy6OyLLw-FivpFoe1p3ckHTCmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 10:23 PM, Linus Walleij wrote:
> On Sun, Nov 11, 2018 at 1:03 PM Pavel Machek <pavel@ucw.cz> wrote:
> 
>>> -"devicename:colour:function"
>>> +"colour:function"
>>
>> I don't think we want to do it in all cases.
>>
>> So, on my cellphone seeing lp5523:green:led is indeed not useful.
>>
>> But on notebook with usb keyboard attached, you need to keep the
>> devicename to be able to distinguish capslock on internal keyboard and
>> capslock on first USB keyboard and capslock on second USB keyboard.
> 
> I agree with Pavel.
> 
> I ran into this when connecting two identical keyboards to the
> same machine. The driver worked fine up until it tries
> to create two sysfs entries with the same name for capslock.
> BOOM!

What kernel version did you use? LED core has had a protection
against name clash since the commit:

commit a96aa64cb5723d941de879a9cd1fea025d6acb1b
Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon Mar 30 10:45:59 2015 -0700

    leds/led-class: Handle LEDs with the same name

    The current code expected that every LED had an unique name. This is a
    legit expectation when the device tree can no be modified or extended.
    But with device tree overlays this requirement can be easily broken.

    This patch finds out if the name is already in use and adds the suffix
    _1, _2... if not.

    Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Bryan Wu <cooloney@gmail.com>


> In this case I suggest "serialnumber:color:capslock" and
> similar.
> 
> The important point is the string must be unique for each
> plugged device.

-- 
Best regards,
Jacek Anaszewski
