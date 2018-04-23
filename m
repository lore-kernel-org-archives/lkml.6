Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932305AbeDWRm2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:42:28 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35960 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeDWRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:42:26 -0400
X-Google-Smtp-Source: AIpwx4/6uhSPOEp6jYyznGtZCFiHIUv9Oo3hq63Kx/LmGtmCednTDFi9W3RrhxLxYw6QkHyWUF7m/w==
Date: Mon, 23 Apr 2018 10:42:24 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        JF Bastien <jfb@google.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status
 update
Message-ID: <20180423174224.GA243180@google.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sedat,

On Mon, Apr 23, 2018 at 03:56:41PM +0200, Sedat Dilek wrote:
> [ CC Nick ]
> [ CC Arnd ]
> [ CC JF ]
 
> I wrote some early documentation (wiki) and tested/booted a
> clang-compiled kernel on x86-64 bare metal.
> The project was called "lll-project" these days.
> The followup - LLVMlinux project - seems to be somehow dead?

Yes, I think it stalled in 2014 or so. There is still a mailing list
with very occasional traffic.

> After reading your posting, I got really excited and had a quick look
> over the Linux v4.9.y-LTS patch-stack with additional stuff:
> 
> $ git fetch https://chromium.googlesource.com/chromiumos/third_party/kernel
> refs/sandbox/mka/llvm/v4.9_ext
> $ git checkout -b llvm_v4.9_ext FETCH_HEAD
> 
> I like your commit subjects and messages.
> 
> Before starting to compile I have some questions, I hope you can answer them.
> 
> [ CLANG-VERSION ]
> 
> Here on Debian/testing (will get Version 10 with codename "buster")
> AMD64 I have the choice of installing CLANG v4.0.1, v5.0.1 and v6.0.0.
> As you point out LLVM/CLANG v5.0 or higher are a good and faster
> choice than v4.0.
> Using CLANG >= 5.0 makes the *CLANG* patch-series obsolete?

Correct, preferably use clang v6 or newer.

> [ REFRESH PATCH-STACK ]
> 
> What about the *FROMGIT* and *CUSTOM* patch-series?
> Are they in upstream in the meantime?

CUSTOM patches address issues in older kernels that have been fixed
upstream in a different, not easily backportable way. They will never
land in upstream.

FROMGIT patches should eventually land upstream, since they were taken
from a maintainer tree.

The commit message includes the upstream git hash, so you can easily
check if it has landed (though in some cases the hash changes ...)

> If yes, will you refresh this v4.9.y-LTS patch-stack?

I eventually will, the two FROMGIT patches are relatively recent, and
respinning the trees just to update the tags isn't one of my
priorities.

> [ ASM-GOTO ]
> 
> Foremore, I have seen you have a "refs/sandbox/mka/llvm/v4.14" Git branch.
> Linux v4.14 is also an LTS release.

Yes, there is also a follow up post:
https://lkml.org/lkml/2017/11/22/943

> After Linux v4.9 "asm-goto" support was added which is GCC specific.

asm-goto was optional until a few weeks ago, when x86 maintainers
decided to make it mandatory, and thus break clang builds for x86:

https://lkml.org/lkml/2018/4/2/486

> Is there a workaround to compile Linux-kernel with any CLANG
> version?

You could revert the patch that makes asm-goto mandatory.

> You happen to know the status in LLVM upstream?

I know people are actively working on this, but don't know an ETA.

> [ X86-EFLAGS/IF ]
> 
> AFAICS, I remember an EFLAGS/IF problem on X86 and interrupt handling.
> You happen to know if this is fixed in LLVM upstream?
> Some LLVM developers were interested in fixing this.
> Can you comment on this, JF (we had some email conversation in private in 2016)?

Yes, this has been fixed recently:
https://bugs.llvm.org/show_bug.cgi?id=36028

Cheers

Matthias
