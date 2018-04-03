Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753878AbeDCVsM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:48:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43092 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeDCVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:48:11 -0400
Subject: Re: [PATCH v2 1/3] locking: Document the semantics of
 spin_is_locked()
To: David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
References: <Pine.LNX.4.44L0.1804031557470.1399-100000@iolanthe.rowland.org>
 <7471.1522791794@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91b57513-99be-7b77-ebe2-a7c2a121475f@infradead.org>
Date: Tue, 3 Apr 2018 14:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7471.1522791794@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 02:43 PM, David Howells wrote:
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
>> + * Returns: 1 if @lock is locked, 0 otherwise.
>> + * However, on !CONFIG_SMP builds with !CONFIG_DEBUG_SPINLOCK,
>> + * the return value is always 0 (see include/linux/spinlock_up.h).
>> + * Therefore you should not rely heavily on the return value.
> 
> Seems reasonable.
> 
> It might also want to include a note that the lock isn't necessarily held by
> your own CPU.  I would also use "=n" rather than "!", so maybe something like:
> 
>  * Returns: 1 if @lock is locked, 0 otherwise.
>  *
>  * Note that the function only tells you that the CPU is seen to be locked,

the CPU is locked??

>  * not that it is locked on your CPU.
>  *
>  * Further, on CONFIG_SMP=n builds with CONFIG_DEBUG_SPINLOCK=n, the return
>  * value is always 0 (see include/linux/spinlock_up.h).  Therefore you should
>  * not rely heavily on the return value.
> 
> David
> 


-- 
~Randy
