Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769752086A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9i7zkbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769752086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeH2RxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:53:04 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36379 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbeH2RxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:53:03 -0400
Received: by mail-oi0-f68.google.com with SMTP id r69-v6so9269093oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JfmlXV7r32WPXiqljgmMJihDrqoRAg0etIOFnh21hV8=;
        b=V9i7zkbo8PRnn4DcPamiaM9VjO1mZHWB25Xn6CGD3J47pvxegl4c5u6ycVXCdJcwyg
         TRnHmkJdkXvL/CHl4TRz9LW20ke3lYtPtTFwqFtasNna05bcddulzx88FZBPCBFeBF4o
         Sj1zZFN40gfemHzj/Lny1aDA/uEbrBajklXK2veSusCbIUnqXDto0lfyAbAsESOomK2i
         3zbB4ZlLgHGc0emaSMabDx4Bx7r0LdbNAGbnnudYoVxG+jPnNny+XyQTZkGD/nP3g/28
         TVtseyihyH53p+BUAmioG4b+8CiH60h9/TF+l2szRie4UfxnVX302N8W69OQ6YudNesO
         g8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JfmlXV7r32WPXiqljgmMJihDrqoRAg0etIOFnh21hV8=;
        b=XRiRMlBK335WOB4lkYL8FJFTYTEAvBfM7yiF9UD3sQTEUBmSCbToeBfUyjDPH1hf9r
         TxSCaOLftLKCNkoZh4y4B7A+GH4BejkQ6odL3QN04H46G3qUKgr+gM8TOboBrmiR8c7U
         1/58XPXlj2VZXtZ58+1NEIXmYSfh9dTMFw50/fEwfnFL6kZm/O67kOimglbzxN/bX8jj
         UkIXDuM55zfwAgK98fdCa1QfhXKjym7eWwvLYj59keQ9rCUS0yPS8ADUTQHvlpUQDJm8
         Xwt7gE6aCYYY5Yc6VxZmjLBEb3kUP45CGV33Te2ic21qriyIhIGZlbHyvs2YbjVpt6Hl
         9Mpg==
X-Gm-Message-State: APzg51BfaND58AL54fIwQNptUvxJ1aB/eLZqAwxSswnEV+WR/zcuqa2P
        HTBA6Mpi2kzz/eWVgxdb1AcQ5dWvvcHqA/JL89AXYw==
X-Google-Smtp-Source: ANB0Vdas/SRpNCNRPTsrsjXtFVhBLZnI8NSIe2clrmLUTRvE7JlNE/9gGCX0LJoKAOsvchqpHevsLn+442wQuf2NBgg=
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr3005061oia.195.1535550959121;
 Wed, 29 Aug 2018 06:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154901.112726-1-jannh@google.com> <20180829071042.GB6337@nazgul.tnic>
In-Reply-To: <20180829071042.GB6337@nazgul.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 Aug 2018 15:55:32 +0200
Message-ID: <CAG48ez37HBh=0YfP=rLVGGEcFV0zJL_PLVgedFxDtyRgXHMROQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/dumpstack: don't dump kernel memory based on
 usermode RIP
To:     bp@suse.de
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:10 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Tue, Aug 28, 2018 at 05:49:01PM +0200, Jann Horn wrote:
> > show_opcodes() is used both for dumping kernel instructions and for dum=
ping
> > user instructions. If userspace causes #PF by jumping to a kernel addre=
ss,
> > show_opcodes() can be reached with regs->ip controlled by the user,
> > pointing to kernel code. Make sure that userspace can't trick us into
> > dumping kernel memory into dmesg.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7cccf0725cf7 ("x86/dumpstack: Add a show_ip() function")
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > v2: Andy pointed out that I probably shouldn't be doing wrapping
> > arithmetic on pointers.
> >
> >  arch/x86/include/asm/stacktrace.h |  2 +-
> >  arch/x86/kernel/dumpstack.c       | 13 ++++++++++---
> >  arch/x86/mm/fault.c               |  2 +-
> >  3 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/s=
tacktrace.h
> > index b6dc698f992a..f335aad404a4 100644
> > --- a/arch/x86/include/asm/stacktrace.h
> > +++ b/arch/x86/include/asm/stacktrace.h
> > @@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(vo=
id)
> >       return (unsigned long)frame;
> >  }
> >
> > -void show_opcodes(u8 *rip, const char *loglvl);
> > +void show_opcodes(struct pt_regs *regs, const char *loglvl);
> >  void show_ip(struct pt_regs *regs, const char *loglvl);
> >  #endif /* _ASM_X86_STACKTRACE_H */
> > diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> > index 9c8652974f8e..14b337582b6f 100644
> > --- a/arch/x86/kernel/dumpstack.c
> > +++ b/arch/x86/kernel/dumpstack.c
> > @@ -89,14 +89,21 @@ static void printk_stack_address(unsigned long addr=
ess, int reliable,
> >   * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a rand=
om
> >   * guesstimate in attempt to achieve all of the above.
> >   */
> > -void show_opcodes(u8 *rip, const char *loglvl)
> > +void show_opcodes(struct pt_regs *regs, const char *loglvl)
> >  {
> >  #define PROLOGUE_SIZE 42
> >  #define EPILOGUE_SIZE 21
> >  #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
> >       u8 opcodes[OPCODE_BUFSIZE];
> > +     u8 *prologue =3D (u8 *)(regs->ip - PROLOGUE_SIZE);
>
> Just a nitpick:
>
> <--- newline here.

The code below this point is still part of the declarations. Do you
want a newline here anyway? If you say yes, I'll adjust and resend.

> > +     /*
> > +      * Make sure userspace isn't trying to trick us into dumping kern=
el
> > +      * memory by pointing the userspace instruction pointer at it.
> > +      */
> > +     bool bad_ip =3D user_mode(regs) &&
> > +                   __range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_=
MAX);
>
> Other than that:
>
> Reviewed-by: Borislav Petkov <bp@suse.de>
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)
> --
