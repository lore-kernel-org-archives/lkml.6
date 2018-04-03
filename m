Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932152AbeDCMtO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:49:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeDCMtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:49:13 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com> <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: dhowells@redhat.com, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of spin_is_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29561.1522759749.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 13:49:09 +0100
Message-ID: <29562.1522759749@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> +/**
> + * spin_is_locked() - Check whether a spinlock is locked.
> + * @lock: Pointer to the spinlock.
> + *
> + * This function is NOT required to provide any memory ordering
> + * guarantees; it could be used for debugging purposes or, when
> + * additional synchronization is needed, accompanied with other
> + * constructs (memory barriers) enforcing the synchronization.
> + *
> + * Return: 1, if @lock is (found to be) locked; 0, otherwise.

It's more complicated than that.  This function is dangerous and should be
used with extreme care.  In the case where CONFIG_SMP=n the value is locked
one way or the other and it might be the wrong way.

David
