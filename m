Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeEPHQ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:16:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeEPHQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:16:55 -0400
Date: Wed, 16 May 2018 09:16:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Message-ID: <20180516071640.GU12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 09:49:03PM -0700, Srinivas Pandruvada wrote:
> intel_pstate has two operating modes: active and passive. In "active"
> mode, the in-built scaling governor is used and in "passive" mode,
> the driver can be used with any governor like "schedutil". In "active"
> mode the utilization values from schedutil is not used and there is
> a requirement from high performance computing use cases, not to read
> any APERF/MPERF MSRs. In this case no need to use CPU cycles for
> frequency invariant accounting by reading APERF/MPERF MSRs.
> With this change frequency invariant account is only enabled in
> "passive" mode.

WTH is active/passive? Is passive when we select performance governor?

Also; you have to explain why using APERF/MPERF is bad in that case. Why
do they care if we read those MSRs during the tick?
