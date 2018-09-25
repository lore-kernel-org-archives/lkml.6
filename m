Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DE62098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7Lt2Tdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DE62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeIYRWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:22:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34330 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeIYRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:22:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so21327818ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rQLvRKCeY3g9WSuzfwqlCRdqegXkBTiAjWxOS9woDG0=;
        b=f7Lt2TdzhGP8R7Y34mNXF1D2p4mrGOS0yl+7iAkWWhG8KDtH6AloB+qRnw80BwmOvQ
         0kkf5t9cMqoPQnVbxRO4w/U2zRuGWNoZDQFlRWkPflhMzMaMBsO7b65kpItCPJkKH+iy
         0L8RVePeZf20/Olu0Tf3wvTU6W6FZ8pTLxKfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rQLvRKCeY3g9WSuzfwqlCRdqegXkBTiAjWxOS9woDG0=;
        b=MiFL3lAj1sYWZL0iTShU8xay/dhdZ962WVyhSY2Ne7NeI0dcrc3UmRUQNjxmWIpHKB
         7xuhbJngUJEci+t3hhTbZxKrrjD7iqY+kBLqhchc58momVZTTD0sR9jgKRACqZNMqwKx
         gfpw2Teyd3XCBTnI5FfnQASeILH1Kqv237OTvS3ojRQARv4syoDgkSfCoasiG9hLQLuW
         m/G9zi53k6XvGFvYBvuhGx4DPoqQGYlMhLwXHWHu4/MtMiP37qJodZ+i6vucgmdi6BF8
         FFZLCXCRaPNYwqeEOdPXwuzAMh4ugLXGI51OruvG7yjKqMK2Py00NN6w8SH0wX60UjQM
         Ydgg==
X-Gm-Message-State: ABuFfogG2ajwT16DLABA4QB+mUqCfdQY8laqDHTQ2T/pq1kUDmteW+qa
        bUboPsDhKKaxQRSjDk8vcczs1tFzOBUtclMq0itBAA==
X-Google-Smtp-Source: ACcGV61KJX9a9zMJ7t7tdp4IpenfyUqXc9mJ5K7cn6aSZzWF14u7oEAogutCUbJxkkhODHPgpT/hYzMtFeHUnEfRh/s=
X-Received: by 2002:a2e:544f:: with SMTP id y15-v6mr453429ljd.51.1537874131954;
 Tue, 25 Sep 2018 04:15:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 04:15:31
 -0700 (PDT)
In-Reply-To: <470f4037-b682-73f8-8063-b4d7a70e04bc@gmail.com>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
 <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com> <20180921211758.GC18062@amd>
 <ccac8e5f-e122-9f7d-aa43-fa89c79cb1fe@gmail.com> <20180921221813.GA20355@amd>
 <20180922194451.GA27826@amd> <470f4037-b682-73f8-8063-b4d7a70e04bc@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 25 Sep 2018 19:15:31 +0800
