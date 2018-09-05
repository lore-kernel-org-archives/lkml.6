Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43299C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88042075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4WkY4Ig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIELVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:21:31 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33613 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeIELVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:21:31 -0400
Received: by mail-oi0-f68.google.com with SMTP id 8-v6so11711974oip.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j5+LUeWkkvNyNEOqsV98RmeC5J0UDG1gH8etz9be/Yg=;
        b=Y4WkY4Ig/MZ1TBYRj8R2uba48wF4fPdNA52urla/8zWi0P15uH0CI84oDz9jN2+xAr
         bAi83JhLOfE2JsYjVfHlvNBWbljhQRvCRs1iAdwPXAjNjPYfy+yEQANACPcLsTY/XOAS
         Lz+ZLmFoxb25a2cyR4ryHGsDYfsVJ71P6lsZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j5+LUeWkkvNyNEOqsV98RmeC5J0UDG1gH8etz9be/Yg=;
        b=JM8y7PWamt1IrRPBOp3mlswYgF6PvGErZlBbXhNLnQJZD30RdVzmoUhEgLIPM1IdCs
         P/4VEtee4IiqHlU+/fAMxiYDSwk0YCqbZAZDh8XEWof3oE1IOSK0UglEbH+PQ0m9e/TO
         l53WCsgEg7MMG9Dt4sF53GyfMZ7qqJxAF9AuD7XLm/3wBQZbYST7KnCsynOYVai3E2Vt
         xG03VLBTBSGl9Nsqr9k9q3rge4on+dOIi8UjcXqJbhXuAtfdZQ1a1lQE8Lo0fThBXJeP
         QGGxFL4bEITBwrBYrNQncvx0Mt2nDYDn19qpyf4CkZyjctZ+htwPnAWXL8g6D9UvKjQy
         h9wQ==
X-Gm-Message-State: APzg51AS+FOadWY3muU21KjUf1YYqrb+Ph2VMrke6R+nNZoAsT46uxXX
        Tc0qyUf0lJcqUSsEO4//BmfL4Sj0z/V4bcutMXrc+A==
X-Google-Smtp-Source: ANB0VdZZEqjMSDQpEmO68GEIpfQs5CxyFikHg/ZmyCMZLPZ2n8JdrYpmcZfET/nNx3J1MOGESdr212w9+648sMiqv84=
X-Received: by 2002:aca:741:: with SMTP id 62-v6mr17373336oih.168.1536130368308;
 Tue, 04 Sep 2018 23:52:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 23:52:47 -0700 (PDT)
In-Reply-To: <CAMz4kuJJUXe-z5s5cRQG19Yj4RE3uVqOCdWNpOX3f+wvW+WbrQ@mail.gmail.com>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <e7642c73ac1c20b97990a887f76f2f51c41f930b.1536027873.git.baolin.wang@linaro.org>
 <ff34b0fd-dd56-f239-94a9-d84673f6869a@gmail.com> <CAMz4kuJJUXe-z5s5cRQG19Yj4RE3uVqOCdWNpOX3f+wvW+WbrQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 5 Sep 2018 14:52:47 +0800
Message-ID: <CAMz4kuK6KF61dDYCHBZchMd+rT1bkT04oiLsb-M8Zfj2y8dZUw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] leds: sc27xx: Add pattern_set/clear interfaces for
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

On 5 September 2018 at 10:43, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Jacek,
>
> On 5 September 2018 at 04:19, Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> Hi Baolin,
>>
>> On 09/04/2018 01:01 PM, Baolin Wang wrote:
>>> This patch implements the 'pattern_set'and 'pattern_clear'
>>> interfaces to support SC27XX LED breathing mode.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> ---
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
>>>  .../ABI/testing/sysfs-class-led-driver-sc27xx      |   11 +++
>>>  drivers/leds/leds-sc27xx-bltc.c                    |   94 ++++++++++++++++++++
>>>  2 files changed, 105 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>> new file mode 100644
>>> index 0000000..ecef3ba
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
>>> @@ -0,0 +1,11 @@
>>> +What:                /sys/class/leds/<led>/hw_pattern
>>> +Date:                September 2018
>>> +KernelVersion:       4.20
>>> +Description:
>>> +             Specify a hardware pattern for the SC27XX LED. For the SC27XX
>>> +             LED controller, it only supports 4 hardware patterns to configure
>>
>> If I understand it correctly then the four components: low, rise, high,
>> and fall time make a single pattern. So calling it "4 hardware patterns"
>> can be misleading. Below you're using "stage" notion - it would be good
>> to use it consequently on the whole span of this document.
>
> Sure. I will modify the documentation to avoid misleading words.
>
>>
>>> +             the low time, rise time, high time and fall time for the breathing
>>> +             mode, and each stage duration unit is 125ms. So the format of
>>> +             the hardware pattern values should be:
>>
>> I'd be more precise here:
>>
>> Min stage duration: ???
>> Max stage duration: ???
>> Stage duration step: 125 ms
>
> OK.
>
>>
>>> +             "brightness_1 duration_1 brightness_2 duration_2 brightness_3
>>> +             duration_3 brightness_4 duration_4".
>>
>> Looking at sc27xx_led_pattern_set() it doesn't seem like you would
>> use brightnesses other then brightness_1. I assume that the low
>> brightness is fixed to 0 and the high brightness is the brightness_1.
>> If yes, than we don't need brightnesses in this pattern definition,
>> since the current brightness will suffice.
>>
>> You'd need to alter the hw_pattern description to say that the
>> brightness currently set is to be used as a high brightness, and the
>> hw_pattern for this driver consists only of the four delta_t components.
>
> Sorry for confusing here. For SC27XX LED, the 4 stages use one same
> brightness. To be compatible with the hardware pattern format, so we
> force to set one brightness for each stage. I will add some comments
> to explain the LED expects the same brightness for each stage instead
> of using the current brightness file which is not used for our
> breathing mode.
>
>>
>> This is clear example of what I had on mind when having doubts
>> about using tuples for pattern_set.
>>
>> Alternatively, if we want to enforce tuples format for hw_pattern,
>> and if we want to be consistent - we'd need to require defining target
>> brightness for each stage properly, i.e.
>>
>> echo "100 500 100 500 0 500 0 500" > pattern

After more thinking, I will change the description to reflect the real
brightness according to your suggestion. Please see my new patch.
Thanks.

>>
>> Which would mean:
>>
>> 1. Rise from brightness 0 to 100 for 500 ms.
>> 2. Keep brightness 100 for 500 ms.
>> 3. Fall from brightness 100 to 0 for 500 ms.
>> 4. Keep brightness 0 for 500 ms.
>>
>> --
>> Best regards,
>> Jacek Anaszewski
>
>
>
> --
> Baolin Wang
> Best Regards



-- 
Baolin Wang
Best Regards
