Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2426127-1521056732-2-3691715754795513971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=5xW2=GE=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521056731; b=s0oYpV3rRid6eR3dlYXPTrfY/wqRu59JoD68/ziiNxHzwds
    IEg9pffBkrNOTcGaoihvjwIGFglA1s1HoLfrZZvbntr8Bp9zf2uF55av1hSSFuE+
    RLO463opGtArRzrm6jbQ3Nrufdu3woz3sFC+bvq0ZcD6/F1psOcGct74gBMuGyaL
    TDRQEwVvqFLBi0N7VV0O1iPek9QAmY75N1Vf5zVp6ce2IJoDG94vGF2eutb6ceHv
    oOjy5OVBrst7YxNyt+1CoHTrWLxNfIyyrfNePYAobhgl7T1r+OSuDQTZ3dUaug7G
    Y1gDETbIvoIwy7kMRV3s8mhCAKHu0FjsWBoi0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521056731; bh=b7S3zDzaG3n
    vAYmTEo7A2nG7oDmEoR04rXqwN5bqPB8=; b=pKTess9FMY3riGCVc59ppwdq+C3
    68jkZtSpUYHkrwe2orvd3/qPxYn4Zl0NofWDiemohzXZ7H9D/wBzN4pdYRYNzcKu
    XYPetSnCBFui9bV/elinnFuLD1LaB8UVlIOWxo16ElrgDoWuHrhuq4Ug0mClyUDl
    In0ToSnUjelZdKBR4pZT/mr5zhHNS22/KeoTi7FVEtiSzJNv3BlESLkYGEt5fWJt
    puelDBS2KZLodlE95gRgSduwcsdZV1Lyob6nZ7O06C2H9s+3RbiK7zR6mvXBVNoJ
    qQ1H614iYCGK6tZEKNhXssq9PsBtpjfAa9waL6uiu1lcvx//oAgAM1M78DA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A/7D7D9/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DfAX3Eby;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A/7D7D9/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DfAX3Eby;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAC12077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELsbdqH4i06i/9+C4NcNMjFCCXDbKzppmi5UTrOlgf3HLovLEBRHoD6ooLylVRdzH5EqtIB75w==
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
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] fs/aio: Add explicit RCU grace period when freeing kioctx
Date: Wed, 14 Mar 2018 12:45:08 -0700
Message-Id: <20180314194515.1661824-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180314194205.1651587-1-tj@kernel.org>
References: <20180314194205.1651587-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While fixing refcounting, e34ecee2ae79 ("aio: Fix a trinity splat")
incorrectly removed explicit RCU grace period before freeing kioctx.
The intention seems to be depending on the internal RCU grace periods
of percpu_ref; however, percpu_ref uses a different flavor of RCU,
sched-RCU.  This can lead to kioctx being freed while RCU read
protected dereferences are still in progress.

Fix it by updating free_ioctx() to go through call_rcu() explicitly.

v2: Comment added to explain double bouncing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Fixes: e34ecee2ae79 ("aio: Fix a trinity splat")
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
---
 fs/aio.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index a062d75..eb2e0cf 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -115,7 +115,8 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct work_struct	free_work;
+	struct rcu_head		free_rcu;
+	struct work_struct	free_work;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -588,6 +589,12 @@ static int kiocb_cancel(struct aio_kiocb *kiocb)
 	return cancel(&kiocb->common);
 }
 
+/*
+ * free_ioctx() should be RCU delayed to synchronize against the RCU
+ * protected lookup_ioctx() and also needs process context to call
+ * aio_free_ring(), so the double bouncing through kioctx->free_rcu and
+ * ->free_work.
+ */
 static void free_ioctx(struct work_struct *work)
 {
 	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
@@ -601,6 +608,14 @@ static void free_ioctx(struct work_struct *work)
 	kmem_cache_free(kioctx_cachep, ctx);
 }
 
+static void free_ioctx_rcufn(struct rcu_head *head)
+{
+	struct kioctx *ctx = container_of(head, struct kioctx, free_rcu);
+
+	INIT_WORK(&ctx->free_work, free_ioctx);
+	schedule_work(&ctx->free_work);
+}
+
 static void free_ioctx_reqs(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
@@ -609,8 +624,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
 	if (ctx->rq_wait && atomic_dec_and_test(&ctx->rq_wait->count))
 		complete(&ctx->rq_wait->comp);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	/* Synchronize against RCU protected table->table[] dereferences */
+	call_rcu(&ctx->free_rcu, free_ioctx_rcufn);
 }
 
 /*
@@ -838,7 +853,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 	table->table[ctx->id] = NULL;
 	spin_unlock(&mm->ioctx_lock);
 
-	/* percpu_ref_kill() will do the necessary call_rcu() */
+	/* free_ioctx_reqs() will do the necessary RCU synchronization */
 	wake_up_all(&ctx->wait);
 
 	/*
-- 
2.9.5
