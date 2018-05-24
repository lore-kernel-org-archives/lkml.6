Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597100-1527197391-2-1828729008934648212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527197390; b=UzDhA/EN12fBFtZJmzzV+qvm1qC9hJn2cYgyrYkMyU0eqDfots
    2luM5b/ZpCQlaJLPYPXN/yz++RSqGzRUFC0lPFFcS5Gi6l4TAnY0fawHbJJs41do
    zVkQDPtmKWVVp0dTMsBPbWKnvN0f0ZDiAlirAQNkIqf8VjArfZSnnUbwlX+iTy1h
    y0Rf4GjFlNl5FN2WVFgwbTvoHAwI2uSJEDYllei6dnmgVslgT2wvlRYGqZk/dnzD
    K0Jb2pE2SvSmnjkdwBG+WUXcib9EGcmIj5iehvj8HmrmfafLp15nBU4DUCXHtw7D
    CfTud6aS74QX3eIZUbnDCcqE8YW8XWKWU+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527197390; bh=
    WPuOKLK8kBP3bQvhGAEsm6/YVbg85bp9ledJKuehuQQ=; b=lMZdDaRGcleNdouo
    GsNAy6ig5iPU3L8bpyMlor/GIMuGenxwKLDbRfTJlUQCqFoSnJS7hroLMR7KvViM
    CaPWhsMZmQr8oLBnn7lUnwwqJrFc5PJYrqcTX2Utilfn9wtnY3HwMETxHDPlWHSv
    hnrZQyLt8QlT8Igv1sClfgqbyo/4gDMFdIdgoChmSmSf1xe1voTpHEID9Etx2BF/
    1UR6diYxfDqb1JyfAhVLXmayeUlpx6dyinsWJixgueQjQLJCS/yu/e2dRSsOM/dF
    qLVAH+MtFqicDhRXuQOb7v2sMs7kDWsAFu8N+vrFHiCsqv8+Gg62xOy98uwDuJmA
    ZvF+Nw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGABGYsRZlvresv7RA+gSit9Wyjh/NnbC4Lv/+iA3xKe8Byb6PzOfkpJJuuQbYIKcZgiGAKHs1QleFhTg89eKWFBOEiAHS1Gz0F8NSI1gtYYyWf0nAq/
    rIJtHpJHkR1aM6QIdXr1iC7eoAS8tZ+5qHkinIvVCQMT03vhun5pIlUECcyzp+DAuyWpy5ZoYmYhANgaEB0jU76Z1FCUUYPYEZC6ezhTmhxrl2/vwR/05AsK
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=Z4Rwk6OoAAAA:8
    a=VwQbUJbxAAAA:8 a=uUSRhqOYgDZgFF497NwA:9 a=x8gzFH9gYPwA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161326AbeEXV20 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 17:28:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:33372 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161325AbeEXV2Y (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 24 May 2018 17:28:24 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable allocation
Date: Thu, 24 May 2018 14:11:31 -0700
Message-Id: <20180524211135.27760-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180524211135.27760-1-dave@stgolabs.net>
References: <20180524211135.27760-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

rhashtable_init() may fail due to -ENOMEM, thus making the
entire api unusable. This patch removes this scenario,
however unlikely. In order to guarantee memory allocation,
this patch refactors bucket_table_alloc() to add a 'retry'
parameter which always ends up doing GFP_KERNEL|__GFP_NOFAIL
for both the tbl as well as alloc_bucket_spinlocks().

So upon the first table allocation failure, we shrink the
size to the smallest value that makes sense and retry the alloc
with the same semantics. If we fail again, then we force the
call with __GFP_NOFAIL. With the defaults, this means that from
64 buckets, we retry with only 4. Any later issues regarding
performance due to collisions or larger table resizing (when
more memory becomes available) is the last of our problems.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/rhashtable.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 05a4b1b8b8ce..28f28602e2f5 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -166,15 +166,20 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 	return tbl;
 }
 
-static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
-					       size_t nbuckets,
-					       gfp_t gfp)
+static struct bucket_table *__bucket_table_alloc(struct rhashtable *ht,
+						 size_t nbuckets,
+						 gfp_t gfp, bool retry)
 {
 	struct bucket_table *tbl = NULL;
 	size_t size, max_locks;
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
+	if (retry) {
+		gfp |= __GFP_NOFAIL;
+		tbl = kzalloc(size, gfp);
+	} /* fall-through */
+
 	if (gfp != GFP_KERNEL)
 		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
 	else
@@ -211,6 +216,20 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	return tbl;
 }
 
+static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
+					       size_t nbuckets,
+					       gfp_t gfp)
+{
+	return __bucket_table_alloc(ht, nbuckets, gfp, false);
+}
+
+static struct bucket_table *bucket_table_alloc_retry(struct rhashtable *ht,
+						     size_t nbuckets,
+						     gfp_t gfp)
+{
+	return __bucket_table_alloc(ht, nbuckets, gfp, true);
+}
+
 static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 						  struct bucket_table *tbl)
 {
@@ -1067,9 +1086,20 @@ int rhashtable_init(struct rhashtable *ht,
 		}
 	}
 
+	/*
+	 * This is api initialization and thus we need to guarantee the
+	 * initial rhashtable allocation. Upon failure, retry with a
+	 * smallest possible size, otherwise we exhaust our options with
+	 * __GFP_NOFAIL.
+	 */
 	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (tbl == NULL)
-		return -ENOMEM;
+	if (unlikely(tbl == NULL)) {
+		size = HASH_MIN_SIZE;
+
+		tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
+		if (tbl == NULL)
+			tbl = bucket_table_alloc_retry(ht, size, GFP_KERNEL);
+	}
 
 	atomic_set(&ht->nelems, 0);
 
-- 
2.13.6

