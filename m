Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F73C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57E520865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrVtzdOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57E520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392307AbeKVRcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:32:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54241 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeKVRcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:32:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so4517254wmi.3;
        Wed, 21 Nov 2018 22:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AUfAsSH41xZOuW/crlRNyG3/Suowa+OzG+GhGlGVAiI=;
        b=JrVtzdOGaoATUX7E4yss+wxUOHNTnypcCRmWTsdb3os4fv9pUDWtmLYndvNADUdrhd
         2r9yVMHPQVjTMnPMjuu3s+11FGvkGAfkqm7bhXPE2gAVp2jqZXFPoI5mknlyR3Bshn3C
         mEHzZk5M5Iego9nzqnSlGBRPac+Tsed3khz4wLWkZIGvAx0N/g3DVARBRLgWx2TgxEyr
         V15ynA70AnB9DoP9gg844w3vZL8YrxCJcObfluozTL6IQez4VmNPkUbrIpeINcc+D9ij
         o2vgF31+NlvzJ/BammRs6iUaHpi0VualfaJ8DMibx1VQMKlXckeHgrmWp19F+71gkJO+
         XB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AUfAsSH41xZOuW/crlRNyG3/Suowa+OzG+GhGlGVAiI=;
        b=OHU3akw1gkQKK0JJbl1EIuDW6P5cuqJSkHwVblv5kvzYaAEealkYPLefdgeegUkDJV
         eSwtpaFNr7/RyfJuoJJ2vXrbdRN1RAZu59mSz6v5DKTd2VBF8ZUVx1ypN4X1haXAXZiP
         qV9LKmQbybYO6V3Ad0eEPB7maLH9emmtoZqefRPRozCZ7uXloUKT0ONhg7bXoNzNguRb
         zH2XnaTmwRMpbz51IBdWHwLbKoofguc8Uu60lDA7jcPrpXzkUfDqe9Zk/spmJ/VdE5vJ
         X4KE8U7OflfsaMXQ6/RrMBvoCZu9X5UFAW8245+Rv7bXHEWmWQBvavuKrgiIpEYz8Sjb
         nbZg==
X-Gm-Message-State: AGRZ1gLrITAB2AGXV7Xl3YZBcxDlnlQbxbTTbwBWjBeDUHq6kAEtZRLh
        9bwnBi0oWweqJ8/WChN7dac=
X-Google-Smtp-Source: AJdET5fqAAQvodTMOZfsu0h/p48agmKJgwipcodg23hl4UVlUIoPAO5O97nbGP1Cnfb0cv6GbEqGEw==
X-Received: by 2002:a1c:28c6:: with SMTP id o189-v6mr8086136wmo.89.1542869650388;
        Wed, 21 Nov 2018 22:54:10 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s66sm3390813wmf.34.2018.11.21.22.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 22:54:09 -0800 (PST)
Date:   Thu, 22 Nov 2018 07:54:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@samba.org>,
        Ben Gainey <ben.gainey@arm.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        David Ahern <dsahern@gmail.com>,
        David Aldridge <david.aldridge@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Edward Cree <ecree@solarflare.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Gustavo Luiz Duarte <gduarte@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Pu Wen <puwen@hygon.cn>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Rob Gardner <rob.gardner@oracle.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>,
        yuzhoujian@didichuxing.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/28] perf/core improvements and fixes
