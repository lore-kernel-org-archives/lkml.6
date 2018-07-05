Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B352EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACA52405C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMga1AwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACA52405C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeGEJp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:45:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55880 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753249AbeGEJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:45:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so10024529wmv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HrOnZ6dUQ44LCF0hC3YxX2LKAVDgIrj2wX9NSksDJvI=;
        b=iMga1AwVrcK9O0wPkqdUV6TgIWEXD2F+MVX1tmdCOOYf6oFr8XopyoW0I3ftg3vExR
         Lwn/ws0n4BabgmFfeD8SEDHtNVg9FEAtmgc5ozVRza/sIHeLPz3nPUjVzsiGYrUtMJb9
         6RGFHTDUoWqB06tHO1v4cxHlC78myWZNdWsnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrOnZ6dUQ44LCF0hC3YxX2LKAVDgIrj2wX9NSksDJvI=;
        b=fPxPFrZpT/vZfEP2tvgj2Z9uL22XJk26BYwmraOUn8lyNjqgOZgzxaNkBEGHB3LqWZ
         RDpMvTtbK2RT0K32gcM4r+oUMdHcK2c2sI9Yf5kpIElJMAQ2SkjmJ/mQpgOa8tZBWS6a
         9RtepDw6+TBII67aUzMJrwqvcddr3HshWDtN7LbG0rOq83NwJbVxez4w93OBoIMB/mIO
         t/bXt/1i4+UuRe3kpCZDV8GJfhvSilr9t2AJLgNwOvHsSAuTj7LjS58F8ifcM+HE+5mX
         1nyueEppnyzgjdaHPYdCU75tFePygLvYpGtOqmz3rw9LmUB5XhaKtwbGTy34dS6Qh8y5
         elQQ==
X-Gm-Message-State: APt69E3FtrT4GguoHClzNZ5cCw1dvzf1FKOuXGRvdUQkmEjfxk0cJngn
        vO4sciOfaMVbMxqJjUaaQxu1XA==
X-Google-Smtp-Source: AAOMgpf9AIf1QQDc/uLZStFDAEHqWu4lNDV2Q5P1QI+dZPODah9UXaGOvBaMmoVfdnnVEqY0G0RTUg==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr4273008wrg.211.1530783923489;
        Thu, 05 Jul 2018 02:45:23 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id e3-v6sm10649685wmd.2.2018.07.05.02.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 02:45:22 -0700 (PDT)
Subject: Re: [PATCH v2 12/29] venus: add common capability parser
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-13-stanimir.varbanov@linaro.org>
 <CAAFQd5Bj73zyi0vsaSJ2sam2TGm7agshXg+n+sa2c7HoqLRGUw@mail.gmail.com>
 <13c7aec1-2bb9-f449-6b7d-7ec93be4ec71@linaro.org>
 <CAAFQd5B8UVk3n7m+MV3t68vrDhtd9Hi_CnuYS-4QFaVdByOTyA@mail.gmail.com>
 <CAAFQd5CddQBo2JRaab0uWdtkmetd=zDzVt=rM+vJZQ7DM-kLGA@mail.gmail.com>
 <30d141b6-dffa-bf6a-dae8-79595c966a23@linaro.org>
 <CAAFQd5Aet4Hb62Jps6QPu+0fLsB=ruxH1qFwE93c_MWygvmXBw@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <abc191de-de3c-4e5b-9907-5094e82ff50a@linaro.org>
Date:   Thu, 5 Jul 2018 12:45:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Aet4Hb62Jps6QPu+0fLsB=ruxH1qFwE93c_MWygvmXBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 07/02/2018 01:05 PM, Tomasz Figa wrote:
> On Mon, Jul 2, 2018 at 6:59 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Tomasz,
>>
>> On 07/02/2018 12:23 PM, Tomasz Figa wrote:
>>> On Thu, May 31, 2018 at 4:06 PM Tomasz Figa <tfiga@chromium.org> wrote:
>>>>
>>>> On Thu, May 31, 2018 at 1:21 AM Stanimir Varbanov
>>>> <stanimir.varbanov@linaro.org> wrote:
>>>>>
>>>>> Hi Tomasz,
>>>>>
>>>>> On 05/24/2018 05:16 PM, Tomasz Figa wrote:
>>>>>> Hi Stanimir,
>>>>>>
>>>>>> On Tue, May 15, 2018 at 5:08 PM Stanimir Varbanov <
>>> [snip]
>>>>>>
>>>>>>> +                       break;
>>>>>>> +               }
>>>>>>> +
>>>>>>> +               word++;
>>>>>>> +               words_count--;
>>>>>>
>>>>>> If data is at |word + 1|, shouldn’t we increment |word| by |1 + |data
>>>>>> size||?
>>>>>
>>>>> yes, that could be possible but the firmware packets are with variable
>>>>> data length and don't want to make the code so complex.
>>>>>
>>>>> The idea is to search for HFI_PROPERTY_PARAM* key numbers. Yes it is not
>>>>> optimal but this enumeration is happen only once during driver probe.
>>>>>
>>>>
>>>> Hmm, do we have a guarantee that we will never find a value that
>>>> matches HFI_PROPERTY_PARAM*, but would be actually just some data
>>>> inside the payload?
>>>
>>> Ping?
>>
>> OK, you are right there is guarantee that we not mixing keywords and
> 
> Did the auto-correction engine in my head got this correctly as "no
> guarantee"? :)
> 
>> data. I can make parse_* functions to return how words they consumed and
>> increment 'word' pointer with consumed words.
> 
> Yes, that or maybe just returning the pointer to the first word after
> consumed data. Most of the looping functions already seem to have this
> value, so it would have to be just returned. (vs having to subtract
> from the start pointer)

I made the relevant changes to satisfy you request but the results were
fine for Venus v3 and wrong on v1. So I'd propose to postpone this
change and fix it with follow up patches because I don't want miss the
next merge window. So far the supported venus firmware versions are fine
with the current parser implementation.

What you think?

-- 
regards,
Stan
