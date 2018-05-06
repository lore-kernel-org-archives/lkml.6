Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeEFCfF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 22:35:05 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:37557 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeEFCfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 22:35:04 -0400
X-Google-Smtp-Source: AB8JxZrooKU0ieM2zFWGGCM7OXOHDCfKZd4Xyj9JkmFJdrAYr4QUZskhb8XQEgU9iFY3Hh+n1qoWG89RIvu4FC6TRQI=
MIME-Version: 1.0
In-Reply-To: <1b8328d1-4e41-c4f9-c07b-87530e85eb7c@infradead.org>
References: <1b8328d1-4e41-c4f9-c07b-87530e85eb7c@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 5 May 2018 22:35:03 -0400
X-Google-Sender-Auth: iG0eS4xrStikrKR6Ox-pQCOLfSo
Message-ID: <CAK8P3a1fPK0eqfkehphXF9aeL0sbryzOyqD3rXej6YSrySSMwA@mail.gmail.com>
Subject: Re: crosstool requirements?
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 5, 2018 at 2:20 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> Hi Arnd,
>
> I was trying to use the x86_64 hosted openrisc/or1k gcc compiler (7.3.0-nolibc)
> but I mostly what I get are errors like the following:
>
> crosstool/gcc-7.3.0-nolibc/or1k-linux/bin/../libexec/gcc/or1k-linux/7.3.0/cc1: error while loading shared libraries: libisl.so.15: cannot open shared object file: No such file or directory
>
>
> I do have /usr/lib64/libisl.so.10 (not .15) installed on my system.
> Am I just outofluck for doing this?

This has been pointed out by some others before, sorry for not having addressed
it yet. I'll be back from travelling on May 22 and should be able to build a set
of gcc-8.1 binaries without this problem, and also rebuild some of the older
compilers to fix it (gcc-4.8 is already fixed, but IIRC doesn't
support openrisc)

What happened here is that I built against the libraries that came
with Ubuntu 16.04,
intentionally picking a somewhat older distro in the hope that this
would produce
binaries that work on a wider range of systems, but I had it use the
system libisl,
libgmp, libmpfc, and libmpc rather than using the one provided by the
gcc project
for static linking.

You should be able to just install the binaries from
https://launchpad.net/ubuntu/xenial/amd64/libisl15/0.16.1-1
as well as any others you might need along with the toolchain (either
using dpkg on Debian or Ubuntu, or extracting the .so file into an
appropriate directory for others) until then.

        Arnd
