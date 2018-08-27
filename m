Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953A3208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FX/YVmD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953A3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH0XKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:10:43 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38674 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0XKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:10:42 -0400
Received: by mail-oi0-f65.google.com with SMTP id x197-v6so169118oix.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2ahqzoEJ50pToHQv3UOg8VdlhaO9pPIx0D3UNF8sLQ=;
        b=FX/YVmD3Y/j7rhnDWs6ZsSUiWpp4BpUlsmQiJCcW0SDEjCdUXHIBs0xQJHSpsWCnSp
         v2rCfU+KwIy0XFhJqPXZoWYjvZc8Q7Ool+sbU7D28I8VAwxxF9j8DJUGNV8EEKpLCWZp
         E8tBixzb5i4Zwo/cwbneoJfoikXSSW9fgTqeEoV67oihWQHe7pJFgxHjNxBvFysA6qBX
         hOcOecIsw4+QMD6YI9UvaJ4iLzauKx2T3+pY9Eb5fhtm+BUIwkU5SFVBKilr908ogQ0/
         Ogbm70RXA/dtynkzVu4OAlH7ux1z/N7Re1Lms1VmvfIjU+npNNsdf4ocx305XQCfr3OX
         qQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2ahqzoEJ50pToHQv3UOg8VdlhaO9pPIx0D3UNF8sLQ=;
        b=NuEcyQZdJV7nv2Hci4Ha5QxuHpCRrw7+1Qxekca98EJw6M7HmP7P+GnkNYwEBATsVx
         v+nFb3LTR8mH/2o7mhQyZA2go0T8XTGyBqSWv1R9XeJp6fJv2+y992LYXE8kU4ZI8SAA
         8uO/9w0Ii/lSNn44lCL6FQ3uH25Wb9hGJ9lp6Q7Tsz7PpkQ6hlFZZlyHlVK6J6DS5Ymu
         qdG8a3dnQvc1SHYQHCKqTOMZd2H7iLBKAwxLQL++X58FuDq5qTFFur0JWRG8pqzWqR/O
         Hf5zh4hh5KXypCBeII4daGsgkPMQkz+W88IZQXL2FPlL9r1RLaLPsonzeorqwoStmTRX
         J3jA==
X-Gm-Message-State: APzg51CBYU5PKra6zevoAkzS+zuyNqRfce7CVK7+Xhan0hmaWGxKgKHv
        uTp8xSfI3qpAgBr/JhJNTMlA/jwvQVGfYBThQ6ySkA==
X-Google-Smtp-Source: ANB0VdZFDqpxksz42aXf2MYcBrZ0cK6pVRwMupbPoDwELlmjCfsgLhhqC9rzVv3ROXhVvVdr1sH4/kZH+txbXwQeWJo=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr13915592oia.229.1535397766293;
 Mon, 27 Aug 2018 12:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180827185631.163506-1-jannh@google.com> <20180827185631.163506-4-jannh@google.com>
 <CALCETrUeRA63Vt_LBOGmUHc_M9gc3J7+ewK6j+sB8P=9ijk7ag@mail.gmail.com>
In-Reply-To: <CALCETrUeRA63Vt_LBOGmUHc_M9gc3J7+ewK6j+sB8P=9ijk7ag@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Aug 2018 21:22:19 +0200
Message-ID: <CAG48ez0=-nDmQVQiJtD_6ingdWWVJE+y+5_oWQrggQ9Eqg-UKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] x86: stop calling fixup_exception() from kprobe_fault_handler()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        anil.s.keshavamurthy@intel.com,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        tony.luck@intel.com, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:02 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Aug 27, 2018 at 11:56 AM, Jann Horn <jannh@google.com> wrote:
> > This removes the call into exception fixup that was added in
> > commit c28f896634f2 ("[PATCH] kprobes: fix broken fault handling for
> > x86_64").
> >
> > On X86, kprobe_fault_handler() is called from two places:
> > do_general_protection() (for #GP) and kprobes_fault() (for #PF).
> > In both paths, the fixup_exception() call in the kprobe fault handler is
> > redundant.
> >
> > For #GP, fixup_exception() is called immediately before
> > kprobe_fault_handler() is invoked - if someone wanted to fix up our #GP,
> > they've already done so, no need to try again. (This assumes that the
> > kprobe's fault handler isn't going to do something crazy like changing RIP
> > so that it suddenly points to an instruction that does userspace access.)
>
> This needs review by someone who understands kprobes better than I do.
> What happens if someone puts a kprobe on a uaccess instruction and the
> uaccess subsequently faults?

Ugh, good point. I'll admit to not having thought about that properly.

I think that's the "if (unlikely(regs->ip == (unsigned
long)cur->ainsn.insn))" branch in kprobe_fault_handler(), which I'm
not touching.

For #PF, both without and with my patch, stuff should get fixed up by
the normal pagefault handler, since the fixup happens after the kprobe
handler has fiddled with the exception state.

For #GP, we're already past the fixup call, and I think both without
and with my patch, nothing will catch it - so I think that's a bug,
but I don't think it's one I'm introducing.

> > For #PF on a kernel address from kernel space, after the kprobe fault
> > handler has run, we'll go into no_context(), which calls fixup_exception().
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/kernel/kprobes/core.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 467ac22691b0..7315ac202aad 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -1021,13 +1021,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> >                 if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
> >                         return 1;
> >
> > -               /*
> > -                * In case the user-specified fault handler returned
> > -                * zero, try to fix up.
> > -                */
> > -               if (fixup_exception(regs, trapnr))
> > -                       return 1;
> > -
> >                 /* fixup routine could not handle it. */
> >         }
> >
> > --
> > 2.19.0.rc0.228.g281dcd1b4d0-goog
> >
