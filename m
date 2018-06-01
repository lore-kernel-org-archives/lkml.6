Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeFANUB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFANUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:20:00 -0400
Date: Fri, 1 Jun 2018 10:19:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix hist_entry__tui_annotate declaration for
 !HAVE_SLANG_SUPPORT
Message-ID: <20180601131957.GC12795@kernel.org>
References: <20180601095648.20737-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180601095648.20737-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 01, 2018 at 11:56:48AM +0200, Jiri Olsa escreveu:
> The compilation is broken if there's no slang support:
> 
>   builtin-annotate.c: In function ‘hists__find_annotations’:
>   builtin-annotate.c:344:10: error: too many arguments to function ‘hist_entry__tui_annotate’
>       key = hist_entry__tui_annotate(he, evsel, NULL, &ann->opts);
> 
> Adding the missing argument to hist_entry__tui_annotate function.

Thanks, I think I have this fixed locally.

- Arnaldo
 
> Fixes: 464fb4fd6af7 ("perf hists browser: Pass annotation_options from tool to browser")
> Link: http://lkml.kernel.org/n/tip-vgf5a8wk0eyayo7omvutwhqo@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/hist.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 256292b18bb8..9b1a68a685d4 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -446,7 +446,8 @@ static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
>  
>  static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>  					   struct perf_evsel *evsel __maybe_unused,
> -					   struct hist_browser_timer *hbt __maybe_unused)
> +					   struct hist_browser_timer *hbt __maybe_unused,
> +					   struct annotation_options *annotation_opts)
>  {
>  	return 0;
>  }
> -- 
> 2.13.6
