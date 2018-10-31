Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA902054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA902054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeJaWdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbeJaWdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EA49309174E;
        Wed, 31 Oct 2018 13:35:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA63360851;
        Wed, 31 Oct 2018 13:35:35 +0000 (UTC)
Date:   Wed, 31 Oct 2018 14:35:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        leo.yan@linaro.org, David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 0/5] perf tools: Fix for cases where cpumode is incorrect
 or insufficient
Message-ID: <20181031133534.GB13216@krava>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031091043.23465-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 31 Oct 2018 13:35:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:10:38AM +0200, Adrian Hunter wrote:
> Hi
> 
> These patches probably deal with most cases except the one fixed by David
> Miller's "perf callchain: Honour the ordering of
> PERF_CONTEXT_{USER,KERNEL,etc}" patch, and also cat_backtrace() which looks
> like it has the same problem, and the cs-etm fix.
> 
> 
> Adrian Hunter (5):
>       perf tools: Add fallback functions for cases where cpumode is insufficient
>       perf tools: Use fallback for sample_addr_correlates_sym() cases
>       perf tools: Use fallbacks for branch stacks
>       perf intel-pt: Insert callchain context into synthesized callchains
>       perf intel-pt/bts: Calculate cpumode for synthesized samples

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/builtin-script.c                        | 12 +++---
>  tools/perf/util/event.c                            | 29 +++++++++++++-
>  tools/perf/util/intel-bts.c                        | 17 ++++++---
>  tools/perf/util/intel-pt.c                         | 28 ++++++++------
>  tools/perf/util/machine.c                          | 40 ++++++++++++++++++++
>  tools/perf/util/machine.h                          |  2 +
>  .../util/scripting-engines/trace-event-python.c    | 16 ++++----
>  tools/perf/util/thread-stack.c                     | 44 +++++++++++++++++-----
>  tools/perf/util/thread-stack.h                     |  2 +-
>  tools/perf/util/thread.h                           |  4 ++
>  10 files changed, 153 insertions(+), 41 deletions(-)
> 
> 
> Regards
> Adrian
