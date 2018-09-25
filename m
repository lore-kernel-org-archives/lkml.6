Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4663C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A57A204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHzZgwWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A57A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeIZCJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:09:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40211 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeIZCJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:09:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id r83-v6so4948215ljr.7;
        Tue, 25 Sep 2018 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YWy/mYGRrt/Oy5tX2KRbDGpIj5Cy8eineKuOaUNYHz4=;
        b=tHzZgwWi5e0TS7Hlu3SPXSKiFm2NsfbV+1bmSii9zTLNG4x21xhKLHt1DT2vEkVm1K
         HNxOHFSyXpuaui10op110RARfqlGaH/bNzS+8yA/HftroFucwhVx1mkmxhQBJoRZP5R7
         q5wgN0MHP1uA5v1Y7rCpQb2Z78fPtB0vl8zpRu2GVGW1kqd0owGJ8UiSSK/cCHy9AL8E
         ChW1lu+f1lY1zED9ddZQFvUNN53myZG4xyCdCkuWc6UbAXvIXDuoCvKya+S3piDjWa+q
         EteyoXVuPcjn1Bm13cN06nGO6xla58aao6ylYX/+oEfwDnDNcvezOWlTj2mMBsLodlS2
         BFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YWy/mYGRrt/Oy5tX2KRbDGpIj5Cy8eineKuOaUNYHz4=;
        b=i9xUDLvdvB7ultQgXiKN/oL+UHTLHSDKYhtcFi/TMwA0baa45f84bAMFyfyGcJs6mc
         b3GzISbiMjBiOIElQjJ/Wl1UXQFpYiG8gD+bgS/MOMYZQonkzZ/hdLztyZ44vfTMN9zK
         oglDpNSO5YFD1FvubBeVnFbgAWg6tPDHCP5Wb61jg4H9fplvnZMSnRu8sjCn2cmzjJzy
         wjg/s3LsQTQdn4wHwEvtqe0lCLu8oFeL/4LSJ+gqwdcgFfpApuxErmpQC67zA4TrifD9
         rnQ17lLgOJcQJhpz8prKtEfSjKBBa+vap320JjC273iO+RJ6CmSExxz2oUA2tf9mpTvv
         2LEA==
X-Gm-Message-State: ABuFfoh2laAYv+F0FENU7ZAmY0bcNB4Rein2cCAz54Hbc/Gs3GpjjD8V
        jyVPXp3dvsJehXcKGiPnqqIc0kd8
X-Google-Smtp-Source: ACcGV62L1L1+/EUH8bgxUUE3KWimT43X1DX3KDKar17YJk6PslW1ffsNLBYk5TQJlgNHLXuAzy4/tw==
X-Received: by 2002:a2e:6c07:: with SMTP id h7-v6mr279530ljc.81.1537905612850;
        Tue, 25 Sep 2018 13:00:12 -0700 (PDT)
Received: from [192.168.1.18] (dku194.neoplus.adsl.tpnet.pl. [83.24.24.194])
        by smtp.gmail.com with ESMTPSA id o10-v6sm560915ljg.39.2018.09.25.13.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:00:12 -0700 (PDT)
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
 <324778a9-a32c-ae6e-337a-39845f214bfc@gmail.com> <20180921211758.GC18062@amd>
 <ccac8e5f-e122-9f7d-aa43-fa89c79cb1fe@gmail.com> <20180921221813.GA20355@amd>
 <20180922194451.GA27826@amd> <470f4037-b682-73f8-8063-b4d7a70e04bc@gmail.com>
 <CAMz4kuL431PPMnOAXev-4ZzYwiGwMtz90RQT0JTP2bSdZ7fHUg@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9188b107-92da-11aa-9903-848e3f347f8c@gmail.com>
