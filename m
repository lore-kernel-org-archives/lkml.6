Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeC0JHC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:07:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:65448 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751073AbeC0JHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:07:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="28765440"
Date: Tue, 27 Mar 2018 02:06:42 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf stat: avoid 10ms limit for printing event counts
Message-ID: <20180327090642.GP13724@tassilo.jf.intel.com>
References: <8f27e33e-355a-e6f3-30d9-c0fc3ff46c4d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f27e33e-355a-e6f3-30d9-c0fc3ff46c4d@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When running perf stat -I for monitoring e.g. PCIe uncore counters and 
> at the same time profiling some I/O workload by perf record e.g. for 
> cpu-cycles and context switches, it is then possible to build and 
> observe good-enough consolidated CPU/OS/IO(Uncore) performance picture 
> for that workload.

At some point I still hope we can make uncore measurements in 
perf record work. Kan tried at some point to allow multiple
PMUs in a group, but was not successfull. But perhaps we
can sample them from a software event instead.

> 
> The warning on possible runtime overhead is still preserved, however 
> it is only visible when specifying -v option.

I would print it unconditionally. Very few people use -v.

BTW better of course would be to occasionally measure the perf stat 
cpu time and only print the warning if it's above some percentage
of a CPU. But that would be much more work.

Rest looks ok.


-Andi
