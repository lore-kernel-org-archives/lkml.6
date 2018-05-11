Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753256AbeEKNsE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752974AbeEKNsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:48:03 -0400
Date: Fri, 11 May 2018 10:48:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
Message-ID: <20180511134800.GO13491@kernel.org>
References: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 10, 2018 at 12:01:59PM +0800, Leo Yan escreveu:
> CoreSight doesn't allocate thread structure for unknown_thread in etm
> auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
> contain valid tid and then cs_etm__mem_access() uses unknown_thread
> instead as thread handler, this results in segmentation fault when
> thread__find_addr_map() accesses thread handler.
> 
> This commit creates new thread data which is used by unknown_thread, so
> CoreSight tracing can roll back to use unknown_thread if perf data
> doesn't include valid thread info.  This commit also releases thread
> data for initialization failure case and for normal auxtrace free flow.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied to perf/urgent.

And please use a more descriptive, eye catching summary, something like:

  perf cs-etm: Fix segfault when accessing NULL unknown_thread variable

:-)

- Arnaldo
