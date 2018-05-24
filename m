Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159700-2-16484849765517521644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159699; b=TFPKodsMlHTZMu3r0EnVZwCcuOJmaOc6Kt3RBDwywK32aZBEAy
    gyEIOifYP4rl890LJG+Dar49ONSebvISFT+aqSkzJPFyqIV9E5nnCwmz6wGu/KFO
    H3AxXhe7FJLYQrxYKqi/fMvi249rmltHDRIOfYkxEMVY+jfKKbtQ541Ek78jiAKh
    vx+tc3aMLYK46kJOi9zqZ4+q4RkDOBVVxGASq85b0KLLi+ci6ImlrICZyWsvlWdx
    UhlYm79YR7S7/q1FNsipnQyafq2/mj35lctzYYJXF36LzFpIdR1I5pjmrgbVQ/YA
    Pj86q/5TRJT4RazVjiH7PW6pwczq/Mc4PgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527159699; bh=
    wFeiVlQp/QImsUhDq9mo+6r6AGFPjF4j88Ygw9FOSIg=; b=WM8yARi0IJM66YL9
    6MtXYOesEOagyCvZXjP8BUtSA3RVOLKZ5AwkpwlUCs3aPvckRuLnRnCdbZkpqfdl
    4D0LPtXz2ILUE6g5yvwYJ5Qza9usQKn7RE1yOQTWH83cXCRIS+UKICqq48HEt10S
    ETn6qjX7czlNhECIvfmKT4k5CUI4HXYs2NuZ6l0NLt4zpKvTqr7dK48/eVVB0eU5
    bUFNKDPM4Tq3ItX8D4ffQVttAJyI3EFqrZQrG2KHDm7D9mUY86gz9nIBFkt7YS0R
    3Gh2TxLSmAGPmzqysQpufuzH58511Bdj0UKlDCu+0ndHigDUXwMCrVVInvu3pApQ
    3ej8PQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKGpyJVEyPn6269DDZVI14NO1hu6wouepsFkT2v24DViZ7IWNcF3K1j7U9qJJoyDCWVAK7V/+0vjRiDAutLgBuOFn0LO++0EIHnlmegsh8H2qXNmSsnk
    taGAn6sWrSh/Ba1cDxWPzCxdOdE6/qMlu3pxEe3VqPfvXAPs4O8SF5fuA70SDP1Ls6N2tBEibJtewXC/BXKIUOPLQ5yHE/IQ/f9yJRehFsfRSr0+F7mMYT14
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=FYBxro5Pd-oduUAjmJMA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030229AbeEXLBf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:36159 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030246AbeEXLAZ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 07:00:25 -0400
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 3/5] dcache: allocate external names from reclaimable kmalloc caches
Date: Thu, 24 May 2018 13:00:09 +0200
Message-Id: <20180524110011.1940-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524110011.1940-1-vbabka@suse.cz>
References: <20180524110011.1940-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can use the newly introduced kmalloc-reclaimable-X caches, to allocate
external names in dcache, which will take care of the proper accounting
automatically, and also improve anti-fragmentation page grouping.

This effectively reverts commit f1782c9bc547 ("dcache: account external names
as indirectly reclaimable memory") and instead passes __GFP_RECLAIMABLE to
kmalloc(). The accounting thus moves from NR_INDIRECTLY_RECLAIMABLE_BYTES to
NR_SLAB_RECLAIMABLE, which is also considered in MemAvailable calculation and
overcommit decisions.

This reverts commit f1782c9bc547754f4bd3043fe8cfda53db85f13f.
---
 fs/dcache.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c30a8ae46096..3346034d4520 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -257,25 +257,11 @@ static void __d_free(struct rcu_head *head)
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
-static void __d_free_external_name(struct rcu_head *head)
-{
-	struct external_name *name = container_of(head, struct external_name,
-						  u.head);
-
-	mod_node_page_state(page_pgdat(virt_to_page(name)),
-			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
-			    -ksize(name));
-
-	kfree(name);
-}
-
 static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
-
-	__d_free_external_name(&external_name(dentry)->u.head);
-
-	kmem_cache_free(dentry_cache, dentry);
+	kfree(external_name(dentry));
+	kmem_cache_free(dentry_cache, dentry); 
 }
 
 static inline int dname_external(const struct dentry *dentry)
@@ -306,7 +292,7 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 		struct external_name *p;
 		p = container_of(name->name, struct external_name, name[0]);
 		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			call_rcu(&p->u.head, __d_free_external_name);
+			kfree_rcu(p, u.head);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -1609,7 +1595,6 @@ EXPORT_SYMBOL(d_invalidate);
  
 struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
-	struct external_name *ext = NULL;
 	struct dentry *dentry;
 	char *dname;
 	int err;
@@ -1630,14 +1615,15 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		dname = dentry->d_iname;
 	} else if (name->len > DNAME_INLINE_LEN-1) {
 		size_t size = offsetof(struct external_name, name[1]);
-
-		ext = kmalloc(size + name->len, GFP_KERNEL_ACCOUNT);
-		if (!ext) {
+		struct external_name *p = kmalloc(size + name->len,
+						  GFP_KERNEL_ACCOUNT |
+						  __GFP_RECLAIMABLE);
+		if (!p) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&ext->u.count, 1);
-		dname = ext->name;
+		atomic_set(&p->u.count, 1);
+		dname = p->name;
 	} else  {
 		dname = dentry->d_iname;
 	}	
@@ -1676,12 +1662,6 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		}
 	}
 
-	if (unlikely(ext)) {
-		pg_data_t *pgdat = page_pgdat(virt_to_page(ext));
-		mod_node_page_state(pgdat, NR_INDIRECTLY_RECLAIMABLE_BYTES,
-				    ksize(ext));
-	}
-
 	this_cpu_inc(nr_dentry);
 
 	return dentry;
@@ -2762,7 +2742,7 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		call_rcu(&old_name->u.head, __d_free_external_name);
+		kfree_rcu(old_name, u.head);
 }
 
 /*
-- 
2.17.0

