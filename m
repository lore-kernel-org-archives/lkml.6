Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750759AbeEPPry (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:47:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEPPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:47:52 -0400
Date: Wed, 16 May 2018 17:47:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Message-ID: <20180516154733.GF12198@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516151925.GO28366@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 05:19:25PM +0200, Juri Lelli wrote:

> Anyway, FWIW I started testing this on a E5-2609 v3 and I'm not seeing
> hackbench regressions so far (running with schedutil governor).

https://en.wikipedia.org/wiki/Haswell_(microarchitecture)#Server_processors

Lists the E5 2609 v3 as not having turbo at all, which is basically a
best case scenario for this patch.

As I wrote earlier today; when turbo exists, like say the 2699, then
when we're busy we'll run at U=2.3/3.6 ~ .64, which might confuse
things.
