Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDZFdN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:33:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40270 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeDZFdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:33:05 -0400
X-Google-Smtp-Source: AB8JxZo5LS+QbQE5kqRWcxYQclKzprnwglWLjib0LvSLLId3MAzkBsfg3lpgTp+pIt2URj4RbbhNWA==
Date: Thu, 26 Apr 2018 07:33:00 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, kernel-team@lge.com,
        Kim Phillips <kim.phillips@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Martin Vuille <jpmv27@aim.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Sangwon Hong <qpakzk@gmail.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/12] perf/urgent fixes
Message-ID: <20180426053300.hftu657w62235euc@gmail.com>
References: <20180425160008.3407-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
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
> The following changes since commit c042f7e9bb6ad9429ea0f2c9138dc06413198967:
> 
>   Merge tag 'perf-urgent-for-mingo-4.17-20180420' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-04-21 09:38:33 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180425
> 
> for you to fetch changes up to 80ee8c588afde077cb0439e15129579a267916c4:
> 
>   perf stat: Fix duplicate PMU name for interval print (2018-04-24 16:12:00 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf stat:
> 
> - Keep the '/' event modifier separator in fallback, for example when
>   fallbacking from 'cpu/cpu-cycles/' to user level only, where it should
>   become 'cpu/cpu-cycles/u' and not 'cpu/cpu-cycles/:u' (Jiri Olsa)
> 
> - Fix PMU events parsing rule, improving error reporting for
>   invalid events (Jiri Olsa)
> 
> - Disable write_backward and other event attributes for !group
>   events in a group, fixing, for instance this group: '{cycles,msr/aperf/}:S'
>   that has leader sampling (:S) and where just the 'cycles',
>   the leader event, should have the write_backward attribute
>   set, in this case it all fails because the PMU where 'msr/aperf/'
>   lives doesn't accepts write_backward style sampling (Jiri Olsa)
> 
> - Only fall back group read for leader (Kan Liang)
> 
> - Fix core PMU alias list for X86 platform (Kan Liang)
> 
> - Print out hint for mixed PMU group error (Kan Liang)
> 
> - Fix duplicate PMU name for interval print (Kan Liang)
> 
> Core:
> 
> - Set main kernel end address properly when reading kernel and
>   module maps (Namhyung Kim)
> 
> perf mem:
> 
> - Fix incorrect entries and add missing man options (Sangwon Hong)
> 
> s/390:
> 
> - Remove s390 specific strcmp_cpuid_cmp function (Thomas Richter)
> 
> - Adapt 'perf test' case record+probe_libc_inet_pton.sh for s390
> 
> - Fix s390 undefined record__auxtrace_init() return value in
>   'perf record' (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Jiri Olsa (3):
>       perf stat: Keep the / modifier separator in fallback
>       perf pmu: Fix pmu events parsing rule
>       perf evsel: Disable write_backward for leader sampling group events
> 
> Kan Liang (4):
>       perf pmu: Fix core PMU alias list for X86 platform
>       perf stat: Print out hint for mixed PMU group error
>       perf evsel: Only fall back group read for leader
>       perf stat: Fix duplicate PMU name for interval print
> 
> Namhyung Kim (1):
>       perf machine: Set main kernel end address properly
> 
> Sangwon Hong (1):
>       perf mem: Document incorrect and missing options
> 
> Thomas Richter (3):
>       perf list: Remove s390 specific strcmp_cpuid_cmp function
>       perf test: Adapt test case record+probe_libc_inet_pton.sh for s390
>       perf record: Fix s390 undefined record__auxtrace_init() return value
> 
>  tools/perf/Documentation/perf-mem.txt              | 41 +++++++++++++++-------
>  tools/perf/arch/s390/util/auxtrace.c               |  1 +
>  tools/perf/arch/s390/util/header.c                 | 18 ----------
>  tools/perf/builtin-stat.c                          | 40 +++++++++++++++++++--
>  tools/perf/pmu-events/arch/s390/mapfile.csv        | 10 +++---
>  tools/perf/tests/attr/test-record-group-sampling   |  3 ++
>  .../tests/shell/record+probe_libc_inet_pton.sh     |  6 ++--
>  tools/perf/util/evsel.c                            | 18 +++++++---
>  tools/perf/util/evsel.h                            |  1 +
>  tools/perf/util/machine.c                          | 30 +++++++++-------
>  tools/perf/util/parse-events.y                     |  8 ++---
>  tools/perf/util/pmu.c                              | 22 +++++-------
>  12 files changed, 123 insertions(+), 75 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
