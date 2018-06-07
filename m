Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w8UAGRLBGFv3eQAAmS7hNA
	; Thu, 07 Jun 2018 05:22:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 46A9E6089E; Thu,  7 Jun 2018 05:22:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnLga0v8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6528C607DC;
	Thu,  7 Jun 2018 05:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6528C607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeFGFWX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:22:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39331 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751331AbeFGFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:22:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so16072193wmc.4;
        Wed, 06 Jun 2018 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUzYVJDLCaKtepW9Fi6iVxJKh18f2D2JdJSup+lRN4M=;
        b=MnLga0v8OmQwzTRgdXSCoxhEg9YbXjMfU23+8mHX829XU1BhExBpgzNwX88BJUrjfZ
         nB8IEWnmlv/OtPbA/PeZSqlcHDPetXriuXZk3L9ulDQTLiH6VpfN3s/QRvVGIB36/A6D
         QWXt/OQKJn6nkWuodsHLOKFSPN3Fz00wu8dr79hYzNElq3ifJf3Q2KtidS8BO5tnaqGv
         jzalWVY7a4JuTFZ1+pXxBy3TE88wkUBsxBVtj6pG9A5gFU7A4EGASZbaHcwSiovSKHti
         pgm6O2XHgzNoTDKS8BpKGnf2meblOYH6h3FElCJJzGv9Dil23N7j4FXBDJKPw1Xgd3lk
         BBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUzYVJDLCaKtepW9Fi6iVxJKh18f2D2JdJSup+lRN4M=;
        b=cjKgC0xqYbSDcy5MqYwlLb3xnADJFyrk+qVjbbmYtExhHYauIyVVul77ZpWUDhe4OU
         gfuoHAjCgkPTM9kD6ecob9GgsmUryaJIIFZ+YgB+N8AoAtDMqfPDPsCf1n3Xql+QeuFE
         rgLI1sbGJUypdacFPLTKIWY7TzLevi3OQYSvIdV6Cqw9jMEks4bkv290088roC3q3gWm
         KP4c4iPHhe8/Wy7Z/ZV6ZhGg6ou5ctUSW0G4Na/w4gBmwlJFokOf6y5OSDXHZVUfZfqm
         2krIa9QDwt8wW4jvnj/iVOZsqlmJOMZIZ6vYNlnDJWAvjFXJfjIpBHXWUiswOEFiuIF0
         +Aew==
X-Gm-Message-State: APt69E09m3VceQRysmIgRrTpkdu5e515jdQhHm07NUljE7nNWkYYm7Z0
        QuTP+F8+qKosMnaEL17zNGI=
X-Google-Smtp-Source: ADUXVKKrajSy0jlt2PexXFZ6c8VSnvXJ86k+MtVfXO8zceZ26ziuJfMLSKxKdTbyIW5qVXSp/njjpQ==
X-Received: by 2002:a1c:4203:: with SMTP id p3-v6mr518217wma.111.1528348938666;
        Wed, 06 Jun 2018 22:22:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i46-v6sm54571533wra.36.2018.06.06.22.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:22:17 -0700 (PDT)
