Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2426127-1521056754-2-13305360911304707517
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=5xW2=GE=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521056753; b=iOyrSE31nRkd65A3WR8JUBaDFlE7TI/vx8uN2TrrzbNUwzi
    4XOtyXDS9+3qjVZN0Wh7/MSk6MT86AQfcLpMrGK2/UNksqsjEsp0f6qTWaHKLghu
    QxM2jX0/K3wLhsQe7nr/EaYGvq6vk2yn88VdOthcru/hAQfMB3ugJIxBzIDVnyu0
    8mcfmlHVc7QK38/UGi8yiJpXnH5C57FSNUcZ0sQ8HPks0nQ68nAQWIftvLNc0xSs
    XdUz/5ta8ZUu8BIFKgZ1feCKhgYlc6AuOO75TZck7yXISd4jUPCuiQAjx8NhCfA+
    f0TLIF/x66g2yhqx4sb1bkUUMRExsB6Y3xsSdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521056753; bh=1AZwbudM275
    ET0VERaOchqg43LHHPPriJCHLAPU6pJg=; b=UW1pk57LoOI6n3VCD8Iab7ukY5F
    Q1yv76o4TqMSqryT8rahOj1K/WR7IdegeHHHbsD6hSBaquj9knH49y7d7lpfJ2mr
    5r+HFAHXsi7xY9pUFxPOPfQScdtdRH/Ng0sRSzju0E5wbmKsh/WCWE+ZDn7kBFQT
    2b4nM9LBBGDzRyd8PfBKZphJUeKoc3BIE3w5tr6upDIFsupdZFafMhviibzGezuE
    wJnua4sO7oJ00TF85NsHrBK0V/CbbRhO+UA8/pXqURUMUs02FOzLAX3kt7QsU328
    Ui0cSM/7teQaHjt2T0lpc1kUwSPk/7POSnsG6rlWANPLYOlgIN9oTm8ewEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WQn33yHa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AzNXoGG1;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WQn33yHa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AzNXoGG1;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98472077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELsk/s53d0F/F9YlMQqJFACyWLQkAmJz4z5JyYS42BHDiJIqJTSUJBYrQ3CRw4zQv/N5bTPe6g==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and work item
Date: Wed, 14 Mar 2018 12:45:15 -0700
Message-Id: <20180314194515.1661824-8-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180314194515.1661824-1-tj@kernel.org>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Workqueue now has rcu_work.  Use it instead of open-coding rcu -> work
item bouncing.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

If there's no objection, I'll route this together with rcu_work patch
through wq/for-4.17.

Thanks.

 fs/aio.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 6bcd3fb..88d7927 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -115,8 +115,7 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct rcu_head		free_rcu;
-	struct work_struct	free_work;	/* see free_ioctx() */
+	struct rcu_work		free_rwork;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -592,13 +591,12 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 /*
  * free_ioctx() should be RCU delayed to synchronize against the RCU
  * protected lookup_ioctx() and also needs process context to call
- * aio_free_ring(), so the double bouncing through kioctx->free_rcu and
- * ->free_work.
+ * aio_free_ring().  Use rcu_work.
  */
 static void free_ioctx(struct work_struct *work)
 {
-	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
-
+	struct kioctx *ctx = container_of(to_rcu_work(work), struct kioctx,
+					  free_rwork);
 	pr_debug("freeing %p\n", ctx);
 
 	aio_free_ring(ctx);
@@ -608,14 +606,6 @@ static void free_ioctx(struct work_struct *work)
 	kmem_cache_free(kioctx_cachep, ctx);
 }
 
-static void free_ioctx_rcufn(struct rcu_head *head)
-{
-	struct kioctx *ctx = container_of(head, struct kioctx, free_rcu);
-
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
-}
-
 static void free_ioctx_reqs(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
@@ -625,7 +615,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 		complete(&ctx->rq_wait->comp);
 
 	/* Synchronize against RCU protected table->table[] dereferences */
-	call_rcu(&ctx->free_rcu, free_ioctx_rcufn);
+	INIT_RCU_WORK(&ctx->free_rwork, free_ioctx);
+	queue_rcu_work(system_wq, &ctx->free_rwork);
 }
 
 /*
-- 
2.9.5
