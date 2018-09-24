Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392C4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51A62064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prby4oN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51A62064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIXOGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:06:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37481 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeIXOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:06:11 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so16907067iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cg7ZN9rBKFhzm979WWrn1nn7WRK1ovFnc4AB+fqH32Q=;
        b=prby4oN1HTN/SwFxgjrH09d779vxemm9xENoW0FWyc2uyq4z7sMVjbtOo+W6YUSk6L
         u+D38nEAhMi6xA0g0FMsowmLX9hEm+2pMynhe5z36sTeRWZfWqkwBVhL+4TQHrHLZWsX
         HLkcVvoERArBeG3ZFAm5bMnNP0VOCkJd7tuHLv17vGD+QjmSYcM7N/k4EYfOn095QYne
         UWEFFj4PHjOAbWVi1p021mqRVl3z3tooPv1xfR+zJ1S9kYqM02+eosib7FrIDdO3lNhB
         vCWW5tV1/UBUGaUV508hoMzDpng/X6C82L6Rt/F4TAHXFpiFd3v08n1/5CNU77Y40GGc
         EMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cg7ZN9rBKFhzm979WWrn1nn7WRK1ovFnc4AB+fqH32Q=;
        b=e6Tw9jOzp0cuK3LCAoytN5RuJBSlgkg7AajYAqwPIN74Up7RtvCMmFLWUENt557kjC
         6pvfdHEn8+S7h0aBTH94/WKqnDI5aafy1h3juTsfan5on994A1mCI8nTeaCCV5OdDxLP
         nk0B6cUM9VwDyDhAeK7m7TWZzfRFKCfVc8qsQU3q01HRrhFCOl++tnyaWxsbN/ABErFs
         1PWuqFnWMTkL+uGzvtXiZfDzJQaVApbgXnqQpB1rzxEGkfgrxA7agsRoCqIv3H+g5T/b
         wp/QqwWxt8feGlDV3B8nN6KfRLhS2Tt9WXIIYO2H8zcGO9V400uYSHsaftWAQA0CQVvM
         C5Ew==
X-Gm-Message-State: ABuFfoi8VKKntosu/ZMKhLWse/wQEhXMHWy9nRq+ir6rZ0sW1O/0xtAm
        Nat1hzRimlM1CLjOVSyxYfPVEkkfkTKu8bDQDC0hQQ==
X-Google-Smtp-Source: ACcGV60qLbhetcHvr9y5t0CcRZbt8o/hFNTa6+KC2ibrWin+tMxmJFXEdyt6Afu1pK7/5Bo74/9HTyt5RlLjA3W2FcY=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr6652026ioh.271.1537776319174;
 Mon, 24 Sep 2018 01:05:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 01:04:58
 -0700 (PDT)
In-Reply-To: <CAK8P3a19i72D3NRDEK+B5wRY-J8uQqQ5twRpTWn0641S6m-GTA@mail.gmail.com>
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com> <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
 <CAK8P3a19i72D3NRDEK+B5wRY-J8uQqQ5twRpTWn0641S6m-GTA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Sep 2018 10:04:58 +0200
Message-ID: <CACT4Y+Zfk-JBPQboNDvReW5A+ii1NwpuZZUXzb5uo__S9ynbbw@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 4:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 21, 2018 at 2:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Fri, Sep 21, 2018 at 11:25 AM, Andrey Ryabinin
>> <aryabinin@virtuozzo.com> wrote:
>> > On 09/21/2018 04:50 AM, Andy Lutomirski wrote:
>> >> This patch seems reasonable, but you emailed the wrong people :)
>> >>
>> >> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> >>>
>> >>> It turns out that KASAN in general will bloat stack frames in unexpected
>> >>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
>> >>> default to be associated with KASAN instead of KASAN_EXTRA.
>> >>>
>> >
>> > KASAN_EXTRA bloats stack more than just KASAN, that's why the limit is higher than just for KASAN.
>> > If want more details, tead the changelog from commit e7c52b84fb18f08ce49b6067ae6285aca79084a8
>> >
>> > If anything causes "stack frame > 2048" warning for KASAN we should at least try to fix it,
>> > I mean reduce stack usage.
>>
>>
>> +Nick who is also hitting these warnings on clang/arm64 build. As far
>> as I understand the situation there is much worse.
>>
>> I would be good to understand/fix the worst offenders. But the stack
>> size increase with KASAN is a real, inherent thing. So if we live very
>> close the edge, we can get people using different compilers and/or
>> versions of compilers constantly breaking each other. And clang hits
>> this warnings in lots of places today just because the current code
>> was tailored to gcc over long period, i.e. allowing more locals where
>> gcc happened to handle that better and having fewer locals where gcc
>> happened to handle it worse. But for another compiler all these
>> assumptions are significantly perturbed.
>>
>> Nick, do you know what frame size limit eliminates the bulk of
>> warnings on clang? Is 3072 a reasonable limit allowing to fix the
>> remaining outliners?
>
> I do not consider 3072 a reasonable limit at all. For gcc, we managed to fix or
> work around all the bugs that caused excessive stack usage. In almost all
> cases there was something seriously wrong with code generation. I added
> the KASAN_EXTRA option for the one thing that added an inherent significant
> overhead to the stack usage.
>
> llvm apparently has a similar bug to what we fixed in gcc. I created a
> reduced test case for one of the file at:
> https://bugs.llvm.org/show_bug.cgi?id=38809
>
> Unfortunately, nobody has commented on that so far, but in the
> meantime I think the best workaround would be to disable asan-stack
> entirely when building with clang, and moving it to KASAN_EXTRA
> there, like we did with the scope check on gcc.

Good point. I CCed more people on https://bugs.llvm.org/show_bug.cgi?id=38809
