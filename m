Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeFAPUQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:20:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32807 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeFAPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:20:14 -0400
X-Google-Smtp-Source: ADUXVKKBq6dCpgP/MEm/Fi8DfLb7ymQVySPR9tlx4PAs1Tt4YxY/tOEUQe0gZjqznzNQHAbQEoWi2dN1E9fWlYTYEUg=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATdw+nTQ0O7jBUDTKHaL53ejZ=oTPocFOJ1brtDr-GB1Q@mail.gmail.com>
References: <20180528153222.2037158-1-arnd@arndb.de> <20180530151736.nzpde2bgzn4koi7f@ast-mbp>
 <CAK7LNATdw+nTQ0O7jBUDTKHaL53ejZ=oTPocFOJ1brtDr-GB1Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 1 Jun 2018 17:20:12 +0200
X-Google-Sender-Auth: lqElk9B5a0dZRv8z2PwtwhBvTHM
Message-ID: <CAK8P3a1MSsL1vhV7Y98wCnP6NzK+OhqYpkoNuRm2J5PkJEK8=g@mail.gmail.com>
Subject: Re: [PATCH] [net-next, wrong] make BPFILTER_UMH depend on X86
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 3:42 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-05-31 0:17 GMT+09:00 Alexei Starovoitov <alexei.starovoitov@gmail.com>:
>> On Mon, May 28, 2018 at 05:31:01PM +0200, Arnd Bergmann wrote:

> Hmm.
> For cross-compiling, we set 'ARCH' via the environment variable or the
> command line.
>
> ARCH is not explicitly set, the top-level Makefile sets it to $(SUBARCH)
>
>
> ARCH ?= $(SUBARCH)
>
>
> Maybe, we can assume the native build if $(ARCH) and $(SUBARCH) are the same?
>

SUBARCH is also used with a special meaning for arch/um where we build
with ARCH=um SUBARCH=x86, either on native (x86) or cross builds.


So doing that would still work in most but not all cases.

What is the reason for using HOSTCC rather than CC anyway? I think
the correct way to do this would be to check if CC is able to link binaries
and disallow the option if it's not.

Don't we already do something like that for tools/testing/selftest which
also needs to generate binaries with CC?

       Arnd
