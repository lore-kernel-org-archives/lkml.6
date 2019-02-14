Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D04EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3E2222DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407910AbfBNQ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfBNQ2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:28:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D296222DA;
        Thu, 14 Feb 2019 16:28:21 +0000 (UTC)
Date:   Thu, 14 Feb 2019 11:28:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, joelaf@google.com,
        smuckle@google.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2] tracing: Fix number of entries in trace header
Message-ID: <20190214112818.701347c4@gandalf.local.home>
In-Reply-To: <20190214152950.4179-1-quentin.perret@arm.com>
References: <20190214150130.3162-1-quentin.perret@arm.com>
        <20190214152950.4179-1-quentin.perret@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 15:29:50 +0000
Quentin Perret <quentin.perret@arm.com> wrote:

> The following commit
> 
>   441dae8f2f29 ("tracing: Add support for display of tgid in trace output")

Thanks, I'll take a look at this.

> 
> removed the call to print_event_info() from print_func_help_header_irq()
> which results in the ftrace header not reporting the number of entries
> written in the buffer. As this wasn't the original intent of the patch,
> re-introduce the call to print_event_info() to restore the orginal
> behaviour.
> 
> Fixes: 441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
> Cc: 4.13+ <stable@vger.kernel.org> # v4.13+

Note, with the "Fixes:" tag, adding the version number is obsolete. Just

Cc: stable@vger.kernel.org

is sufficient.

-- Steve

> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Acked-by: Joel Fernandes <joelaf@google.com>
> ---
>  kernel/trace/trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c521b7347482..c4238b441624 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3384,6 +3384,8 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
>  	const char tgid_space[] = "          ";
>  	const char space[] = "  ";
>  
> +	print_event_info(buf, m);
> +
>  	seq_printf(m, "#                          %s  _-----=> irqs-off\n",
>  		   tgid ? tgid_space : space);
>  	seq_printf(m, "#                          %s / _----=> need-resched\n",

