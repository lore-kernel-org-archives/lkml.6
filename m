Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E1C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A5D2495D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0L0g2ZAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A5D2495D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeFZTz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:55:29 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38414 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeFZTz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:55:27 -0400
Received: by mail-wm0-f44.google.com with SMTP id 69-v6so3049870wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zndDjG6gCCf2MVNDwovbShTc2QnUCFQK2fFunO8QyXQ=;
        b=0L0g2ZADsziBrc+hGTY/tT2M1Qe1sD+EArFt/bxDbAw/c6by5NBjuAbLU1ffJalGea
         J8yY0dkQ36a/Rk1aUwiPug/pAPfGsXvIyXf1S+3JeCT4ULAOai5aP7rJkjO3yhS6LeCo
         7h4+8qIOPRu7BS/8ddXCN7R5QLvQ8ZW5wc+0DFcUqoN6V5zUu+yFD9B+vQTfaFzNeW5Y
         zro+RuRuZlS5dv5Iuf31ud4lXUh0Ux6q7fdYXo8niY/NOGQjhCgOQzl0YyLJxBWp16k0
         Yv/zdB04TU8R9+FATmvZEHLrwTwmH6NgWoci4MnhAR6qH8Lu/fB/tbt3F3PcvjqYhPU1
         QFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zndDjG6gCCf2MVNDwovbShTc2QnUCFQK2fFunO8QyXQ=;
        b=NQumrtyI++SooZrGdfo4aJTA1kFe08gmvgwN8VdR2Rs3hXV8BknlnixRKOXUPz9DJE
         7upbAf/vFrQVI/iWS85paF8oKJ+EaFMkuWYracPdavHB2/v00gyP/HFlYuUfbyU6s8tY
         ywRX/469o7WIt9H8C7Lrx+MtYCbR12MfFcfd9Sa9e/qCLZVTbTXxo0IEuPJfNHoQLqt/
         qkbgVNipjSeHNoRdKno+MVblfZc4pvttoxVAusCYO7Yo2WzvsSSct2WNBIG8KBXx2jhJ
         rKj0SkBOA/TbbhlWP0OqrP3cZc7iA02dLy86kF7xS+5fhCaldHP2WCOKq/Ljibr9C46i
         5w3g==
X-Gm-Message-State: APt69E2HyB0JI6qQJNTsL6JSACLuQlQlksA50FmuimR1Lo+M8DwINd5n
        7p6XkmHLuiFdfDcAbJhSoaA3fNEOeY3B5TLQx5EGOQ==
X-Google-Smtp-Source: AAOMgpf0DnWuUEapDgXvgbNYE7T4x2QHylTmEfRAQ4toP5J74ybeKSZO1KlEZQGDCsJrpjJabl1Qz4MYmfsKUJED4dw=
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr2528275wmc.144.1530042926238;
 Tue, 26 Jun 2018 12:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com>
 <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com>
 <CALCETrXimh61U7Tn9KShr6sKag7NCL3qfraN18Oy2Bk+0VRAUA@mail.gmail.com> <1277536320.5963.1530042608296.JavaMail.zimbra@efficios.com>
In-Reply-To: <1277536320.5963.1530042608296.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 26 Jun 2018 12:55:14 -0700
Message-ID: <CALCETrWhY_+SxKt9Xq2ruiGk8GQeYvrojy84w_Quosrf5fpApQ@mail.gmail.com>
Subject: Re: rseq: How to test for compat task at signal delivery
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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

On Tue, Jun 26, 2018 at 12:50 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jun 26, 2018, at 3:32 PM, Andy Lutomirski luto@amacapital.net wrote:
>
> > On Tue, Jun 26, 2018 at 11:45 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Jun 26, 2018, at 1:38 PM, Mathieu Desnoyers
> >> mathieu.desnoyers@efficios.com wrote:
> >>
> >> > Hi Andy,
> >> >
> >> > I would like to make the behavior rseq on compat tasks more robust
> >> > by ensuring that kernel/rseq.c:rseq_get_rseq_cs() clears the high
> >> > bits of rseq_cs->abort_ip, rseq_cs->start_ip and
> >> > rseq_cs->post_commit_offset when a 32-bit binary is run on a 64-bit
> >> > kernel.
> >> >
> >> > The intent here is that if user-space has garbage rather than zeroes
> >> > in its struct rseq_cs fields padding, the behavior will be the same
> >> > whether the binary is run on 32-bit or 64 kernels.
> >> >
> >> > I know that internally, the kernel is making a transition from
> >> > is_compat_task() to in_compat_syscall().
> >> >
> >> > I'm fine with using in_compat_syscall() when rseq_get_rseq_cs() is
> >> > invoked from a system call, but is it OK to call it when it is
> >> > invoked from signal delivery ? AFAIU, signals can be delivered
> >> > upon return from interrupt as well.
> >> >
> >> > If not, what strategy do you recommend for arch-agnostic code ?
> >>
> >> I think what we're missing here is a new "is_compat_frame(struct ksignal *ksig)"
> >> which I could use in the rseq code. I'll prepare a patch and we can discuss
> >> from there.
> >>
> >
> > That sounds about right.
> >
> > I'm confused, though.  Wouldn't it be more consistent to just segfault
> > if the high 32 bits are not clear when rseq transitions to a 32-bit
> > context?  If there's garbage in 64-bit mode, the program will crash.
> > Why should 32-bit mode be any different?
>
> Currently, if a 32-bit binary puts garbage in the high bits of
> start_ip, post_commit_offset, and abort_ip in
>
> include/uapi/linux/rseq.h:
>
> struct rseq_cs {
>         /* Version of this structure. */
>         __u32 version;
>         /* enum rseq_cs_flags */
>         __u32 flags;
>         LINUX_FIELD_u32_u64(start_ip);
>         /* Offset from start_ip. */
>         LINUX_FIELD_u32_u64(post_commit_offset);
>         LINUX_FIELD_u32_u64(abort_ip);
> } __attribute__((aligned(4 * sizeof(__u64))));

This ABI isn't real ABI until a stable kernel happens, right?  So how
about just making all those fields be u64?

>
> A 32-bit kernel just never reads the padding, thus in reality acting
> as if those were zeroes. However, a 64-bit kernel dealing with this
> 32-bit compat task will read that padding, handling those as very
> large values.

Sounds like a design error.  Have all kernels read the fields no
matter what.  A 32-bit kernel will send SIGSEGV if the high bits are
set.  A 64-bit kernel running compat userspace should make sure that a
32-bit task dies if the high bits are set.

>
> We need to improve that by introducing a consistent behavior across
> native 32-bit kernels and 32-bit compat mode on 64-bit kernels.
>
> There are two ways to achieve this: either the 32-bit kernel validates
> the padding by killing the process if padding is non-zero, or the
> 64-bit kernel treats compat mode by zeroing the high bits of padding.
>
> If we look at system call interfaces in general, I think the usual
> approach is to clear the top bits whenever a value read from a
> compat task ends up being used as a pointer. This is why I am tempted
> to go for the "clear high bits" approach rather than killing the task.

I think the modern preference is to use fields of fixed size rather
than long when UABI is involved.

In any event, I think the test you want is user_64bit_mode().

>
> Also, validating that the top 32-bit is zeroes from a native 32-bit
> kernel requires extra loads, whereas not caring about their content
> is free, which makes me slightly prefer an approach where 32-bit
> compat mode on 64-bit kernel just clears the top bits.
>

But performance is totally irrelvant here, right?  This only affects
the abort path, unless I'm rather confused.

--Andy
