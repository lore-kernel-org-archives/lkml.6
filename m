Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1143910-1525285321-2-17829169225857674747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525285320; b=HJDPgtcjnL66g8yx6NjoPkBxqWzuhM8Zfo4icnkOQbNbiZDvtO
    jS4ADC5IiLy2h2tRA1dY1SyXOA6thZdqSlAgCTYt54AjkgnJ29MMge5UgZugURoy
    ECmFxDJbEqIumUpNajv5jlTVYxUQoDBZKy1njpc5kL8UQWTbYewnB7mZgfooFlsb
    CaDqkKNiptFp4Qwd0sr/fosnxdLBG+8VDwrM6BVkJ8y3J/ime1vTmuGu0+O5b6sI
    i7VL1NFVSN2xO4BV0Lkg/L2sf181SB+AcYUqZkSQX32zrxnraljjm0g6pYxadbtO
    0HQwm2mYJjho7OyucTAKpBBaewRU9rioSzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525285320; bh=1B+Vn
    SwnhJKP1GOTh/ETArcgwB9R4L7t5Qdtxngu9/Q=; b=Vgvt9I5AmJ3m+IZKNbA41
    BLlvHjaEgU8AL+4ZD5tZvg3PlpROCppyMi70Uii+fYOdDnNHI3jmpiDCqYZWUEfv
    XYG8cgnWk4kjuzBDkHLSaZiyayvrS/axOyXykkogHQcMtSwNMjdo4YmnECdyJWZs
    VhXZuR9sbObRdLnWMjNAfEPM6Mm/Q90kRedcm16ABDIf5O06fvK4eAXlHf1p9XwE
    c45Lnrcjs7xHQHYMcIVt0QAnq3I5DXs+6aDM/LThOPMG5tiNH3Ahj9XtsHf3PK5I
    wyIy7GaYLmxoEw4IzBb+8rAbAGd+iqUOYp71uPJ5WW4w97QiUlXPe5O+RUZadYQu
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFrNkkJioocq6S9X2mnQbnIm09SOMweeNxz1kFJDodQC4MnIzk2ABH+2uQQyMf2+whSOvSVnpkoF04011Ewb7xvVmEviNQG7Sf/yYUy8Nue6DaCCMLck
    2i0a9OqUqjXdFY/aulDWcMJ/eLaNFxmDyhfHb9eXLCW8xsPRtwWJgyZt4JoeBGJWkf8lErqiVs9dCKY6DAIaFsWZmjg70ABqTY0/fXyOwn6iM/hgtMRgrj8G
    1x2tdpftbj3d9rUCUKr3Aw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=lB0dNpNiAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=VcUaqHDnAncBUzZZCLAA:9 a=CjuIK1q_8ugA:10 a=c-ZiYqmG3AbHTdtsH08C:22
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, Lai Siyao <lai.siyao@intel.com>,
 Jinshan Xiong <jinshan.xiong@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 1/4] staging: lustre: obdclass: change spinlock of key to
 rwlock
Date: Wed,  2 May 2018 14:21:45 -0400
Message-Id: <1525285308-15347-2-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
References: <1525285308-15347-1-git-send-email-jsimmons@infradead.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Gu Zheng <gzheng@ddn.com>, Li Xi <lixi@ddn.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Li Xi <lixi@ddn.com>

