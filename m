Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF388C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C512175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C512175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbeHCPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbeHCPR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:17:27 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59043216FD;
        Fri,  3 Aug 2018 13:21:07 +0000 (UTC)
Date:   Fri, 3 Aug 2018 09:21:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, trivial@kernel.org
Subject: Re: [PATCH] kernel/kthread:  Make function
 __kthread_queue_delayed_work static
Message-ID: <20180803092105.3dd68f05@gandalf.local.home>
In-Reply-To: <1533300002-27105-1-git-send-email-zhongjiang@huawei.com>
References: <1533300002-27105-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2018 20:40:02 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> Fix the following warning.
> 
> kernel/kthread.c:859:6: warning: symbol '__kthread_queue_delayed_work' was not declared. Should it be static?


This should go via the trivial tree.

> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  kernel/kthread.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 087d18d..3c661a0 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -856,7 +856,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>  }
>  EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
>  
> -void __kthread_queue_delayed_work(struct kthread_worker *worker,
> +static void __kthread_queue_delayed_work(struct kthread_worker *worker,
>  				  struct kthread_delayed_work *dwork,
>  				  unsigned long delay)

Although, one could say you should align the parameters too, but that's
not a big deal. Anyway...

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  {

