Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeDDHFU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:05:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750915AbeDDHFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:05:19 -0400
Date: Wed, 4 Apr 2018 09:05:16 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf stat: enable 1ms interval for printing event
 counters values
Message-ID: <20180404070516.GB2313@krava>
References: <b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 09:18:33PM +0300, Alexey Budankov wrote:
> 
> Currently print count interval for performance counters values is 
> limited by 10ms so reading the values at frequencies higher than 100Hz 
> is restricted by the tool.
> 
> This change makes perf stat -I possible on frequencies up to 1KHz and, 
> to some extent, makes perf stat -I to be on-par with perf record 
> sampling profiling.
> 
> When running perf stat -I for monitoring e.g. PCIe uncore counters and 
> at the same time profiling some I/O workload by perf record e.g. for 
> cpu-cycles and context switches, it is then possible to observe 
> consolidated CPU/OS/IO(Uncore) performance picture for that workload.
> 
> Tool overhead warning printed when specifying -v option can be missed 
> due to screen scrolling in case you have output to the console 
> so message is moved into help available by running perf stat -h.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> 
> Changes in v2:
>  - updated minimum value to 1ms at perf-stat.txt manual

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
