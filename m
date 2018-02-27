Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeB0Myq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:54:46 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33594 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeB0Myp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:54:45 -0500
X-Google-Smtp-Source: AG47ELtHIYVQZTgTACF9sxTOEXAp1r0I6UeIt4g57sSq0sejAIZNoXC7YDC2cYw5+jga0DGzh0mnsErkhhHpTyauM5Y=
MIME-Version: 1.0
From: Woody Suwalski <terraluna977@gmail.com>
Date: Tue, 27 Feb 2018 07:54:44 -0500
Message-ID: <CAM6Zs0WTjWW+Lw3ws_iAH-K1dJgd5r9s0oC=u4TgEFUyC5bxig@mail.gmail.com>
Subject: 4.16 regression: s2ram broken on non-PAE i686
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        William Grant <william.grant@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a problem with s2ram on 4.16, and it has now been propagated
to 4.15 and 4.14 stable updates.

It originates from

commit 62c00e6122a6b5aa7b1350023967a2d7a12b54c9
Author: William Grant <william.grant@canonical.com
<mailto:william.grant@canonical.com>>
Date:   Tue Jan 30 22:22:55 2018 +1100

    x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP

s2ram works OK on PAE kernels, breaks badly on non-PAE. I do not think
that the problem can be duplicated in VMPlayer, but it is 100%
reproducible on a "real" hardware.
System goes to sleep OK, but when woken - it reboots the PC.

The issue is tracked in Bugzilla bug 198763
[https://bugzilla.kernel.org/show_bug.cgi?id=198763]

Thanks, Woody
