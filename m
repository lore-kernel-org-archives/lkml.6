Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934336AbeCEMVq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:21:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933542AbeCEMVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:21:45 -0500
Date: Mon, 5 Mar 2018 12:21:40 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Saravana Kannan <skannan@codeaurora.org>
Cc: suzuki.poulose@arm.com, Peter Zijlstra <peterz@infradead.org>,
        rananta@codeaurora.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        avilaj@codeaurora.org, Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/core: Add support for PMUs that can be read from
 more than 1 CPU
Message-ID: <20180305122140.wwwu4hvhssouuzcp@lakrids.cambridge.arm.com>
References: <1520039693-30914-1-git-send-email-skannan@codeaurora.org>
 <20180305121702.l64rzrckog6d7jop@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305121702.l64rzrckog6d7jop@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 12:17:02PM +0000, Mark Rutland wrote:
> On Fri, Mar 02, 2018 at 05:14:53PM -0800, Saravana Kannan wrote:

> > @@ -629,6 +629,7 @@ struct perf_event {
> >  
> >  	int				oncpu;
> >  	int				cpu;
> > +	cpumask_t			readable_on_cpus;
> 
> For most PMUs, this will be emptry, and it's potentially *very* large
> (e.g. on systems where NR_CPUS is 4096). Please use a poitner to a mask,
> as I suggested in [1], e.g.

> [1] https://lkml.kernel.org/r/20171128124534.3jvuala525wvn64r@wfg-t540p.sh.intel.com

Whoops, that should've been:

[1] https://lkml.kernel.org/r/20180225143802.denbkubqjg2dc7af@salmiak

Mark.
