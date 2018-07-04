Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43590245D0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qkm0j6Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43590245D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933998AbeGDIuH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:50:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35919 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGDIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:50:03 -0400
Received: by mail-it0-f68.google.com with SMTP id j185-v6so6689421ite.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M1aOkY2jCGShbnQ5ru42X1vKhP8RBUu9Xpv7sHiBZ68=;
        b=Qkm0j6HpdcMRTN9HHevtD1wR9lQJOfYdvjdH69KshKCNaMSEJ8VG1cp2PKNdJCTruV
         SNYrkJkPbdocpRzVC82n8EOicHu95MqH+fyArfPJNYwXPDQ1MOY1gBmWHXYG4VfRGF/D
         u75ImyaTjjHRoD6k9+xnjgX64P7uH2DZe6HQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M1aOkY2jCGShbnQ5ru42X1vKhP8RBUu9Xpv7sHiBZ68=;
        b=DAWju+LYRjUAz+I68v4AD/sA3E2alXW/JTjb4doALSQtuH/gOvrPTGnxbZwc2hNWFC
         6aQaFDZmWR/dxd7SZERxjzeLRFgH1MevCr7O6bgjkOSU0HapnnBjfhKPDNgsd6mflBX/
         wqSgEFRyXjMnFptUI6oOf+Vay5XhMsiHBZcZmm03HHkqtS8Afp6jVu3MjJVyx4tRYYHz
         qEaXIcXRxDrXTD9QGmF1r1A3hmemq3NqE76uQMzUjQ9TxL8fG/csnwf86OKcGovFcMs/
         4I+Ll7oplZRHFQb8lxdqax8a7ii/VaOLyDg2Jqj3uFOA6VbYEFf9tJ6c3DH/SRKicf/E
         O/YQ==
X-Gm-Message-State: APt69E1NxaVjTo+jKF74+eVfS0mlCvG1n3+7qDLiLqGqYYNLR92ouC6i
        y919bhgxKzlBCz7+kD5X6bdtjoTM3zKP4i46xlOM5g==
X-Google-Smtp-Source: AAOMgpemLmncrYMMCLqA0HM1CEKUOytCue2Xh/HCPZiJcOGZkiexUpbGmWA+9CfIqlmjW9l2T5Bdq+QEpSgmSoLSBhA=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr1076117itc.68.1530694202716;
 Wed, 04 Jul 2018 01:50:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 01:50:02 -0700 (PDT)
In-Reply-To: <20180704075923.GF3701@osiris>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org> <20180704075923.GF3701@osiris>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Jul 2018 10:50:02 +0200
Message-ID: <CAKv+Gu-O3mMJHH2P7L9anXeKZtEQYcN8Am4-3xkzAQSFWUN+=w@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
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

On 4 July 2018 at 09:59, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
>> This series implements support for emitting the data structures associated
>> with jump tables as 32-bit relative references instead of absolute
>> references, which take up more space on builds that target 64-bit
>> architectures, or implement self relocation [or both].
>>
>> This series enables it for arm64 and x86, although other architectures
>> might benefit as well.
>
> Hello Ard,
>
> feel free to add the patch below which adds support for s390 to your series.
>

Thanks, I will incorporate it into v3 and beyond.

>> Changes since v1:
>> - change the relative reference to the static key to a 64-bit wide one on 64
>>   bit architectures; this is necessary on arm64, which allows modules to
>>   reside anywhere within a 4 GB window covering the core kernel text, which
>>   means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
>>   Note that x86_64 changes are in preparation that widen the relocation
>>   range as well (using the PIE linker), so I assumed that the same change
>>   is appropriate for x86 as well.
>
> FWIW, kernel modules on s390 are since ages more than 2GB away from the
> core kernel text. So this is required for s390 as well.
>

OK, good to know.

-- 
Ard.


