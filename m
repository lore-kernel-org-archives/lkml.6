Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372B8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A0D254DA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ0vvZw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A0D254DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934091AbeGBLAz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:00:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45618 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932092AbeGBLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:00:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id u7-v6so15077696wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dV8eoZD6dWlXqtY72bE97JsOy5IYJNdX18WFyHMfNR4=;
        b=DZ0vvZw5peXDYk3JsZ64S01Z5bP43YERa3n7eZr+Saf1jmusTw3KqnDKFk6GtXgfv0
         yNMZjvvREeTdij9qQuX2d8xwgWiDGT7A8hLls7AtersrolLTL79KG8+QoHal9WvMpXW7
         84AyYWQVP07REELGWP4tBoOeQr2GauC7YUiNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dV8eoZD6dWlXqtY72bE97JsOy5IYJNdX18WFyHMfNR4=;
        b=gqvsO2kkiNZgyprXmjL4OuDupiMrN9P7yL9vSBmA5XZ6u3HMY8XRrZaEo9p9z2IOre
         FBJDm8Xr5c4RRNZU6+VhpyFTFJZEj+91Np3TOQJOVzKUo4riV7XhqnHs1Kh88xhj8Atw
         ukDscIBO0HObhGfp0TAIBLLQc08sGGdYFB2KLzN4QatT6/QMI4BQm2/vQu2JgqjblX9M
         MGxl/ksawigjjBuJs0Y3eq0mfquyGpRbu7bW98gFOycws/Es7If8SkJ6YlEG9doChArp
         ZJ0ilrGG7zTJ4sJ4t09MwDBlMj0dv8tmD2LWvcpyw2Ye9Vq4rcc54ebnFu3+nMQgr28n
         xdvA==
X-Gm-Message-State: APt69E166HkX5aqdG5PtU2XfZ71xP08WvSJnl7z4mNXkJNC0O0gbEB+n
        DS+KuZbeTksR9+KhH1O1Q2G86g==
X-Google-Smtp-Source: AAOMgpe79jW2/Mx6Nc0BzUQ2l27tu/KbXRuBZCOb35CDJ78KFzRB81SMPKOLtl6clxkKIFsFUD9jgQ==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr18530064wre.268.1530529252307;
        Mon, 02 Jul 2018 04:00:52 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id e126-v6sm13972966wmd.43.2018.07.02.04.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:00:51 -0700 (PDT)
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
Message-ID: <f715773f-ea48-cf47-a615-f7af147ec60f@linaro.org>
Date:   Mon, 2 Jul 2018 14:00:49 +0300
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

yes, your engine works better than my :)

> 
>> data. I can make parse_* functions to return how words they consumed and
>> increment 'word' pointer with consumed words.
> 
> Yes, that or maybe just returning the pointer to the first word after
> consumed data. Most of the looping functions already seem to have this
> value, so it would have to be just returned. (vs having to subtract
> from the start pointer)

One possible issue could be with not parsed params, there I have to
increment with one because the read data size is unknown.

-- 
regards,
Stan
