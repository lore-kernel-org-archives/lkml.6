Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16530C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBC320844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548151682;
	bh=M0d/Cs69YySg7Ovl6xp69btq2IW3gvaDgsXFZwKgWcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PqlJiocqeWQOKdTP5Mr0WiQPP8JnBGexAZag4NqGVKuDLAds7/AzZ6Q7lZOZsxGlD
	 0RBQ7/y87no8Ov/8Y7luid2TNemMecFJRSTPOR1q4C2iicFjxg7e4qX7L0VcDybWJ2
	 oGJB1N5tVZCNTOrKNLmwxyI/sKehj9tTbUVDWBv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfAVKIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:08:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40529 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfAVKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:08:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so13483953wmf.5;
        Tue, 22 Jan 2019 02:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yedw9jh5p2XODwyGZZlX7Q0B39wWeWxJ8+6aZZq22Ng=;
        b=B1OxEJ7l+AQUFg2HvPwraCxcRc/2FFB44g5Io+YONyj7XZPkWBv3o8y0Yj8oE3Plqv
         lJ8AXby0B9GKIw9sec6Fcqk80aHQsPwLPD3KlBE86J8BjrkV6Ni4NuVbtzU9OwteH26w
         jwtzawasYsp8S83U86ECPMgr1jEeI2aC1N/fb+kXQM1Gs1k7J0+kPkEkSzcIVyXxdwiH
         dh4QCrjopYo9SMCpLv+X09bF9XE2JJafmsv5u/o/34pjVrOhNZcNfbM2Uk2tEMXOyDGN
         7qEUrbppXA9GZq+hq+B0jlJLW7gb9P7HWTYhuGPy6FblEiyeJEHwxEiqVURY/iqBBw/v
         kJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yedw9jh5p2XODwyGZZlX7Q0B39wWeWxJ8+6aZZq22Ng=;
        b=WfzthU1MMRtfXlImDc49vDxahIGufDlJlZeB/pYYGUQQZYxnUiAiFm+Zuos0AhMK8n
         8jBjDYUK4kmjIJVpfN4wnsG4uBWHNIh8K4XgubJH5TrExDbcmj2viPiw4PLBVnARkLUa
         HyAhx5P34KAOTgzO+7hGbEjiciyReBF59bhiHVzusy7tFCzKIUwVDgkcHWGejlyy1ogN
         ODSUImEETtBwA1NascybwNwCuCxugsoYiFT/I2PDNcH3FIyPujYDDhrkY5sMXKl+r2Aw
         rQ9ddNsOOGYiLXZcBAMRiFTV/uIuHxLQAUAiK8COnxjv1fYx5Vqq6oYqxjWoPaNgQFs0
         8WFQ==
X-Gm-Message-State: AJcUukeCOyGJXBfjZ0GNeaPFAZYtgZY+Ozx/rQ806cripZKrXvLdK6Ok
        9QHQ0DfHeaQbT8BinK/tlE4=
X-Google-Smtp-Source: ALg8bN6R8QN6xRkLEcEBa6zHpSOjF7WBxgO07gDzG21xSdFwbEJXqacvTh1hWDFikU8ZVeARTT3BWQ==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr2903146wmg.79.1548151677169;
        Tue, 22 Jan 2019 02:07:57 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 124sm54906938wmh.22.2019.01.22.02.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 02:07:56 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:07:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Song Liu <songliubraving@fb.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/24] perf/core improvements and fixes
