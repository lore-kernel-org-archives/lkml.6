Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C290AC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E32084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeqOC+5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2E32084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKXJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:09:04 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42734 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:09:04 -0500
Received: by mail-pg1-f180.google.com with SMTP id d72so7351970pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOPaSWVAZ5nvz+8GhI3J6wXJPQLqY4acHXGXpEwSG2A=;
        b=DeqOC+5q0afbRFo3NbD2rv6m/UnMQDaQV8vq9Mz99nLR45+eqQm4luUD+XsaqAYPwg
         VfWuT6FhNNl5gqMxmgPDQohuzUdEp+QlKUXqv4NMnzXHvvJTVhwykbxEKXP6Ew/vswls
         tU8mIIXunLPxy/w8Guf+qvSPtWU8O1+1EX1SHEEDNQObIw5MCk5aJvISXjxlMVGQp4TP
         AZH8IYSFX2teZT3sjRdPLdCbEhqui6XOQ2INvzJX+Ubtw8JJB8iGu/aXc7bLIqcbaD1H
         gcXr/t0DfJ86rSDD5IMMlrUFiJhEX+diFSO8Bt4tijH1aphsM2DhpzrwFKCd8eJm2U/Z
         CJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOPaSWVAZ5nvz+8GhI3J6wXJPQLqY4acHXGXpEwSG2A=;
        b=DaXLS27aQWvjz1uDsHrQp48D2yM62gXUpRa7YTfGsqO1HqkwBbKIXXB9DuhsNAP7CR
         V7gmh/ZdwdTeTjJ3dQ7jFmWVQam8tygmPJyYrAVH98rBdah64QN35wYJLYXtGp8WgsjS
         +wqTSw+tUNkbFy5PUsU+I4V65JUZPssBa2px9Sf0afuqIdni2sRuafblzs8uIapWktW/
         xUSI3Z64XJq5Qk14YdO2v78fhlEfYWCw9ZzyXEKFGky5MhaR2oYPQDDYprgZYYyE+Io5
         pdnDvvzQhn/OYNB/pms+rpMBBR0ZDwxmolm0K34iJnayF+755nP3arYwgDVfvYaJIhQY
         aHUw==
X-Gm-Message-State: AA+aEWZ7njFdDuQMPnEqfGEyEkBf6Wo1oiD30Kv6pbqM6gVM9ZgpFO3M
        4vbULFrmUZ4pD6IYhpXqCW20IVVLh9Jir+i6/s1RpQ==
X-Google-Smtp-Source: AFSGD/WBmwWrHbJdQXfZOUiKmLwmWOMdtZ5hlVKNflqnJuYPS1OhjGmuvW8EnJ68EJL0ckxxc98uJVCf7OyunHWvZLQ=
X-Received: by 2002:a62:109b:: with SMTP id 27mr17702732pfq.227.1544569743092;
 Tue, 11 Dec 2018 15:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20181210234538.5405-1-natechancellor@gmail.com>
In-Reply-To: <20181210234538.5405-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 15:08:51 -0800
Message-ID: <CAKwvOdmw3cdffW+wMowrs05h-CBhHbuMJ22UFhWMfh6A5Lyxcw@mail.gmail.com>
Subject: Re: [PATCH] x86/pgtable: Always inline p4d_index
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:46 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building an allyesconfig build with Clang, the kernel fails to link
> arch/x86/platform/efi/efi_64.o because of a failed BUILD_BUG_ON:
>
> ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> (.text+0x8e5): undefined reference to `__compiletime_assert_277'
>
> Since there are several BUILD_BUG_ONs in efi_64.c, I isolated it down to
> the following:
>
>     BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
>
> After some research, it turns out that there is a new config option
> called NO_AUTO_INLINE, which adds '-fno-inline-functions' to
> KBUILD_CFLAGS so that the compiler does not auto inline small functions,
> which causes this BUILD_BUG_ON to fail because p4d_index is no longer an
> integer constant expression.
>
> According to the help text of the config, functions explicitly marked
> inline should still be inlined. As it turns out, GCC and Clang both
> support '-fno-inline-functions' but Clang only inlines functions when
> they are marked with an always inline annotation[1].
>
> Since it's expected that p4d_index should always be inlined so that its
> value can be evaluated at build time, mark it as __always_inline.
>
> [1]: https://github.com/llvm-mirror/clang/blob/master/lib/Frontend/CompilerInvocation.cpp#L637-L656

(resending as text-plain; why does gmail silently switch it back to html...)

Just some top secret github-fu: this link is bound to break over time
as the source changes.  While on that page, if you hit `y`, it's
hotkeyed to update the URL to pin it to a SHA.  That is a little more
robust (the branch or even the tree could still disappear, or history
gets rewritten (hopefully not on a master branch, but I've seen it
happen accidentally (Firefox OS))).

This doesn't look like an invasive change to me, though I'm curious
about the usefulness of CONFIG_NO_AUTO_INLINE if the kernel is still
compiled at -O2.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Thanks for sending!

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/256
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/x86/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 40616e805292..f78e53382498 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -918,7 +918,7 @@ static inline int p4d_bad(p4d_t p4d)
>  }
>  #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
>
> -static inline unsigned long p4d_index(unsigned long address)
> +static __always_inline unsigned long p4d_index(unsigned long address)
>  {
>         return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
>  }
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
