Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49967C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BF82150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BF82150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeHYBBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeHYBBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:01:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1784F2150F;
        Fri, 24 Aug 2018 21:24:44 +0000 (UTC)
Date:   Fri, 24 Aug 2018 17:24:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/32] selftests/ftrace: More initialize features in
 initialize_ftrace
Message-ID: <20180824172443.4900cda2@gandalf.local.home>
In-Reply-To: <153443709338.23257.2179609309041817332.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443709338.23257.2179609309041817332.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:31:33 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Clear pid filter, synthetic_events, snapshots,
> ftrace filter, and trace log in initialize_ftrace(),
> since those are used in test cases.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>   Changes in v2:
>    - Add reset_ftrace_filter
> ---
>  tools/testing/selftests/ftrace/test.d/functions |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index e4645d5e3126..b2bfa4dd43f7 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -89,12 +89,17 @@ initialize_ftrace() { # Reset ftrace to initial-state
>      reset_tracer
>      reset_trigger
>      reset_events_filter
> +    reset_ftrace_filter
>      disable_events
>      echo > set_event_pid	# event tracer is always on
> +    echo > set_ftrace_pid
>      [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
>      [ -f set_graph_function ] && echo | tee set_graph_*
>      [ -f stack_trace_filter ] && echo > stack_trace_filter
>      [ -f kprobe_events ] && echo > kprobe_events
>      [ -f uprobe_events ] && echo > uprobe_events
> +    [ -f synthetic_events ] && echo > synthetic_events
> +    [ -f snapshot ] && echo 0 > snapshot
> +    clear_trace
>      enable_tracing
>  }

