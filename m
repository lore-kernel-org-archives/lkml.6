Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA0FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAE520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAE520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbeGZQJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbeGZQJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:09:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BD520673;
        Thu, 26 Jul 2018 14:51:54 +0000 (UTC)
Date:   Thu, 26 Jul 2018 10:51:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: tracing: Fix a typo of trace_stat
Message-ID: <20180726105152.6aa98a8f@gandalf.local.home>
In-Reply-To: <153260901588.12474.13361141902967649729.stgit@devbox>
References: <153260898648.12474.8316095450186108842.stgit@devbox>
        <153260901588.12474.13361141902967649729.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jon,

Can you take this patch?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I'll take the other two.

Thanks!

-- Steve


On Thu, 26 Jul 2018 21:43:36 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> The name of the directory for per-cpu function statistics
> is trace_stat, not trace_stats.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  0 files changed
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index a20d34955333..7ea16a0ceffc 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -329,9 +329,9 @@ of ftrace. Here is a list of some of the key files:
>  	track of the time spent in those functions. The histogram
>  	content can be displayed in the files:
>  
> -	trace_stats/function<cpu> ( function0, function1, etc).
> +	trace_stat/function<cpu> ( function0, function1, etc).
>  
> -  trace_stats:
> +  trace_stat:
>  
>  	A directory that holds different tracing stats.
>  
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index dcc0166d1997..a47f77d27673 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -521,7 +521,7 @@ config FUNCTION_PROFILER
>  	  in debugfs called function_profile_enabled which defaults to zero.
>  	  When a 1 is echoed into this file profiling begins, and when a
>  	  zero is entered, profiling stops. A "functions" file is created in
> -	  the trace_stats directory; this file shows the list of functions that
> +	  the trace_stat directory; this file shows the list of functions that
>  	  have been hit and their counters.
>  
>  	  If in doubt, say N.

