Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbeENQY7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:24:59 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:39085 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeENQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:24:57 -0400
X-Google-Smtp-Source: AB8JxZoxePYzoQdFiQtt7jrhQ1waju/F4Tv2rlFhLyeBpPEfc953tifN0zp0tDHEljDHVlXNOYxZuQOpMVyFZzz1Si8=
MIME-Version: 1.0
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
 <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com> <CAAeHK+zpAnC3Ppjq2W=r-5fYh+ceEwYymER0iLTan7+pcFDiJg@mail.gmail.com>
In-Reply-To: <CAAeHK+zpAnC3Ppjq2W=r-5fYh+ceEwYymER0iLTan7+pcFDiJg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 14 May 2018 09:24:45 -0700
Message-ID: <CAKwvOdkedxmstRytbWeYU8Pj9ahgWOe7rODJJ8BDtRzUroQeXw@mail.gmail.com>
Subject: Re: Clang arm64 build is broken
To: Andrey Konovalov <andreyknvl@google.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        LKML <linux-kernel@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, christoffer.dall@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 7:59 AM Andrey Konovalov <andreyknvl@google.com>
wrote:
> On Fri, Apr 20, 2018 at 10:13 AM, Marc Zyngier <marc.zyngier@arm.com>
wrote:
> >> The issue is that
> >> clang doesn't know about the "S" asm constraint. I reported this to
> >> clang [2], and hopefully this will get fixed. In the meantime, would
> >> it possible to work around using the "S" constraint in the kernel?
> >
> > I have no idea, I've never used clang to build the kernel. Clang isn't
> > really supported to build the arm64 kernel anyway (as you mention
> > below), and working around clang deficiencies would mean that we leave
> > with the workaround forever. I'd rather enable clang once it is at
> > feature parity with GCC.

> The fact that there are some existing issues with building arm64
> kernel with clang doesn't sound like a good justification for adding
> new issues :)

> However in this case I do believe that this is more of a bug in clang
> that should be fixed.

Just to follow up with this thread;

Support for "S" constraints is being (re-)added to Clang in:
https://reviews.llvm.org/D46745

-- 
Thanks,
~Nick Desaulniers
