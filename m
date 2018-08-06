Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF66C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D21B21A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D21B21A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHFQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:35:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeHFQfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:35:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B17F4076045;
        Mon,  6 Aug 2018 14:26:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9FB241010421;
        Mon,  6 Aug 2018 14:26:25 +0000 (UTC)
Date:   Mon, 6 Aug 2018 16:26:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 19/20] perf annotate: Add --percent-type option
Message-ID: <20180806142625.GC16446@krava>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-20-jolsa@kernel.org>
 <20180806134912.GB6983@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806134912.GB6983@danjae.aot.lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 14:26:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 14:26:27 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:49:12PM +0900, Namhyung Kim wrote:
> On Sat, Aug 04, 2018 at 03:05:20PM +0200, Jiri Olsa wrote:
> > Adding --percent-type option to set annotation percent type
> > from following choices:
> >   global-period, local-period, global-hits, local-hits
> > 
> > Examples:
> >   $ perf annotate --percent-type period-local --stdio | head -1
> >    Percent         |      Source code ... es, percent: local period)
> >   $ perf annotate --percent-type hits-local --stdio | head -1
> >    Percent         |      Source code ... es, percent: local hits)
> >   $ perf annotate --percent-type hits-global --stdio | head -1
> >    Percent         |      Source code ... es, percent: global hits)
> >   $ perf annotate --percent-type period-global --stdio | head -1
> >    Percent         |      Source code ... es, percent: global period)
> > 
> > The local/global keywords set if the percentage is computed
> > in the scope of the function (local) or the whole data (global).
> > 
> > The period/hits keywords set the base the percentage is computed
> > on - the samples period or the number of samples (hits).
> 
> What about adding "period" as an alias to "local-period" (and same for
> "hits" as well)?

I dont mind that.. will add to v2 if there are no objections

thanks,
jirka
