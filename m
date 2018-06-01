Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeFAIgV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:36:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750740AbeFAIgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:36:14 -0400
Date: Fri, 1 Jun 2018 10:36:11 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2]: perf record: enable arbitrary event names thru name=
 modifier
Message-ID: <20180601083611.GB2986@krava>
References: <23f72f9b-c513-ecd4-d375-c5cf2eb30197@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f72f9b-c513-ecd4-d375-c5cf2eb30197@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 05:08:12PM +0300, Alexey Budankov wrote:
> 
> Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> trace using name= modifier e.g. like this:
> 
> perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> 
> Below is how it looks like in the report output. Please note explicit escaped 
> quoting at cmdline string in the header so that thestring can be directly reused
> for another collection in shell:
> 
> perf report --header
> 
> # ========
> ...
> # cmdline : /root/abudanko/kernel/tip/tools/perf/perf record -v -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex 
> # event : name = OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM, , type = 4, size = 112, config = 0x100003c, { sample_period, sample_freq } = 3500000, sample_type = IP|TID|TIME, disabled = 1, inh
> ...
> # ========
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 24K of event 'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM'
> # Event count (approx.): 86492000000
> #
> # Overhead  Command  Shared Object     Symbol                                        
> # ........  .......  ................  ..............................................
> #
>     14.75%  futex    [kernel.vmlinux]  [k] __entry_trampoline_start
> ...
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
