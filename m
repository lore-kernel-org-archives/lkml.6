Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:20:41 +0000 (UTC)
X-Greylist: delayed 8854 seconds by postgrey-1.34 at mail.kernel.org; Fri, 15 Feb 2019 09:20:34 UTC
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bljhgync"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F107F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F107F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfBOJUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:20:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51005 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfBOJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:20:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id x7so9122762wmj.0;
        Fri, 15 Feb 2019 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HtUTOqCKlO9ZqwHQoRxnhywttGL89EFT0e1QQqdbgU4=;
        b=bljhgyncpyIeCQwZsuBdlnHBvIreqShOVXS7ugn7wgBh2d4iZoHG2lyVe6WQM75H/o
         tCMMWz0Jji8Tss65ZLuC2eH1jG7cB9ftpX6higxRtSh034jsn8cJd9uojyVZllpSo9vp
         hLX6gXQuhILhcFZEnWQB3rfj1LwJwSNsXJKEcZShTFXrwBlxf+J7nl5Q7dsIMGIT8hQT
         bR7UazCE97ZP5XYoyQEdA+PoLuhkOH3fHqmiQ14Gb79HED1f+7G82P0E5SJ3v1Um3P7G
         4Ck5qIhBpS7l943GDX4gCIL4QJzAur+l8i+vY083iEIF7DrstetUgAVcwbR61y7pNcyv
         /DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HtUTOqCKlO9ZqwHQoRxnhywttGL89EFT0e1QQqdbgU4=;
        b=QQnY+UZ1crE7QqBgZylCvd+KY94Tilt5a/rq8973/1asGieazZ6LJlZXjjFqxiRl9p
         NZEkmzmi7iUNcAT8fEajnuxO0em7Mnp2oxtE6aGfYjHBrILhZfdgeZdT+WgEjqzqEBxs
         QU0PXWi84+KM1IfRsmBHPH49BYhlDPnGmY7YeSVy+X/3V2XxCScw6zFnq2w0E8LVkDQp
         q8oaC2U+a3sddKUIG5eK5Wp31nhPlJ5WH6qHXkVbrAJ7sKoEufsaLd66CnoTd8unTEIz
         fiAzw+DaTTyvwt64+gW7SvarnYZr2pGOXfUhqBDvme1qZbBHgfMzZ2mJgXIYeM+tzto5
         vsUQ==
X-Gm-Message-State: AHQUAuZRXHzQL+iFniy+3+NaR4rg5B8VrXfpcee3oywFNaEwyjxTCvoN
        ubSK077GAlNG//8AlHPy+wQ=
X-Google-Smtp-Source: AHgI3IbELwYs57pyNQEfBECiWAyom1q/s++6XGY6KMtqM/3Wgzdhpwb/N3Bv11CC1J2B2icliNukUQ==
X-Received: by 2002:a1c:f406:: with SMTP id z6mr5645948wma.107.1550222407042;
        Fri, 15 Feb 2019 01:20:07 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a184sm5958206wmh.37.2019.02.15.01.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 01:20:06 -0800 (PST)
