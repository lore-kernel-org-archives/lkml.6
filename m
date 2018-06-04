Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeFDXvI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:51:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46430 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeFDXvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:51:06 -0400
X-Google-Smtp-Source: ADUXVKJPq7HxWr0vMo2zTo7hL4GUEMOMMjiIduDCu7RkIkQWyO2q7Qv99gqyh+SxAFF3vb89PETGDA==
Date: Mon, 4 Jun 2018 16:51:03 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
Message-ID: <20180604235101.fdhkvbx3m7m2u5uc@ast-mbp>
References: <20180528153222.2037158-1-arnd@arndb.de>
 <20180530151736.nzpde2bgzn4koi7f@ast-mbp>
 <CAK7LNATdw+nTQ0O7jBUDTKHaL53ejZ=oTPocFOJ1brtDr-GB1Q@mail.gmail.com>
 <CAK8P3a1MSsL1vhV7Y98wCnP6NzK+OhqYpkoNuRm2J5PkJEK8=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1MSsL1vhV7Y98wCnP6NzK+OhqYpkoNuRm2J5PkJEK8=g@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 05:20:12PM +0200, Arnd Bergmann wrote:
> On Thu, May 31, 2018 at 3:42 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > 2018-05-31 0:17 GMT+09:00 Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> >> On Mon, May 28, 2018 at 05:31:01PM +0200, Arnd Bergmann wrote:
> 
> > Hmm.
> > For cross-compiling, we set 'ARCH' via the environment variable or the
> > command line.
> >
> > ARCH is not explicitly set, the top-level Makefile sets it to $(SUBARCH)
> >
> >
> > ARCH ?= $(SUBARCH)
> >
> >
> > Maybe, we can assume the native build if $(ARCH) and $(SUBARCH) are the same?
> >
> 
> SUBARCH is also used with a special meaning for arch/um where we build
> with ARCH=um SUBARCH=x86, either on native (x86) or cross builds.
> 
> 
> So doing that would still work in most but not all cases.
> 
> What is the reason for using HOSTCC rather than CC anyway? I think
> the correct way to do this would be to check if CC is able to link binaries
> and disallow the option if it's not.

that's a great idea. Let's do that.

> Don't we already do something like that for tools/testing/selftest which
> also needs to generate binaries with CC?

I couldn't find such makefile magic. Can you please help me with this?
