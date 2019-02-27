Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB6D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfB0O2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbfB0O2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:28:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0228C0AC912;
        Wed, 27 Feb 2019 14:28:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 616305D73A;
        Wed, 27 Feb 2019 14:28:06 +0000 (UTC)
Date:   Wed, 27 Feb 2019 15:28:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190227142804.GB30149@krava>
References: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 27 Feb 2019 14:28:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:31:38AM +0300, Alexey Budankov wrote:

SNIP

> TESTING:
> 
> tools/perf/perf test
>  1: vmlinux symtab matches kallsyms                       : Skip
>  2: Detect openat syscall event                           : Ok
>  3: Detect openat syscall event on all cpus               : Ok
>  4: Read samples using the mmap interface                 : Ok
>  5: Test data source output                               : Ok
>  6: Parse event definition strings                        : Ok
>  7: Simple expression parser                              : Ok
>  8: PERF_RECORD_* events & perf_sample fields             : Ok
>  9: Parse perf pmu format                                 : Ok
> 10: DSO data read                                         : Ok
> 11: DSO data cache                                        : Ok
> 12: DSO data reopen                                       : Ok
> 13: Roundtrip evsel->name                                 : Ok
> 14: Parse sched tracepoints fields                        : Ok
> 15: syscalls:sys_enter_openat event fields                : Ok
> 16: Setup struct perf_event_attr                          : Skip
> 17: Match and link multiple hists                         : Ok
> 18: 'import perf' in python                               : FAILED!

Arnaldo's perf/core is passing for me in here:

[jolsa@krava perf]$ ./perf test 16 48
16: Setup struct perf_event_attr                          : Ok
48: Synthesize attr update                                : Ok

jirka
