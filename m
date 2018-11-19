Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB67CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F0720671
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sx78368e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F0720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeKTEfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:35:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39458 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbeKTEfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:35:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so14959653pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H024FE/5R9+1RH7pcrH8o1llU5cGRF6cB+BVGsKl9OY=;
        b=sx78368eV39Y6BKvqtE9gYLRkGdjO7wsxmuLgV7Y0nR3o/A0TFsBQwzgJnQPxbbFXO
         nPhGzxn6T+BInbBneUn6hko5a/ItNZouC97D1auEtSOjfmf3skrDpLiW0mj+96rf9dg2
         7k3VBt2mALoKwTYqkm8VL+LNlshl8GoD12lCapKZidL6C6GHWA61Xm3Kp3WdfuSq0sDr
         NK36P0i9U/UrgjRV5br+RtlkbKx81eHOLwpohxGjhHfyzobjjQXTvIXo0YA4i/3NDMVh
         OHlFzeFySQsCtuYXD2uBB4FG3V/PHIOHS8s2zi+z6gL/58JYlZRhcNo2AjFrsx/ZY3Q0
         okCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H024FE/5R9+1RH7pcrH8o1llU5cGRF6cB+BVGsKl9OY=;
        b=q5So+U7bAmIQrZIZ0euUnpO0GENOmmh4/mlRLkRKbnDF5KHNszoNh01+RfCczvw5yD
         44fBSDyJ3ex83ECTi8ndt//yIlcS+cEwqaO8uA5AN981d8Sl7yqFMhtGLbMDnqncJIg4
         vARrrBC0S6sLlwfq8YcUwiLt3pNtpaFO7yAxQ0Yqj6PNVvSzGlw0yDF5+RYLHmOqNH3T
         j1dlShyo4BRiLlImUU8NfFlRjQOXEmgMSs/KRMOvFxlvPGh/YrT54abLEqNBsTsV2TQO
         sqIbX8YpsxA+FsrktVamKqpTCSByGz3O05VOuj5NQw6Sn9bYpU5N1mxURDBqv7GHxyiU
         J6Hw==
X-Gm-Message-State: AGRZ1gIusYd8hVrOONo8Quoceb9i96ZEP7Iex5GJU7o1ixud6WeYo4L2
        ge039RjKOZUJFmk8oFw2KiYH1h81JVIxK8bH/z3ufA==
X-Google-Smtp-Source: AJdET5fJ9ko3JekKK/CDxRdU73yhVQv+JXhY6iimGs6TFN84+a5i8BH1IwsdFBFfJKeH4je3UfSkqF1vvOukR2IV+JU=
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr16290375pll.320.1542651038769;
 Mon, 19 Nov 2018 10:10:38 -0800 (PST)
MIME-Version: 1.0
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com> <1542623503-3755-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1542623503-3755-2-git-send-email-yamada.masahiro@socionext.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Nov 2018 10:10:27 -0800
Message-ID: <CAKwvOd=dSu-rirP6rY15oLG=i2fj_ca4QvZoxMXBqj0N1pJUPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] build_bug.h: remove negative-array fallback for BUILD_BUG_ON()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kees Cook <keescook@chromium.org>, josh@joshtriplett.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The kernel can only be compiled with an optimization option (-O2, -Os,
> or the currently proposed -Og). Hence, __OPTIMIZE__ is always defined
> in the kernel source.
>
> The fallback for the -O0 case is just hypothetical and pointless.
> Moreover, commit 0bb95f80a38f ("Makefile: Globally enable VLA warning")
> enabled -Wvla warning. The use of variable length arrays is banned.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  include/linux/build_bug.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index 43d1fd5..d415c64 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -51,23 +51,9 @@
>   * If you have some code which relies on certain constants being equal, or
>   * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
>   * detect if someone changes it.
> - *
> - * The implementation uses gcc's reluctance to create a negative array, but gcc
> - * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
> - * inline functions).  Luckily, in 4.3 they added the "error" function
> - * attribute just for this type of case.  Thus, we use a negative sized array
> - * (should always create an error on gcc versions older than 4.4) and then call
> - * an undefined function with the error attribute (should always create an
> - * error on gcc 4.3 and later).  If for some reason, neither creates a
> - * compile-time error, we'll still have a link-time error, which is harder to
> - * track down.
>   */
> -#ifndef __OPTIMIZE__
> -#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
> -#else
>  #define BUILD_BUG_ON(condition) \
>         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> -#endif
>
>  /**
>   * BUILD_BUG - break compile if used.
> --
> 2.7.4
>

Yep seems fine.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested an arm64 defconfig with Clang + this patch. Then tested again
with a `BUILD_BUG_ON(4 != 5)` to verify this still breaks the build.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
