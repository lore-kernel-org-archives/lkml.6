Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B905C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD4A21A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A86C0ov0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfBPVzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 16:55:04 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35192 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfBPVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 16:55:04 -0500
Received: by mail-lf1-f50.google.com with SMTP id v7so9691378lfd.2;
        Sat, 16 Feb 2019 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VY7fHHAG4KU8LXetcIebfHfOpmZI8CPCLYXRFWTEkQM=;
        b=A86C0ov0y+M/ZBU+lzVgKBWnhsmQU8ax+dns/VcaYJJtBSRVnoCxFOZQLbsLVVUloK
         XDArR3/LgNVoIlsnnOhLP6gP2yWcTb9pc3GzMcij7rLxj/VwPQe/62+xgDLaJbJvoqgZ
         BPef0rHS4/ES41SibteOsmQvyLc+JV1+1tc5onm6ZFOZNP4CbeWYHlYDDa+vjaPAwGlt
         VngWw7YkGhJeVuPQsj/9VCYI0i1Il6RbHYz0LCHX0OS8I4jD+EAG7xKSXapGOoHmZ8z7
         hZGL7x3+fv3rWXx6ySYJKzSoCbjxg3VRwE8lFchEfTPVbZ8MM4Ae8iVpjsJUnJNjE9CU
         ObdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VY7fHHAG4KU8LXetcIebfHfOpmZI8CPCLYXRFWTEkQM=;
        b=PmEFPaafZUxeno2EpA9o3tKNKFRJ24pBewaNBYhsVd2VA3+nkghzVnLZ82fqtSLv9/
         Xcnb6QvfPeGSoGY/enlCVWXvWtW0L/pelPMp8zh52s0gVVSo4GGGYmsdGXIDdtc9HnMx
         UeUD6ZQctwBaihxLhaNpfPioue8wjWLJ4LzX4ALUI7W6EN/1MpeDi8GE+KgMjR2R4cH0
         AgEB95+omLS5HdVcvf4ndEcJPbvlDtQaAXLCvTbER2r79G0VdMzJ69V0sX0sCEMegbAR
         O8nR4fOhF15w05xhoN/01cuBxjgreCnCmpVUutFdSM3JiMelFYrnP3WdBC9hhvU/QRtI
         HZPA==
X-Gm-Message-State: AHQUAuZ42fvBl7CDS4LID9z6XAisJJx7VEmqlVzi8GDod8T2IzlTDwRn
        ta4sSCGtbaafW0gkKRW7eUidSb5e
X-Google-Smtp-Source: AHgI3Ibt2MOTxxgLYnITYQCJ9JwwVtPklpNDs18SXSDbTJupeUJK7cVxhSjn2gZ16Lu+H8UEAB3JbA==
X-Received: by 2002:a19:5013:: with SMTP id e19mr9238351lfb.89.1550354100673;
        Sat, 16 Feb 2019 13:55:00 -0800 (PST)
Received: from [192.168.1.18] (chf73.neoplus.adsl.tpnet.pl. [83.31.3.73])
        by smtp.gmail.com with ESMTPSA id q123-v6sm2397530ljb.60.2019.02.16.13.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 13:54:59 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
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
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <2d5c6f50-c41f-655c-ab03-0c66aa911a27@gmail.com>
Date:   Sat, 16 Feb 2019 22:54:57 +0100
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

This is hardware specific and is supposed to have dedicated ABI
documentation. There's no reason to introduce new mechanisms when
existing ones fit. It will still describe a pattern but activated
on some condition.

-- 
Best regards,
Jacek Anaszewski