> From 77d87236f3d5474f33c25534d8ba2c7c54c88c55 Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Wed, 4 Jul 2018 09:13:37 +0200
> Subject: [PATCH] s390/jump_label: switch to relative references
>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  arch/s390/Kconfig                  |  1 +
>  arch/s390/include/asm/jump_label.h | 40 +++++++++++++++-----------------------
>  arch/s390/kernel/jump_label.c      | 11 ++++++-----
>  3 files changed, 23 insertions(+), 29 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index baed39772c84..0349fb06a2ec 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -121,6 +121,7 @@ config S390
>         select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_JUMP_LABEL
> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_SOFT_DIRTY
> diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
> index 40f651292aa7..e2d3e6c43395 100644
> --- a/arch/s390/include/asm/jump_label.h
> +++ b/arch/s390/include/asm/jump_label.h
> @@ -14,41 +14,33 @@
>   * We use a brcl 0,2 instruction for jump labels at compile time so it
>   * can be easily distinguished from a hotpatch generated instruction.
>   */
> -static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
> +static inline bool arch_static_branch(struct static_key *key, bool branch)
>  {
> -       asm_volatile_goto("0:   brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
> -               ".pushsection __jump_table, \"aw\"\n"
> -               ".balign 8\n"
> -               ".quad 0b, %l[label], %0\n"
> -               ".popsection\n"
> -               : : "X" (&((char *)key)[branch]) : : label);
> -
> +       asm_volatile_goto("0:   brcl    0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
> +                         ".pushsection __jump_table,\"aw\"\n"
> +                         ".balign      8\n"
> +                         ".long        0b-.,%l[label]-.\n"
> +                         ".quad        %0-.\n"
> +                         ".popsection\n"
> +                         : : "X" (&((char *)key)[branch]) : : label);
>         return false;
>  label:
>         return true;
>  }
>
> -static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
> +static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
>  {
> -       asm_volatile_goto("0:   brcl 15, %l[label]\n"
> -               ".pushsection __jump_table, \"aw\"\n"
> -               ".balign 8\n"
> -               ".quad 0b, %l[label], %0\n"
> -               ".popsection\n"
> -               : : "X" (&((char *)key)[branch]) : : label);
> -
> +       asm_volatile_goto("0:   brcl 15,%l[label]\n"
> +                         ".pushsection __jump_table,\"aw\"\n"
> +                         ".balign      8\n"
> +                         ".long        0b-.,%l[label]-.\n"
> +                         ".quad        %0-.\n"
> +                         ".popsection\n"
> +                         : : "X" (&((char *)key)[branch]) : : label);
>         return false;
>  label:
>         return true;
>  }
>
> -typedef unsigned long jump_label_t;
> -
> -struct jump_entry {
> -       jump_label_t code;
> -       jump_label_t target;
> -       jump_label_t key;
> -};
> -
>  #endif  /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
> index 43f8430fb67d..50a1798604a8 100644
> --- a/arch/s390/kernel/jump_label.c
> +++ b/arch/s390/kernel/jump_label.c
> @@ -33,13 +33,13 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
>  {
>         /* brcl 15,offset */
>         insn->opcode = 0xc0f4;
> -       insn->offset = (entry->target - entry->code) >> 1;
> +       insn->offset = (jump_entry_target(entry) - jump_entry_code(entry)) >> 1;
>  }
>
>  static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
>                            struct insn *new)
>  {
> -       unsigned char *ipc = (unsigned char *)entry->code;
> +       unsigned char *ipc = (unsigned char *)jump_entry_code(entry);
>         unsigned char *ipe = (unsigned char *)expected;
>         unsigned char *ipn = (unsigned char *)new;
>
> @@ -59,6 +59,7 @@ static void __jump_label_transform(struct jump_entry *entry,
>                                    enum jump_label_type type,
>                                    int init)
>  {
> +       void *code = (void *)jump_entry_code(entry);
>         struct insn old, new;
>
>         if (type == JUMP_LABEL_JMP) {
> @@ -69,13 +70,13 @@ static void __jump_label_transform(struct jump_entry *entry,
>                 jump_label_make_nop(entry, &new);
>         }
>         if (init) {
> -               if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
> +               if (memcmp(code, &orignop, sizeof(orignop)))
>                         jump_label_bug(entry, &orignop, &new);
>         } else {
> -               if (memcmp((void *)entry->code, &old, sizeof(old)))
> +               if (memcmp(code, &old, sizeof(old)))
>                         jump_label_bug(entry, &old, &new);
>         }
> -       s390_kernel_write((void *)entry->code, &new, sizeof(new));
> +       s390_kernel_write(code, &new, sizeof(new));
>  }
>
>  static int __sm_arch_jump_label_transform(void *data)
> --
> 2.16.4
>
