Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeCMQeE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:34:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44951 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933504AbeCMQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:34:01 -0400
X-Google-Smtp-Source: AG47ELv263hQqMXWltGyMsVBP0Z5rRlRHSO0wRmu+rH0Fs5aX7DLxctR2GW2ZblynQcPshuYfrguGlm/gyGAgLUj+b8=
MIME-Version: 1.0
References: <20180313061109.72629-1-dianders@chromium.org> <20180313061109.72629-3-dianders@chromium.org>
 <20180313061603.jsgiumet23uqi6hl@gmail.com> <CAD=FV=UEuWww=H=TY=E8JvEmrobDNi5+rbTXvTAmZ2brpK+sdg@mail.gmail.com>
In-Reply-To: <CAD=FV=UEuWww=H=TY=E8JvEmrobDNi5+rbTXvTAmZ2brpK+sdg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 13 Mar 2018 16:33:48 +0000
Message-ID: <CAKwvOdnPSMSOenPiPqBpDf=hf5q5uQ5MF0pOLAea5T5_VPhmaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kbuild: Don't mess with the .cache.mk when root
To: Doug Anderson <dianders@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>, malat@debian.org,
        dave.hansen@intel.com, yang.s@alibaba-inc.com, linux@roeck-us.net,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>, a.p.zijlstra@chello.nl,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:23 PM Doug Anderson <dianders@chromium.org>
wrote:

> Hi,

> On Mon, Mar 12, 2018 at 11:16 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Douglas Anderson <dianders@chromium.org> wrote:
> >
> >> +# Don't create Makefile caches if running as root since they can't be
deleted
> >> +# easily; in the real world we might be root when doing "sudo make
install"
> >> +ifeq ($(shell id -u),0)
> >> +export KBUILD_NOCACHE := 1
> >> +endif
> >
> > Please don't do this - many prominent kernel developers build their
kernels as
> > root - this makes the build slower for them, and also bifurcates
testing.

> Ah, interesting.  I hadn't realized that!

> I'm OK with dropping this patch myself.  It was mostly addressing a
> potential problem pointed out by Masahiro Yamada when we were talking
> about .cache.mk, but I don't think anyone has actually experienced the
> problems listed in the CL description.

>    /bin/sh: ./.cache.mk: Permission denied

I feel like I've definitely seen that permission error before.

Is there any issue if I:

$ make clean
$ make
$ sudo make install
<hack around>
$ make

Or it's only a problem if:

$ make clean
$ sudo make install
<hack around>
$ make
--
Thanks,
~Nick Desaulniers
