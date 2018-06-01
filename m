Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbeFAQET (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752992AbeFAQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:04:15 -0400
Date: Fri, 1 Jun 2018 13:03:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix hist_entry__tui_annotate declaration for
 !HAVE_SLANG_SUPPORT
Message-ID: <20180601160339.GK25467@kernel.org>
References: <20180601095648.20737-1-jolsa@kernel.org>
 <20180601131957.GC12795@kernel.org>
 <20180601152155.GA1602@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601152155.GA1602@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 01, 2018 at 05:21:55PM +0200, Jiri Olsa escreveu:
> On Fri, Jun 01, 2018 at 10:19:57AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jun 01, 2018 at 11:56:48AM +0200, Jiri Olsa escreveu:
> > > Adding the missing argument to hist_entry__tui_annotate function.

> > Thanks, I think I have this fixed locally.

> > > +++ b/tools/perf/util/hist.h
> > > @@ -446,7 +446,8 @@ static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
> > >  
> > >  static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
> > >  					   struct perf_evsel *evsel __maybe_unused,
> > > -					   struct hist_browser_timer *hbt __maybe_unused)
> > > +					   struct hist_browser_timer *hbt __maybe_unused,
> > > +					   struct annotation_options *annotation_opts)
> 
> good, because I sent you wrong one.. without __maybe_unused ;-) sry

Erm, I hadn't, so I just fixed this and force pushed perf/core

https://git.kernel.org/acme/c/2b90f5c0c0a6

- Arnaldo
