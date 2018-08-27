Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690FD208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQMBv1P5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690FD208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH0Nl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:41:26 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:39249 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0NlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:41:25 -0400
Received: by mail-oi0-f54.google.com with SMTP id c190-v6so26207174oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjtbmH2va80cETjTwP12yR1eFr9X+4EFx0tThrCOsVo=;
        b=bQMBv1P5YhH7WgQOO+TJ1kG45mMqRPnYvPZdxheGMY6KE9Z7mJfxjUclGIpdhCMkay
         MfKCN7Mx1xcsphWDpMjmitT0CX+lgL2AJWiXVzaWnvwUwRXnt/KF7eKZ9DmjlJE6wweG
         2TaMA/HOIhDsIPjrkV+A6Uje92uJUWk5GRQ3ZTKHaT0OXMKhLYDCaaavEwQkQvM0tdQt
         fJUR6uJQrbqnZvhAKWxUxhh+ul5qwNN6RFohIxQA9fKaiqNCnTtcypecpIVfFqtCKzzS
         79309U2/lBNHyBoQKSlUy4iS682YezLgK5eqfoEnUR6h5Ugoyvo4jIW+NE1db45GgQ55
         2rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjtbmH2va80cETjTwP12yR1eFr9X+4EFx0tThrCOsVo=;
        b=uFhIvE7shyQ3UREYhoLg3+XABvTc7q3DtSUxhkgoucICkSJVZn4zedGkoOItYw1uOt
         KX7+W+AdJFaoiYgE3fEqMz+g/BI0fnIEREXEo7bCLd9BTrCRrkVmSkA+P0HmRcBshn2H
         3aEWPvnTjrfsjQ0SR4d5q9WPKeJuipXn07QGaP0KecFcPFwT77oXw6gXv/YgqZ81e760
         OPSktu0r9EkpjAzZfyh6BF/Dffeg6FCDNZ5N6chOs5WO5tdSp6qA3lQ1IAtZom8HaXXN
         XRxaTHwUC/wGIgE+pgI7EN8PWIP7Xbm9zDAYnf+UF4lKApSSjQnBOmMYKfjCXI9fqf0E
         rSuw==
X-Gm-Message-State: APzg51DdADozA0TyCswDNh+4EufVbt2Lj8WsI32VG0yT7bSVgb32beTM
        nC2VSxQP4fxUqklM45RUn6Q6/AZfr0qh9VkiuoVNSw==
X-Google-Smtp-Source: ANB0VdafVaplQTUuaIrNdXoCCNki5WAAzkUQUlRCkNVba+IJYsxb2BIa1BYrEynTCKgL1KTrLwwXMIWEolyE7pHmu54=
X-Received: by 2002:aca:b40a:: with SMTP id d10-v6mr12617792oif.190.1535363727475;
 Mon, 27 Aug 2018 02:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com> <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org> <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <20180826090958.GT24124@hirez.programming.kicks-ass.net> <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
 <20180827081329.GZ24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180827081329.GZ24124@hirez.programming.kicks-ass.net>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Aug 2018 11:55:00 +0200
Message-ID: <CAG48ez2sn_5a1HFXpDjLHmHvp49iLn06isPwAati26Y47r2ttw@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     mhiramat@kernel.org, Kees Cook <keescook@chromium.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>, jkosina@suse.cz,
        Will Deacon <will.deacon@arm.com>, benh@au1.ibm.com,
        npiggin@gmail.com, "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Adin Scannell <ascannell@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 27, 2018 at 12:03:05PM +0900, Masami Hiramatsu wrote:
> > On Sun, 26 Aug 2018 11:09:58 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > FWIW, before text_poke_bp(), text_poke() would only be used from
> > > stop_machine, so all the other CPUs would be stuck busy-waiting with
> > > IRQs disabled. These days, yeah, that's lots more dodgy, but yes
> > > text_mutex should be serializing all that.
> >
> > I'm still not sure that speculative page-table walk can be done
> > over the mutex. Also, if the fixmap area is for aliasing
> > pages (which always mapped to memory), what kind of
> > security issue can happen?
>
> So suppose CPU-A is doing the text_poke (let's say through text_poke_bp,
> such that other CPUs get to continue with whatever they're doing).
>
> While at that point, CPU-B gets an interrupt, and the CPU's
> branch-trace-buffer for the IRET points to / near our fixmap. Then the
> CPU could do a speculative TLB fill based on the BTB value, either
> directly or indirectly (through speculative driven fault-ahead) of
> whatever is in te fixmap at the time.

Worse: The way academics have been defeating KASLR for a while is
based on TLB fills for kernel addresses, triggered from userspace.
Quoting https://www.ieee-security.org/TC/SP2013/papers/4977a191.pdf :

| Additionally, even if a permission error occurs, this still allows to
| launch address translations and, hence, generate valid TLB entries
| by accessing privileged kernel space memory from user mode.

This was actually part of the original motivation for KAISER/KPTI.
Quoting https://gruss.cc/files/kaiser.pdf :

| Modern operating system kernels employ address space layout
| randomization (ASLR) to prevent control-flow hijacking attacks and
| code-injection attacks. While kernel security relies fundamentally
on preventing
| access to address information, recent attacks have shown that the
| hardware directly leaks this information.

I believe that PTI probably prevents this way of directly triggering
TLB fills for now (under the assumption that hyperthreads with equal
CR3 don't share TLB entries), but I would still assume that an
attacker can probably trigger TLB fills for arbitrary addresses
anytime. And at some point in the future, I believe people would
probably like to be able to disable PTI again?

> Then CPU-A completes the text_poke and only does a local TLB invalidate
> on CPU-A, leaving CPU-B with an active translation.
>
> *FAIL*
