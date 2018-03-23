Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeCWNXQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:23:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:3235 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeCWNXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:23:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,350,1517904000";
   d="scan'208";a="26937403"
Message-ID: <1521811393.27781.2.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH] tracing: Fix a potential NULL dereference
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Fri, 23 Mar 2018 08:23:13 -0500
In-Reply-To: <20180323113735.GC28518@mwanda>
References: <20180323113735.GC28518@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Fri, 2018-03-23 at 14:37 +0300, Dan Carpenter wrote:
> We forgot to set the error code on this path so we return ERR_PTR(0)
> which is NULL.  It results in a NULL dereference in the caller.
> 
> Fixes: 100719dcef44 ("tracing: Add simple expression support to hist triggers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 4f027642ceef..a02bc09d765a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2776,6 +2776,7 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  		expr->fn = hist_field_plus;
>  		break;
>  	default:
> +		ret = -EINVAL;
>  		goto free;
>  	}
>  

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks for catching this!

Tom
