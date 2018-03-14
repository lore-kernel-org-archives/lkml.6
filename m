Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2426127-1521056737-2-5024028488878839905
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
    t=1521056737; b=SCtUirv+njz6QdLP5KkJNmP6cJZ0gVW7H0Nt/GH+6VWXAG4
    tr8j+iQinq6qNnzhLYZkUHkrKAyDx9yPej3NtRg2r9VANGyo+d6vWPiSY3KNtBk7
    DtT52f48NV/s8ucMZzLSCdG5yt84naZKDL6bYT5MDhqpqs8FZCNZv37tPQ6e0+H+
    6kzbT22fFOqzojkuVJciDYpjdeRCe/prHY5a9KMVXnRWw3fcQEpPzar7SnorWTJv
    dcpiZP2QsSG05qE5rvJADHjfxWG+I4Gi91NQjd4xdkIbU7M16fOYat14T82LUPu/
    WLXswFtHLeNcCz3styfVDKJCTRaPwnPlkLpdaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521056737; bh=GLWObaPTIUZ
    6EtonGulkOVQ0MK3T4Q3B2oWXZVMUsTo=; b=AFzyMwbAQZgmvZl5RvIpr8F0dpP
    dgmxcXFn9lVkn92JkpN9bEhRYoCyf8+RuanV1VUBI3ghibijWOGxRHgRubiyt429
    xZydOJPdQ2HDqE9hPZlDPAEDUf1wmUHvjnXZy0Mp9cxsmyX81IdBheAFxUzKGWvS
    obpiGDbFO6panZBeFk9krwHn9YvBBOkx1atW8vSvnowLinTeIaqn1OOHtnk7BWwE
    1J+W+jMpxjXm7JlAeX2FIpCCljWGYf8s2y6MOS/hJfnBlet4w7gF9oOLNhSGnSoi
    06UpeM3oMm1nr6iWQ6xyCGLCbcrVS6VzEt6W8MEWj6yJEUjNat39m10d67A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ieGMt89T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eDJpVtYM;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ieGMt89T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eDJpVtYM;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5492077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELuZH4IlW9VDyXB6mecFbd/CRJ+XQAlWBvWFKeEVdWSNNKa9JDehA7yJGQYVbEd42pcey/hJ2Q==
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
Subject: [PATCH 2/8] fs/aio: Use RCU accessors for kioctx_table->table[]
Date: Wed, 14 Mar 2018 12:45:09 -0700
Message-Id: <20180314194515.1661824-2-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180314194515.1661824-1-tj@kernel.org>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While converting ioctx index from a list to a table, db446a08c23d
("aio: convert the ioctx list to table lookup v3") missed tagging
kioctx_table->table[] as an array of RCU pointers and using the
appropriate RCU accessors.  This introduces a small window in the
lookup path where init and access may race.

Mark kioctx_table->table[] with __rcu and use the approriate RCU
accessors when using the field.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Fixes: db446a08c23d ("aio: convert the ioctx list to table lookup v3")
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
---
 fs/aio.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index eb2e0cf..6bcd3fb 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -68,9 +68,9 @@ struct aio_ring {
 #define AIO_RING_PAGES	8
 
 struct kioctx_table {
-	struct rcu_head	rcu;
-	unsigned	nr;
-	struct kioctx	*table[];
+	struct rcu_head		rcu;
+	unsigned		nr;
+	struct kioctx __rcu	*table[];
 };
 
 struct kioctx_cpu {
@@ -330,7 +330,7 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = table->table[i];
+		ctx = rcu_dereference(table->table[i]);
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -666,9 +666,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	while (1) {
 		if (table)
 			for (i = 0; i < table->nr; i++)
-				if (!table->table[i]) {
+				if (!rcu_access_pointer(table->table[i])) {
 					ctx->id = i;
-					table->table[i] = ctx;
+					rcu_assign_pointer(table->table[i], ctx);
 					spin_unlock(&mm->ioctx_lock);
 
 					/* While kioctx setup is in progress,
@@ -849,8 +849,8 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 	}
 
 	table = rcu_dereference_raw(mm->ioctx_table);
-	WARN_ON(ctx != table->table[ctx->id]);
-	table->table[ctx->id] = NULL;
+	WARN_ON(ctx != rcu_access_pointer(table->table[ctx->id]));
+	RCU_INIT_POINTER(table->table[ctx->id], NULL);
 	spin_unlock(&mm->ioctx_lock);
 
 	/* free_ioctx_reqs() will do the necessary RCU synchronization */
@@ -895,7 +895,8 @@ void exit_aio(struct mm_struct *mm)
 
 	skipped = 0;
 	for (i = 0; i < table->nr; ++i) {
-		struct kioctx *ctx = table->table[i];
+		struct kioctx *ctx =
+			rcu_dereference_protected(table->table[i], true);
 
 		if (!ctx) {
 			skipped++;
@@ -1084,7 +1085,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	if (!table || id >= table->nr)
 		goto out;
 
-	ctx = table->table[id];
+	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
 		percpu_ref_get(&ctx->users);
 		ret = ctx;
-- 
2.9.5
