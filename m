Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B162C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F347A20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn7mr5np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F347A20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeKDA5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 20:57:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44396 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeKDA5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 20:57:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id n12so7908417qkh.11
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ctP2kVziwErnRs1fJFH4r1u1c1scRAxuGV5TwHB8MrY=;
        b=Jn7mr5nph0qoJrsTSZdywFCunT7slNv6jmZYcj8RWOaIs8ukB/+os7GhiqO8ASsNwQ
         tKSq5CuWKOThZ2cyuoeMqxrGnFNPVkDl+d9COjxMxGBSOh9mpwNi5JQ60//dK4M4a+yK
         LUY7Ae36pBBhPLGn3Xo0nNi8avOb7l4r6N9Hbw/iKjgVS3HoAH7v4XxKLAXV3gNIsFdu
         zaOrtY3f54HibmDwAMJXIvqPuvN7hrBmK1rBxux7cxkJE/DSVhbYtm5MaIMxPQBdIP2h
         KXSFR01oFttNhv/QztyUUId6Rx4GWhIu5d6quyJ8hLG3x2OwJol1eh4aZH5kV9xmnehs
         8DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ctP2kVziwErnRs1fJFH4r1u1c1scRAxuGV5TwHB8MrY=;
        b=Ns2Kw2Jqa9PKbuFdAHO01JALcDGoJpBse/dgEfJ6liuqCti3RaTkO3aYPm1PTvOjek
         O1FlZt3XqaGdX3BXyhsfd8N1+buaMKX+2xeQ7LZ+0gflRY/nutmOHU8wVfKSOUZLci4R
         DgSfRDpFjPa/bGUVr1caSG4HJS76WzdnK6KI5blfpES9O1Ue0107aIcs03D0A8KB5pea
         u66Abb1kWcCOd3uuO3pOQoa/H0jpKSWHHqDI5SYNEg2GnotmfMMX32gxzLbbHNE+6ud9
         snjzkoFg1MEVwCnQ8d6Jx6Mn+OwJtqjP6FwTiwx6Zu9ht9PFTBmWIjyh75PxI9NP4Bkq
         ZLEA==
X-Gm-Message-State: AGRZ1gLbwYwr1Gu4mq2rroPs7D2knJZ39q1BEkis2gHh6WsjQuSs5dbD
        +Ls1xvy++P0WW1eQ57gvF5iR50sYGHXD8LIm/mU=
X-Google-Smtp-Source: AJdET5cuVCMLf4T1GOxmPRkycRebYGmetznvFzHIdoGfZPgZYFFJt946YJGg/RRYymP5tc60S1LP5FWdwYxmSYNZaUg=
X-Received: by 2002:a37:324a:: with SMTP id y71mr804666qky.291.1541259972676;
 Sat, 03 Nov 2018 08:46:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Sat, 3 Nov 2018 08:46:12 -0700 (PDT)
In-Reply-To: <20181103000357.delj5z56zxrkcpeg@mail.google.com>
References: <20181102155710.2299475-1-arnd@arndb.de> <20181103000357.delj5z56zxrkcpeg@mail.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 3 Nov 2018 16:46:12 +0100
X-Google-Sender-Auth: gJ0nDmmpZIdW6AFWgy1t_pUv4J8
Message-ID: <CAK8P3a2L4DsaSU5H7ZPQxSNUc1=Nw5yAfVjDYe1y86T0s0kK4w@mail.gmail.com>
Subject: Re: [PATCH] copy_{to,from}_user(): fix compile-time sanity checks
 with gcc -Og
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/18, Changbin Du <changbin.du@gmail.com> wrote:
> On Fri, Nov 02, 2018 at 04:56:58PM +0100, Arnd Bergmann wrote:
>> When CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is set, we get countless warnings
>> like
>>
>> In function 'check_copy_size',
>>     inlined from 'copy_from_user' at include/linux/uaccess.h:146:6,
>>     inlined from '__copy_siginfo_from_user' at kernel/signal.c:3032:6:
>> include/linux/thread_info.h:147:4: error: call to '__bad_copy_to' declared
>> with attribute error: copy destination size is too small
>>
>> It seems that constant propagation doesn't work well enough to make
>> this code reliable, so turn it off for that configuration.
>>
> This is caused by __compiletime_warning() and fixed by below change
> already. Could you try the latest kbuild tree?
>
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -86,8 +86,10 @@
>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
>  #ifndef __CHECKER__
> +#ifndef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
>  #define __compiletime_warning(message) __attribute__((warning(message)))
>  #define __compiletime_error(message) __attribute__((error(message)))
> +#endif

Right, that works as well, but my version is a bit less invasive as it
only disables the __compiletime_error in the one file that introduced
the regression, and not all of them. I have built hundreds of randconfig
builds and found no other problem with __compiletime_error(), though
I did find a bunch of (correct) section mismatch warnings and
false-positive -Wformat-overflow= warnings with
CONFIG_CC_OPTIMIZE_FOR_DEBUGGING (patches pending).

I also got some link errors for which I already posted patches.

       Arnd
