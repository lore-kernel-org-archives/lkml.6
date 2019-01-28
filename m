Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79349C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BCA2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA1IU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:20:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1IU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:20:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3575D88318;
        Mon, 28 Jan 2019 08:20:26 +0000 (UTC)
Received: from krava (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0D16F101F97A;
        Mon, 28 Jan 2019 08:20:23 +0000 (UTC)
Date:   Mon, 28 Jan 2019 09:20:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
Message-ID: <20190128082023.GA15461@krava>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
 <27127a53-4393-ab69-ff61-0d0a36a629a0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27127a53-4393-ab69-ff61-0d0a36a629a0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 28 Jan 2019 08:20:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:13:20AM +0300, Alexey Budankov wrote:

SNIP

> > ---
> > Alexey Budankov (4):
> >   perf record: allocate affinity masks
> >   perf record: bind the AIO user space buffers to nodes
> >   perf record: apply affinity masks when reading mmap buffers
> >   perf record: implement --affinity=node|cpu option
> > 
> >  tools/perf/Documentation/perf-record.txt |   5 ++
> >  tools/perf/builtin-record.c              |  45 +++++++++-
> >  tools/perf/perf.h                        |   8 ++
> >  tools/perf/util/cpumap.c                 |  10 +++
> >  tools/perf/util/cpumap.h                 |   1 +
> >  tools/perf/util/evlist.c                 |   6 +-
> >  tools/perf/util/evlist.h                 |   2 +-
> >  tools/perf/util/mmap.c                   | 105 ++++++++++++++++++++++-
> >  tools/perf/util/mmap.h                   |   3 +-
> >  9 files changed, 175 insertions(+), 10 deletions(-)
> > 
> > ---
> > Changes in v5:
> > - avoided multiple allocations of online cpu maps by 
> >   implementing it once in cpu_map__online()
> > - reduced indentation at record__parse_affinity()
> 
> Are there any more comments on this patch set?

sry for late reply.. there was a mayhem in here
last week because of the devconf ;-)

I'll review it today, but I think there were no more issues

jirka
