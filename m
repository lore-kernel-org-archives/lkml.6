Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D98021B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfBKNwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:52:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfBKNwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:52:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12ED03D47A;
        Mon, 11 Feb 2019 13:52:49 +0000 (UTC)
Received: from krava (ovpn-204-173.brq.redhat.com [10.40.204.173])
        by smtp.corp.redhat.com (Postfix) with SMTP id DDFA85C23A;
        Mon, 11 Feb 2019 13:52:46 +0000 (UTC)
Date:   Mon, 11 Feb 2019 14:52:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190211135245.GB16528@krava>
References: <64502e28-b312-e59f-5cd7-732c4088c16b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64502e28-b312-e59f-5cd7-732c4088c16b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Feb 2019 13:52:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:02:49AM +0300, Alexey Budankov wrote:
> 
> The patch set implements runtime trace compression for record mode and 
> trace file decompression for report mode. Zstandard API [1] is used for 
> compression/decompression of data that come from perf_events kernel 
> data buffers.
> 
> Realized -z,--compression_level=n option provides ~3-5x avg. trace file 
> size reduction on variety of tested workloads what saves user storage 
> space on larger server systems where trace file size can easily reach 
> several tens or even hundreds of GiBs, especially when profiling with 
> stacks for later dwarf unwinding and context-switches tracing and etc.
> 
>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
> 
> --mmap-flush option can be used to avoid compressing every single byte 
> of data and increase compression ratio at the same time lowering tool 
> runtime overhead.
> 
> The compression functionality can be disabled from the command line 
> using NO_LIBZSTD define and Zstandard sources can be overridden using 
> value of LIBZSTD_DIR define:
> 
>   $ make -C tools/perf NO_LIBZSTD=1 clean all
>   $ make -C tools/perf LIBZSTD_DIR=/path/to/zstd-1.3.7 clean all
> 
> The patch set is for Arnaldo's perf/core repository.

hi,
got here late and can't apply this anymore.. which revision
(commit id) is this based on? perf/core is moving real fast
these days ;-)

based on errors below I suspect u need to rebase anyway :-\

sry for late response

jirka


> 
> ---
> Alexey Budankov (4):
>   feature: realize libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
>   perf record: implement -z=<level> and --mmap-flush=<thres> options

got this one failing when applied:

patching file tools/perf/Documentation/perf-record.txt
Hunk #1 succeeded at 459 with fuzz 2 (offset 19 lines).
patching file tools/perf/builtin-record.c
Hunk #1 succeeded at 292 (offset 5 lines).
Hunk #2 succeeded at 336 (offset 5 lines).
Hunk #3 FAILED at 565.
Hunk #4 succeeded at 765 with fuzz 1 (offset 10 lines).
Hunk #5 FAILED at 778.
Hunk #6 succeeded at 806 (offset 11 lines).
Hunk #7 succeeded at 839 (offset 11 lines).
Hunk #8 succeeded at 873 (offset 11 lines).
Hunk #9 succeeded at 1185 (offset 11 lines).
Hunk #10 succeeded at 1218 (offset 11 lines).
Hunk #11 succeeded at 1354 (offset 11 lines).
Hunk #12 succeeded at 1455 (offset 11 lines).
Hunk #13 succeeded at 1866 (offset 26 lines).
Hunk #14 FAILED at 2006.
Hunk #15 succeeded at 2230 with fuzz 2 (offset 32 lines).
3 out of 15 hunks FAILED -- saving rejects to file tools/perf/builtin-record.c.rej
patching file tools/perf/perf.h
Hunk #1 FAILED at 84.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/perf.h.rej
patching file tools/perf/util/env.h
patching file tools/perf/util/event.c
Hunk #1 succeeded at 68 (offset 2 lines).
patching file tools/perf/util/event.h
Hunk #2 succeeded at 627 (offset 1 line).
Hunk #3 succeeded at 665 (offset 1 line).
patching file tools/perf/util/evlist.c
Hunk #1 FAILED at 1022.
Hunk #2 FAILED at 1032.
Hunk #3 FAILED at 1064.
3 out of 3 hunks FAILED -- saving rejects to file tools/perf/util/evlist.c.rej
patching file tools/perf/util/evlist.h
Hunk #1 FAILED at 165.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/evlist.h.rej
patching file tools/perf/util/header.c
patching file tools/perf/util/header.h
patching file tools/perf/util/mmap.c
Hunk #1 FAILED at 154.
Hunk #2 succeeded at 282 with fuzz 1 (offset 69 lines).
Hunk #3 succeeded at 359 (offset 69 lines).
Hunk #4 succeeded at 434 (offset 97 lines).
Hunk #5 succeeded at 484 (offset 97 lines).
1 out of 5 hunks FAILED -- saving rejects to file tools/perf/util/mmap.c.rej
patching file tools/perf/util/mmap.h
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 69.
2 out of 2 hunks FAILED -- saving rejects to file tools/perf/util/mmap.h.rej
patching file tools/perf/util/session.h