Date:   Tue, 25 Sep 2018 22:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuL431PPMnOAXev-4ZzYwiGwMtz90RQT0JTP2bSdZ7fHUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 09/25/2018 01:15 PM, Baolin Wang wrote:
> On 23 September 2018 at 20:25, Jacek Anaszewski
> <jacek.anaszewski@gmail.com> wrote:
>> On 09/22/2018 09:44 PM, Pavel Machek wrote:
>>> On Sat 2018-09-22 00:18:13, Pavel Machek wrote:
>>>> On Sat 2018-09-22 00:11:29, Jacek Anaszewski wrote:
>>>>> On 09/21/2018 11:17 PM, Pavel Machek wrote:
>>>>>> On Fri 2018-09-21 22:59:40, Jacek Anaszewski wrote:
>>>>>>> Hi Baolin,
>>>>>>>
>>>>>>> On 09/21/2018 05:31 AM, Baolin Wang wrote:
>>>>>>>> Hi Jacek and Pavel,
>>>>>>>>
>>>>>>>> On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>>>>>>> This patch adds one new led trigger that LED device can configure
>>>>>>>>> the software or hardware pattern and trigger it.
>>>>>>>>>
>>>>>>>>> Consumers can write 'pattern' file to enable the software pattern
>>>>>>>>> which alters the brightness for the specified duration with one
>>>>>>>>> software timer.
>>>>>>>>>
>>>>>>>>> Moreover consumers can write 'hw_pattern' file to enable the hardware
>>>>>>>>> pattern for some LED controllers which can autonomously control
>>>>>>>>> brightness over time, according to some preprogrammed hardware
>>>>>>>>> patterns.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
>>>>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>>>>
>>>>>>>> Do you have any comments for the v12 patch set? Thanks.
>>>>>>>
>>>>>>> We will probably have to remove hw_pattern from ledtrig-pattern
>>>>>>> since we are unable to come up with generic interface for it.
>>>>>>> Unless thread [0] will end up with some brilliant ideas. So far
>>>>>>> we're waiting for Pavel's reply.
>>>>>>>
>>>>>>> [0] https://lkml.org/lkml/2018/9/13/1216
>>>>>>
>>>>>> To paint a picture:
>>>>>>
>>>>>> brightness
>>>>>>
>>>>>>    rise hold          lower       hold down
>>>>>>   ^    XXXXXXXXXXXXXXX
>>>>>>   |   X               XX
>>>>>>   |  X                  XX
>>>>>>   | X                     XXXXXXXXXXXXXXXXXXXXXXXXXX
>>>>>>   +-------------------------------------------------------> time
>>>>>>
>>>>>> This is what Baolin's hardware can do, right?
>>>>>>
>>>>>> This is also what pattern trigger can do, right?
>>>>>>
>>>>>> So all we need to do is match the two interfaces, so that hw_pattern
>>>>>> returns -EINVAL on patterns hardware can not actually do.
>>>>>>
>>>>>> I believe I described code to do that in [0] above.
>>>>>
>>>>> You said that we should get the same effect by writing the
>>>>> same series of tuples to either pattern or hw_pattern file.
>>>>>
>>>>> Below command consists of four tuples (marked with brackets
>>>>> to highlight), and it will activate breathing mode in Baolin's
>>>>> hw_pattern:
>>>>>
>>>>> "[0 rise_duration] [brightness high_duration] [brightness fall_duration]
>>>>> [0   low_duration]"
>>>>>
>>>>> Now, I can't see how these four tuples could force the software
>>>>> fallback to produce breathing effect you depicted.
>>>>
>>>> I really should get some sleep now. But my intention was that software
>>>> fallback produces just that with those four tuples. (If it does not,
>>>> we can fix the software fallback to do just that).
>>>
>>> And you are right, v12 1/2 seems to do the wrong thing.
>>>
>>> My "brilliant idea" is to something closer to the original version I
>>> posted here. I'm attaching it for reference.
>>>
>>> I'm also attaching the original documentation. It was clearly designed
>>> to do smooth transitions, too. (But pattern is written in slightly
>>> different way there, AFAICT).
>>>
>>> Clearly, having same semantics for pattern and hw_pattern is possible.
>>
>> Thank you for the attachment. The documentation part makes everything
>> clear. Comparing the patch from the attachment and the Baolin's patch
>> there is one vital part missing, from the original
>> pattern_trig_update():
>>
>> if (data->next->brightness == data->curr->brightness) {
>> [...]
>> } else {
>>         /* Gradual dimming */
>>         led_set_brightness(data->led_cdev, compute_brightness(data));
>>         data->delta_t += UPDATE_INTERVAL;
>>         mod_timer(&data->timer, jiffies
>>                 + msecs_to_jiffies(UPDATE_INTERVAL));
>> }
> 
> I have some confusions about this, if data->next->brightness !=
> data->curr->brightness, we should always do gradual dimming? But
> suppose below pattan values:
> echo "0 100 20 100 40 100 80 100 100 100" > patter
ledtrig-pattern.txt attached by Pavel explains this:

