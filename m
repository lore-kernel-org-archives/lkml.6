Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeC2HXt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:23:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36686 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC2HXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:23:47 -0400
X-Google-Smtp-Source: AIpwx48doKoWErdWfAf+YZGLiTI45yrEP12keKHFbu+rqSexnPc4WgO2/nwht8lp8QNnFchHi7BP2Q==
Date: Thu, 29 Mar 2018 09:23:42 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/8] perf/core improvements and fixes
Message-ID: <20180329072342.o42m6ot5ro2ac6jg@gmail.com>
References: <20180328184919.32287-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328184919.32287-1-acme@kernel.org>
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
> The following changes since commit 631fe154edb0a37308d0116a0f9b7bba9dca6218:
> 
>   perf/x86: Update rdpmc_always_available static key to the modern API (2018-03-27 07:53:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.17-20180328
> 
> for you to fetch changes up to 109d59b900e78834c66657dd4748fcedb9a1fe8d:
> 
>   perf vendor events s390: Add JSON files for IBM z14 (2018-03-27 13:13:39 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Be consistent when checking if a perf_mmap instance had
>   its ring buffer unmmaped, fixing segfaults noticed in
>   'perf trace' (Kan Liang, Arnaldo Carvalho de Melo)
> 
> - Avoid adding the same option multiple times to the 'diff'
>   command in check-headers.sh (Jiri Olsa)
> 
> - Add vendor event files (JSON format) to various IBM
>   s390 models (z10EC, z10BC, z196, zEC12, zBC12, z13
>   and z14) (Thomas Richter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf mmap: Be consistent when checking for an unmaped ring buffer
> 
> Jiri Olsa (1):
>       perf build: Fix check-headers.sh opts assignment
> 
> Kan Liang (1):
>       perf mmap: Fix accessing unmapped mmap in perf_mmap__read_done()
> 
> Thomas Richter (5):
>       perf vendor events s390: Add JSON files for IBM z10EC z10BC
>       perf vendor events s390: Add JSON files for IBM z196
>       perf vendor events s390: Add JSON files for IBM zEC12 zBC12
>       perf vendor events s390: Add JSON files for IBM z13
>       perf vendor events s390: Add JSON files for IBM z14
> 
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/pmu-events/arch/s390/cf_z10/basic.json  |  74 +++++
>  tools/perf/pmu-events/arch/s390/cf_z10/crypto.json |  98 ++++++
>  .../perf/pmu-events/arch/s390/cf_z10/extended.json | 110 +++++++
>  tools/perf/pmu-events/arch/s390/cf_z13/basic.json  |  74 +++++
>  tools/perf/pmu-events/arch/s390/cf_z13/crypto.json |  98 ++++++
>  .../perf/pmu-events/arch/s390/cf_z13/extended.json | 338 +++++++++++++++++++++
>  tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |  50 +++
>  tools/perf/pmu-events/arch/s390/cf_z14/crypto.json |  98 ++++++
>  .../perf/pmu-events/arch/s390/cf_z14/extended.json | 320 +++++++++++++++++++
>  tools/perf/pmu-events/arch/s390/cf_z196/basic.json |  74 +++++
>  .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |  98 ++++++
>  .../pmu-events/arch/s390/cf_z196/extended.json     | 146 +++++++++
>  .../perf/pmu-events/arch/s390/cf_zec12/basic.json  |  74 +++++
>  .../perf/pmu-events/arch/s390/cf_zec12/crypto.json |  98 ++++++
>  .../pmu-events/arch/s390/cf_zec12/extended.json    | 212 +++++++++++++
>  tools/perf/pmu-events/arch/s390/mapfile.csv        |   6 +
>  tools/perf/util/mmap.c                             |  19 +-
>  18 files changed, 1987 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z10/basic.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z10/extended.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/basic.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/extended.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/basic.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/extended.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/basic.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z196/extended.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
>  create mode 100644 tools/perf/pmu-events/arch/s390/mapfile.csv

Pulled, thanks a lot Arnaldo!

	Ingo
