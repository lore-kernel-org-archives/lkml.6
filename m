Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965083AbeCGUV2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:21:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965077AbeCGUVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:21:24 -0500
Date: Wed, 7 Mar 2018 21:21:14 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180307202114.GA2926@krava>
References: <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
 <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
 <20180307185415.GK25017@tassilo.jf.intel.com>
 <20180307190509.GQ3701@kernel.org>
 <20180307190543.GR3701@kernel.org>
 <20180307193930.GW3701@kernel.org>
 <ca5a79445859ff4fb75b021f84f656f9@codeaurora.org>
 <20180307195833.GX3701@kernel.org>
 <0ba091eaa6676498b4554978606d8016@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba091eaa6676498b4554978606d8016@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:09:08PM -0500, Agustin Vega-Frias wrote:

SNIP

> > > >  #include <fnmatch.h>
> > > > +/*
> > > > + * GNU extension, so better define it to 0 for systems such
> > > > + * as Android and Alpine Linux.
> > > > + */
> > > > +#ifndef FNM_EXTMATCH
> > > > +#define FNM_EXTMATCH 0
> > > > +#endif
> > > >  #include <linux/compiler.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/types.h>
> > > 
> > > Hey Jiri,
> > > 
> > > The downside is that, while the compilation now works on those
> > > systems, the pattern will not work as intended in them :o(
> > > Let me cook something and send it ASAP.
> > 
> > Well, do you think this is really a big problem? Even if we add nice
> > docs?
> > 
> > I haven't tested something that works with this syntax on a capable
> > system and then on one that doesn't, to see how it would behave,
> > probably it would say something about a syntax error?
> > 
> 
> Most likely, yes, it would be flagged as a syntax error in the event name.
> I'd prefer we fix this. I have the new patch ready, do you want me to just
> send you that patch instead of the series?

we could also detect the extension via build features
and have HAVE_FEATURE_ macro defined for it, so we'd
have full functionality on system with its support

but maybe that's little too much for feature this size,
or we can add it later.. now I'd be ok with the limited
functionality as well

jirka
