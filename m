Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDKQcJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:32:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752664AbeDKQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:32:07 -0400
Date: Wed, 11 Apr 2018 18:31:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Message-ID: <20180411163157.GQ4082@hirez.programming.kicks-ass.net>
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
 <20180409184258.GP3948@linux.vnet.ibm.com>
 <20180410203214.GA19606@linux.vnet.ibm.com>
 <8cbda122-6aa3-365b-fd09-52dca0644cbd@redhat.com>
 <20180410213434.GC3948@linux.vnet.ibm.com>
 <156ac07b-7393-449f-518a-6b1c2cff8efb@redhat.com>
 <20180411161956.GQ3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411161956.GQ3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 09:19:56AM -0700, Paul E. McKenney wrote:

> > 
> >                                    Prior Operation   Subsequent Operation
> >                                    ---------------   ---------------------
> >                                    R  W  RMW  SV     R  W  DR  DW  RMW  SV
> >                                    -  -  ---  --     -  -  --  --  ---  --

> > smp_store_mb()                     Y  Y    Y   Y      Y  Y   Y   Y   Y   Y

I'm not sure about that, the generic version of that reads:

include/asm-generic/barrier.h:#define __smp_store_mb(var, value)  do { WRITE_ONCE(var, value); __smp_mb(); } while (0)

Which doesn't not have an smp_mb() before, so it doesn't actually order
prior; or I'm failing to read the table wrong.
