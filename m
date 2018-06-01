Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeFAPWB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:22:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752107AbeFAPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:21:57 -0400
Date: Fri, 1 Jun 2018 17:21:55 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix hist_entry__tui_annotate declaration for
 !HAVE_SLANG_SUPPORT
Message-ID: <20180601152155.GA1602@krava>
References: <20180601095648.20737-1-jolsa@kernel.org>
 <20180601131957.GC12795@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180601131957.GC12795@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:19:57AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 01, 2018 at 11:56:48AM +0200, Jiri Olsa escreveu:
> > The compilation is broken if there's no slang support:
> > 
> >   builtin-annotate.c: In function ‘hists__find_annotations’:
> >   builtin-annotate.c:344:10: error: too many arguments to function ‘hist_entry__tui_annotate’
> >       key = hist_entry__tui_annotate(he, evsel, NULL, &ann->opts);
> > 
> > Adding the missing argument to hist_entry__tui_annotate function.
> 
> Thanks, I think I have this fixed locally.
> 
> - Arnaldo
>  
> > Fixes: 464fb4fd6af7 ("perf hists browser: Pass annotation_options from tool to browser")
> > Link: http://lkml.kernel.org/n/tip-vgf5a8wk0eyayo7omvutwhqo@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/hist.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> > index 256292b18bb8..9b1a68a685d4 100644
> > --- a/tools/perf/util/hist.h
> > +++ b/tools/perf/util/hist.h
> > @@ -446,7 +446,8 @@ static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
> >  
> >  static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
> >  					   struct perf_evsel *evsel __maybe_unused,
> > -					   struct hist_browser_timer *hbt __maybe_unused)
> > +					   struct hist_browser_timer *hbt __maybe_unused,
> > +					   struct annotation_options *annotation_opts)

good, because I sent you wrong one.. without __maybe_unused ;-) sry

jirka
