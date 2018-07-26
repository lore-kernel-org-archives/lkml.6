Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9008420846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtG4ycaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9008420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeGZTGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:06:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45699 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbeGZTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:06:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so2406482qti.12;
        Thu, 26 Jul 2018 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vjxnrIyPvp35oPyr4nzJenOgZNT2jL+1BYO3vza0Z10=;
        b=CtG4ycaSM+1PUGVBIPgk2CaVy6fZMkbOHkTTYeVVmm0D9l9hHuG7g5Q875Uc/tsbd0
         r9pG98lfgZZ4phkGp6Vh7KTyhm4uEqvei5mbSBd9/RI+7wQpwBUQ9DcRud/0DyFS9f8K
         hVG9dWRbWLA0PUt0B/HekGPFTxT+ZEuPGsnu6eZv4L5aXWI7ewoGog/966C2JV8LSVED
         923+NJiMn2szfMgVoXMrsi55pqHpDcw8UC1u8dik6CHf7Q2p9zkFsMHXM8n3qcmhX81b
         J5rXCey3gDZhAy/6OErH2FdAR8WgcTX3XeLNrNHlDrn0hjFoUih7jUj9PtniHhk8xZqV
         vUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjxnrIyPvp35oPyr4nzJenOgZNT2jL+1BYO3vza0Z10=;
        b=cubTZzQ7R0SLdtkQUi5Qrwd/JPGpwKxX2B2DdJ95jdvORgHcs0j1euf1uWbA8kzk9t
         K9TrOmtOxq4gYUatSf00QSUe8E44PoISrY1X0aK27XOIbfjC9OiOQKxPMjeFuSNc0CD2
         PlXFdVHuhv/gRBK03N+VaBLC+sDyb6LU8I+qR5lRm2VTXE/GOPNdUUk8eAlEJNmgz62v
         l6x5YXxGuiE8lbTvRH/xfff1JuHdXZB5nzRaq1bu+2KGC5PzBFzAwaIhz9JPK5zSOJBE
         SycgBzQhpU9FLzurqEBWwcs4Jgc6hpdDhAT9JYQwu0BSYUl2vOAZElAZ1z30wzcjcF1q
         O1Gg==
X-Gm-Message-State: AOUpUlG4bIPLYs5062Dh/t5r6kbzbC4ucNEiPopk+16ddlppmkFpddkm
        8wtML/UoQsRX06EjW+Op0lSD6CPkBRU=
X-Google-Smtp-Source: AAOMgpd9bLX9euZMJt3uMxJ42ef4bnNJjO59OGjtq7AcrM5tZbvza9oeOvBju7kpD21W3qm/oarRVQ==
X-Received: by 2002:ac8:31b7:: with SMTP id h52-v6mr2912817qte.380.1532627338137;
        Thu, 26 Jul 2018 10:48:58 -0700 (PDT)
Received: from [192.168.44.96] (42.sub-174-226-17.myvzw.com. [174.226.17.42])
        by smtp.gmail.com with ESMTPSA id 49-v6sm1319444qtu.0.2018.07.26.10.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 10:48:57 -0700 (PDT)
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
To:     Stefan Agner <stefan@agner.ch>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra-owner@vger.kernel.org
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
 <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
 <1553c44e99b96a813af129d1c4169222@agner.ch>
 <553f9ed6-8f7c-775b-d731-fd9732f74b07@gmail.com>
 <7edc8c666dbbc0743221c86286ff583a@agner.ch>
 <12ae1da9-cd09-b15d-9a81-461ca9cc06d7@gmail.com>
 <24fffc2c52b58301c37d95fe5d1ad355@agner.ch>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <3a970d5d-4f18-0167-ab22-2032e8bf743d@gmail.com>
