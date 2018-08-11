Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5F8C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25969219C8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHwS/Lsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25969219C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeHKEtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 00:49:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37609 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeHKEtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 00:49:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id j205-v6so18968586oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 19:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bI6BXzuAoIwh36HFd/ZEQZzlPPNHzJFzUrBq/60xplQ=;
        b=JHwS/LshX724+l6V4ouUlCIfNf3h1RYykbP96y4cafjuanEiHn9FFsky5NRU+6OGmm
         kyk+lvZ/ikdIpsT+XhpZxbPsC71v8p4hIN0n1bw+ZK5w2u44QYRQoTUfwX3YWq9KX5Fd
         aRMzmsaGNaDwWbqlM2e8tvdJGYTqyfXbQ3CbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bI6BXzuAoIwh36HFd/ZEQZzlPPNHzJFzUrBq/60xplQ=;
        b=uJiO7TSY+We0u33lasNJSE7YRooON3nSobVo0a24T+Qr6nNIGshrU4B6/iAnYrShg6
         r9kmAy7yg7oCb7UnKTSSrzoUOX3HNzb4Imhg526TK5nHEKt7MoJq78L+us3V0wU12ZQd
         9HQ0bB0+LupZ+aSX5zZv6HxTvt8cJo0NzCgPmtVuCux4CBH7GmcO8y25TCN61Hq1UmfZ
         a45BoY/ZnxSkapdhbHPOB3cqg8obJ6K7NtU0iX/DSJbAuNZGGClr7ATZvntn9s+F3rBG
         NGxvpChXGArWAF+cHBqJbKa6UAMfNsC6tj1E15oUspjghHY26oJdcpEiAmwjfLbyXmos
         mDDA==
X-Gm-Message-State: AOUpUlF2+R1mYTHEBCjaF7dQOdhy7Oi3XHf40nDXZdwN9HPtg7xdD4xm
        Z05IQU/2Z598/XYQl3v1NVop7DZvqEtke1ctHEeb2g==
X-Google-Smtp-Source: AA+uWPzVTJ5tJC0bGQQ7NhGzzkwcdZ3RBmZiJi3LJThVrafMt62wyQzA+ZbOD51t5XZ28cdbeR1SoM/NqG8og6l5oIw=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr9247966oih.31.1533953832536;
 Fri, 10 Aug 2018 19:17:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 19:17:11
 -0700 (PDT)
In-Reply-To: <90e7f2b4-b706-4784-a7c6-30dba1614e67@gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <CAMz4kuL8ufCqbqgegozJt3P7JON0AzA9KrbvcvOB15McA5S=zA@mail.gmail.com>
 <5d594e9b-9889-adc2-cc59-f4f45eea7ddb@gmail.com> <CAMz4kuJBT2m8YpsAFufiGQFOYCgBbyf9Rrhce+396pRoW802aw@mail.gmail.com>
 <cc29be64-47a5-2bc1-f1be-64b4ad7e1a6d@gmail.com> <CAMz4kuKs09P4_9k=_U1jYOpYz_8UHkHGpD_Wketpd35uqdBRoA@mail.gmail.com>
 <90e7f2b4-b706-4784-a7c6-30dba1614e67@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sat, 11 Aug 2018 10:17:11 +0800
