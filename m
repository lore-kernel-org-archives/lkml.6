Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640DBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F23D21721
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 03:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545535442;
	bh=3n369nWYZ8HdgrX8iixqClWPvKI3Eh2lTubEpB1cjFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IdLMId/Q2/552mbO6AhlXVE4oDzkIWE/IipFdIlHhxokm7RhpNPLvPNEUK9eWYQsZ
	 xDw0ZYNm6OFBSL9X4bbKXzDys9qZjAdgPgrx5z/UZjTlD8Yc4SWuPOXK4TmpjZsJGw
	 x5YrKG2TsFPNyQvj1qNMSN/emQcuidoJSALzZzDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405169AbeLWDYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 22:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731060AbeLWDX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 22:23:59 -0500
Received: from devbox (unknown [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400F32171F;
        Sun, 23 Dec 2018 03:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545535437;
        bh=3n369nWYZ8HdgrX8iixqClWPvKI3Eh2lTubEpB1cjFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VjOO+RnGqqB2x1Oqimux2xWnMkA6p8HqIUC/yH2GvF3WUsMEJOAJuIrfDIB9aIOl5
         QhH5Mgk8buG9WxB6uGFHCX5EjdKbXjfvfE5AOtCO3HUV1/CJ3cmqhHH3HfE2HdAdp5
         hBvhwiwZNCDyBPMnWp5pRyfQCJ+UOsedvJag+304=
Date:   Sun, 23 Dec 2018 12:23:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 5/5] tracing: Use the return of
 str_has_prefix() to remove open coded numbers
Message-Id: <20181223122352.dd3c077443f0b6621a796039@kernel.org>
In-Reply-To: <20181222162857.116914355@goodmis.org>
References: <20181222162007.697862256@goodmis.org>
        <20181222162857.116914355@goodmis.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2018 11:20:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> There are several locations that compare constants to the beginning of
> string variables to determine what commands should be done, then the
> constant length is used to index into the string. This is error prone as the
> hard coded numbers have to match the size of the constants. Instead, use the
> len returned from str_has_prefix() and remove the open coded string length
> sizes.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

for trace_probe part.

Thanks!

> 
> Cc: Joe Perches <joe@perches.com>
> Cc: Masami  Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c       |  8 +++++---
>  kernel/trace/trace_probe.c | 17 +++++++++--------
>  kernel/trace/trace_stack.c |  6 ++++--
>  3 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index eac2824a18ab..18b86c3974e1 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4408,13 +4408,15 @@ static int trace_set_options(struct trace_array *tr, char *option)
>  	int neg = 0;
>  	int ret;
>  	size_t orig_len = strlen(option);
> +	int len;
>  
>  	cmp = strstrip(option);
>  
> -	if (str_has_prefix(cmp, "no")) {
> +	len = str_has_prefix(cmp, "no");
> +	if (len)
>  		neg = 1;
> -		cmp += 2;
> -	}
> +
> +	cmp += len;
>  
>  	mutex_lock(&trace_types_lock);
>  
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 541375737403..9962cb5da8ac 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -186,19 +186,20 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  			    struct fetch_insn *code, unsigned int flags)
>  {
> -	int ret = 0;
>  	unsigned long param;
> +	int ret = 0;
> +	int len;
>  
>  	if (strcmp(arg, "retval") == 0) {
>  		if (flags & TPARG_FL_RETURN)
>  			code->op = FETCH_OP_RETVAL;
>  		else
>  			ret = -EINVAL;
> -	} else if (str_has_prefix(arg, "stack")) {
> -		if (arg[5] == '\0') {
> +	} else if ((len = str_has_prefix(arg, "stack"))) {
> +		if (arg[len] == '\0') {
>  			code->op = FETCH_OP_STACKP;
> -		} else if (isdigit(arg[5])) {
> -			ret = kstrtoul(arg + 5, 10, &param);
> +		} else if (isdigit(arg[len])) {
> +			ret = kstrtoul(arg + len, 10, &param);
>  			if (ret || ((flags & TPARG_FL_KERNEL) &&
>  				    param > PARAM_MAX_STACK))
>  				ret = -EINVAL;
> @@ -213,10 +214,10 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
>  	} else if (((flags & TPARG_FL_MASK) ==
>  		    (TPARG_FL_KERNEL | TPARG_FL_FENTRY)) &&
> -		   str_has_prefix(arg, "arg")) {
> -		if (!isdigit(arg[3]))
> +		   (len = str_has_prefix(arg, "arg"))) {
> +		if (!isdigit(arg[len]))
>  			return -EINVAL;
> -		ret = kstrtoul(arg + 3, 10, &param);
> +		ret = kstrtoul(arg + len, 10, &param);
>  		if (ret || !param || param > PARAM_MAX_STACK)
>  			return -EINVAL;
>  		code->op = FETCH_OP_ARG;
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 3641f28c343f..eec648a0d673 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -448,8 +448,10 @@ static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
>  
>  static __init int enable_stacktrace(char *str)
>  {
> -	if (str_has_prefix(str, "_filter="))
> -		strncpy(stack_trace_filter_buf, str+8, COMMAND_LINE_SIZE);
> +	int len;
> +
> +	if ((len = str_has_prefix(str, "_filter=")))
> +		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
>  
>  	stack_tracer_enabled = 1;
>  	last_stack_tracer_enabled = 1;
> -- 
> 2.19.2
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
