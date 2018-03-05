Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeCETJn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:09:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752812AbeCETJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:09:41 -0500
Date: Mon, 5 Mar 2018 20:09:37 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V2 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180305190937.GA31349@krava>
References: <1520034092-35275-1-git-send-email-agustinv@codeaurora.org>
 <1520034092-35275-2-git-send-email-agustinv@codeaurora.org>
 <20180303143436.GA14563@krava>
 <20180304171245.GB25017@tassilo.jf.intel.com>
 <20180304181010.GA7030@krava>
 <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddac3f4900267b0c9a69ef4c598be51@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:08:18AM -0500, Agustin Vega-Frias wrote:
> On 2018-03-04 13:10, Jiri Olsa wrote:
> > On Sun, Mar 04, 2018 at 09:12:45AM -0800, Andi Kleen wrote:
> > > > > +#include <fnmatch.h>
> > > > >  #include <linux/compiler.h>
> > > > >  #include <linux/list.h>
> > > > >  #include <linux/types.h>
> > > > > @@ -241,7 +242,7 @@ PE_NAME opt_event_config
> > > > >  			if (!strncmp(name, "uncore_", 7) &&
> > > > >  			    strncmp($1, "uncore_", 7))
> > > > >  				name += 7;
> > > > > -			if (!strncmp($1, name, strlen($1))) {
> > > > > +			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
> > > >
> > > > could we now get rid of the strncmp in here and keep the
> > > > glob matching only?
> > > 
> > > That would break existing command lines. Not a good idea.
> > 
> > I hoped that only you guys are using this and would rewrite your scripts
> > ;-)
> > 
> > I had no idea there's fnmatch func before.. too bad, ok
> > 
> > jirka
> 
> An option to keep backward compatibility and consistency would be
> to wrap the pattern/string passed in *'s, that way we can just use
> fnmatch and have all the examples Jiri brought up work the same.
> With that in place we can actually also drop the explicit ignoring
> of the uncore_ prefix since the globbing would take care of that.

I don't mind the strcmp as such, I wanted to get rid of the wildcard
matching without using '*' ... but as Andi said it's been out
there and it's been a while, so let's keep it

but if there's a way to make it simpler, let's go for it

thanks,
jirka
