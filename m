Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbeE3EzU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:55:20 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40399 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeE3EzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:55:19 -0400
X-Google-Smtp-Source: ADUXVKKjEvhoMAn0NYK4D1iIAI+PoFqGpV53Yr3z9s3R8ejONrRf2QmIBjGwb8ZWbwrADHQwTdcfVQ==
Date: Wed, 30 May 2018 12:55:09 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] perf hists browser: Fix stale hist_entry__tui_annotate()
 declaration
Message-ID: <20180530045509.GA12368@leoy-ThinkPad-X240s>
References: <1527655767-12161-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527655767-12161-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, May 30, 2018 at 12:49:27PM +0800, Leo Yan wrote:
> Since commit 464fb4fd6af7 ("perf hists browser: Pass annotation_options
> from tool to browser") has added extra parameter for functions, but it
> missed to update hist_entry__tui_annotate() declaration for
> !HAVE_SLANG_SUPPORT configuration so this results in regression for perf
> tool building failure.
> 
> This patch is to update hist_entry__tui_annotate() declaration for
> new added argument '*annotation_opts'.

Seems to me this fixing should be merged into the patch "perf hists
browser: Pass annotation_options from tool to browser" because I
encountered this issue on perf/core branch.  Just remind for this.

Thanks,
Leo Yan

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/hist.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 5f30758..cafafbf 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -460,7 +460,8 @@ static inline int map_symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
>  
>  static inline int hist_entry__tui_annotate(struct hist_entry *he __maybe_unused,
>  					   struct perf_evsel *evsel __maybe_unused,
> -					   struct hist_browser_timer *hbt __maybe_unused)
> +					   struct hist_browser_timer *hbt __maybe_unused,
> +					   struct annotation_options *annotation_opts __maybe_unused)
>  {
>  	return 0;
>  }
> -- 
> 2.7.4
> 
