Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891914-1520357637-2-5237193535148254363
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
X-Mail-from: SRS0=gsCl=F4=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357636; b=qaovpJEe/2Iuk20ok789rforWDFry9bsI2qzDVg9rupaiID
    1RepJqMHjabC0ySuunTUZj/kFyH5BhHICL7vIp65/EvwkS9rce4hcSyAW6hwKVIN
    ujk5+ftYcNvIgiyaTnLaSEmtIuFiO3UaHN/UOkdTlhfKId38lhXE4SX5ykeUeRig
    OxTgrfcTfnRU549fEW53iFc7drYRnw5ZEs5lFxNI1eHPrNc+SoMY6TQETJ/arLuq
    C763+n8o+whlG1jBvfaThEFj0pG3YpfkSEdbcXxT+ecNu/Kih+aayBXhmOhkaxNU
    raaXyT5Tii5qusfIgE/1dixyEoIyAFJ8M3OqGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1520357636; bh=b7S3zDzaG3n
    vAYmTEo7A2nG7oDmEoR04rXqwN5bqPB8=; b=NOCaYF0mh4YEqX8ROC/R1J8don5
    aPcdCU7APU3PrhPZ/8sV4aky1Ou3EVFAfKaGRZasxj0l1nbPptRXZCkAElbfEqBt
    Bk45zS+c/0EdPRBJtXdzKTT+CqWXJjobZ93LCN27rLUdl4lq6zIdXGslOaw0CUo4
    AMqEvhqOzsmDHtB7h55m+4cuyxnr9brXWKEAvh3HTXdSwjqjdfutJiIH1lQKXWhD
    OiX26v2Wo6mEMRttcJuE7phC7MilKrNK3cLznuXpCCpxM+X/wLuYB8G8wlF0+K0H
    BGejeiJNv3Wi3w4SsMlYp2W2L+6IOmALAfdO7fTnjx32+GSqQ189JDFJ6gg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kCkC7hKu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V9qfXLXF;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kCkC7hKu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=V9qfXLXF;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D9F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELuNRpoVkz5f15a3OI5BdqAzSk4zB7CeQA968dOn4sfhJFsmTRIiLW1gL4Sap3qIfYvDanqvbw==
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
Subject: [PATCH 1/7] fs/aio: Add explicit RCU grace period when freeing kioctx
Date: Tue,  6 Mar 2018 09:33:10 -0800
Message-Id: <20180306173316.3088458-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306172657.3060270-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
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
