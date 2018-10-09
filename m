Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B1ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD56F20644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXxmfG9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD56F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJBzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:55:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJBzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:55:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so2491961ljc.11;
        Tue, 09 Oct 2018 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YxrVkyPivpkFoQ0gm/AxS7eKXoEdX7Yw147iqGTDhTA=;
        b=LXxmfG9zN4r3UJcPEmwKtxjXd6x4jBzonHFw0zkCDNVBKNbWc4RuRL0xyTosnaggIm
         eB/RRty7ZAiwCtAWR3eV5n3+lq3lQe7TJXjivnIBy4uFk0VWaTggkI0Zp+UEpDkFFHPz
         YCro82WmExKS6xgoGYmswSWABrOSXJPWWAAHSqciN0b+gWqRw9J+e2FIgZEejbj+TbnZ
         HN/EiMFyvf9kiHxsza+2mrT9UIblJehLy+cIg1C+HXFm/t3M/Ie9i5aVDGZHi5ukZwRW
         /Qw7UAFwYQGdRXtyj1lAQT2TUVLyUScMxFyh8EBq9e842t6Tikx2wUZNI4EV/zhJwdF4
         pWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YxrVkyPivpkFoQ0gm/AxS7eKXoEdX7Yw147iqGTDhTA=;
        b=El8dxeCbQ0/uDxx7hNSE3jQH8s+h0axNB3YPvcIP+vDv/JPwcIlJwxy6Ai/f7rU6mA
         aAehqWajT7iEjpv428xidkoy1Rew3FWDfiyUbQYSPa3EB2U2kSVaxO3WVLw4CXMDadCK
         XSj1dVCug9pMDYjB+Ig3Z6jninQX0nxyEfXvsNyJbwGFRJTqvdFm4fJYW3ea4NfwsVaF
         8mHqly8KXups0Udvl7Af/mFkx4WVr0ClUwPWemG/VT0i8MvuxSHvb2m0aSahXAplYFhJ
         Lw1ewTPtiCop3+HP1j0JUf/8bgJiHBvZuPACOh7RFt87jYo82wt9bw5sjys5prAAILX6
         B+kA==
X-Gm-Message-State: ABuFfogQUk7Yql+/n9vrjt0rJqky1TSxdwzQTFuyQ0IDnhY22Q6MU+rm
        G4BWVw8AAdB5Q3RaZl3tPiWbYjto
X-Google-Smtp-Source: ACcGV605OhgzHJ46etb4HC2N2D6MoyVEM/bnw7EAJxnktStmWGhvHE4woCcouo5Dnj5vhK295QeS6g==
X-Received: by 2002:a2e:990a:: with SMTP id v10-v6mr4850084lji.22.1539110236720;
        Tue, 09 Oct 2018 11:37:16 -0700 (PDT)
Received: from [192.168.1.18] (dki68.neoplus.adsl.tpnet.pl. [83.24.12.68])
        by smtp.gmail.com with ESMTPSA id 25-v6sm4557003lfv.43.2018.10.09.11.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 11:37:15 -0700 (PDT)
