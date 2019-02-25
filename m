Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA57DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4E72184D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBzkFIeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBYOFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:05:42 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:40411 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfBYOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:05:41 -0500
Received: by mail-qt1-f176.google.com with SMTP id j36so10515286qta.7;
        Mon, 25 Feb 2019 06:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQt2GkvgYdpVIPRZhjcon2sWX8+fswkp59BKaq2UYz4=;
        b=OBzkFIeNRuxs6+0V3lkQ6rxwj4Tx0BRX34zcSmGenoCEOvf5bJPx+JD2mq/Uw2Rgct
         MwRmrYcQbs9Q2rxyX8ULvnTAhmE1IigEQhM3eo2SEMyGuYdoncsqrH85g4zzvENtP8G1
         mbvj+gkMsO/yH8bTVMmr4xbGe5X17PakpmqR1L9bZJ0C5SA1A4lWSMuLiGJ44dvKbz0x
         lmAgSdc/2LlOShom3PSQeui7WlpeJCwXFiEf2vHYgPA5A5KfGBmuuTxOubw94LaZs7AB
         /OHAhx/DeZxTXlvxCWQWIDuxAqw1KjPhVlQPE3jAXxoueJCJJJ21EI6UhvlC/KiEtvGR
         180A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQt2GkvgYdpVIPRZhjcon2sWX8+fswkp59BKaq2UYz4=;
        b=dxOpWTU2eGJc5N7AUBM1+ng1Rzoe+QxJIHwkaJnXrkl5L7xD+4CM1B5mRCneLJ0bSa
         0jBkxGN4m+4P/dQHY3SGsUD5AdH1Xlx7OlsfD0rf82xI/7pef/4am3sqo1ofo9payFny
         VAn3NbxEkSK3OLrUNruS1Nn5fUyvJzrsBwh61ORseKw3C4B/hyS3RgmUb8EBB3kMGu2d
         kuYiDlvUhJ8hvqpxJMGBcrYKQTa9Spa1qXvp/KDIzdYPU6r0IfIsY9Eeyj7SWMwr5JhX
         UQ7K40aAJYZM0o1y3RXxNp3jf6q2MQnpEh05Rt0swXDi2t8MJi9JgEQAhlVYwJr8xLZ5
         p8EQ==
X-Gm-Message-State: AHQUAubS6mnfNWuHa615rvVMSKJMc+eNGIQbo5btUw1N4llYBtAYV4Zi
        PJBaYR+A21KkwuGLH6Mv+MLjamV0
X-Google-Smtp-Source: AHgI3IZRaJ4SWOF/7pX6F5NhASywzI2wDXp5oElJT9ExSUcsHiMIMS78QxMW6Ck33OCpLdZ8yJSb5w==
X-Received: by 2002:a0c:f2d3:: with SMTP id c19mr13453886qvm.230.1551103539647;
        Mon, 25 Feb 2019 06:05:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id r64sm5634049qkb.60.2019.02.25.06.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:05:38 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 212064039C; Mon, 25 Feb 2019 11:05:35 -0300 (-03)
Date:   Mon, 25 Feb 2019 11:05:35 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: Re: [PATCH 02/15] perf script python: add Python3 support to
 check-perf-trace.py
Message-ID: <20190225140535.GE31136@kernel.org>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-3-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222230619.17887-3-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:06:06PM -0800, Tony Jones escreveu:
> Support both Python 2 and Python 3 in the check-perf-trace.py script.
> 
> There may be differences in the ordering of output lines due to
> differences in dictionary ordering etc.  However the format within lines
> should be unchanged.
> 
> Also correct inconsistent indentation which was being flagged by Python3.

When we have "Also" in a patch, usually it need to be split :-)

- Arnaldo
 
