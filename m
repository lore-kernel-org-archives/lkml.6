Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B33BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B132082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGoT6uBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B132082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeH3LkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:40:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41663 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeH3LkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:40:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so13786477oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hTyoiYA3NcOxlUcfr6MPOkvgiEW9uAldq12+ZJhYWfo=;
        b=kGoT6uBuoOlfVBcewdv/3tXCoqsozt0rtPJCdnLu4fwLvPqHSkm5yL05TV74Bqfp8I
         2BT6n2n7SU9kIjTMiIGa2jP0m+DSpMNekuN81rLGHlDHxtSLM/5XCCy1mPuPhsmlHOZf
         /8h3nh2FluTKsh5C0i2aS1S2cMqYodXJ/iSos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hTyoiYA3NcOxlUcfr6MPOkvgiEW9uAldq12+ZJhYWfo=;
        b=cdPTNjZtovIj9aaCR+NbcT7E8pe6J9ugR8rB6TCWf3JE4v8OtmykhmzM6Vx25XKO9L
         BOuKj7WeMhMIlvYZpoOzi5czGYN55YcYISBsFyNHu8/+eKt6PXHlmfDhB7N66KcnfEE8
         KmgZKJKtC+pGnjVsjUmUi4rS4IsmfVAgA1ed88F/gb30Hki1+99GYn6vAxfINA0AM8fQ
         mfagcbyANOs203KDU7Mr/7L1u4DfX98jrjrR8LVUMXgz5RRvY+I4UVkiR0fxrO7z846t
         QPXnQRbmE8zk4wyMCXZ2wBI02/FrBM2uS/wvajs3x5JNzGfe6w788/DjMNf1nXVHw8M/
         KAWA==
X-Gm-Message-State: APzg51BiesnKxoZoDRJUtP2e07TwHaT/2H7tNF9mmZGuQ+WXSf7o4SBM
        RHzr9VNAsOUVEW68+tQpjjbht3b6gfYEhhZ6LVmQdQ==
X-Google-Smtp-Source: ANB0VdbMLYha1oiEVRGkSXy7zNIvai7xhh2zTQFa5GaG6Icq5w+tpBREDzWsi+pD6Ha8VMJw5IDU8jtkTDi7vljBP58=
X-Received: by 2002:aca:50cf:: with SMTP id e198-v6mr1450028oib.332.1535614755610;
 Thu, 30 Aug 2018 00:39:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:29:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 00:39:14 -0700 (PDT)
In-Reply-To: <CAMz4kuKT=zcH_Kjc5FnvX98vw-5aNQMxMTs4aeqqiM6F4QGEuA@mail.gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com> <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
 <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com> <CAMz4ku+a5QT5CaonW3R6dfKzcpJgyeGLbD5tH-0K1QMLDdQpqQ@mail.gmail.com>
 <6d0881db-e02f-6bf4-2516-448bc4772cb8@gmail.com> <CAMz4kuKT=zcH_Kjc5FnvX98vw-5aNQMxMTs4aeqqiM6F4QGEuA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 30 Aug 2018 15:39:14 +0800
