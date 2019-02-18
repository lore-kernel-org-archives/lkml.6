Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D972C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE44C206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfBRJFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:05:02 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:54838 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729139AbfBRJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:05:01 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 442ycW1HkDz8v93;
        Mon, 18 Feb 2019 10:04:59 +0100 (CET)
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 199.249.230.82
Received: from uni-erlangen.de (tor29.quintex.com [199.249.230.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18tsPtxwVp+lnnbww0p/peNXzEoNnsdu10=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 442ycN59j9z8tnB;
        Mon, 18 Feb 2019 10:04:52 +0100 (CET)
Date:   Mon, 18 Feb 2019 10:04:41 +0100
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: update perf.data file format documentation
Message-ID: <20190218090441.nutpvfpsjz5oxwes@studium.uni-erlangen.de>
References: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190217232246.GB26460@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217232246.GB26460@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:22:46AM +0100, Jiri Olsa wrote:
> On Fri, Feb 15, 2019 at 07:28:23PM +0100, Jonas Rabenstein wrote:
> > I found that the documentation of the flags section is some how
> > different from the actual format used and expected by the perf
> > tools. In this patch the according section of the file format
> > documentation is updated to conform to the expectations of the
> > perf tool suite.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > ---
> >  .../perf/Documentation/perf.data-file-format.txt  | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index dfb218feaad9..6ea199f28330 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -43,13 +43,10 @@ struct perf_file_section {
> >  
> >  Flags section:
> >  
> > -The header is followed by different optional headers, described by the bits set
> > -in flags. Only headers for which the bit is set are included. Each header
> > -consists of a perf_file_section located after the initial header.
> > -The respective perf_file_section points to the data of the additional
> > -header and defines its size.
> > -
> > -Some headers consist of strings, which are defined like this:
> > +The Flags section is placed directly after the data section and consists of a
> > +variable amount of information described by the flags-bitset in the perf_header.
> > +A lot of the headers in the Flags section are simple strings and are represented
> > +like this:
> 
> some how I find this more confusing.. please describe
> what's actualy wrong with the current wording
The difference is that the current wording states "The header is
followed by different optional headers" but the actual placement
of those headers of the flags section is after the data section
(see perf_file_header__read at util/header.c:3108 in v4.20). But
I admit that I shouldn't have removed the perf_file_section's...
> >  
> >  struct perf_header_string {
> >         uint32_t len;
> > @@ -82,7 +79,7 @@ assigned by the linker to an executable.
> >  struct build_id_event {
> >  	struct perf_event_header header;
> >  	pid_t			 pid;
> > -	uint8_t			 build_id[24];
> > +	uint8_t			 build_id[PERF_ALIGN(24, sizeof(u64))];
> 
> isn't that always 24? I guess u meant:
> 
>   build_id[PERF_ALIGN(20, sizeof(u64))];
You are right that this should always be 24. I just went over the diff
of my codebase to generate the perf.data file and tried to extract the
relevant format changes. I think I just stumbled across the definition
of build_id_event in util/event.h:229 and added that (irrelevant) change
which finally - also useless - worked as soon as I adjusted the flags
section.
The other way round this is the actual definition in the code base so
I'm not sure whether it should be the same. But as it is useless perhaps
change the definition in the source?
> 
> 
> >  	char			 filename[header.size - offsetof(struct build_id_event, filename)];
> >  };
> >  
> > @@ -131,7 +128,7 @@ An uint64_t with the total memory in bytes.
> >  
> >  	HEADER_CMDLINE = 11,
> >  
> > -A perf_header_string with the perf command line used to collect the data.
> > +A perf_header_string_list with the perf arg-vector used to collect the data.
> 
> nice catch
> 
> thanks,
> jirka
> 
> >  
> >  	HEADER_EVENT_DESC = 12,
> >  
> > -- 
> > 2.17.1
> > 
