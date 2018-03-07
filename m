Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933958AbeCGPht (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:37:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933833AbeCGPhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:37:47 -0500
Date: Wed, 7 Mar 2018 16:37:45 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Show zero counters as well in 'perf report
 --stat'
Message-ID: <20180307153745.GA21531@krava>
References: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307152430.7e5h7e657b7bgd7q@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:24:30PM +0100, Ingo Molnar wrote:
> 
> When recently using 'perf report --stat' it was not clear to me from the output 
> whether a particular statistics field (LOST_SAMPLES) was not present, or just 
> zero:
> 
>   fomalhaut:~> perf report --stat
> 
>   Aggregated stats:
>            TOTAL events:     495984
>             MMAP events:         85
>             COMM events:       3389
>             EXIT events:       1605
>         THROTTLE events:          2
>       UNTHROTTLE events:          2
>             FORK events:       3377
>           SAMPLE events:     472629
>            MMAP2 events:      14753
>   FINISHED_ROUND events:        139
>       THREAD_MAP events:          1
>          CPU_MAP events:          1
>        TIME_CONV events:          1
> 
> I had to check the output several times to ascertain that I'm not misreading the 
> output, that the field didn't change and that I didn't misremember the name. In 
> fact I had to look into the perf source to make sure that zero fields are indeed 
> not shown.
> 
> With the patch applied:
> 
>   fomalhaut:~> perf report --stat
> 
>   Aggregated stats:
>            TOTAL events:     495984
>             MMAP events:         85
>             LOST events:          0
>             COMM events:       3389
>             EXIT events:       1605
>         THROTTLE events:          2
>       UNTHROTTLE events:          2
>             FORK events:       3377
>             READ events:          0
>           SAMPLE events:     472629
>            MMAP2 events:      14753
>              AUX events:          0
>     ITRACE_START events:          0
>     LOST_SAMPLES events:          0
>           SWITCH events:          0
>  SWITCH_CPU_WIDE events:          0
>       NAMESPACES events:          0
>             ATTR events:          0
>       EVENT_TYPE events:          0
>     TRACING_DATA events:          0
>         BUILD_ID events:          0
>   FINISHED_ROUND events:        139
>         ID_INDEX events:          0
>    AUXTRACE_INFO events:          0
>         AUXTRACE events:          0
>   AUXTRACE_ERROR events:          0
>       THREAD_MAP events:          1
>          CPU_MAP events:          1
>      STAT_CONFIG events:          0
>             STAT events:          0
>       STAT_ROUND events:          0
>     EVENT_UPDATE events:          0
>        TIME_CONV events:          1
>          FEATURE events:          0

ok, it also might be better to read since now the events
appear in the same place, not scattered based on what was
data was collected

jirka
