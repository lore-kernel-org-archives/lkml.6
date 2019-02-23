Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC1A206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 02:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq22NNsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBWC26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:28:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWC25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 21:28:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so1931217pgr.3;
        Fri, 22 Feb 2019 18:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsp+5vyCsszqSz61YLIUf6zbpzkwLpG+tTvW+vqfMFw=;
        b=Zq22NNsiTcSt0bHJJd5MAzg3ogVM1O3aiBQKdtVmxgRrABMhIb2zZqPR2CSCU3+MRk
         +M+DhZs3jgj3Ys6EZOz818vtIpDhZS8QwqNkro4DuB4WCBy1ouJoPDoZfpTYVgEwEbJN
         9sw5sFfMkf6o5FmpT99NtCmcvyA0ESHV/Mo2qbUGIZ5WZ935I9E3288tSVIplKbybGNy
         HG/d1f4dEPgmgO8VmtudWw+zjpSYDbOz5p5DIIc2bu/RBmTAUyGfsRtUtpkRC70Ugw4a
         I4a3ywWM+pphw+tU8h4ifZgUo1CxN5oeaBLE6wnsEBzlzTKwR6RXIcwCAvhDHtEQ9eVq
         MVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsp+5vyCsszqSz61YLIUf6zbpzkwLpG+tTvW+vqfMFw=;
        b=lZt8ThZi9Tl4TfV36Uem7x3TdkGkvnQkK0uT0022YUUqutR1nP1tIuKtR9dkj/Bvfm
         6R8DZIB0a0bVRNab/hyJsM+CYwIptWNzqvw2waismda+hMgIbD8tU+t8LSDI1jzFoHlr
         /RDmup+5TV+/yVkLDCI8QKvArSpzjliMoUySplY7QfXoj2EHfTSTJlwNeszV2WbhHenh
         eD2nLWrd1mK+2PDMaQbAgMrfWMBxlJOdXKtBc13KBiIsnsmHvFFqy2SNaADbrWQAUxAQ
         /K0K1fNrR4SHSSVGjvBCduqDPHNM8+x4LW32Ez2N0TakY+aYLzUlRBihzFDZZTTl9GvK
         WSCA==
X-Gm-Message-State: AHQUAuZ+ACGcJdViKsSy5PDe9rZI/dMh8tL+8Ty8hu/WucPyFV4SCeOn
        gV9Z4MQRsNL7xW8Aw90m5MA=
X-Google-Smtp-Source: AHgI3Ibe3f6AtyPwsMQLJRqV85oeQhs5X3KGclOS66tr6ciYypIyL3ESCbzkErgBjZ7gsBiMypGFxQ==
X-Received: by 2002:a63:2b03:: with SMTP id r3mr6668590pgr.1.1550888935978;
        Fri, 22 Feb 2019 18:28:55 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id q86sm7829233pfi.171.2019.02.22.18.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:28:55 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:28:53 -0800
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
Message-ID: <20190223022850.nv4hnweueetprbot@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net>
 <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
 <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whu_iwv4TQP5Xd62bTfWW-uswVecUbFeiSCuTWnH1xgPg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:08:59PM -0800, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 3:56 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > It will preserve existing bpf_probe_read() behavior on x86.
> 
> ... but that's the worst possible situation.
> 
> It appears that people haven't understood that kernel and user
> addresses are distinct, and may have written programs that are
> fundamentally buggy.
> 
> And we _want_ to make it clear that they are buggy on x86-64, exactly
> because x86-64 is the one that gets the most testing - by far.
> 
> So if x86-64 continues working for buggy programs, then that only
> means that those bugs never get fixed.
> 
> It would be much better to try to get those things fixed, and make the
> x86-64 implementation stricter, exactly so that people end up
> _realizing_ that they can't just think "a pointer is a pointer, and
> the context doesn't matter".
>
> From a pure functional safety standpoint, I thought bpf already knew
> what kind of a pointer it had?

when bpf verifier knows the type of pointer it allows direct access to it.
That's the case for skb, socket, packet data, hash maps, arrays, stack, etc.
Networking progs cannot call bpf_probe_read().
It's available to tracing progs only and their goal is to walk the kernel and
user memory with addresses that cannot be statically verified
at program load time.
We are working on adding type information (BTF) to vmlinux.
Soon we'll be able to tell the type of every kernel function argument.
Right now arg1 and arg2 in a kprobed function are just u64 pt_regs->di, si.
Soon we'll be able to precisely identify their C type.

I completely agree on the direction that x86 is the architecture that
sets an example and users need to learn the difference in pointers.
I only disagree on timing.
Right now users don't have an alternative.
In our repo I counted ~400 calls to bpf_probe_read and about 10 times more
'indirect' calls. What's happening with 'indirect' calls is BCC toolchain
using clang to automatically replace struct_a->field_foo access with
bpf_probe_read(struct_a + offsetof(typeof(struct_a), field_foo));

If we had __user vs __kernel annotation available to clang we could have
taught BCC to replace this '->' dereference with appropriate kernel vs user
helper. Also we need to teach GCC to recognize __user and store into dwarf,
so we can take it further into BTF and verify later.

Also I think disallowing bpf_probe_read() to read user pointer will not
make a desired teaching effect. It will only cause painful debugging to folks
when their progs will stop working. It's better to remove bpf_probe_read()
completely.
imo the process of teaching the users of kernel vs user pointer difference
needs to be gradual.
First we introduce bpf_probe_kernel_read and bpf_probe_user_read and
introduce clang/gcc tooling to catch the mistakes.
Going over this 400+ places and manually grepping kernel sources
for __user keyword is not a great proposal if we want to keep those users.
Once we have this working we can remove bpf_probe_read() altogether.
Rejecting bpf prog at load time is a clear signal that user has to fix it
(instead of changing run-time behavior).
When the verifier gets even smarter it could potentially replace prob_read
with probe_kernel_read and probe_user_read when it has that type info.

imo this kernel release should finish as-is and in the next cycle we can
change probe_kernel_read() to reject user address, have temporary
workaround in bpf_probe_read() with probe_kernel_read+get_user hack,
introduce new bpf helpers, new tooling and eventually remove
buggy bpf_probe_read.

