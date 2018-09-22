Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12527C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638A22150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638A22150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeIVUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:50:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38735 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeIVUuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:50:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id s129-v6so7107999qke.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 07:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4N7qT40L1SXSju6GOzf684xcTauWIDH1zqc0KWGrCwg=;
        b=jxL/fpCi29lcc51yxaLNznYM6qopxL2/vQHD/rY6wyz9Ay6UT2gtz8HkJv+FTvrFLQ
         uix+6juizDLPS5ddn5dhmpCVtgO2hyuYaP2Nw61+FbJ8S+8704wG8sPsK58zuX4xhQ0q
         vWPGa0uVrI5q8MurZTSYsvheLNbbv/xGd5md8KYkGAbUpCp4m2Nzr4em8AL+Rb8VARnb
         eTRB1tvpwjqiymIPWVMO1mEZGGUv+vKFQ9aLX5dhn/ipbJVtHNAcSw0JPj6wUD9ANbDc
         E3xu7Ug+zmXRKD/QDLl6ymxArGpEGIiRTXaFlQ6qutptk9P1G6Z29h3R5sx+a+lRKpKu
         1nEQ==
X-Gm-Message-State: ABuFfoiAr0zDUbK1DW/C8JzmTnTfI/wVV6VYt9fdcIXcAjEOplM7N0TV
        xAZHzb6cM1QMu64wIXq8lBYh+3YZiidzmTnWIdU=
X-Google-Smtp-Source: ACcGV60hcOScoBrIoPBw7PDIsOOcqBsJ/NhUmBAkuR2GQieXCuK3xG/GacWSO4dWB7qyy9oS4HSG156v3oBGYHToGdc=
X-Received: by 2002:a37:bd4:: with SMTP id 203-v6mr1578220qkl.173.1537628189326;
 Sat, 22 Sep 2018 07:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com> <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 22 Sep 2018 07:56:11 -0700
Message-ID: <CAK8P3a19i72D3NRDEK+B5wRY-J8uQqQ5twRpTWn0641S6m-GTA@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Fri, Sep 21, 2018 at 2:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 21, 2018 at 11:25 AM, Andrey Ryabinin
> <aryabinin@virtuozzo.com> wrote:
> > On 09/21/2018 04:50 AM, Andy Lutomirski wrote:
> >> This patch seems reasonable, but you emailed the wrong people :)
> >>
> >> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >>>
> >>> It turns out that KASAN in general will bloat stack frames in unexpected
> >>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
> >>> default to be associated with KASAN instead of KASAN_EXTRA.
> >>>
> >
> > KASAN_EXTRA bloats stack more than just KASAN, that's why the limit is higher than just for KASAN.
> > If want more details, tead the changelog from commit e7c52b84fb18f08ce49b6067ae6285aca79084a8
> >
> > If anything causes "stack frame > 2048" warning for KASAN we should at least try to fix it,
> > I mean reduce stack usage.
>
>
> +Nick who is also hitting these warnings on clang/arm64 build. As far
> as I understand the situation there is much worse.
>
> I would be good to understand/fix the worst offenders. But the stack
> size increase with KASAN is a real, inherent thing. So if we live very
> close the edge, we can get people using different compilers and/or
> versions of compilers constantly breaking each other. And clang hits
> this warnings in lots of places today just because the current code
> was tailored to gcc over long period, i.e. allowing more locals where
> gcc happened to handle that better and having fewer locals where gcc
> happened to handle it worse. But for another compiler all these
> assumptions are significantly perturbed.
>
> Nick, do you know what frame size limit eliminates the bulk of
> warnings on clang? Is 3072 a reasonable limit allowing to fix the
> remaining outliners?

I do not consider 3072 a reasonable limit at all. For gcc, we managed to fix or
work around all the bugs that caused excessive stack usage. In almost all
cases there was something seriously wrong with code generation. I added
the KASAN_EXTRA option for the one thing that added an inherent significant
overhead to the stack usage.

llvm apparently has a similar bug to what we fixed in gcc. I created a
reduced test case for one of the file at:
https://bugs.llvm.org/show_bug.cgi?id=38809

Unfortunately, nobody has commented on that so far, but in the
meantime I think the best workaround would be to disable asan-stack
entirely when building with clang, and moving it to KASAN_EXTRA
there, like we did with the scope check on gcc.

        Arnd
