Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeDDMsB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:48:01 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38198 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeDDMr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:47:57 -0400
X-Google-Smtp-Source: AIpwx4+Ab9r117NipbTHDpHU2vzGwYAiKgCI0WsBVHQXM9u7z4xwzsvL4ZoyAj/p2kvPFVnqcLOcjQ==
Date: Wed, 4 Apr 2018 14:47:47 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: David Howells <dhowells@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
Message-ID: <20180404124747.GA8773@andrea>
References: <Pine.LNX.4.44L0.1804031557470.1399-100000@iolanthe.rowland.org>
 <7471.1522791794@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7471.1522791794@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 10:43:14PM +0100, David Howells wrote:
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > + * Returns: 1 if @lock is locked, 0 otherwise.
> > + * However, on !CONFIG_SMP builds with !CONFIG_DEBUG_SPINLOCK,
> > + * the return value is always 0 (see include/linux/spinlock_up.h).
> > + * Therefore you should not rely heavily on the return value.
> 
> Seems reasonable.
> 
> It might also want to include a note that the lock isn't necessarily held by
> your own CPU.  I would also use "=n" rather than "!", so maybe something like:
> 
>  * Returns: 1 if @lock is locked, 0 otherwise.
>  *
>  * Note that the function only tells you that the CPU is seen to be locked,
>  * not that it is locked on your CPU.
>  *
>  * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n, the return
>  * value is always 0 (see include/linux/spinlock_up.h).  Therefore you should
>  * not rely heavily on the return value.

Thank you all for the suggestions.  I plan to integrate these in the next
version of the patch, which should also include your Co-developed-by:

  Andrea


> 
> David
