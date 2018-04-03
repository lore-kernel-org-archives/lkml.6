Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeDCVnU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:43:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753261AbeDCVnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:43:19 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.1804031557470.1399-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1804031557470.1399-100000@iolanthe.rowland.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: dhowells@redhat.com, Andrea Parri <andrea.parri@amarulasolutions.com>,
        paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of spin_is_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7470.1522791794.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 22:43:14 +0100
Message-ID: <7471.1522791794@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:

> + * Returns: 1 if @lock is locked, 0 otherwise.
> + * However, on !CONFIG_SMP builds with !CONFIG_DEBUG_SPINLOCK,
> + * the return value is always 0 (see include/linux/spinlock_up.h).
> + * Therefore you should not rely heavily on the return value.

Seems reasonable.

It might also want to include a note that the lock isn't necessarily held by
your own CPU.  I would also use "=n" rather than "!", so maybe something like:

 * Returns: 1 if @lock is locked, 0 otherwise.
 *
 * Note that the function only tells you that the CPU is seen to be locked,
 * not that it is locked on your CPU.
 *
 * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n, the return
 * value is always 0 (see include/linux/spinlock_up.h).  Therefore you should
 * not rely heavily on the return value.

David
