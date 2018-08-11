Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5485DC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0366321A28
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpoOMogP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0366321A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeHKRRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 13:17:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44981 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeHKRRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 13:17:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so10593805wrt.11;
        Sat, 11 Aug 2018 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NW1zrHVggqTYcyk7jlANWahgIrW7rPmetvwLmknNPSc=;
        b=WpoOMogPWcpy98JpWTLnDs1MKnd3uG0pUzd1FU/9RNjJJjnUlWqVodnO0maJgcxgXc
         sFEL5k+yYTAm1otT+PYpaarMufZBAxKatFgWk7OcSsQFz6eDPEPN2qPfM92VXXEtS9up
         T6PhUTjnJZp7qjnmmyiN+Ui8/sRR0nUzM1jPNGrAX1psnZdnjWXiSeJCzgiad5vssJA8
         bMN6674l4AwjET10Wtp93757jN0kzG6wVdSsJUnINZi7EyRKU592n/43CU/pCe8/8pUz
         N+58PvsCg1pCKSTiJ/laX2qsQeDOGnlsNJhYMvCmHqZckS2f1W9AGHjN1zkCJPk32Rfe
         SQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NW1zrHVggqTYcyk7jlANWahgIrW7rPmetvwLmknNPSc=;
        b=VnwqeLHpoyMtKXunT13h8DAMTu46tk6okWdJB3N25+ehSPsCmjF53PZLJvEWYk+iV1
         JVw1WqVlDzATMkQ2y12Ta5APDKSbKAbHv0kISLYWfYvjNtnLc/M1tIdklv6gmptRGbtv
         6z47ijnZxSn+bBxTC2EU08l2QksEzj2dMLK1N5wtxrteYhXJu2ZDd5mOQwZOD+wFhKzp
         mJppApemt3XakXUUoIJ3Lcblay+HghVXra7jLJ8nijl3BdhnH1WvBhsaELaziElgJ0AG
         c1rWvMh9WC6MWMBdiC8tHEHBVi7ZZ7zve6k5YEEo776sUnOVtizPegaNMIJiVPy0R8xB
         Kkkw==
X-Gm-Message-State: AOUpUlHGzkOfwaxPVKQ0+6JjG82Ot9TPdc8abUjWuzqZJeYmpihIsGr5
        XHwzAFGcL+LYiMaZGnrTzz4=
X-Google-Smtp-Source: AA+uWPwUnPG2//MiwwV7AVTEQsEeRgMVoVNURZD/APiFgWMSvoEyCVKEIwtz6PBsh0OvosjkUmVGpg==
X-Received: by 2002:adf:9a55:: with SMTP id z79-v6mr6497792wrb.153.1533998583533;
        Sat, 11 Aug 2018 07:43:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id x16-v6sm2949956wro.84.2018.08.11.07.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 07:43:02 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com, rminnich@sandia.gov,
        lucho@ionkov.net
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>,
        Dominique Martinet <dominique.martinet@cea.fr>
Subject: [PATCH 2/2] 9p: Add refcount to p9_req_t
Date:   Sat, 11 Aug 2018 16:42:54 +0200
Message-Id: <20180811144254.23665-2-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180811144254.23665-1-tomasbortoli@gmail.com>
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid use-after-free(s), use a refcount to keep track of the
usable references to any instantiated struct p9_req_t.

This commit adds p9_req_put(), p9_req_get() and p9_req_try_get() as
wrappers to kref_put(), kref_get() and kref_get_unless_zero().
These are used by the client and the transports to keep track of
valid requests' references.

p9_free_req() is added back and used as callback by kref_put().

Add SLAB_TYPESAFE_BY_RCU as it ensures that the memory freed by
kmem_cache_free() will not be reused for another type until the rcu
synchronisation period is over, so an address gotten under rcu read
lock is safe to inc_ref() without corrupting random memory while
the lock is held.