> The use of from __future__ implies the minimum supported version of
> Python2 is now v2.6
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Cc: Tom Zanussi <tzanussi@gmail.com>
> ---
>  tools/perf/scripts/python/check-perf-trace.py | 68 ++++++++++---------
>  1 file changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
> index 334599c6032c..2851cf0e6b4b 100644
> --- a/tools/perf/scripts/python/check-perf-trace.py
> +++ b/tools/perf/scripts/python/check-perf-trace.py
> @@ -7,11 +7,13 @@
>  # events, etc.  Basically, if this script runs successfully and
>  # displays expected results, Python scripting support should be ok.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  
> -sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> -	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
> +sys.path.append(os.environ['PERF_EXEC_PATH'] +
> +    '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
>  
>  from Core import *
>  from perf_trace_context import *
> @@ -19,37 +21,38 @@ from perf_trace_context import *
>  unhandled = autodict()
>  
>  def trace_begin():
> -	print "trace_begin"
> -	pass
> +    print("trace_begin")
> +    pass
>  
>  def trace_end():
> -        print_unhandled()
> +    print_unhandled()
>  
>  def irq__softirq_entry(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, vec):
> -		print_header(event_name, common_cpu, common_secs, common_nsecs,
> -			common_pid, common_comm)
> +    common_secs, common_nsecs, common_pid, common_comm,
> +    common_callchain, vec):
> +
> +    print_header(event_name, common_cpu, common_secs, common_nsecs,
> +        common_pid, common_comm)
>  
> -                print_uncommon(context)
> +    print_uncommon(context)
>  
> -		print "vec=%s\n" % \
> -		(symbol_str("irq__softirq_entry", "vec", vec)),
> +    print("vec=%s" %
> +        (symbol_str("irq__softirq_entry", "vec", vec)))
>  
>  def kmem__kmalloc(event_name, context, common_cpu,
> -	common_secs, common_nsecs, common_pid, common_comm,
> -	common_callchain, call_site, ptr, bytes_req, bytes_alloc,
> -	gfp_flags):
> -		print_header(event_name, common_cpu, common_secs, common_nsecs,
> -			common_pid, common_comm)
> +    common_secs, common_nsecs, common_pid, common_comm,
> +    common_callchain, call_site, ptr, bytes_req, bytes_alloc,
> +    gfp_flags):
>  
> -                print_uncommon(context)
> +    print_header(event_name, common_cpu, common_secs, common_nsecs,
> +        common_pid, common_comm)
>  
> -		print "call_site=%u, ptr=%u, bytes_req=%u, " \
> -		"bytes_alloc=%u, gfp_flags=%s\n" % \
> -		(call_site, ptr, bytes_req, bytes_alloc,
> +    print_uncommon(context)
>  
> -		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
> +    print("call_site=%u, ptr=%u, bytes_req=%u, "
> +        "bytes_alloc=%u, gfp_flags=%s\n" %
> +        (call_site, ptr, bytes_req, bytes_alloc,
> +        flag_str("kmem__kmalloc", "gfp_flags", gfp_flags))),
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
>      try:
> @@ -58,25 +61,26 @@ def trace_unhandled(event_name, context, event_fields_dict):
>          unhandled[event_name] = 1
>  
>  def print_header(event_name, cpu, secs, nsecs, pid, comm):
> -	print "%-20s %5u %05u.%09u %8u %-20s " % \
> -	(event_name, cpu, secs, nsecs, pid, comm),
> +    print("%-20s %5u %05u.%09u %8u %-20s " %
> +        (event_name, cpu, secs, nsecs, pid, comm),
> +                end='')
>  
>  # print trace fields not included in handler args
>  def print_uncommon(context):
> -    print "common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " \
> -        % (common_pc(context), trace_flag_str(common_flags(context)), \
> -               common_lock_depth(context))
> +    print("common_preempt_count=%d, common_flags=%s, common_lock_depth=%d, " %
> +        (common_pc(context), trace_flag_str(common_flags(context)),
> +        common_lock_depth(context))),
>  
>  def print_unhandled():
>      keys = unhandled.keys()
>      if not keys:
>          return
>  
> -    print "\nunhandled events:\n\n",
> +    print("\nunhandled events:\n")
>  
> -    print "%-40s  %10s\n" % ("event", "count"),
> -    print "%-40s  %10s\n" % ("----------------------------------------", \
> -                                 "-----------"),
> +    print("%-40s  %10s" % ("event", "count"))
> +    print("%-40s  %10s" % ("----------------------------------------",
> +                 "-----------"))
>  
>      for event_name in keys:
> -	print "%-40s  %10d\n" % (event_name, unhandled[event_name])
> +        print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
> -- 
> 2.20.1

-- 

- Arnaldo
