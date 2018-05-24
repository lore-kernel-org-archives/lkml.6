Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597100-1527197364-2-14169795688753335132
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
    1527197364; b=QEvr08litvD63PFRiRHr0wS9e6DCuAU2ba/hR7uM0hwGtH7Wbw
    PwgqQs0sq2xKZ2ZXorVZr0ZbXX5tvcN7BNyZYbxZ/P0bKMkEHEQ57b7D5Ne5cVFM
    f5qvHQolDGBSMcw31WvzDv4+w6HOLsupaIp+FT5LmcB0RdqpMdUvIfmtfgNna0Ck
    2IBxRBaQeTJ2XCeHXtA1XGpxW6b6hRAmLXvj3opPkEQfyTgyLirTJfx4AO+mD/ME
    aZmG1guj0OP+aoje6+QLIOnWSEMOOOhYBVc8YqQP27SrRMRzNvuRsDaO6+yDeBcU
    bXlysqSbgKjPlb+mdF2KZvBC672/81u9gkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527197364; bh=
    YLmgs8pChuSULDL/qlMTCyhboYKYZJMpTz0jjThAkVg=; b=dKE+N2TXJzaqQ5It
    tQ59VmGiZfGckxqDb4QzXLUEd1cQ4ofwqIIqj9Ady3M0VcLsz24ULoFlBOBd2tQM
    rdHGWeH70jOig8kJP5HacG+gse7l9r/nbKRN6zqiylkTSi/dwSAaKL9emeesuLl9
    ZvWx8rUZStAq0HRQZDj53axn1QC/JWQyMPgFjoqfv5dPqPsfeB6ceZnO3/4oABno
    YjxRya5UEOu/tTJwJiVSz7UBuFtCAHUuSPue+OOUDwLQEZn675f94GM1i1eCUqZT
    86DUGAh1KjYfxvgCVUQ1Tu3pJSQSIlr9F+mHuF+ttPuUzbTviAgi9BfPd0U0iTZR
    x27LQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfOR2W/d8pa8OfhRRSNBa1ChYMAY4U3AHOS4TY/ChWSzgBBTz/pa6gPHfB5cKvAL7N4hoQB56Z1rVbVo3eWkW4rhMCREeg7frk3mK6qgugdhjuNi8sycy
    DWSHu4W7mg14zqmV2ix9YN75FwpLwda7N/QZCXiQPC4TPLvyatKugVxli+Hp1hoIXk5LnBcXh/LVY1P/PtsR1pkipwl2dO0RwyYScBwoW2zWOHPgs7D4Ny7y
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ppB18yTfwJPjpZ29F0QA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161360AbeEXV3S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 17:29:18 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:36415 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161359AbeEXV2e (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 24 May 2018 17:28:34 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/6] ipc: get rid of ids->tables_initialized hack
Date: Thu, 24 May 2018 14:11:33 -0700
Message-Id: <20180524211135.27760-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180524211135.27760-1-dave@stgolabs.net>
References: <20180524211135.27760-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In sysvipc we have an ids->tables_initialized regarding the
rhashtable, introduced in:

    0cfb6aee70b (ipc: optimize semget/shmget/msgget for lots of keys).

It's there, specifically, to prevent nil pointer dereferences,
from using an uninitialized api. Considering how rhashtable_init()
can fail (probably due to ENOMEM, if anything), this made the
overall ipc initialization capable of failure as well. That alone
is ugly, but fine, however I've spotted a few issues regarding the
semantics of tables_initialized (however unlikely they may be):

- There is inconsistency in what we return to userspace: ipc_addid()
returns ENOSPC which is certainly _wrong_, while ipc_obtain_object_idr()
returns EINVAL.

- After we started using rhashtables, ipc_findkey() can return nil upon
!tables_initialized, but the caller expects nil for when the ipc structure
isn't found, and can therefore call into ipcget() callbacks.

Now that rhashtable initialization cannot fail, we can properly
get rid of the hack altogether.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/ipc_namespace.h |  1 -
 ipc/util.c                    | 23 ++++++++---------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index b5630c8eb2f3..37f3a4b7c637 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -16,7 +16,6 @@ struct user_namespace;
 struct ipc_ids {
 	int in_use;
 	unsigned short seq;
-	bool tables_initialized;
 	struct rw_semaphore rwsem;
 	struct idr ipcs_idr;
 	int max_id;
diff --git a/ipc/util.c b/ipc/util.c
index 4e81182fa0ac..823e09e72c58 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -125,7 +125,6 @@ int ipc_init_ids(struct ipc_ids *ids)
 	if (err)
 		return err;
 	idr_init(&ids->ipcs_idr);
-	ids->tables_initialized = true;
 	ids->max_id = -1;
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	ids->next_id = -1;
@@ -178,19 +177,16 @@ void __init ipc_init_proc_interface(const char *path, const char *header,
  */
 static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 {
-	struct kern_ipc_perm *ipcp = NULL;
+	struct kern_ipc_perm *ipcp;
 
-	if (likely(ids->tables_initialized))
-		ipcp = rhashtable_lookup_fast(&ids->key_ht, &key,
+	ipcp = rhashtable_lookup_fast(&ids->key_ht, &key,
 					      ipc_kht_params);
+	if (!ipcp)
+		return NULL;
 
-	if (ipcp) {
-		rcu_read_lock();
-		ipc_lock_object(ipcp);
-		return ipcp;
-	}
-
-	return NULL;
+	rcu_read_lock();
+	ipc_lock_object(ipcp);
+	return ipcp;
 }
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -255,7 +251,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (limit > IPCMNI)
 		limit = IPCMNI;
 
-	if (!ids->tables_initialized || ids->in_use >= limit)
+	if (ids->in_use >= limit)
 		return -ENOSPC;
 
 	idr_preload(GFP_KERNEL);
@@ -566,9 +562,6 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 	struct kern_ipc_perm *out;
 	int lid = ipcid_to_idx(id);
 
-	if (unlikely(!ids->tables_initialized))
-		return ERR_PTR(-EINVAL);
-
 	out = idr_find(&ids->ipcs_idr, lid);
 	if (!out)
 		return ERR_PTR(-EINVAL);
-- 
2.13.6

