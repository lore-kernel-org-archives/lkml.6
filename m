Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965179AbeBMP1w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:27:52 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35162 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964869AbeBMP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:27:50 -0500
X-Google-Smtp-Source: AH8x224ZhQDymLxfm5fYS5SWJIB+6jJGhTVvLC9ucbyLi+EIBUAI4/b+Dj6PtWwE7pGgfGY/tI8HQbzt3rFFjRlGDAM=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 13 Feb 2018 10:27:29 -0500
Message-ID: <CAP8WD_Yr8bt+uz7JBixf+xELB-_3Y8J8tsaQWpEg8nvFtGFraw@mail.gmail.com>
Subject: Re: move stack-protector availability out of Kconfig
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        Arnd Bergmann <arnd@arndb.de>, josh@joshtriplett.org,
        npiggin@gmail.com, Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,
  I have a question about this patch. When I configure a kernel for
ARCH=i386 it sets these Kconfig variables this way:

HAVE_CC_STACKPROTECTOR=y
CC_STACKPROTECTOR_AUTO=y

CC_STACKPROTECTOR_NONE=n
CC_STACKPROTECTOR_REGULAR=n
CC_STACKPROTECTOR_STRONG=n

It seems to me that at least _one_ of the last _three_ variables
should be set to 'y' with the defaults that are being set, probably
CC_STACKPOINTER_NONE=y. All of them being 'n' doesn't make sense to
me.

As a side note, these defaults set X86_32_LAZY_GS=n (depends on X86_32
[=y] && CC_STACKPROTECTOR_NONE [=n]) which causes the x86_32 kernels
to hang. I'll discuss  that in a different email thread, but just
wanted to say how I came upon this.

- Matthew Whitehead
