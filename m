Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeC1Pf0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753941AbeC1PfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:35:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90AE2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 28 Mar 2018 11:35:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wang Yu <yuwang@linux.alibaba.com>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix task's invalid comm of <...> when big pid
Message-ID: <20180328113522.21b4298b@gandalf.local.home>
In-Reply-To: <1522240347-24465-1-git-send-email-yuwang@linux.alibaba.com>
References: <1522240347-24465-1-git-send-email-yuwang@linux.alibaba.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 20:32:27 +0800
Wang Yu <yuwang@linux.alibaba.com> wrote:

> when pid is bigger than PID_MAX_DEFAULT, the comm of task
> is <...>, it is better use pid_max to compare
> 
> Signed-off-by: Wang Yu <yuwang@linux.alibaba.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 kernel/trace/trace.c
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> old mode 100644
> new mode 100755
> index 20a2300..0d4bc7a
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1976,7 +1976,7 @@ static void __trace_find_cmdline(int pid, char comm[])
>  		return;
>  	}
>  
> -	if (pid > PID_MAX_DEFAULT) {
> +	if (pid > pid_max) {

Thanks! this probably should go to stable.

-- Steve

>  		strcpy(comm, "<...>");
>  		return;
>  	}
