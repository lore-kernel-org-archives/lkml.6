Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B90DECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CA320684
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9+AxrPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CA320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbeIUPdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:33:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35461 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:33:30 -0400
Received: by mail-it1-f195.google.com with SMTP id 139-v6so1249059itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6yodDWNExFcPbLDDukiKkXIpHJsM/fP+aQJtylI10eA=;
        b=S9+AxrPeis5FhcS7IQx+9/c0HI3RbxS7OM5JFTCjvJbQ7aQstWd4WEhSLTuFHFONV/
         jgEm3e5+8uU16fbtQaUl3jmssBDYAUuGgDs2xpLUMrqDf8tbP5ofju8DRcuaXNzSeX1T
         4xMnyeyGIS/NSN/9XQJUERLmvGzIZ4hsI4yZPfFu2LlX7HvKunKmy2eCzZiJjWJ1ScaN
         s6PBGXLHIZJCigt9HSWx3gGAp/eKHVoo0HVEBCPM6JK1IcthJVs3umxQHwxC8sAJ413n
         zqceOV+9Kx8VLW7l2dzPRDItCZoXVj13moX2g1V0yFhzg4IgeJQ5C30RYV4+Vss7hpGe
         lqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6yodDWNExFcPbLDDukiKkXIpHJsM/fP+aQJtylI10eA=;
        b=H9xj1SL43BLYpL/mIKCNUyZj6MC3eqJrX8+GI++L26vRxqijwXoz8f07N2WeWT6wka
         lkrn+57sif2w3xYJEZW2A5rDKlT/spB50f4Nyl34pW3wU/5eG9i2hYitvmvpzRLNyId5
         kOjjp6p42pb62LTw1QN/aMurT7JqVeyWwk4wY8rdmxum2uTVLL+W+4xzzdPcU02vn6sM
         wcNctHrwWCxmRzPbiqhCL0Rbe1u9H8sAWxikIeHwUncKbEqrW0lSxwilPXLnGyO9FIg/
         2tRnk/CN3q0UpvpKY9bnuObEC7q880SYNX6Gs/++0xI4PrUaXsm64B+c+5po+FUGlv6l
         /Q4Q==
X-Gm-Message-State: APzg51DNw7PQHCS1ObKGGa0G+YQL0r9GbfbZ7cue6mRNYKDd2AGqGBP+
        GnxhKYiOJ0tLiI9sA8425iKoOncuRU5sGLOHncsMpA==
X-Google-Smtp-Source: ANB0VdbeUpiDSFtEAn0vgq/lBeoJbCgfpsyu5uYJ81NINFsWkGz+yjjt4lqQtDkZ2B/9C1jPj4uOnmv2WNHh5njTZ8M=
X-Received: by 2002:a24:140f:: with SMTP id 15-v6mr5271807itg.57.1537523127817;
 Fri, 21 Sep 2018 02:45:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 02:45:07
 -0700 (PDT)
In-Reply-To: <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com>
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 Sep 2018 11:45:07 +0200
Message-ID: <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 11:25 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> On 09/21/2018 04:50 AM, Andy Lutomirski wrote:
>> This patch seems reasonable, but you emailed the wrong people :)
>>
>> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>
>>> It turns out that KASAN in general will bloat stack frames in unexpected
>>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
>>> default to be associated with KASAN instead of KASAN_EXTRA.
>>>
>
> KASAN_EXTRA bloats stack more than just KASAN, that's why the limit is higher than just for KASAN.
> If want more details, tead the changelog from commit e7c52b84fb18f08ce49b6067ae6285aca79084a8
>
> If anything causes "stack frame > 2048" warning for KASAN we should at least try to fix it,
> I mean reduce stack usage.


+Nick who is also hitting these warnings on clang/arm64 build. As far
as I understand the situation there is much worse.

I would be good to understand/fix the worst offenders. But the stack
size increase with KASAN is a real, inherent thing. So if we live very
close the edge, we can get people using different compilers and/or
versions of compilers constantly breaking each other. And clang hits
this warnings in lots of places today just because the current code
was tailored to gcc over long period, i.e. allowing more locals where
gcc happened to handle that better and having fewer locals where gcc
happened to handle it worse. But for another compiler all these
assumptions are significantly perturbed.

Nick, do you know what frame size limit eliminates the bulk of
warnings on clang? Is 3072 a reasonable limit allowing to fix the
remaining outliners?


>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>>>  lib/Kconfig.debug | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 4966c4fbe7f7..39078a080e29 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
>>>  config FRAME_WARN
>>>         int "Warn for stack frames larger than (needs gcc 4.4)"
>>>         range 0 8192
>>> -       default 3072 if KASAN_EXTRA
>>> +       default 3072 if KASAN
>>>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>>         default 1280 if (!64BIT && PARISC)
>>>         default 1024 if (!64BIT && !PARISC)
>>> --
>>> 2.19.0
