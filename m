Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5792AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95D620834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhkPRCkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95D620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeJZQB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:01:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32778 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:01:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so3537794wmd.0;
        Fri, 26 Oct 2018 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKqzJcqP3H9upeFleUX6dD1IHOqQiOlG1ckS7AFUc+Y=;
        b=YhkPRCkrU3kTtewA7bXxAHsY92T4ZMK5DPb3mTWp18pyhc+4XYa12k6WZHWZsi5N+o
         oP5xbjfZPeCdnArpek8uRmOX6jdyIsr7hC/8p8aj2jo1lja+MLIzO2luhAqc9Je5xeSu
         COnbPpglXAb2jZ5VYw/ydxKWx6Zr74dO/Q3X7yBcSlkaiq5jAEHTqjqzyGbSd83Y+I2q
         N1FE+nC6rJ1nx5n4VwwlfFt2IqIV9JZo+kH1dz5R70U7jNfcGO2uSOpLityGKGW4PJrE
         lP6M2Vf6qB4F5y6z+iJdrzHuBTAursxgI1QZ8xyiFSGCdWo1eGkhisfxNdinjL5nNlyk
         jXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKqzJcqP3H9upeFleUX6dD1IHOqQiOlG1ckS7AFUc+Y=;
        b=sA4ZJU17pgQFK9iUcolUOdBqEQTHcJ0OM/vAAYqzxvH9F+6XcEAmgYl31PO4KDSC9f
         DhVdy1qMAMd+LYzHSXeMWkGbeEszgYdakUhFmNBY4tCQiThyJ8OwVWaCwaqLNsg6yanT
         letwjDVbXGH5jWbkH/f2IxhQLjCFZmTOCIae16xMTnh2viYcoIKDnK+RYLctKDKfk8qI
         8x9kKptfcu1gsiQdvnrHCnBl6y28+i525dyi1KUzPEhYU2caw/ojw8cf0c9P56os9o+6
         wmp3yZkLax3QjwqxU6Ma3ugryo6+OatliJmusYmyuGWtW1xalfqCrLjlXBReCi/4A3BF
         YeuA==
X-Gm-Message-State: AGRZ1gIl534HBcxnR3ALAcv8huIFrczSRafOWOkjv7nx2WGaxcJ8zvyz
        yHaB/CsOuB/pRR1cp0pvAa8=
X-Google-Smtp-Source: AJdET5eiH4dK9V2yXCyQiBq38qOkiPk0960OA3ajyS0tyywX+al24DKv3yj6RXpuut+mePv2jocjug==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr4321175wma.69.1540538732675;
        Fri, 26 Oct 2018 00:25:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b143-v6sm5275527wma.28.2018.10.26.00.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 00:25:31 -0700 (PDT)
Date:   Fri, 26 Oct 2018 09:25:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Tolnay <dtolnay@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Hemant Kumar <hemant@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Hongxu Jia <hongxu.jia@windriver.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Li Bin <huawei.libin@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        =?iso-8859-1?Q?Rud=E1?= Moura <ruda.moura@gmail.com>,
        =?iso-8859-1?Q?S=E9bastien?= Boisvert <sboisvert@gydle.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>, zhangmengting@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 00/37] perf/core improvements and fixes
