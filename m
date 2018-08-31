Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE595C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C7E2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dF8luGdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C7E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeIABsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:48:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47094 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIABsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:48:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so6058648pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2myr9DjiLMzEybNM7rgB8Hb4Y/Lf9yt4tmGt7nA3V4=;
        b=dF8luGdBdJxIa8ULEdtQBV4rL7W6jPwD/rfAK0oovt1PyvxzUsssgi/7rPUnMsN7T8
         ZnANy6TK2c4r/F1efwIBODktzKnvH5+Ws9t2RPmL4xrnktayFMiWRVsZUZlC5LxIPuHt
         9WXCWr/ga7Bn85eHYYSiH4BShqpFx1k3fAR+1hb+CdzvJdsGWAF5sTt1a3793gaOuTlx
         4gUrjhCQfEM455VV/e7eFlKLXlUog5o8SBqg4nih9cuGZA/acvBQ6c5v6sgxTZxNDP3J
         SaddHi3PyC6swC/fPRFx5Dr0dC3IaBDbcoBHfO0veaWj12Esg9Zm20NNdFyzp8han7x9
         /B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2myr9DjiLMzEybNM7rgB8Hb4Y/Lf9yt4tmGt7nA3V4=;
        b=c9VlKcPID3tB9WVqPQ0N8oHcyX+hBwdwsdnBo+3vvUK58KERXAeQvzEFjKV3eiMOvi
         L8opv+qEYfamwao2O/rqrcYP9EygYjQ9tuSUEl9Ws5FmmcpHmE83kSI7zhOU5+10t5Wk
         cvCXr/R4Wf/jPJj5IphFJcVrn/dKPkLtA4FyCax9zSOnQELplOG+25wTrS4xj/af7dqB
         h9pqPfDG2S1nlEpxJlb9fKYwhByz1cnaofvvin4UDmEllZyLJG8hcZSAYJRqy9/mt+Gr
         SmXA7nloiwRt+PF/pgpHtj325mMhCcYIwVUNjF6OK0YlfhzCctaBNBEByQorIYeHf8R+
         FdvA==
X-Gm-Message-State: APzg51CqTq1BW1RQsjqsj8ipoxr+TsdZn0YpghR45HVgb0AHjU8eh9d1
        6M/SgxMFttwRinzRt2QH3DUYmkYtkxXIU7ehmXLzSgxAqCpjsA==
X-Google-Smtp-Source: ANB0VdYIg483ClGYcYUn+zHKiwvnvOmsVml/PgkTEAyycja8MMkIBIKiozojrDWUb+JnT5d3KB48XKIielaTQTSSyBM=
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr16355192pgb.145.1535751518301;
 Fri, 31 Aug 2018 14:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <20180831170514.24665-6-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-6-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 14:38:26 -0700
Message-ID: <CAKwvOdkZeFj1QW8QBDSCet2Kv1jRka0DK_eSJwNmfG1Zqn2zcg@mail.gmail.com>
Subject: Re: [PATCH 6/7] Compiler Attributes: remove unneeded sparse
 (__CHECKER__) tests
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparse@chrisli.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        joe@perches.com, asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:05 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Sparse knows about a few more attributes now, so we can remove
> the __CHECKER__ conditions from them (which, in turn, allow us
> to move some of them later on to compiler_attributes.h).
>
>   * assume_aligned: since sparse's commit ffc860b ("sparse:
>     ignore __assume_aligned__ attribute"), included in 0.5.1
>
>   * error: since sparse's commit 0a04210 ("sparse: Add 'error'
>     to ignored attributes"), included in 0.5.0
>
>   * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
>     ignore hotpatch attribute"), included in 0.5.1
>
>   * warning: since sparse's commit 977365d ("Avoid "attribute
>     'warning': unknown attribute" warning"), included in 0.4.2
>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler-gcc.h   | 6 ++----
>  include/linux/compiler_types.h | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index fdf2fbe6d544..32e6ce06163f 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -84,14 +84,12 @@
>
>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
> -#ifndef __CHECKER__
>  #define __compiletime_warning(message) __attribute__((warning(message)))
>  #define __compiletime_error(message) __attribute__((error(message)))
>
> -#ifdef LATENT_ENTROPY_PLUGIN
> +#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>  #define __latent_entropy __attribute__((latent_entropy))
>  #endif
> -#endif /* __CHECKER__ */
>
>  /*
>   * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
> @@ -139,7 +137,7 @@
>
>  /* gcc version specific checks */
>
> -#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
> +#if GCC_VERSION >= 40900
>  /*
>   * __assume_aligned(n, k): Tell the optimizer that the returned
>   * pointer can be assumed to be k modulo n. The second argument is
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3662b19599fc..5dddc7e0c607 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -216,7 +216,7 @@ struct ftrace_likely_data {
>  #define __must_check
>  #endif
>
> -#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
> +#if defined(CC_USING_HOTPATCH)
>  #define notrace                        __attribute__((hotpatch(0, 0)))
>  #else
>  #define notrace                        __attribute__((no_instrument_function))
> --
> 2.17.1
>

Everything looks correct here.  It would be good for the sparse
maintainer to triple check the commit sha's (as those are for sparse's
code base, not the kernel's) and have their blessing.  If Chris is
happy with it, then you can add my signoff:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Also, do you need to put the cc list in the commit message? Some
people do (hopefully in an automated fashion, because I'd imagine
manually to be difficult) but don't this it's required.  Doesn't
matter, just curious.

-- 
Thanks,
~Nick Desaulniers
