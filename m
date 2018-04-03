Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeDCNf4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:35:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37526 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeDCNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:35:54 -0400
X-Google-Smtp-Source: AIpwx49AO1LeKfCS4R8NGV/zUrrXjFeFlQt4JesgtHRtGlXrgWIwBRnT8G78zFXccm58qP4inT+A2g==
Date: Tue, 3 Apr 2018 15:35:43 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: David Howells <dhowells@redhat.com>
Cc: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180403133543.GA26653@andrea>
References: <1522600912-6208-2-git-send-email-andrea.parri@amarulasolutions.com>
 <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
 <29562.1522759749@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29562.1522759749@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 01:49:09PM +0100, David Howells wrote:
> Andrea Parri <andrea.parri@amarulasolutions.com> wrote:
> 
> > +/**
> > + * spin_is_locked() - Check whether a spinlock is locked.
> > + * @lock: Pointer to the spinlock.
> > + *
> > + * This function is NOT required to provide any memory ordering
> > + * guarantees; it could be used for debugging purposes or, when
> > + * additional synchronization is needed, accompanied with other
> > + * constructs (memory barriers) enforcing the synchronization.
> > + *
> > + * Return: 1, if @lock is (found to be) locked; 0, otherwise.
> 
> It's more complicated than that.  This function is dangerous and should be
> used with extreme care.  In the case where CONFIG_SMP=n the value is locked
> one way or the other and it might be the wrong way.

You mean "unlocked"? (aka, return 0)

  Andrea


> 
> David
