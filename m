Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbeA3KNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeA3KNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:13:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED0D21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 30 Jan 2018 05:13:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: use helper function clear_ftrace_function
Message-ID: <20180130051306.15f47965@vmware.local.home>
In-Reply-To: <1517273161-36355-1-git-send-email-xieyisheng1@huawei.com>
References: <1517273161-36355-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018 08:46:01 +0800
Yisheng Xie <xieyisheng1@huawei.com> wrote:

> We have helper function clear_ftrace_function(), use it instead of hard
> code. And this should not have any functional change.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 554b517..ba78e03 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6779,7 +6779,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
>  
>  	} else {
>  		/* stopping ftrace calls (just send to ftrace_stub) */
> -		ftrace_trace_function = ftrace_stub;
> +		clear_ftrace_function();
>  
>  		ftrace_shutdown_sysctl();
>  	}

Honestly, I rather nuke that function and clear_ftrace_function_probe()
along with it. They are not used outside of ftrace.c and they don't
actually help.

-- Steve
