Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E81C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675F520870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544632811;
	bh=NLt/dpgAytp9E9jLUtvgCUNLUuBvdWuL08dEXZhw+dw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FA8H4mLDXp4xLNJtSqN6fTHhfTXtw+NyrMgYIwgbr3Juk7BObojiCkLSgrmG9rYKi
	 o/kCcImEnIFo6P+cp1ljbS+eO26ox0ouO9H9PD3A5F29dNkDz2L4BwY3T4VeBsVUQM
	 uGIxJizEIy0ZzpP8qUbZoAevEw5n44mNYTTHFbNs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675F520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbeLLQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeLLQkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:40:09 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF6A21479
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544632807;
        bh=NLt/dpgAytp9E9jLUtvgCUNLUuBvdWuL08dEXZhw+dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zsEEYEnJYRLtgkgXkcDnPQRXgVYHgGYJ95ONwNJVI4C79Idh7LGt4YPGPhufM8X2d
         yC3QGTcggiTszxU4gufEECshLCJVplcu1MOtOI9ODhMp4vEY3BNzotWYBF3q4rNPpU
         hOtWewYxs3wk/X2bD7C1DLJdFhpFcjdpaaBY9/fI=
Received: by mail-wr1-f45.google.com with SMTP id l9so18315188wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 08:40:07 -0800 (PST)
X-Gm-Message-State: AA+aEWbUfSY8oFRd5sTXyqL+zVKHBWFJhZY5lTfsl0jDTjRPBw10dOnz
        2mSSHZUba6FFeihcNr0/FmNGcveYU3mimKsBBBEY3g==
X-Google-Smtp-Source: AFSGD/UwPvA/CoskIvkNNFpQocVtvc6DPb6FBg4Ma0OVwHuQACp2bjChupMV2tnnimeCPBQ1nib0t+1gs90wZ0wSZ/w=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr17124755wro.77.1544632805891;
 Wed, 12 Dec 2018 08:40:05 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org> <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
In-Reply-To: <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Dec 2018 08:39:53 -0800
X-Gmail-Original-Message-ID: <CALCETrUYn=S=hmJ0tKdm2LoSgkWchY2_65sH7hJZp7wfS30giw@mail.gmail.com>
Message-ID: <CALCETrUYn=S=hmJ0tKdm2LoSgkWchY2_65sH7hJZp7wfS30giw@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     tg@mirbsd.de
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 11, 2018, at 6:33 PM, Thorsten Glaser <tg@mirbsd.de> wrote:
>
> Andy Lutomirski dixit:
>

>
>> IMO the real right solution would be to push the whole problem to
>> userspace: get an ILP32 system working with almost or entirely LP64
>
> Is this a reflex of Linux kernel developers? ;-)
>
> I doubt that userspace is the right place for this, remember
> the recent glibc vs. syscalls debate. It would also need to
> multiply across various libcs.
>
>> How hard would it be to have __attribute__((ilp64)), with an optional
>> warning if any embedded structs are not ilp64?  This plus a wrapper to
>
> You mean LP64. Impossible, because LP64 vs. ILP32 is not the only
> difference between amd64 and x32.

I mean LP64.  And I'm not suggesting that ILP32 is the only difference
between x32 and x86_64, nor am I suggesting that a technique like this
would implement x32 -- I'm suggesting it would implement something
better than x32.

The kernel, as a practical matter, supports two ABIs on 64-bit builds:
LP64 and ILP32.  ILP32 is what the kernel calls "compat".  ("compat"
comes with other baggage -- it generally has a 32-bit signal frame,
syscall arguments are mostly limited to 32 bits, etc.)  Allowing a
user program that runs in 64-bit mode to issue compat syscalls is not
really a big deal.  x86_64 has allowed this forever using int $0x80 --
it's just slow.  Adding a faster mechanism would be straightforward.
As I understand it, the arm64 ilp32 proposal involves using a genuine
ILP32 model for user code, so the syscalls will all (except for signal
handling) go through the compat path.

x32 is not this at all.  The kernel ABI part of x32 isn't ILP32.  It's
IP32, 32-bit size_t, and *64-bit* long.  The core kernel doesn't
really support this.  The only good things I can think of about it are
that (a) it proves that somewhat odd ABIs are possible, at least in
principle, and (b) three users have come out of the woodwork to say
that they use it.

I'm proposing another alternative.  Given that x32 already proves that
the user bitness model doesn't have to match the kernel model (in x32,
user "long" is 32-bit but the kernel ABI "long" is 64-bit), I'm
proposing extending this to just make the kernel ABI be LP64.  So
__kernel_size_t would be 64-bit and pointers in kernel data structures
would be 64-bit.  In other words, most or all of the kernel ABI would
just match x86_64.

As far as I can tell, the only thing that really needs unusual
toolchain features here is that C doesn't have an extra-wide pointer
type.  The kernel headers would need a way to say "this pointer is
still logically a pointer, and user code may assume that it's 32 bits,
but it has 8-byte alignment."

So I guess I'm proposing that people who really like x32 and are
willing to invest effort it in instead invest some effort into getting
something similar to work using the normal x86_64 syscalls.  And I'm
hinting to the ARM folks on the thread that they consider this
approach for arm64.

There's an added benefit to my proposal over x32.  With my proposal,
an ILP32 program could plausibly call into a true 64-bit C library
using a straightforward FFI translation.
>
> bye,
> //mirabilos
> --
> I believe no one can invent an algorithm. One just happens to hit upon it
> when God enlightens him. Or only God invents algorithms, we merely copy them.
> If you don't believe in God, just consider God as Nature if you won't deny
> existence.        -- Coywolf Qi Hunt
