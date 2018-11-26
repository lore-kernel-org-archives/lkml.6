Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9932086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuSG9zlX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9932086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeKZSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbeKZSdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:33:19 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA97D20663;
        Mon, 26 Nov 2018 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543218005;
        bh=9FJhciFxOlUWmW4YqgEibELgV10hqWDKRTnhqdIRGtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UuSG9zlXcHibDeG2KdnvUmJiDH+xLg4k6uPeMJWRWIXKMGE/1+pPGxCnsTqcBhnEd
         0wT7F3ArHKYDKRldzMhYIM0pdwa7GysAt4d1UMJ38JFsLU7J83KA5m8rOYIALjSRfg
         DmVurD1FtX+i+Tazm8rhpvDW5DNU7lzNVEzXBwFg=
Date:   Mon, 26 Nov 2018 16:40:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 08/14] function_graph: Remove unused
 task_curr_ret_stack()
Message-Id: <20181126164002.16e2e924529f52fb4d46d2f4@kernel.org>
In-Reply-To: <20181122012803.706044851@goodmis.org>
References: <20181122012708.491151844@goodmis.org>
        <20181122012803.706044851@goodmis.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 20:27:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The static inline function task_curr_ret_stack() is unused, remove it.

This looks able to be applied without this series. I think we should
apply this to for-next branch?

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,


> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/ftrace.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 477ff9412d26..5544df21a886 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -819,11 +819,6 @@ extern void ftrace_graph_init_task(struct task_struct *t);
>  extern void ftrace_graph_exit_task(struct task_struct *t);
>  extern void ftrace_graph_init_idle_task(struct task_struct *t, int cpu);
>  
> -static inline int task_curr_ret_stack(struct task_struct *t)
> -{
> -	return t->curr_ret_stack;
> -}
> -
>  static inline void pause_graph_tracing(void)
>  {
>  	atomic_inc(&current->tracing_graph_pause);
> @@ -847,11 +842,6 @@ static inline int register_ftrace_graph(struct fgraph_ops *ops);
>  }
>  static inline void unregister_ftrace_graph(struct fgraph_ops *ops) { }
>  
> -static inline int task_curr_ret_stack(struct task_struct *tsk)
> -{
> -	return -1;
> -}
> -
>  static inline unsigned long
>  ftrace_graph_ret_addr(struct task_struct *task, int *idx, unsigned long ret,
>  		      unsigned long *retp)
> -- 
> 2.19.1
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
