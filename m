Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C34B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmNfAvOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C34B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeIYP1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:27:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55581 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbeIYP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:27:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id 206-v6so4664683wmb.5;
        Tue, 25 Sep 2018 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s6fADGR2eKhX68CzeTWECeOcbCfDsCiLmOOA3ysOpnM=;
        b=LmNfAvOUadAUJEIMkDnYERo7tnZES4XAX4ph+ZMc246XDELz2TCB2m+dZajL7WG5jP
         in9MLMgfJKX0g3VNn885jFYqJSXBQXv/HMEaTc4m8h601hy8cc3uKnjy/Jb0ZIMERSJJ
         ZDG4v3Olanx1/CwAqdpnLL5Pqsxy/zruCrDzCRkKJ1XSv7L/HOTQ/lvYzG2/nqyGO8Ky
         SOdjm0I7T2lWNjodsNHkY+Tjh5HuYYFlTCDWYy+Uby3q76DQHMukFL1oGObxDJ/DiNkX
         F+21SbWiK/a7Fb6fTdxRQL33a8Xo+FLJt5zsMpPgsSX+OXS12dHW/B6eYBkdI3rQaJoy
         7cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s6fADGR2eKhX68CzeTWECeOcbCfDsCiLmOOA3ysOpnM=;
        b=Q7ZDIml4GJT4F21YP9v0RlUWJoZ4RIxifwbeFlTUrx+dWPchbMD7dLUXDh/UXUFJTy
         m15foN7peMoTNzmiVYAbZePktg/POfG5uLHEBwlHRJuAc5k7udDliajWGjcxMnDEr3YC
         U7lkQKsPwBmceRq5vyi5dvkHSG78cBZjyokkce056H2hTf3zyqGRVNnmamZLAgWjTZle
         CwTmHNyCXmdiVeiLeRBNYs0jbjgyTz/XGAw19NX+if72DIy8Y6bLg6/A4WIISG+bg74v
         jUhM8CTQTWXXapzB7fXrODVXcQ5c756unHZKlJ+G+jwjtYRziOqAHdBK1XjuhgAMSBmM
         zfSA==
X-Gm-Message-State: ABuFfogh5yLFPpNdgn65zhCEjHGSJOrYaX03U9DQn/v00GAQ6T2x1nSK
        yr6kyK9/hyOMayT4JfEue4g=
X-Google-Smtp-Source: ACcGV60YDUaXeYns5X8m3mhIYYV0ECcSRFzzR9EiZy76Jy8l3hz6jSgMW9X0C6Fv0laXSkOqiWYL0g==
X-Received: by 2002:a1c:889:: with SMTP id 131-v6mr21423wmi.142.1537867263714;
        Tue, 25 Sep 2018 02:21:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j133-v6sm2629229wmd.12.2018.09.25.02.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 02:21:02 -0700 (PDT)
Date:   Tue, 25 Sep 2018 11:21:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jeremie Galarneau <jeremie.galarneau@efficios.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Wang Nan <wangnan0@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/13] perf/core improvements and fixes
Message-ID: <20180925092100.GA20981@gmail.com>
References: <20180919142537.29985-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
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
> The following changes since commit 7f16023bfcc4b1f2bbccf86219dc97473db6e0d6:
> 
>   Merge remote-tracking branch 'acme/perf/urgent' into perf/core (2018-09-18 17:20:41 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.20-20180919
> 
> for you to fetch changes up to 24ef0fd0a1f389b156e6ef0edd71072728831bd9:
> 
>   perf python: Use -Wno-redundant-decls to build with PYTHON=python3 (2018-09-19 10:25:13 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf test:
> 
> - Add watchpoint entry (Ravi Bangoria)
> 
> Build fixes:
> 
> - Initialize perf_data_file fd field to fix building the CTF (trace format)
>   converter with with gcc 4.8.4 on Ubuntu 14.04 (Jérémie Galarneau)
> 
> - Use -Wno-redundant-decls to build with PYTHON=python3 to
>   build the python binding, fixing the build in systems such
>   as Clear Linux (Arnaldo Carvalho de Melo)
> 
> Hardware tracing:
> 
> - Suppress AUX/OVERWRITE records (Alexander Shishkin)
> 
> Infrastructure:
> 
> - Adopt PTR_ERR_OR_ZERO from the kernel and use it in
>   the bpf-loader instead of open coded equivalent (Ding Xiang)
> 
> - Improve the event ordering code to make it clear and fix
>   a bug related to freeing of events when using pipe mode
>   from 'record' to 'inject' (Jiri Olsa)
> 
> - Some prep work to facilitate per-cpu threads to write
>   record data to per-cpu files (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexander Shishkin (1):
>       perf: Suppress AUX/OVERWRITE records
> 
> Arnaldo Carvalho de Melo (1):
>       perf python: Use -Wno-redundant-decls to build with PYTHON=python3
> 
> Ding Xiang (2):
>       tools include: Adopt PTR_ERR_OR_ZERO from the kernel err.h header
>       perf bpf-loader: use PTR_ERR_OR_ZERO inetead of return code
> 
> Jiri Olsa (7):
>       perf ordered_events: Add 'struct ordered_events_buffer' layer
>       perf ordered_events: Prevent crossing max_alloc_size
>       perf tools: Remove perf_tool from event_op2
>       perf tools: Remove perf_tool from event_op3
>       perf auxtrace: Pass struct perf_mmap into mmap__read* functions
>       perf tools: Add 'struct perf_mmap' arg to record__write()
>       perf util: Make copyfile_offset() global
> 
> Jérémie Galarneau (1):
>       perf tools: Initialize perf_data_file fd field
> 
> Ravi Bangoria (1):
>       perf test: Add watchpoint test
> 
>  kernel/events/ring_buffer.c       |  14 ++-
>  tools/include/linux/err.h         |   7 ++
>  tools/perf/builtin-annotate.c     |   7 +-
>  tools/perf/builtin-inject.c       |  37 +++---
>  tools/perf/builtin-record.c       |  51 +++++----
>  tools/perf/builtin-report.c       |   9 +-
>  tools/perf/builtin-script.c       |  38 +++----
>  tools/perf/builtin-stat.c         |  23 ++--
>  tools/perf/tests/Build            |   1 +
>  tools/perf/tests/builtin-test.c   |   9 ++
>  tools/perf/tests/tests.h          |   3 +
>  tools/perf/tests/wp.c             | 229 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.c        |  30 +++--
>  tools/perf/util/auxtrace.h        |  21 ++--
>  tools/perf/util/bpf-loader.c      |   2 +-
>  tools/perf/util/data-convert-bt.c |   2 +-
>  tools/perf/util/header.c          |  16 ++-
>  tools/perf/util/header.h          |  15 +--
>  tools/perf/util/mmap.c            |   6 +-
>  tools/perf/util/mmap.h            |   2 +-
>  tools/perf/util/ordered-events.c  |  87 ++++++++++++---
>  tools/perf/util/ordered-events.h  |  37 +++---
>  tools/perf/util/session.c         |  75 ++++++-------
>  tools/perf/util/session.h         |   5 +-
>  tools/perf/util/setup.py          |   2 +-
>  tools/perf/util/stat.c            |   5 +-
>  tools/perf/util/stat.h            |   5 +-
>  tools/perf/util/tool.h            |   7 +-
>  tools/perf/util/util.c            |   2 +-
>  tools/perf/util/util.h            |   2 +
>  30 files changed, 519 insertions(+), 230 deletions(-)
>  create mode 100644 tools/perf/tests/wp.c

Pulled, thanks a lot Arnaldo!

	Ingo
