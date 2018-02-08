Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHPWD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeBHPWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:22:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4982172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:21:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        liuzhengyuang521@gmail.com, linx.z.chen@intel.com
Subject: Re: [PATCH] ftrace: fix the file mode of graph tracer and stack
 tracer
Message-ID: <20180208102149.7e3bfe45@gandalf.local.home>
In-Reply-To: <1518054113-28096-1-git-send-email-liuzhengyuan@kylinos.cn>
References: <1518054113-28096-1-git-send-email-liuzhengyuan@kylinos.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Feb 2018 09:41:53 +0800
Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:

> It's something looks weird that those files could be written by root
> but shows with no write permission by ll command.
> Chen LinX <linx.z.chen@intel.com> has sent a similar patch to fix
> graph function file mode in 2000,  I didn't get the reason why that
> patch wasn't applied so I resend it.
> 
> Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
> ---
>  kernel/trace/ftrace.c      | 4 ++--
>  kernel/trace/trace_stack.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index ccdf366..fe903dc8 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5513,10 +5513,10 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
>  	ftrace_create_filter_files(&global_ops, d_tracer);
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -	trace_create_file("set_graph_function", 0444, d_tracer,
> +	trace_create_file("set_graph_function", 0644, d_tracer,

Thanks for resending the patch.

What's interesting is that this doesn't seem to affect whether or not
root can write to the file. I wonder if that's a bug itself.

-- Steve

>  				    NULL,
>  				    &ftrace_graph_fops);
> -	trace_create_file("set_graph_notrace", 0444, d_tracer,
> +	trace_create_file("set_graph_notrace", 0644, d_tracer,
>  				    NULL,
>  				    &ftrace_graph_notrace_fops);
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 734accc..4356f14 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -468,7 +468,7 @@ static __init int stack_trace_init(void)
>  			NULL, &stack_trace_fops);
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
> -	trace_create_file("stack_trace_filter", 0444, d_tracer,
> +	trace_create_file("stack_trace_filter", 0644, d_tracer,
>  			  &trace_ops, &stack_trace_filter_fops);
>  #endif
>  
