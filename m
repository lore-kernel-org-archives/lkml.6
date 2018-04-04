Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeDDK2n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:28:43 -0400
Received: from ozlabs.org ([103.22.144.67]:58607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeDDK2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:28:38 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH for-4.17 2/2] powerpc: Remove smp_mb() from arch_spin_is_locked()
In-Reply-To: <20180328110809.GE4129@hirez.programming.kicks-ass.net>
References: <1522060667-7034-1-git-send-email-andrea.parri@amarulasolutions.com> <1522109216.7364.30.camel@kernel.crashing.org> <20180327102521.GA7347@andrea> <87a7us3h66.fsf@concordia.ellerman.id.au> <20180328110436.GR4043@hirez.programming.kicks-ass.net> <20180328110809.GE4129@hirez.programming.kicks-ass.net>
Date: Wed, 04 Apr 2018 20:28:36 +1000
Message-ID: <87tvsrmfjf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Mar 28, 2018 at 01:04:36PM +0200, Peter Zijlstra wrote:
>> On Wed, Mar 28, 2018 at 04:25:37PM +1100, Michael Ellerman wrote:
>> > Documenting it would definitely be good, but even then I'd be inclined
>> > to leave the barrier in our implementation. Matching the documented
>> > behaviour is one thing, but the actual real-world behaviour on well
>> > tested platforms (ie. x86) is more important.
>> 
>> By that argument you should switch your spinlock implementation to RCpc
>> and include that SYNC in either lock or unlock already ;-)
>
> *RCsc* obviously... clearly I need to wake up moar.

It's just a jumble of letters to me - I didn't even notice ;)

cheers
