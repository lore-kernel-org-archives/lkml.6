Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8650DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BCC20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IlINU9XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BCC20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeH1RjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:39:21 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:44609 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeH1RjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:39:21 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7SDlLs9003963;
        Tue, 28 Aug 2018 22:47:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7SDlLs9003963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535464042;
        bh=tV9ejS/uIxcX5Arhv9DLkFl7BhaBUIeeAvherwqzrbY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=IlINU9XEzfSI8QPDecxw9cOB0iUbLD/q5hdz2iwHJNEDB5w2DOVCmMpKpKbJukX5G
         d3w+HNzWpDMjOi8WLLPChDli23OFq8kIXRtNMxvLL2N8o4C2U83YSvZwrs4GQeE9mr
         fRAB70TZofCAsTmhkLxjGd5sCFvL8SgzUrHSJWOT0sMNr4GJTe/gC8z//M4mqD177a
         9B9leOX0KxAwifT99Mj82Jcf+iX1idI9LzcBWJOg3bpAnokE24SmOCEWPggrwK31b1
         E7OiXoEERErvFwVihYKf+Zsq9B9dOBiBInGroOgo0QTkW5USr04ArTiV2AmS9ayjWY
         KjN8EgEazioBw==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id q7-v6so1003745uam.12;
        Tue, 28 Aug 2018 06:47:22 -0700 (PDT)
X-Gm-Message-State: APzg51AdvPGwi+8CU7z6VSf5BotXduNtORSOcrXODZGpPejYl1BHjBuP
        nLWkkjX4XS0Gq6PGL1RbauFeRbJkX7hcvBUHobM=
X-Google-Smtp-Source: ANB0VdbcywnaqtndV+oPgUF72HSYStzXbYzYV0Av4vtYLbS67Vn7VOrTD7fNSvlS8PaEYcqUmTCcR1+SRBkwrQqNLvs=
X-Received: by 2002:ab0:4f17:: with SMTP id n23-v6mr1025334uah.135.1535464041289;
 Tue, 28 Aug 2018 06:47:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 06:46:40
 -0700 (PDT)
In-Reply-To: <CAK8P3a2NgqV6fnQSaTFKWdBpwp656L9Kp4NB=bwTwRb8ojZAuQ@mail.gmail.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAK8P3a2NgqV6fnQSaTFKWdBpwp656L9Kp4NB=bwTwRb8ojZAuQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 28 Aug 2018 22:46:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyPfDZ9SkUjzSBi9upntVwydfU6N3eRrq7rmKZgXAS8w@mail.gmail.com>
Message-ID: <CAK7LNARyPfDZ9SkUjzSBi9upntVwydfU6N3eRrq7rmKZgXAS8w@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Santos <daniel.santos@pobox.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-28 19:55 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Aug 27, 2018 at 10:44 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>>
>> On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
>> >> Now we're back to the question of "what do you mean by 'constant'"?  If
>> >> you mean a C constant expression (as defined in the C standard) than
>> >> almost none of this code fits that criteria.  For these compile-time
>> >> assertions to work, we are concerned with the data flow analysis and
>> >> constant propagation performed by the compiler during optimization.  You
>> >> will notice in include/linux/compiler.h that __compiletime_assert is a
>> >> no-op when __OPTIMIZE__ is not defined.
>> > Depending on optimizations for static assertions sounds problematic.
>>
>> (with my best Palpatine voice) It is unavoidable.
>>
>> Actually it's theoretically possible, but the compiler would have to do
>> something akin to copying it's control flow graph et. al, run -O2-ish
>> optimizations, perform the static assertions and then throw away the
>> optimized control flow graph and emit code based upon the original.
>
> In the context of the kernel, compiling with anything less than -O2 or
> -Os is not an issue, we don't do it anyway. -O0 never worked, and
> AFAICT we only build one file with -O1, but that is something we can do
> away with as well:
>
> from fs/reiserfs/Makefile:
> # gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
> # functions are used.  This causes the compiler to advance the stack
> # pointer out of the available stack space, corrupting kernel space,
> # and causing a panic. Since this behavior only affects ppc32, this ifeq
> # will work around it. If any other architecture displays this behavior,
> # add it here.
> ccflags-$(CONFIG_PPC32) := $(call cc-ifversion, -lt, 0400, -O1)
>
>      Arnd

Recently, I sent out patches to remove redundant GCC version checks,
including this one.

https://lore.kernel.org/patchwork/patch/977808/

I do not know who is maintaining reiserfs, though.


-- 
Best Regards
Masahiro Yamada
