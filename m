Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1244D20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkiVK1GN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1244D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeH1UWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:22:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42526 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1UWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:22:38 -0400
Received: by mail-oi0-f67.google.com with SMTP id q204-v6so3918904oig.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJ3t1huZk69r9WLkN9FgxFXjM7P5Up6X9edVOpBmrYM=;
        b=RkiVK1GNYN98oe9M00BnstLV5hEqjHMpmT+iFewlyhgrWI0yrk0lu8YE+pNVb+vV3l
         MJqH2IvK9OCmAdnpRStHhkgsCRrgM5A8aSgqenF+Ua7GnN6yecjH3KS+00YA5NTDNurG
         p+5c65Hq5Y2Q+PWML6r6Kyb3H+6JlqqcVm8H+1kcAOnhRNAJ1Yk3wNqd947vFfgK2Mq5
         AyEPdbEQ7zT3Ll+WqeebX9+rU2H0iUpC9JAYdDHZx71NPbu5RQXEn/yh1ZdJ6QKWcv4i
         RMa2aFPRLMuxR2cQF+GSt8SE+KkJzaXtmmpoh2PtMulUBH6WvPfICC3zadA99L3iPQqM
         EjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJ3t1huZk69r9WLkN9FgxFXjM7P5Up6X9edVOpBmrYM=;
        b=q5ePILU3zwEyv5fCDAL5RE0aF3PWp9yY2Md6ky7UZLOGzqwEeODYCGltL4k2vV3vh1
         5qXCP/r9yyacQ5uTYXXHWQ52XXcouv8dgmcwPKL2Q5bSzYJnMsRbBiRGR4o16/sOr70z
         FBEcHbTekxtVXZdHbZerUn8kGlwLY+Wy+Lcfdihd7lTt2WkBgCbpBKy/OA9bQW5bm1Vz
         gu4OCaLkQPz670cxE+9uzBGZd8EAQEWuDThiE/TY82+fo//JaELHKKjS87yiVAXqrPUQ
         KhTNvaz26/tBFHX9NZSWYv6wTqSkKYfaoO+/v+S6WNP9BbndpKYDqoCUkqKVnVOOGXYu
         owzw==
X-Gm-Message-State: APzg51Aw9T7dEybh+KgHHuHyb5HgEsTQv4OVL7W7KZOGASQwuvBPRTbx
        UxCUoknEr5KkL7O20BhYYujuv3MY4a4xKyUUH7v2hQ==
X-Google-Smtp-Source: ANB0VdYNVrQ8ccGN2/Xur52stuEiO7hRIGV5z1cFXjyPyjc/8G6D4rXUTu36tUjaeSmJgWhxlu5X8ZfuZ4NcjvK6TEY=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr450441oif.348.1535473809621;
 Tue, 28 Aug 2018 09:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180828154901.112726-1-jannh@google.com> <20180828162551.GA4950@nazgul.tnic>
In-Reply-To: <20180828162551.GA4950@nazgul.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Aug 2018 18:29:43 +0200
Message-ID: <CAG48ez3N5wBUEDCDaSzWOWjs5rYrQ4QgNTYT=PmYmFQAcqfA-w@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 6:25 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Tue, Aug 28, 2018 at 05:49:01PM +0200, Jann Horn wrote:
> > show_opcodes() is used both for dumping kernel instructions and for dumping
> > user instructions. If userspace causes #PF by jumping to a kernel address,
> > show_opcodes() can be reached with regs->ip controlled by the user,
> > pointing to kernel code.
>
> Yap, and people keep asking how to dump the running kernel, after
> patching and jump labels and stuff... Here's how!
>
> :-))))
>
> > Make sure that userspace can't trick us into
> > dumping kernel memory into dmesg.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7cccf0725cf7 ("x86/dumpstack: Add a show_ip() function")
>
> I think this one is more likely:
>
>   ba54d856a9d8 ("x86/fault: Dump user opcode bytes on fatal faults")
>
> as it added the dumping of user opcode bytes.

No, you can also get user opcode bytes printed by WARN() and friends.
When you add a WARN() in the pagefault handler, you get something like
this. The first "Code:" line is from ba54d856a9d8, but the second one
further down is from before that.

[  125.564041] segfault[1602]: segfault at ffffffff854340c0 ip
ffffffff854340c0 sp 00007ffd4cc7a568 error 15
[  125.569923] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <63> 6f 72 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[  125.576859] ------------[ cut here ]------------
[  125.578406] TESTING WARN()
[  125.578439] WARNING: CPU: 6 PID: 1602 at arch/x86/mm/fault.c:894
__bad_area_nosemaphore+0x147/0x270
[  125.582172] Modules linked in: bpfilter
[  125.583394] CPU: 6 PID: 1602 Comm: segfault Tainted: G        W
    4.18.0+ #108
