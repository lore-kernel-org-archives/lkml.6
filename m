Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbeFEXU2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:20:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33162 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeFEXU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:20:26 -0400
X-Google-Smtp-Source: ADUXVKKmlpWUrG83gpc3xMevbj20IYiMuBzTS/7h4rI/qJ03Alf2/jE1eB2Ph8vE4ocD8pLXzHVH0w==
Date: Wed, 6 Jun 2018 02:20:22 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: x86/asm: __clear_user() micro-optimization (was: "Re: [GIT PULL]
 x86/asm changes for v4.18")
Message-ID: <20180605232022.GA4468@avx2>
References: <20180604122132.GA3337@gmail.com>
 <CA+55aFx=zLkZx4h4rcWv79OKQSGJAwC3eS8=zSDgKjyrsbLrNA@mail.gmail.com>
 <20180605150514.GA31065@gmail.com>
 <20180605172243.GA2059@avx2>
 <CA+55aFxTve6FxLuvWyyD88ACOg+3eHKbpWUeuvNZMSB=AFfuqg@mail.gmail.com>
 <20180605224150.GA2051@avx2>
 <CA+55aFwt0SOns=tfsD9GCfbc9-xY04O5AWfKiQTroeH=edO7wQ@mail.gmail.com>
 <CA+55aFxz46_efiQw9Nk_pFbX3AYx+oehPQOk-BDd1Xpbr2Oa3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxz46_efiQw9Nk_pFbX3AYx+oehPQOk-BDd1Xpbr2Oa3w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:04:37PM -0700, Linus Torvalds wrote:
> On Tue, Jun 5, 2018 at 4:01 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Jun 5, 2018 at 3:41 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > On my potato performance increase is 33%, sheesh.
> > > And CPU starts doing 3 instructions per cycle vs 2.
> >
> > Whee. That's a shockingly big difference. On my CPU (i7-6700K) it
> > makes absolutely no difference whether the values are integers or in
> > registers.
> 
> In fact, looking at Agner Fog's instruction lists, I don't see any CPU
> where it would make a difference, except for the P4 (where the
> immediate looks like it's a bad idea because it's an extra uop, but it
> might pack fine and not be noticeable).
> 
> But maybe I'm missing something subtle. What CPU, out of morbid interest?

This is Broadwell Xeon E5-2620 v4.
Which is somewhat strange indeed because it should be modern enough.
