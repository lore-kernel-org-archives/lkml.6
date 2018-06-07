Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4+z7EvF+GVvBcAAAmS7hNA
	; Thu, 07 Jun 2018 18:58:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3F336074D; Thu,  7 Jun 2018 18:58:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsZfM6qB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4F459601D2;
	Thu,  7 Jun 2018 18:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F459601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeFGS6C (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932747AbeFGS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:58:00 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0DF20895;
        Thu,  7 Jun 2018 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528397880;
        bh=yEv351XTOTYXz0eD8cEy9PYciOpHlAo8TanyUNw6a9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsZfM6qBYWzgFw/Zn1qhVpWomur8U/d9muh8m+ORfbdSf2CAAWMObotLX6vawu3m1
         90gkeU1okfFtzNsHkt3lAltj4VE5psbnNyYebxy1PCFA14G4ek2a/5YjxY0EJOUROZ
         NUCQPAbVQIiPY7O80QoS3cv4px+NGWKx5mNI1rn0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4E98D1468B9; Thu,  7 Jun 2018 15:57:57 -0300 (-03)
Date: Thu, 7 Jun 2018 15:57:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 03/10] perf stat: Add --interval-clear option
Message-ID: <20180607185757.GB17292@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-4-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 12:15:06AM +0200, Jiri Olsa escreveu:
> Adding --interval-clear option to clear the screen
> before next interval.

Better than:

  watch -n 0 perf stat -a sleep 1

:-)

Tested and applied,

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-8zobiwghr6t9f9a4o886cmau@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-stat.txt |  3 +++
>  tools/perf/builtin-stat.c              | 11 +++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 5dfe102fb5b5..b10a90b6a718 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -178,6 +178,9 @@ Print count deltas for fixed number of times.
>  This option should be used together with "-I" option.
>  	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
>  
> +--interval-clear::
> +Clear the screen before next interval.
> +
>  --timeout msecs::
>  Stop the 'perf stat' session and print count deltas after N milliseconds (minimum: 10 ms).
>  This option is not supported with the "-I" option.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index fce46252f89c..067d8b5b2c83 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -65,6 +65,7 @@
>  #include "util/tool.h"
>  #include "util/string2.h"
>  #include "util/metricgroup.h"
> +#include "util/top.h"
>  #include "asm/bug.h"
>  
>  #include <linux/time64.h>
> @@ -173,6 +174,7 @@ static struct cpu_map		*aggr_map;
>  static aggr_get_id_t		aggr_get_id;
>  static bool			append_file;
>  static bool			interval_count;
> +static bool			interval_clear;
>  static const char		*output_name;
>  static int			output_fd;
>  static int			print_free_counters_hint;
> @@ -1713,9 +1715,12 @@ static void print_interval(char *prefix, struct timespec *ts)
>  	FILE *output = stat_config.output;
>  	static int num_print_interval;
>  
> +	if (interval_clear)
> +		puts(CONSOLE_CLEAR);
> +
>  	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, csv_sep);
>  
> -	if (num_print_interval == 0 && !csv_output) {
> +	if ((num_print_interval == 0 && !csv_output) || interval_clear) {
>  		switch (stat_config.aggr_mode) {
>  		case AGGR_SOCKET:
>  			fprintf(output, "#           time socket cpus");
> @@ -1747,7 +1752,7 @@ static void print_interval(char *prefix, struct timespec *ts)
>  		}
>  	}
>  
> -	if (num_print_interval == 0 && metric_only)
> +	if ((num_print_interval == 0 && metric_only) || interval_clear)
>  		print_metric_headers(" ", true);
>  	if (++num_print_interval == 25)
>  		num_print_interval = 0;
> @@ -2066,6 +2071,8 @@ static const struct option stat_options[] = {
>  		    "(overhead is possible for values <= 100ms)"),
>  	OPT_INTEGER(0, "interval-count", &stat_config.times,
>  		    "print counts for fixed number of times"),
> +	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
> +		    "clear screen in between new interval"),
>  	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
>  		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
>  	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
> -- 
> 2.13.6
