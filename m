Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF04EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579AD21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ulO/ug5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579AD21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeIRNep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:34:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36537 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbeIRNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so1119712edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnmFi0hiEs6tHZmUqR4AZh2ntkfEmxwfXC4NBIwd+p4=;
        b=ulO/ug5N+CdAfmlazXbs1KGqyMYChSkIQoYmN45kVBDKKDBCFj5id9kJa308/cEDkn
         hGsbGbwVQKCP/O+9/N9aORBmwHq+YZmbhy4VlpP+tr6cgRowg6c12BI0likEzC5wgw2e
         JxPN4mwMGjONSWG+25aImJTo9yCSKGwSSsaZTdgNaR+cssxxqZRmoiQWcXaEHFJxphwP
         JHvjf+4XURXj50doVxDSC+Ec3r0nV9rYkj7g8lMdmqwP6PWPH0OKrxBN91g1kA+VyXyi
         0ToFskGQZRmu2BPXhzMMoMV9KYHdeUAl/rzzSI1yCDzeTnlWFQd5tqP0v9Y1XUjeyvFE
         uvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnmFi0hiEs6tHZmUqR4AZh2ntkfEmxwfXC4NBIwd+p4=;
        b=NQPEkti+iiaB2JWs8xcZDhlERVqpGl4Rsyv9Eic0LY6rjZbHDWxy/98TIL9VboE13n
         HTLezvXVLbAfLO2LVs21ooq5JJG+VzvfwiojV2kZhaPEZyJPsbss/WNJNvRsacaHcD7K
         QK+hX0FBQkIzg4VU1YbCoPvuvcn2u1qAKP9nipA62I8j4iP0mM85Z/r5/xH0acdG+1TF
         BNFuxMJyLIvCpSnzhjtO6tYUT4ycjeSFwHQRMqBbr0XD4jdpCUriA+MFJFBJ1uNGND87
         Xra6tEAGEMqaC6IVClAg7QWGF9hbqVrWmKVjLc6iHTS6jHBYkZa8vhqB7wMTvBccA7Pa
         BLeQ==
X-Gm-Message-State: APzg51D/2hlxpERfW9smP+iUJtxAniyKavMzq8w7HvLjycF9+kfR9kG+
        NYThev667ZDYS8btk9RgaQKNyA==
X-Google-Smtp-Source: ANB0VdYnE6HLEGin0H5SD19SDxupUyBZs02cIfn0moKsDno+pyxyCCH15r65Oxmcg64bhM0lBXoTkQ==
X-Received: by 2002:a50:98c1:: with SMTP id j59-v6mr49134886edb.212.1537257795548;
        Tue, 18 Sep 2018 01:03:15 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id l48-v6sm7221062eda.94.2018.09.18.01.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 01:03:14 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: pblk: move ring buffer alloc/free rb init
Date:   Tue, 18 Sep 2018 10:03:04 +0200
Message-Id: <1537257785-31630-4-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pblk's read/write buffer currently takes a buffer and its size and uses
it to create the metadata around it to use it as a ring buffer. This
puts the responsibility of allocating/freeing ring buffer memory on the
ring buffer user. Instead, move it inside of the ring buffer helpers
(pblk-rb.c). This simplifies creation/destruction routines.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 18 +++------------
 drivers/lightnvm/pblk-rb.c   | 53 +++++++++++++++++++++++++++-----------------
 drivers/lightnvm/pblk.h      |  7 ++----
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index caed18fabd35..549f13a58b33 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -185,17 +185,14 @@ static void pblk_rwb_free(struct pblk *pblk)
 	if (pblk_rb_tear_down_check(&pblk->rwb))
 		pblk_err(pblk, "write buffer error on tear down\n");
 
-	pblk_rb_data_free(&pblk->rwb);
-	vfree(pblk_rb_entries_ref(&pblk->rwb));
+	pblk_rb_free(&pblk->rwb);
 }
 
 static int pblk_rwb_init(struct pblk *pblk)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_rb_entry *entries;
-	unsigned long nr_entries, buffer_size;
-	unsigned int power_size, power_seg_sz;
+	unsigned long buffer_size;
 	int pgs_in_buffer;
 
 	pgs_in_buffer = max(geo->mw_cunits, geo->ws_opt) * geo->all_luns;
@@ -205,16 +202,7 @@ static int pblk_rwb_init(struct pblk *pblk)
 	else
 		buffer_size = pgs_in_buffer;
 
-	nr_entries = pblk_rb_calculate_size(buffer_size);
-
-	entries = vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_entry)));
-	if (!entries)
-		return -ENOMEM;
-
-	power_size = get_count_order(nr_entries);
-	power_seg_sz = get_count_order(geo->csecs);
-
-	return pblk_rb_init(&pblk->rwb, entries, power_size, power_seg_sz);
+	return pblk_rb_init(&pblk->rwb, buffer_size, geo->csecs);
 }
 
 /* Minimum pages needed within a lun */
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index e46d8cb9d28b..f653faa6a9ed 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -23,7 +23,7 @@
 
 static DECLARE_RWSEM(pblk_rb_lock);
 
