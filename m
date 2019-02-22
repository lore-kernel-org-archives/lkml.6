Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76356C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4481B20663
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1WPsh8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfBVXM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:12:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37314 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfBVXM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:12:26 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so3309817otp.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmDN9X/UEjCpZcgMNiozJuCrFz7Y2Sx2GWMobE40puc=;
        b=i1WPsh8/eSfOd3jLSd+Hkqkpp9cKP16/WqbUrEkH0rd9CBLUnQI8RGI18kbJKfcutS
         pyXX4xyPwb3K0O8QS0HE+DSbVvkXcF4s2ahIeUAiugJ9R/AXpG0Mit2uHPKf03+6FEDr
         7ptTSA/DybTt6tClC0VLxCgLGxCZLqlDJlewbol0uJfZ+2/4DambWq7MlnG3r3SGM3Xf
         xnHVpEwW80rDzyATJzD3NEGS/2CByGmadtnJxv9A+r7uHdIxKtvYzZZrt6cqh7yCVnwn
         LwMzYXtnuIcXsvUFacWau0M8BvpO1jNOKpgV6azmvCHUQBPjoSSuxbqaUiHdn/f+bn1h
         TuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmDN9X/UEjCpZcgMNiozJuCrFz7Y2Sx2GWMobE40puc=;
        b=ie6L7U+UGYu+CODll1G93bepTCjQ8rphLYTFEv2bh8qFEwfBcQ73vb2HLpc5u8Yvt2
         nywE6ZRMW+NMtaT1QwBGsjDOanrF7NJw8Qm/P4sCZwML98A/FL3vT2aaWGmTGnxLmT09
         LWoqXYl4IEn2HUX/8aNg9qvIWWyHNjvTVSeTIkmIa1Hu7n0vSGhQHODzSqkYfzeng2zZ
         vazJG/3/j/PXAWxfsrEpVg3ip3G90X5xkPhap95vHHvDni6XJ8DexKR7lnljoU0Spw0z
         OBfET2BvKZQobsNew5oPEOiROHShHG1NKHRZqfcawCR4YSOCIDWhK8zmfUosZWMqbnTN
         hV4g==
X-Gm-Message-State: AHQUAuYM7kQlJt2wTkNP885UgevmxZJyE9czRDJMHC455BYf/VT7pkVi
        5jZwwraLYyPnC2s05K4w7+gMlYpvpFtDkyJ8VLdV0Q==
X-Google-Smtp-Source: AHgI3IbwjQUw0c2RZAhMxGBbRYag5OkEWPuPo7BDKTLf65I/1x4SufQv3nAEEQYNeog/h/R+xnl8QFzJc88qV9BgUFw=
X-Received: by 2002:a9d:66d0:: with SMTP id t16mr4257261otm.35.1550877145204;
 Fri, 22 Feb 2019 15:12:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net> <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 23 Feb 2019 00:11:58 +0100
Message-ID: <CAG48ez0nMEMP5-eSFWmLKs30zApgZ57zqU1Od9cROBYQvoJxsg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:51 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 22, 2019 at 01:59:10PM -0800, Linus Torvalds wrote:
> > On Fri, Feb 22, 2019 at 1:38 PM David Miller <davem@davemloft.net> wrote:
> > >
> > > Don't be surprised if we see more separation like this in the future too.
> >
> > Yes, with the whole meltdown fiasco, there's actually more pressure to
> > add more support for separation of kernel/user address spaces. As Andy
> > pointed out, it's been discussed as a future wish-list for x86-64 too.
> >
> > But yeah, right now the *common* architectures all distinguish kernel
> > and user space by pointers (ie x86-64, arm64 and powerpc).
>
> That's all fine. I'm missing rationale for making probe_kernel_read()
> fail on user addresses.
> What is fundamentally wrong with a function probe_any_address_read() ?

I think what Linus is saying is: There are some scenarios (like a
system with the old 4G/4G X86 patch) where *the same* address can
refer to two different pieces of memory, depending on whether you
interpret it as a kernel pointer or a user pointer. So for example, if
your BPF program tries to read tsk->comm, it works, but if the BPF
program then tries to read from PT_REGS_PARM2(ctx), it's going to
actually interpret the userspace address as a kernel address and read
completely different memory.

On top of that, from the security angle, this means that if a user
passes a kernel pointer into a syscall, they can trick a tracing BPF
program into looking at random kernel memory instead of the user's
memory. That may or may not be problematic, depending on what you do
afterwards with the data you've read. (For example, if this is a
service that collects performance data and then saves it to some
world-readable location on disk because the data it is collecting
(including comm strings) isn't supposed to be sensitive, you might
have a problem.)

> For context, typical bpf kprobe program looks like this:
> #define probe_read(P) \
>     ({typeof(P) val = 0; bpf_probe_read(&val, sizeof(val), &P); val;})
> SEC("kprobe/__set_task_comm")
> int bpf_prog(struct pt_regs *ctx)
> {
>     struct signal_struct *signal;
>     struct task_struct *tsk;
>     char oldcomm[16] = {};
>     char newcomm[16] = {};
>     u16 oom_score_adj;
>     u32 pid;
>
>     tsk = (void *)PT_REGS_PARM1(ctx);
>     pid = probe_read(tsk->pid);
>     bpf_probe_read(oldcomm, sizeof(oldcomm), &tsk->comm);
>     bpf_probe_read(newcomm, sizeof(newcomm), (void *)PT_REGS_PARM2(ctx));
>     signal = probe_read(tsk->signal);
>     oom_score_adj = probe_read(signal->oom_score_adj);
>     ...
> }
>
> where PT_REGS_PARMx macros are defined per architecture.
> On x86 it's #define PT_REGS_PARM1(x) ((x)->di)
>
> The program writer has to know the meaning of function arguments.
> In this example they need to know that __set_task_comm is defined as
> void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec) in the kernel.
>
> Right now these programs just call bpf_probe_read() on whatever data
> they need to access and not differentiating whether it's user or kernel.
>
> One idea we discussed is to split bpf_probe_read() into kernel_read and user_read
> helpers, but in the BPF verifier we cannot determine which address space
> the program wants to access. The prog writer needs to manually analyze the program
> to use correct one. But mistakes are possible and cannot be fatal.
> On the kernel side we have to be safe.
> Both probe_kernel_read and probe_user_read must not panic if a pointer
> from wrong address space was passed.
>
> Hence my preference is to keep probe_kernel_read as "try read any address".
> The function can be renamed to indicate so.
>
