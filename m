Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeEQQmr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:42:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:27508 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbeEQQmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:42:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,411,1520924400";
   d="scan'208";a="229386357"
Message-ID: <1526575358.11765.14.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
Date: Thu, 17 May 2018 09:42:38 -0700
In-Reply-To: <20180517161649.GX12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
         <20180516151925.GO28366@localhost.localdomain>
         <20180516154733.GF12198@hirez.programming.kicks-ass.net>
         <20180516163105.GP28366@localhost.localdomain>
         <20180517105907.GC22493@localhost.localdomain>
         <20180517150418.GF22493@localhost.localdomain>
         <1526571692.11765.10.camel@linux.intel.com>
         <20180517161649.GX12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-17 at 18:16 +0200, Peter Zijlstra wrote:
> On Thu, May 17, 2018 at 08:41:32AM -0700, Srinivas Pandruvada wrote:
> > One more point to note. Even if we calculate some utilization based
> > on
> > the freq-invariant and arrive at a P-state, we will not be able to
> > control any P-state in turbo region (not even as a cap) on several
> > Intel processors using PERF_CTL MSRs.
> 
> Right, but don't we need to set the PERF_CTL to max P in order to
> access
> the turbo bins?
Any PERF_CTL setting above what we call "Turbo Activation ratio" (which
can be less than P1 read from platform info MSR) will do that on these
systems (Most clients from Ivy bridge).

>  So we still need to compute a P state, but as soon as we
> reach max P, we're done.
What will happen if we look at all core turbo as max and cap any
utilization above this to 1024?

> 
> And its not as if setting anything below max P is a firm setting
> either
> anyway, its hints all the way down.