Message-ID: <20181122065406.GA122927@gmail.com>
References: <20181122033611.15890-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling, some from before the trip to Vancouver,
> some that were more easy to process before I continue with the backlog.
> Took a bit more time than I antecipated due to fixing build breakage in
> various places due to multiple patches.  This has tip/perf/urgent
> merged.
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b1a9d7b0190119dad5b9b7841751b5a7586bbc8b:
> 
>   Merge tag 'perf-urgent-for-mingo-4.20-20181121' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-11-21 15:57:21 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20181122
> 
> for you to fetch changes up to f4a0742b3cc1d03b2ff448017b8c714a77e5a261:
> 
>   perf pmu: Move *_cpuid_str() weak functions to header.c (2018-11-21 22:39:59 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Start using BPF maps in 'perf trace' for filters in the augmented syscalls
>   code, keeping the existing code for tracepoint filters so that we can switch
>   back and forth while getting everything BPFied (Arnaldo Carvalho de Melo)
> 
> - Suppress potential format-truncation warning in the PMU code (Ben Hutchings)
> 
> - Introduce 'perf bench epoll', with "wait" and "ctl" benchmarks (Davidlohr Bueso)
> 
> - Fix slowness due to -ffunction-section, do it by sorting the maps by name, so
>   avoiding the using rb_first/next to traverse all entries looking for a map name,
>   that with --ffunction-section gets to thousands of maps (Eric Saint-Etienne)
> 
> - Separate jvmti cmlr check (Jiri Olsa)
> 
> - Allow using the stepping when figuring out which JSON files to use for a x86
>   processor, so that Cascadelake server can be support, which has the same
>   cpuid as some other processor, being different only in the stepping (Kan Liang)
> 
> - Share code and output format for uregs and iregs 'perf script' output (Milian Wolff)
> 
> - Use perf_evsel__is_clocki() for clock events in 'perf stat' (Ravi Bangoria)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (15):
>       perf bpf: Add unistd.h to the headers accessible to bpf proggies
>       perf augmented_syscalls: Filter on a hard coded pid
>       perf augmented_syscalls: Remove needless linux/socket.h include
>       perf bpf: Add defines for map insertion/lookup
>       perf bpf: Add simple pid_filter class accessible to BPF proggies
>       perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter
>       perf augmented_syscalls: Use pid_filter
>       perf evlist: Rename perf_evlist__set_filter* to perf_evlist__set_tp_filter*
>       perf trace: Add "_from_option" suffix to trace__set_filter()
>       perf trace: See if there is a map named "filtered_pids"
>       perf trace: Fill in BPF "filtered_pids" map when present
>       perf augmented_syscalls: Remove example hardcoded set of filtered pids
>       Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"
>       perf bpf: Reduce the hardcoded .max_entries for pid_maps
>       tools build feature: Check if eventfd() is available
> 
> Ben Hutchings (1):
>       perf pmu: Suppress potential format-truncation warning
> 
> Davidlohr Bueso (3):
>       perf bench: Move HAVE_PTHREAD_ATTR_SETAFFINITY_NP into bench.h
>       perf bench: Add epoll parallel epoll_wait benchmark
>       perf bench: Add epoll_ctl(2) benchmark
> 
> Eric Saint-Etienne (1):
>       perf symbols: Fix slowness due to -ffunction-section
> 
> Jiri Olsa (1):
>       perf jvmti: Separate jvmti cmlr check
> 
> Kan Liang (3):
>       perf vendor events: Add stepping in CPUID string for x86
>       perf vendor events: Add JSON metrics for Cascadelake server
>       perf pmu: Move *_cpuid_str() weak functions to header.c
> 
> Milian Wolff (2):
>       perf script: Add newline after uregs output
>       perf script: Share code and output format for uregs and iregs output
> 
> Pu Wen (1):
>       perf tools: Add Hygon Dhyana support
> 
> Ravi Bangoria (1):
>       perf stat: Use perf_evsel__is_clocki() for clock events
> 
>  tools/build/Makefile.feature                       |     1 +
>  tools/build/feature/Makefile                       |     8 +
>  tools/build/feature/test-all.c                     |     5 +
>  tools/build/feature/test-eventfd.c                 |     9 +
>  tools/build/feature/test-jvmti-cmlr.c              |    11 +
>  tools/build/feature/test-jvmti.c                   |     1 -
>  tools/perf/Documentation/perf-bench.txt            |    10 +
>  tools/perf/Makefile.config                         |    12 +-
>  tools/perf/Makefile.perf                           |     3 +
>  tools/perf/arch/x86/util/header.c                  |    66 +-
>  tools/perf/arch/x86/util/kvm-stat.c                |     2 +-
>  tools/perf/bench/Build                             |     3 +
>  tools/perf/bench/bench.h                           |    14 +
>  tools/perf/bench/epoll-ctl.c                       |   413 +
>  tools/perf/bench/epoll-wait.c                      |   540 +
>  tools/perf/bench/futex.h                           |    12 -
>  tools/perf/builtin-bench.c                         |    13 +
>  tools/perf/builtin-script.c                        |    38 +-
>  tools/perf/builtin-trace.c                         |    92 +-
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |    10 +-
>  tools/perf/include/bpf/bpf.h                       |    19 +
>  tools/perf/include/bpf/pid_filter.h                |    21 +
>  tools/perf/include/bpf/unistd.h                    |    10 +
>  tools/perf/jvmti/libjvmti.c                        |    12 +
>  .../pmu-events/arch/x86/cascadelakex/cache.json    | 10172 +++++++++++++++++++
>  .../arch/x86/cascadelakex/clx-metrics.json         |   164 +
>  .../arch/x86/cascadelakex/floating-point.json      |    85 +
>  .../pmu-events/arch/x86/cascadelakex/frontend.json |   482 +
>  .../pmu-events/arch/x86/cascadelakex/memory.json   |  9909 ++++++++++++++++++
>  .../pmu-events/arch/x86/cascadelakex/other.json    |  8908 ++++++++++++++++
>  .../pmu-events/arch/x86/cascadelakex/pipeline.json |   969 ++
>  .../arch/x86/cascadelakex/uncore-memory.json       |   117 +
>  .../arch/x86/cascadelakex/uncore-other.json        |   255 +
>  .../arch/x86/cascadelakex/virtual-memory.json      |   285 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv         |     3 +-
>  tools/perf/util/evlist.c                           |    10 +-
>  tools/perf/util/evlist.h                           |     6 +-
>  tools/perf/util/header.c                           |    39 +
>  tools/perf/util/map.c                              |    27 +
>  tools/perf/util/map.h                              |     2 +
>  tools/perf/util/pmu.c                              |    47 +-
>  tools/perf/util/stat-shadow.c                      |     3 +-
>  tools/perf/util/symbol.c                           |    15 +-
>  43 files changed, 32711 insertions(+), 112 deletions(-)
>  create mode 100644 tools/build/feature/test-eventfd.c
>  create mode 100644 tools/build/feature/test-jvmti-cmlr.c
>  create mode 100644 tools/perf/bench/epoll-ctl.c
>  create mode 100644 tools/perf/bench/epoll-wait.c
>  create mode 100644 tools/perf/include/bpf/pid_filter.h
>  create mode 100644 tools/perf/include/bpf/unistd.h
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json

Pulled, thanks a lot Arnaldo!

	Ingo