Message-ID: <20190122100754.GA113758@gmail.com>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
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
> Regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit ad07c8ceb6631a83b62d405a61448bba92adac68:
> 
>   perf/core: Remove unused perf_flags (2019-01-21 11:01:31 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.0-20190121
> 
> for you to fetch changes up to 32e9136e37840a62c659259a394ed3735e3b3c84:
> 
>   perf utils: Move perf_config using routines from color.c to separate object (2019-01-21 17:38:56 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> BPF:
> 
>   Song Liu:
> 
>   - Introduce PERF_RECORD_KSYMBOL to allow tooling to notice the addition
>     of new kernel symbols and be able to resolve samples in such symbols.
> 
>   - Introduce PERF_RECORD_BPF_EVENT to notify tooling about the loading
>     and unloading of BPF programs, making them visible and allowing for
>     the request of further information to allow for things like annotation.
> 
>   - Change the userspace perf tools to handle those new events and to
>     synthesize them for pre-existing loaded BPF programs.
> 
> Kernel:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Make perf_event_output() propagate the output() return, allowing
>     users to check for -ENOSPC in the ring buffer.
> 
> perf report:
> 
>   Thomas Richter:
> 
>   - Display arch specific diagnostic counter sets, starting with s390
>     diagnostic counter sets.
> 
> perf session:
> 
>   Jiri Olsa:
> 
>   - Introduce a reader object to prep for multithreaded processing
>     of recorded events.
> 
> Misc:
> 
>   Rasmus Villemoes:
> 
>   - Replace automatic const char[] variables by statics, to avoid
>     initializing them at runtime, instead having them in .rodata,
>     reducing code size.
> 
>   YueHaibing:
> 
>   - Remove duplicated workqueue.h include from perf_event.h
> 
>   Brajeswar Ghosh:
> 
>   - Remove some more duplicated headers.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf: Make perf_event_output() propagate the output() return
>       perf top: Synthesize BPF events for pre-existing loaded BPF programs
>       perf python: Remove -fstack-clash-protection when building with some clang versions
>       perf utils: Move perf_config using routines from color.c to separate object
> 
> Brajeswar Ghosh (1):
>       perf tools: Remove duplicate headers
> 
> Jiri Olsa (6):
>       perf session: Rearrange perf_session__process_events function
>       perf session: Get rid of file_size variable
>       perf session: Add reader object
>       perf session: Add 'data_size' member to reader object
>       perf session: Add 'data_offset' member to reader object
>       perf session: Add reader__process_events function
> 
> Rasmus Villemoes (1):
>       perf tools: Replace automatic const char[] variables by statics
> 
> Song Liu (8):
>       perf, bpf: Introduce PERF_RECORD_KSYMBOL
>       tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
>       perf, bpf: Introduce PERF_RECORD_BPF_EVENT
>       tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
>       perf tools: Handle PERF_RECORD_KSYMBOL
>       perf tools: Handle PERF_RECORD_BPF_EVENT
>       perf tools: Synthesize PERF_RECORD_* for loaded BPF programs
>       bpf: Add module name [bpf] to ksymbols for bpf programs
> 
> Thomas Richter (3):
>       perf report: Display arch specific diagnostic counter sets, starting with s390
>       perf report: Display names in s390 diagnostic counter sets
>       perf report: Dump s390 counter set data to file
> 
> YueHaibing (1):
>       perf: Remove duplicated workqueue.h include from perf_event.h
> 
>  include/linux/filter.h                           |   7 +
>  include/linux/perf_event.h                       |  21 +-
>  include/uapi/linux/perf_event.h                  |  53 ++++-
>  kernel/bpf/core.c                                |   2 +-
>  kernel/bpf/syscall.c                             |   2 +
>  kernel/events/core.c                             | 224 +++++++++++++++++++-
>  kernel/kallsyms.c                                |   2 +-
>  kernel/trace/bpf_trace.c                         |   3 +-
>  tools/include/uapi/linux/perf_event.h            |  53 ++++-
>  tools/perf/builtin-c2c.c                         |   4 +-
>  tools/perf/builtin-kmem.c                        |   4 +-
>  tools/perf/builtin-record.c                      |   7 +
>  tools/perf/builtin-report.c                      |   6 +-
>  tools/perf/builtin-sched.c                       |   2 +-
>  tools/perf/builtin-stat.c                        |   1 -
>  tools/perf/builtin-top.c                         |   7 +
>  tools/perf/examples/bpf/augmented_raw_syscalls.c |   4 +-
>  tools/perf/examples/bpf/augmented_syscalls.c     |  14 +-
>  tools/perf/examples/bpf/etcsnoop.c               |  10 +-
>  tools/perf/perf.h                                |   1 +
>  tools/perf/tests/bp_account.c                    |   1 -
>  tools/perf/ui/browsers/header.c                  |   2 +-
>  tools/perf/ui/browsers/hists.c                   |   4 +-
>  tools/perf/util/Build                            |   5 +
>  tools/perf/util/bpf-event.c                      | 257 +++++++++++++++++++++++
>  tools/perf/util/bpf-event.h                      |  38 ++++
>  tools/perf/util/color.c                          |  39 ----
>  tools/perf/util/color_config.c                   |  47 +++++
>  tools/perf/util/dso.h                            |   1 -
>  tools/perf/util/event.c                          |  41 ++++
>  tools/perf/util/event.h                          |  36 ++++
>  tools/perf/util/evlist.h                         |   4 +-
>  tools/perf/util/evsel.c                          |  19 +-
>  tools/perf/util/evsel.h                          |   2 +
>  tools/perf/util/machine.c                        |  58 +++++
>  tools/perf/util/machine.h                        |   3 +
>  tools/perf/util/s390-cpumcf-kernel.h             |  62 ++++++
>  tools/perf/util/s390-cpumsf.c                    |  77 ++++++-
>  tools/perf/util/s390-sample-raw.c                | 222 ++++++++++++++++++++
>  tools/perf/util/sample-raw.c                     |  18 ++
>  tools/perf/util/sample-raw.h                     |  14 ++
>  tools/perf/util/session.c                        |  98 ++++++---
>  tools/perf/util/setup.py                         |   2 +
>  tools/perf/util/tool.h                           |   5 +-
>  tools/perf/util/zlib.c                           |   1 -
>  45 files changed, 1358 insertions(+), 125 deletions(-)
>  create mode 100644 tools/perf/util/bpf-event.c
>  create mode 100644 tools/perf/util/bpf-event.h
>  create mode 100644 tools/perf/util/color_config.c
>  create mode 100644 tools/perf/util/s390-cpumcf-kernel.h
>  create mode 100644 tools/perf/util/s390-sample-raw.c
>  create mode 100644 tools/perf/util/sample-raw.c
>  create mode 100644 tools/perf/util/sample-raw.h

Pulled, thanks a lot Arnaldo!

	Ingo
