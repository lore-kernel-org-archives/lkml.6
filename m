Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeEFMLg (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:11:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32818 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeEFMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:11:33 -0400
X-Google-Smtp-Source: AB8JxZpB5ylEKZBey5S5cR1LZF35IZyLIQqgUPEb+vvERKUHfwV2FwaFOrM4frLOsgxRiedQpsP5rw==
Date: Sun, 6 May 2018 14:11:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aryabinin@virtuozzo.com, catalin.marinas@arm.com, dvyukov@google.com,
        will.deacon@arm.com
Subject: Re: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to
 asm/cmpxchg.h and define the full set of cmpxchg APIs
Message-ID: <20180506121129.baacc4fxgr72rzex@gmail.com>
References: <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
 <20180505103550.s7xsnto7tgppkmle@gmail.com>
 <20180505112817.ihrb726i37bwm4cj@tardis>
 <20180505132751.gwzu2vbzibr2risd@gmail.com>
 <20180505140340.uzfhoc42xvas4m72@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505140340.uzfhoc42xvas4m72@tardis>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Boqun Feng <boqun.feng@gmail.com> wrote:

> > The only change I made beyond a trivial build fix is that I also added the release 
> > atomics variants explicitly:
> > 
> > +#define atomic_cmpxchg_release(v, o, n) \
> > +	cmpxchg_release(&((v)->counter), (o), (n))
> > +#define atomic64_cmpxchg_release(v, o, n) \
> > +	cmpxchg_release(&((v)->counter), (o), (n))
> > 
> > It has passed a PowerPC cross-build test here, but no runtime tests.
> > 
> 
> Do you have the commit at any branch in tip tree? I could pull it and
> cross-build and check the assembly code of lib/atomic64_test.c, that way
> I could verify whether we mess something up.
> 
> > Does this patch look good to you?
> > 
> 
> Yep!

Great - I have pushed the commits out into the locking tree, they can be found in:

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core

The PowerPC preparatory commit from you is:

  0476a632cb3a: locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs

Thanks,

	Ingo
