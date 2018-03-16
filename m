Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbeCPKjw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:39:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753416AbeCPKju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:39:50 -0400
Date: Fri, 16 Mar 2018 11:39:46 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>, tglx@linutronix.de,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, kan.liang@intel.com, eranian@google.com,
        davidcc@google.com, valery.cherepennikov@intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [PATCH] perf: Fix sibling iteration
Message-ID: <20180316103946.GA6960@krava>
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
 <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
 <20180316103129.GC4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316103129.GC4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:31:29AM +0100, Peter Zijlstra wrote:
> On Fri, Mar 16, 2018 at 12:59:34PM +0300, Alexey Budankov wrote:
> > Hi,
> > On 15.03.2018 20:01, Peter Zijlstra wrote:
> > > Subject: perf: Fix sibling iteration
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Thu Mar 15 17:36:56 CET 2018
> > > 
> > > Mark noticed that the change to sibling_list changed some iteration
> > > semantics; because previously we used group_list as list entry,
> > > sibling events would always have an empty sibling_list.
> > > 
> > > But because we now use sibling_list for both list head and list entry,
> > > siblings will report as having siblings.
> > > 
> > > Fix this with a custom for_each_sibling_event() iterator.
> > > 
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > Fixes: 8343aae66167 ("perf/core: Remove perf_event::group_entry")
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > 
> > Applied to tip repo and run testing on Fedora 27/x86_64 (client skylake 8 cores):
> 
> There is at least one more known issue with that patch, but neither Mark
> nor me could reproduce so far, so we don't know if we're right about the
> cause.

is there more info about that issue? I could try it

thanks,
jirka
