Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE71C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5642089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cjbFuLXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5642089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933605AbeGJOqq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:46:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42974 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeGJOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:46:44 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so20598764ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P0yDWUFNA3y1hSKszzuPM/T+VLDO/Q494wy7YhdvLj4=;
        b=cjbFuLXaI9s5TFxD8evMgMRlaG4lz8EAEY/7tGcgNPZhDHauaaunUtOHY+ebKiItQA
         equr95d1NlqGawy7sIaDRXbJU+aVV+LfGHbqvwLceHfyNfPHDT6y/gu7MD0urLaUpf+r
         gyVbO3KP2XV6ZwIlkTfbNWVc4w6HxL0aCeI81s6jkpp1lzWyriBnbZibi8prQNJrSG0O
         iub9QHkOGB967FBmHJRUTd4cB9IOn61HYcL9XMxd3Fei5GMWWs1PbAzZsk2hl3nwTnb2
         w4fkULWkh1Q54c4G09NBnrdXsTMCCjJP+BROGWOg3GyeskEGwDy/W7AgopgRVq5prqtJ
         jV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P0yDWUFNA3y1hSKszzuPM/T+VLDO/Q494wy7YhdvLj4=;
        b=lS26EDvjIerSZbYWTEdsxA5Sr/HXdNQfTP6vrRhungBv7QML3wP1veIY0hLmBgLXGH
         dj0BaKN+t2xszaBD5SOlrH8bE2ZXdpFAO25l4rPTTFT0+wR2uC8zzCQ35YRaMrgdmBkh
         MH8te3Z3/CYdiZ4s1Gfn5Lq53hRnku7BwAs5L0Mwqe805g/cIwm1xUwhooZlggqC8NUa
         FlkGTD1XWGzq5aXoy2LrTBRUKux2CtzTEL0Gl4wHpOir/ZEce7BXfp2FYhtfMFMfP//X
         PvETmN0SEWytXXjpdgBedl8AhtXPusOks5IqOjN52SvLl3bX1Ias59CHV1UfPjb8mSai
         FJig==
X-Gm-Message-State: APt69E3HXZ2LzMrN5N/4i9BMqONnnbFmCle8cRvMjWx5/yGMVALfyicF
        7X4S5WSu+n2kW/Xk0ryp80YC5A==
X-Google-Smtp-Source: AAOMgpf0rS8eyGIq47atd0//SWvHFX/Z5oXWdwQ286/u0cmEAbSN2Us5SdtNzEO31B/p8y0vKDrQOw==
X-Received: by 2002:a6b:19c4:: with SMTP id 187-v6mr21131678ioz.244.1531234003942;
        Tue, 10 Jul 2018 07:46:43 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l126-v6sm9961923itb.5.2018.07.10.07.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:46:42 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "loberman@redhat.com" <loberman@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
 <1530899118.31977.1.camel@redhat.com>
 <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
 <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
 <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
Date:   Tue, 10 Jul 2018 08:46:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/18 6:05 PM, Bart Van Assche wrote:
> On Mon, 2018-07-09 at 10:34 -0600, Jens Axboe wrote:
>> On 7/9/18 1:54 AM, Matias Bjørling wrote:
>>> For fio, you can use the zone support here:
>>>
>>>    https://github.com/bvanassche/fio
>>>
>>> It is in the process of being upstreamed.
>>
>> In the spirit of making some progress on this, I just don't like how
>> it's done. For example, it should not be necessary to adjust what
>> comes out of the block generator, instead the block generator should
>> be told to do what we need on zbc. This is a key concept. The workload
>> should be defined as such that it works for zoned devices.
> 
> Hello Jens,
> 
> How would you like to see block generation work? I don't see an
> alternative for random I/O other starting from the output of a random
> generator and translating that output into something that is
> appropriate for a zoned block device. Random reads must happen below
> the zone pointer if fio is configured to read below the zone pointer.
> Random writes must happen at the write pointer. The only way I see to
> implement such an I/O pattern is to start from the output of a random
> generator and to adjust the output of that random generator. However,
> I don't have a strong opinion whether adjusting the output of a random
> generator should happen by the caller of get_next_buflen() or inside
> get_next_buflen(). Or is your concern perhaps that the current
> approach interferes with fio job options like bs_unaligned?

The main issue I have with that approach is that the core of fio is
generating the IO patterns, and then you are just changing them as you
see fit. This means that the workload definition and the resulting IO
operations are no longer matched up, since they now also depend on what
you are running on. If I take one workload and run it on a zoned drive,
and then run it on a non-zoned drive, I can't compare the results at
all. This is a showstopper.

There should be no adjusting of the output, rather it should be possible
to write zoned friendly job definitions. It should be possible to run
the same job on a non-zoned drive, and vice versa, and the resulting IO
patterns must be the same.

Fio already has some notion of zones. Maybe that could be extended to
hard zones, and some control of open zones, and patterns within those
zones?

-- 
Jens Axboe

