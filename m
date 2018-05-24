Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeEXWc7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:32:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58446 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeEXWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:32:55 -0400
Date: Fri, 25 May 2018 00:32:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180524223244.GO12198@hirez.programming.kicks-ass.net>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
 <20180524124410.GF12198@hirez.programming.kicks-ass.net>
 <20180524124734.GE8689@arm.com>
 <20180524130948.f37eltocl5tnittp@lakrids.cambridge.arm.com>
 <20180524220610.GA7607@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524220610.GA7607@andrea>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 12:06:10AM +0200, Andrea Parri wrote:
> Hi Mark,
> 
> > As an aside, If I complete the autogeneration stuff, it'll be possible
> > to generate those. I split out the necessary barriers in [1], but I
> > still have a lot of other preparatory cleanup to do.
> 
> I do grasp the rationale behind that naming:
> 
>   __atomic_mb_{before,after}_{acquire,release,fence}()
> 
> and yet I remain puzzled by it:
> 
> For example, can you imagine (using):
> 
>   __atomic_mb_before_acquire() ?
> 
> (as your __atomic_mb_after_acquire() is whispering me "acquire-fences"...)

Yes, I really do think he means acquire-fence. It is however something I
have vague memories of not being liked much because it is the memop
itself that carries the ordering.

That said, this is only an implementation detail and not a public
interface, so maybe we can get away with it.