Message-ID: <20181026072528.GA5782@gmail.com>
References: <20181025111031.3440-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
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
> The following changes since commit ce6c9da1113ad681bff27a3e376d2017f7f8a59c:
> 
>   Merge remote-tracking branch 'tip/perf/urgent' into perf/core (2018-10-18 11:13:01 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.20-20181025
> 
> for you to fetch changes up to fe57120e18a1f9124ca758c89cc54f91333d1847:
> 
>   perf script: Support total cycles count (2018-10-24 15:29:56 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Introduce 'perf trace --max-events' for stopping 'perf trace' when
>   that many syscalls (enter+exit), tracepoints or other events such as
>   page faults take place.
> 
>   Support that as well on a per-event basis, e.g.:
> 
>    perf trace -e sched:*switch/nr=2/,block:*_plug/nr=4/,block:*_unplug/nr=1/,net:*dev_queue/nr=3,max-stack=16/
> 
>   Will stop when 2 context switches, 4 block plugs, 1 block unplug and
>   3 net_dev_queue tracepoints take place. (Arnaldo Carvalho de Melo)
> 
> - Poll for monitored tasks being alive in 'perf stat -p/-t', exiting when
>   those tasks all terminate (Jiri Olsa)
> 
> - Encode -k clockid frequency into perf.data to enable timestamps derived
>   metrics conversion into wall clock time on reporting stage. (Alexey Budankov)
> 
> - Improve Intel PT call graph from SQL database and GUI python scripts,
>   including adopting the Qt MDI interface to allow for multiple subwindows
>   for all the tables, helping in better visualizing the data in the SQL
>   tables, also uses, when available, the Intel XED disassembler libraries
>   to present the Intel PT data as x86 asm mnemonics. This last feature
>   is not currently working in some cases, fix is being discussed (Adrian Hunter)
> 
> - Implement a ftrace function_graph view in 'perf script' when processing
>   hardware trace data such as Intel PT (Andi Kleen)
> 
> - Better integration with the Intel XED disassembler, when available, in
>   'perf script' (Andi Kleen)
> 
> - Some 'perf trace' drop refcount fixes (Arnaldo Carvalho de Melo)
> 
> - Add Sparc support to 'perf annotate', jitdump (David Miller)
> 
> - Fix PLT symbols entry/header sizes properly on Sparc (David Miller)
> 
> - Fix generation of system call table failure with /tmp mounted with 'noexec'
>   in arm64 (Hongxu Jia)
> 
> - Allow extended console debug output in 'perf script' (Milian Wolff)
> 
> - Flush output stream after events in 'perf script' verbose mode (Milian Wolff)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (17):
>       perf scripts python: call-graph-from-sql.py: Use SPDX license identifier
>       perf scripts python: call-graph-from-sql.py: Provide better default column sizes
>       perf scripts python: call-graph-from-sql.py: Set a minimum window size
>       perf scripts python: call-graph-from-sql.py: Change icon
>       perf scripts python: call-graph-from-sql.py: Make a "Main" function
>       perf scripts python: call-graph-from-sql.py: Separate the database details into a class
>       perf scripts python: call-graph-from-sql.py: Add a class for global data
>       perf scripts python: call-graph-from-sql.py: Remove use of setObjectName()
>       perf scripts python: call-graph-from-sql.py: Factor out CallGraphModel from TreeModel
>       perf scripts python: call-graph-from-sql.py: Add data helper functions
>       perf scripts python: call-graph-from-sql.py: Refactor TreeItem class
>       perf scripts python: call-graph-from-sql.py: Rename to exported-sql-viewer.py
>       perf scripts python: exported-sql-viewer.py: Add support for multiple sub-windows
>       perf scripts python: exported-sql-viewer.py: Add ability to find symbols in the call-graph
>       perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font
>       perf scripts python: exported-sql-viewer.py: Add ability to display all the database tables
>       perf scripts python: exported-sql-viewer.py: Add All branches report
> 
> Alexey Budankov (1):
>       perf record: Encode -k clockid frequency into Perf trace
> 
> Andi Kleen (5):
>       perf script: Add --insn-trace for instruction decoding
>       perf script: Make itrace script default to all calls
>       tools script: Add --call-trace and --call-ret-trace
>       perf script: Implement --graph-function
>       perf script: Support total cycles count
> 
> Arnaldo Carvalho de Melo (7):
>       tools lib subcmd: Introduce OPTION_ULONG
>       perf trace: Introduce --max-events
>       perf evsel: Introduce per event max_events property
>       perf evsel: Mark a evsel as disabled when asking the kernel do disable it
>       perf trace: Drop addr_location refcounts
>       perf trace: Drop thread refcount in trace__event_handler()
>       perf trace: Introduce per-event maximum number of events property
> 
> David Miller (3):
>       perf annotate: Add Sparc support
>       perf jitdump: Add Sparc support.
>       perf symbols: Set PLT entry/header sizes properly on Sparc
> 
> Hongxu Jia (1):
>       perf arm64: Fix generate system call table failed with /tmp mounted with noexec
> 
> Jiri Olsa (1):
>       perf stat: Poll for monitored tasks being alive
> 
> Milian Wolff (2):
>       perf script: Allow extended console debug output
>       perf script: Flush output stream after events in verbose mode
> 
>  tools/lib/subcmd/parse-options.c                  |   19 +
>  tools/lib/subcmd/parse-options.h                  |    2 +
>  tools/perf/Documentation/build-xed.txt            |   19 +
>  tools/perf/Documentation/intel-pt.txt             |    2 +-
>  tools/perf/Documentation/itrace.txt               |    7 +-
>  tools/perf/Documentation/perf-script.txt          |   18 +
>  tools/perf/Documentation/perf-trace.txt           |   67 +
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl |    2 +-
>  tools/perf/arch/sparc/Makefile                    |    2 +
>  tools/perf/arch/sparc/annotate/instructions.c     |  169 ++
>  tools/perf/builtin-record.c                       |   24 +-
>  tools/perf/builtin-script.c                       |  166 +-
>  tools/perf/builtin-stat.c                         |   24 +
>  tools/perf/builtin-trace.c                        |   50 +-
>  tools/perf/perf.h                                 |    1 +
>  tools/perf/scripts/python/call-graph-from-sql.py  |  339 ----
>  tools/perf/scripts/python/export-to-postgresql.py |    2 +-
>  tools/perf/scripts/python/export-to-sqlite.py     |    2 +-
>  tools/perf/scripts/python/exported-sql-viewer.py  | 2128 +++++++++++++++++++++
>  tools/perf/util/annotate.c                        |    8 +
>  tools/perf/util/auxtrace.c                        |   17 +-
>  tools/perf/util/auxtrace.h                        |    5 +-
>  tools/perf/util/cs-etm.c                          |    3 +-
>  tools/perf/util/env.h                             |    1 +
>  tools/perf/util/evlist.c                          |    2 +-
>  tools/perf/util/evsel.c                           |   27 +-
>  tools/perf/util/evsel.h                           |    5 +
>  tools/perf/util/genelf.h                          |    6 +
>  tools/perf/util/header.c                          |   23 +
>  tools/perf/util/header.h                          |    1 +
>  tools/perf/util/intel-bts.c                       |    3 +-
>  tools/perf/util/intel-pt.c                        |    3 +-
>  tools/perf/util/parse-events.c                    |    8 +
>  tools/perf/util/parse-events.h                    |    1 +
>  tools/perf/util/parse-events.l                    |    1 +
>  tools/perf/util/symbol-elf.c                      |   12 +-
>  tools/perf/util/symbol.h                          |    3 +-
>  tools/perf/util/thread.h                          |    2 +
>  38 files changed, 2778 insertions(+), 396 deletions(-)
>  create mode 100644 tools/perf/Documentation/build-xed.txt
>  create mode 100644 tools/perf/arch/sparc/annotate/instructions.c
>  delete mode 100644 tools/perf/scripts/python/call-graph-from-sql.py
>  create mode 100755 tools/perf/scripts/python/exported-sql-viewer.py

Pulled, thanks a lot Arnaldo!

	Ingo