Message-ID: <CAMz4ku+wV1WAyq-ZO5y66b_H2p__hDzaXNquRctNSaHRj0xiOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 11 August 2018 at 02:10, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 08/10/2018 05:26 PM, Baolin Wang wrote:
>> Hi Jacek,
>>
>> On 9 August 2018 at 21:21, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>> Hi Baolin,
>>>
>>> On 08/09/2018 07:48 AM, Baolin Wang wrote:
>>> [...]
>>>>>>>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>>>>>>> +                                   struct led_classdev *led_cdev)
>>>>>>>> +{
>>>>>>>> +     if (!data->npatterns)
>>>>>>>> +             return 0;
>>>>>>>> +
>>>>>>>> +     if (led_cdev->pattern_set) {
>>>>>>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>>>>> +                                          data->npatterns, data->repeat);
>>>>>>>
>>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>>> lead to the situation where LED class devices that support hardware
>>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>>> resort to using software pattern engine which will accept far greater
>>>>>>> amount of pattern combinations.
>>>>>>
>>>>>> Hmmm, I am not sure this is useful for hardware pattern, since the LED
>>>>>> hardware can be diverse which is hard to be compatible with software
>>>>>> pattern.
>>>>>>
>>>>>> For example, for our SC27XX LED, it only supports 4 hardware patterns
>>>>>> setting (low time, rising time, high time and falling time) to make it
>>>>>> work at breathing mode. If user provides 3 or 5 patterns values, it
>>>>>> will failed to issue pattern_set(). But at this time, we don't want to
>>>>>> use software pattern instead since it will be not the breathing mode
>>>>>> expected by user. I don't know if there are other special LED
>>>>>> hardware.
>>>>>
>>>>> Good point. So this is the issue we should dwell on, since the
>>>>> requested pattern effect should look similar on all devices.
>>>>> Of course in case of software pattern it will be often impossible
>>>>> to achieve the same fluency. Similarly as in case of rendering graphics
>>>>> with and without acceleration.
>>>>>
>>>>> In case of your device, I'd say that we'd need more complex description
>>>>> of breathing mode pattern. More complex than just four intervals.
>>>>> It should reflect all the intervals the hardware engine needs to perform
>>>>> to achieve the breathing effect. Can this information be inferred from
>>>>> the docs?
>>>>
>>>> >From our docs, it only provides registers to set the low time, rising
>>>> time, high time and falling time (value unit is 0.125s and max value
>>>> is 63 = 7.875s) to enable breathing mode. So each interval value can
>>>> be 1 ~ 63. But that is still hard for software pattern to simulate the
>>>> breathing mode performed by hardware pattern.
>>>
>>> Software fallback is not expected to show similar performance to the
>>> hardware engine on the whole span of the supported time range.
>>>
>>> Having min rise time value at 125ms, and given that max_brightness
>>> is 255, then we'd have 255 / 125 = 2.04 of brightness level rise per
>>> 1ms. So, the pattern for rising edge could look like (assuming we
>>> stop at 254):
>>>
>>> 0 1 2 1 4 1 6 1 8 1 10 1 ... 254 1
>>
>> Right, maybe this can work, maybe not. Since we can met different
>> cases when failed to issue pattern_set(). Maybe the LED hardware
>> occurs some errors, in this case we should shutdown the LED, not
>> enable the software pattern instead, which still can not work.
>
> This is arguable. Timer trigger always resorts to using software
> fallback if blink_set() fails.

Timer trigger is simple which only need delay_on and delay_off, that
means software can be easy to show the same performance. But hardware
pattern can be diverse, we need to convert hardware patterns to
software patterns.

>> Maybe
>> driver can set NULL for pattern_set/clear interfaces to disable
>> hardware pattern, then next time user will perform the patterns with
>> software pattern mode.
>
> Resetting any ops after LED class driver is probed should be
> deemed forbidden, since LED core can make some decisions basing on
> whether given ops are initialized or not.

OK.

>
>> For our SC27XX LED, like I said if user provides only 3 pattern values
>> which will failed to issue pattern_set(). But I still do not need use
>> software patterns to show similar performance, instead it will still
>> keep the last hardware pattern performance ( It did not overlap the
>> previous hardware pattern setting). Maybe different drivers have
>> different error handling, that's why I think we can leave driver to
>> choose the proper way to handle.
>
> ABI semantics is generic, i.e. common for all drivers. Driver can
> always log any problems occurred while setting pattern, but it shouldn't
> necessarily need to prevent pattern trigger from using software
> fallback.

Fine.

>> Honestly, can we keep this pattern trigger simple and easy at first?
>> If some drivers want to use software patterns to perform again once
>> their hardware patterns performed failed (IMHO our SC27XX LED do not
>> need), then we can add this feature, at that time we will have users
>> to test and optimize the feature. Maybe I am wrong:)
>
> In other words you want to prevent users from exploiting the flexibility
> of pattern trigger, and limit them to using always only breathing
> scheme for SC27XX LED. What if someone would like to employ pattern
> trigger for encoding morse message to report system errors?

I think we can change to use timer trigger or other triggers.

>
> And secondly, we cannot keep the interface simple at first and then
> change it, because this is against Linux rule, which says that
> interface cannot break existing users.

Make sense.

>
>>> Now, I'm starting to wonder if we shouldn't have specialized trigger
>>> for breathing patterns, that would accept brightness level change per
>>> time period. Pattern trigger needs more flexibility and inferring if the
>>> hardware can handle given series of pattern intervals would entail
>>> unnecessary code complexity.
>>>
>>> Such breathing trigger would require triplets comprised of
>>> start brightness, end brightness and a duration of the brightness
>>> transition.
>>
>> But this is the only place we can set the hardware patterns according
>> to our previous discussion. Thanks.
>
> Thinking more about it, introducing another trigger for something being
> also a pattern is a bad idea.

Yes.

> Perhaps, as an alternative, we could allow for providing mathematical
> formula to define the edge of brightness change.
>
> I wonder what Pavel thinks.

-- 
Baolin Wang
Best Regards
