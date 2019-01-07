Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BFC206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma6PEGfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbfAGOzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:55:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34345 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfAGOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:55:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so747168wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=A8FKJ4B1FFfc+QSjZQillPCgTS6sp0GxRUAJ4+ssX8E=;
        b=Ma6PEGfAyixtcpSj0vsWS7MUzLw2FdYV0bxIJHjwFCrCnmnoHfz8MmGqrrnvjhzS/h
         s9o2TNU65XRuPcsOIBQpm5rYR8Za7KO+ta6OhyjM3YKIC1Z9MHlBtG7oVrXgBBUOPdnd
         Cwc0doeYS6QHOh1sPUh16iPz/J4s08tNQGyQlpcBK162qMNDclmklog8wo0mQZ1grbfV
         vn+u8KAiYPiTKhXGft5pEtFjt/hJKItbN/FUeoVd1RZoRWGaySlPNoSzC6FxX8B2jT3i
         Ai1sHR3o9/OihyajeTk30Hn14UOTWyHgju8sUe6Bvs1Mt+XsI3sQCorSmdidUsCN8VFZ
         TjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A8FKJ4B1FFfc+QSjZQillPCgTS6sp0GxRUAJ4+ssX8E=;
        b=FjcVcFZMW0KyXZqhd2djfTHl8gc3IkPEFZxwLKt8vAFuhR6L6BE7bA8WLiEm8O7xJf
         KsRGzr9pGGREWT5dCySgixb2mYZy0IJwHV17BGMWDwLHPh2fsB16XdEYEY4zoOecxdcb
         hdSIMQEusrUy3RAvVvyFf8fVJumqhbQSBa172FAIzsKtO5b220xYdZP8GzPDg6GVf2QX
         9vR7o99JFvJdqZqK89wereuXcHmGHE14lPISsMZ3s3u5It6pYqUeP105PL3lS0P3w9m1
         M42L5OsREw+BYhJar+t1n3yqaWRPnt7Qz88KXZFNKrx6r1+ogshBhg2PoRgFkBGlNNDI
         6mXg==
X-Gm-Message-State: AJcUukeG5xzkEtCXsB/eKPCjpVAi16bln2fjbqCA6k7iRLYnDu9GoO+H
        lNbXyZxhVChCfCqX/oTUl9Vzl1s8aw==
X-Google-Smtp-Source: ALg8bN4OUlAHAvtZbNyUg1rhussxFdJiOogbEefwY/yjEIcGWqBfr/oGicYln3m2HkjZi2q5J3TliA==
X-Received: by 2002:adf:f308:: with SMTP id i8mr11022232wro.219.1546872938326;
        Mon, 07 Jan 2019 06:55:38 -0800 (PST)
Received: from localhost (host89-130-dynamic.43-79-r.retail.telecomitalia.it. [79.43.130.89])
        by smtp.gmail.com with ESMTPSA id 125sm9702383wmm.26.2019.01.07.06.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 06:55:37 -0800 (PST)
Date:   Mon, 7 Jan 2019 15:55:36 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] kprobes: Mark ftrace mcount handler functions
 nokprobe
Message-ID: <20190107145536.GA1944@xps-13>
References: <154686789378.15479.2886543882215785247.stgit@devbox>
 <154686795211.15479.15577152313750689302.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154686795211.15479.15577152313750689302.stgit@devbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:32:32PM +0900, Masami Hiramatsu wrote:
> Mark ftrace mcount handler functions nokprobe since
> probing on these functions with kretprobe pushes
> return address incorrectly on kretprobe shadow stack.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> ---
>  kernel/trace/ftrace.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f0ff24173a0b..ad4babad4a03 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6250,7 +6250,7 @@ void ftrace_reset_array_ops(struct trace_array *tr)
>  	tr->ops->func = ftrace_stub;
>  }
>  
> -static inline void
> +static nokprobe_inline void

I think we need to #include <linux/kprobes.h>, otherwise:

  CC      kernel/trace/ftrace.o
kernel/trace/ftrace.c:6219:24: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘void’
 static nokprobe_inline void
                        ^~~~

 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3a58ad280d83..0333241034d5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -32,6 +32,7 @@
 #include <linux/sort.h>
 #include <linux/list.h>
 #include <linux/hash.h>
+#include <linux/kprobes.h>
 #include <linux/rcupdate.h>
 
 #include <trace/events/sched.h>

Thanks,
-Andrea

>  __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *ignored, struct pt_regs *regs)
>  {
> @@ -6310,11 +6310,13 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
>  }
> +NOKPROBE_SYMBOL(ftrace_ops_list_func);
>  #else
>  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip)
>  {
>  	__ftrace_ops_list_func(ip, parent_ip, NULL, NULL);
>  }
> +NOKPROBE_SYMBOL(ftrace_ops_no_ops);
>  #endif
>  
>  /*
> @@ -6341,6 +6343,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
>  	preempt_enable_notrace();
>  	trace_clear_recursion(bit);
>  }
> +NOKPROBE_SYMBOL(ftrace_ops_assist_func);
>  
>  /**
>   * ftrace_ops_get_func - get the function a trampoline should call
