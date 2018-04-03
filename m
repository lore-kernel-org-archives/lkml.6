Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeDCOnR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:43:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54778 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDCOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:43:15 -0400
Date: Tue, 3 Apr 2018 16:43:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180403144300.GE4082@hirez.programming.kicks-ass.net>
References: <20180403133543.GA26653@andrea>
 <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
 <29562.1522759749@warthog.procyon.org.uk>
 <13191.1522763553@warthog.procyon.org.uk>
 <20180403141718.GG3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403141718.GG3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 07:17:18AM -0700, Paul E. McKenney wrote:
> Suggestions for a fix?  Clearly great care is required when using it
> in things like WARN_ON()...

Yeah, don't use it there, use lockdep_assert_held().

As I stated before in this thread, ideally we'd make *_is_locked() go
away entirely.
