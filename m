Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034060AbeBPOSh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:18:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033893AbeBPOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:18:34 -0500
Date: Fri, 16 Feb 2018 15:18:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org
Subject: Re: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180216141829.GK25235@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216103520.GC25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216103520.GC25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:35:20AM +0100, Peter Zijlstra wrote:

> #define BIT_U32_MASK(nr)	(1UL << ((nr) % 32))
> #define BIT_U32_WORD(nr)	(((nr) / 32) ^ (4 * __BIG_ENDIAN__))

s/4 *//

it's already a 4 byte offset.