Date: Thu, 7 Jun 2018 07:22:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [GIT PULL 00/46] perf/core fixes and improvements
Message-ID: <20180607052214.GA30148@gmail.com>
References: <20180605175030.32549-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 7869e5889477e4e32e4024d665431b35e8b7b693:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-06-04 10:28:20 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.18-20180605
> 
> for you to fetch changes up to 03ac4e71cd120d2c3411d106d00d266114575f74:
> 
>   perf intel-pt: Fix "Unexpected indirect branch" error (2018-06-05 12:28:52 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf stat:
> 
> . Display user and system time for workload targets (Jiri Olsa)
> 
> perf record:
> 
> . Enable arbitrary event names thru name= modifier (Alexey Budankov)
> 
> PowerPC:
> 
> . Add a python script for hypervisor call statistics (Ravi Bangoria)
> 
> Intel PT: (Adrian Hunter)
> 
> . Fix sync_switch INTEL_PT_SS_NOT_TRACING
> 
> . Fix decoding to accept CBR between FUP and corresponding TIP
> 
> . Fix MTC timing after overflow
> 
> . Fix "Unexpected indirect branch" error
> 
> perf test:
> 
> . record+probe_libc_inet_pton:
> 
>   .  To get the symbol table for dynamic
>      shared objects on ubuntu we need to pass the -D/--dynamic command line
>      option, unlike with the fedora distros (Arnaldo Carvalho de Melo)
> 
> . code-reading:
> 
>   . Fix perf_env setup for PTI entry trampolines (Adrian Hunter)
> 
> . kmod-path:
> 
>   . Add tests for vdso32 and vdsox32 (Adrian Hunter)
> 
> . Use header file util/debug.h (Thomas Richter)
> 
> perf annotate:
> 
> . Make the various UI backends (stdio, TUI, gtk) use more consistently
>   structs with annotation options as specified by the user (Arnaldo Carvalho de Melo)
> 
> . Move annotation specific knobs from the symbol_conf global kitchen
>   sink to the annotation option structs (Arnaldo Carvalho de Melo)
> 
> Core:
> 
> . Fix misleading error for some unparsable events mentioning PMUs when
>   those are not involved in the problem (Jiri Olsa)
> 
> - Fix symbol and object code resolution for vdso32 and vdsox32 (Adrian Hunter)
> 
> . No need to check for null when passing pointers to foo__get() style
>   refcount grabbing helpers, just like in the kernel and with free(),
>   its safe to pass a NULL pointer to avoid having to check it before
>   each and every foo__get() call (Arnaldo Carvalho de Melo)
> 
> . Remove some dead code (quote.[ch]) (Arnaldo Carvalho de Melo)
> 
> . Remove some needless globals, making them local (Arnaldo Carvalho de Melo)
> 
> . Reduce usage of symbol_conf.use_callchain, using other means of
>   finding out if callchains are in use or available for specific events,
>   as we evolved this codebase to allow requesting callchains for just
>   a subset of the monitored events. In time it will help polish
>   recording and showing mixed sets accross the various tools:
> 
>     perf record -e cycles/call-graph=fp/,cache-misses/call-graph=dwarf/,instructions
> 
>   (Arnaldo Carvalho de Melo)
> 
> . Consider PTI entry trampolines in map__rip_2objdump() (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (8):
>       perf tests kmod-path: Add tests for vdso32 and vdsox32
>       perf tools: Fix symbol and object code resolution for vdso32 and vdsox32
>       perf test code-reading: Fix perf_env setup for PTI entry trampolines
>       perf map: Consider PTI entry trampolines in rip_2objdump()
>       perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
>       perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
>       perf intel-pt: Fix MTC timing after overflow
>       perf intel-pt: Fix "Unexpected indirect branch" error
> 
> Alexey Budankov (1):
>       perf record: Enable arbitrary event names thru name= modifier
> 
> Arnaldo Carvalho de Melo (33):
>       perf tools: Remove dead quote.[ch] code
>       perf probe: Use return of map__get() to make code more compact
>       perf cgroup: Make evlist__find_cgroup() more compact
>       perf tools: No need to check if the argument to __get() function is NULL
>       perf annotate: Pass perf_evsel instead of just evsel->idx
>       perf annotate: __symbol__acount_cycles doesn't need notes
>       perf annotate: Split allocation of annotated_source struct
>       perf annotate: Introduce constructor/destructor for annotated_source
>       perf annotate: Introduce annotated_source__alloc_histograms
>       perf annotate: __symbol__inc_addr_samples() needs just annotated_source
>       perf annotate: Introduce symbol__hists()
>       perf annotate: Introduce symbol__cycle_hists()
>       perf annotate: Stop using symbol_conf.nr_events global in symbol__hists()
>       perf annotate: Replace symbol__alloc_hists() with symbol__hists()
>       perf tools: Ditch the symbol_conf.nr_events global
>       perf annotate: Add comment about annotated_src->nr_histograms
>       perf annotate stdio: Use annotation_options consistently
>       perf srcline: Introduce map__srcline() to make code more compact
>       perf sort: Introduce addr_map_symbol__srcline() to make code more compact
>       perf srcline: Make hist_entry srcline helper consistent with map's
>       perf annotate: Pass annotation_options to symbol__annotate()
>       perf annotate: Adopt anotation options from symbol_conf
>       perf annotate: Move disassembler_style global to annotation_options
>       perf hists browser: Pass annotation_options from tool to browser
>       perf annotate: Move objdump_path to struct annotation_options
>       perf report: No need to have report_callchain_help as a global
>       perf evsel: Add has_callchain() helper to make code more compact/clear
>       perf script: Check if evsel has callchains before trying to use it
>       perf sched: Use sched->show_callchain where appropriate
>       perf hists: Do not allocate space for callchains for evsels without them
>       perf hists: Introduce hist_entry__has_callchain() method
>       perf hists: Check if a hist_entry has callchains before using them
>       perf test record+probe_libc_inet_pton: Ask 'nm' for dynamic symbols
> 
> Jiri Olsa (2):
>       perf stat: Display user and system time
>       perf tools: Fix pmu events parsing rule
> 
> Ravi Bangoria (1):
>       perf script powerpc: Python script for hypervisor call statistics
> 
> Thomas Richter (1):
>       perf test: Use header file util/debug.h
> 
>  tools/perf/Documentation/perf-list.txt             |   6 +-
>  tools/perf/Documentation/perf-record.txt           |   3 +
>  tools/perf/Documentation/perf-stat.txt             |  40 +++--
>  tools/perf/arch/common.c                           |   4 +-
>  tools/perf/arch/common.h                           |   4 +-
>  tools/perf/builtin-annotate.c                      |  36 ++--
>  tools/perf/builtin-c2c.c                           |   2 +-
>  tools/perf/builtin-kvm.c                           |   2 -
>  tools/perf/builtin-probe.c                         |   3 +-
>  tools/perf/builtin-report.c                        |  39 ++--
>  tools/perf/builtin-sched.c                         |  14 +-
>  tools/perf/builtin-script.c                        |  12 +-
>  tools/perf/builtin-stat.c                          |  28 ++-
>  tools/perf/builtin-top.c                           |  48 +++--
>  tools/perf/builtin-trace.c                         |   2 +-
>  tools/perf/perf.c                                  |   1 -
>  .../perf/scripts/python/bin/powerpc-hcalls-record  |   2 +
>  .../perf/scripts/python/bin/powerpc-hcalls-report  |   2 +
>  tools/perf/scripts/python/powerpc-hcalls.py        | 200 +++++++++++++++++++++
>  tools/perf/tests/code-reading.c                    |   1 +
>  tools/perf/tests/kmod-path.c                       |  16 ++
>  tools/perf/tests/parse-events.c                    |   4 +-
>  tools/perf/tests/python-use.c                      |   3 +-
>  .../tests/shell/record+probe_libc_inet_pton.sh     |   2 +-
>  tools/perf/ui/browsers/annotate.c                  |  21 ++-
>  tools/perf/ui/browsers/hists.c                     |  43 +++--
>  tools/perf/ui/browsers/hists.h                     |   3 +
>  tools/perf/ui/gtk/annotate.c                       |   2 +-
>  tools/perf/ui/gtk/hists.c                          |   5 +-
>  tools/perf/ui/hist.c                               |   2 +-
>  tools/perf/ui/stdio/hist.c                         |   4 +-
>  tools/perf/util/Build                              |   1 -
>  tools/perf/util/annotate.c                         | 160 ++++++++++-------
>  tools/perf/util/annotate.h                         |  53 ++++--
>  tools/perf/util/cgroup.c                           |   9 +-
>  tools/perf/util/dso.c                              |   2 +
>  tools/perf/util/evsel.c                            |   4 +-
>  tools/perf/util/evsel.h                            |   5 +
>  tools/perf/util/header.c                           |  24 ++-
>  tools/perf/util/hist.c                             |  23 ++-
>  tools/perf/util/hist.h                             |  26 ++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  23 ++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   9 +
>  tools/perf/util/intel-pt.c                         |   5 +
>  tools/perf/util/map.c                              |  26 ++-
>  tools/perf/util/map.h                              |   1 +
>  tools/perf/util/parse-events.l                     |  18 +-
>  tools/perf/util/parse-events.y                     |  14 +-
>  tools/perf/util/probe-event.c                      |   3 +-
>  tools/perf/util/quote.c                            |  62 -------
>  tools/perf/util/quote.h                            |  31 ----
>  tools/perf/util/session.c                          |   2 +-
>  tools/perf/util/sort.c                             |  81 +++------
>  tools/perf/util/sort.h                             |   7 +-
>  tools/perf/util/symbol.c                           |   1 -
>  tools/perf/util/symbol.h                           |   3 -
>  tools/perf/util/top.h                              |   3 +-
>  57 files changed, 731 insertions(+), 419 deletions(-)
>  create mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
>  create mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
>  create mode 100644 tools/perf/scripts/python/powerpc-hcalls.py
>  delete mode 100644 tools/perf/util/quote.c
>  delete mode 100644 tools/perf/util/quote.h

Pulled, thanks a lot Arnaldo!

	Ingo
