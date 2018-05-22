Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbeEVJGF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:06:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52312 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:06:01 -0400
Date: Tue, 22 May 2018 11:05:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
Message-ID: <20180522090527.GP12198@hirez.programming.kicks-ass.net>
References: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 10:25:49AM +0100, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> For situations where sysadmins might want to allow different level of
> of access control for different PMUs, we start creating per-PMU
> perf_event_paranoid controls in sysfs.

Could you explain how exactly this makes sense?

For example, how does it make sense for one PMU to reveal kernel data
while another PMU is not allowed.

Once you allow one PMU to do so, the secret is out.

So please explain, in excruciating detail, how you want to use this and
how exactly that makes sense from a security pov.

> These work in equivalent fashion as the existing perf_event_paranoid
> sysctl, which now becomes the parent control for each PMU.
> 
> On PMU registration the global/parent value will be inherited by each PMU,
> as it will be propagated to all registered PMUs when the sysctl is
> updated.
> 
> At any later point individual PMU access controls, located in
> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
> fine grained access control.
> 