Message-ID: <CAMz4kuL1Wia-dWpqDNwzyLDtTag-Rpd0eXe2KLRPjK4ZGhhVRw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 30 August 2018 at 11:26, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Jacek,
>
> On 30 August 2018 at 03:15, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>> Hi Baolin,
>>
>> On 08/29/2018 11:48 AM, Baolin Wang wrote:
>>> Hi Jacek,
>>>
>>> On 29 August 2018 at 04:25, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>>> On 08/25/2018 09:51 AM, Baolin Wang wrote:
>>>>> On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>>>>> On 08/24/2018 10:12 PM, Pavel Machek wrote:
>>>>>>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>>>>>>>> Hi Pavel,
>>>>>>>>
>>>>>>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>>>>>>>> Hi!
>>>>>>>>>
>>>>>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>>>>>> lead to the situation where LED class devices that support hardware
>>>>>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>>>>>> resort to using software pattern engine which will accept far greater
>>>>>>>>>> amount of pattern combinations.
>>>>>>>>>>
>>>>>>>>>> In this case we need to discuss on what basis the decision will be
>>>>>>>>>> made on whether hardware or software engine will be used.
>>>>>>>>>>
>>>>>>>>>> Possible options coming to mind:
>>>>>>>>>> - an interface will be provided to determine max difference between
>>>>>>>>>>   the settings supported by the hardware and the settings requested by
>>>>>>>>>>   the user, that will result in aligning user's setting to the hardware
>>>>>>>>>>   capabilities
>>>>>>>>>> - the above alignment rate will be predefined instead
>>>>>>>>>> - hardware engine will be used only if user requests supported settings
>>>>>>>>>>   on the whole span of the requested pattern
>>>>>>>>>> - in each of the above cases it would be worth to think of the
>>>>>>>>>>   interface to show the scope of the settings supported by hardware
>>>>>>>>>
>>>>>>>>> I'd recommend keeping it simple. We use hardware engine if driver
>>>>>>>>> author thinks pattern is "close enough".
>>>>>>>>
>>>>>>>> The thing is that in the ledtrig-pattern v5 implementation there
>>>>>>>> is no option of using software fallback if pattern_set op
>>>>>>>> is initialized:
>>>>>>>>
>>>>>>>> +    if (led_cdev->pattern_set) {
>>>>>>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>>>>> +                                         data->npatterns, data->repeat);
>>>>>>>> +    }
>>>>>>>
>>>>>>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
>>>>>>>
>>>>>>> It pattern_set() returns special error code, it should just continue
>>>>>>> and use software pattern fallback.
>>>>>>
>>>>>> And now we can get back to the issue I was concerned about in the
>>>>>> email you replied to, i.e. what series of [brightness delta_t] tuples
>>>>>> should be written to the pattern file to enable hardware breathing
>>>>>> engine.
>>>>>
>>>>> OK. So now we've made a consensus to use the software pattern fallback
>>>>> if failed to set hardware pattern. How about introduce one interface
>>>>> to convert hardware patterns to software patterns if necessary?
>>>>>
>>>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
>>>>> b/drivers/leds/trigger/ledtrig-pattern.c
>>>>> index 63b94a2..d46a641 100644
>>>>> --- a/drivers/leds/trigger/ledtrig-pattern.c
>>>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>>>> @@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
>>>>> pattern_trig_data *data,
>>>>>                 return 0;
>>>>>
>>>>>         if (led_cdev->pattern_set) {
>>>>> -               return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>> -                                            data->npatterns, data->repeat);
>>>>> +               ret = led_cdev->pattern_set(led_cdev, data->patterns,
>>>>> +                                           data->npatterns, data->repeat);
>>>>> +               if (!ret)
>>>>> +                       return 0;
>>>>> +
>>>>> +               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
>>>>> +
>>>>> +               if (led_cdev->pattern_convert)
>>>>> +                       led_cdev->pattern_convert(led_cdev,
>>>>
>>>> I can't see how it could help to assess if hw pattern
>>>> engine can launch given pattern, and with what accuracy.
>>>>
>>>> Instead, I propose to add a means for defining whether the pattern
>>>> to be set is intended for hardware pattern engine or for software
>>>> fallback. It could be either separate sysfs file e.g. hw_pattern,
>>>> or a modifier to the pattern written to the pattern file, e,g,
>>>>
>>>> echo "hw 100 2 200 3 100 2" > pattern
>>>>
>>>> hw format expected by given driver would have to be described
>>>> in the per-driver ABI documentation. All patterns without
>>>> "hw" prefix would enable software pattern engine.
>>>
>>> OK. So I did some optimization based on v5 according to suggestion, if
>>> you think this is okay for you, then I will send out the formal v6
>>> patch set.
>>>
>>> 1. echo "hw 100 2 200 3 100 2" > pattern
>>> Only for hardware pattern, if failed,  we will return error number.
>>
>> After thinking more about it, I'd opt for a separate file
>> dedicated to hardware pattern, e.g. hw_pattern, which would
>> be created only if the LED class driver implemented pattern_set op.
>>
>>> 2. echo "100 2 200 3 100 2" > pattern
>>> Will try to set hardware pattern firstly, if failed, will use software
>>> pattern instead.
>>>
>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
>>> b/drivers/leds/trigger/ledtrig-pattern.c
>>> index 63b94a2..f08e797 100644
>>> --- a/drivers/leds/trigger/ledtrig-pattern.c
>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>> @@ -26,6 +26,7 @@ struct pattern_trig_data {
>>>       u32 repeat;
>>>       u32 last_repeat;
>>>       bool is_indefinite;
>>> +     bool is_hw_pattern;
>>>       struct timer_list timer;
>>>  };
>>>
>>> @@ -62,12 +63,21 @@ static void pattern_trig_timer_function(struct
>>> timer_list *t)
>>>  static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>>                                     struct led_classdev *led_cdev)
>>>  {
>>> +     int ret;
>>> +
>>>       if (!data->npatterns)
>>>               return 0;
>>>
>>>       if (led_cdev->pattern_set) {
>>> -             return led_cdev->pattern_set(led_cdev, data->patterns,
>>> +             ret = led_cdev->pattern_set(led_cdev, data->patterns,
>>>                                            data->npatterns, data->repeat);
>>> +             if (!ret)
>>> +                     return 0;
>>> +
>>> +             dev_warn(led_cdev->dev, "Failed to set hardware patterns\n");
>>> +
>>> +             if (data->is_hw_pattern)
>>> +                     return ret;
>>
>> With separate pattern files we could get rid of this ambiguity and
>> attempt calling pattern_set only if requested via hw_pattern file.
>> No software fallback should be employed in case of failure then.
>>
>> Similarly in case of requests originating from pattern file -
>> the software engine should be set up.
>
> Please correct me if I understood you incorrectly.
>
> So we should create the hw_pattern file if the LED class driver
> implemented pattern_set op, then no need use software fallback if it
> failed to set hardware pattern.
>
> If the LED class driver did not implement pattern_set op, we just show
> up pattern file for users, and we always use software pattern now.
>
> But AFAICT the V5 has implemented the logics, but did not change the
> pattern file name according to if LED class driver implemented
> pattern_set op. So now we just change the pattern file to hw_pattern
> file if pattern_set op is set?
>

Sorry for misunderstanding your points, now I realized we will create
2 files for software pattern and hardware pattern if the pattern_set
op was implemented. I submitted v6 patch set according to your
suggestion. Please help to review. Thanks.

-- 
Baolin Wang
Best Regards
