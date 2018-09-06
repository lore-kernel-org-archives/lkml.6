Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820EDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FDC2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Syqf3eZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FDC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeIFG7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:59:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42651 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:59:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so17636300oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=imKpnDG/aV3qpWKt+JPNwIRVJC88POjfyLVnWVmFVR4=;
        b=Syqf3eZ5mSWKzNmLaphP6/P0E/yyjlpsqonxFNF3aqo6rA95W/bEGMFoboT/p04uEa
         J9ZGBZOnEkfsP0HkfYQccaQ9+wMrwj6wSRYL67nJrkKzl6yrYup9QsjhC3/yhY0flf65
         wCzN5tf8L9Q1IP2zvbmHvxFGc2FXAI/bJCq14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=imKpnDG/aV3qpWKt+JPNwIRVJC88POjfyLVnWVmFVR4=;
        b=a+S9j2/ZX1Rz1PFI3/YBxaqcX2QmJ1LiK9NpnI5yxUUpjJgkMHX2Cq0wSBvyJEqvgU
         PaOcQfqsgmwoO0h7NYOtP+p6M3kwgAdCtsw2uXMIZpZIxZ2sAp2Zgwp+jTsQ1IJ8CGPa
         5Fwjsh8Z1XqRq7MLXAq/STrWrwPZdS6PNPRso6Co16WOqjgSl4n3Nqqg5PV9kjnIE5Re
         6AwzltmUABhAxUIZjTYLBy9LlusT5sQsWJt21Vh/gu0UZnrVfmoAoLTz9PbxaMtuDQQh
         VQ2BQ12WNOktZB2hWY98G5ORXKVMBqE0euQwGPPXyk8IC6sbJtzCF6d1in4YDVCUOCmJ
         iU0A==
X-Gm-Message-State: APzg51DO7D1x1+YoPFoL4rCoeApUVtjSnFVWVfvaSwWLTdb8YK0tvzX3
        /5HgoGKUfHCgxIrw5kneY4TwlPnJOh3CpYQ+wNTPfQ==
X-Google-Smtp-Source: ANB0VdaPbfu7QDQ+4XTr7VxGVawQAjd31pdg3uLH3iKbG2nTjm2oxKcpYP2PMSNONw04Lfqtqb51MAaRcu6cSm8QbcE=
X-Received: by 2002:aca:d706:: with SMTP id o6-v6mr624110oig.45.1536200764133;
 Wed, 05 Sep 2018 19:26:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 19:26:03 -0700 (PDT)
In-Reply-To: <CAMz4ku+JcfwGkSosJMtsK22hU3Ka+mp+X2dK0FagBDRv_fHWsQ@mail.gmail.com>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536131926.git.baolin.wang@linaro.org>
 <b079d9a27390d6589195906606e6bac143bdb95c.1536131926.git.baolin.wang@linaro.org>
 <059de1cc-e964-6976-15c6-bfb3385e1fcf@gmail.com> <CAMz4ku+JcfwGkSosJMtsK22hU3Ka+mp+X2dK0FagBDRv_fHWsQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 6 Sep 2018 10:26:03 +0800
Message-ID: <CAMz4kuJVhduAW19biMDCJ8vzkyfYndF0LYT6disgWMW6sQ8mGg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] leds: sc27xx: Add pattern_set/clear interfaces for
 LED controller
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 09:43, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Jacek,
>
> On 6 September 2018 at 03:14, Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> Hi Baolin,
>>
>> Thanks for the v9.
>>
>> On 09/05/2018 09:20 AM, Baolin Wang wrote:
>>> This patch implements the 'pattern_set'and 'pattern_clear'
>>> interfaces to support SC27XX LED breathing mode.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
>>> Changes from v8:
>>>  - Optimize the ABI documentation file.
>>>
>>> Changes from v7:
>>>  - Add its own ABI documentation file.
>>>
>>> Changes from v6:
>>>  - None.
>>>
>>> Changes from v5:
>>>  - None.
>>>
>>> Changes from v4:
>>>  - None.
>>>
>>> Changes from v3:
>>>  - None.
>>>
>>> Changes from v2:
>>>  - None.
>>>
>>> Changes from v1:
>>>  - Remove pattern_get interface.
>>> ---
>>>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   20 +++++
>>>  drivers/leds/leds-sc27xx-bltc.c                    |   93 ++++++++++++++++++++
>>>  2 files changed, 113 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>> new file mode 100644
>>> index 0000000..391ca6e
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>> @@ -0,0 +1,20 @@
>>> +What:                /sys/class/leds/<led>/hw_pattern
>>> +Date:                September 2018
>>> +KernelVersion:       4.20
>>> +Description:
>>> +             Specify a hardware pattern for the SC27XX LED. For the SC27XX
>>> +             LED controller, it only supports 4 stages to make a single
>>> +             hardware pattern, which is used to configure the rise time,
>>> +             high time, fall time and low time for the breathing mode.
>>> +
>>> +             For the breathing mode, the SC27XX LED only expects one brightness
>>> +             for the high stage. To be compatible with the hardware pattern
>>> +             format, we should set brightness as 0 for rise stage, fall
>>> +             stage and low stage.
>>> +
>>> +             Min stage duration: 1
>>> +             Max stage duration: 255
>>> +             Stage duration step: 125 ms
>>
>> It seems that min and max stage duration are given in device
>> specific levels in contrary to the step which is given in ms.
>> Please keep it consistent. If I'm getting it right then duration
>> constraints should be given as follows:
>>
>> Min stage duration: 125 ms
>> Max stage duration: 31875 ms
>
> This is not good for users. Since what we set into LED registers is
> step counters, and each step is 125 ms. Which means it only support
> 125ms, 250ms, 375ms, 500ms .... 31875ms.
>
> If user set stage duration to 200ms, what we actually set into LED
> registers is 1 step counter (200ms / 125ms = 1), which means the
> actual duration is 125ms. That will confuse the user. So I still like
> to force user to set the step counter which can show the real
> duration.

Ah, sorry for misunderstanding, to keep consistent with the
documentation, I will change the duration unit to ms and add more
documentation for the duration step in next version. Thanks.

-- 
Baolin Wang
Best Regards