-void pblk_rb_data_free(struct pblk_rb *rb)
+static void pblk_rb_data_free(struct pblk_rb *rb)
 {
 	struct pblk_rb_pages *p, *t;
 
@@ -36,22 +36,46 @@ void pblk_rb_data_free(struct pblk_rb *rb)
 	up_write(&pblk_rb_lock);
 }
 
+void pblk_rb_free(struct pblk_rb *rb)
+{
+	pblk_rb_data_free(rb);
+	vfree(rb->entries);
+}
+
+/*
+ * pblk_rb_calculate_size -- calculate the size of the write buffer
+ */
+static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
+{
+	/* Alloc a write buffer that can at least fit 128 entries */
+	return (1 << max(get_count_order(nr_entries), 7));
+}
+
 /*
  * Initialize ring buffer. The data and metadata buffers must be previously
  * allocated and their size must be a power of two
  * (Documentation/core-api/circular-buffers.rst)
  */
-int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
-		 unsigned int power_size, unsigned int power_seg_sz)
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_size)
 {
 	struct pblk *pblk = container_of(rb, struct pblk, rwb);
+	struct pblk_rb_entry *entries;
 	unsigned int init_entry = 0;
-	unsigned int alloc_order = power_size;
 	unsigned int max_order = MAX_ORDER - 1;
-	unsigned int order, iter;
+	unsigned int power_size, power_seg_sz;
+	unsigned int alloc_order, order, iter;
+	unsigned int nr_entries;
+
+	nr_entries = pblk_rb_calculate_size(size);
+	entries = vzalloc(array_size(nr_entries, sizeof(struct pblk_rb_entry)));
+	if (!entries)
+		return -ENOMEM;
+
+	power_size = get_count_order(size);
+	power_seg_sz = get_count_order(seg_size);
 
 	down_write(&pblk_rb_lock);
-	rb->entries = rb_entry_base;
+	rb->entries = entries;
 	rb->seg_size = (1 << power_seg_sz);
 	rb->nr_entries = (1 << power_size);
 	rb->mem = rb->subm = rb->sync = rb->l2p_update = 0;
@@ -62,6 +86,7 @@ int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
 
 	INIT_LIST_HEAD(&rb->pages);
 
+	alloc_order = power_size;
 	if (alloc_order >= max_order) {
 		order = max_order;
 		iter = (1 << (alloc_order - max_order));
@@ -80,6 +105,7 @@ int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
 		page_set = kmalloc(sizeof(struct pblk_rb_pages), GFP_KERNEL);
 		if (!page_set) {
 			up_write(&pblk_rb_lock);
+			vfree(entries);
 			return -ENOMEM;
 		}
 
@@ -89,6 +115,7 @@ int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
 			kfree(page_set);
 			pblk_rb_data_free(rb);
 			up_write(&pblk_rb_lock);
+			vfree(entries);
 			return -ENOMEM;
 		}
 		kaddr = page_address(page_set->pages);
@@ -125,20 +152,6 @@ int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
 	return 0;
 }
 
-/*
- * pblk_rb_calculate_size -- calculate the size of the write buffer
- */
-unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
-{
-	/* Alloc a write buffer that can at least fit 128 entries */
-	return (1 << max(get_count_order(nr_entries), 7));
-}
-
-void *pblk_rb_entries_ref(struct pblk_rb *rb)
-{
-	return rb->entries;
-}
-
 static void clean_wctx(struct pblk_w_ctx *w_ctx)
 {
 	int flags;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0ffc19cff697..17b27b395942 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -734,10 +734,7 @@ struct pblk_line_ws {
 /*
  * pblk ring buffer operations
  */
-int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
-		 unsigned int power_size, unsigned int power_seg_sz);
-unsigned int pblk_rb_calculate_size(unsigned int nr_entries);
-void *pblk_rb_entries_ref(struct pblk_rb *rb);
+int pblk_rb_init(struct pblk_rb *rb, unsigned int size, unsigned int seg_sz);
 int pblk_rb_may_write_user(struct pblk_rb *rb, struct bio *bio,
 			   unsigned int nr_entries, unsigned int *pos);
 int pblk_rb_may_write_gc(struct pblk_rb *rb, unsigned int nr_entries,
@@ -771,7 +768,7 @@ unsigned int pblk_rb_wrap_pos(struct pblk_rb *rb, unsigned int pos);
 
 int pblk_rb_tear_down_check(struct pblk_rb *rb);
 int pblk_rb_pos_oob(struct pblk_rb *rb, u64 pos);
-void pblk_rb_data_free(struct pblk_rb *rb);
+void pblk_rb_free(struct pblk_rb *rb);
 ssize_t pblk_rb_sysfs(struct pblk_rb *rb, char *buf);
 
 /*
-- 
2.7.4

