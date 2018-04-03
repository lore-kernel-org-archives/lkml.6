Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbeDCI7L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:59:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755086AbeDCI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:59:10 -0400
Date: Tue, 3 Apr 2018 10:59:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180403085904.GY4082@hirez.programming.kicks-ass.net>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 02:44:48PM -0700, Linus Torvalds wrote:
> On Mon, Apr 2, 2018 at 2:50 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > The biggest change is the forcing of asm-goto support on x86, which effectively
> > increases the GCC minimum supported version to gcc-4.5 (on x86).
> 
> So my biggest worry isn't gcc-4.5 (anybody who hasn't updated deserves
> to be forced, or can stay with old kernels).
> 
> No, my biggest worry is clang. What's the status there?
> 
> I've pulled this, and honestly, the disaster with
> -fmerge-all-constants makes me think that clang isn't that good a
> compiler choice anyway, but it's sad if this undoes a lot of clang
> work just because of the worries about Spectre and mis-speculated
> branches.

It's not just spectre, I believe you yourself wanted to use asm-goto
somewhere in the x86 code:

  http://lkml.kernel.org/r/CA+55aFyCp-9Qqjcn9wp=VDp2KO7tfYuUMJxVKC75Xxu0wEB5Cw@mail.gmail.com

There was some KVM talk of relying on it here:

  http://lkml.kernel.org/r/6a5f2453-cf51-d491-db54-5f239caa29bc@redhat.com

And there's the comment here:

  https://elixir.bootlin.com/linux/v4.16-rc7/source/arch/x86/kvm/emulate.c#L457

As to the suitablility of using clang, there's also this unresolved
issue:

  http://lkml.kernel.org/r/20180321211931.GA111711@google.com

The fact that even without asm-goto they cannot correctly compile a
kernel and have sat on their hands regarding asm-goto for the past 7 odd
years makes me care very little.

And since they need to spin a new version of the compiler with all the
various bugs fixed, they might as well include asm-goto in that and be
done with it.
