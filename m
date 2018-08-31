Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58129C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0326A2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6KUWOUj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0326A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeHaWsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:48:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42376 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:48:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so5891632pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbEBSLoYYXdqkwapMaPABG8uME/HyFvOnTsz2qYUb+U=;
        b=n6KUWOUjWk6iRpHm6Q15oaJP9GKoMGh1SXU6x341j7cHJhYNXLyIkLRy5vdqHJC7tU
         PSKbBu/aL6ziaUcddX43g6RkFfHnKRRMGHkniMJc2qufLskIBb3vXAbtWOkhyvdKqFJW
         xGveDEg7vprYLRCKe3YBYreYqphNbik3iGQM8F8Ji5GURXQLmoWki5TPJL3lxONZLupR
         B+6+8CSisqeD8MhK2m1xut2JHLQhyCjlN34ByXVU3ZfRzUpbFhkLkQBPxaaeK+llBD4k
         w5948cey/Hkj6ZV40j9XXPHgQwrXbjJFybmTOXnELAEgYQ853StcbRhXJT96iNwMsPae
         TU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbEBSLoYYXdqkwapMaPABG8uME/HyFvOnTsz2qYUb+U=;
        b=Ezd40swqOKuZMRNScxOgQG+L6916CFQnQYaEffkv83djJ71+XwcbFPrzEhvu4dXrkk
         xgJvqfOznxWtaL3M5pxHzQswufHgHVdcam8yx1WT5H42iXzrY864I4srj7D5ib486+bC
         jex4RZSyoyZ2Ac+lxMzsLY0m99TbaunAOLLldBTkH4Egjs1efjZvoMoWvYrUoBvi7k9A
         tWYlT+g0LVMlBtbn5zLq8ud347ZvKDCLgNCST1xMSlSq7IRkJ1vpYxByuF4z2EiWbyw3
         5MHNiYA6CISZQR7rbA1kLn3nYLmUJITjG8tgZhpMRKjtwISO5UWw7xJNzK9TGH7uN2cy
         Dj4A==
X-Gm-Message-State: APzg51DqNboANniKm2NxJbTKrOqAKa+DuEPkxK8vTrbQnQETBFUxWr1R
        uMLMexpu1JuBxeA16QurYVunTUtamFyzAvH8w43IMh3dMZoNuw==
X-Google-Smtp-Source: ANB0VdafPH8gQHIO+fdQp8UWLrrC52VAlrH9znF2JsbEP0NzLROz4tG6Qe2T1vIfcaAIAFENVVpVajE4fPtkbXRVx4Y=
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr9659101pgm.225.1535740768913;
 Fri, 31 Aug 2018 11:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 11:39:17 -0700
Message-ID: <CAKwvOdk9ck_85u5-_eHwrtNu260HM5X5HRsqh8aKfK66CJH6jw@mail.gmail.com>
Subject: Re: [PATCH 1/7] Compiler Attributes: remove unused attributes
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
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
> __optimize and __deprecate_for_modules are unused in
> the whole kernel tree. Simply drop them.

Indeed.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
>  include/linux/compiler-gcc.h   | 2 --
>  include/linux/compiler.h       | 4 ----
>  include/linux/compiler_types.h | 1 -
>  3 files changed, 7 deletions(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 763bbad1e258..0a2d06677d83 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -95,8 +95,6 @@
>
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>
> -#define __optimize(level)      __attribute__((__optimize__(level)))
> -
>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
>  #ifndef __CHECKER__
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 681d866efb1e..7c0157d50964 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -301,10 +301,6 @@ static inline void *offset_to_ptr(const int *off)
>
>  #endif /* __ASSEMBLY__ */
>
> -#ifndef __optimize
> -# define __optimize(level)
> -#endif
> -
>  /* Compile time object size, -1 for unknown */
>  #ifndef __compiletime_object_size
>  # define __compiletime_object_size(obj) -1
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3525c179698c..b6534292ea33 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -108,7 +108,6 @@ struct ftrace_likely_data {
>
>  /* Don't. Just don't. */
>  #define __deprecated
> -#define __deprecated_for_modules
>
>  #endif /* __KERNEL__ */
>
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
