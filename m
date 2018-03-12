Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCLLYJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:24:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750752AbeCLLYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:24:07 -0400
Date: Mon, 12 Mar 2018 12:24:03 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Oleg Nesterov <onestero@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2 0/8] hw_breakpoint: Breakpoint modification fixes and
 new modify ioctl
Message-ID: <20180312112403.GB23111@krava>
References: <20171129083853.28022-1-jolsa@kernel.org>
 <20180312112041.p6pksk7yj5nhbtju@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312112041.p6pksk7yj5nhbtju@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 12:20:41PM +0100, Ingo Molnar wrote:

SNIP

> > It's also available in here:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/bp
> > 
> > v2 changes:
> >   - added check for the rest of the perf_event_attr fields
> >     to be the same as for kernel event
> >
> > Jiri Olsa (7):
> >       hw_breakpoint: Pass bp_type directly as find_slot_idx argument
> >       hw_breakpoint: Pass bp_type argument to __reserve_bp_slot|__release_bp_slot
> >       hw_breakpoint: Add modify_bp_slot function
> >       hw_breakpoint: Factor out __modify_user_hw_breakpoint function
> >       hw_breakpoint: Add perf_event_attr fields check in __modify_user_hw_breakpoint
> >       perf/core: Move perf_event_attr::sample_max_stack into perf_copy_attr
> >       perf tests: Add breakpoint accounting/modify test
> > 
> > Milind Chabbi (1):
> >       perf/core: fast breakpoint modification via _IOC_MODIFY_ATTRIBUTES.
> > 
> >  include/linux/hw_breakpoint.h         |   7 +++++
> >  include/uapi/linux/perf_event.h       |   2 ++
> >  kernel/events/core.c                  |  53 +++++++++++++++++++++++++++++--
> >  kernel/events/hw_breakpoint.c         | 115 ++++++++++++++++++++++++++++++++++++++++++++++++-------------------
> >  tools/include/uapi/linux/perf_event.h |   2 ++
> >  tools/perf/tests/Build                |   1 +
> >  tools/perf/tests/bp_account.c         | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/tests/builtin-test.c       |   4 +++
> >  tools/perf/tests/tests.h              |   1 +
> >  9 files changed, 344 insertions(+), 36 deletions(-)
> >  create mode 100644 tools/perf/tests/bp_account.c
> 
> Sorry about the late response - I suppose we could try this feature, but the 
> tooling patches don't apply anymore. Mind re-sending a merged version, on top of 
> latest -tip or so?

sure, I'll resend

thanks,
jirka
