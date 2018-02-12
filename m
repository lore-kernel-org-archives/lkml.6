Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeBLBvb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:51:31 -0500
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:54074 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbeBLBva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:51:30 -0500
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 12 Feb 2018 10:51:28 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Sangwon Hong <qpakzk@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 1/2] perf kmem: Document a missing option & an argument
Message-ID: <20180212015128.GC31513@sejong>
References: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 05:38:36AM +0900, Sangwon Hong wrote:
> First, perf kmem has --force option, but didn't document it on the man
> page. So add missing --force option.
> 
> Second, --time option has to get a value, but didn't specify it on the
> man page. So describe --time option's argument.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Taeung Song <treeze.taeung@gmail.com>
> Signed-off-by: Sangwon Hong <qpakzk@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

A nit below though..


> ---
>  tools/perf/Documentation/perf-kmem.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-kmem.txt b/tools/perf/Documentation/perf-kmem.txt
> index 479fc32..c4aa843 100644
> --- a/tools/perf/Documentation/perf-kmem.txt
> +++ b/tools/perf/Documentation/perf-kmem.txt
> @@ -25,6 +25,9 @@ OPTIONS
>  --input=<file>::
>  	Select the input file (default: perf.data unless stdin is a fifo)
>  
> +-f::
> +--force::
> +	Don't do ownership validation

Please add a blank line here

Thanks,
Namhyung


>  -v::
>  --verbose::
>          Be more verbose. (show symbol address, etc)
> @@ -61,7 +64,7 @@ OPTIONS
>  	default, but this option shows live (currently allocated) pages
>  	instead.  (This option works with --page option only)
>  
> ---time::
> +--time=<start>,<stop>::
>  	Only analyze samples within given time window: <start>,<stop>. Times
>  	have the format seconds.microseconds. If start is not given (i.e., time
>  	string is ',x.y') then analysis starts at the beginning of the file. If
> -- 
> 2.7.4
> 
