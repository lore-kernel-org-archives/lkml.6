Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeEOTkC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:40:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeEOTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:39:59 -0400
Date: Tue, 15 May 2018 21:39:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] locking/atomics: Simplify the op definitions
 in atomic.h some more
Message-ID: <20180515193952.GC12198@hirez.programming.kicks-ass.net>
References: <tip-87d655a48dfe74293f72dc001ed042142cf00d44@git.kernel.org>
 <20180509073327.GE12217@hirez.programming.kicks-ass.net>
 <20180515083556.GA30420@gmail.com>
 <20180515114144.GX12217@hirez.programming.kicks-ass.net>
 <20180515154333.bszh4nuowhocozuc@lakrids.cambridge.arm.com>
 <20180515171021.GI12217@hirez.programming.kicks-ass.net>
 <20180515175307.m4xbkbicdrzo4qhb@lakrids.cambridge.arm.com>
 <20180515181136.GR12217@hirez.programming.kicks-ass.net>
 <20180515181510.GM12235@hirez.programming.kicks-ass.net>
 <CA+55aFxjU0op8QLLu0n-RjHBs7gQsLvD8jcyedgw6jeZFN7B+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxjU0op8QLLu0n-RjHBs7gQsLvD8jcyedgw6jeZFN7B+Q@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 11:52:17AM -0700, Linus Torvalds wrote:
>   (b) if at all possible, please aim to make "git grep" find the stuff that
> is generated?

The easiest way to make that happen is to just commit the generated
headers instead of generating them each build.

This would mean moving them to include/linux/atomic-gen-*.h or somesuch,
instead of using include/generated/.

I don't expect they'll change often anyway (famous last words).
