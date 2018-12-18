Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA6C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6955F21872
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AwnNAia+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLRN3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:29:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39175 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbeLRN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:29:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so7839672pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yP3NcjGDOSMZzmxRni+JaeeLFFFjjWstoEdD5qCNdSM=;
        b=AwnNAia+55wtNyB3bs4kM9pJNE80Z+7Q0XVG6rR2ZlMozfVXBz/wpi3plOa5jpNf5m
         6w647nC0D2Xu23mJwlHgAFBAogeKM5BvbLDNgBlyVUHpMYNDb/z9P+PUmDXuPFPieQsh
         cKesVKlk8M6SzHvXMjHoge9tZ8kFaLz9y2bLhIXbk/XJzX46/WYcM7kMPoGA8M2tcX1/
         E5SBzjUg/53bI7PpxObgpy4vYAWWB6I7e96Bqb8tU4e1PhAasU2ahRrnu8JaWUzpMNzX
         7szR6VG2F1fkHoV+pa4beDgAC3NQ+EEJpBHizmYP+3zYz/NKcYQ2VFKt2b7mc8I6Txvo
         FMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yP3NcjGDOSMZzmxRni+JaeeLFFFjjWstoEdD5qCNdSM=;
        b=Dydnz/ypiigTLKJ/gGrG25HAbY7zyfszU5z2L2c8ykNc+LSpIVoBildFRVf2stPl2+
         iGRyjtwL6uH20st5mCfHbcwjmUXOW/5LAN+8m6vvNT1tMqQIVbxc0gzcdTdzRp3472oW
         4vuFammWjDwHY74OvwDuI5oozjgLfAyzKg2/8sE/cRZKJyzcHFOXU99ADW3Ty83tjwka
         2EVHZvvxMKk60CFYhP2V4NTlBybs5tHBwEeds9hFEbqCJSAl5e+C5WlXVoAuMe6qSm4y
         mnC3WZKbyEr22L+Yd5aouDGhSLXBp0TzSIqegtLzKPcMDG0GpKNE/bpvZsI2/I8rQVFZ
         2K7g==
X-Gm-Message-State: AA+aEWZ2kJdvJHr+KCgS0Srt5bc8lEbntDJiW+V5gQhYy4LgqpEZOUIC
        8Nm3J0dmYUAnYFZY1WbxQO1tRQ==
X-Google-Smtp-Source: AFSGD/WNv2MDRxtyJ1hP7iR9pR7Nsx9u44c2tMOGIW3hfOSNz5M357efjwsiUcbOh3Eyp1x8XMM/WA==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr16751826plb.52.1545139757578;
        Tue, 18 Dec 2018 05:29:17 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p7sm22213134pfa.22.2018.12.18.05.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 05:29:16 -0800 (PST)
Subject: Re: [PATCH v2] drbd: Avoid Clang warning about pointless switch
 statment
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181002171447.10765-1-natechancellor@gmail.com>
 <20181004200912.32348-1-natechancellor@gmail.com>
 <20181217172401.GA30635@flashbox>
 <0110d874-7595-1786-77e3-e2b0daec2327@kernel.dk>
 <20181218092202.GJ5026@soda.linbit>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5a59a80-791a-2c42-9820-31e1fe86d72f@kernel.dk>
Date:   Tue, 18 Dec 2018 06:29:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218092202.GJ5026@soda.linbit>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 2:22 AM, Lars Ellenberg wrote:
> On Mon, Dec 17, 2018 at 10:29:38AM -0700, Jens Axboe wrote:
>>> Hi Lars and Philipp,
>>>
>>> Could you please make sure that this patch and the other one I sent make
>>> it into 4.21/5.0? I am not sure when you were planning on sending the
>>> pull request to Jens that you mentioned in the other thread but I've
>>> noticed most maintainers typically send their requests for the impending
>>> merge window around -rc7 or so and I wanted to make sure it was on your
>>> radar.
> 
> I'm sorry.
> From my point of view, "fixing the pointless switch" is just "pointless",
> so it (again) fell through.  I get it that it is important to others,
> and getting rid of Clang warnings is a good thing.  So sorry again.
> 
>> It needs to get here now, but drbd hasn't really sent anything in for
>> about a year,
> 
> Last actual fix was 2018-06-25 64dafbc9530c drbd: fix access after free
> so almost six month, yes.

It just dropped from its usual cadence of regular updates.

>> so I'm starting to doubt how maintained it is at this
>> point.
> 
> Oh, it is maintained.  It is just happens to be "stable".
> We don't add new features there,
> and I'm currently not aware of any misbehavior.

Well, I guess that's good news then :-)

> I'll prepare a pull request containing this,
> the other Clang warning patch from Nathan,
> and possibly other small stuff that accumulated,
> if I can find any, and send that out later today.
> 
> Thanks for the reminder,

Thank.

-- 
Jens Axboe

