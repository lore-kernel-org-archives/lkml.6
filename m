Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706D3ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D142087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D142087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJREQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725737AbeJREQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:16:46 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6C42087A;
        Wed, 17 Oct 2018 20:19:25 +0000 (UTC)
Date:   Wed, 17 Oct 2018 16:19:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Export trace_dump_stack to modules
Message-ID: <20181017161923.310ca1a4@gandalf.local.home>
In-Reply-To: <1539759103-5923-1-git-send-email-nborisov@suse.com>
References: <1539759103-5923-1-git-send-email-nborisov@suse.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 09:51:43 +0300
Nikolay Borisov <nborisov@suse.com> wrote:

> There is no reason for this function to be unexprted and it's a useful
> debugging aid.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Thanks, I added this to my queue for the merge window.

-- Steve

> ---
>  kernel/trace/trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index bf6f1d70484d..15c7a7d01505 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2727,6 +2727,7 @@ void trace_dump_stack(int skip)
>  	__ftrace_trace_stack(global_trace.trace_buffer.buffer,
>  			     flags, skip, preempt_count(), NULL);
>  }
> +EXPORT_SYMBOL_GPL(trace_dump_stack);
>  
>  static DEFINE_PER_CPU(int, user_stack_count);
>  

