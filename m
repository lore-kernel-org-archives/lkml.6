Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B40C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64D420823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfBPUzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:55:47 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34301 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfBPUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 15:55:47 -0500
Received: by mail-ed1-f46.google.com with SMTP id b3so10709731ede.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 12:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JkHRzx57Bmt3kE/RGXxfdDJvpQx2jBwFf7qCluVXvk=;
        b=bSrv3IUsuJVUmuWu6KKmWq6/4g3z+wxvNqa0eIfd/SAeKcfER2rwYwD3HaFEdEdVaj
         JaK/zMVu5HxjBKafPmfy0canpGE4d8wszCj9vwAwA3QGu5ouRdNfDgrADME/dhk+zQ2w
         E0Mb5OMkna2PVijQ4IUo0/8dHVOWySaTINbvuaoo0gQ8uk/8nEXybg9xl7cgWA6m7xEE
         55YhnJefNQeQltX5H17n2BdVdbklZt/jJZG2q3g1EXVdoNQ+5vxPj6o/PdY5BztEia/A
         2nQma0DBXCd0N64uaP2B19NwXxFCJP2gRUu8WsjCkIgtc34PDoWbr1FzVtReNI0fv1bN
         qAkQ==
X-Gm-Message-State: AHQUAuYBNwbgS+hAlkWaFq+PYS1BrrZGzNJ66EzsWDtqSoy2wwIKqSbz
        rMLOv2i62J4qTxd1RTPs0Lz3Qg==
X-Google-Smtp-Source: AHgI3Ia9JgEAwtdX+p1/mjKcR9SGg35pvv6G5UL4rA31CUI9n04JdvfIDHoPkmlNASBe16TKbdsswg==
X-Received: by 2002:a50:a901:: with SMTP id l1mr12952843edc.90.1550350544688;
        Sat, 16 Feb 2019 12:55:44 -0800 (PST)
Received: from localhost.localdomain ([2001:678:814:68:8573:4f61:f765:5d7e])
        by smtp.gmail.com with ESMTPSA id x30sm2670882edd.30.2019.02.16.12.55.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 12:55:43 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
 <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
 <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
 <20190216193727.GA14305@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7be63b6b-8d8d-90b8-fb17-d219b87a101f@redhat.com>
Date:   Sat, 16 Feb 2019 21:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216193727.GA14305@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/16/19 8:37 PM, Pavel Machek wrote:
> Hi!
> 
>>>>>> I think that should work fine, which means that we can use the timer and
>>>>>> pattern trigger support for the blinking and breathing modes.
>>>>>>
>>>>>> That still leaves the switching between user and hw-control modes,
>>>>>> as discussed the hw-controlled mode could be modelled as a new "hardware"
>>>>>> trigger, but then we cannot choose between on/blink/breathing when
>>>>>> in hw-controlled mode. As Pavel mentioned, that would require some
>>>>>> sort of composed trigger, where we have both the hardware and
>>>>>> timer triggers active for example.
>>>>>>
>>>>>> I think it might be easier to just allow turning on/off the hardware
>>>>>> control mode through a special "hardware_control" sysfs attribute and
>>>>>> then use the existing timer and pattern triggers for blinking / breathing.
>>>>>
>>>>> Pattern trigger exposes pattern file by default and hw_pattern if
>>>>> pattern_set/get ops are provided. Writing them enables software and
>>>>> hardware pattern respectively.
>>>>
>>>> This is not about software vs hardware pattern.
>>>>
>>>> There are 2 *orthogonal*, separate problems/challenges with this LED controller:
>>>>
>>>> 1) It has hardware blinking and breathing, as discussed this can be
>>>> controlled through the timer and pattern triggers, so this problem
>>>> is solved.
>>>>
>>>> 2) It has 2 operating modes:
>>>>
>>>> a) Automatic/hardware controlled, in this mode the LED is turned
>>>> off or on (where on can be continues on, blinking or breathing)
>>>> by the hardware itself, when in this mode we / userspace is not
>>>> in control of the LED
>>>>
>>>> b) Manual/user controlled mode, in this mode we / userspace can
>>>> control of the LED.
>>>>
>>>> Currently there is no API in the ledclass to switch a LED from
>>>> automatic controlled to user controlled and back, This is what
>>>> the proposed hardware trigger was for, to switch to automatic
>>>> mode. A problem with this is that we still want to be able
>>>> to chose between continues on, blinking or breathing (when on),
>>>> configure the max brightness, etc.
>>>
>>> Yes, we do have the API to switch a LED from automatic (hardware
>>> accelerated) control to software control and back. This is pattern
>>> trigger, which exposes two files for setting pattern: pattern
>>> and hw_pattern. Writing pattern file switches the device to software
>>> control mode and writing hw_pattern switches it to the hardware control,
>>> with the possibility of defining device specific ABI syntax to enable
>>> particular pattern (blinking, breathing or event permanently on
>>> in case of this device).
>>
>> OK, I see. So we would use the hw_pattern for this and the driver
>> would implement the pattern_set led_classdev callback.
>>
>> The pattern_set callback would then expect 6 brightness/time tuples
>> with the following meaning for the time part of each tupple
>>
>> tupple0: charging blinking_on_time
>> tupple1: charging blinking_off_time
>> tupple2: charging breathing_time
>> tupple3: manual blinking_on_time
>> tupple4: manual blinking_off_time
>> tupple5: manual breathing_time
>>
>> Where only the times in tupple 0-2; or the times in 3-5 can be
>> non-zero. Having non zero times for both some charging and some
>> manual values is not allowed.
>>
>> If a breathing time is set, none of the other times may be non
>> 0. If blinkig_on and blinking_off are used then breathing_time
>> must be 0.
>>
>> When configured to blink then blinking_off must be either 0
>> (continuously on); or it must be the same as blinking_on.
>>
>>
>> I believe this will work, does this sound ok to you ?
> 
> I don't pretend to fully understand it, _but_ hw_pattern should really
> describe the pattern LED should do, not whether it reacts to charging
> or not.

Then we are back to step 1 of the discussion, that we need another
mechanism outside of the trigger to select if the LED shows the configured
pattern always, or only when the charger is on.

These really are 2 orthogonal settings, there is a pattern which can
be set and the LED can either show that pattern always; or only when
charging the battery. Note that the same pattern is used in both cases.

This is why I previously suggested having a custom sysfs hardware_control
attribute which selects between the "only show pattern when charging"
modes ("hardware_control=1" or "always show the pattern mode"
("hardware_control=0").

Regards,

Hans

