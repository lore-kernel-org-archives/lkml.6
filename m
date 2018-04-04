Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeDDNjY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbeDDNjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:39:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6B7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 4 Apr 2018 10:39:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf stat: enable 1ms interval for printing event
 counters values
Message-ID: <20180404133920.GA966@kernel.org>
References: <b842ad6a-d606-32e4-afe5-974071b5198e@linux.intel.com>
 <20180404070516.GB2313@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404070516.GB2313@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 04, 2018 at 09:05:16AM +0200, Jiri Olsa escreveu:
> On Tue, Apr 03, 2018 at 09:18:33PM +0300, Alexey Budankov wrote:
> > 
> > Currently print count interval for performance counters values is 
> > limited by 10ms so reading the values at frequencies higher than 100Hz 
> > is restricted by the tool.
> > 
> > This change makes perf stat -I possible on frequencies up to 1KHz and, 
> > to some extent, makes perf stat -I to be on-par with perf record 
> > sampling profiling.
> > 
> > When running perf stat -I for monitoring e.g. PCIe uncore counters and 
> > at the same time profiling some I/O workload by perf record e.g. for 
> > cpu-cycles and context switches, it is then possible to observe 
> > consolidated CPU/OS/IO(Uncore) performance picture for that workload.
> > 
> > Tool overhead warning printed when specifying -v option can be missed 
> > due to screen scrolling in case you have output to the console 
> > so message is moved into help available by running perf stat -h.
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> > ---
> > 
> > Changes in v2:
> >  - updated minimum value to 1ms at perf-stat.txt manual
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to perf/core.

- Arnaldo
