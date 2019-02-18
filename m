Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550494014;
	bh=PatrqlGfscd+ebmnHCj1aP7qkFakXdmsxYLSep0wcjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mL29mj60ak5hxAyJXi/nOkKT27W6Qkx6fx1h7GXLwwlMCH88XvMBfdp/TweJfqX//
	 +f8dfqiWMVfyUre2Q0djs80ZCBx86A+gcY6B2wYeA/SItY1JIhnT89effxWK2SyHbi
	 A0N7HW2WLT/uWECBStTGL7Z/Yi/kXxv2ITxMgbCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfBRMqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:46:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfBRMqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:46:51 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE4CB2173C;
        Mon, 18 Feb 2019 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550494011;
        bh=PatrqlGfscd+ebmnHCj1aP7qkFakXdmsxYLSep0wcjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHvAAcVmasM7Z0jnkHwwkr7uNMRwh91A18XJlA92kbBFk1ELqyk5vkRBAthkyQ+5A
         mIYyJEnXYUbbpSp3zTiW18o8yR8fowhCXzwm7mD+UjDsvAx0gZQzUT/L1KPfTNT987
         KLQ984CMzpnlu4/2IUW29kJ7YXZwqbuVNTFGR6tA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FA11410D5; Mon, 18 Feb 2019 09:46:48 -0300 (-03)
Date:   Mon, 18 Feb 2019 09:46:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: update perf.data file format documentation
Message-ID: <20190218124648.GN31177@kernel.org>
References: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190217232246.GB26460@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217232246.GB26460@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 18, 2019 at 12:22:46AM +0100, Jiri Olsa escreveu:
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
> 
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

This is why patch granularity is important, this part is unrelated to
the other fixes, so should be in a separate patch, had it been like
that I'd already process this part that got Jiri's Acked-by (in the form
of a positive comment).

- Arnaldo