Co-developed-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+467050c1ce275af2a5b8@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
---
 include/net/9p/client.h | 14 +++++++++++++
 net/9p/client.c         | 54 +++++++++++++++++++++++++++++++++++++++++++------
 net/9p/trans_fd.c       | 11 +++++++++-
 net/9p/trans_rdma.c     |  1 +
 4 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 735f3979d559..947a570307a6 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -94,6 +94,7 @@ enum p9_req_status_t {
 struct p9_req_t {
 	int status;
 	int t_err;
+	struct kref refcount;
 	wait_queue_head_t wq;
 	struct p9_fcall tc;
 	struct p9_fcall rc;
@@ -233,6 +234,19 @@ int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
 int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
 void p9_fcall_fini(struct p9_fcall *fc);
 struct p9_req_t *p9_tag_lookup(struct p9_client *, u16);
+
+static inline void p9_req_get(struct p9_req_t *r)
+{
+	kref_get(&r->refcount);
+}
+
+static inline int p9_req_try_get(struct p9_req_t *r)
+{
+	return kref_get_unless_zero(&r->refcount);
+}
+
+int p9_req_put(struct p9_req_t *r);
+
 void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status);
 
 int p9_parse_header(struct p9_fcall *, int32_t *, int8_t *, int16_t *, int);
diff --git a/net/9p/client.c b/net/9p/client.c
index 7942c0bfcc5b..83f2f0aadc14 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -310,6 +310,18 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	if (tag < 0)
 		goto free;
 
+	/*	Init ref to two because in the general case there is one ref
+	 *	that is put asynchronously by a writer thread, one ref
+	 *	temporarily given by p9_tag_lookup and put by p9_client_cb
+	 *	in the recv thread, and one ref put by p9_remove_tag in the
+	 *	main thread. The only exception is virtio that does not use
+	 *	p9_tag_lookup but does not have a writer thread either
+	 *	(the write happens synchronously in the request/zc_request
+	 *	callback), so p9_client_cb eats the second ref there
+	 *	as the pointer is duplicated directly by virtqueue_add_sgs()
+	 */
+	refcount_set(&req->refcount.refcount, 2);
+
 	return req;
 
 free:
@@ -333,10 +345,21 @@ struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag)
 	struct p9_req_t *req;
 
 	rcu_read_lock();
+again:
 	req = idr_find(&c->reqs, tag);
-	/* There's no refcount on the req; a malicious server could cause
-	 * us to dereference a NULL pointer
-	 */
+	if (req) {
+		/* We have to be careful with the req found under rcu_read_lock
+		 * Thanks to SLAB_TYPESAFE_BY_RCU we can safely try to get the
+		 * ref again without corrupting other data, then check again
+		 * that the tag matches once we have the ref
+		 */
+		if (!p9_req_try_get(req))
+			goto again;
+		if (req->tc.tag != tag) {
+			p9_req_put(req);
+			goto again;
+		}
+	}
 	rcu_read_unlock();
 
 	return req;
@@ -350,7 +373,7 @@ EXPORT_SYMBOL(p9_tag_lookup);
  *
  * Context: Any context.
  */
-static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
+static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
 {
 	unsigned long flags;
 	u16 tag = r->tc.tag;
@@ -359,11 +382,23 @@ static void p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
 	spin_lock_irqsave(&c->lock, flags);
 	idr_remove(&c->reqs, tag);
 	spin_unlock_irqrestore(&c->lock, flags);
+	return p9_req_put(r);
+}
+
+static void p9_req_free(struct kref *ref)
+{
+	struct p9_req_t *r = container_of(ref, struct p9_req_t, refcount);
 	p9_fcall_fini(&r->tc);
 	p9_fcall_fini(&r->rc);
 	kmem_cache_free(p9_req_cache, r);
 }
 
