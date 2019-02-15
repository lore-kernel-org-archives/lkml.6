Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958621900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394166AbfBOL1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:27:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37765 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBOL1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:27:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id m12so7667551edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EtNMZwiHTC0iw7fMTcpJk9syhTrjtdjMJznWwL4OPfg=;
        b=Xjj2nsjOxcHIcUhGk0+DAN1vNVgWCkQlqJlwUPhVHHQemgsMnHjrSm3GLGYtbGgbXU
         oEhgzv2psCyoSjyKExP7o9jhYnePnXAqNA8+widOGrrJf7pMSWUSpoH86yJPCFNY6dYb
         H6fCmJhHmZYR0SZqZQ9OPNSejLxS9JSa+NFQwdGO7rWkfmyb6uRmSfIQOs/RONWv5+aA
         1tWekNt8QjTjbrKtBmGWrVICb+Rp2yzdUhypRHFGvyFU2Dgm34u+t+JQ9PyAY8ite9dB
         k/MgUy0PqnvdHtAwP9zUUSL/JYqhuq2W+bd6kR8PJn4HDtoOa3HjWm2zYvoyxhbgRCpb
         +a8w==
X-Gm-Message-State: AHQUAuYsvsiYrQ2/Fo/YWxvcx44NoJXFU3iHq2Mxt4oigz6E+gFrxMVT
        9sPU3IPSfONpHlbskl2NadKaug==
X-Google-Smtp-Source: AHgI3Iag9yqyR6zkOuuRteLuTgF8tvgfX893ZAgIkHI83YOsubrIyZBnPl1RpHu+V2r9ksSiaqUi5g==
X-Received: by 2002:aa7:c6da:: with SMTP id b26mr7236762eds.258.1550230038475;
        Fri, 15 Feb 2019 03:27:18 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id r22sm199755ejb.1.2019.02.15.03.27.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 03:27:17 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com> <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
Date:   Fri, 15 Feb 2019 12:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214230307.GA17358@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15-02-19 00:03, Pavel Machek wrote:
> Hi!
> 
>>>>> I suggest that we deal with this special case by adding 3 custom
>>>>> sysfs attributes:
>>>>>
>>>>> 1) "mode" which when read, prints, e.g. :
>>>>> manual [on-when-charging]
>>>>
>>>> While this allows _user on console_ to control everything using echo,
>>>> it is not suitable for applications trying to control LEDs.
>>>>
>>>> As there's nothing special about the case here, I believe we should
>>>> have generic solution here.
>>>>
>>>> My preffered solution would be "hardware" trigger that leaves the LED
>>>> in hardware control.
>>>
>>> As you explained in the parts which I snipped, there are many
>>> devices which have a similar choice for a LED being under hw or
>>> user control. I can see how this looks like a trigger and how we
>>> could use the trigger API for this.
>>>
>>> I believe though, that if we implement a "virtual" (for lack of
>>> a better word) trigger for this, that this should be done in the
>>> LED core. I can envision this working like this:
>>>
>>> 1) Add a:
>>>
>>> hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
>>
>> Please note that we have support for hw patterns in the pattern trigger.
>> (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
>> breathing pattern).
>> We have also support for hw blinking in timer trigger via blink_set op.
>>
>> In addition to that there is brightness_hw_changed sysfs attribute
>> with led_classdev_notify_brightness_hw_changed() LED API.
>>
>> Couldn't they be used in concert to support the specific features
>> of the device in question?
> 
> I believe main issue here is this:
> 
> Hardware can automatically control the LED according to the charging
> status, or it can be used as normal software-controlled LED.
> 
> I believe we should use trigger to select if hardware controls it or
> not (and then add driver-specific files to describe the
> details). Other proposal is in the mail thread, too.

Right, so there are really 2 orthogonal issues here:

1) With this hardware the LED is either turned on/off automatically
by the PMIC based on charging state; or it is under user control.

This is different from the led_classdev_notify_brightness_hw_changed
case, where the hardware may update the state underneath the driver,
but the driver can still always update the state itself. In this case
if the LED is in hw-control mode then the driver cannot turn it on/off.

Pavel suggested modeling this with a new "hardware' trigger, where
setting the trigger to this trigger will enable the hw-controlled
mode and setting any other trigger will switch thing to the user-controlled
mode.

2) This hardware can do blinking / breathing. There are various issues with
this:

2.1) Blinking is more or less covered by the timer trigger. But breathing is
not the pattern trigger is a poor match since there is only 1 fixed pattern

2.2) The supported blinking frequencies are very limited, so it might be better
to keep the standard software blinking mode and have a special sysfs attribute
to select the hardware blink support

2.3) The user can also select between continuous on / blinking / breathing
when the LED is under hardware control (it will then be on / blinking / breathing)
when charging.

My suggestion for dealing with this is 2 new device specific sysfs attributes.

a) "pattern" which when read outputs e.g.:
on blinking [breathing]
And

b) "pattern_delay_on_off" which sets the on and off times for the hardware
patterns on milliseconds, mirroring the delay_on / delay_off attributes
from the timer trigger.

Note we could alternatively use: "hw_pattern" and "hw_pattern_delay_on_off"
to make it clear that this is done in hardware.

To deal with interactions with the standard API I suggest we reset pattern
to "on" when brightness gets set to 0, similar to how we stop the timer
trigger then, etc.

Regards,

Hans

