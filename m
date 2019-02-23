Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D5AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A662084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IW4Z6ah5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfBWK37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:29:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35951 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBWK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:29:58 -0500
Received: by mail-io1-f67.google.com with SMTP id r136so3864882iod.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 02:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czgMrXoy4OznuWyRAp8WH61JQaMmGjKrEeBoU0SDHNw=;
        b=IW4Z6ah5ZG09zAZTJde3NvhOs1Gb24DdtQfnBvu0cmgzstnCZ7mQV05V0pzyHaOVOZ
         Yfdw3MlQcSP0dFU7NEHslxjZ+oF+v933f7Gp3lpYqZ4g42FH/UOWKtBFWHshRJVennOR
         BkMD4KHAf1c4D62OBIvone874wfhUBF7FqWzQmmA3ple/Y5morh3wusaUSFVxN+AXIrN
         caBcelTAFCVjBFuD1edHEbohV/5z0WJ/n/KzzT2bZPWRbfm/03vI53+Flp/uby03XcPu
         Osey296TpzuQl3BOFruzmDkIA0+/jyf+/RcEhDvB7I/kGENayyWjqqLyk/N0FIbhonf1
         NhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czgMrXoy4OznuWyRAp8WH61JQaMmGjKrEeBoU0SDHNw=;
        b=mJ7sbnFr+7e1JX8Maw84AcWd4hKAkdkkewGUBK9SDQwTvPdFppdDXi8bo2xp3LxPcw
         cV9kJypsqc/I9zF9YBu9+Y9dBm88Nq82r8g+wYeQyXJdD6G65+WWZmV5x4LIHWu/88zV
         VPvVKLh7Nkb8tocC9KfV8nkGxhWA8Jkqg8ZZZrxapTuenXtiTg4tf98fNPbozotrXoXW
         580+8OuvzaeqNVJC0RBT3mSOWZVcEr/3jI/bch1pB1H+epO3AGTCirnvysK7GA44T6cw
         IR9sIKcHhL/4qmkjmI14KkMIsAdIHV5hjNFd1XwxoUhC1fsCcPxbEa8Lgabt5/BsizgU
         PpXw==
X-Gm-Message-State: AHQUAuYzLec7svfbPFoQWmzyk6nL05vbk5s0KvC+nikLKKlJsQB2kZ2H
        Iy1FXKg7HaAk7ylcX9qz7uVH9qoI+jKL20XUGBrtHQ==
X-Google-Smtp-Source: AHgI3IZVPzlI4CK+d7CyIZeB280RHiwl2nuYfFMWp16bv7GrUWYxTIMslmQO0y2ROCq07yBr2jOoLKBDV0+MhIPLIdg=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr4360551ior.271.1550917797156;
 Sat, 23 Feb 2019 02:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20190222182851.21174-1-mark.rutland@arm.com>
In-Reply-To: <20190222182851.21174-1-mark.rutland@arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Feb 2019 11:29:45 +0100
Message-ID: <CACT4Y+Z39U5JqaDQ-VMCn6Zmg+sJ58ZRO4ts8DQEr8XKS53Eug@mail.gmail.com>
Subject: Re: [PATCH] kasan: prevent recursive instrumentation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:29 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> When CONFIG_KASAN is selected, <linux/kasan-checks.h> defines the
> prototypes for kasan_check_{read,write}(), rather than inline stubs.


+kasan-dev@googlegroups.com

Doesn't this do the same as?
https://groups.google.com/d/msg/kasan-dev/NwEdpGgUeac/oXUIRUC6CAAJ



> This is the case even when it is included by files which are not
> instrumented by KASAN. Where helpers (e.g. the atomics) are instrumented
> with explicit calls to kasan_check_{read,write}(), this results in files
> being unexpectedly instrumented.
>
> This is problematic as it can result in instrumentation in files which
> cannot safely call these functions, such as within the EFI stub:
>
> [mark@lakrids:~/src/linux]% usekorg 8.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j64 -s
> drivers/firmware/efi/libstub/arm-stub.stub.o: In function `atomic_set':
> /home/mark/src/linux/./include/asm-generic/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
> /home/mark/src/linux/./include/asm-generic/atomic-instrumented.h:44:(.init.text+0xa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__efistub_kasan_check_write'
> Makefile:1021: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> Let's avoid this by ensuring that uninstrumented files are given the
> same stub definition of these functions used for !KASAN builds. So that
> the stub defintions don't conflict with the real definitions in
> (uninstrumented) common KASAN code, the real definitions are prefixed
> with underscores, and called from unprefixed macros.
>
> Any compiler-generated instrumentation uses separate
> __asan_{load,store}_*() entry points, and is not affected by this
> change.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/kasan-checks.h | 8 +++++---
>  mm/kasan/common.c            | 8 ++++----
>  scripts/Makefile.kasan       | 2 +-
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> Hi,
>
> Assuming the KASAN folk are happy with this, I'd like this to be queued in the
> tip tree, where the arm64 instrumented atomics are already queued.
>
> Thanks,
> Mark.
>
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index d314150658a4..6cf4b41a5393 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -2,9 +2,11 @@
>  #ifndef _LINUX_KASAN_CHECKS_H
>  #define _LINUX_KASAN_CHECKS_H
>
> -#ifdef CONFIG_KASAN
> -void kasan_check_read(const volatile void *p, unsigned int size);
> -void kasan_check_write(const volatile void *p, unsigned int size);
> +#if defined(CONFIG_KASAN) && !defined (KASAN_NOSANITIZE)
> +void __kasan_check_read(const volatile void *p, unsigned int size);
> +#define kasan_check_read __kasan_check_read
> +void __kasan_check_write(const volatile void *p, unsigned int size);
> +#define kasan_check_write __kasan_check_write
>  #else
>  static inline void kasan_check_read(const volatile void *p, unsigned int size)
>  { }
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 73c9cbfdedf4..630e32838adb 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -95,17 +95,17 @@ void kasan_disable_current(void)
>         current->kasan_depth--;
>  }
>
> -void kasan_check_read(const volatile void *p, unsigned int size)
> +void __kasan_check_read(const volatile void *p, unsigned int size)
>  {
>         check_memory_region((unsigned long)p, size, false, _RET_IP_);
>  }
> -EXPORT_SYMBOL(kasan_check_read);
> +EXPORT_SYMBOL(__kasan_check_read);
>
> -void kasan_check_write(const volatile void *p, unsigned int size)
> +void __kasan_check_write(const volatile void *p, unsigned int size)
>  {
>         check_memory_region((unsigned long)p, size, true, _RET_IP_);
>  }
> -EXPORT_SYMBOL(kasan_check_write);
> +EXPORT_SYMBOL(__kasan_check_write);
>
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 25c259df8ffa..c475a8ac776c 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -52,5 +52,5 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>  endif # CONFIG_KASAN_SW_TAGS
>
>  ifdef CONFIG_KASAN
> -CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> +CFLAGS_KASAN_NOSANITIZE := -fno-builtin -DKASAN_NOSANITIZE
>  endif
> --
> 2.11.0
>
