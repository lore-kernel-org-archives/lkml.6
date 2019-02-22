Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9022075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550879741;
	bh=17mG8B8lMHG5wfQsv/g1N0tTizuAj4ppTtNUCXlyCk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2XgaKCsP5xD5YHJMJnon2GlN/TRhieUYtOSjp0sIKkCz2RJ07DC7q9CyqG8jRypdR
	 h/ZUT+9Tf+armGBE4rb/7hvgfzBDC2zzWcPgrmg98kdUw4TMG/jmviYagBV2fPolCH
	 +lEkvDuirJXruaSca2HDQhdxwNCvsullYxK9ofxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBVXzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVXzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:55:39 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE603208E4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550879739;
        bh=17mG8B8lMHG5wfQsv/g1N0tTizuAj4ppTtNUCXlyCk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iQdqgB4BLleP6EAaIiJ72KMnEz35gwGkAmwiW43Y1Pnoo0KoXI3CxYkdei9/aFu/7
         mde8mEBkYTlblMS0BW59VUhqTth4KpmVLX1jFTX24BRI/cObRPg/v2hkZmm3Ikw+iD
         J1iHUpWDevAL3X78aB/+9QEowS3/004thCj0bDtc=
Received: by mail-wr1-f50.google.com with SMTP id w6so841248wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:55:38 -0800 (PST)
X-Gm-Message-State: AHQUAubH+mNf2k3SbhITpYrMmTx3SlhUHKAriWN/xH1ADorCUtsIpQV5
        Vb31BOke+nStLkI+lNjItGeSj3GZhAoexTkGr+2L6w==
X-Google-Smtp-Source: AHgI3Ib0CVIzhDnShAg0pz7M8k6P8KKBcQ9vQpJz+0avB23uRG3JQ06jBt1Y/4c3dqcHimd7PnhigfylGtd89yvYuaE=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr4445431wrv.199.1550879737087;
 Fri, 22 Feb 2019 15:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net> <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net> <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com> <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de> <20190222222635.GK14054@worktop.programming.kicks-ass.net>
In-Reply-To: <20190222222635.GK14054@worktop.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Feb 2019 15:55:25 -0800
X-Gmail-Original-Message-ID: <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
Message-ID: <CALCETrV0XAv_tuw3WzQG+dx0iKEahw9V6DLACq4PtNQrkJBwhw@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 2:26 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 22, 2019 at 07:10:34PM +0100, Thomas Gleixner wrote:
>
> > But correct :)
>
> > I agree, that a function which is doing the actual copy should be callable,
> > but random other functions? NO!
>
> So find the below patch -- which spotted fail in ptrace.c
>
> It has an AC_SAFE(func) annotation which allows marking specific
> functions as safe to call. The patch includes 2 instances which were
> required to make arch/x86 'build':
>
>   arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_restore_sigcontext()+0x3d: call to native_load_gs_index() with AC set
>   arch/x86/kernel/ptrace.o: warning: objtool: genregs_get()+0x8e: call to getreg() with AC set
>
> It also screams (provided one has CONFIG_FUNCTION_TRACE=y) about the
> lack of notrace annotations on functions marked AC_SAFE():
>
>   arch/x86/kernel/ptrace.o: warning: objtool: getreg()+0x0: call to __fentry__() with AC set
>
> It builds arch/x86 relatively clean; it only complains about some
> redundant CLACs in entry_64.S because it doesn't understand interrupts
> and I've not bothered creating an annotation for them yet.
>
>   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x4d: redundant CLAC
>   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x5a: redundant CLAC
>   ...
>   arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xb1: redundant CLAC

Does objtool understand altinstr?  If it understands that this is an
altinstr associated with a not-actually-a-fuction (i.e. END not
ENDPROC) piece of code, it could suppress this warning.

>
> -static unsigned long getreg(struct task_struct *task, unsigned long offset)
> +static notrace unsigned long getreg(struct task_struct *task, unsigned long offset)
>  {
>         switch (offset) {
>         case offsetof(struct user_regs_struct, cs):
> @@ -444,6 +444,7 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
>
>         return *pt_regs_access(task_pt_regs(task), offset);
>  }
> +AC_SAFE(getreg);

This takes the address and could plausibly suppress some optimizations.

>
> +#if defined(CONFIG_STACK_VALIDATION) && !defined(BUILD_VDSO) && !defined(BUILD_VDSO32)
> +/*
> + * This macro marks functions as AC-safe, that is, it is safe to call from an
> + * EFLAGS.AC enabled region (typically user_access_begin() /
> + * user_access_end()).
> + *
> + * These functions in turn will only call AC-safe functions themselves (which
> + * precludes tracing, including __fentry__ and scheduling, including
> + * preempt_enable).
> + *
> + * AC-safe functions will obviously also not change EFLAGS.AC themselves.
> + *
> + * Since STAC/CLAC are OPL-0 only, this is all irrelevant for VDSO builds
> + * (and the generated symbol reference will in fact cause link failures).
> + */
> +#define AC_SAFE(func) \
> +       static void __used __section(.discard.ac_safe) \
> +               *__func_ac_safe_##func = func

Are we okay with annotating function *declarations* in a way that
their addresses get taken whenever the declaration is processed?  It
would be nice if we could avoid this.

I'm wondering if we can just change the code that does getreg() and
load_gs_index() so it doesn't do it with AC set.  Also, what about
paravirt kernels?  They'll call into PV code for load_gs_index() with
AC set.

--Andy
