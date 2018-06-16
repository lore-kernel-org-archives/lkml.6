Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA0C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53862208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulj86c9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53862208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeFPJsT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932358AbeFPJsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:48:17 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822AE2087E;
        Sat, 16 Jun 2018 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529142496;
        bh=NzOA5MW67GY5PIUEdyhRQ/ZCNWwmC8v1oFQ5nMCALTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ulj86c9sUDvDF6bYxkctFCsxGQz5v8BbKYisNZMnkVh3ePxOYhtHo2QuJ99bYi/2g
         5zZcNexZd1pVV2CcAF2JEL4azz0JkdvP39I/b+6kes2hOmO1d9Xr4aVGQeP8XKB3pf
         5RbGN7jafMViRJKE47Fqhrf0rwWNxwfpffO7lGvQ=
Date:   Sat, 16 Jun 2018 18:48:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        bigeasy@linutronix.de, mhiramat@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com,
        mathieu.desnoyers@efficios.com, julia@ni.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix some errors in histogram documentation
Message-Id: <20180616184812.ad77980a00483a761e315c27@kernel.org>
In-Reply-To: <20180614224859.55864-1-joel@joelfernandes.org>
References: <20180614224859.55864-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 15:48:59 -0700
Joel Fernandes <joelaf@google.com> wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> Fix typos, inconsistencies in using quotes, incorrect section number,
> etc. in the trace histogram documentation.

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/trace/histogram.txt | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
> index 6e05510afc28..da955cd696f6 100644
> --- a/Documentation/trace/histogram.txt
> +++ b/Documentation/trace/histogram.txt
> @@ -1730,35 +1730,35 @@ If a variable isn't a key variable or prefixed with 'vals=', the
>  associated event field will be saved in a variable but won't be summed
>  as a value:
>  
> -  # echo 'hist:keys=next_pid:ts1=common_timestamp ... >> event/trigger
> +  # echo 'hist:keys=next_pid:ts1=common_timestamp ...' >> event/trigger
>  
>  Multiple variables can be assigned at the same time.  The below would
>  result in both ts0 and b being created as variables, with both
>  common_timestamp and field1 additionally being summed as values:
>  
> -  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ... >> \
> +  # echo 'hist:keys=pid:vals=$ts0,$b:ts0=common_timestamp,b=field1 ...' >> \
>  	event/trigger
>  
>  Note that variable assignments can appear either preceding or
>  following their use.  The command below behaves identically to the
>  command above:
>  
> -  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ... >> \
> +  # echo 'hist:keys=pid:ts0=common_timestamp,b=field1:vals=$ts0,$b ...' >> \
>  	event/trigger
>  
>  Any number of variables not bound to a 'vals=' prefix can also be
>  assigned by simply separating them with colons.  Below is the same
>  thing but without the values being summed in the histogram:
>  
> -  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ... >> event/trigger
> +  # echo 'hist:keys=pid:ts0=common_timestamp:b=field1 ...' >> event/trigger
>  
>  Variables set as above can be referenced and used in expressions on
>  another event.
>  
>  For example, here's how a latency can be calculated:
>  
> -  # echo 'hist:keys=pid,prio:ts0=common_timestamp ... >> event1/trigger
> -  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ... >> event2/trigger
> +  # echo 'hist:keys=pid,prio:ts0=common_timestamp ...' >> event1/trigger
> +  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp-$ts0 ...' >> event2/trigger
>  
>  In the first line above, the event's timetamp is saved into the
>  variable ts0.  In the next line, ts0 is subtracted from the second
> @@ -1767,7 +1767,7 @@ yet another variable, 'wakeup_lat'.  The hist trigger below in turn
>  makes use of the wakeup_lat variable to compute a combined latency
>  using the same key and variable from yet another event:
>  
> -  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ... >> event3/trigger
> +  # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
>  
>  2.2.2 Synthetic Events
>  ----------------------
> @@ -1808,10 +1808,11 @@ the command that defined it with a '!':
>  At this point, there isn't yet an actual 'wakeup_latency' event
>  instantiated in the event subsytem - for this to happen, a 'hist
>  trigger action' needs to be instantiated and bound to actual fields
> -and variables defined on other events (see Section 6.3.3 below).
> +and variables defined on other events (see Section 2.2.3 below on
> +how that is done using hist trigger 'onmatch' action). Once that is
> +done, the 'wakeup_latency' synthetic event instance is created.
>  
> -Once that is done, an event instance is created, and a histogram can
> -be defined using it:
> +A histogram can now be defined for the new synthetic event:
>  
>    # echo 'hist:keys=pid,prio,lat.log2:sort=pid,lat' >> \
>          /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
> @@ -1961,7 +1962,7 @@ hist trigger specification.
>      back to that pid, the timestamp difference is calculated.  If the
>      resulting latency, stored in wakeup_lat, exceeds the current
>      maximum latency, the values specified in the save() fields are
> -    recoreded:
> +    recorded:
>  
>      # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
>              if comm=="cyclictest"' >> \
> -- 
> 2.18.0.rc1.242.g61856ae69a-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
