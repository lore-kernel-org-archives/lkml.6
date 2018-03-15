Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCOJ3T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:29:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C5620779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 15 Mar 2018 18:29:14 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, wangnan0@huawei.com, mingo@redhat.com,
        srikar@linux.vnet.ibm.com, oleg@redhat.com, mhiramat@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v2 1/2] trace_uprobe: Use %lx to display offset
Message-Id: <20180315182914.ec9640e5272abfd516141bc2@kernel.org>
In-Reply-To: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 13:57:55 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> tu->offset is unsigned long, not a pointer, thus %lx should
> be used to print it, not the %px.
> 

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Fixes: 0e4d819d0893 ("trace_uprobe: Display correct offset in uprobe_events")
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> v2 changelog:
>  - Keep prefixed 0s as is.
> 
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2014f4351ae0..0298bd15be83 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_file *m, void *v)
>  
>  	/* Don't print "0x  (null)" when offset is 0 */
>  	if (tu->offset) {
> -		seq_printf(m, "0x%px", (void *)tu->offset);
> +		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
>  	} else {
>  		switch (sizeof(void *)) {
>  		case 4:
> -- 
> 2.13.6
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
