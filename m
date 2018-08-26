Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A71DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6257216FA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAZB/L7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6257216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeH0COB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:14:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39746 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0COB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:14:01 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so24114021oig.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7p8kO3p8z7dEv5dtS72z5MSDZzJ8qRx+UY80J2Tma4=;
        b=fAZB/L7TXZSLTboeLraK7flX4INdYKvIctXH5B+KsEHDb0O3GIjVLIvWv+QHnZvOx+
         Gc6RYTw0wRWpv8xCo455uX8+DH3t8B5gpwL7+46ncIVNLY0z76iNPmPTcO6SJ0sssqbm
         K9hRjZcNmzrhNDQNSGIdsZdi3ANpjhyX2QuDtQcYqcx9xCvpTHZ0VXQAUxP5aETI0a/X
         clCjwQpKG5iRMQLMS22FLQZ6BjrHZy49tz6bbhclV3oJAoeLQ8rKtbVaAoDGZ/XpdK3g
         PphTQMSSQE3TF5i+AdSiymY4Dit3ezmNTXsjyJer98zuU2WgkoX11UhhbL3i7ioOys+w
         HC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7p8kO3p8z7dEv5dtS72z5MSDZzJ8qRx+UY80J2Tma4=;
        b=oTNlr9a7ilaAP2bEe3BC6Izb81pJjcIFquUO5ieJ3f44fCqresAWUZqI3BTHfmHghW
         KAkr+Bc5laoasdzppf0sKeDn9SKRsOC7w3np+FHIrRp+D4XpQXOROG0HCpQU902pnzl9
         wiccvkQkGsUOx13LINDWfb0Lg/gXd5U7dgGEV7XLE35TNMIJysm0VPtlUDYAQSq+M+Yn
         ws1pqyZ17v2hAMj5yUxic6RKEIORPr8Xr+ihajwhjltXBnpGFdch1J/QcNF+pDFkuzbr
         67fseJT4/MGLxR9riJG+cVAtjNpDNOnyZs38K3U+29OzGS8rH/acyIFXR5fZGh0yIJ4o
         mOhg==
X-Gm-Message-State: APzg51DucY5eq7Jcj3c9lCduoFidDDfLGEHFG5QWqT5b7+bPS7VDRVHl
        dHCKQI87nLHteWV+giA/qnRSv6P7yWOmO8lVz7+kGQ==
X-Google-Smtp-Source: ANB0VdbigpTnk33MDOS0S7tUAJjY+eK0AEUrNUGPFmjw0LgAXXCF+nBWrBcwfDEj/sWBxmX7qVTINQRz0kdjq6ADvm0=
X-Received: by 2002:aca:4204:: with SMTP id p4-v6mr9465189oia.242.1535322604623;
 Sun, 26 Aug 2018 15:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180822153012.173508681@infradead.org> <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net> <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net> <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com> <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org> <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com>
 <952A64F0-90B3-4E2F-B410-7E20BE90D617@amacapital.net> <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
 <DF353FDA-4A57-4F5E-A403-531DDA0DBC25@amacapital.net> <alpine.DEB.2.21.1808262212030.1195@nanos.tec.linutronix.de>
 <CAGXu5jJQGiGwQRBGuVrmhQqyUEfRUUSD6WYokc2xezExY9ZNUg@mail.gmail.com>
In-Reply-To: <CAGXu5jJQGiGwQRBGuVrmhQqyUEfRUUSD6WYokc2xezExY9ZNUg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 27 Aug 2018 00:29:37 +0200
Message-ID: <CAG48ez0tXJgsuoez3akJr4LW8fDGFFGg_9Mpb=MU7yP_7UbJ=A@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>, mhiramat@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>, jkosina@suse.cz,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, benh@au1.ibm.com,
        npiggin@gmail.com, "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
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

On Mon, Aug 27, 2018 at 12:11 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Aug 26, 2018 at 1:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sun, 26 Aug 2018, Andy Lutomirski wrote:
> >> > On Aug 26, 2018, at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
> >> >> On Sun, Aug 26, 2018 at 7:20 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> >> >>> I tried to convince Ingo to use this method for doing "write rarely"
> >> >>> and he soundly rejected it. :) I've always liked this because AFAICT,
> >> >>> it's local to the CPU. I had proposed it in
> >> >>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=kspp/write-rarely&id=9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d
> >> >>
> >> >> Ingo, can you clarify why you hate it?  I personally would rather use CR3, but CR0 seems like a fine first step, at least for text_poke.
> >> >
> >> > Sorry, it looks like it was tglx, not Ingo:
> >> >
> >> > https://lkml.kernel.org/r/alpine.DEB.2.20.1704071048360.1716@nanos
> >> >
> >> > This thread is long, and one thing that I think went unanswered was
> >> > "why do we want this to be fast?" the answer is: for doing page table
> >> > updates. Page tables are becoming a bigger target for attacks now, and
> >> > it's be nice if they could stay read-only unless they're getting
> >> > updated (with something like this).
> >> >
> >> >
> >> It kind of sounds like tglx would prefer the CR3 approach. And indeed my
> >> patch has a serious problem wrt the NMI code.
> >
> > That's exactly the problem I have with CR0. It leaves everything and some
> > more writeable for any code which can interrupt that section.
>
> I thought the point was that the implementation I suggested was
> NMI-proof? (And in reading Documentation/preempt-locking.txt it sounds
> like disabling interrupts is redundant to preempt_disable()? But I
> don't understand how; it looks like the preempt stuff is advisory?)

Where are you dealing with NMIs? local_irq_disable() disables the
interrupt flag, but Non-Maskable Interrupts can still come in. As far
as I know, the only way to block those is to artificially generate an
NMI yourself (Xen does that sometimes). Otherwise, you have to twiddle
CR0.WP in the NMI handler entry/exit code.
