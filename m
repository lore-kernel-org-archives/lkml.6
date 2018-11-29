Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13F2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyhkU6yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13F2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeK3Gdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:33:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeK3Gdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:33:43 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09622214C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543519634;
        bh=vpOVOwhjT/kVoASKNPVKMME21MfJO3QsgQYtA9P5E+8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dyhkU6yuGDYU1Ly312kInMWQtDi9fQ4o0VAAHQm70gowM6Q8C5q4+I38VqhnC58PM
         wvuSin5UUw6h6y8ZzhUv/KS/z6cLRqYP4iKURsSG4NqibZvmpwM/6hdYSBZvRdKhKa
         eQJlr8H8hVgsJJu//j3ZhR/gUzeJ+pkK3B+oKQCI=
Received: by mail-wm1-f47.google.com with SMTP id 125so3491683wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:27:13 -0800 (PST)
X-Gm-Message-State: AA+aEWZZDpEHDRAsF7gNiiEd9BoDQ9d1LEs0mNEaRBFe23Ct+mDU8qRP
        UmqnF8ydq3aEGLnEv/5iR1gS3JEaLQEaQVZLTNZeBg==
X-Google-Smtp-Source: AFSGD/VUiEi9rm0TXXlVGKdAToF3j8g7aNLHhbOzc+HouYLVw8Fwq90yHsMFAN5XUSyRuIJrFNat5zCdBcwubnE76Uc=
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr2807372wme.108.1543519632362;
 Thu, 29 Nov 2018 11:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com>
 <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129121307.12393c57@gandalf.local.home>
 <CAHk-=wik5AfDs7qqjGHQ5vRBYkV8K6tFmPna3PdbwdzVwPGTsg@mail.gmail.com>
 <20181129124404.2fe55dd0@gandalf.local.home> <CAHk-=wgnZobye-KNaBVO-SdqX-5Xkz+i=aJ_kOFZ4RpZFT0HqQ@mail.gmail.com>
 <20181129125857.75c55b96@gandalf.local.home> <CAHk-=wigLUgxDM6Dq2aS7efduffratP976Ggmpv4Ev4EOrJxyA@mail.gmail.com>
 <20181129134725.6d86ade6@gandalf.local.home> <CAHk-=wgbnQs4fpuHqT1jLkDnKcvTGS5EN8m=qy7oUE5n_fhOig@mail.gmail.com>
 <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjN=sow0F-UtA6DtHHT_CNUV7wYVe3cQ4E8GPp4LN32+Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 29 Nov 2018 11:27:00 -0800
X-Gmail-Original-Message-ID: <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
Message-ID: <CALCETrVzFk2Yv8q54Xh6qOb45AKKrQhD5OkAuTsw9HaR3Wvy4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>, julia@ni.com, jeyu@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Nov 29, 2018 at 10:58 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > In contrast, if the call was wrapped in an inline asm, we'd *know* the
> > compiler couldn't turn a "call wrapper(%rip)" into anything else.
>
> Actually, I think I have a better model - if the caller is done with inline asm.
>
> What you can do then is basically add a single-byte prefix to the
> "call" instruction that does nothing (say, cs override), and then
> replace *that* with a 'int3' instruction.
>
> Boom. Done.
>
> Now, the "int3" handler can just update the instruction in-place, but
> leave the "int3" in place, and then return to the next instruction
> byte (which is just the normal branch instruction without the prefix
> byte).
>
> The cross-CPU case continues to work, because the 'int3' remains in
> place until after the IPI.

Hmm, cute.  But then the calls are in inline asm, which results in
giant turds like we have for the pvop vcalls.  And, if they start
being used more generally, we potentially have ABI issues where the
calling convention isn't quite what the asm expects, and we explode.

I propose a different solution:

As in this patch set, we have a direct and an indirect version.  The
indirect version remains exactly the same as in this patch set.  The
direct version just only does the patching when all seems well: the
call instruction needs to be 0xe8, and we only do it when the thing
doesn't cross a cache line.  Does that work?  In the rare case where
the compiler generates something other than 0xe8 or crosses a cache
line, then the thing just remains as a call to the out of line jmp
trampoline.  Does that seem reasonable?  It's a very minor change to
the patch set.

Alternatively, we could actually emulate call instructions like this:

void __noreturn jump_to_kernel_pt_regs(struct pt_regs *regs, ...)
{
  struct pt_regs ptregs_copy = *regs;
  barrier();
  *(unsigned long *)(regs->sp - 8) = whatever;  /* may clobber old
regs, but so what? */
  asm volatile ("jmp return_to_alternate_ptregs");
}

where return_to_alternate_ptregs points rsp to the ptregs and goes
through the normal return path.  It's ugly, but we could have a test
case for it, and it should work fine.
