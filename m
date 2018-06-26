Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBABC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37806255D2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sxhQwWWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37806255D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934001AbeFZUrG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:47:06 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:50692 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933482AbeFZUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:47:04 -0400
Received: by mail-wm0-f47.google.com with SMTP id e16-v6so3380427wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PeoFP3TQ+jL34Z7z2KDfzHEGSxz80XsvHL183l9rn3g=;
        b=sxhQwWWAGETiAdHR4C/FBa1OGQB34cuJesNhaoXL3ICKy77zM/w48vpkahqdnkyBVj
         7x9Asis+n/2wrN2LbHXRCXtmL42pm+tSy3t1wuN45EQdPzMs5DhdVLaAwGxXcpc0kVLx
         XdrYovPBjLu9f3vw6leFyWXSXTkcoU+quK1RQ3lb3yJx4qpCe0crj/RedZ9lurliBKVy
         M/IWdrb24VxK3uKPNX9Xl1liqEZJnozfgYGZ/0zdoUZxqyy72Fbl6VY6zjtF3o26Vji1
         wk0Kc5ykB0D8equ6L4NKZKcAamDnzDDVrS5w/UrU1z3foX0vZrJKn4xge6w6qM2yF1MS
         3VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeoFP3TQ+jL34Z7z2KDfzHEGSxz80XsvHL183l9rn3g=;
        b=forDtfwmcwYB4i0WwdgwDQ+//S5SuuMzrahMadUK8c45mqarmXrDxD0tsrnBV7R3Vv
         gxwKkSqbYb2p2RjVz55WMoGw/L+xllQRA6QpRoUYeg8uM82CUevOt8ZFwA9WEc8jM0sD
         UHe+nwOjXJFXIFgoNTNLSGdJ8inC6KpZSgSnSowL0y7AwA5QdRmNasZvy4ddaFQPtqH0
         CfEXS3M+iOQitQbZBkB436aW2tazGRlofrUozccLMAy+WWu7XNJFg+eKkNnFCCKkEjHZ
         Y/0nSe5bLZzEdgqV6hRYRZ3xvlVW/zQTc/DAelZj1s0JchEwWZJ8QkkEN38plpfVTTIZ
         vgqw==
X-Gm-Message-State: APt69E2vfDO++6qZsaj4zsJ7VUHktNg195SxITYL3n0qoy6vl/Nr2fSG
        cSOU9CvHy1rV/mOpCHjnHGLalYloerHIk4KO5pi4BQ==
X-Google-Smtp-Source: AAOMgpddGRMd4Tg0gT3mBFB4jWVyvyFNgHiMOoKexshZcn0zvY4KKz7nuCLEuZKSGYw9Mme+VBwIRHLRwL4ub36t9hM=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr2658955wmh.116.1530046022554;
 Tue, 26 Jun 2018 13:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com>
 <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com>
 <CALCETrXimh61U7Tn9KShr6sKag7NCL3qfraN18Oy2Bk+0VRAUA@mail.gmail.com>
 <1277536320.5963.1530042608296.JavaMail.zimbra@efficios.com>
 <CALCETrWhY_+SxKt9Xq2ruiGk8GQeYvrojy84w_Quosrf5fpApQ@mail.gmail.com> <1352608225.6039.1530043932895.JavaMail.zimbra@efficios.com>
