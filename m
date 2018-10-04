Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F3C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6BD21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLpGOg7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6BD21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeJDQKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:10:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37774 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDQKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:10:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id az3-v6so4873446plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bmhM7/u2L/Z64GZwk50hxpk7YMbmNX1GUQUryl21ihY=;
        b=KLpGOg7nV/XYLqTFOSMop+iIiv2Jy3h3hJWN5407rcMPcN4bROtt6XRew7CwL9yRJA
         HbZJZ0jJx7Nlzz7X175NYhrW5Jjx1oyF9dF299givCRYjx8kaxFlENUD1CN55zcoXGHi
         2WPQK1YANmadWHPlRQq4IyRUocVbBXy74NLEoZnRENpmdN7W2LOYbb6bTuQ+eXObijmz
         l3tUEos85LoOajxEJCGTr4kLJ8D7yRkAD+QkNMrOFBvySCx0UWMtH+pGzFAbpWBdB9pG
         N0e/QNmJb7e4gr68oGuhwEE+61HtfR8gPkAqCn8ZF2eXSW2bcyj49ZxfTfY7gdN6P+3A
         2mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bmhM7/u2L/Z64GZwk50hxpk7YMbmNX1GUQUryl21ihY=;
        b=UR2syjXOzwBQ1maBcVGMKhyLyBLdXeTHslTpluNGK8VoRoFOnaZ21CkjLak5++lVNU
         rHkoUUmLfg3d+ctG/BMI5hcv+pLsDvhfl+mcr8E2A5YlO/4LDMpQB8ec/SL8h9dkefZ2
         Q5lHHJu9QOXrMzOEJ1dKg/NA0+PRuZzLZUdhxkQdMie6aJKBokm/HwMjX7khztMAOHa5
         EpPHIvSFyG0Pd6YRMle2OhR3s/VMbOpXyWFs5c1SNff3xTBRP8AFK0bzfDNKJ2Z1K7AD
         TYRRFCbv8wfjBQDsGkxTLSGPMDnW3VO1z8xx6ca2gHtMHaa5wRrJReTAwW76jRBzy/4I
         MgWg==
X-Gm-Message-State: ABuFfogCBztKRQ7EMt8xKEVBWjCpby7BXapkPnmjz4LeoRtevUG1XhV2
        +mn1/kOARwr+tzbJfuj2Em/NCq8b
X-Google-Smtp-Source: ACcGV63tKoAZIJQMdA/HfZ1hCVXQqVdtT/WdY0gLh2IYvzgiSlgd5C0rBPkHqvVH+1sTGNXLW1SSlg==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15-v6mr5659147plm.246.1538644678122;
        Thu, 04 Oct 2018 02:17:58 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id 68-v6sm9598694pfg.136.2018.10.04.02.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:17:57 -0700 (PDT)
Subject: Re: [BUG] sound: pci: trident: a possible data race
To:     Takashi Iwai <tiwai@suse.de>
Cc:     keescook@chromium.org, perex@perex.cz, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <864e211c-8be5-6a34-902a-a71f176111db@gmail.com>
 <s5hk1mzowkd.wl-tiwai@suse.de>
 <e334c065-5768-7710-bd70-059f7316157b@gmail.com>
 <s5hmurunv13.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <3be565e2-d2fe-689b-52a9-f6bed0e215f1@gmail.com>
Date:   Thu, 4 Oct 2018 17:17:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <s5hmurunv13.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/4 13:24, Takashi Iwai wrote:
> On Thu, 04 Oct 2018 05:08:45 +0200,
> Jia-Ju Bai wrote:
>> Thanks for the reply :)
>>
>>
>> On 2018/10/3 23:54, Takashi Iwai wrote:
>>> On Wed, 03 Oct 2018 14:50:25 +0200,
>>> Jia-Ju Bai wrote:
>>>> CPU0:
>>>> snd_trident_hw_free
>>>>       snd_trident_free_voice
>>>>               line 3870: spin_lock_irqsave()
>>>>               line 3881: voice->substream = NULL; [WRITE]
>>>> CPU1:
>>>> snd_trident_interrupt
>>>>       line 3798: snd_pcm_period_elapsed(voice->substream);  [READ]
>>>>
>>>> As for voice->substream, the WRITE operation in CPU0 is performed
>>>> with holding a spinlock, but the READ operation in CPU1 is performed
>>>> without holding this spinlock, so there may exist a data race.
>>> Thanks for the report.
>>>
>>> The actual crash must be very unlikely, almost 0%, though.
>>> snd_trident_hw_free() is called always after the PCM stream gets
>>> stopped via trigger callback, i.e. at the moment, there is no
>>> corresponding interrupt is generated for that voice entry.
>> How about the case that playback and capture are performed concurrently?
>> Namely, snd_trident_hw_free() is called for playback, and the
>> interrupt is generated for capture.
> They are different substreams, hence it won't pick up the substream
> object.

Actually, I performed a runtime testing, and found that 
snd_trident_hw_free() and snd_trident_interrupt() are executed concurrently.
However, I did not check the substream object, so I guess this report 
was produced in the case that I mentioned.
Anyway, my report should be false, sorry...


Best wishes,
Jia-Ju Bai
