Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeEVHMB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:12:01 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:43838 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVHL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:11:56 -0400
X-Google-Smtp-Source: AB8JxZpzWT4ktpWFhlY+FbBgi1tllB42IvpX6vqD5C5Es963NyZX4mvIJ9s3rI3xx+j7jUJarU43ZScR0AgjrRFj8FE=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com> <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
 <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 22 May 2018 09:11:54 +0200
Message-ID: <CA+icZUWjKDgg+-EJ8dyw-r4A+O_iMLPEBk2aKhTWO9_0Em_s4A@mail.gmail.com>
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

Hi Nick,

yesterday was public holiday in Germany, so I answer today.

These are really good news, Thanks.

For my recent experiments with Linux-kernel v4.14.y LTS I used Clang...

#1: version 6.0 from Debian/testing repositories
#2: version 7 (svn330207) from <apt-llvm.org>

In these cases I had success (good means boot on bare metal) or it
failed (bad verified in Qemu):

bad: CONFIG_PARAVIRT=y and  CONFIG_CC_STACKPROTECTOR_STRONG=y
good: CONFIG_PARAVIRT=n and CONFIG_CC_STACKPROTECTOR_STRONG=y
good: CONFIG_PARAVIRT=y and CONFIG_CC_STACKPROTECTOR_NONE=y

So, the issue is in both Clang versions and I appreciate to have your
fix in LLVM/Clang version 6.0.1 as I don't know which version will get
into upcoming Debian/buster (version 10, current status: testing).

Hope this helps.

Regards,
- Sedat -
