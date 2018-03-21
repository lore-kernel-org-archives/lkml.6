Return-Path: <SRS0=Ew++=GL=redhat.com=oleg@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-193552-1521647899-2-10289336860653920522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=Ew++=GL=redhat.com=oleg@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521647898; b=iTEMQsUwvYJAzgHcigOae0J5BHNL6Su1eM2bDpBRkKI3IN3
    +UPtjXF9lSQbTZcjJBf9foLjIjk+K71o1fUTdFtt86606ldXML54U2yBS+ebuIxI
    4HHikcV4KaLO/NwbtiNHkZ0ZO7zpZNZNPksUkb1rmAo3Jstl4Fgsn6G9HAqtVFk4
    Ub2VvSBdWUySUvJ+6NthAp9/0KWw1rCeKK0ygdcQRHqpI9P79CX9ah+eTlBlZMV9
    ac4rArY9IvZw8A/xQ+z4lcyzCTSKV8ggJ0rjKb6eYC3dOtSENVEPSnoZGmA6x44H
    so1sdldSn6DycwQ9s2biRiUnGZ41/k59oAUXFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521647898; bh=SemN5feSBZmHoBAYz+0cAaf9iIZZ48aHqidxurqvpG8=; b=W
    qgmeaqIaLiHuJLdS2ZXDPCtlzpftG9wpXA3zkIr5FORsNPKLJ91RvHpNkNlEeZCn
    zwteUN2HPP4NpSfu43Vr0LpFvVvMRuv/545F5QoFuGmg1Mq2P+vUVDzPTvAC/OEC
    HSWOCc2X4H6lEA6UCOpEhwUU0Y82a/hkQY8IbssB/ZMbwas9Y7vav8tfF5B2eNLu
    N2fueXYLe7jQDYc8rI5idtwywP3gfUYVw+J0PJIxfR4i7cY+d24cn07zWEJr8Y59
    2GTZNH/fm1up79/RJMh/XoDe9fB3ak3ysB5z3Zdv+O1ocjk28/IHgwYsXBW5Wo1q
    LVh87Axb1XyDrsYYdMBwg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Ew++=GL=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Ew++=GL=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6582A2177B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=oleg@redhat.com
Date: Wed, 21 Mar 2018 16:58:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180321155812.GA9382@redhat.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314194515.1661824-8-tj@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tejun,

sorry for late reply.

On 03/14, Tejun Heo wrote:
>
> Workqueue now has rcu_work.  Use it instead of open-coding rcu -> work
> item bouncing.

Yes, but a bit of open-coding may be more efficient...

> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -115,8 +115,7 @@ struct kioctx {
>  	struct page		**ring_pages;
>  	long			nr_pages;
>  
> -	struct rcu_head		free_rcu;
> -	struct work_struct	free_work;	/* see free_ioctx() */
> +	struct rcu_work		free_rwork;	/* see free_ioctx() */

IIUC, you can't easily share rcu_work's, thus every kioctx needs its own
->free_rwork and this looks sub-optimal.

What do you think about the (untested) patch below?

Oleg.


--- a/fs/aio.c
+++ b/fs/aio.c
@@ -115,8 +115,10 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct rcu_head		free_rcu;
-	struct work_struct	free_work;	/* see free_ioctx() */
+	union {
+		struct rcu_head		free_rcu;
+		struct llist_node	free_llist;
+	};
 
 	/*
 	 * signals when all in-flight requests are done
@@ -589,31 +591,38 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 	return cancel(&kiocb->common);
 }
 
+static struct llist_head free_ioctx_llist;
+
 /*
  * free_ioctx() should be RCU delayed to synchronize against the RCU
  * protected lookup_ioctx() and also needs process context to call
  * aio_free_ring(), so the double bouncing through kioctx->free_rcu and
  * ->free_work.
  */
-static void free_ioctx(struct work_struct *work)
+static void free_ioctx_workfn(struct work_struct *work)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
+	struct llist_node *llist = llist_del_all(&free_ioctx_llist);
+	struct kioctx *ctx, *tmp;
 
-	pr_debug("freeing %p\n", ctx);
+	llist_for_each_entry_safe(ctx, tmp, llist, free_llist) {
+		pr_debug("freeing %p\n", ctx);
 
-	aio_free_ring(ctx);
-	free_percpu(ctx->cpu);
-	percpu_ref_exit(&ctx->reqs);
-	percpu_ref_exit(&ctx->users);
-	kmem_cache_free(kioctx_cachep, ctx);
+		aio_free_ring(ctx);
+		free_percpu(ctx->cpu);
+		percpu_ref_exit(&ctx->reqs);
+		percpu_ref_exit(&ctx->users);
+		kmem_cache_free(kioctx_cachep, ctx);
+	}
 }
 
+static DECLARE_WORK(free_ioctx_work, free_ioctx_workfn);
+
 static void free_ioctx_rcufn(struct rcu_head *head)
 {
 	struct kioctx *ctx = container_of(head, struct kioctx, free_rcu);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	if (llist_add(&ctx->free_llist, &free_ioctx_llist))
+		schedule_work(&free_ioctx_work);
 }
 
 static void free_ioctx_reqs(struct percpu_ref *ref)
