Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1143910-1525285332-2-2124096240337748099
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525285331; b=GYX0i+erjahqMpVGAiX4HGAefkqXOGFK2WzwVT+rUpW3ozvZx/
    Cg2xAlvRSjuQw2spIXx46Xc1yn4NqHG0F313tK0jiTFhZAYfnmSQ3sf/qDgKb8XN
    RM7adYCPQtCYG5Db+bTqjqYmbMENIOHpXdILk18RlhE/T27evdH7kqnqY4JVGlvm
    QAxVCdI8blCnwNpItCrHGLkLuRie5GogKgb6t57CN9bzQE3f6L65mjU7tj1iYome
    +s5VLnoudbChzzxbG4GArmS1w8laAkTvMEp0dbBkg6pzVVLTHiXGiKUmbzFyrZ+6
    EQaLURZdISeCcYhcHzkn+ovGYlf+3xzmKXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525285331; bh=R0J9H
    N0vE/kNDq+qEuNCVryyQIlrTpkcPs1beQSbEqY=; b=lMpAztHW5jMFQNDvkCDu8
    +zs4uwsWfbiQxz1FTtdiOZemdwMuMRbsGV8HgTitVQwkRFO9rVp526zQG5skFH6l
    MFFfMk0QpGXivS35whqP1V2I8U8QXmCU71iCHd3EMqILabN16IbL8TJZaqJz1BG3
    gkAbqGw+bSmf0prIRccTbT/3OTFIDdhu/Kq67FptHxB/TUkm3t+c7EVxKuCKKR/5
    a3UrLSfeqdFGteJrEuE+k6nT+Lba0uBaeJ9x1kDqFBY4+CdbrF/VfrM1OuJm0bWn
    //m1AXkLBjiL22sKl4RAr9HRBiHRcZwJ38yWSv2Wv9ND82Cnubj5JzFyCnpi0oqu
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2GZpUQ/D6jp6S3lum0IqWpo7huIw3OkM9PPSGjaAXCRPO07QOInuT6N4RSZB7aP99aUnidrhcqyMqBEHa4HFOrjOIAPnIBiqOfXROVi9QhBRmLFMJj
    KzH7nFFfZ+vvMPhHYXj8zK1AAiFl5ml/xCvt7hC/O5L19Lu8e2DFhsgCE9EBVzYPSJqL9YHGK8zghTfeRYbKtzhI1YpCi13cDE66owiU0u0bb564bzp4eI6t
    SQdFymu9tBTm+AXWLYRQvQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=gUh1nhc3pXk5PR3UN0EA:9 a=CjuIK1q_8ugA:10
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
Subject: [PATCH 4/4] staging: lustre: obdclass: change object lookup to no
 wait mode
Date: Wed,  2 May 2018 14:21:48 -0400
Message-Id: <1525285308-15347-5-git-send-email-jsimmons@infradead.org>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lai Siyao <lai.siyao@intel.com>

Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
to remove object from cache, but this may lead to deadlock, because
when other process lookup such object, it needs to wait for this
object until release (done at last refcount put), while that process
maybe already hold an LDLM lock.

Now that current code can handle dying object correctly, we can just
return such object in lookup, thus the above deadlock can be avoided.

Signed-off-by: Lai Siyao <lai.siyao@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9049
Reviewed-on: https://review.whamcloud.com/26965
Reviewed-by: Alex Zhuravlev <alexey.zhuravlev@intel.com>
Tested-by: Cliff White <cliff.white@intel.com>
Reviewed-by: Fan Yong <fan.yong@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/include/lu_object.h  |  2 +-
 drivers/staging/lustre/lustre/obdclass/lu_object.c | 82 +++++++++-------------
 2 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers/staging/lustre/lustre/include/lu_object.h
index f29bbca..232063a 100644
--- a/drivers/staging/lustre/lustre/include/lu_object.h
+++ b/drivers/staging/lustre/lustre/include/lu_object.h
@@ -673,7 +673,7 @@ static inline void lu_object_get(struct lu_object *o)
 }
 
 /**
- * Return true of object will not be cached after last reference to it is
+ * Return true if object will not be cached after last reference to it is
  * released.
  */
 static inline int lu_object_is_dying(const struct lu_object_header *h)
diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index 8b507f1..9311703 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -589,19 +589,13 @@ static struct lu_object *htable_lookup(struct lu_site *s,
 				       const struct lu_fid *f,
 				       __u64 *version)
 {
-	struct cfs_hash		*hs = s->ls_obj_hash;
 	struct lu_site_bkt_data *bkt;
 	struct lu_object_header *h;
 	struct hlist_node	*hnode;
-	__u64 ver;
-	wait_queue_entry_t waiter;
+	u64 ver = cfs_hash_bd_version_get(bd);
 
-retry:
-	ver = cfs_hash_bd_version_get(bd);
-
-	if (*version == ver) {
+	if (*version == ver)
 		return ERR_PTR(-ENOENT);
-	}
 
 	*version = ver;
 	bkt = cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
@@ -615,31 +609,13 @@ static struct lu_object *htable_lookup(struct lu_site *s,
 	}
 
 	h = container_of(hnode, struct lu_object_header, loh_hash);
-	if (likely(!lu_object_is_dying(h))) {
-		cfs_hash_get(s->ls_obj_hash, hnode);
-		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
-		if (!list_empty(&h->loh_lru)) {
-			list_del_init(&h->loh_lru);
-			percpu_counter_dec(&s->ls_lru_len_counter);
-		}
-		return lu_object_top(h);
+	cfs_hash_get(s->ls_obj_hash, hnode);
+	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
+	if (!list_empty(&h->loh_lru)) {
+		list_del_init(&h->loh_lru);
+		percpu_counter_dec(&s->ls_lru_len_counter);
 	}
-
-	/*
-	 * Lookup found an object being destroyed this object cannot be
-	 * returned (to assure that references to dying objects are eventually
-	 * drained), and moreover, lookup has to wait until object is freed.
-	 */
-
-	init_waitqueue_entry(&waiter, current);
-	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
-	cfs_hash_bd_unlock(hs, bd, 1);
-	schedule();
-	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
-	cfs_hash_bd_lock(hs, bd, 1);
-	goto retry;
+	return lu_object_top(h);
 }
 
 /**
@@ -680,6 +656,8 @@ static void lu_object_limit(const struct lu_env *env, struct lu_device *dev)
 }
 
 /**
+ * Core logic of lu_object_find*() functions.
+ *
  * Much like lu_object_find(), but top level device of object is specifically
  * \a dev rather than top level device of the site. This interface allows
  * objects of different "stacking" to be created within the same site.
@@ -713,36 +691,46 @@ struct lu_object *lu_object_find_at(const struct lu_env *env,
 	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
 	 * just alloc and insert directly.
 	 *
+	 * If dying object is found during index search, add @waiter to the
+	 * site wait-queue and return ERR_PTR(-EAGAIN).
 	 */
-	s  = dev->ld_site;
-	hs = s->ls_obj_hash;
+	if (conf && conf->loc_flags & LOC_F_NEW) {
+		o = lu_object_alloc(env, dev, f, conf);
+		if (unlikely(IS_ERR(o)))
+			return o;
+
+		hs = dev->ld_site->ls_obj_hash;
+		cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
+		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
+		cfs_hash_bd_unlock(hs, &bd, 1);
 
-	cfs_hash_bd_get(hs, f, &bd);
-	if (!(conf && conf->loc_flags & LOC_F_NEW)) {
-		cfs_hash_bd_lock(hs, &bd, 0);
-		o = htable_lookup(s, &bd, f, &version);
-		cfs_hash_bd_unlock(hs, &bd, 0);
+		lu_object_limit(env, dev);
 
-		if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
-			return o;
+		return o;
 	}
+
+	s  = dev->ld_site;
+	hs = s->ls_obj_hash;
+	cfs_hash_bd_get_and_lock(hs, f, &bd, 1);
+	o = htable_lookup(s, &bd, f, &version);
+	cfs_hash_bd_unlock(hs, &bd, 0);
+	if (!IS_ERR(o) || PTR_ERR(o) != -ENOENT)
+		return o;
+
 	/*
 	 * Allocate new object. This may result in rather complicated
 	 * operations, including fld queries, inode loading, etc.
 	 */
 	o = lu_object_alloc(env, dev, f, conf);
-	if (IS_ERR(o))
+	if (unlikely(IS_ERR(o)))
 		return o;
 
 	LASSERT(lu_fid_eq(lu_object_fid(o), f));
 
 	cfs_hash_bd_lock(hs, &bd, 1);
 
-	if (conf && conf->loc_flags & LOC_F_NEW)
-		shadow = ERR_PTR(-ENOENT);
-	else
-		shadow = htable_lookup(s, &bd, f, &version);
-	if (likely(PTR_ERR(shadow) == -ENOENT)) {
+	shadow = htable_lookup(s, &bd, f, &version);
+	if (likely(IS_ERR(shadow) && PTR_ERR(shadow) == -ENOENT)) {
 		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
 		cfs_hash_bd_unlock(hs, &bd, 1);
 
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
