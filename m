Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44311C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F099E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F099E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLKJDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:03:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33077 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:03:05 -0500
Received: by mail-qk1-f195.google.com with SMTP id o89so8182709qko.0;
        Tue, 11 Dec 2018 01:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeWJmY84JG6eAX2k07pciE7NYOZrbaPRTVaeLim/GR0=;
        b=VShOFWPXfyxhnKLoG8Goxl8xI7RjLSpv9mhke8F/RL8bW2pisyY1qWdpma5uqKfGf3
         rbuOmlrOdsEEiRxyLaq8ro2wDjWb/mcSGybUjBdw34dfAbGedqcAE1xiUUzPai8LPesX
         1wMs8NTh6agKpVEwRD5a+Am1FfHrvo6uvfwfb9hfINDG0ngsO0Sj1mrnyF/LKc01ajaj
         3E0dA8Ut5wGOMAT6FdxqOXaOKng/a1A+qkvtof/U6RaxS2GgGu7T9h23snE9iFELbA0p
         ArWQXTn2ln7nIVWxYnlVAZz5s6XM+QII0vkZIq1C0IAKgjGuZvNpBBYKwd2FQ0ugfhCr
         lOHA==
X-Gm-Message-State: AA+aEWZ59dxeqzVY3nFvAoLW2+PHNV07FJhIFupKHC+0YfYj7vLw9tA/
        jir8L90rxkpSZGJ/qjkR5G1rQcLVKv1kk5U8AZQ=
X-Google-Smtp-Source: AFSGD/U3y+u2T4/tfzFvoe+M9zw4vSGqYVf+T9V3TbWFrXx++KX80jLRAPwyyvZkd6snk4e3dR82KH0HQHNUpFAfY0w=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr13129956qkf.107.1544518984309;
 Tue, 11 Dec 2018 01:03:04 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAMe9rOp0m5sn59AsD2F2i2Ad2tb7ufPU1mMg-vUOfh+TnGMeaw@mail.gmail.com> <CALCETrU5xw61=me1YcTO3VPzjNEZahMPpi-20-oiSGs+CHcj4g@mail.gmail.com>
In-Reply-To: <CALCETrU5xw61=me1YcTO3VPzjNEZahMPpi-20-oiSGs+CHcj4g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 10:02:45 +0100
Message-ID: <CAK8P3a0adxnXr9JLfpR5MBeEJXSCK2Rt4w7NFLUUwO6s6LBVPQ@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>, vapier@gentoo.org,
        Rich Felker <dalias@libc.org>, x32@buildd.debian.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 6:35 AM Andy Lutomirski <luto@kernel.org> wrote:
> On Mon, Dec 10, 2018 at 7:15 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> > On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org> wrote:
> Right.  My question wasn't whether x32 had developers -- it was
> whether it had users.  If the only users are a small handful of people
> who keep the toolchain and working and some people who benchmark it,
> then I think the case for keeping it in upstream Linux is a bit weak.

+1

> > > Conversely, if you call a syscall in the 512 range with bit 31
> > > *clear*, then the compat entry is set with in_compat_syscall()
> > > *clear*.  This is also nutty.
> >
> > This is to share syscalls between LP64 and ILP32 (x32) in x86-64 kernel.
> >
>
> I tried to understand what's going on.  As far as I can tell, most of
> the magic is the fact that __kernel_long_t and __kernel_ulong_t are
> 64-bit as seen by x32 user code.  This means that a decent number of
> uapi structures are the same on x32 and x86_64.  Syscalls that only
> use structures like this should route to the x86_64 entry points.  But
> the implementation is still highly dubious -- in_compat_syscall() will
> be *true* in such system calls,

I think the fundamental issue was that the intention had always been
to use only the 64-bit entry points for system calls, but the most
complex one we have -- ioctl() -- has to use the compat entry point
because device drivers define their own data structures using 'long'
and pointer members and they need translation, as well as
matching in_compat_syscall() checks. This in turn breaks down
again whenever a driver defines an ioctl command that takes
a __kernel_long_t or a derived type like timespec as its argument.

> which means that, if someone changes:
>
...
> where one argument has x32 and x86_64 matching but the other has x32
> and x86_32 matching.
>
> This whole thing seems extremely fragile.

It definitely is. We have lots of workarounds specifically for
x32 in device drivers, but in the time_t conversion for y2038
I still found ones that had not been caught earlier, and for each
y2038 conversion that someone did to a driver or syscall, we have
to make sure that it doesn't break x32 in the process.

         Arnd
