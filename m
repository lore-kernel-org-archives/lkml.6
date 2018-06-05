Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeFENXk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbeFENXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:23:36 -0400
Date: Tue, 5 Jun 2018 10:23:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Display user and system time
Message-ID: <20180605132333.GC4899@kernel.org>
References: <20180605121313.31337-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605121313.31337-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 05, 2018 at 02:13:13PM +0200, Jiri Olsa escreveu:
> Adding the support to read rusage data once the
> workload is finished and display the system/user
> time values:
<SNIP>
> Those times are the very same displayed by 'time' tool.
> They are returned by wait4 call via the getrusage struct
> interface.

Thanks, tested it with:

      # perf stat --null time perf bench sched pipe
      # Running 'sched/pipe' benchmark:
      # Executed 1000000 pipe operations between two processes
    
           Total time: 5.526 [sec]
    
             5.526534 usecs/op
               180945 ops/sec
      1.00user 6.25system 0:05.52elapsed 131%CPU (0avgtext+0avgdata 8056maxresident)k
      0inputs+0outputs (0major+606minor)pagefaults 0swaps
    
       Performance counter stats for 'time perf bench sched pipe':
    
             5.530978744 seconds time elapsed
    
             1.004037000 seconds user
             6.259937000 seconds sys
    
      #

:-)

- Arnaldo