Message-ID: <CAMz4kuL431PPMnOAXev-4ZzYwiGwMtz90RQT0JTP2bSdZ7fHUg@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 September 2018 at 20:25, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> On 09/22/2018 09:44 PM, Pavel Machek wrote:
>> On Sat 2018-09-22 00:18:13, Pavel Machek wrote:
>>> On Sat 2018-09-22 00:11:29, Jacek Anaszewski wrote:
>>>> On 09/21/2018 11:17 PM, Pavel Machek wrote:
>>>>> On Fri 2018-09-21 22:59:40, Jacek Anaszewski wrote:
>>>>>> Hi Baolin,
>>>>>>
>>>>>> On 09/21/2018 05:31 AM, Baolin Wang wrote:
>>>>>>> Hi Jacek and Pavel,
>>>>>>>
>>>>>>> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>>>>> This patch adds one new led trigger that LED device can configure
>>>>>>>> the software or hardware pattern and trigger it.
>>>>>>>>
>>>>>>>> Consumers can write 'pattern' file to enable the software pattern
>>>>>>>> which alters the brightness for the specified duration with one
>>>>>>>> software timer.
>>>>>>>>
>>>>>>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>>>>>>>> pattern for some LED controllers which can autonomously control
>>>>>>>> brightness over time, according to some preprogrammed hardware
>>>>>>>> patterns.
>>>>>>>>
>>>>>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>>
>>>>>>> Do you have any comments for the v12 patch set? Thanks.
>>>>>>
>>>>>> We will probably have to remove hw_pattern from ledtrig-pattern
>>>>>> since we are unable to come up with generic interface for it.
>>>>>> Unless thread [0] will end up with some brilliant ideas. So far
>>>>>> we're waiting for Pavel's reply.
>>>>>>
>>>>>> [0] https://lkml.org/lkml/2018/9/13/1216
>>>>>
>>>>> To paint a picture:
>>>>>
>>>>> brightness
>>>>>
>>>>>    rise hold          lower       hold down
>>>>>   ^    XXXXXXXXXXXXXXX
>>>>>   |   X               XX
>>>>>   |  X                  XX
>>>>>   | X                     XXXXXXXXXXXXXXXXXXXXXXXXXX
>>>>>   +-------------------------------------------------------> time
>>>>>
>>>>> This is what Baolin's hardware can do, right?
>>>>>
>>>>> This is also what pattern trigger can do, right?
>>>>>
>>>>> So all we need to do is match the two interfaces, so that hw_pattern
>>>>> returns -EINVAL on patterns hardware can not actually do.
>>>>>
>>>>> I believe I described code to do that in [0] above.
>>>>
>>>> You said that we should get the same effect by writing the
>>>> same series of tuples to either pattern or hw_pattern file.
>>>>
>>>> Below command consists of four tuples (marked with brackets
>>>> to highlight), and it will activate breathing mode in Baolin's
>>>> hw_pattern:
>>>>
>>>> "[0 rise_duration] [brightness high_duration] [brightness fall_duration]
>>>> [0   low_duration]"
>>>>
>>>> Now, I can't see how these four tuples could force the software
>>>> fallback to produce breathing effect you depicted.
>>>
>>> I really should get some sleep now. But my intention was that software
>>> fallback produces just that with those four tuples. (If it does not,
>>> we can fix the software fallback to do just that).
>>
>> And you are right, v12 1/2 seems to do the wrong thing.
>>
>> My "brilliant idea" is to something closer to the original version I
>> posted here. I'm attaching it for reference.
>>
>> I'm also attaching the original documentation. It was clearly designed
>> to do smooth transitions, too. (But pattern is written in slightly
>> different way there, AFAICT).
>>
>> Clearly, having same semantics for pattern and hw_pattern is possible.
>
> Thank you for the attachment. The documentation part makes everything
> clear. Comparing the patch from the attachment and the Baolin's patch
> there is one vital part missing, from the original
> pattern_trig_update():
>
> if (data->next->brightness == data->curr->brightness) {
> [...]
> } else {
>         /* Gradual dimming */
>         led_set_brightness(data->led_cdev, compute_brightness(data));
>         data->delta_t += UPDATE_INTERVAL;
>         mod_timer(&data->timer, jiffies
>                 + msecs_to_jiffies(UPDATE_INTERVAL));
> }

I have some confusions about this, if data->next->brightness !=
data->curr->brightness, we should always do gradual dimming? But
suppose below pattan values:
echo "0 100 20 100 40 100 80 100 100 100" > pattern

I do not want to do gradual dimming, just change the brightness with duration.

> And the compute_brightness() implementation:
>
> static int compute_brightness(struct pattern_trig_data *data)
> {
>         if (data->delta_t == 0)
>                 return data->curr->brightness;
>
>         if (data->curr->delta_t == 0)
>                 return data->next->brightness;
>
>         return data->curr->brightness + data->delta_t
>                 * (data->next->brightness - data->curr->brightness)
>                 / data->curr->delta_t;
> }
>
> With the above the linear gradual dimming is indeed feasible.
> And for non-linear dimming like breathing mode the hw_pattern will do.

I am still not sure when we need the linear gradual dimming? When
failed to set hardware pattern?

>
> There is also vital discrepancy between the documentation and the
> proposed ledtrig-pattern implementation. The doc says:
>
> "Duration of 0 means brightness should immediately change to new value"

OK. Will add in next version.

>
> This syntax seems to be not supported in the Baolin's patch.
>
> With all the above covered we will be almost there.
>
> Now, only the issues raised by Bjorn need a clarification:
>
> On 09/08/2018 07:02 AM, Bjorn Andersson wrote:
> [...]
>> The controls for my hardware is:
>> * a list of brightness values
>> * the rate of the pattern
>
> The two can be described using [brightness delta_t] tuples.
>
>> * a flag to indicate that the pattern should be played from start
>>   to end, end to start or start to end to start
>
> As above, but the tuples would have to be suitably arranged.
>
> We won't need any specific flag to indicate how the pattern
> should be played, but instead explicitly give the tuples in the
> required order. For the start-end-start case the sequence of tuples
> will need to be tripled, but the middle part should be put in the
> reverse order.
>
>> * a boolean indicating if the pattern should be played once or repeated
>>   indefinitely.
>
> We will have "repeat" file for that.
>
> Baolin, would you mind adding the support for gradual dimming to your
> ledtrig-timer.c implementation?

Yes, I will do. Thanks.

-- 
Baolin Wang
Best Regards
