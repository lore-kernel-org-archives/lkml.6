Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeCPIA0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:00:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:12751 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbeCPIAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:00:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,313,1517904000";
   d="scan'208";a="25003681"
Date: Fri, 16 Mar 2018 15:51:09 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: changbin.du@intel.com
Cc: acme@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: remove redundant ')'
Message-ID: <20180316075108.xwenvklz3a6scodh@intel.com>
References: <1520937601-24952-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520937601-24952-1-git-send-email-changbin.du@intel.com>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, How about this simple one? Thanks.

On Tue, Mar 13, 2018 at 06:40:01PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> There is a redundant ')' at the tail of each event. So remove it.
> $ sudo perf trace --no-syscalls -e 'kmem:*' -a
>    899.342 kmem:kfree:(vfs_writev+0xb9) call_site=ffffffff9c453979 ptr=(nil))
>    899.344 kmem:kfree:(___sys_recvmsg+0x188) call_site=ffffffff9c9b8b88 ptr=(nil))
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e7f1b18..7273f5f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1959,7 +1959,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
>  				      trace->output);
>  	}
>  
> -	fprintf(trace->output, ")\n");
> +	fprintf(trace->output, "\n");
>  
>  	if (callchain_ret > 0)
>  		trace__fprintf_callchain(trace, sample);
> -- 
> 2.7.4
> 

-- 
Thanks,
Changbin Du
