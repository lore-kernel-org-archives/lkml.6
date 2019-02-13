Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AA6C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44DC222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eu+FGcwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392400AbfBMO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:59:15 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:30709 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbfBMO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:59:12 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x1DEwsJn031082;
        Wed, 13 Feb 2019 23:58:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1DEwsJn031082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550069935;
        bh=55DKZHzUs6VExYmThMy1H+99yndAtO1BycyXZJDqIIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eu+FGcwaUhMzJATvuYEtL/+ajMCkQXCjWgkEnYFJv/csZeHxklzFcmVLvlfmdWX4b
         0W0EA9GH8NMwu4x9jwrgZo2ZOF24jZQVdW9V/D+IV4emYNQ/u2yV22M/kN2A5WrDV3
         9ZgMa93NPqe+njKiKVHnw9D87OXjKuFbV4nqd9pZjBgKLC6/qCfW2cXrnbZrX4wbBC
         5O4bKl7pUjjKQEebpK1QeluNmO6G5m0sJW0tg1aVIRyRjtiIQXkmErdAi6CJ1ZcudS
         OArts3bMV70DOJo3rEjcBwC3PTj3ZVW4O8pZtAalK1VIT+SeD5WXWAM1OWofixRe/m
         CgoGhRyZ7IezQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id z18so1543318vso.7;
        Wed, 13 Feb 2019 06:58:55 -0800 (PST)
X-Gm-Message-State: AHQUAuaFP4RRbSdWs0i47uUbZw6jmkNgPijQjihhDhd4TWxyE43Wtt3g
        nf/aFOuLMvLIoZ6zHDjxTjPMmE5HW0LMsz2hXIU=
X-Google-Smtp-Source: AHgI3IYhmOBf5M2y4iuyl7FNJv6k8ZUwjsXuLt/fDpeKD+7JRFaGhTGfIWe2/xlM+ccBLzPbCqaiyM2F1/tGO83APTQ=
X-Received: by 2002:a67:485:: with SMTP id 127mr378590vse.54.1550069934466;
 Wed, 13 Feb 2019 06:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com> <20190211193008.24101-3-ndesaulniers@google.com>
In-Reply-To: <20190211193008.24101-3-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Feb 2019 23:58:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
Message-ID: <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
>
> This is needed because clang doesn't select which linker to use based on
> $LD but rather -fuse-ld=lld. This is problematic especially for
> cc-ldoption, which checks for linker flag support via invoking the
> compiler, rather than the linker.


Sorry, please explain what kind of problem
this patch solves.



[1] $(LD) is used to link vmlinux, modules, etc.

[2] $(CC) is used to link vdso, etc.
    and -fuse-ld= selects which linker is invoked from $(CC)


Is it a problem to use a different
type of linker for [1] and [2] ?


Thanks.





> Link: https://github.com/ClangBuiltLinux/linux/issues/342
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1->V2:
> * add reviewed and tested by tags.
> * move this addition up 2 statments so that it's properly added to
>   KBUILD_*FLAGS as per Nathan.
>
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index d3b65e96d183..00e8e01d23fc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -500,6 +500,9 @@ ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  CLANG_FLAGS    += -no-integrated-as
> +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> +CLANG_FLAGS    += -fuse-ld=lld
> +endif
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  export CLANG_FLAGS
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


--
Best Regards
Masahiro Yamada
