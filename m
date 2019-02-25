Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E35CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ED420652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBYMi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:38:29 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:54818 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfBYMi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:38:29 -0500
Received: from cpe-2606-a000-111b-405a-9816-2c85-c514-8f7a.dyn6.twc.com ([2606:a000:111b:405a:9816:2c85:c514:8f7a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gyFWa-0002xg-DB; Mon, 25 Feb 2019 07:38:26 -0500
Date:   Mon, 25 Feb 2019 07:37:55 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/15] perf script python: add Python3 support to
 net_dropmonitor.py
Message-ID: <20190225123755.GA30699@hmswarspite.think-freely.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-9-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-9-tonyj@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:06:12PM -0800, Tony Jones wrote:
> Support both Python2 and Python3 in the net_dropmonitor.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Neil Horman <nhorman@tuxdriver.com>
> ---
>  tools/perf/scripts/python/net_dropmonitor.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
> index a150164b44a3..212557a02c50 100755
> --- a/tools/perf/scripts/python/net_dropmonitor.py
> +++ b/tools/perf/scripts/python/net_dropmonitor.py
> @@ -1,6 +1,8 @@
>  # Monitor the system for dropped packets and proudce a report of drop locations and counts
>  # SPDX-License-Identifier: GPL-2.0
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  
> @@ -50,19 +52,19 @@ def get_sym(sloc):
>  		return (None, 0)
>  
>  def print_drop_table():
> -	print "%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT")
> +	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
>  	for i in drop_log.keys():
>  		(sym, off) = get_sym(i)
>  		if sym == None:
>  			sym = i
> -		print "%25s %25s %25s" % (sym, off, drop_log[i])
> +		print("%25s %25s %25s" % (sym, off, drop_log[i]))
>  
>  
>  def trace_begin():
> -	print "Starting trace (Ctrl-C to dump results)"
> +	print("Starting trace (Ctrl-C to dump results)")
>  
>  def trace_end():
> -	print "Gathering kallsyms data"
> +	print("Gathering kallsyms data")
>  	get_kallsyms_table()
>  	print_drop_table()
>  
> -- 
> 2.20.1
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