"To make the LED go instantly from one brightness value to another,
use zero-time lengths."

Actually you have it also:
"Duration of 0 means brightness should immediately change to new value"

According to this, to get instant changes your pattern should look
like this:

echo "0 100 0 0 20 100 20 0 40 100 40 0 80 100 80 0 100 100" > pattern

> I do not want to do gradual dimming, just change the brightness with duration.
> 
>> And the compute_brightness() implementation:
>>
>> static int compute_brightness(struct pattern_trig_data *data)
>> {
>>         if (data->delta_t == 0)
>>                 return data->curr->brightness;
>>
>>         if (data->curr->delta_t == 0)
>>                 return data->next->brightness;
>>
>>         return data->curr->brightness + data->delta_t
>>                 * (data->next->brightness - data->curr->brightness)
>>                 / data->curr->delta_t;
>> }
>>
>> With the above the linear gradual dimming is indeed feasible.
>> And for non-linear dimming like breathing mode the hw_pattern will do.
> 
> I am still not sure when we need the linear gradual dimming? When
> failed to set hardware pattern?

No. Linear gradual dimming needs to be applied only if set via pattern
file. In this case we shouldn't attempt to call pattern_set at all,
since we know that we are asked for enabling software engine.

Similarly, in the hw_pattern handler we should call only pattern_set,
and return error code, without falling back to the software engine
in case of error.

>> There is also vital discrepancy between the documentation and the
>> proposed ledtrig-pattern implementation. The doc says:
>>
>> "Duration of 0 means brightness should immediately change to new value"
> 
> OK. Will add in next version.

You already have it added.

>> This syntax seems to be not supported in the Baolin's patch.
>>
>> With all the above covered we will be almost there.
>>
>> Now, only the issues raised by Bjorn need a clarification:
>>
>> On 09/08/2018 07:02 AM, Bjorn Andersson wrote:
>> [...]
>>> The controls for my hardware is:
>>> * a list of brightness values
>>> * the rate of the pattern
>>
>> The two can be described using [brightness delta_t] tuples.
>>
>>> * a flag to indicate that the pattern should be played from start
>>>   to end, end to start or start to end to start
>>
>> As above, but the tuples would have to be suitably arranged.
>>
>> We won't need any specific flag to indicate how the pattern
>> should be played, but instead explicitly give the tuples in the
>> required order. For the start-end-start case the sequence of tuples
>> will need to be tripled, but the middle part should be put in the
>> reverse order.
>>
>>> * a boolean indicating if the pattern should be played once or repeated
>>>   indefinitely.
>>
>> We will have "repeat" file for that.
>>
>> Baolin, would you mind adding the support for gradual dimming to your
>> ledtrig-timer.c implementation?
> 
> Yes, I will do. Thanks.
> 

-- 
Best regards,
Jacek Anaszewski
