Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934429AbeBMPlp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:41:45 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41475 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbeBMPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:41:44 -0500
X-Google-Smtp-Source: AH8x226SLsac/LRyRsWOWqWXkyAWgorcJN9f8ddBGnrv9qXZxnIzUk2A/b3nHN1tAHI0La/NXtKTq0aELLvpWNgNWDo=
MIME-Version: 1.0
In-Reply-To: <CAP8WD_Yr8bt+uz7JBixf+xELB-_3Y8J8tsaQWpEg8nvFtGFraw@mail.gmail.com>
References: <CAP8WD_Yr8bt+uz7JBixf+xELB-_3Y8J8tsaQWpEg8nvFtGFraw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 07:41:42 -0800
X-Google-Sender-Auth: CYNLML8GzfCUkWArgd45aG5fCQQ
Message-ID: <CAGXu5jKkUbDaOuypmGhq1FCDDvsU24GkGEU9z0d1YQ9-kRajNQ@mail.gmail.com>
Subject: Re: move stack-protector availability out of Kconfig
To: whiteheadm@acm.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, Josh Triplett <josh@joshtriplett.org>,
        Nick Piggin <npiggin@gmail.com>, Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:27 AM, tedheadster <tedheadster@gmail.com> wrote:
> Kees,
>   I have a question about this patch. When I configure a kernel for
> ARCH=i386 it sets these Kconfig variables this way:
>
> HAVE_CC_STACKPROTECTOR=y
> CC_STACKPROTECTOR_AUTO=y
>
> CC_STACKPROTECTOR_NONE=n
> CC_STACKPROTECTOR_REGULAR=n
> CC_STACKPROTECTOR_STRONG=n
>
> It seems to me that at least _one_ of the last _three_ variables
> should be set to 'y' with the defaults that are being set, probably
> CC_STACKPOINTER_NONE=y. All of them being 'n' doesn't make sense to
> me.

The last three are a defined state and map to specific flags. _AUTO
just tries its best to find any working flag. After some redesign to
Kconfig, this may improve so that Kconfig maps directly to things that
right now only the Makefile can determine. That's under development
now.

> As a side note, these defaults set X86_32_LAZY_GS=n (depends on X86_32
> [=y] && CC_STACKPROTECTOR_NONE [=n]) which causes the x86_32 kernels
> to hang. I'll discuss  that in a different email thread, but just
> wanted to say how I came upon this.

I'd tested this combination, but I must have missed something. I'll go
read the other email...

-Kees

-- 
Kees Cook
Pixel Security