Subject: Re: [PATCH v14 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <c3a6f08ac978c309bb0b002a0384c4f0ad0f59cd.1538494476.git.baolin.wang@linaro.org>
 <9bf6236e-83af-7156-b26b-7d88ece2d81e@gmail.com>
 <CAMz4kuJ4iB7pn+i29aypnbxxPK_UDjus=EiNZ2WefBB0onZPTg@mail.gmail.com>
 <7051613e-f2db-260f-85d7-d40278fd11cb@gmail.com>
 <CAMz4kuKJ73mHzYotwmx08h1sJJiKAZNCspo0_v7L-2Ec+5rEQg@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <931be52e-fa7e-72f8-0e5f-9a8a006d6ccd@gmail.com>
Date:   Tue, 9 Oct 2018 20:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKJ73mHzYotwmx08h1sJJiKAZNCspo0_v7L-2Ec+5rEQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 10/09/2018 02:01 PM, Baolin Wang wrote:
> Hi Jacek and Pavel,
> 
> On 5 October 2018 at 04:00, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>> Hi Baolin,
>>
>> On 10/03/2018 03:21 AM, Baolin Wang wrote:
>>> Hi Jacek,
>>>
>>> On 3 October 2018 at 04:25, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>>> Hi Baolin,
>>>>
>>>> Thank you for the v14. We'll probably need v15, though :-)
>>>>
>>>> I added the comments in the code below.
>>>>
>>>> On 10/02/2018 05:43 PM, Baolin Wang wrote:
>>>>> This patch adds one new led trigger that LED device can configure
>>>>> the software or hardware pattern and trigger it.
>>>>>
>>>>> Consumers can write 'pattern' file to enable the software pattern
>>>>> which alters the brightness for the specified duration with one
>>>>> software timer.
>>>>>
>>>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>>>>> pattern for some LED controllers which can autonomously control
>>>>> brightness over time, according to some preprogrammed hardware
>>>>> patterns.
>>>>>
>>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>> ---
>>>>> Changes from v13:
>>>>>  - Add duration validation for gradual dimming.
>>>>>  - Coding style optimization.
>>>>>
>>>>> Changes from v12:
>>>>>  - Add gradual dimming support for software pattern.
>>>>>
>>>>> Changes from v11:
>>>>>  - Change -1 means repeat indefinitely.
>>>>>
>>>>> Changes from v10:
>>>>>  - Change 'int' to 'u32' for delta_t field.
>>>>>
>>>>> Changes from v9:
>>>>>  - None.
>>>>>
>>>>> Changes from v8:
>>>>>  - None.
>>>>>
>>>>> Changes from v7:
>>>>>  - Move the SC27XX hardware patterns description into its own ABI file.
>>>>>
>>>>> Changes from v6:
>>>>>  - Improve commit message.
>>>>>  - Optimize the description of the hw_pattern file.
>>>>>  - Simplify some logics.
>>>>>
>>>>> Changes from v5:
>>>>>  - Add one 'hw_pattern' file for hardware patterns.
>>>>>
>>>>> Changes from v4:
>>>>>  - Change the repeat file to return the originally written number.
>>>>>  - Improve comments.
>>>>>  - Fix some build warnings.
>>>>>
>>>>> Changes from v3:
>>>>>  - Reset pattern number to 0 if user provides incorrect pattern string.
>>>>>  - Support one pattern.
>>>>>
>>>>> Changes from v2:
>>>>>  - Remove hardware_pattern boolen.
>>>>>  - Chnage the pattern string format.
>>>>>
>>>>> Changes from v1:
>>>>>  - Use ATTRIBUTE_GROUPS() to define attributes.
>>>>>  - Introduce hardware_pattern flag to determine if software pattern
>>>>>  or hardware pattern.
>>>>>  - Re-implement pattern_trig_store_pattern() function.
>>>>>  - Remove pattern_get() interface.
>>>>>  - Improve comments.
>>>>>  - Other small optimization.
>>>>> ---
>>>>>  .../ABI/testing/sysfs-class-led-trigger-pattern    |  76 ++++
>>>>>  drivers/leds/trigger/Kconfig                       |   7 +
>>>>>  drivers/leds/trigger/Makefile                      |   1 +
>>>>>  drivers/leds/trigger/ledtrig-pattern.c             | 431 +++++++++++++++++++++
>>>>>  include/linux/leds.h                               |  15 +
>>>>>  5 files changed, 530 insertions(+)
>>>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>>  create mode 100644 drivers/leds/trigger/ledtrig-pattern.c
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>> new file mode 100644
>>>>> index 0000000..22d7af7
>>>>> --- /dev/null
>>>>> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>>>>> @@ -0,0 +1,76 @@
>>>>> +What:                /sys/class/leds/<led>/pattern
>>>>> +Date:                September 2018
>>>>> +KernelVersion:       4.20
>>>>> +Description:
>>>>> +             Specify a software pattern for the LED, that supports altering
>>>>> +             the brightness for the specified duration with one software
>>>>> +             timer. It can do gradual dimming and constant brightness.
>>>>> +
>>>>> +             The pattern is given by a series of tuples, of brightness and
>>>>> +             duration (ms). The LED is expected to traverse the series and
>>>>> +             each brightness value for the specified duration. Duration of
>>>>> +             0 means brightness should immediately change to new value.
>>>>> +
>>>>> +             1. When doing gradual dimming, the led brightness will be updated
>>>>> +             every 50 milliseconds, so the duration of each step should not
>>>>> +             less than 50 milliseconds.
>>>>
>>>> I'd like to avoid this constraint. Lowest supported delta_t should be 1.
>>>>
>>>> We should only prevent entering dimming mode if current delta_t
>>>> is lower than UPDATE_INTERVAL.
>>>
>>> I do not think so. If the pattern format is used for dimming and the
>>> delta_t is lower than UPDATE_INTERVAL, we should return errors. Since
>>> in this case, we can not change to constant mode.
>>
>> I'll play with the code at weekend and will let you know my findings.
> 
> Thanks Jacek. Do you have any more suggestion?

Sorry to say, but I had really busy weekend and failed to carve out
time for looking into that. It's queued up with the highest priority
on my todo list of things needing more than five minutes of attention.

> BTW, we have not get a consensus about adding one 'dimming_interval'
> file to set the dimming interval instead of fixed 50 ms.
> Pavel, I want to hear your suggestion before I submit new patch set? Thanks.

I think that this feature belongs to the "nice to have" category,
and lack of it will not prevent us from merging the patch set.

-- 
Best regards,
Jacek Anaszewski