Date:   Fri, 15 Feb 2019 10:20:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        David Carrillo-Cisneros <davidca@fb.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Paul Clarke <pc@us.ibm.com>, Song Liu <songliubraving@fb.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL 00/43] perf/core improvements and fixes
Message-ID: <20190215092002.GA76493@gmail.com>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
> The following changes since commit af63147c1edacfb75a28885a7cd7e6f44e626164:
> 
>   perf/x86/intel: Add counter freezing quirk for Goldmont (2019-02-11 08:00:42 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.1-20190214
> 
> for you to fetch changes up to 44ec8396e2dadf0f0806767642cfac9e04d0d5b1:
> 
>   tools build feature sched_getcpu: Undef _GNU_SOURCE at the end (2019-02-14 15:39:21 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf list:
> 
>   Jiri Olsa:
> 
>   - Display metric expressions for --details option
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Implement --affinity=node|cpu option, leftover, the other patches
>     in this kit were already applied.
> 
> perf trace:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix segfaults due to not properly handling negative file descriptor syscall args.
> 
>   - Fix segfault related to the 'waitid' 'options' prefix showing logic.
> 
>   - Filter out 'gnome-terminal*' if it is a parent of 'perf trace', to reduce the
>     syscall feedback loop in system wide sessions.
> 
> BPF:
> 
>   Song Liu:
> 
>   - Silence "Couldn't synthesize bpf events" warning for EPERM.
> 
> Build system:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix the test-all.c feature detection fast path that was broken for
>     quite a while leading to longer build times.
> 
> Event parsing:
> 
>   Jiri Olsa:
> 
>   - Fix legacy events symbol separator parsing
> 
> cs-etm:
> 
>   Mathieu Poirier:
> 
>   - Fix some error path return errors and plug some memory leaks.
> 
>   - Add proper header file for symbols
> 
>   - Remove unused structure fields.
> 
>   - Modularize auxtrace_buffer fetch, decoder and packet processing loop.
> 
> Vendor events:
> 
>   Paul Clarke:
> 
>   - Add assorted metrics for the Power8 and Power9 architectures.
> 
> perf report:
> 
>   Thomas Richter:
> 
>   - Add s390 diagnostic sampling descriptor size
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (1):
>       perf record: Implement --affinity=node|cpu option
> 
> Arnaldo Carvalho de Melo (11):
>       tools feature: Undef _GNU_SOURCE at the end of feature tests
>       perf beauty ioctl cmd: The 'fd' arg is signed
>       perf trace: Check if the 'fd' is negative when mapping it to pathname
>       perf beauty waitid options: Fix up prefix showing logic
>       tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio
>       perf trace: Filter out gnome-terminal* parent
>       perf coresight: Do not test for libopencsd by default
>       perf unwind: Do not put libunwind-{x86,aarch64} in FEATURE_TESTS_BASIC
>       tools build: Add test-reallocarray.c to test-all.c to fix the build
>       perf build: Add missing FEATURE_CHECK_LDFLAGS-libcrypto
>       tools build feature sched_getcpu: Undef _GNU_SOURCE at the end
> 
> Jiri Olsa (7):
>       perf tools: Compile perf with libperf-in.o instead of libperf.a
>       perf tools: Rename LIB_FILE to LIBPERF_A
>       perf tools: Rename build libperf to perf
>       perf tools: Fix legacy events symbol separator parsing
>       perf list: Display metric expressions for --details option
>       perf header: Get rid of write_it label
>       perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'
> 
> Mathieu Poirier (14):
>       perf cs-etm: Add proper header file for symbols
>       perf cs-etm: Remove unused structure field "state"
>       perf cs-etm: Remove unused structure field "time" and "timestamp"
>       perf cs-etm: Fix wrong return values in error path
>       perf cs-etm: Introducing function cs_etm_decoder__init_dparams()
>       perf cs-etm: Fix memory leak in error path
>       perf cs-etm: Introducing function cs_etm__init_trace_params()
>       perf cs-etm: Fix erroneous comment
>       perf cs-etm: Cleaning up function cs_etm__alloc_queue()
>       perf cs-etm: Rethink kernel address initialisation
>       perf cs-etm: Make cs_etm__run_decoder() queue independent
>       perf cs-etm: Modularize main decoder function
>       perf cs-etm: Modularize main packet processing loop
>       perf cs-etm: Modularize auxtrace_buffer fetch function
> 
> Paul Clarke (8):
>       perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics
>       perf vendor events power8: Dl1_reload, instruction_misses, l2_stats, lsu_rejects, memory & pteg_reloads metrics
>       perf vendor events power8: Branch_prediction, latency, bus_stats, instruction_mix & instruction_stats metrics
>       perf vendor events power8: Translaton & general metrics
>       perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics
>       perf vendor events power9: Dl1_reloads, instruction_misses, l[23]_stats & pteg_reloads metrics
>       perf vendor events power9: Branch_prediction, instruction_stats, latency, lsu_rejects, memory, prefetch & translation metrics
>       perf vendor events power9: General metrics
> 
> Song Liu (1):
>       perf utils: Silence "Couldn't synthesize bpf events" warning for EPERM
> 
> Thomas Richter (1):
>       perf report: Add s390 diagnosic sampling descriptor size
> 
>  tools/build/Makefile.feature                       |   10 +-
>  tools/build/feature/test-all.c                     |   10 +-
>  tools/build/feature/test-get_current_dir_name.c    |    1 +
>  tools/build/feature/test-libpython.c               |    1 +
>  tools/build/feature/test-reallocarray.c            |    2 +
>  tools/build/feature/test-sched_getcpu.c            |    2 +
>  tools/build/feature/test-setns.c                   |    1 +
>  tools/perf/Build                                   |   10 +-
>  tools/perf/Documentation/perf-record.txt           |    5 +
>  tools/perf/Makefile.config                         |   14 +-
>  tools/perf/Makefile.perf                           |   24 +-
>  tools/perf/arch/Build                              |    4 +-
>  tools/perf/arch/arm/Build                          |    4 +-
>  tools/perf/arch/arm/tests/Build                    |    8 +-
>  tools/perf/arch/arm/util/Build                     |    8 +-
>  tools/perf/arch/arm64/Build                        |    4 +-
>  tools/perf/arch/arm64/tests/Build                  |    6 +-
>  tools/perf/arch/arm64/util/Build                   |   12 +-
>  tools/perf/arch/nds32/Build                        |    2 +-
>  tools/perf/arch/nds32/util/Build                   |    2 +-
>  tools/perf/arch/powerpc/Build                      |    4 +-
>  tools/perf/arch/powerpc/tests/Build                |    6 +-
>  tools/perf/arch/powerpc/util/Build                 |   18 +-
>  tools/perf/arch/s390/Build                         |    2 +-
>  tools/perf/arch/s390/util/Build                    |   12 +-
>  tools/perf/arch/sh/Build                           |    2 +-
>  tools/perf/arch/sh/util/Build                      |    2 +-
>  tools/perf/arch/sparc/Build                        |    2 +-
>  tools/perf/arch/sparc/util/Build                   |    2 +-
>  tools/perf/arch/x86/Build                          |    4 +-
>  tools/perf/arch/x86/tests/Build                    |   14 +-
>  tools/perf/arch/x86/util/Build                     |   30 +-
>  tools/perf/arch/xtensa/Build                       |    2 +-
>  tools/perf/arch/xtensa/util/Build                  |    2 +-
>  tools/perf/builtin-list.c                          |    8 +-
>  tools/perf/builtin-record.c                        |   18 +
>  tools/perf/builtin-trace.c                         |    6 +-
>  .../pmu-events/arch/powerpc/power8/metrics.json    | 2245 ++++++++++++++++++++
>  .../pmu-events/arch/powerpc/power9/metrics.json    | 1982 +++++++++++++++++
>  tools/perf/scripts/Build                           |    4 +-
>  tools/perf/scripts/perl/Perf-Trace-Util/Build      |    2 +-
>  tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
>  tools/perf/tests/parse-events.c                    |   30 +
>  tools/perf/trace/beauty/Build                      |   26 +-
>  tools/perf/trace/beauty/ioctl.c                    |    2 +-
>  tools/perf/trace/beauty/waitid_options.c           |    2 +-
>  tools/perf/ui/Build                                |   18 +-
>  tools/perf/ui/browsers/Build                       |   10 +-
>  tools/perf/ui/tui/Build                            |    8 +-
>  tools/perf/util/Build                              |  276 +--
>  tools/perf/util/bpf-event.c                        |    4 +-
>  tools/perf/util/c++/Build                          |    4 +-
>  tools/perf/util/cs-etm-decoder/Build               |    2 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   10 +-
>  tools/perf/util/cs-etm.c                           |  458 ++--
>  tools/perf/util/cs-etm.h                           |    4 +-
>  tools/perf/util/header.c                           |    8 +-
>  tools/perf/util/intel-pt-decoder/Build             |    2 +-
>  tools/perf/util/metricgroup.c                      |    8 +-
>  tools/perf/util/metricgroup.h                      |    3 +-
>  tools/perf/util/parse-events.c                     |    2 +-
>  tools/perf/util/parse-events.y                     |    4 +-
>  tools/perf/util/s390-cpumsf.c                      |    5 +
>  tools/perf/util/scripting-engines/Build            |    4 +-
>  64 files changed, 4877 insertions(+), 512 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json

Pulled, thanks a lot Arnaldo!

	Ingo
