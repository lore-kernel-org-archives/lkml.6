Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA452C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A4222D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbfBOW0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:26:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43212 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfBOW0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:26:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id m35so5188379ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKIjqgtlDlACH7hTt2ZlTkW/Uco0ejjAnOGf3tycgIA=;
        b=I619fJiw/pl6WtPKmvYTxGgfTyCcnikXTmL+a3heYmq0Kv3s6QUXdTKLpzao/U4Oi0
         CFt9lNnsWD8WIdzmLvNfXpgRGB4OKW7KMxNpaOo5KAloFOW1I22mlWD4v8lb9hQVl2L4
         pSBI93FnWTPc7CeYVgLeyTzLUwcuQlQWgCgpxyMXP7rW3JPmb4zkxv2lzBLSIycgqBY4
         JIpRMkmQWGN609if8S1kkp9zS3RLSc6CAZfCCrfbOE8CH/tfnbDLNZWtXMxAM/eXM5dH
         zomvNWOqSLCEAVcApo+81iKwZkd6MxZ3NZRg6PbiqJR2YZe4WAiPvOvyX4mPzwnNwTU8
         NkIw==
X-Gm-Message-State: AHQUAuZX4H3j0qYYVcDuK7HtnHxYNg2tIXmo71vFoNXivwelgZT5SV+/
        I9bJAhn3/oPfCs8UyR1wHpEv3Q==
X-Google-Smtp-Source: AHgI3IYKO9oCjbqqcYs7qTM2pXVhDs8tJaC3e6GY3yyCjGUhYyO3WXaP3q3deMVEYkkQFbicBJeQRQ==
X-Received: by 2002:a17:906:6a82:: with SMTP id p2mr1569034ejr.212.1550269588007;
        Fri, 15 Feb 2019 14:26:28 -0800 (PST)
Received: from localhost.localdomain ([2001:678:814:68:8573:4f61:f765:5d7e])
        by smtp.gmail.com with ESMTPSA id d7-v6sm1457722ejd.13.2019.02.15.14.26.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:26:27 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
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
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
Date:   Fri, 15 Feb 2019 23:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/15/19 10:42 PM, Jacek Anaszewski wrote:
> Hi all,
> 
> On 2/15/19 12:27 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 15-02-19 00:03, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>>> I suggest that we deal with this special case by adding 3 custom
>>>>>>> sysfs attributes:
>>>>>>>
>>>>>>> 1) "mode" which when read, prints, e.g. :
>>>>>>> manual [on-when-charging]
>>>>>>
>>>>>> While this allows _user on console_ to control everything using echo,
>>>>>> it is not suitable for applications trying to control LEDs.
>>>>>>
>>>>>> As there's nothing special about the case here, I believe we should
>>>>>> have generic solution here.
>>>>>>
>>>>>> My preffered solution would be "hardware" trigger that leaves the LED
>>>>>> in hardware control.
>>>>>
>>>>> As you explained in the parts which I snipped, there are many
>>>>> devices which have a similar choice for a LED being under hw or
>>>>> user control. I can see how this looks like a trigger and how we
>>>>> could use the trigger API for this.
>>>>>
>>>>> I believe though, that if we implement a "virtual" (for lack of
>>>>> a better word) trigger for this, that this should be done in the
>>>>> LED core. I can envision this working like this:
>>>>>
>>>>> 1) Add a:
>>>>>
>>>>> hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
>>>>
>>>> Please note that we have support for hw patterns in the pattern trigger.
>>>> (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
>>>> breathing pattern).
>>>> We have also support for hw blinking in timer trigger via blink_set op.
>>>>
>>>> In addition to that there is brightness_hw_changed sysfs attribute
>>>> with led_classdev_notify_brightness_hw_changed() LED API.
>>>>
>>>> Couldn't they be used in concert to support the specific features
>>>> of the device in question?
>>>
>>> I believe main issue here is this:
>>>
>>> Hardware can automatically control the LED according to the charging
>>> status, or it can be used as normal software-controlled LED.
>>>
>>> I believe we should use trigger to select if hardware controls it or
>>> not (and then add driver-specific files to describe the
>>> details). Other proposal is in the mail thread, too.
>>
>> Right, so there are really 2 orthogonal issues here:
>>
>> 1) With this hardware the LED is either turned on/off automatically
>> by the PMIC based on charging state; or it is under user control.
>>
>> This is different from the led_classdev_notify_brightness_hw_changed
>> case, where the hardware may update the state underneath the driver,
>> but the driver can still always update the state itself. In this case
>> if the LED is in hw-control mode then the driver cannot turn it on/off.
>>
>> Pavel suggested modeling this with a new "hardware' trigger, where
>> setting the trigger to this trigger will enable the hw-controlled
>> mode and setting any other trigger will switch thing to the user-controlled
>> mode.
> 
> We already do have hw_pattern file exposed by pattern trigger.
> It can be used to set hw breathing mode using some device specific
> syntax semantics, documented in dedicated ABI documentation.
> It was introduced for similar case, see
> Documentation/ABI/testing/sysfs-class-led-driver-sc27xx.

Ah I see, yes that could be used, the pattern would just be a single
integer specifying the cycle time in milliseconds, as nothing
else is configurable.

I think that should work fine, which means that we can use the timer and
pattern trigger support for the blinking and breathing modes.

That still leaves the switching between user and hw-control modes,
as discussed the hw-controlled mode could be modelled as a new "hardware"
trigger, but then we cannot choose between on/blink/breathing when
in hw-controlled mode. As Pavel mentioned, that would require some
sort of composed trigger, where we have both the hardware and
timer triggers active for example.

I think it might be easier to just allow turning on/off the hardware
control mode through a special "hardware_control" sysfs attribute and
then use the existing timer and pattern triggers for blinking / breathing.

Regards,

Hans
