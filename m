Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D87BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E30024AD1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hlgjSJxa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i80AfjIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E30024AD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeGBSaC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:30:02 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41046 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbeGBS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:29:57 -0400
Received: by mail-yw0-f195.google.com with SMTP id j5-v6so6995329ywe.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qx4WHmIBRsW6WEfFM7RA8/FczRIZE7LVfDizuJGrzbU=;
        b=hlgjSJxa70aSpblPHYG1oApC3B5i8l0056wBh+Kj1K+/0aH2jeaxQUPLb4JWGjoSwt
         /DBkiNaXEG+FsJk0ZRED4r8gIoHZmX3s6iR12Je/oANJ+9ACco4Pxtdb5V1GS3ycOJIU
         36S5V+N9q571heiJ2KN7Mb6df1X1eYxS6PaA6t1dl/jPrfP9hYpqd97qu7HihALkfypq
         Fhe4466DDY/ZbzvfuLkw3JUnK7rR869os4vsz+vQo5KgEgJ/H1phgxZtxYAjEODE8waC
         /gnTAdI0gnsX7afdm/5LT8c6r6ucgC8dKZf+HWZ5EKpHoTKghmK/z6/4bYXJ6E7AymyD
         R0Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qx4WHmIBRsW6WEfFM7RA8/FczRIZE7LVfDizuJGrzbU=;
        b=i80AfjIhhNa6WmwMWHEGBWADQX87uoJGkuutIZk8aGsUsPyGGuQdTf3OZGk6heLDS3
         zUUAyfAclElRBaMuN07oDCawrKsKphXiPDxdfdIZRZSnN2mNyIMjq/A6SQXkxR8lkfSn
         r34gXmxuQx/EpRbmoW8lvx7MJllDtKKUTqr0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qx4WHmIBRsW6WEfFM7RA8/FczRIZE7LVfDizuJGrzbU=;
        b=LmSuyuqsFiNaHNUNofpJI3D61/qNoDZVjgXiQ/4Dla2N108HxWWfL6OyEtOjwlbafE
         i4kUmlcaYZSVqDbpp0vKBvsKVktcPKntzKrzonu6hPharhoZXvugvyu1UJHVZmw6k5+D
         PFkM2zIGHLsu9a4+wIbX4yRmFgGfW9ZDUuRE6y/WPEMiYSTIj6HOrMhLxHW9dZWzmLqy
         7054kO7fCAIErx2NERa09MTzdu+zLWTnDyOw+GYIXknDg5oUPTe0IdmsPxvLY1g56TKw
         V3IW/52uni+ROF410D5sEe5nM+xfrdw9CEQty6GmvcVh86y4mF/oQwfSNmMqXvpxYgQo
         E/nA==
X-Gm-Message-State: APt69E2syRvsK9mcVAmfjR2qWD/ehzA7GmgER0jLhvPWEwEFLfWxjRRd
        xVkHj0750F152BMTFZptd6ntkkvntjq/ao5xlYW5FUn9
X-Google-Smtp-Source: AAOMgpd9EN56qZ5RwFDSR1a84vqg/eu4w1rU8ivTVLVY/tj3AN7SWE+qfg8xnIBFRdPiGQebsPnrS3pePQ89Wvnpiow=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr12712842ywn.88.1530556196406;
 Mon, 02 Jul 2018 11:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 11:29:55 -0700 (PDT)
In-Reply-To: <20180702181145.4799-9-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org> <20180702181145.4799-9-ard.biesheuvel@linaro.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 11:29:55 -0700
X-Google-Sender-Auth: 0a3oy8fe3iFvbt1dMcv-ThcPeHA
Message-ID: <CAGXu5jK0_vjuaig1Wz=TGyWh81LXg0zbGkoJDR-_YYig6yTqng@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] jump_table: move entries into ro_after_init region
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:11 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The __jump_table sections emitted into the core kernel and into
> each module consist of statically initialized references into
> other parts of the code, and with the exception of entries that
> point into init code, which are defused at post-init time, these
> data structures are never modified.
>
> So let's move them into the ro_after_init section, to prevent them
> from being corrupted inadvertently by buggy code, or deliberately
> by an attacker.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Yay more things read-only! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  arch/arm/kernel/vmlinux-xip.lds.S |  1 +
>  arch/s390/kernel/vmlinux.lds.S    |  1 +
>  include/asm-generic/vmlinux.lds.h | 11 +++++++----
>  kernel/module.c                   |  9 +++++++++
>  4 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 3593d5c1acd2..763c41068ecc 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -118,6 +118,7 @@ SECTIONS
>         RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
>         .data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
>                 *(.data..ro_after_init)
> +               JUMP_TABLE_DATA
>         }
>         _edata = .;
>
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> index f0414f52817b..a7cf61e46f88 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -67,6 +67,7 @@ SECTIONS
>         __start_ro_after_init = .;
>         .data..ro_after_init : {
>                  *(.data..ro_after_init)
> +               JUMP_TABLE_DATA
>         }
>         EXCEPTION_TABLE(16)
>         . = ALIGN(PAGE_SIZE);
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e373e2e10f6a..ed6befa4c47b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -256,10 +256,6 @@
>         STRUCT_ALIGN();                                                 \
>         *(__tracepoints)                                                \
>         /* implement dynamic printk debug */                            \
> -       . = ALIGN(8);                                                   \
> -       __start___jump_table = .;                                       \
> -       KEEP(*(__jump_table))                                           \
> -       __stop___jump_table = .;                                        \
>         . = ALIGN(8);                                                   \
>         __start___verbose = .;                                          \
>         KEEP(*(__verbose))                                              \
> @@ -303,6 +299,12 @@
>         . = __start_init_task + THREAD_SIZE;                            \
>         __end_init_task = .;
>
> +#define JUMP_TABLE_DATA                                                        \
> +       . = ALIGN(8);                                                   \
> +       __start___jump_table = .;                                       \
> +       KEEP(*(__jump_table))                                           \
> +       __stop___jump_table = .;
> +
>  /*
>   * Allow architectures to handle ro_after_init data on their
>   * own by defining an empty RO_AFTER_INIT_DATA.
> @@ -311,6 +313,7 @@
>  #define RO_AFTER_INIT_DATA                                             \
>         __start_ro_after_init = .;                                      \
>         *(.data..ro_after_init)                                         \
> +       JUMP_TABLE_DATA                                                 \
>         __end_ro_after_init = .;
>  #endif
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 7cb82e0fcac0..0d4e320e41cd 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3349,6 +3349,15 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>          * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
>          */
>         ndx = find_sec(info, ".data..ro_after_init");
> +       if (ndx)
> +               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +       /*
> +        * Mark the __jump_table section as ro_after_init as well: these data
> +        * structures are never modified, with the exception of entries that
> +        * refer to code in the __init section, which are annotated as such
> +        * at module load time.
> +        */
> +       ndx = find_sec(info, "__jump_table");
>         if (ndx)
>                 info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
