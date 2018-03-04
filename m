Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeCDSKQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 13:10:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751692AbeCDSKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 13:10:14 -0500
Date: Sun, 4 Mar 2018 19:10:10 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180304181010.GA7030@krava>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava>
 <20180304171245.GB25017@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304171245.GB25017@tassilo.jf.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 09:12:45AM -0800, Andi Kleen wrote:
> > > +#include <fnmatch.h>
> > >  #include <linux/compiler.h>
> > >  #include <linux/list.h>
> > >  #include <linux/types.h>
> > > @@ -241,7 +242,7 @@ PE_NAME opt_event_config
> > >  			if (!strncmp(name, "uncore_", 7) &&
> > >  			    strncmp($1, "uncore_", 7))
> > >  				name += 7;
> > > -			if (!strncmp($1, name, strlen($1))) {
> > > +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
> > 
> > could we now get rid of the strncmp in here and keep the
> > glob matching only? 
> 
> That would break existing command lines. Not a good idea.

I hoped that only you guys are using this and would rewrite your scripts ;-)

I had no idea there's fnmatch func before.. too bad, ok

jirka
