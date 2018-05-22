Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEVHjf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:39:35 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32782 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeEVHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:39:33 -0400
X-Google-Smtp-Source: AB8JxZqvRoFsL+LFVGRQB/qWMPsUawwtCVxyXvI96aZUzSTSsMwU5iOTv5mYUsBZY+S4GdJUw2yIom47PeWQ3YqmZw8=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com> <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
 <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 22 May 2018 09:39:31 +0200
Message-ID: <CA+icZUVsV=5jvTcXVWqMs6ROhT3mv+7zBOoJ0JkUy5Mf+a4GNw@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Manoj Gupta <manojgupta@chromium.org>,
        AlistairStrachan <astrachan@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 12:54 AM, Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
> Sedat,
> Thanks for the report.  We have a fix ready in
> https://bugs.llvm.org/show_bug.cgi?id=37512.  Can you report what
> version of clang you were using and if earlier versions of clang have
> this issue?
> Thanks,

Can you give some advices on how to implement
"attribute((no_stack_protector))" for Clang?

I looked on how this is done for GCC...

[ include/linux/compiler-gcc.h ]

#if GCC_VERSION >= 40400
#define __optimize(level)       __attribute__((__optimize__(level)))
#define __nostackprotector      __optimize("no-stack-protector")
#endif /* GCC_VERSION >= 40400 */

[ include/linux/compiler_types.h ]

#ifndef __nostackprotector
# define __nostackprotector
#endif

LLVM-bug #37512 says:

"GCC option for this is: attribute((optimize("no-stack-protector")))
and the equivalent clang syntax would be: attribute((no_stack_protector))"

So, there should be a define in "include/linux/compiler-clang.h" for this?

[ include/linux/compiler-clang.h ]

#define __nostackprotector attribute((no_stack_protector))

Looks that good to you?

- Sedat -
