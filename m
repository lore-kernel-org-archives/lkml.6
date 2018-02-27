Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeB0Gx5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 01:53:57 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34862 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeB0Gx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 01:53:56 -0500
X-Google-Smtp-Source: AH8x227j1MWZwgC7Wi6sAXCVx9ifB7PZqzf5GSK1CLKXRFm6p3QmV4+zcDXk96QPDVAm2ijH/D+GMw==
Date: Tue, 27 Feb 2018 07:53:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: kan.liang@intel.com
Cc: acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf top: Fix annoying fallback message on older kernel
Message-ID: <20180227065352.kuuwworei2uxwbd4@gmail.com>
References: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@intel.com <kan.liang@intel.com> wrote:

> From: Kan Liang <Kan.liang@intel.com>
> 
> On older (v4.4) kernels, the annoying fallback message can be observed
> in 'perf top'.
> 
> The 'perf top' has been changed to overwrite mode since
> 'commit ebebbf082357 ("perf top: Switch default mode to overwrite mode")'
> For the older kernels which don't have overwrite mode support, the 'perf
> top' will fall back to non-overwrite mode and print out the fallback
> message by ui__warning, which needs user's input to close.
> 
> The fallback message is not critical message for end users. Turning it
> to debug message which is printed when running with -vv.
> 
> Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
> Reported-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Kan Liang <Kan.liang@intel.com>
> ---
>  tools/perf/builtin-top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index b7c823b..35ac016 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -991,7 +991,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
>  	evlist__for_each_entry(evlist, counter)
>  		counter->attr.write_backward = false;
>  	opts->overwrite = false;
> -	ui__warning("fall back to non-overwrite mode\n");
> +	pr_debug2("fall back to non-overwrite mode\n");
>  	return 1;
>  }

Thanks!

	Ingo