In-Reply-To: <1352608225.6039.1530043932895.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 26 Jun 2018 13:46:50 -0700
Message-ID: <CALCETrVs57TZf4V4vrCkh2Aa_x=+HuVO5hYB5yFmS1VqE5rcuw@mail.gmail.com>
Subject: Re: rseq: How to test for compat task at signal delivery
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 1:12 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jun 26, 2018, at 3:55 PM, Andy Lutomirski luto@amacapital.net wrote:
>
> > On Tue, Jun 26, 2018 at 12:50 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Jun 26, 2018, at 3:32 PM, Andy Lutomirski luto@amacapital.net wrote:
> >>
> >> > On Tue, Jun 26, 2018 at 11:45 AM Mathieu Desnoyers
> >> > <mathieu.desnoyers@efficios.com> wrote:
> >> >>
> >> >> ----- On Jun 26, 2018, at 1:38 PM, Mathieu Desnoyers
> >> >> mathieu.desnoyers@efficios.com wrote:
> >> >>
> >> >> > Hi Andy,
> >> >> >
> >> >> > I would like to make the behavior rseq on compat tasks more robust
> >> >> > by ensuring that kernel/rseq.c:rseq_get_rseq_cs() clears the high
> >> >> > bits of rseq_cs->abort_ip, rseq_cs->start_ip and
> >> >> > rseq_cs->post_commit_offset when a 32-bit binary is run on a 64-bit
> >> >> > kernel.
> >> >> >
> >> >> > The intent here is that if user-space has garbage rather than zeroes
> >> >> > in its struct rseq_cs fields padding, the behavior will be the same
> >> >> > whether the binary is run on 32-bit or 64 kernels.
> >> >> >
> >> >> > I know that internally, the kernel is making a transition from
> >> >> > is_compat_task() to in_compat_syscall().
> >> >> >
> >> >> > I'm fine with using in_compat_syscall() when rseq_get_rseq_cs() is
> >> >> > invoked from a system call, but is it OK to call it when it is
> >> >> > invoked from signal delivery ? AFAIU, signals can be delivered
> >> >> > upon return from interrupt as well.
> >> >> >
> >> >> > If not, what strategy do you recommend for arch-agnostic code ?
> >> >>
> >> >> I think what we're missing here is a new "is_compat_frame(struct ksignal *ksig)"
> >> >> which I could use in the rseq code. I'll prepare a patch and we can discuss
> >> >> from there.
> >> >>
> >> >
> >> > That sounds about right.
> >> >
> >> > I'm confused, though.  Wouldn't it be more consistent to just segfault
> >> > if the high 32 bits are not clear when rseq transitions to a 32-bit
> >> > context?  If there's garbage in 64-bit mode, the program will crash.
> >> > Why should 32-bit mode be any different?
> >>
> >> Currently, if a 32-bit binary puts garbage in the high bits of
> >> start_ip, post_commit_offset, and abort_ip in
> >>
> >> include/uapi/linux/rseq.h:
> >>
> >> struct rseq_cs {
> >>         /* Version of this structure. */
> >>         __u32 version;
> >>         /* enum rseq_cs_flags */
> >>         __u32 flags;
> >>         LINUX_FIELD_u32_u64(start_ip);
> >>         /* Offset from start_ip. */
> >>         LINUX_FIELD_u32_u64(post_commit_offset);
> >>         LINUX_FIELD_u32_u64(abort_ip);
> >> } __attribute__((aligned(4 * sizeof(__u64))));
> >
> > This ABI isn't real ABI until a stable kernel happens, right?  So how
> > about just making all those fields be u64?
>
> Good point. Unlike the rseq_cs field in the struct rseq TLS, those
> fields don't need to be word-sized/word-aligned, so we could simply
> declare them as __u64.
>
> >
> >>
> >> A 32-bit kernel just never reads the padding, thus in reality acting
> >> as if those were zeroes. However, a 64-bit kernel dealing with this
> >> 32-bit compat task will read that padding, handling those as very
> >> large values.
> >
> > Sounds like a design error.  Have all kernels read the fields no
> > matter what.  A 32-bit kernel will send SIGSEGV if the high bits are
> > set.  A 64-bit kernel running compat userspace should make sure that a
> > 32-bit task dies if the high bits are set.
>
> If we end up declaring those as __u64, that approach makes sense.
>
> >
> >>
> >> We need to improve that by introducing a consistent behavior across
> >> native 32-bit kernels and 32-bit compat mode on 64-bit kernels.
> >>
> >> There are two ways to achieve this: either the 32-bit kernel validates
> >> the padding by killing the process if padding is non-zero, or the
> >> 64-bit kernel treats compat mode by zeroing the high bits of padding.
> >>
> >> If we look at system call interfaces in general, I think the usual
> >> approach is to clear the top bits whenever a value read from a
> >> compat task ends up being used as a pointer. This is why I am tempted
> >> to go for the "clear high bits" approach rather than killing the task.
> >
> > I think the modern preference is to use fields of fixed size rather
> > than long when UABI is involved.
> >
> > In any event, I think the test you want is user_64bit_mode().
>
> Currently, user_64bit_mode is only implemented on x86.
>
> Should we introduce an architecture-agnostic user_64bit_mode(struct pt_regs *)
> which maps to is_compat_task() for non-x86 ? I'm just worried that ptrace
> code could try to use it from the context of another task and get mixed up.

I'm not sure other archs can do this.  It might need to have a
task_struct pointer, too.

But I think the only actual consideration is that a lot of
architectures might fail to kill the task if the task is 32-bit and
regs->ip or regs->sp ends up with garbage in the high bits.  Certainly
x86 is not consistent about this.  So maybe a helper to fully validate
all 64 bits of ip and sp or perhaps helpers to set them and check for
full validity would be better.  Like:

void set_task_64bit_ip_or_signal(struct task_struct *, u64 value);

that promises to actually signal the task if value is garbage?

Let's ask linux-arch here.  I'm not nearly familiar enough with the
nasty details of other compat-capable architectures.  x86 is very,
very, very inconsistent about how what the high bits of the registers
mean, and there are cases where the "high bits" involved are actually
the high 48 bits, not the high 32 bits.  Sigh.

--Andy
