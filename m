Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1731937-1526350561-5-13366548297672281259
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526350560; b=YWpeXd3FOKEidkbQ7V3dGIInjVCEIHhSGbTD1xnV/RUgdccy8i
    x+nqcFe7HnedBKMruxkuLlUEVAEFq9kLuKaZAmt4eWS9pZRqdyT/6H2uOhnssGM4
    RNNZ/XMGgL9yHJ/BbrG3jkrbh0bmjgm0qspHC+c38ZryK4qNAhmqlUSOKKJ3qTP0
    4YOyDtQdm6/enRq/3qtfsICD+A7rMfF1kjHbDzQ1uOohcc05Jgd+2V9lW4CQYGJT
    WGg0wPc8TJtMKDql1/1qvzCaQS2i6xlTyr4tvZWIItULR9xVYZ/7ODF1SKRC6VW3
    8DZ8n9x5foD50ux+YVCr1xOPNKKNF9luctvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526350560; bh=S5mrf
    Dyfg/6LjoKyhfwS69oqSB7y5asP14NPD4e85+c=; b=TuJPnXjaEP5eAHCimF+Pe
    WXu1iHDY6ygGp22V9Ph61lRYnmWVcjUzKW6A2RGB3MrI+ruSl34MeuVEcNn2jWiK
    woOUuejTUD9riXDlSdSJu39HtOTCjoLuQx8bp3Jl8Q9L5cE7GF76JAJnRrdM02jd
    2KbioWYfNcJbQmOg9L+FrMfeUjEgbKw32trBtGdPpzOuJX+hXYZ5tU0qtCjvScOB
    wgd0q2i8xyahK/nrb6um59SKto0kGQRShazQlYH7s4Y0rAvn9BRfThGSDVzhIFSm
    ykkqwVGIdpuqXXoeanFpvgZjOufJXCYRSpTlTe/uyWfclzNO/NdVS81/WVovohDV
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAJGh0cqVp/2j7ZWdS8v1p+UGv0j1uEVSd6d9svAM0fQ+lMwjHUSyMvBJ22NQB//q75JHpx+i158vAMUZQivl8d+KsbWtqOoFvvhTOPN403AmPcMVurX
    DKDL4rJ71oy0Weu6dV6pIkfaw5nEmxqqQl8pG5WGPMKw5OoUXt+J+jyrNLR8grNIEYQ2cGMIhLmrytVO+dDS9ZF5mSaXuRxTzJh++BCTenIE1aJp3hLhZtuW
    2nYGCavsgB0MDfZpXnC5HA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=k0etZ8SI3Tafqq5tNSwA:9 a=CjuIK1q_8ugA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH v2] staging: lustre: obdclass: change object lookup to no wait
 mode
Date: Mon, 14 May 2018 22:15:48 -0400
Message-Id: <1526350548-4402-1-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
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
Cc: Lai Siyao <lai.siyao@intel.com>,
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
Reviewed-by: NeilBrown <neil@brown.name>
---
Changelog:

v1) Initial patch that didn't apply to staging-testing branch
v2) Rebased after Neil's patches landed. Remove unlikely() test
    as requested by Dan Carpenter

 drivers/staging/lustre/lustre/obdclass/lu_object.c | 39 +++++-----------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers/staging/lustre/lustre/obdclass/lu_object.c
index f14e350..e0abd4f 100644
--- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
+++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
@@ -593,15 +593,10 @@ static struct lu_object *htable_lookup(struct lu_site *s,
 				       const struct lu_fid *f,
 				       __u64 *version)
 {
-	struct cfs_hash		*hs = s->ls_obj_hash;
 	struct lu_site_bkt_data *bkt;
 	struct lu_object_header *h;
 	struct hlist_node	*hnode;
-	__u64 ver;
-	wait_queue_entry_t waiter;
-
-retry:
-	ver = cfs_hash_bd_version_get(bd);
+	u64 ver = cfs_hash_bd_version_get(bd);
 
 	if (*version == ver)
 		return ERR_PTR(-ENOENT);
@@ -618,31 +613,13 @@ static struct lu_object *htable_lookup(struct lu_site *s,
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
@@ -683,6 +660,8 @@ static void lu_object_limit(const struct lu_env *env, struct lu_device *dev)
 }
 
 /**
+ * Core logic of lu_object_find*() functions.
+ *
  * Much like lu_object_find(), but top level device of object is specifically
  * \a dev rather than top level device of the site. This interface allows
  * objects of different "stacking" to be created within the same site.
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