+int p9_req_put(struct p9_req_t *r)
+{
+	return kref_put(&r->refcount, p9_req_free);
+}
+EXPORT_SYMBOL(p9_req_put);
+
 /**
  * p9_tag_cleanup - cleans up tags structure and reclaims resources
  * @c:  v9fs client struct
@@ -379,7 +414,9 @@ static void p9_tag_cleanup(struct p9_client *c)
 	rcu_read_lock();
 	idr_for_each_entry(&c->reqs, req, id) {
 		pr_info("Tag %d still in use\n", id);
-		p9_tag_remove(c, req);
+		if (p9_tag_remove(c, req) == 0)
+			pr_warn("Packet with tag %d has still references",
+				req->tc.tag);
 	}
 	rcu_read_unlock();
 }
@@ -403,6 +440,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
 
 	wake_up(&req->wq);
 	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc.tag);
+	p9_req_put(req);
 }
 EXPORT_SYMBOL(p9_client_cb);
 
@@ -682,6 +720,8 @@ static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
 	return req;
 reterr:
 	p9_tag_remove(c, req);
+	/* We have to put also the 2nd reference as it won't be used */
+	p9_req_put(req);
 	return ERR_PTR(err);
 }
 
@@ -716,6 +756,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 
 	err = c->trans_mod->request(c, req);
 	if (err < 0) {
+		/* write won't happen */
+		p9_req_put(req);
 		if (err != -ERESTARTSYS && err != -EFAULT)
 			c->status = Disconnected;
 		goto recalc_sigpending;
@@ -2241,7 +2283,7 @@ EXPORT_SYMBOL(p9_client_readlink);
 
 int __init p9_client_init(void)
 {
-	p9_req_cache = KMEM_CACHE(p9_req_t, 0);
+	p9_req_cache = KMEM_CACHE(p9_req_t, SLAB_TYPESAFE_BY_RCU);
 	return p9_req_cache ? 0 : -ENOMEM;
 }
 
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 20f46f13fe83..686e24e355d0 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -132,6 +132,7 @@ struct p9_conn {
 	struct list_head req_list;
 	struct list_head unsent_req_list;
 	struct p9_req_t *req;
+	struct p9_req_t *wreq;
 	char tmp_buf[7];
 	struct p9_fcall rc;
 	int wpos;
@@ -383,6 +384,7 @@ static void p9_read_work(struct work_struct *work)
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
 		m->rc.capacity = 0;
+		p9_req_put(m->req);
 		m->req = NULL;
 	}
 
@@ -472,6 +474,8 @@ static void p9_write_work(struct work_struct *work)
 		m->wbuf = req->tc.sdata;
 		m->wsize = req->tc.size;
 		m->wpos = 0;
+		p9_req_get(req);
+		m->wreq = req;
 		spin_unlock(&m->client->lock);
 	}
 
@@ -492,8 +496,11 @@ static void p9_write_work(struct work_struct *work)
 	}
 
 	m->wpos += err;
-	if (m->wpos == m->wsize)
+	if (m->wpos == m->wsize) {
 		m->wpos = m->wsize = 0;
+		p9_req_put(m->wreq);
+		m->wreq = NULL;
+	}
 
 end_clear:
 	clear_bit(Wworksched, &m->wsched);
@@ -694,6 +701,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
 	if (req->status == REQ_STATUS_UNSENT) {
 		list_del(&req->req_list);
 		req->status = REQ_STATUS_FLSHD;
+		p9_req_put(req);
 		ret = 0;
 	}
 	spin_unlock(&client->lock);
@@ -711,6 +719,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	spin_lock(&client->lock);
 	list_del(&req->req_list);
 	spin_unlock(&client->lock);
+	p9_req_put(req);
 
 	return 0;
 }
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index c60655c90c9e..8cff368a11e3 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -365,6 +365,7 @@ send_done(struct ib_cq *cq, struct ib_wc *wc)
 			    c->busa, c->req->tc.size,
 			    DMA_TO_DEVICE);
 	up(&rdma->sq_sem);
+	p9_req_put(c->req);
 	kfree(c);
 }
 
-- 
2.11.0