Date:   Thu, 26 Jul 2018 13:48:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <24fffc2c52b58301c37d95fe5d1ad355@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/26/2018 01:36 PM, Stefan Agner wrote:
> On 26.07.2018 18:39, Peter Geis wrote:
>>>>>> I finally got around to testing this on the Ouya (Tegra 3).
>>>>>
>>>>> Thanks for testing!
>>>>>
>>>>>>
>>>>>> I found that the "Got command interrupt 0x00010000 even though no
>>>>>> command operation was in progress." error occurred when the interface
>>>>>> is unstable.
>>>>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
>>>>>> Mhz, probably due to the fact that they are using the internal cmd and
>>>>>> clock pull-up resistors, against the TRM's instruction.
>>>>>> At 39Mhz, I saw the error this patch corrects.
>>>>>> With the patch, the error went away, but the interface is still
>>>>>> unstable under load.
>>>>>
>>>>> How does this instability manifest exactly?
>>>>>
>>>>
>>>> At the very edge of stability, you see write errors under heavy load.
>>>> As clock rate increases, the write errors occur more frequently.
>>>> At a certain point, you start getting read errors.
>>>> Following that you get constant io errors during card probing.
>>>> Eventually the emmc will fail to initialize, with errors 87 or 110.
>>>
>>> What mode are you running at actually? E.g. what is the ios file saying?
>>> cat /sys/kernel/debug/mmcX/ios
>>
>> This is the best functionality I've been able to get prior to the patches:
>> root@ouya:~# cat /sys/kernel/debug/mmc0/ios
>> clock:          30000000 Hz
>> actual clock:   29142858 Hz
>> vdd:            21 (3.3 ~ 3.4 V)
>> bus mode:       2 (push-pull)
>> chip select:    0 (don't care)
>> power mode:     2 (on)
>> bus width:      3 (8 bits)
>> timing spec:    9 (mmc HS200)
>> signal voltage: 1 (1.80 V)
>> driver type:    0 (driver type B)
>>
> 
> Yeah HS200 is definilty not supported by the controller and really
> should not be used.
> 
>> Now I am trying DDR, but even with the patches I'm not able to remain
>> stable above 17Mhz (34Mhz clock).
>>
>> I've also tried just straight mmc-hs mode, but even that makes no difference.
>>
> 
> So you tried timing spec 1 (mmc HS)?
> 
> How did you exactly enable mmc-hs mode?

cap-mmc-highspeed;

> 
> I suggest to *not set* vqmmc and apply patch 1. It will report that
> signaling voltage is 3.3V, but that did not really matter in our case.
> This was our baseline and always worked stable on mainline. I also would
> use that mode when tweaking pinmux etc...

Will do, thanks.

> 
>>>
>>>>
>>>> I've been tweaking the pull up/down values to try and improve the
>>>> stability, but without access to anything but the TRM it's a lot of
>>>> trial and error.
>>>>
>>>
>>> Hm, maybe Marcel's recent fixes in our device tree are helpful?
>>> https://lkml.org/lkml/2018/7/22/165
>>>
>>> Also make sure to have a complete pinmux such that alternative pins for
>>> sdmmc4 are *not* muxed as sdmmc4.
>>
>> That was my first issue, which was preventing sdmmc4 from working at all.
>> Just double checked all of the spare function pins, they are all
>> assigned elsewhere.
>>
> 
> Ok.
> 
>>>
>>>>>>
>>>>>> Lowering down to 32Mhz, without the patch there are no errors.
>>>>>
>>>>> So the patch does not make it less stable right?
>>>>>
>>>>
>>>> No, it did not affect stability.
>>>> Although I'd conduct some performance testing to check for degradation.
>>>> Of course I'm nowhere near the limits of the controller, so it is
>>>> doubtful I'd see a hit.
>>>
>>> Ok, and this is with the complete patchset applied correct?
>>>
>>> Btw, what device tree are you using? Ouya is not upstream as far as I
>>> can tell?
>>
>> Indeed, I have the full patchset.
>>
>> Ouya is an old android game console that I've been working on getting
>> mainline working on.
> 
> I know, I have one sitting here too. I only tried to tinker a bit at the
> very beginning...

It runs Xubuntu very well now with mainline.
I've got most everything roughly supported with the exception of audio.

> 
>> I've written most of the device tree, with contributions from Matt Merhar.
>> It's almost bit for bit a cardhu dev board, but with everything not
>> necessary to function removed.
>> They cut a lot of corners with the board design.
>> Last stable kernel was 3.2, but it ran fine at 52mhz, mind you it
>> reported it was running mode 5.
> 
> That is what we saw too. With Apalis/Colibri T30 L4T downstream kernel
> (which is 3.1 with quite some patches) 52MHz DDR worked fine,
> surprisingly even with ACMD23. However, speed is slightly slower than
> mainline 52MHz without ACMD23...

I noticed the same thing, speed with the original kernel on the MMC was 
worse at 52Mhz than it was at 34Mhz in HS-200 mode on mainline.
I'd be happy with it where it is, but the fact that it worked at 52Mhz 
before makes me believe something isn't quite there yet.
I selected HS-200 mode just to force 1.8v mode.

> 
> --
> Stefan
> 
>>
>> To get this speed, I have the pins all driven down at 4, and up at 24.
>> Default is 2 down and 18 up from driver init.
>> The pin pull ups are exactly as the original kernel, all pins pulled
>> up except reset, which is pulled down.
>>
>>>
>>> --
>>> Stefan
>>>
>>>>
>>>>> --
>>>>> Stefan
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
