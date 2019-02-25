Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B90C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E1D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g59257IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfBYOJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:09:12 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:45269 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBYOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:09:11 -0500
Received: by mail-qt1-f180.google.com with SMTP id d18so10495469qtg.12;
        Mon, 25 Feb 2019 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtkpR0jwK5/2SO55Dxxw3+yARKBB3w8d7o6IKNBLwC4=;
        b=g59257INkhRlM0h/SRJbaBi88xI5NPM3DA0/k1iJsJx6ebvkTRmQ4KV8SPY1mEoDSj
         gYS/hSfJvRsbFQU/1amlsBSVGIBedyQLu1Z3XgqEytGbSbzaaGpctPk3oYnpIBmWJYw7
         +pq9Swowp6rEdEw6Cg4/MnZYNu+odkJdxocJbC4GPQwon0g6h3sCQn3YqSN+f3hf3Ge7
         bzNEQT2V1CRVFNoAbyYk4uN8O2SZNj4FCDr7aoqTrL2QSjEjnEhhzqMzsvwhsrzsgic5
         u1oewwaGbQ2E2SZi6rtzCwt3+gGgT5qyOPcAP1k5QjKSgmWNnZZllza1Vadof9DzvDYL
         z02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtkpR0jwK5/2SO55Dxxw3+yARKBB3w8d7o6IKNBLwC4=;
        b=cIefF1UhFd+c6V8aM7iY1fWhYwgR1APRb7TIuNV/TpLzOBD+kMhsWKS0mFIY4E+XGX
         vEH8A9/DVIDmw0H2yOu+nUnGTGiDgh7SqjCqovdkYE+gLE0piWzbhnRTIix6UgHbCyfT
         zEIKRE52EwIzHHeYq2TvQgN8IozZCyXidiMkey7eGAALGvofZGg4dr4HPnJ7ZoXVLPLV
         uSH1r4qlggxmWU4PuUsawrIx94x+gC3necU9eLNjefOZW2XDZFVi7Xuzt0GyFo/IMU25
         5miwc6zPY+eeYggztjAO7tQgw7Q/4QJFTtqnKQAgKKzybLtXLhZnLkrEXTfW1cJKmaSB
         I4tw==
X-Gm-Message-State: AHQUAuZhmt8k/ZkQ18RWAGQJlYW+sMTPLI9iooqjFRxFU1ZeUnDJGs8+
        B3yjmyxu8cvVpApae8/dMkA=
X-Google-Smtp-Source: AHgI3IYDWLUBOuSIHbp2WBpFfOH1wa0cWiH4ivKGRWPS+nRcb6keeu4EJqjpRhHGRUfTThGgfr0Cuw==
X-Received: by 2002:ac8:24e7:: with SMTP id t36mr13771459qtt.43.1551103750416;
        Mon, 25 Feb 2019 06:09:10 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id a3sm6709910qta.21.2019.02.25.06.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:09:09 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C4F774039C; Mon, 25 Feb 2019 11:09:06 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:09:06 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: Re: [PATCH 04/15] perf script python: add Python3 support to
 failed-syscalls-by-pid.py
Message-ID: <20190225140906.GG31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-5-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-5-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:08PM -0800, Tony Jones escreveu:
> Support both Python2 and Python3 in the failed-syscalls-by-pid.py script
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> The use of 'from __future__' implies the minimum supported Python2 version
> is now v2.6

Applied
 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Tom Zanussi <tzanussi@gmail.com>
> ---
>  .../scripts/python/failed-syscalls-by-pid.py  | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/failed-syscalls-by-pid.py b/tools/perf/scripts/python/failed-syscalls-by-pid.py
> index cafeff3d74db..3648e8b986ec 100644
> --- a/tools/perf/scripts/python/failed-syscalls-by-pid.py
> +++ b/tools/perf/scripts/python/failed-syscalls-by-pid.py
> @@ -5,6 +5,8 @@
>  # Displays system-wide failed system call totals, broken down by pid.
>  # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  
> @@ -32,7 +34,7 @@ if len(sys.argv) > 1:
>  syscalls = autodict()
>  
>  def trace_begin():
> -	print "Press control+C to stop and show the summary"
> +	print("Press control+C to stop and show the summary")
>  
>  def trace_end():
>  	print_error_totals()
> @@ -57,22 +59,21 @@ def syscalls__sys_exit(event_name, context, common_cpu,
>  
>  def print_error_totals():
>      if for_comm is not None:
> -	    print "\nsyscall errors for %s:\n\n" % (for_comm),
> +	    print("\nsyscall errors for %s:\n" % (for_comm))
>      else:
> -	    print "\nsyscall errors:\n\n",
> +	    print("\nsyscall errors:\n")
>  
> -    print "%-30s  %10s\n" % ("comm [pid]", "count"),
> -    print "%-30s  %10s\n" % ("------------------------------", \
> -                                 "----------"),
> +    print("%-30s  %10s" % ("comm [pid]", "count"))
> +    print("%-30s  %10s" % ("------------------------------", "----------"))
>  
>      comm_keys = syscalls.keys()
>      for comm in comm_keys:
>  	    pid_keys = syscalls[comm].keys()
>  	    for pid in pid_keys:
> -		    print "\n%s [%d]\n" % (comm, pid),
> +		    print("\n%s [%d]" % (comm, pid))
>  		    id_keys = syscalls[comm][pid].keys()
>  		    for id in id_keys:
> -			    print "  syscall: %-16s\n" % syscall_name(id),
> +			    print("  syscall: %-16s" % syscall_name(id))
>  			    ret_keys = syscalls[comm][pid][id].keys()
> -			    for ret, val in sorted(syscalls[comm][pid][id].iteritems(), key = lambda(k, v): (v, k),  reverse = True):
> -				    print "    err = %-20s  %10d\n" % (strerror(ret), val),
> +			    for ret, val in sorted(syscalls[comm][pid][id].items(), key = lambda kv: (kv[1], kv[0]),  reverse = True):
> +				    print("    err = %-20s  %10d" % (strerror(ret), val))
> -- 
> 2.20.1

-- 

- Arnaldo
