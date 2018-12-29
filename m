Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295D2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 16:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bF/XiszS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeL2QuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 11:50:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeL2QuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 11:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Dj34/bcCuD6bPp548hO84TElS+OSHQnwgkFvQVWmp3c=; b=bF/XiszSF91JwGyE0/3TI3BR+
        DQ3CPxVS8H6oDtaor/HlIaKf6uZ5sN9oIJdMe9Q/AFL7asAGaAsH0sLLWsWbDld/2YEAFT0XDBQdi
        G3rL9BhR0i0OS2HFwfc3VlCReJOVMUnZVdHeytd4GNgxofttszRx7hlZtzy9Itgdj1UL0ALYyawNS
        /3jBbtxuaUNhbaRxgA8O8c6t6eotx2RkXr095mDzQhQqY3aEPDovM+EQniX4LfizgyF4OT2TfESjq
        OFS8508cOh1RIIhB4NkzvHvJlaOigMb3rLqJd9nKjNcVVYOaSNz80yJCwVHVR9oDlVBOS8r0xcXqu
        Q7vtCi8Vw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gdHoR-0003VD-Ig; Sat, 29 Dec 2018 16:50:11 +0000
Subject: Re: [PATCH 3/3] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
To:     Willy Tarreau <w@1wt.eu>
Cc:     mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
References: <20181229155817.12647-1-w@1wt.eu>
 <20181229155817.12647-4-w@1wt.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e3f7a66-2e66-a795-ea00-0e27af18f0b1@infradead.org>
Date:   Sat, 29 Dec 2018 08:50:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181229155817.12647-4-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/18 7:58 AM, Willy Tarreau wrote:
> Ingo rightfully asked for a bit more documentation in the nolibc header,
> so this patch adds some explanation about its purpose, how it's made, and
> how to use it.
> 
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Hi Willy,

This is a good summary IMO.  Thanks.
And it's in good shape -- doesn't *require* any fixes.
But if you do make any changes to it, here are a few suggestions.  :)


> ---
>  tools/testing/selftests/rcutorture/bin/nolibc.h | 90 +++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/nolibc.h b/tools/testing/selftests/rcutorture/bin/nolibc.h
> index 985364c..20d15a6 100644
> --- a/tools/testing/selftests/rcutorture/bin/nolibc.h
> +++ b/tools/testing/selftests/rcutorture/bin/nolibc.h
> @@ -3,6 +3,84 @@
>   * Copyright (C) 2017-2018 Willy Tarreau <w@1wt.eu>
>   */
>  
> +/*
> + * This file is designed to be used as a libc alternative for minimal programs
> + * with very limited requirements. It consists of a small number of syscall and
> + * types definitions, and the minimal startup code needed to call main().

      type

> + * All syscalls are declared as static functions so that they can be optimized
> + * away by the compiler when not used.
> + *
> + * Syscalls are split between 3 levels :

Instead of "between", use either "among" or "into".  and then "levels:".

> + *   - the lower level is the arch-specific syscall() definition, consisting in
> + *     assembly code in compound expressions. These ones are called

Apparently "these ones" is acceptable in UK English, not so in US English.
I don't like it, but we do accept UK English here.  :)

> + *     my_syscall0() to my_syscall6() depending on the number of arguments. The
> + *     MIPS implementation is limited to 5 arguments. All input arguments are
> + *     cast to a long stored in a register. These expressions always return the
> + *     syscall's return value as a signed long value which is often either a
> + *     pointer or the negated errno value.
> + *
> + *   - the second level is mostly architecture-independent. It is made of
> + *     static functions called sys_<name>() which rely on my_syscallN()
> + *     depending on the syscall definition. These functions are responsible
> + *     for exposing the appropriate types for the syscall arguments (int,
> + *     pointers, etc) and for setting the appropriate return type (often int).
> + *     A few of them are architecture-specific because the syscalls are not all
> + *     mapped exactly the same between architecture. For example, some archs do
> + *     not implement select() and need pselect6() instead, so the sys_select()
> + *     function will have to abstract this.
> + *
> + *   - the third level is the libc call definition. It exposes the lower raw
> + *     sys_<name>() calls in a way that looks like what a libc usually does,
> + *     takes care of specific input values, and of setting errno upon error.
> + *     There can be minor variations compared to standard libc calls. For
> + *     example the open() call always takes 3 args here.
> + *
> + * The errno variable is declared static and unused. This way it can be
> + * optimized away if not used. However this means that a program made of
> + * multiple C files may observe different errno values (one per C file). For
> + * the type of programs this project targets it usually is not a problem. The
> + * resulting program may even be reduced by defining the NOLIBC_IGNORE_ERRNO
> + * macro, in which case the errno value will never be assigned.
> + *
> + * Some stdint-like integer types are defined. These ones are valid on all

                                                  These are valid on all
(or not :)

> + * currently supported architecture, because signs are enforced, ints are
> + * assumed to be 32 bits, longs the size of a pointer and long long 64 bits.
> + * If more architectures have to be supported, this may need to be adapted.
> + *
> + * Some macro definitions like the O_* values passed to open(), and some
> + * structures like the sys_stat struct depend on the architecture.
> + *
> + * The definitions start with the architecture-specific parts, which are picked
> + * based on what the compiler knows about the target architecture, and are
> + * completed with the generic code. Since it is the compiler which sets the
> + * target architecture, cross-compiling normally works out of the box without
> + * having to specify anything.
> + *
> + * Finally some very common libc-level functions are provided. It is the case
> + * for a few functions usually found in string.h, ctype.h, or stdlib.h. Nothing
> + * is currently provided regarding stdio emulation.
> + *
> + * The macro NOLIBC is always defined, so that it is possible for a program to
> + * check this macro to know if it is being built against and decide to disable
> + * some features or simply not to include some standard libc files.
> + *
> + * Ideally this file should be split in multiple files for easier long term
> + * maintenance, but provided as a single file as it is now, it's quite
> + * convenient to use. Maybe some variations involving a set of includes at the
> + * top could work.
> + *
> + * A simple static executable may be built this way :
> + *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
> + *            -static -include nolibc.h -lgcc -o hello hello.c
> + *
> + * A very useful calling convention table may be found here :
> + *      http://man7.org/linux/man-pages/man2/syscall.2.html
> + *
> + * This doc is quite convenient though not necessarily up to date :
> + *      https://w3challs.com/syscalls/
> + *
> + */
> +
>  /* some archs (at least aarch64) don't expose the regular syscalls anymore by
>   * default, either because they have an "_at" replacement, or because there are
>   * more modern alternatives. For now we'd rather still use them.
> @@ -19,18 +97,6 @@
>  
>  #define NOLIBC
>  
> -/* Build a static executable this way :
> - *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
> - *            -static -include nolibc.h -lgcc -o hello hello.c
> - *
> - * Useful calling convention table found here :
> - *      http://man7.org/linux/man-pages/man2/syscall.2.html
> - *
> - * This doc is even better :
> - *      https://w3challs.com/syscalls/
> - */
> -
> -
>  /* this way it will be removed if unused */
>  static int errno;
>  
> 

ciao.  thanks.
-- 
~Randy
