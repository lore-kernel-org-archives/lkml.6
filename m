Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-870783-1520357657-2-5683600582289824315
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357656; b=MFNB0ifjHuIFm+czrIfE7QJ1T7QVSaYOFsO6lwF6kfM3wqF
    2bglaPOO5gLPHS4osCfIGP01TL5u+fLiUzLjgANk0xwJFTw95jAjJzMCQXAI1nXd
    e5pPqUlJVld69w901ev8W7WKOBewFDk2CEmOssC8gW/IcGldM3/htliAfb2yBBl2
    iw/AEGDZasABLTH695abXqmTfLQd/9IN3R/uIAC/pmTbCEG9t5SBV2sNTRhLWuiy
    eRR9Y4aPsiFVXKPWA9YzbUGkRL88ZL42pUpFglRmzKS8z1mCnW70eCNwPRicX1q0
    gAWkP9A5iyLP8xOY72oR6FZ0viapsOiRjrWIUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520357656;
    bh=GLWObaPTIUZ6EtonGulkOVQ0MK3T4Q3B2oWXZVMUsTo=; b=demKQFL8NhUS
    VBpauQ6+pfapWzde5Xfy2j/KLNusJ9eO7cFbo1h/bIt/BmcRDyRYlk6AJJhugUjh
    Oln0wHCokyaEkRMPWyPcPjvj2yxEPOmKTich6fbkuFy2fLzNc/bec2pOreHTcKjH
    jW/pvtTJ+x6Y3wICa4NyEaitlJmJ/ZvyzSpnnAJqvRFM8YOf34R6MXTS0JdaHdyg
    tcLUOoWt7ugPAkb6hkKwDxiR6KFushjP+TUB38mRgBbjPDORl4d7zA4r/tKE6BRE
    ADpYsXYORsKGI5GX/o2r+JudBRn7sLXpgV0/SqaIRA8E5TGaxaJLsZuv1U9sGOap
    jPspy4mHsQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cxRejNdU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NfEDQP31;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cxRejNdU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NfEDQP31;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeCFReP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 12:34:15 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35384 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbeCFReN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 12:34:13 -0500
X-Google-Smtp-Source: AG47ELv1noWe+cN1QwTveYes85hfNJzvBhSLKDkb0UkzagQHx1BtmMVHZkKlbBP3wMa4z+OmsqrdXA==
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, jannh@google.com,
        paulmck@linux.vnet.ibm.com, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, kent.overstreet@gmail.com
Cc: security@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/7] fs/aio: Use RCU accessors for kioctx_table->table[]
Date: Tue,  6 Mar 2018 09:33:11 -0800
Message-Id: <20180306173316.3088458-2-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306173316.3088458-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
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
