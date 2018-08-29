Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2994C2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw7L1YkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2994C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeH2WyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:54:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40588 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeH2WyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:54:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so5782889wrw.7;
        Wed, 29 Aug 2018 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jrVnkk74ldmRMlSZTQnEn84eKYHk4HRLhSd4OxKqPq4=;
        b=Bw7L1YkLdLsc4HvHky5AvKbtKWUV6gnBMNBP8Cq7/pMZuEP4Pg5eISByhu9QOhisrV
         cqt511l0jMSWnT8UhuC0thljNL/HoUMc1pkL2rLCI8gnqNO+Vo/JSytdXcWgpToFhiXl
         wKR/vUPdepnLTKD5s7rOwIcZXbYnxdWZdWJolJwZi2F7aStEtpcHwM877lG5C5d3Un8x
         ZljWZpyTnO4b4nQvQWdGBQ/ol5/8wLWJuHZHxxy3gfZ4QbaE1sG+sglLcOTW0tUPpP2V
         lXLK56GIX9No3+1w6NrU4svZuANgq+kSHh8uMKBnjDKWkMZ3QNMN27x2RLk+4yFt/fS+
         uWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrVnkk74ldmRMlSZTQnEn84eKYHk4HRLhSd4OxKqPq4=;
        b=sJLtY3vgrRx0cS29+PE/MmSqD3ae+n5+JYIOsgwc1vfjAoJ+P/jYadKuHRXs9BUPIn
         iXE7YyifuocIPy8SI+XMZhDdv6TL0KAG9/ooAl4EY+xhCM6SQSZrl8i0y5laHdz/QeqC
         G8nEU/Vn+JJEAYU8yHYAXigQtKqTzOSNKbCgASGbQAMtg+L2In380ioXU8DGGaqZ1zxh
         vIvFOYuFusEDBsB4XPH/JwT9rSWOrnidYfP7lFLjJhfw3p45sEhqH+rpm7jMllCWVfwW
         tx/diWWnmnloiDhxfVHHGvatCZx65KXK3VdM+RAUdZTg2OZbUQEC9r3Zqj03rC3Z72ib
         mazg==
X-Gm-Message-State: APzg51Bs5LMAjQiw1Be97DH2jSWmk1iYN3w5JKzwCpwIyp0ipfBTCZst
        lchgIk/WuPwACp+TwkJVqFmG1kM+
X-Google-Smtp-Source: ANB0VdYJPI0q0FWpdq4o4jEVL0K8WIVdWTqN32WZUmcg+opwwTyd0tg7En+JvEfIBXmoOizyr+Xtbg==
X-Received: by 2002:adf:ae01:: with SMTP id x1-v6mr5162831wrc.45.1535568956415;
        Wed, 29 Aug 2018 11:55:56 -0700 (PDT)
Received: from [192.168.1.18] (bkz141.neoplus.adsl.tpnet.pl. [83.28.193.141])
        by smtp.gmail.com with ESMTPSA id p89-v6sm8635500wrc.97.2018.08.29.11.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:55:55 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baolin Wang <baolin.wang@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
 <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
 <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
 <20180828211326.GI2523@minitux>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ba3c46dd-cfa3-6df3-7f30-dc604ea1d511@gmail.com>
Date:   Wed, 29 Aug 2018 20:55:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828211326.GI2523@minitux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 11:13 PM, Bjorn Andersson wrote:
> On Tue 28 Aug 13:25 PDT 2018, Jacek Anaszewski wrote:
> 
>> On 08/25/2018 09:51 AM, Baolin Wang wrote:
>>> On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>>> On 08/24/2018 10:12 PM, Pavel Machek wrote:
>>>>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>>>>>> Hi Pavel,
>>>>>>
>>>>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>>>> lead to the situation where LED class devices that support hardware
>>>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>>>> resort to using software pattern engine which will accept far greater
>>>>>>>> amount of pattern combinations.
>>>>>>>>
>>>>>>>> In this case we need to discuss on what basis the decision will be
>>>>>>>> made on whether hardware or software engine will be used.
>>>>>>>>
>>>>>>>> Possible options coming to mind:
>>>>>>>> - an interface will be provided to determine max difference between
>>>>>>>>   the settings supported by the hardware and the settings requested by
>>>>>>>>   the user, that will result in aligning user's setting to the hardware
>>>>>>>>   capabilities
>>>>>>>> - the above alignment rate will be predefined instead
>>>>>>>> - hardware engine will be used only if user requests supported settings
>>>>>>>>   on the whole span of the requested pattern
>>>>>>>> - in each of the above cases it would be worth to think of the
>>>>>>>>   interface to show the scope of the settings supported by hardware
>>>>>>>
>>>>>>> I'd recommend keeping it simple. We use hardware engine if driver
>>>>>>> author thinks pattern is "close enough".
>>>>>>
>>>>>> The thing is that in the ledtrig-pattern v5 implementation there
>>>>>> is no option of using software fallback if pattern_set op
>>>>>> is initialized:
>>>>>>
>>>>>> +    if (led_cdev->pattern_set) {
>>>>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>>> +                                         data->npatterns, data->repeat);
>>>>>> +    }
>>>>>
>>>>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
>>>>>
>>>>> It pattern_set() returns special error code, it should just continue
>>>>> and use software pattern fallback.
>>>>
>>>> And now we can get back to the issue I was concerned about in the
>>>> email you replied to, i.e. what series of [brightness delta_t] tuples
>>>> should be written to the pattern file to enable hardware breathing
>>>> engine.
>>>
>>> OK. So now we've made a consensus to use the software pattern fallback
>>> if failed to set hardware pattern. How about introduce one interface
>>> to convert hardware patterns to software patterns if necessary?
>>>
>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
>>> b/drivers/leds/trigger/ledtrig-pattern.c
>>> index 63b94a2..d46a641 100644
>>> --- a/drivers/leds/trigger/ledtrig-pattern.c
>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>> @@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
>>> pattern_trig_data *data,
>>>                 return 0;
>>>
>>>         if (led_cdev->pattern_set) {
>>> -               return led_cdev->pattern_set(led_cdev, data->patterns,
>>> -                                            data->npatterns, data->repeat);
>>> +               ret = led_cdev->pattern_set(led_cdev, data->patterns,
>>> +                                           data->npatterns, data->repeat);
>>> +               if (!ret)
>>> +                       return 0;
>>> +
>>> +               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
>>> +
>>> +               if (led_cdev->pattern_convert)
>>> +                       led_cdev->pattern_convert(led_cdev,
>>
>> I can't see how it could help to assess if hw pattern
>> engine can launch given pattern, and with what accuracy.
>>
>> Instead, I propose to add a means for defining whether the pattern
>> to be set is intended for hardware pattern engine or for software
>> fallback. It could be either separate sysfs file e.g. hw_pattern,
>> or a modifier to the pattern written to the pattern file, e,g,
>>
>> echo "hw 100 2 200 3 100 2" > pattern
>>
>> hw format expected by given driver would have to be described
>> in the per-driver ABI documentation. All patterns without
>> "hw" prefix would enable software pattern engine.
>>
> 
> We started this discussion with the suggestion that rather than
> introducing a new Qualcomm specific sysfs interface for controlling the
> pattern engine we should have a common one, but if I understand your
> suggestion we should not have a common interface, just a common sysfs
> file name?

True, when it is related to hardware pattern. Software pattern would
have common both file and interface. Alternatively, we could have two
separate files for setting software and hardware pattern.

-- 
Best regards,
Jacek Anaszewski
