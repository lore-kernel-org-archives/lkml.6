Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1AC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8E2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg9zNG17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE8E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeKTVvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:51:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46938 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeKTVvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:51:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so1270500ljh.13;
        Tue, 20 Nov 2018 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=No49aoCtFtb6imx3tqQwjNdiFvf75oT47N7CeK3zTb4=;
        b=Qg9zNG17M2FJ5TvejbD4vEaygjYGsnJoqBV+gCj/CqYYOSsst9dhnKfPNlYeBxuCG4
         YqDMmW4oWzSfo8nvusVwixywAmK1CpWb9UY+ABqorRAWvNprlgQcpzQn6z3GKdRGlB6L
         +/EjXXMOvAK0bqU0c8q/xSDflMiyV8735SQAUgGVflEa+Kjdi8z6wmCNoLLuYgYVoY8w
         eFLsripk0uQTosWsFlw7VLxBLqw8ieRpU3waGFyG/soTEb7fkHGr3iKp7kkzfEJevZhi
         msOeynr5+mhQexRTqfY6uFMkWCHW8AaFmvGcJReSlG1Zw+VI7gHHxJpReFAeFsG1dJEL
         l8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=No49aoCtFtb6imx3tqQwjNdiFvf75oT47N7CeK3zTb4=;
        b=civVbzFfS9D/g+DAWaoTCJAHNM7C3nA5jXf19nGnNEC3RzZnS/6WrNM6hMHlPeTdl0
         uXDN1I4Dsx1nUnGQhNWzENnBpdgKERZkMqm4tMxbegdeMYqHFMgZTN7ZA0iy627ImRaK
         VHoxwVDNBeZI3loDt1lN/RD+fW+zvSYDKKXEXm+UJorGgXsFGLb2BHxF1+NYXYpjVugK
         t6t08tMUs3AypWJGpfG+eEMkZILgJ/XaadA4voj4m5Xhm+2FlSc+LbISd+0iSZlXCqQp
         /AG7oKdpU/gPh0osOUBG7lx3lpa6yNgyE0XjMNV1+86ooo72pzRcjY2qlrmb1+x8yGDf
         HrBg==
X-Gm-Message-State: AA+aEWb6LkSQ1Y0T7A59jNUXwRit1K5VCXn6c74Mp6uf35agGcJamtLX
        Jm8/hAJt3rKpJchZ7Jgkm+SEvxo9
X-Google-Smtp-Source: AFSGD/V4p4JJTqIuufpLMf5CeGyraNFsdw3jPNgyu/gmjhrL3EvvqZ44Y4tKMmXiXQ+4jyCMN45qHQ==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr844527ljo.10.1542712945083;
        Tue, 20 Nov 2018 03:22:25 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id r26-v6sm6027682lji.25.2018.11.20.03.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 03:22:24 -0800 (PST)
Subject: Re: [PATCH v1 2/4] ARM: tegra: Fix DRAM refresh-interval clobbering
 on resume from LP1 on Tegra30
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-3-digetx@gmail.com>
 <4f61bf5f-0aa8-df6e-109b-194b08f3374e@nvidia.com>
 <cee4398b-edb8-4c9d-7830-6f52fffd6e1c@gmail.com>
 <2096a744-d80b-42ad-a285-7bc1c1d3a5ed@gmail.com>
 <d0894c7c-be5a-5541-fab5-90bfd7d25dab@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <081d67f4-8dd2-4685-1c68-0f11c2b12bb2@gmail.com>
Date:   Tue, 20 Nov 2018 14:22:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d0894c7c-be5a-5541-fab5-90bfd7d25dab@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 13:26, Jon Hunter wrote:
> 
> On 19/11/2018 22:32, Dmitry Osipenko wrote:
>> On 20.11.2018 1:09, Dmitry Osipenko wrote:
>>> On 20.11.2018 0:34, Jon Hunter wrote:
>>>>
>>>> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>>>>> The DRAM refresh-interval is getting erroneously set to "1" on exiting
>>>>> from memory self-refreshing mode. The clobbered interval causes the
>>>>> "refresh request overflow timeout" error raised by the External Memory
>>>>> Controller on exiting from LP1 on Tegra30.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-tegra/sleep-tegra30.S | 2 --
>>>>>  1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>>>>> index 801fe58978ae..99ac9c6dcf7c 100644
>>>>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>>>>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>>>>> @@ -29,7 +29,6 @@
>>>>>  #define EMC_CFG				0xc
>>>>>  #define EMC_ADR_CFG			0x10
>>>>>  #define EMC_TIMING_CONTROL		0x28
>>>>> -#define EMC_REFRESH			0x70
>>>>>  #define EMC_NOP				0xdc
>>>>>  #define EMC_SELF_REF			0xe0
>>>>>  #define EMC_MRW				0xe8
>>>>> @@ -459,7 +458,6 @@ emc_wait_auto_cal_onetime:
>>>>>  	cmp	r10, #TEGRA30
>>>>>  	streq	r1, [r0, #EMC_NOP]
>>>>>  	streq	r1, [r0, #EMC_NOP]
>>>>> -	streq	r1, [r0, #EMC_REFRESH]
>>>>>  
>>>>>  	emc_device_mask r1, r0
>>>>
>>>> This does look incorrect and it appears Tegra20 has the same bug.
>>>
>>> Indeed.. somehow this doesn't cause any problems on T20. Maybe this affects only specific timing configurations and it's just a luck that "refresh overflow" isn't getting raised.
>>
>> Ah, T20 exit_selfrefresh_loop doesn't latch registers.. that's probably why it stayed unnoticed.
> 
> Good to know.

Thank you for pointing at it, will be fixed in v2.
