Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E13C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C4720838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1HrU0KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C4720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbeLFKb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:31:59 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44910 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeLFKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:31:56 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so19241206iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 02:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjA60Ta70B0BdffOxwLfM6fA5laqa+qcnZ7JQd20IsE=;
        b=k1HrU0KSEVnr9c1TqhF36VcNxLHh3i8j8MK1D8HFHqd7xVR8V/Eni9IWlGvZjptFwQ
         x035l63fXncSWvOHa1z8Skf3jP60uEjV0WtpVh4VicCsuf5NvYYki80r+UKnfkMoqnc+
         /b8TNUjzp/kHjvxAXUl9lrkk9aniDQcMAeZX4yU8GCAlgllhHXgBl7EphuZXsJUHSDKg
         KV1zrOBHERkYxjAEuk/W/ZIPnTfc+n1pKMzapVxEjyWlJOOOo8tUXTFBkvrp6xU46VT3
         LLHauH2FiLuid+CfBIs3heWHRA2NeYspmhyGtVd6rtU55S4OTgZXKlcdByg0wNhdCjP+
         zz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjA60Ta70B0BdffOxwLfM6fA5laqa+qcnZ7JQd20IsE=;
        b=FZ4jvbjzbgVhzKOXICtVsTo/IkSAKpMkzbcj2UJLIXRVWKR+ZDZZVyi0Z5VExuN/Hj
         FMImSP0xJjVOYuq0nTK4+hmcO+2Nb1AmiJUrdGCd1FELT8bPYFOoIl74Ipeqee0VpC2U
         UO49PWAFBRfBz9JspusF4eFHt6KZQ+adJyvM9VYcL95wSb0EycgxBui3F/M+mClnJbk9
         HTmNIKDuroliImJjia2uOZhKOWoE4q86lN/gDsmPlA1DlwlCFhSH/Aw5Qik0ncH5hvWV
         LlESy1/W81pRtMovuvAulqT5AX/gwgT8khPNMc8viilgvEXZTbymcZ6vszbWEY2EgMBS
         6qDA==
X-Gm-Message-State: AA+aEWYhdTjuPlSN6PybfPWJL199SwP9a+WUzmVupjTg6oqMwHmhR/KI
        BK9/49HSFN28rfZN7HZ/rtAKLhjJunafbcZSYoJm7Q==
X-Google-Smtp-Source: AFSGD/X7kjfiGvPtE1+7cYM3wjPmz7gw1yXVn9ww++aMKruyZOq1Xt/6CmcltuxQFQaHf18t717zniivb+ebW5sMfCI=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr25725066ior.31.1544092314966;
 Thu, 06 Dec 2018 02:31:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com> <e825441eda1dbbbb7f583f826a66c94e6f88316a.1543337629.git.andreyknvl@google.com>
 <20181129180138.GB4318@arm.com>
In-Reply-To: <20181129180138.GB4318@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Dec 2018 11:31:43 +0100
Message-ID: <CAAeHK+zVzWJ7RBsX88SOsebq0a40ypuawYFd4w4woFSHuximOw@mail.gmail.com>
Subject: Re: [PATCH v12 20/25] kasan, arm64: add brk handler for inline instrumentation
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:01 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Nov 27, 2018 at 05:55:38PM +0100, Andrey Konovalov wrote:
> > Tag-based KASAN inline instrumentation mode (which embeds checks of shadow
> > memory into the generated code, instead of inserting a callback) generates
> > a brk instruction when a tag mismatch is detected.
> >
> > This commit adds a tag-based KASAN specific brk handler, that decodes the
> > immediate value passed to the brk instructions (to extract information
> > about the memory access that triggered the mismatch), reads the register
> > values (x0 contains the guilty address) and reports the bug.
> >
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  arch/arm64/include/asm/brk-imm.h |  2 +
> >  arch/arm64/kernel/traps.c        | 68 +++++++++++++++++++++++++++++++-
> >  include/linux/kasan.h            |  3 ++
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> > index ed693c5bcec0..2945fe6cd863 100644
> > --- a/arch/arm64/include/asm/brk-imm.h
> > +++ b/arch/arm64/include/asm/brk-imm.h
> > @@ -16,10 +16,12 @@
> >   * 0x400: for dynamic BRK instruction
> >   * 0x401: for compile time BRK instruction
> >   * 0x800: kernel-mode BUG() and WARN() traps
> > + * 0x9xx: tag-based KASAN trap (allowed values 0x900 - 0x9ff)
> >   */
> >  #define FAULT_BRK_IMM                        0x100
> >  #define KGDB_DYN_DBG_BRK_IMM         0x400
> >  #define KGDB_COMPILED_DBG_BRK_IMM    0x401
> >  #define BUG_BRK_IMM                  0x800
> > +#define KASAN_BRK_IMM                        0x900
> >
> >  #endif
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 5f4d9acb32f5..04bdc53716ef 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/sizes.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/mm_types.h>
> > +#include <linux/kasan.h>
> >
> >  #include <asm/atomic.h>
> >  #include <asm/bug.h>
> > @@ -284,10 +285,14 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
> >       }
> >  }
> >
> > -void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > +void __arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> >  {
> >       regs->pc += size;
> > +}
> >
> > +void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> > +{
> > +     __arm64_skip_faulting_instruction(regs, size);
> >       /*
> >        * If we were single stepping, we want to get the step exception after
> >        * we return from the trap.
> > @@ -959,7 +964,7 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
> >       }
> >
> >       /* If thread survives, skip over the BUG instruction and continue: */
> > -     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > +     __arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
>
> Why do you want to avoid the single-step logic here? Given that we're
> skipping over the brk instruction, why wouldn't you want that to trigger
> a step exception if single-step is enabled?

I was asked to do that, see the discussion here:

https://www.spinics.net/lists/linux-mm/msg146575.html
https://www.spinics.net/lists/linux-mm/msg148215.html
https://www.spinics.net/lists/linux-mm/msg148367.html
