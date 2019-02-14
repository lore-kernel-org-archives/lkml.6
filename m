Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47528C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12ED92077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyM3e1Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfBNQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:18:14 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39418 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfBNQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:18:14 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so2860252iti.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TlrUo1nz8e5UjEpq94TBOhHzkFofvLch+Eitz9P/X5I=;
        b=qyM3e1Y2NMp9HyAxWyqJlw9SXaIfg+J4UanPqcCWH+9vEXkTi2WJgOA2Iiw6lzdl1V
         WrP27pkxz11JHMRSpOoCZ1/IjqPwJrTfWRJXbkaBzMt6+M7/O8YcKuf22nDUsbngwzzu
         luOFWnLux/m3iRDYKaCulWfqtv9y/o+AOmk379cYEaOV/KwoVnqxlSH1GM652nB6dRFd
         9OPcy4j+YW+fLnbh1l4pOrvy+Rm3tuvRTHm6dZNPsjQwY/ozyss1WfALHyQd4yEMeNdy
         4ka6aIT6hV7+pmX6WgEvH3GzAXw9jcYXYdY4DoBWqVamfIGRLpoaNR4ANtYynLnDwpRB
         QV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TlrUo1nz8e5UjEpq94TBOhHzkFofvLch+Eitz9P/X5I=;
        b=QsLIaqCqKU+LorynLxsokweOfgPVQahN+AF5a5mNyDb0EFA4TvnMUW7bDlwnPhtRLm
         SpcDOn6HOD/yStK6uDCgtk0Q6qYlsoEkVJzDkFscsjJpP11Nds+OpaSNeGyWqvZpTyp3
         ZHPXqFdz0zQUeYaxmDm90m/9qTfwwJ0C3ONAHQh7Nz67OhgZX0rEhCdRa/uDEcIPiYZJ
         lgabQI2CUGtzIUEWqDv9YPlc7LtL6roOIkwtsVVE+gYo0pp36e2w+2i2PnGlF74ll8JE
         jWc2Nf/OImFxJPOjLhBsujPYMyS0fVVV25vrH1111SPZZEcpEDvKG0rt8gv9p1lKMIBc
         fiDw==
X-Gm-Message-State: AHQUAuYKh4gSxbIvIySCBVjjlw70T09qymGpGcIbAqGdEvAjtuz3qOvb
        EEpaWM8nP/+1LbTUcQCmcWwSuakWleIp3s63Gw==
X-Google-Smtp-Source: AHgI3IaI3t2OpJb1Us8EHtDJzIQE6azZFuSiFBRGFYvHqGWr/GB8pA9bvL1pwN3seKIIl00V+5bONrK0RbUeUwNUNUA=
X-Received: by 2002:a24:3953:: with SMTP id l80mr2663005ita.108.1550161092706;
 Thu, 14 Feb 2019 08:18:12 -0800 (PST)
MIME-Version: 1.0
References: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com> <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 14 Feb 2019 11:18:01 -0500
Message-ID: <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 5:14 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Wed, Feb 13, 2019 at 02:49:47PM -0800, Andy Lutomirski wrote:
>
> > Do we need to backport this thing?
>
> Possibly, just to be safe.
>
> > The problem can=E2=80=99t be too widespread or we would have heard of i=
t before.
>
> Yes, so far we've been lucky.
>
> ---
> Subject: sched/x86: Save [ER]FLAGS on context switch
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Feb 14 10:30:52 CET 2019
>
> Effectively revert commit:
>
>   2c7577a75837 ("sched/x86_64: Don't save flags on context switch")
>
> Specifically because SMAP uses FLAGS.AC which invalidates the claim
> that the kernel has clean flags.
>
> In particular; while preemption from interrupt return is fine (the
> IRET frame on the exception stack contains FLAGS) it breaks any code
> that does synchonous scheduling, including preempt_enable().
>
> This has become a significant issue ever since commit:
>
>   5b24a7a2aa20 ("Add 'unsafe' user access functions for batched accesses"=
)
>
> provided for means of having 'normal' C code between STAC / CLAC,
> exposing the FLAGS.AC state. So far this hasn't led to trouble,
> however fix it before it comes apart.
>
> Fixes: 5b24a7a2aa20 ("Add 'unsafe' user access functions for batched acce=
sses")
> Acked-by: Andy Lutomirski <luto@amacapital.net>
> Reported-by: Julien Thierry <julien.thierry@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_32.S        |    2 ++
>  arch/x86/entry/entry_64.S        |    2 ++
>  arch/x86/include/asm/switch_to.h |    1 +
>  3 files changed, 5 insertions(+)
>
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -650,6 +650,7 @@ ENTRY(__switch_to_asm)
>         pushl   %ebx
>         pushl   %edi
>         pushl   %esi
> +       pushfl
>
>         /* switch stack */
>         movl    %esp, TASK_threadsp(%eax)
> @@ -672,6 +673,7 @@ ENTRY(__switch_to_asm)
>  #endif
>
>         /* restore callee-saved registers */
> +       popfl
>         popl    %esi
>         popl    %edi
>         popl    %ebx
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -291,6 +291,7 @@ ENTRY(__switch_to_asm)
>         pushq   %r13
>         pushq   %r14
>         pushq   %r15
> +       pushfq
>
>         /* switch stack */
>         movq    %rsp, TASK_threadsp(%rdi)
> @@ -313,6 +314,7 @@ ENTRY(__switch_to_asm)
>  #endif
>
>         /* restore callee-saved registers */
> +       popfq
>         popq    %r15
>         popq    %r14
>         popq    %r13
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -40,6 +40,7 @@ asmlinkage void ret_from_fork(void);
>   * order of the fields must match the code in __switch_to_asm().
>   */
>  struct inactive_task_frame {
> +       unsigned long flags;
>  #ifdef CONFIG_X86_64
>         unsigned long r15;
>         unsigned long r14;

flags should be initialized in copy_thread_tls().  I think the new
stack is zeroed already, but it would be better to explicitly set it.

--
Brian Gerst
