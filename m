Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D13AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065FB20841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2sNuf1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065FB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeIAB7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:59:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40516 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeIAB7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:59:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so6017943plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZiorIf3uGxuC0t6PQdbdDRoCZPcPN1Zy9cGAiA5xB/c=;
        b=E2sNuf1I7zkjzT5DOaPFc/B4bXeoDgfrOZHvrQRXfM1LZFAxqKzqfIFrJ5X59noHOQ
         ARJdDLVqpnN6ZjarKtZZ3JxhK0vhqawafn+cCf8PfHwYVToOLZ/uwoTWvPBI4Bd9KlHu
         qbjownJl49uzpaJZlB1nOCvt4nAL4hrC9YgTf0UUgHSgt7rDaSHw5UKWAqSQo5p2rTlP
         6UV9bPqGNjXLb6GBQ0rLTYYFuYQFIFvDWhlmiiKhJR6gYTEqSU4Xy9bkG62EgCUyeH4T
         +PJNoHBM+Bd06xVbgKjITfuhD4ZZxDEJMuXMcTCfFSt0lDBAz26mYVB/57Zc35RyvtyD
         9P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZiorIf3uGxuC0t6PQdbdDRoCZPcPN1Zy9cGAiA5xB/c=;
        b=WtgEhlJb83OVPW8lyar0mXwnaSC7d+DsdJjmDvUkJHE2ZRdVEi7oTFks1wc4rNQ1+l
         4c+R6tuTKhFxBCNJOUR5+ABgOxpHE7xHW23rFKS8Z2gUuHh4QHMJv5yRNn60aqRY39bv
         0Dp5aS5QBGa/RaklCT15Sf2HtG2Ikxr5VnqGhcestD2fgqAcNZDEyv+74GiZDgQaFLdF
         Gx/gCGTNxY1Bj01iw1UQTUrn8R+qitePkhNqp2uW2zXnlJp0OQIQYxzLqM+GxAggjIsc
         zk5kCz8AZ1p/vcCc1D9BqZPR7c4GTO/M4Dd54oIGb9xyFntm1NL0W/d2oDNo/ucBGy1Y
         PiEg==
X-Gm-Message-State: APzg51D3WYzX8+VsSbAifagv1Wh7vrykZ+xaJ2xd7sE0f9LbVVD+BkdK
        0UvBpnV+4bYpTFEfynPwKaHMInvqIXjcmANYzcSXFQ==
X-Google-Smtp-Source: ANB0VdaMnVatcJbfA+tdGDEqDJcgfgrqL3eZaJkHLF+hnghX8+T8ADOXG0BNSLoGImEaqnDxZxqPzRZZud0hl3plyqQ=
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr17458152plz.238.1535752216282;
 Fri, 31 Aug 2018 14:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180730213412.242849-1-ndesaulniers@google.com> <20180730213412.242849-2-ndesaulniers@google.com>
In-Reply-To: <20180730213412.242849-2-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 14:50:05 -0700
Message-ID: <CAKwvOdk3mL87ZA_7ifGdmbztzxdFzJhFAwKoGfv6OiH0ECV0vg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] compiler-clang.h: Add CLANG_VERSION and __diag macros
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, joe@perches.com
Cc:     Arnd Bergmann <arnd@arndb.de>, paul.burton@mips.com,
        christophe.leroy@c-s.fr, Stafford Horne <shorne@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, rdunlap@infradead.org,
        bp@suse.de, neilb@suse.com, LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, dwmw@amazon.co.uk,
        sandipan@linux.vnet.ibm.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Lawrence <paullawrence@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, ghackmann@android.com,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>, avagin@openvz.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Miguel and Joe

This is the old patch I had sent for detecting Clang version.  If we
wanted to set a minimal version, this plus the actual version should
do it.  Probably could drop the diag stuff, as we changed clang to not
warn in this case, so my solution using _Pragma is obsolete.
On Mon, Jul 30, 2018 at 2:34 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> These are needed for doing proper version checks, though feature
> detection via __has_attribute,  __has_builtin, and __has_feature should
> be preferred, see:
> https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
>
> Also adds __diag support, for generating compiler version specific
> _Pragma()'s.
>
> __diag support based on commit 8793bb7f4a9d ("kbuild: add macro for
> controlling warnings to linux/compiler.h")
>
> Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/compiler-clang.h | 19 +++++++++++++++++++
>  include/linux/compiler_types.h |  4 ++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 7087446c24c8..9442e07a361e 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -7,6 +7,10 @@
>   * for Clang compiler
>   */
>
> +#define CLANG_VERSION (__clang_major__ * 10000 \
> +                      + __clang_minor__ * 100  \
> +                      + __clang_patchlevel__)
> +
>  #ifdef uninitialized_var
>  #undef uninitialized_var
>  #define uninitialized_var(x) x = *(&(x))
> @@ -46,3 +50,18 @@
>      __has_builtin(__builtin_sub_overflow)
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> +
> +#define __diag_str1(s) #s
> +#define __diag_str(s) __diag_str1(s)
> +#define __diag(s) _Pragma(__diag_str(clang diagnostic s))
> +#define __diag_CLANG_ignore ignored
> +#define __diag_CLANG_warn warning
> +#define __diag_CLANG_error error
> +#define __diag_CLANG(version, severity, s) \
> +       __diag_CLANG_ ## version(__diag_CLANG_ ## severity s)
> +
> +#if CLANG_VERSION >= 70000
> +#define __diag_CLANG_7(s) __diag(s)
> +#else
> +#define __diag_CLANG_7(s)
> +#endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index a8ba6b04152c..a04e6bd63476 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -279,6 +279,10 @@ struct ftrace_likely_data {
>  #define __diag_GCC(version, severity, string)
>  #endif
>
> +#ifndef __diag_CLANG
> +#define __diag_CLANG(version, severity, string)
> +#endif
> +
>  #define __diag_push()  __diag(push)
>  #define __diag_pop()   __diag(pop)
>
> --
> 2.18.0.345.g5c9ce644c3-goog
>


-- 
Thanks,
~Nick Desaulniers
