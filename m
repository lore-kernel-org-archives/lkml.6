Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbeEAJMZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:12:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48443 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755012AbeEAJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:12:20 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rui.zhang@intel.com
Subject: Re: [PATCH v2 0/7] Various tsc/clocksource fixes
Date: Tue, 01 May 2018 11:12:03 +0200
Message-ID: <2748619.xuzImzcDij@aspire.rjw.lan>
In-Reply-To: <20180430100008.503783478@infradead.org>
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 30, 2018 12:00:08 PM CEST Peter Zijlstra wrote:
> These patches are the result of the regression Diego reported against commit:
> 
>   aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
> 
> His Core2 triggers mark_tsc_unstable() while we're running with tsc-early,
> which then results in us failing to unregister the clocksource.
> 
> Furthermore, since mark_tsc_unstable() only looks at the regular tsc
> clocksource, we don't even mark tsc_early UNSTABLE or de-rate it, resulting in
> it actually staying a desirable clocksource.
> 
> Fixing that is a little more tricky; albeit far less critical after we
> guarantee to unregister tsc-early.
> 
> Please consider these for /urgent. I've used both Fixes and stable tags
> on a bunch of them because the above commit is already in v4.16 and
> would need stable help.
> 
> These patches have been tested on both a Core2 and an IVB. On IVB I've both
> changed intel_idle to always report the TSC unstable and mucked about with the
> TSC msr from userspace to tickle the watchdog paths.
> 
> ---
> Changes since v1
> 
>  - fix __clocksource_change_rating() locking
>  - removed work->kthread->watchdog hoops
>  - fixed up comment
> 
> 

I've had a deeper look at the patches and have not found anything of concern
in them, so for the whole series:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
