Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031161AbeBNPBA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030382AbeBNPA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:00:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1177F2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 14 Feb 2018 10:00:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] srcu: Remove dead code in srcu_gp_end()
Message-ID: <20180214100054.45f525fe@gandalf.local.home>
In-Reply-To: <1518599124-29153-1-git-send-email-byungchul.park@lge.com>
References: <1518599124-29153-1-git-send-email-byungchul.park@lge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 18:05:24 +0900
Byungchul Park <byungchul.park@lge.com> wrote:

> Of course, compilers will optimize out a dead code. Anyway, remove
> any dead code for better readibility.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/srcutree.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 44bc0fa..829453b 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -531,7 +531,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
>  	unsigned long flags;
>  	unsigned long gpseq;
>  	int idx;
> -	int idxnext;

Interesting. According to git history, idxnext was never actually used.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  	unsigned long mask;
>  	struct srcu_data *sdp;
>  	struct srcu_node *snp;
> @@ -555,7 +554,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
>  
>  	/* Initiate callback invocation as needed. */
>  	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
> -	idxnext = (idx + 1) % ARRAY_SIZE(snp->srcu_have_cbs);
>  	rcu_for_each_node_breadth_first(sp, snp) {
>  		spin_lock_irq_rcu_node(snp);
>  		cbs = false;
