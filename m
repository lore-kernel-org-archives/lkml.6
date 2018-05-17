Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeEQQRP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:17:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEQQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:17:13 -0400
Date: Thu, 17 May 2018 18:16:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Message-ID: <20180517161649.GX12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain>
 <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain>
 <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain>
 <1526571692.11765.10.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526571692.11765.10.camel@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 08:41:32AM -0700, Srinivas Pandruvada wrote:
> One more point to note. Even if we calculate some utilization based on
> the freq-invariant and arrive at a P-state, we will not be able to
> control any P-state in turbo region (not even as a cap) on several
> Intel processors using PERF_CTL MSRs.

Right, but don't we need to set the PERF_CTL to max P in order to access
the turbo bins? So we still need to compute a P state, but as soon as we
reach max P, we're done.

And its not as if setting anything below max P is a firm setting either
anyway, its hints all the way down.
