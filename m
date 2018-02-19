Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeBTNCL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:02:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeBTNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:09 -0500
Date: Mon, 19 Feb 2018 15:05:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org
Subject: Re: [RFC PATCH 3/5] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180219140553.GT25201@hirez.programming.kicks-ass.net>
References: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
 <1518708575-12284-4-git-send-email-will.deacon@arm.com>
 <20180215170847.GD25181@hirez.programming.kicks-ass.net>
 <20180215182049.GC15274@arm.com>
 <20180216103520.GC25201@hirez.programming.kicks-ass.net>
 <20180219140151.GE30394@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219140151.GE30394@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:01:51PM +0000, Will Deacon wrote:
> If it's defined, then we could consider using cmpxchg64 to build atomic64
> instead of the locks. But even then, I'm not sure we're really helping
> anybody out in practice.

yeah, most 64bit archs have more atomics or ll/sc and would not use it
anyway I suppose.
