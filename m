Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EACC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7E220835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7E220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJIRRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbeJIRRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:17:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49B663082A42;
        Tue,  9 Oct 2018 10:00:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.5])
        by smtp.corp.redhat.com (Postfix) with SMTP id 710356A047;
        Tue,  9 Oct 2018 10:00:50 +0000 (UTC)
Date:   Tue, 9 Oct 2018 12:00:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
Message-ID: <20181009100049.GF6499@krava>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava>
 <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava>
 <20181003212052.GA32371@krava>
 <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 09 Oct 2018 10:00:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:20:39AM +0100, John Garry wrote:

SNIP

> > We synthesize an update event that needs to touch the evsel
> > id array, which is not defined at that time. Fixing this by
> > forcing the id allocation for events with theeir own cpus.
> > 
> > Reported-by: John Garry <john.garry@huawei.com>
> > Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6@git.kernel.org
> 
> Tested-by: John Garry <john.garry@huawei.com>
> 
> In terms of adding to stable, LT v4.14 is not affected, but 4.18.x is.
> 
> Thanks,
> John

Arnaldo, could you please pick up this one

thanks,
jirka

> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-report.c | 1 +
> >  tools/perf/util/evsel.c     | 3 +++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index c0703979c51d..257c9c18cb7e 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -980,6 +980,7 @@ int cmd_report(int argc, const char **argv)
> >  			.id_index	 = perf_event__process_id_index,
> >  			.auxtrace_info	 = perf_event__process_auxtrace_info,
> >  			.auxtrace	 = perf_event__process_auxtrace,
> > +			.event_update	 = perf_event__process_event_update,
> >  			.feature	 = process_feature_event,
> >  			.ordered_events	 = true,
> >  			.ordering_requires_timestamps = true,
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index ac6cfb8b085e..7a0d5fbaf3c1 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1088,6 +1088,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
> >  		attr->exclude_user   = 1;
> >  	}
> > 
> > +	if (evsel->own_cpus)
> > +		evsel->attr.read_format |= PERF_FORMAT_ID;
> > +
> >  	/*
> >  	 * Apply event specific term settings,
> >  	 * it overloads any global configuration.
> > 
> 
> 
