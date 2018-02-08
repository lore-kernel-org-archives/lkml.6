Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeBHMUf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:20:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeBHMUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:20:33 -0500
Date: Thu, 8 Feb 2018 13:20:31 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Wang YanQing <udknight@gmail.com>, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Provide libtraceevent with a kernel symbol
 resolver
Message-ID: <20180208122031.GA30130@krava>
References: <20180115044732.GB20373@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115044732.GB20373@udknight>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 12:47:32PM +0800, Wang YanQing wrote:
> So that beautifiers wanting to resolve kernel function addresses to
> names can do its work, and when we use "perf report" for output of
> "perf kmem record", we will get kernel symbol output.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-report.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dd4df9a..7b65100 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1317,6 +1317,15 @@ int cmd_report(int argc, const char **argv)
>  		report.range_num = 1;
>  	}
>  
> +	if (session->tevent.pevent &&
> +	    pevent_set_function_resolver(session->tevent.pevent,
> +					 machine__resolve_kernel_addr,
> +					 &session->machines.host) < 0) {
> +		pr_err("%s: failed to set libtraceevent function resolver\n",
> +		       __func__);
> +		return -1;
> +	}
> +
>  	sort__setup_elide(stdout);
>  
>  	ret = __cmd_report(&report);
> -- 
> 1.8.5.6.2.g3d8a54e.dirty
> 