[  125.585811] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[  125.588410] RIP: 0010:__bad_area_nosemaphore+0x147/0x270
[  125.590078] Code: 48 89 d9 48 89 ea 44 89 e6 48 c7 83 30 0b 00 00
0e 00 00 00 bf 0b 00 00 00 e8 f5 eb ff ff 48 c7 c7 00 61 66 84 e8 79
11 05 00 <0f> 0b 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 83 c4
28 4c
[  125.595779] RSP: 0018:ffff8801cb3b7e18 EFLAGS: 00010286
[  125.597426] RAX: 0000000000000000 RBX: ffff8801cbb9e000 RCX: 0000000000000000
[  125.599605] RDX: 0000000000000001 RSI: dffffc0000000000 RDI: ffffffff86678ea0
[  125.601800] RBP: ffffffff854340c0 R08: ffffed003d873ed5 R09: ffffed003d873ed5
[  125.603935] R10: 0000000000000001 R11: ffffed003d873ed4 R12: 0000000000000001
[  125.606113] R13: 0000000000000000 R14: 0000000000000015 R15: ffff8801cb3b7f58
[  125.608250] FS:  00007fe30d518700(0000) GS:ffff8801ec380000(0000)
knlGS:0000000000000000
[  125.610608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.612331] CR2: ffffffff854340c0 CR3: 00000001d563e001 CR4: 00000000003606e0
[  125.614470] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  125.616607] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  125.618736] Call Trace:
[  125.619475]  __do_page_fault+0x133/0x780
[  125.620646]  ? mm_fault_error+0x1b0/0x1b0
[  125.622236]  ? async_page_fault+0x8/0x30
[  125.623388]  async_page_fault+0x1e/0x30
[  125.624526] RIP: 0033:core_pattern+0x0/0x880
[  125.625786] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <63> 6f 72 65 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00
[  125.631208] RSP: 002b:00007ffd4cc7a568 EFLAGS: 00010202
[  125.632737] RAX: ffffffff854340c0 RBX: 0000000000000000 RCX: 0000000000000000
[  125.635039] RDX: 00007ffd4cc7a678 RSI: 00007ffd4cc7a668 RDI: 0000000000000001
[  125.637088] RBP: 00007ffd4cc7a580 R08: 0000562d395106f0 R09: 00007fe30d323cb0
[  125.639153] R10: 0000000000000000 R11: 00007fe30d0d23c0 R12: 0000562d39510530
[  125.641183] R13: 00007ffd4cc7a660 R14: 0000000000000000 R15: 0000000000000000
[  125.643221] ---[ end trace fb20716f9d6369bd ]---

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
> > diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> > index b6dc698f992a..f335aad404a4 100644
> > --- a/arch/x86/include/asm/stacktrace.h
> > +++ b/arch/x86/include/asm/stacktrace.h
> > @@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
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
> > @@ -89,14 +89,21 @@ static void printk_stack_address(unsigned long address, int reliable,
> >   * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
> >   * guesstimate in attempt to achieve all of the above.
> >   */
> > -void show_opcodes(u8 *rip, const char *loglvl)
> > +void show_opcodes(struct pt_regs *regs, const char *loglvl)
> >  {
> >  #define PROLOGUE_SIZE 42
> >  #define EPILOGUE_SIZE 21
> >  #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
> >       u8 opcodes[OPCODE_BUFSIZE];
> > +     u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
> > +     /*
> > +      * Make sure userspace isn't trying to trick us into dumping kernel
> > +      * memory by pointing the userspace instruction pointer at it.
> > +      */
> > +     bool bad_ip = user_mode(regs) &&
> > +                   __range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
> >
>
> Ok, can we pls move the sole dumping of opcodes in a helper called,
> __show_opcodes(), for example, which the checking wrapper show_opcodes()
> - without the "__" prefix - calls?
>
> So that show_signal_msg() can call the checking variant - show_opcodes()
> - as userspace might be doing monkey business there and we definitely
> wanna check first but __show_regs() can call the non-checking variant
> __show_opcodes() because there we wanna dump whatever rIP points to
> because we wanna know if the machine has gone off into the weeds etc,
> when staring at splats.
>
> Or am I missing a security aspect here?

See above.

I'm checking for user_mode(regs), so as long as CS has a kernel
segment loaded, my patch shouldn't change anything, no matter where
RIP points.
