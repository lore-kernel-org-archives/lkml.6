Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DCFC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBBA20645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6Cu4Y/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBVWvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:51:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46169 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBVWvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:51:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so1695089pls.13;
        Fri, 22 Feb 2019 14:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wmo65VbS89VbjwxnUULYPLkRsueB7VFUWxbW+f0j3aM=;
        b=r6Cu4Y/Eazz0yz9OHQ2dY+2h0mKkquzvcENIykheMnsckgc7JKMMv6UmsmM2xJz49B
         QnjwvQqp5ltRsG8xroCLTT3L4nGkiPLIjLbzovNvziVepRD4eiEE/TzdQl2w5lUylMu2
         he3fWRhhDIwtT687yz0eaJ072wu3CIEGpVHnTm1ZBwJlT8Uenv9bEpy6acURkjkJ/AtP
         KP9WY7ukzk3v6kZYCfscyiVSxivIkDZLVIlrPVTPJlw/Li8JXQn7hU1xWgBkyVPMmozb
         0L/9akyS7bkyD6VAKZTeR3sx/zql8PfA1Wb0z4yEfFmz3WkFYazv4m5lBKKS7idA5/Cx
         tOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wmo65VbS89VbjwxnUULYPLkRsueB7VFUWxbW+f0j3aM=;
        b=nwcciyZOj77bYkQYD5tEcNeybHPiDszZvZxxwKYTrZfrCqPXIDO8iVwoemPCwMcLj+
         Hkguwg98c39+P8ozSpGHGAi4qNdLWAyFoI43J4AfCyHu5LN4c9bRsR97nTyW2SaSnqEb
         0VvgasSWHIPgqvb9mzUBWz5Euam9p+e5uRXXfEx1cJxHwi7mHIQO4bz9WHld7sNM6g8I
         8eKw5uV9FM78VN8CUHRmDW6hreVNJRqQaSBZT4uIrDXayQ4PH735vHS4xI38d3lSCeG2
         JmgnIVs4hECTNpIZ0lNRhiTURnPaQoGUNKxSXVL1Km0me0jyIfZBmzOP+0AknwcMAa1q
         /NSQ==
X-Gm-Message-State: AHQUAuYrI+bVEosN24eB0SwPAwJP8t7F4/T3Rist+dNpjrRH75Thk/1x
        MVzM+ixT+KDC3iXFIkfZwf8=
X-Google-Smtp-Source: AHgI3IbS71oMPdCT3hoeobuoQrN3skeTqGiuwfFzDkPMOtRm5ICM6EcLxjU1cAth7geruCKCypUwKA==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr6485433pld.258.1550875867792;
        Fri, 22 Feb 2019 14:51:07 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id s12sm3346099pfm.120.2019.02.22.14.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:51:06 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:51:04 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net>
 <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 01:59:10PM -0800, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 1:38 PM David Miller <davem@davemloft.net> wrote:
> >
> > Don't be surprised if we see more separation like this in the future too.
> 
> Yes, with the whole meltdown fiasco, there's actually more pressure to
> add more support for separation of kernel/user address spaces. As Andy
> pointed out, it's been discussed as a future wish-list for x86-64 too.
> 
> But yeah, right now the *common* architectures all distinguish kernel
> and user space by pointers (ie x86-64, arm64 and powerpc).

That's all fine. I'm missing rationale for making probe_kernel_read()
fail on user addresses.
What is fundamentally wrong with a function probe_any_address_read() ?

For context, typical bpf kprobe program looks like this:
#define probe_read(P) \
    ({typeof(P) val = 0; bpf_probe_read(&val, sizeof(val), &P); val;})
SEC("kprobe/__set_task_comm")
int bpf_prog(struct pt_regs *ctx)
{
    struct signal_struct *signal;
    struct task_struct *tsk;
    char oldcomm[16] = {};
    char newcomm[16] = {};
    u16 oom_score_adj;
    u32 pid;

    tsk = (void *)PT_REGS_PARM1(ctx);
    pid = probe_read(tsk->pid);
    bpf_probe_read(oldcomm, sizeof(oldcomm), &tsk->comm);
    bpf_probe_read(newcomm, sizeof(newcomm), (void *)PT_REGS_PARM2(ctx));
    signal = probe_read(tsk->signal);
    oom_score_adj = probe_read(signal->oom_score_adj);
    ...
}

where PT_REGS_PARMx macros are defined per architecture.
On x86 it's #define PT_REGS_PARM1(x) ((x)->di)

The program writer has to know the meaning of function arguments.
In this example they need to know that __set_task_comm is defined as
void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec) in the kernel.

Right now these programs just call bpf_probe_read() on whatever data
they need to access and not differentiating whether it's user or kernel.

One idea we discussed is to split bpf_probe_read() into kernel_read and user_read
helpers, but in the BPF verifier we cannot determine which address space
the program wants to access. The prog writer needs to manually analyze the program
to use correct one. But mistakes are possible and cannot be fatal.
On the kernel side we have to be safe.
Both probe_kernel_read and probe_user_read must not panic if a pointer
from wrong address space was passed.

Hence my preference is to keep probe_kernel_read as "try read any address".
The function can be renamed to indicate so.

