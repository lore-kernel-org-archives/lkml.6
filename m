Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030370AbeBNNmA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030202AbeBNNl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:41:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3972B21782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 14 Feb 2018 10:41:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Sangwon Hong <qpakzk@gmail.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] tools/headers: Synchronize kernel ABI headers, v4.16-rc1
Message-ID: <20180214134155.GA3974@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
 <20180213115953.ofveezu2tlcxjrnh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213115953.ofveezu2tlcxjrnh@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 13, 2018 at 12:59:53PM +0100, Ingo Molnar escreveu:
> 
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Hi Ingo,
> > 
> > 	Please consider pulling,
> > 
> > - Arnaldo
> > 
> > Test results at the end of this message, as usual.
> > 
> > The following changes since commit 33ea4b24277b06dbc55d7f5772a46f029600255e:
> > 
> >   perf/core: Implement the 'perf_uprobe' PMU (2018-02-06 11:29:28 +0100)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180206
> > 
> > for you to fetch changes up to 52a37001d51a320c1019269fb3ba473a1363650d:
> > 
> >   perf test: Fix test trace+probe_libc_inet_pton.sh for s390x (2018-02-06 10:46:58 -0300)
> > 
> > ----------------------------------------------------------------
> > perf/core improvements and fixes:
> > 
> > - perf_mmap overwrite mode overhaul, prep work to get 'perf top'
> >   using it, making it bearable to use it in large core count systems
> >   such as Knights Landing/Mill Intel systems (Kan Liang)
> > 
> > - Add perf vendor JSON metrics for ARM Cortex-A53 Processor (William Cohen)
> > 
> > - Use strtoull() instead of home grown function (Andy Shevchenko)
> > 
> > - Document missing 'perf data --force' option (Sangwon Hong)
> > 
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Andy Shevchenko (1):
> >       perf tools: Substitute yet another strtoull()
> > 
> > Arnaldo Carvalho de Melo (1):
> >       perf evsel: Expose the perf_missing_features struct
> > 
> > Kan Liang (16):
> >       perf evlist: Remove stale mmap read for backward
> >       perf mmap: Recalculate size for overwrite mode
> >       perf mmap: Cleanup perf_mmap__push()
> >       perf mmap: Introduce perf_mmap__read_init()
> >       perf mmap: Add new return value logic for perf_mmap__read_init()
> >       perf mmap: Discard 'prev' in perf_mmap__read()
> >       perf mmap: Introduce perf_mmap__read_done()
> >       perf mmap: Introduce perf_mmap__read_event()
> >       perf test: Update mmap read functions for backward-ring-buffer test
> >       perf mmap: Discard legacy interface for mmap read
> >       perf top: Check per-event overwrite term
> >       perf top: Add overwrite fall back
> >       perf hists browser: Add parameter to disable lost event warning
> >       perf top: Remove lost events checking
> >       perf top: Switch default mode to overwrite mode
> >       perf top: Check the latency of perf_top__mmap_read()
> > 
> > Sangwon Hong (1):
> >       perf data: Document missing --force option
> > 
> > Thomas Richter (1):
> >       perf test: Fix test trace+probe_libc_inet_pton.sh for s390x
> > 
> > William Cohen (1):
> >       perf vendor events aarch64: Add JSON metrics for ARM Cortex-A53 Processor
> > 
> >  tools/perf/Documentation/perf-data.txt             |   4 +
> >  tools/perf/builtin-c2c.c                           |   4 +-
> >  tools/perf/builtin-report.c                        |   3 +-
> >  tools/perf/builtin-top.c                           | 150 ++++++++++++++++++++-
> >  .../pmu-events/arch/arm64/cortex-a53/branch.json   |  27 ++++
> >  .../perf/pmu-events/arch/arm64/cortex-a53/bus.json |  22 +++
> >  .../pmu-events/arch/arm64/cortex-a53/cache.json    |  27 ++++
> >  .../pmu-events/arch/arm64/cortex-a53/memory.json   |  22 +++
> >  .../pmu-events/arch/arm64/cortex-a53/other.json    |  32 +++++
> >  .../pmu-events/arch/arm64/cortex-a53/pipeline.json |  52 +++++++
> >  tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
> >  tools/perf/tests/backward-ring-buffer.c            |   7 +-
> >  .../perf/tests/shell/trace+probe_libc_inet_pton.sh |  23 +++-
> >  tools/perf/ui/browsers/hists.c                     |  38 ++++--
> >  tools/perf/ui/browsers/hists.h                     |   3 +-
> >  tools/perf/util/evlist.c                           |  17 ---
> >  tools/perf/util/evlist.h                           |   4 -
> >  tools/perf/util/evsel.c                            |  12 +-
> >  tools/perf/util/evsel.h                            |  14 ++
> >  tools/perf/util/hist.h                             |   6 +-
> >  tools/perf/util/mmap.c                             | 141 ++++++++++---------
> >  tools/perf/util/mmap.h                             |  10 +-
> >  tools/perf/util/util.c                             |  24 +---
> >  23 files changed, 492 insertions(+), 151 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
> >  create mode 100644 tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
> 
> Pulled into tip:perf/urgent, thanks a lot Arnaldo!
> 
> Note, I also performed a header sync with v4.16-rc1, see the patch below.
> 
> The only exception is:
> 
>   Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/unistd.h' differs  from latest version at 'arch/s390/include/uapi/asm/unistd.h'
> 
> ... which I'm unsure how to resolve: the new upstream header includes unistd_64.h, 
> but neither s390 nor asm-generic has no such a file.

There is a patch for that from Hendrik, IIRC, I'll merge it. They worked
on making the syscall table generation process to be similar to the one
used in x86_64 after being exposed to it by means of how 'perf trace'
creates its id->string syscall tables.

- Arnaldo
