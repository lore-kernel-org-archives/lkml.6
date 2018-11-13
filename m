Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5182C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7ED22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slxdpBPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7ED22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeKNG5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:57:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36758 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:57:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so2508621edb.3;
        Tue, 13 Nov 2018 12:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xOwrm4sByeEcLXbu/5TSttfFrxwPYuvEn3EGSEQ0K8M=;
        b=slxdpBPOH0YfPWyc8nIBh2h5ccOktWolFvH1jCJwntn1lcQHdK9YZlVHeUAM0gb0t+
         aBVypFhjYGKHXfRRGNLG+49Y5qjBZUAOQIinEjxUWVJl1HGt9BmXJh2P/UI772JWKKJn
         7g3j+CouMi3qEremGGqHlflGtW10r+tUPK52I4iqjrPc/AqPGpt717/mmNWsnsKPaSXZ
         MC7HLzvxhjbJezJ1SPo6JWokdiwJNco2L8+WzNXY7pmnxhkhc/myLWOKt7RGt5c5zFe0
         RE6rATCtk6NsZOJzl7zbwvQtGRoNPgxwZ2ZjHGT+ixRQeKZ8VpZzDxiB+T9V9S9aXNEj
         5IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xOwrm4sByeEcLXbu/5TSttfFrxwPYuvEn3EGSEQ0K8M=;
        b=EpfWP/9isjwFqnHiLH1gNJHV1g6ElZwljhmASLiM6SPgK0XubYnTsUHJAhoCER2nn6
         0AEB8aBqv2mWgplkrCsdX1cAMuwcHJcKArRklWAF1ua0izcPNI6jnpXZ5zR1Hagn3+MY
         ePNNl6AM25EjbFsMN8SbWFJIGd1jWo4F+rdyG2jofb8QrFdeRmkgS8rMHbzxlO11s3hD
         SjTtt+yfKDmc6vhV5L8KkUoxA3MMFuO2/uND6YVvrnCNxFbGoX4ZrB4MeQioazpkHeSQ
         2U16LbwP4p5Lxw2pSjs/oXZyyO1XGVwWBzeZXTT5RjgvPoDs7PuSLYnzAQsmDRuPfbWm
         o7bw==
X-Gm-Message-State: AGRZ1gKsBnMJuUX9rteVcJE1J22AsTHmoZDtp4zZVun7zsKL5FCrR3fc
        icSeT9rGa+do9+Ns8GHnu7Y=
X-Google-Smtp-Source: AJdET5eLOCCDcGfZnU+DbW58mCEY/O0QL3w5qx/fioVAWKzi5d4jI7/07/87qioQZmZ4O3dZuhr2Rg==
X-Received: by 2002:a05:6402:8d2:: with SMTP id d18mr8457224edz.119.1542142661518;
        Tue, 13 Nov 2018 12:57:41 -0800 (PST)
Received: from [192.168.1.18] (dma68.neoplus.adsl.tpnet.pl. [83.24.56.68])
        by smtp.gmail.com with ESMTPSA id x58sm3567280edm.10.2018.11.13.12.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:57:40 -0800 (PST)
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
        Simon Shields <simon@lineageos.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-3-git-send-email-jacek.anaszewski@gmail.com>
 <20181111120234.GA28794@amd> <a640167b-3a3e-daea-b377-6e82b653c5e8@gmail.com>
 <20181111201605.GA20160@amd> <57b77d4e-39a0-aaf2-5952-c2c25dc58593@gmail.com>
 <20181112103513.GB5695@amd> <662c02ba-455b-e2bf-a5e2-ae3933161894@gmail.com>
 <20181112190554.GA13959@amd> <b167cfc1-e392-eec6-6455-5983dc1c7212@gmail.com>
 <20181112220616.GB11942@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <09372762-9778-6bf9-0352-7cbee945745f@gmail.com>
Date:   Tue, 13 Nov 2018 21:57:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181112220616.GB11942@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 11:06 PM, Pavel Machek wrote:
> On Mon 2018-11-12 21:11:32, Jacek Anaszewski wrote:
>> On 11/12/2018 08:05 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>>> My system looks like this:
>>>>>>>
>>>>>>> input16::capslock    tpacpi::bay_active    tpacpi::standby
>>>>>>> input16::numlock     tpacpi::dock_active   tpacpi::thinklight
>>>>>>> input16::scrolllock  tpacpi::dock_batt	      tpacpi::thinkvantage
>>>>>>> input5::capslock     tpacpi::dock_status1  tpacpi::unknown_led
>>>>>>> input5::numlock      tpacpi::dock_status2  tpacpi::unknown_led2
>>>>>>> input5::scrolllock   tpacpi:green:batt	      tpacpi::unknown_led3
>>>
>>>>> But it is not just for backwards compatibility. See my examples above,
>>>>> it is needed to tell which device the LED is asociated with, and it is
>>>>> absolutely required for USB devices (for example).
>>>>
>>>> For USB devices there is already ledtrig-usbport available, which
>>>> provides sysfs interface for defining and reading the usb ports,
>>>> the status of which the LED indicates. Since the USB devices can be
>>>> attached/removed dynamically, it would be impossible to reflect
>>>> the associations in the LED class device name.
>>>
>>> I'm not talking USB activity. I'm talking USB devices with LEDs on
>>> them, like for example keyboards.
>>>
>>> Please take a look at example above. input16::numlock ;
>>> input5::numlock . You absolutely need device part.
>>
>> It would be redundant since there is "device" symbolic link
>> created in given LED class device sysfs directory, pointing to the
>> corresponding input device directory, like in case of my USB
>> keyboard:
> 
> You are right I forgot about the device symlink, and it partly helps
> with the USB keyboard case... 
> 
> But you still need the device part. Sysfs will not like two
> directories named "::numlock".

LED core has a protection against that. See my reply to Linus.

> 
>> #/sys/class/leds/input5::scrolllock$ ls -l
>> total 0
>> -rw-r--r-- 1 root root 4096 Nov 12 20:22 brightness
>> lrwxrwxrwx 1 root root    0 Nov 12 20:22 device -> ../../input5
>> -r--r--r-- 1 root root 4096 Nov 12 20:22 max_brightness
>> drwxr-xr-x 2 root root    0 Nov 12 20:22 power
>> lrwxrwxrwx 1 root root    0 Nov 12 20:04 subsystem ->
>> ../../../../../../../../../../../class/leds
>> -rw-r--r-- 1 root root 4096 Nov 12 20:22 trigger
> 
>>> Because userspace needs that information?
>>>
>>> Say you have raid array, with "error" leds for each drive (your list
>>> already contains "hdderr"). Now userland detects problem with hdparm
>>> on /dev/sdi. It would like to turn on corresponding LED.
>>>
>>> How do you propose we do that?
>>
>> Similarly as in case of USB keyboard.
> 
> Not really, I'm afraid. Hard drives have no red LEDs on them (and the
> LED would not be visible, anyway) so the "device" symlink in such case
> would point to some kind of i2c LED controller.
> 
> Eventually we'll need to have two devices for each LED. "Controller
> this is on" -- in device symlink and "device this talks about".

After thinking it over I agree - we will still need devicename part
Please refer to my reply to Rob.

-- 
Best regards,
Jacek Anaszewski
