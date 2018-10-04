Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16010C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4D020856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeZN8Mwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4D020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJDJ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:59:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeJDJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:59:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so4412261plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 20:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DMyNySL9PTaAmEXBRoKFiUXSogAAhALXve9d9Kq1Jts=;
        b=UeZN8MwlbEm9ULZJsD/d5xSBJwiCj290d4t9pLECDgwxa8h+IUdpHtG9Drq6B/9Wh/
         lg/IN4qAqjzqDRaxT89ysyE43p7Ul2yrj7wYwrCPpitRIqjhOWqRVO2Efo465wqiMd+U
         AN8ZJZUCORDT9ivTH2YWGRbm7j+yWgnWWLgcTQlI/CKPo/liVhX9NQmujpuvcAU/6P9d
         Yrnl6OFPzfo3OEQPPDcoY7luzExBTqDkAiEzHUtqMhGLX+fg4jCQF9GQyliyxoXdskZw
         i1ju3K93epyR5UjwFwwPqbMEhloQAf8tYtZCljbvd5JnN8N5ctHv88IB0afjCxSpGzie
         72mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DMyNySL9PTaAmEXBRoKFiUXSogAAhALXve9d9Kq1Jts=;
        b=G3YovDuRJd13Mf825uiGYkfqYdolG57cPSRlm7KK0VIJmAaQbbpfiN2oWcUxEIaAJg
         a9Y806fdey0kUxeNDH/lQnUhECAkkvmvpm2LzocXF/6DEobL2aIeoYd8UyRxjvb1gXbJ
         CFu/tFLTQvksUeX2q3fqmzjrf9txmyMZEwwbJuSPrI8a1XxD3krZgcF3hGbS99E5sxkY
         Ea/5TrY5hZ1atbJdk74tx/1YCmsqKWveWQ921NBSxG/eociJ4qLCBw7FTAygA9+fse11
         +/tf4XplNGn8ymSdNRh5/ACDmoWrE2Eyt3fe7fikNp65bVibutWxGL6yrzYoSCbfDf4e
         Hucw==
X-Gm-Message-State: ABuFfoi90muZsU/fO5yfMQ1zucpegjvnYzrA7MrjCerCeDcs23LXitaH
        lUxhWEJBLpzq5ixEm3JxWlmffnVR
X-Google-Smtp-Source: ACcGV61PKRyIFEvcHsnoFBz307vefhEl29x5w9HhAoZFv6rJ0lYalm45PoWT1D0kYG+RlYB9Zt7qAQ==
X-Received: by 2002:a17:902:5a4d:: with SMTP id f13-v6mr4499775plm.114.1538622530332;
        Wed, 03 Oct 2018 20:08:50 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id f68-v6sm5518219pfe.143.2018.10.03.20.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 20:08:49 -0700 (PDT)
Subject: Re: [BUG] sound: pci: trident: a possible data race
To:     Takashi Iwai <tiwai@suse.de>
Cc:     keescook@chromium.org, perex@perex.cz, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <864e211c-8be5-6a34-902a-a71f176111db@gmail.com>
 <s5hk1mzowkd.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e334c065-5768-7710-bd70-059f7316157b@gmail.com>
Date:   Thu, 4 Oct 2018 11:08:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <s5hk1mzowkd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply :)


On 2018/10/3 23:54, Takashi Iwai wrote:
> On Wed, 03 Oct 2018 14:50:25 +0200,
> Jia-Ju Bai wrote:
>> CPU0:
>> snd_trident_hw_free
>>      snd_trident_free_voice
>>              line 3870: spin_lock_irqsave()
>>              line 3881: voice->substream = NULL; [WRITE]
>> CPU1:
>> snd_trident_interrupt
>>      line 3798: snd_pcm_period_elapsed(voice->substream);  [READ]
>>
>> As for voice->substream, the WRITE operation in CPU0 is performed
>> with holding a spinlock, but the READ operation in CPU1 is performed
>> without holding this spinlock, so there may exist a data race.
> Thanks for the report.
>
> The actual crash must be very unlikely, almost 0%, though.
> snd_trident_hw_free() is called always after the PCM stream gets
> stopped via trigger callback, i.e. at the moment, there is no
> corresponding interrupt is generated for that voice entry.

How about the case that playback and capture are performed concurrently?
Namely, snd_trident_hw_free() is called for playback, and the interrupt 
is generated for capture.

> And the hardware is very old, I bet only a handful people still using
> in the whole world :)

I have this hardware, so I am the one of these handful people ;)


Best wishes,
Jia-Ju Bai
