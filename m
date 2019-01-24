Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC1C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499812084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBAhl95M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXKBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:01:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40367 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:01:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so2287583wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RH3RkVhILn5NfP+PAd+EIlQSbYKWN633csPXe5V14RU=;
        b=ZBAhl95MlrKjRrEltow6sJ6KkWE0nUfn50slGsrgBaTqrGnFUISJOhlwBdI85aREt5
         VZhd0xbCG5r+G9RPFCdlu5nb55TNZHd+wXFwEpvf6ov6dUNvCcN/iGn6I2ccih8FPnjC
         Pj4PVYmM61UwbS7yrUYeR0uc+0WmxXEil1Tl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RH3RkVhILn5NfP+PAd+EIlQSbYKWN633csPXe5V14RU=;
        b=P7hAc+BRTLz1yokHpiaFesk+dgei1eBTzvWtr9L6pMRbUAJycesPjjIfjzpntoPXHv
         qqeTJMdeoi3109bRGCAXpBbokuhXZm2ALFRRmu3tE36bx4rg/Zv9Do40icUJm5s2xUk5
         kU6W0sGs9JT96VyJ+UtbxqkAxYCEY/0J8OnhkWWVnv2bADocZrmpCIRozpnL3PiUZGFe
         FAJbQNhGCYvAdZIHH64+CT4/hR/Z4atpYUlmrPvOduMr1RzPFiwN2zNvSfvoWqHmgoTE
         R1yUPmktBy4ZzkB8dpvd1OJ2ZiJBPsXF0Jncp+0bi+X17Ie2y0gJwY6PR3LqjUurQU3N
         HIdw==
X-Gm-Message-State: AJcUukfFDZaYKF0VsJ8jH8Iv8EOzaG52sUwJDER9YFzYU3g+Xt03vFud
        QWJeJd7Up5Q7f1Z1mNWVaY55pV8xRzs=
X-Google-Smtp-Source: ALg8bN6fHHuF5QFRw8bP1rMvIKba9tNNJMVaRD/NviB0bWIgblZrJOUg6SM2iKMSxnoq4gZAGrlwpA==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr1911537wmg.71.1548324075843;
        Thu, 24 Jan 2019 02:01:15 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id s3sm44582236wmj.23.2019.01.24.02.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 02:01:15 -0800 (PST)
Subject: Re: linux-next not picking up latest clockevents/next
To:     Chen-Yu Tsai <wens@csie.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20190110062207.18787-1-wens@csie.org>
 <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
 <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com>
 <c00394ec-4817-629d-2a92-e62a7f2d31ab@linaro.org>
 <CAGb2v64iSQ-Ga1kCmbwUY1EHS5hSc2dnRJ6-LVOjsqkyaaPXkQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <11f6d26d-34dc-5c0c-43f3-3184915f16cf@linaro.org>
Date:   Thu, 24 Jan 2019 11:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v64iSQ-Ga1kCmbwUY1EHS5hSc2dnRJ6-LVOjsqkyaaPXkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2019 10:59, Chen-Yu Tsai wrote:
> On Thu, Jan 24, 2019 at 5:39 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 24/01/2019 09:56, Chen-Yu Tsai wrote:
>>> On Thu, Jan 10, 2019 at 5:19 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 10/01/2019 07:22, Chen-Yu Tsai wrote:
>>>>> If the clock tree is not fully populated when the timer-sun5i init code
>>>>> is called, attempts to get the clock rate for the timer would fail and
>>>>> return 0.
>>>>>
>>>>> Make the init code for both clock events and clocksource check the
>>>>> returned clock rate and fail gracefully if the result is 0, instead of
>>>>> causing a divide by 0 exception later on.
>>>>>
>>>>> Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
>>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>>> ---
>>>>
>>>> Applied thanks.
>>>
>>> I'm not seeing this in linux-next, nor the patch
>>>
>>>     arm64: arch_timer: Workaround for Allwinner A64 timer instability
>>>
>>> Any idea where these ended up?
>>
>> Yeah, I have a rough idea. They are now in linux-next via the
>> clockevents/next branch.
> 
> Thanks, Daniel.
> 
> Stephen,
> 
> Looks like linux-next is not picking up the latest clockevents/next.
> 
> The merge log for linux-next-20190124 shows:
> 
>     Merging clockevents/clockevents/next (bd2bcaa565a2 Merge branch
> 'clockevents/4.21' of
> http://git.linaro.org/people/daniel.lezcano/linux into timers/core)
>     $ git merge clockevents/clockevents/next
> 
> The merged clockevents/next looks outdated compared to
> 
>     http://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=clockevents/next


I just updated the branch, so there will be a delay before it gets
reflected in linux-next.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

