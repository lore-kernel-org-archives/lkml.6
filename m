Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41BDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855BB21EB7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855BB21EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeFUUQz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933304AbeFUUQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:16:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D621C21EA4;
        Thu, 21 Jun 2018 20:16:49 +0000 (UTC)
Date:   Thu, 21 Jun 2018 16:16:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-ID: <20180621161648.29e7a4cc@gandalf.local.home>
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Are you going to post another version of this patch set?

-- Steve


On Wed, 25 Apr 2018 21:16:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This is the 7th version of the fetch-arg improvement series.
> This includes variable changes on fetcharg framework like,
> 
> - Add fetcharg testcases (syntax, argN, symbol, string and array)
>   and probepoint testcase.
> - Rewrite fetcharg framework with fetch_insn, switch-case based
>   instead of function pointer.
> - Add "symbol" type support, which shows symbol+offset instead of
>   address value.
> - Add "$argN" fetcharg, which fetches function parameters.
>   (currently only for x86-64)
> - Add array type support (including string arrary :) ) ,
>   which enables to get fixed length array from probe-events.
> - Add array type support for perf-probe, so that user can
>   dump partial array entries.
> 
> V6 is here:
>  https://lkml.org/lkml/2018/3/17/75
> 
> Changes from the v6 are here:
>  [6/16]  - Fix to return an error if failed to fetch string and
>         fill zero-length data_loc in error case.
>  [11/16] - Update document for restructured text.
>  [15/16] - Fix README test.
>  [16/16] - Add type-casting description (and note) to documentation.
> 
> And rebased on the latest Steve's ftrace/core branch.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (16):
>       tracing: probeevent: Cleanup print argument functions
>       tracing: probeevent: Cleanup argument field definition
>       tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
>       tracing: probeevent: Introduce new argument fetching code
>       tracing: probeevent: Unify fetch type tables
>       tracing: probeevent: Return consumed bytes of dynamic area
>       tracing: probeevent: Append traceprobe_ for exported function
>       tracing: probeevent: Unify fetch_insn processing common part
>       tracing: probeevent: Add symbol type
>       x86: ptrace: Add function argument access API
>       tracing: probeevent: Add $argN for accessing function args
>       tracing: probeevent: Add array type support
>       selftests: ftrace: Add a testcase for symbol type
>       selftests: ftrace: Add a testcase for $argN with kprobe_event
>       selftests: ftrace: Add a testcase for array type with kprobe_event
>       perf-probe: Add array argument support
> 
> 
>  Documentation/trace/kprobetrace.rst                |   23 +
>  arch/Kconfig                                       |    7 
>  arch/x86/Kconfig                                   |    1 
>  arch/x86/include/asm/ptrace.h                      |   38 +
>  kernel/trace/trace.c                               |    9 
>  kernel/trace/trace_kprobe.c                        |  358 ++++--------
>  kernel/trace/trace_probe.c                         |  620 +++++++++-----------
>  kernel/trace/trace_probe.h                         |  282 +++------
>  kernel/trace/trace_probe_tmpl.h                    |  216 +++++++
>  kernel/trace/trace_uprobe.c                        |  176 ++----
>  tools/perf/Documentation/perf-probe.txt            |   12 
>  tools/perf/util/probe-event.c                      |   20 +
>  tools/perf/util/probe-event.h                      |    2 
>  tools/perf/util/probe-file.c                       |    5 
>  tools/perf/util/probe-file.h                       |    1 
>  tools/perf/util/probe-finder.c                     |   95 ++-
>  .../ftrace/test.d/kprobe/kprobe_args_argN.tc       |   25 +
>  .../ftrace/test.d/kprobe/kprobe_args_array.tc      |   92 +++
>  .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   77 ++
>  19 files changed, 1127 insertions(+), 932 deletions(-)
>  create mode 100644 kernel/trace/trace_probe_tmpl.h
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_argN.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_array.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

