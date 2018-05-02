Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751650AbeEBN4H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:56:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeEBN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:56:03 -0400
Date: Wed, 2 May 2018 15:55:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rjw@rjwysocki.net, rui.zhang@intel.com
Subject: Re: [PATCH v2 3/7] clocksource: Initialize cs->wd_list
Message-ID: <20180502135556.GT12217@hirez.programming.kicks-ass.net>
References: <20180430100008.503783478@infradead.org>
 <20180430100344.472662715@infradead.org>
 <alpine.DEB.2.21.1805021536460.1560@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805021536460.1560@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:37:30PM +0200, Thomas Gleixner wrote:
> On Mon, 30 Apr 2018, Peter Zijlstra wrote:
> 
> > A number of places relies on list_empty(&cs->wd_list), however the
> > list_head does not get initialized. Do so upon registration, such that
> > thereafter it is possible to rely on list_empty() correctly reflecting
> > the list membership status.
> > 
> > Tested-by: Diego Viola <diego.viola@gmail.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> The next patch is marked for stable, but this one not. Confused

Patch ordering issue mostly. I only marked stable those that fix the
immediate/reported problem.

I noticed this while working on the code, this fixes, afaict, a
pre-existing issue, where the current code relies on
list_empty(&->wd_list), but we don't actually initialize it at all.

Marking it stable is probably fine, but I didn't go to great lengths to
test the individual code paths affected.
