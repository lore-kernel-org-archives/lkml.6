Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeEKXaI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 19:30:08 -0400
Received: from mail-pl0-f49.google.com ([209.85.160.49]:34930 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeEKXaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 19:30:00 -0400
X-Google-Smtp-Source: AB8JxZrS5iCadfQfLcDoMCEQz77auP/YXPGV2Z4hFmE6nC9EyU93yKhZOr5O4rnS58DntsusMsnWFQ==
Date: Sat, 12 May 2018 07:29:53 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
Message-ID: <20180511232953.GA28378@leoy-ThinkPad-X240s>
References: <1525924920-4381-1-git-send-email-leo.yan@linaro.org>
 <20180511134800.GO13491@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511134800.GO13491@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:48:00AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 10, 2018 at 12:01:59PM +0800, Leo Yan escreveu:
> > CoreSight doesn't allocate thread structure for unknown_thread in etm
> > auxtrace, so unknown_thread is NULL pointer.  If the perf data doesn't
> > contain valid tid and then cs_etm__mem_access() uses unknown_thread
> > instead as thread handler, this results in segmentation fault when
> > thread__find_addr_map() accesses thread handler.
> > 
> > This commit creates new thread data which is used by unknown_thread, so
> > CoreSight tracing can roll back to use unknown_thread if perf data
> > doesn't include valid thread info.  This commit also releases thread
> > data for initialization failure case and for normal auxtrace free flow.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Thanks, applied to perf/urgent.
> 
> And please use a more descriptive, eye catching summary, something like:
> 
>   perf cs-etm: Fix segfault when accessing NULL unknown_thread variable
> 
> :-)

Thanks for suggestion.  Indeed, this patch is a fix rather than
a new feature, subject should reflect it.

Thanks,
Leo Yan
