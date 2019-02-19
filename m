Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3621479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550589860;
	bh=QpnygOPpqxA4zWPDpYqIqIxQQKJlQRxphd+yFxTj1b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zsydEe0g/oh4pzFUAJGhqg25Es3s1we1gzNeGEl5Y+uDNDnFZq60Dwqh/NA6x0Bi
	 RRXBCDakeK4ZqLwb2BzIpy94xuOEO+MayIhFrtsibrjIc7M1NxjD0kv9t7/HxXt1qk
	 p9o626IGEW3/INXdyUxz1IptpmA4J+/ykqRpE/wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfBSPYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:24:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfBSPYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:24:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.162.130.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539122146E;
        Tue, 19 Feb 2019 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550589856;
        bh=QpnygOPpqxA4zWPDpYqIqIxQQKJlQRxphd+yFxTj1b4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyzJS/xGfy+VUMRPykP9ZYU33OFRKGTwcZVlhbbFNlfnRLSwg3sldaNvXdAsWa8gF
         Ab4sqUFtsYHLyfXJw+aTByuc4waWaM2o2c1TK32tWIU9SXstn6IXo1s+6Zyqc7ik/x
         LckKRLJfRjRibZwRP0ZHlIRz8i2/EG5z9RGyfv7Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E0EC410D5; Tue, 19 Feb 2019 12:24:13 -0300 (-03)
Date:   Tue, 19 Feb 2019 12:24:13 -0300
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
Subject: Re: [PATCH] perf: fix HEADER_CMDLINE description in perf.data
 documentation
Message-ID: <20190219152413.GB31177@kernel.org>
References: <20190218124648.GN31177@kernel.org>
 <20190218140203.1982-1-jonas.rabenstein@studium.uni-erlangen.de>
 <20190219140409.GD6435@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219140409.GD6435@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 19, 2019 at 03:04:09PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 18, 2019 at 03:02:03PM +0100, Jonas Rabenstein wrote:
> > The content of this feature header is a perf_header_string_list of
> > the argument vector and not a perf_header_string of the commandline.
> 
> missing your Signed-off-by

Please provide for both and I'll apply.

In such a case you could repost with what is missing (your
Signed-off-by: your-email) and collect the Acked-by from whoever
provides them, Jiri in this case, so just add these two lines to the
changeset log:

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Thanks,

- Arnaldo
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/Documentation/perf.data-file-format.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> > index dfb218feaad9..5f9a3924830b 100644
> > --- a/tools/perf/Documentation/perf.data-file-format.txt
> > +++ b/tools/perf/Documentation/perf.data-file-format.txt
> > @@ -131,7 +131,7 @@ An uint64_t with the total memory in bytes.
> >  
> >  	HEADER_CMDLINE = 11,
> >  
> > -A perf_header_string with the perf command line used to collect the data.
> > +A perf_header_string_list with the perf arg-vector used to collect the data.
> >  
> >  	HEADER_EVENT_DESC = 12,
> >  
> > -- 
> > 2.19.2
> > 

-- 

- Arnaldo