Most of the time, keys are never changed. So rwlock might be
better for the concurrency of key read.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Gu Zheng <gzheng@ddn.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-6800
Reviewed-on: http://review.whamcloud.com/15558
Reviewed-by: Faccini Bruno <bruno.faccini@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 38 +++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index fa986f2..04475e9 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -1317,7 +1317,7 @@ enum {
 
 static struct lu_context_key *lu_keys[LU_CONTEXT_KEY_NR] = { NULL, };
 
-static DEFINE_SPINLOCK(lu_keys_guard);
+static DEFINE_RWLOCK(lu_keys_guard);
 static atomic_t lu_key_initing_cnt = ATOMIC_INIT(0);
 
 /**
@@ -1341,7 +1341,7 @@ int lu_context_key_register(struct lu_context_key *key)
 	LASSERT(key->lct_tags != 0);
 
 	result = -ENFILE;
-	spin_lock(&lu_keys_guard);
+	write_lock(&lu_keys_guard);
 	for (i = 0; i < ARRAY_SIZE(lu_keys); ++i) {
 		if (!lu_keys[i]) {
 			key->lct_index = i;
@@ -1353,7 +1353,7 @@ int lu_context_key_register(struct lu_context_key *key)
 			break;
 		}
 	}
-	spin_unlock(&lu_keys_guard);
+	write_unlock(&lu_keys_guard);
 	return result;
 }
 EXPORT_SYMBOL(lu_context_key_register);
@@ -1387,7 +1387,7 @@ void lu_context_key_degister(struct lu_context_key *key)
 	lu_context_key_quiesce(key);
 
 	++key_set_version;
-	spin_lock(&lu_keys_guard);
+	write_lock(&lu_keys_guard);
 	key_fini(&lu_shrink_env.le_ctx, key->lct_index);
 
 	/**
@@ -1395,18 +1395,18 @@ void lu_context_key_degister(struct lu_context_key *key)
 	 * run lu_context_key::lct_fini() method.
 	 */
 	while (atomic_read(&key->lct_used) > 1) {
-		spin_unlock(&lu_keys_guard);
+		write_unlock(&lu_keys_guard);
 		CDEBUG(D_INFO, "%s: \"%s\" %p, %d\n",
 		       __func__, module_name(key->lct_owner),
 		       key, atomic_read(&key->lct_used));
 		schedule();
-		spin_lock(&lu_keys_guard);
+		write_lock(&lu_keys_guard);
 	}
 	if (lu_keys[key->lct_index]) {
 		lu_keys[key->lct_index] = NULL;
 		lu_ref_fini(&key->lct_reference);
 	}
-	spin_unlock(&lu_keys_guard);
+	write_unlock(&lu_keys_guard);
 
 	LASSERTF(atomic_read(&key->lct_used) == 1,
 		 "key has instances: %d\n",
@@ -1526,7 +1526,7 @@ void lu_context_key_quiesce(struct lu_context_key *key)
 		/*
 		 * XXX memory barrier has to go here.
 		 */
-		spin_lock(&lu_keys_guard);
+		write_lock(&lu_keys_guard);
 		key->lct_tags |= LCT_QUIESCENT;
 
 		/**
@@ -1534,19 +1534,19 @@ void lu_context_key_quiesce(struct lu_context_key *key)
 		 * have completed.
 		 */
 		while (atomic_read(&lu_key_initing_cnt) > 0) {
-			spin_unlock(&lu_keys_guard);
+			write_unlock(&lu_keys_guard);
 			CDEBUG(D_INFO, "%s: \"%s\" %p, %d (%d)\n",
 			       __func__,
 			       module_name(key->lct_owner),
 			       key, atomic_read(&key->lct_used),
 			atomic_read(&lu_key_initing_cnt));
 			schedule();
-			spin_lock(&lu_keys_guard);
+			write_lock(&lu_keys_guard);
 		}
 
 		list_for_each_entry(ctx, &lu_context_remembered, lc_remember)
 			key_fini(ctx, key->lct_index);
-		spin_unlock(&lu_keys_guard);
+		write_unlock(&lu_keys_guard);
 		++key_set_version;
 	}
 }
@@ -1584,9 +1584,9 @@ static int keys_fill(struct lu_context *ctx)
 	 * An atomic_t variable is still used, in order not to reacquire the
 	 * lock when decrementing the counter.
 	 */
-	spin_lock(&lu_keys_guard);
+	read_lock(&lu_keys_guard);
 	atomic_inc(&lu_key_initing_cnt);
-	spin_unlock(&lu_keys_guard);
+	read_unlock(&lu_keys_guard);
 
 	LINVRNT(ctx->lc_value);
 	for (i = 0; i < ARRAY_SIZE(lu_keys); ++i) {
@@ -1655,9 +1655,9 @@ int lu_context_init(struct lu_context *ctx, __u32 tags)
 	ctx->lc_state = LCS_INITIALIZED;
 	ctx->lc_tags = tags;
 	if (tags & LCT_REMEMBER) {
-		spin_lock(&lu_keys_guard);
+		write_lock(&lu_keys_guard);
 		list_add(&ctx->lc_remember, &lu_context_remembered);
-		spin_unlock(&lu_keys_guard);
+		write_unlock(&lu_keys_guard);
 	} else {
 		INIT_LIST_HEAD(&ctx->lc_remember);
 	}
@@ -1683,10 +1683,10 @@ void lu_context_fini(struct lu_context *ctx)
 		keys_fini(ctx);
 
 	} else { /* could race with key degister */
-		spin_lock(&lu_keys_guard);
+		write_lock(&lu_keys_guard);
 		keys_fini(ctx);
 		list_del_init(&ctx->lc_remember);
-		spin_unlock(&lu_keys_guard);
+		write_unlock(&lu_keys_guard);
 	}
 }
 EXPORT_SYMBOL(lu_context_fini);
@@ -1714,7 +1714,7 @@ void lu_context_exit(struct lu_context *ctx)
 		for (i = 0; i < ARRAY_SIZE(lu_keys); ++i) {
 			/* could race with key quiescency */
 			if (ctx->lc_tags & LCT_REMEMBER)
-				spin_lock(&lu_keys_guard);
+				read_lock(&lu_keys_guard);
 			if (ctx->lc_value[i]) {
 				struct lu_context_key *key;
 
@@ -1724,7 +1724,7 @@ void lu_context_exit(struct lu_context *ctx)
 						      key, ctx->lc_value[i]);
 			}
 			if (ctx->lc_tags & LCT_REMEMBER)
-				spin_unlock(&lu_keys_guard);
+				read_unlock(&lu_keys_guard);
 		}
 	}
 }
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
