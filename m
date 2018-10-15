Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B479C7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D621D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV62mS9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D621D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeJPDBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeJPDBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:01:42 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D3420881;
        Mon, 15 Oct 2018 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539630907;
        bh=/jW5AnQjjH4XGhM7JfUkwbAarepwovVIp485u5JV3mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AV62mS9iswuFcidwG/5C9OxSiE5OIWqiCQ5vl5/X4SICFGwepfUdeRKTJWWK7zgI2
         b1cDneB7ms8lG3erHLC/1LW/GvoE1bXCwyOPssAwtM1xmz69/EEgStZN3m/Rg33cv+
         QBue6grNNBt+zvuffJYG5b1PcSV6ejgrJd1ws19o=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id C3531142C5E; Mon, 15 Oct 2018 16:15:02 -0300 (-03)
Date:   Mon, 15 Oct 2018 16:15:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf tools: Store ids for events with their own cpus
 perf_event__synthesize_event_update_cpus
Message-ID: <20181015191502.GA2398@kernel.org>
References: <20180927160210.GF6916@krava>
 <4ac88076-60fa-4509-7fa0-2f99d73174d2@huawei.com>
 <20181002111621.GA6357@krava>
 <20181003113643.GA31725@krava>
 <594506a2-8cb3-3d09-82ab-5cb6d8c31ed0@huawei.com>
 <20181003141627.GA6341@krava>
 <20181003212052.GA32371@krava>
 <d071bb27-5533-da2f-9f8f-808183e04794@huawei.com>
 <20181009100049.GF6499@krava>
 <31101407-0bcd-2fbf-361e-43cbcb81cd19@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31101407-0bcd-2fbf-361e-43cbcb81cd19@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 12, 2018 at 02:25:49PM +0100, John Garry escreveu:
> On 09/10/2018 11:00, Jiri Olsa wrote:
> > On Thu, Oct 04, 2018 at 10:20:39AM +0100, John Garry wrote:
> > 
> > SNIP
> > 
> > > > We synthesize an update event that needs to touch the evsel
> > > > id array, which is not defined at that time. Fixing this by
> > > > forcing the id allocation for events with theeir own cpus.
> 
> /s/theeir/their/
> 
> > > > 
> > > > Reported-by: John Garry <john.garry@huawei.com>
> > > > Link: http://lkml.kernel.org/n/tip-8x4n7o34yheigoxm1jibflm6@git.kernel.org
> > > 
> > > Tested-by: John Garry <john.garry@huawei.com>
> > > 
> > > In terms of adding to stable, LT v4.14 is not affected, but 4.18.x is.
> > > 
> > > Thanks,
> > > John
> > 
> > Arnaldo, could you please pick up this one
> > 
> 
> Just a friendly reminder on this patch.
> 
> How about re-send with an updated commit message also?

I'll fix up the commit message and apply, thanks.

- Arnaldo
 
> Thanks,
> John
> 
> > thanks,
> > jirka
> > 
> > > 
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/builtin-report.c | 1 +
> > > >  tools/perf/util/evsel.c     | 3 +++
> > > >  2 files changed, 4 insertions(+)
> > > > 
> > > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > > index c0703979c51d..257c9c18cb7e 100644
> > > > --- a/tools/perf/builtin-report.c
> > > > +++ b/tools/perf/builtin-report.c
> > > > @@ -980,6 +980,7 @@ int cmd_report(int argc, const char **argv)
> > > >  			.id_index	 = perf_event__process_id_index,
> > > >  			.auxtrace_info	 = perf_event__process_auxtrace_info,
> > > >  			.auxtrace	 = perf_event__process_auxtrace,
> > > > +			.event_update	 = perf_event__process_event_update,
> > > >  			.feature	 = process_feature_event,
> > > >  			.ordered_events	 = true,
> > > >  			.ordering_requires_timestamps = true,
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index ac6cfb8b085e..7a0d5fbaf3c1 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -1088,6 +1088,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
> > > >  		attr->exclude_user   = 1;
> > > >  	}
> > > > 
> > > > +	if (evsel->own_cpus)
> > > > +		evsel->attr.read_format |= PERF_FORMAT_ID;
> > > > +
> > > >  	/*
> > > >  	 * Apply event specific term settings,
> > > >  	 * it overloads any global configuration.
> > > > 
> > > 
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> > .
> > 
> 
