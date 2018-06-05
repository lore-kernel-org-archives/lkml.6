Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeFEOO0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:14:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbeFEOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:14:25 -0400
Date: Tue, 5 Jun 2018 16:14:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        will.deacon@arm.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        dvyukov@google.com, glider@google.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, parri.andrea@gmail.com
Subject: Re: [PATCH 0/7] atomics: generate atomic headers
Message-ID: <20180605141416.GW12198@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180605132949.GL12258@hirez.programming.kicks-ass.net>
 <20180605135823.iqantmeuht6aqotg@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605135823.iqantmeuht6aqotg@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:58:23PM +0100, Mark Rutland wrote:

> Sure, it all works, it's just less than optimal as above, and also means
> that we have to duplicate the ifdeffery for optional atomics -- once in
> the instrumented atomics, then in the "real" atomics.
> 
> Whereas if we filled in the raw atomics atop of the arch atomics,
> everything above that can assume the whole API is present, no ifdeffery
> required.

Aah, I see your point now. I don't think performance is a particular
concern when you enable K*SAN, but getting rid of a fair bunch of
ifdeffery is always nice.
