Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeBBM65 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:58:57 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:55463 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBBM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:58:50 -0500
Date: Fri, 2 Feb 2018 13:58:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180202125846.GM2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <3838689.GpfBVtfPr0@aspire.rjw.lan>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <8930678.7E2iWGoJnn@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8930678.7E2iWGoJnn@aspire.rjw.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 12:42:29PM +0100, Rafael J. Wysocki wrote:
> > Yes, too many synchronous IPIs, which themselves are typically already
> > more expensive than the MSR access.
> 
> We could do all of the updates in one IPI (as Srinivas said), but it would be
> more code, and custom code for that matter.
> 
> Is this really worth it for a slow path like this one?

Probably not, still, the pattern really annoys me ;-)
