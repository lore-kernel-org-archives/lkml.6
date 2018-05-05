Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeEEJcm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:32:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeEEJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:32:41 -0400
Date: Sat, 5 May 2018 11:32:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/atomics: Clean up the atomic.h maze of #defines
Message-ID: <20180505093237.GD12217@hirez.programming.kicks-ass.net>
References: <20180504173937.25300-1-mark.rutland@arm.com>
 <20180504173937.25300-2-mark.rutland@arm.com>
 <20180504180105.GS12217@hirez.programming.kicks-ass.net>
 <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <CACT4Y+Z1WKxdkodRBc5PzfyQQmfJCJ3n1JyQc-+WCkqGZeg5Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z1WKxdkodRBc5PzfyQQmfJCJ3n1JyQc-+WCkqGZeg5Wg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2018 at 11:05:51AM +0200, Dmitry Vyukov wrote:
> On Sat, May 5, 2018 at 10:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > And I seriously hate this one:
> >
> >   ba1c9f83f633 ("locking/atomic/x86: Un-macro-ify atomic ops implementation")
> >
> > and will likely undo that the moment I need to change anything there.

> That was asked by Ingo:
> https://groups.google.com/d/msg/kasan-dev/3sNHjjb4GCI/Xz1uVWaaAAAJ
> 
> I think in the end all of current options suck in one way or another,
> so we are just going in circles.

Yeah, and I disagree with him, but didn't have the energy to fight at
that time (and still don't really, I'm just complaining).

> We either need something different (e.g. codegen), or settle on one
> option for doing it.

Codegen I think is the only sensible option at this point for all the
wrappers. The existing ones (without the annotation muck) were already
cumbersome, the annotation stuff just makes it completely horrid.
