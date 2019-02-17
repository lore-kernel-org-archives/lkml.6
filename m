Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA51C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEA121916
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfBQOKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:10:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33249 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfBQOKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:10:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so11671276edi.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 06:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//ZRWvJyweKhrIvvexvNM7vmeuBsg2ofT5HEXjevDhU=;
        b=gSUuplUEAJw1vpcY5aiyviZ6xyAvnlr+sxXggBunU314RlliidG4bfxL7aKS7BUyM8
         IIeNtxc9cD3LKWTn4EP7R9M1W3j8ZTpOPMImDA1f5G2NSDfkoy2+BmsgLwH5GumijN3c
         8giGa4fb5slJTWBSxvU1dyR0lp2PqNLrUVg52EK11Ek7x3ctVH1kHGHpz13RuCKbbYXX
         zBH6Mr76t3RgAKfQsoOany5E1XfC37oPdH2qXg6uSOKD9gQZzwvQWUwDnhrkV75svVoc
         BNPiVFCv8XNntpv4vjqclHIiQL/WgTeZU3izkPlc4c7PF91b8OFsNViXzJ3EUKRszP9+
         vONQ==
X-Gm-Message-State: AHQUAubEZtgpYXbiwnAGvjVTk0aD8jXXne/F8GZjFeeZS0axjxEGQWHV
        1bOCPWQq02V3cYYeH/io2cfi++ZiBVw=
X-Google-Smtp-Source: AHgI3IZu4h6O+I2NWglHB3bAtK/fQcSQBMWIoOwmbUKcf/FEB2Z+zW7ieaXx8KnXH1veJlymPkb8pw==
X-Received: by 2002:a50:92cb:: with SMTP id l11mr15058571eda.25.1550412651112;
        Sun, 17 Feb 2019 06:10:51 -0800 (PST)
Received: from localhost.localdomain ([62.140.137.151])
        by smtp.gmail.com with ESMTPSA id x2sm1967913eji.15.2019.02.17.06.10.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 06:10:50 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
 <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
 <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
 <20190216193727.GA14305@amd>
 <7be63b6b-8d8d-90b8-fb17-d219b87a101f@redhat.com>
 <20190217000851.GA29803@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <81cc42f5-1f3d-c7f2-eb13-c2f8c4f9bfb4@redhat.com>
Date:   Sun, 17 Feb 2019 15:10:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190217000851.GA29803@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/17/19 1:08 AM, Pavel Machek wrote:
> 
>>> I don't pretend to fully understand it, _but_ hw_pattern should really
>>> describe the pattern LED should do, not whether it reacts to charging
>>> or not.
>>
>> Then we are back to step 1 of the discussion, that we need another
>> mechanism outside of the trigger to select if the LED shows the configured
>> pattern always, or only when the charger is on.
> 
> Yep, sorry.
> 
>> These really are 2 orthogonal settings, there is a pattern which can
>> be set and the LED can either show that pattern always; or only when
>> charging the battery. Note that the same pattern is used in both cases.
>>
>> This is why I previously suggested having a custom sysfs hardware_control
>> attribute which selects between the "only show pattern when charging"
>> modes ("hardware_control=1" or "always show the pattern mode"
>> ("hardware_control=0").
> 
> I see... and yes, that would be the easiest solution.
> 
> But somehow I see "this LED is controlled by charging state" as
> primary and "it shows pulses instead of staying on" as secondary
> eye-candy.
> 
> This week there was another driver for charger LED.. but that one does
> not do pulses. Ideally, we'd like consistent interface to the
> userland.
> 
> (To make it complex, the other driver supports things like:
>    LED solid on -- fully charged
>    LED blinking slowly -- charging
>    LED blinking fast -- charge error
>    LED off -- not charging).

Something like that could be supported with my original hw_pattern
proposal where we simply encode all of this in the hw-pattern file:

tupple0: charging blinking_on_time
tupple1: charging blinking_off_time
tupple2: charging breathing_time
tupple3: manual blinking_on_time
tupple4: manual blinking_off_time
tupple5: manual breathing_time

So for this chip you mention, we do not need the breathing time (no breathing support),
so we would get the following tupples:

tupple0: not charging blinking_on_time
tupple1: not charging blinking_off_time
tupple2: slow charging blinking_on_time
tupple3: slow charging blinking_off_time
tupple4: fast charging blinking_on_time
tupple5: fast charging blinking_off_time
tupple6: charging error blinking_on_time
tupple7: charging error blinking_off_time

Where by solid on/off can be done by setting one
of the blinking times to 0.

Having hw_pattern ABIs like this where some of
the tupples only activate on certain conditions
might be better then a hardware_control sysfs
file as it offers more flexibility.

Regards,

Hans
