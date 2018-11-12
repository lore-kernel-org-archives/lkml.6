Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88811C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A92241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486A92241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeKMJWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:22:25 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:53473 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeKMJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:22:25 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-03.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gMLbi-00022a-PD from joseph_myers@mentor.com ; Mon, 12 Nov 2018 15:27:02 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 12 Nov 2018 23:26:59 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gMLbe-0005Rs-Hg; Mon, 12 Nov 2018 23:26:58 +0000
Date:   Mon, 12 Nov 2018 23:26:58 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Daniel Colascione <dancol@google.com>
CC:     Florian Weimer <fweimer@redhat.com>,
        Zack Weinberg <zackw@panix.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
In-Reply-To: <CAKOZueuM=3pxuXaJU4v571daWFCTJ1LYO-ApD6MrD7313RNYfQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811122313000.18130@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com> <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com> <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com> <CAKCAbMiHC9r54h=XeW7CkBZ1Z5eHr9MPH3Rn7KTc9DjoHG=8UA@mail.gmail.com> <CAKOZuev7zqq+xpjyDA2mSdy-zwyNjECCzLsBELF6_v1rwar_mA@mail.gmail.com>
 <87lg5ym7qi.fsf@oldenburg.str.redhat.com> <CAKOZues2bQo1y_1ynxFMHGTvtTjABsqVpKJt5MYMdZBq6-ikHA@mail.gmail.com> <alpine.DEB.2.21.1811122236240.18130@digraph.polyomino.org.uk> <CAKOZueuM=3pxuXaJU4v571daWFCTJ1LYO-ApD6MrD7313RNYfQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-08.mgc.mentorg.com (139.181.222.8) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Daniel Colascione wrote:

> I initially wanted to put the APIs in libc. I still do. But that's
> proving to be impractical, for the reasons we're discussing on this
> thread.

Well, your proposed APIs didn't attract consensus among libc developers.

> > (I can imagine *other* parts of the toolchain being involved, if e.g. you
> > want to have a good way of checking "is the address of the instruction
> > causing this signal in this library?" that works with static as well as
> > dynamic linking - for dynamic linking, I expect something could be done
> > using libc_nonshared and __dso_handle to identify code in the library
> > calling some registering function.  And indeed there might also be new
> > kernel interfaces that help improve signal handling.)
> 
> Again: you're blocking a practical solution for the sake of some
> elegant theoretical implementation that will never arrive, and so the

I'm not - I'm observing various areas that might be open to improvements 
related to signal handling, not saying improvements in one area are a 
prerequisite to improvements in another.  I'm exploring the problem and 
solution space, and collectively exploring the problem and solution space 
is an important part of trying to work out where there might be useful 
future improvements related to the general issue of signal handling.

Exploring the problem and solution space can include coming to the 
conclusion that an idea that seems obvious is in fact a bad idea, or in 
fact orthogonal to other ideas that are independently useful - those 
things are still useful in yielding a better rationale for taking a given 
approach.

> > In the absence of consensus for adding such a new API for signals to
> > glibc, it's unlikely one would get consensus for glibc to depend on some
> > other library providing such an API either.
> 
> glibc would continue using an unsupported legacy system call
> interfaces in lieu of a supported low-level interface library?

The Linux kernel supports the interfaces that people actually use, on the 
principle of not breaking userspace, not the interfaces that someone would 
like to declare to be the supported ones.  We'd use the interfaces that 
seem suitable for use by glibc, and direct syscalls seem more suitable to 
me than any kernel-provided userspace library.

Naturally a library invented in the kernel on the basis of not liking what 
libc people are doing or not doing is unlikely to be suitable for use by 
libc (and use together with libc of anything in it that interferes with 
libc functionality such as sigaction might be explicitly discouraged by 
libc maintainers, just as e.g. direct use of clone can be discouraged) - 
whereas interfaces developed collaboratively with libc implementations and 
getting consensus from those users are more likely to be of use to libc 
implementations.

-- 
Joseph S. Myers
joseph@codesourcery.com
