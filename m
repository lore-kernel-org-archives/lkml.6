Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934035AbeEJD41 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 23:56:27 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:46250 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933858AbeEJD40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 23:56:26 -0400
X-Google-Smtp-Source: AB8JxZqTfQ31Aq8H4C6HJTT4anzW4CnQ+85BFmuF1/nDToV7PbCBQQwjBEvwELXcsowg8I0ARz5Kjw==
Date: Thu, 10 May 2018 11:56:18 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 1/2] perf cs-etm: Support unknown_thread in
 cs_etm_auxtrace
Message-ID: <20180510035618.GD12205@leoy-ThinkPad-X240s>
References: <1525839312-20544-1-git-send-email-leo.yan@linaro.org>
 <20180509155150.GC25559@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509155150.GC25559@xps15>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 09:51:50AM -0600, Mathieu Poirier wrote:
> On Wed, May 09, 2018 at 12:15:11PM +0800, Leo Yan wrote:
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
> 
> Hi Leo,
> 
> Arnaldo maintains the perf tools and he receives dozens of patches every day.
> If his name is not the first one to appear on the "To:" list, it is unlikely
> that his email filters will catch your patches.

Thanks for reminding, Mathieu.  Will resend patches for this.

Thanks,
Leo Yan
