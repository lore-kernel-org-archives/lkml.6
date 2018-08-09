Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F4F21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6TPCn9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F4F21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbeHIPqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:46:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43580 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeHIPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:46:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so5120228wrv.10;
        Thu, 09 Aug 2018 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SGCM5BMv46D3ymrRXTbu/cN0CGwIjkXcYrLDVzWzfUo=;
        b=M6TPCn9O6W3EqXrOL4/Gbfc5XDjoeWcCYHeWaR5D0Y9+H3Rwk/90egUBmkC8eGXL3A
         e5PWeS3R0htK6jNJsdaqoLqVA4F3VrEb7nSBtkAfoTeyQFJ1bc5AR7fpOsjvDu13DEqw
         sOPmgXN4Z93DjIUTC0yrUn3+5+fXZLayzwzGBZOJStAs10muN+DUmbUpQBFk8h5ojUdw
         3Tpanaz0MRSjtnNG+3yjlEFAlhcXk5bIKE/roUzps7QcA4mxng0G5NvRayUxsp/JdwJL
         v25t7qAtk0RpYYrIrazMYSdo+JxA5EnMQsj6KYdc6Y0ydgHUUDhJ60i7ylfW57LeNK+F
         Q0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGCM5BMv46D3ymrRXTbu/cN0CGwIjkXcYrLDVzWzfUo=;
        b=T3AiRHzhZXKxlf81QLD2Pp0EBBdHqrH062O5C7w2RYbC/rzAvfGovjP8lXR+ERkNm6
         CyIXGj5U7qoKpYuo0QDGsXXhqIDcmAiaJCWtMHI+DQfcAHJDzSKlFJPqjKsAIZMHr6yi
         cbPU+4bomjXV6EqABbV9NH3JLD+w78HCSoixdCWa7Om+xEhAyZSqDDpZooohzy/T6s8z
         J6ltoBZn5WDdyFrqwpqrJ17m6HMSHRJj77ntIq+HL/W2sDjSeQb4zllNWnIZYUgG8h8W
         pQwAq1tc6ECwIe6H9/h1zhNfv1VhGN2CE9tbLkL4lIcf1cBtXrvq64np0ZKvWBEzTqMW
         axsg==
X-Gm-Message-State: AOUpUlHjfCEpjxRlNrLwYziEudwrFG3I69yCfc7JR7Vg//hVaklWsT4L
        UYeXQ2Ptgp1Mz2gCzyq20Nc=
X-Google-Smtp-Source: AA+uWPzjBK53WZ/hyfW7Ro1wAb1rRR/+hQQGn01aU8sNwtwjOSyBGYIy6oT27Wg84rt1Bw+Ua9OkKQ==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr1385962wrs.171.1533820915989;
        Thu, 09 Aug 2018 06:21:55 -0700 (PDT)
Received: from [192.168.1.18] (blc170.neoplus.adsl.tpnet.pl. [83.28.196.170])
        by smtp.gmail.com with ESMTPSA id l14-v6sm5444060wrw.65.2018.08.09.06.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 06:21:55 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
 <CAMz4kuL8ufCqbqgegozJt3P7JON0AzA9KrbvcvOB15McA5S=zA@mail.gmail.com>
 <5d594e9b-9889-adc2-cc59-f4f45eea7ddb@gmail.com>
 <CAMz4kuJBT2m8YpsAFufiGQFOYCgBbyf9Rrhce+396pRoW802aw@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <cc29be64-47a5-2bc1-f1be-64b4ad7e1a6d@gmail.com>
Date:   Thu, 9 Aug 2018 15:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJBT2m8YpsAFufiGQFOYCgBbyf9Rrhce+396pRoW802aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 08/09/2018 07:48 AM, Baolin Wang wrote:
[...]
>>>>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>>>> +                                   struct led_classdev *led_cdev)
>>>>> +{
>>>>> +     if (!data->npatterns)
>>>>> +             return 0;
>>>>> +
>>>>> +     if (led_cdev->pattern_set) {
>>>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>> +                                          data->npatterns, data->repeat);
>>>>
>>>> I think that it would be more flexible if software pattern fallback
>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>> lead to the situation where LED class devices that support hardware
>>>> blinking couldn't be applied the same set of patterns as LED class
>>>> devices that don't implement pattern_set. The latter will always have to
>>>> resort to using software pattern engine which will accept far greater
>>>> amount of pattern combinations.
>>>
>>> Hmmm, I am not sure this is useful for hardware pattern, since the LED
>>> hardware can be diverse which is hard to be compatible with software
>>> pattern.
>>>
>>> For example, for our SC27XX LED, it only supports 4 hardware patterns
>>> setting (low time, rising time, high time and falling time) to make it
>>> work at breathing mode. If user provides 3 or 5 patterns values, it
>>> will failed to issue pattern_set(). But at this time, we don't want to
>>> use software pattern instead since it will be not the breathing mode
>>> expected by user. I don't know if there are other special LED
>>> hardware.
>>
>> Good point. So this is the issue we should dwell on, since the
>> requested pattern effect should look similar on all devices.
>> Of course in case of software pattern it will be often impossible
>> to achieve the same fluency. Similarly as in case of rendering graphics
>> with and without acceleration.
>>
>> In case of your device, I'd say that we'd need more complex description
>> of breathing mode pattern. More complex than just four intervals.
>> It should reflect all the intervals the hardware engine needs to perform
>> to achieve the breathing effect. Can this information be inferred from
>> the docs?
> 
>>From our docs, it only provides registers to set the low time, rising
> time, high time and falling time (value unit is 0.125s and max value
> is 63 = 7.875s) to enable breathing mode. So each interval value can
> be 1 ~ 63. But that is still hard for software pattern to simulate the
> breathing mode performed by hardware pattern.

Software fallback is not expected to show similar performance to the
hardware engine on the whole span of the supported time range.

Having min rise time value at 125ms, and given that max_brightness
is 255, then we'd have 255 / 125 = 2.04 of brightness level rise per
1ms. So, the pattern for rising edge could look like (assuming we
stop at 254):

0 1 2 1 4 1 6 1 8 1 10 1 ... 254 1

Now, I'm starting to wonder if we shouldn't have specialized trigger
for breathing patterns, that would accept brightness level change per
time period. Pattern trigger needs more flexibility and inferring if the
hardware can handle given series of pattern intervals would entail
unnecessary code complexity.

Such breathing trigger would require triplets comprised of
start brightness, end brightness and a duration of the brightness
transition.

-- 
Best regards,
Jacek Anaszewski
