Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeC0VwZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:52:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:41096 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbeC0VwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:52:24 -0400
Message-ID: <1522187495.7364.70.camel@kernel.crashing.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from
 arch_spin_is_locked()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Mar 2018 08:51:35 +1100
In-Reply-To: <20180327131339.GA4278@andrea>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com>
         <1522109216.7364.30.camel@kernel.crashing.org>
         <20180327102521.GA7347@andrea>
         <1522150386.7364.53.camel@kernel.crashing.org>
         <20180327131339.GA4278@andrea>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-27 at 15:13 +0200, Andrea Parri wrote:
> > 
> > So unless it's very performance sensitive, I'd rather have things like
> > spin_is_locked be conservative by default and provide simpler ordering
> > semantics.
> 
> Well, it might not be "very performance sensitive" but allow me to say
> that "40+ SYNCs in stuff like BUG_ON or such" is sadness to my eyes ;),

In the fast path or the trap case ? Because the latter doesn't matter
at all...

> especially when considered that our "high level API" provides means to
> avoid this situation (e.g., smp_mb__after_spinlock(); BTW, if you look
> at architectures for which this macro is "non-trivial", you can get an
> idea of the architectures which "wouldn't work"; of course, x86 is not
> among these).  Yes, we do appear to have different views on what is to
> be considered the "simpler ordering semantics".  I'm willing to change
> mine _as soon as_ this gets documented: would you be willing to send a
> patch (on the lines of my [1]) to describe/document such semantics?

Not really :-) Just expressing an opinion. I don't fully object to your
approach, just saying it's open for debate.

At this point, I have too many other things to chase to follow up too
much on this.

Cheers,
Ben.
