Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeESLeG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:34:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45711 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeESLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:34:03 -0400
X-Google-Smtp-Source: AB8JxZrH9HYk9+zM5FqkBWRFwOCnUKbHtn57Jr3AOgw9CMw5KSfwqVZhJ4EWKy/bK6CIcT912VK1ig==
Date: Sat, 19 May 2018 13:33:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/18] perf/core improvements and fixes
Message-ID: <20180519113358.GA784@gmail.com>
References: <20180519105507.16450-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519105507.16450-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 5aafae8d097e2161ee5c6a12ad532100f8885d2b:
> 
>   Merge tag 'perf-core-for-mingo-4.18-20180516' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-05-16 17:56:43 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180519
> 
> for you to fetch changes up to 19422a9f2a3be7f3a046285ffae4cbb571aa853a:
> 
>   perf tools: Fix kernel_start for PTI on x86 (2018-05-19 06:42:51 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Record min/max LBR cycles (>= skylake) and add 'perf annotate' TUI
>   hotkey to show it (c) (Jin Yao)
> 
> - Fix machine->kernel_start for PTI on x86 (Adrian Hunter)
> 
> - Make machine->env->arch always available, e.g. in 'perf top', not
>   just when reading that info from perf.data files (Adrian Hunter)
> 
> - Reduce the number of files read at 'perf' start, leaving information such as
>   cacheline size, tracefs mount point determination, max_stack, etc, to be
>   lazily read as tools needs then (Arnaldo Carvalho de Melo)
> 
> - Fixup BPF include and examples install messages (Arnaldo Carvalho de Melo)
> 
> - Fixup callchain addresses and symbol offsets in 'perf script', to help
>   correlating with objdump output (Sandipan Das)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf machine: Add machine__is() to identify machine arch
>       perf tools: Fix kernel_start for PTI on x86
> 
> Arnaldo Carvalho de Melo (12):
>       perf config: Call perf_config__init() lazily
>       tools lib api: The tracing_mnt variable doesn't need to be global
>       tools lib api: Unexport 'tracing_path' variable
>       tools lib api fs tracing_path: Introduce get/put_events_file() helpers
>       perf tools: Reuse the path to the tracepoint /events/ directory
>       perf parse-events: Use get/put_events_file()
>       tools lib api fs tracing_path: Introduce opendir() method
>       tools lib api fs tracing_path: Make tracing_events_path private
>       tools include compiler-gcc: Add __pure attribute helper
>       perf tools: Read the cache line size lazily
>       perf tools: No need to unconditionally read the max_stack sysctls
>       perf bpf: Fixup include and examples install messages
> 
> Jin Yao (2):
>       perf annotate: Record the min/max cycles
>       perf annotate: Create hotkey 'c' to show min/max cycles
> 
> Sandipan Das (2):
>       perf script: Show virtual addresses instead of offsets
>       perf script: Show symbol offsets by default
> 
>  tools/include/linux/compiler-gcc.h                 |  3 +
>  tools/lib/api/fs/tracing_path.c                    | 40 +++++++++---
>  tools/lib/api/fs/tracing_path.h                    |  9 ++-
>  tools/perf/Makefile.perf                           |  2 +
>  tools/perf/builtin-script.c                        | 26 ++++----
>  tools/perf/builtin-top.c                           |  2 +-
>  tools/perf/builtin-trace.c                         |  2 +-
>  tools/perf/perf.c                                  | 24 +------
>  tools/perf/tests/parse-events.c                    |  9 +--
>  .../tests/shell/record+probe_libc_inet_pton.sh     | 12 ++--
>  tools/perf/ui/browsers/annotate.c                  |  8 +++
>  tools/perf/util/annotate.c                         | 51 ++++++++++++---
>  tools/perf/util/annotate.h                         | 11 +++-
>  tools/perf/util/config.c                           | 16 ++---
>  tools/perf/util/config.h                           |  1 -
>  tools/perf/util/env.c                              | 18 ++++++
>  tools/perf/util/env.h                              |  2 +
>  tools/perf/util/evsel.c                            |  2 +-
>  tools/perf/util/machine.c                          | 18 +++++-
>  tools/perf/util/machine.h                          |  2 +
>  tools/perf/util/parse-events.c                     | 73 +++++++++++++---------
>  tools/perf/util/probe-file.c                       |  3 +-
>  tools/perf/util/sort.c                             |  4 +-
>  tools/perf/util/sort.h                             |  4 +-
>  tools/perf/util/trace-event-info.c                 | 11 ++--
>  tools/perf/util/trace-event.c                      |  8 ++-
>  tools/perf/util/util.c                             | 34 +++++++++-
>  tools/perf/util/util.h                             |  4 +-
>  28 files changed, 279 insertions(+), 120 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
