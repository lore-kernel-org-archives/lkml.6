Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B5D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss5SecYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B5D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbeGTUAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:00:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33480 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388334AbeGTUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:00:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so4928335wma.0;
        Fri, 20 Jul 2018 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zA7SueiGRMYRlTvyb4Cak8oxv9oaPgjG1QFn7sLnpfE=;
        b=Ss5SecYaKgWzxU4qbp3U6DOHiJJ7RN+lFa7bkFOpIDpTlFPwZb07DCwRr5eN9gLyMC
         qzXPkNSJJOP1G51B3BG/ReJqyJFk56MqoV3mjnnBxgwzyFdm7imw31JbcOwKuWBWTFUG
         0Uf0LXBfanQ+xPuYBlOk4u+TVhIyz7dkeu8LuBsxYxPh1C6LqPRj3o49p+MMhxCPD+eX
         8kXZ61ehXZuhPt8fZIX5H08ZZzaAHpNXdenFJ6Vo2FK0YaSbK3MMshJH/Oy2on+lka8y
         neIVe/kbQQ95/1JaZl++eEOcITG6l8HoF/qX4hAP9dguPCvjwiOIcYE1Ixvc0Zw2a5tS
         QUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zA7SueiGRMYRlTvyb4Cak8oxv9oaPgjG1QFn7sLnpfE=;
        b=AgF63jiYNZgmZisv/GOGrjPlsEY+57SlGRaUBGqywxabrlQ7TEMq6i0vtsSiz3xmw4
         QTCjMiD8OE5gkeYmBv1qNZmWEoRSI5/PGKrwJxWXiYjSRY6bYL5UiI0eORGFsKZtmnTa
         pz0G5bbNBH+WASorQOnyeaSGn1AZCOSi2IadX/4zngeLi/rYJUDov8FgmxAEalhLb7ef
         q6ykJ5vVTfLd2/9z/wWEgqFjA/qDqtpO09oXlxdDzOPu5Ctk+hqAVMXg1kzmNY1AEEGq
         I1/r4YlC/jxTX/9z1FRocF+LoaTbyqB511tumAs5i1bS2EzrctFkPuqF0DiNldnOvGfb
         2wwA==
X-Gm-Message-State: AOUpUlEkn4rdiV9nb+UeQNOS2nDjD8kGjJx4Ib4oHfSpo5o/4lcLAock
        6maor0zz/3ToZgCTXjnehAXYkToI
X-Google-Smtp-Source: AAOMgpeJXJHj49mDKVr7uuxI5YYACE90BTPZsQX6qsdMCQvQ03EXkiFTRQ1bCNINm8N4DsVC1Qy1YA==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr2367425wmc.27.1532113873977;
        Fri, 20 Jul 2018 12:11:13 -0700 (PDT)
Received: from [192.168.1.18] (chg252.neoplus.adsl.tpnet.pl. [83.31.4.252])
        by smtp.gmail.com with ESMTPSA id b123-v6sm3646377wma.24.2018.07.20.12.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 12:11:13 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     David Lechner <david@lechnology.com>, Pavel Machek <pavel@ucw.cz>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd> <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
 <CAMz4kuJa=s19q7wQFQT1giUe0AN4hpux4PG2koUcnE7q_x7LCQ@mail.gmail.com>
 <20180718120836.GB23157@amd>
 <47b1b143-48dd-a265-c2af-254dda53a2cc@lechnology.com>
Message-ID: <8e51d2f1-0fc0-a968-4f97-3a4e09dd99e0@gmail.com>
Date:   Fri, 20 Jul 2018 21:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <47b1b143-48dd-a265-c2af-254dda53a2cc@lechnology.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 07/18/2018 07:00 PM, David Lechner wrote:
> 
> 
> On 7/18/18 7:08 AM, Pavel Machek wrote:
>> On Wed 2018-07-18 19:32:01, Baolin Wang wrote:
>>> On 18 July 2018 at 15:56, Pavel Machek <pavel@ucw.cz> wrote:
>>>> Hi!
>>>>
>>>>>>>>> I believe I meant "changing patterns from kernel in response to 
>>>>>>>>> events
>>>>>>>>> is probably overkill"... or something like that.
>>>>>>>>
>>>>>>>> Anyway -- to clean up the confusion -- I'd like to see
>>>>>>>>
>>>>>>>> echo pattern > trigger
>>>>>>>> echo "1 2 3 4 5 6 7 8" > somewhere
>>>>>>>
>>>>>>> s/somewhere/pattern/
>>>>>>>
>>>>>>> pattern trigger should create "pattern" file similarly how 
>>>>>>> ledtrig-timer
>>>>>>> creates delay_{on|off} files.
>>>>
>>>> Yes, that sounds reasonable. v5 still says
>>>>
>>>> +               Writing non-empty string to this file will activate 
>>>> the pattern,
>>>> +               and empty string will disable the pattern.
>>>>
>>>> I'd deactivate the pattern by simply writing something else to the
>>>> trigger file.
>>>
>>> For the case we met in patch 2, it is not related with trigger things.
>>> We just set some series of tuples including brightness and duration
>>> (ms) to the hardware to enable the breath mode of the LED, we did not
>>> trigger anything. So it is weird to write something to trigger file to
>>> deactive the pattern.
>>
>> Confused. I thought that "breathing mode" would be handled similar way
>> to hardware blinking: userland selects pattern trigger, pattern file
>> appears (similar way to delay_on/delay_off files with blinking), he
>> configures it, hardware brightness follows the pattern ("breathing
>> mode"). If pattern is no longer required, echo none > trigger stops
>> it.
>>                                     Pavel
>>
> 
> I was confused too when I first read this thread. But after reviewing 
> v5, it is clear that this is _not_ a trigger (and it should not be a 
> trigger). This is basically the equivalent the brightness attribute - 
> except that now the brightness changes over time instead of being a 
> constant value.

Pattern trigger would be just more flexible version of existing
ledtrig-timer.c, which also changes brightness over time.

Trigger, by definition, is a kernel based source of LED events,
so timer trigger falls under this definition, same way as pattern
trigger would.

What may cause confusion is the possibility of exploiting hardware
capabilities, in case the requested settings fit in.
ledtrig-timer fathom the hardware capabilities using blink_set op,
and pattern trigger would use pattern_set op for that purpose.

> This way, the pattern can be used in conjunction with 
> triggers.
> 
> For example, one might want to set the _pattern_ to something like a 
> "breathe" pattern and set the _trigger_ to the power supply charging 
> full trigger. This way, the LED will be off until the battery is full 
> and then the LED will "breath" when the battery is full.

AFAICS you comprehend "pattern trigger" notion as a LED trigger that
activates pattern functionality. I'd say that you'd need a specialized
"battery" trigger for that purpose, that instead of calling
led_set_brightness_nosleep() would schedule call to
led_trigger_set(led_cdev "pattern"), assuming that pattern trigger
would be implemented as I explained above.

-- 
Best regards,
Jacek Anaszewski
