Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B25BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B720659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUsjw59Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5B720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbeIGBtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:49:19 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:33095 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbeIGBsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:48:22 -0400
Received: by mail-yw1-f50.google.com with SMTP id x67-v6so4646044ywg.0;
        Thu, 06 Sep 2018 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wgmJ6EXhA/y/tOqwdMZZ5+cOrvKrmLtj/CHSmhVjz3A=;
        b=QUsjw59ZPqpDEV4uKiKsG1Fw6W8Uz6Wkl7j3Je5LYne2xprqRpP47kDq+ehvHAUdfG
         K+TjYa1nHVJP4dooRSKwfH2U4DStntjTFz/GpuCfK6QyZxYeD7o3bFg8F/4UwmVXnRfL
         g5ttqorgmMC3v4qNYTDm73n9EIgC0HT/oYiOJ4cw2H++Uvi1Plb1g992PmCEDyYTHCUl
         lzF6IyIQzC3Z35trFg1pgYYGlQiw5plPUGitzqgjkdRasvR5QgSlU7A0c51qJstaUXLx
         EmAwJrn0h1Mq30/FGKh069EmSODUwoyL8jRgppTxklCJlKbUY09zOo4KqnKLfiPee3yC
         TENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wgmJ6EXhA/y/tOqwdMZZ5+cOrvKrmLtj/CHSmhVjz3A=;
        b=a73DeRiEX4I1g+jWTBUh10L5AdtiNlcG9ViR1MFhJOpLhxNWzWruI74+Ws89qakgKO
         OoVhjkCI7AuX/sIZfkwP2SBJjYMKBN6cPY/j1K2ww4jdZJ6dnqVU4F0q5w8Ejv9CpDyI
         vYzTp2XUVabjBgGeaj2zV6Ut+IKbkupColX9OGojA6kkOXz3Qb7Vm/cmm234ki/h9jyB
         N02V52YWvMoQAcgVhsxF132JDtobF6tfcps7Cm8TYNRxl6pfZpoZ7Q/LUZhsRI9AZg4s
         vjp2d/pFPoLIK1yeBZhx3Vi2P/WgxCPIagYiXqMmrxa2zTXX2CRwraqVItW3WxbQUGAD
         erJA==
X-Gm-Message-State: APzg51DfDW4ivnVDobq6zcmYgfp9+p7lsMLVTAc5gaQCsGLU2aiUZOSt
        L7OGo9bmgAlP6dDfI4KwEag=
X-Google-Smtp-Source: ANB0Vda7ZRs2qJ3GQ+DjK0txUb2VyFHxGuf3EwOPKmnTMB0ouH9M6veweRgXR4A9ZgXFwjgWXamvjQ==
X-Received: by 2002:a0d:c903:: with SMTP id l3-v6mr2571471ywd.404.1536268264278;
        Thu, 06 Sep 2018 14:11:04 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u67-v6sm2032802ywa.56.2018.09.06.14.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:11:03 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 06/12] blkcg: associate a blkg for pages being evicted by swap
Date:   Thu,  6 Sep 2018 17:10:39 -0400
Message-Id: <20180906211045.29055-7-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180906211045.29055-1-dennisszhou@gmail.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

A prior patch in this series added blkg association to bios issued by
cgroups. There are two other paths that we want to attribute work back
to the appropriate cgroup: swap and writeback. Here we modify the way
swap tags bios to include the blkg. Writeback will be tackle in the next
patch.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/bio.c         | 83 ++++++++++++++++++++++++++++++++-------------
 include/linux/bio.h | 11 ++++--
 mm/page_io.c        |  2 +-
 3 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a05997bdb967..6c69c35db8c7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1958,30 +1958,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
 
-#ifdef CONFIG_MEMCG
-/**
- * bio_associate_blkcg_from_page - associate a bio with the page's blkcg
- * @bio: target bio
- * @page: the page to lookup the blkcg from
- *
- * Associate @bio with the blkcg from @page's owning memcg.  This works like
- * every other associate function wrt references.
- */
-int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
-{
-	struct cgroup_subsys_state *blkcg_css;
-
-	if (unlikely(bio->bi_css))
-		return -EBUSY;
-	if (!page->mem_cgroup)
-		return 0;
-	blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
-				     &io_cgrp_subsys);
-	bio->bi_css = blkcg_css;
-	return 0;
-}
-#endif /* CONFIG_MEMCG */
-
 /**
  * bio_associate_blkcg - associate a bio with the specified blkcg
  * @bio: target bio
@@ -2027,6 +2003,65 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 	return 0;
 }
 
+static int __bio_associate_blkg_from_css(struct bio *bio,
+					 struct cgroup_subsys_state *css)
+{
+	struct blkcg_gq *blkg;
+
+	rcu_read_lock();
+
+	blkg = blkg_lookup_create(css_to_blkcg(css), bio->bi_disk->queue);
+
+	rcu_read_unlock();
+
+	return bio_associate_blkg(bio, blkg);
+}
+
+/**
+ * bio_associate_blkg_from_css - associate a bio with a specified css
+ * @bio: target bio
+ * @css: target css
+ *
+ * Associate @bio with the blkg found by combining the css's blkg and the
+ * request_queue of the @bio.  This takes a reference on the css that will
+ * be put upon freeing of @bio.
+ */
+int bio_associate_blkg_from_css(struct bio *bio,
+				struct cgroup_subsys_state *css)
+{
+	css_get(css);
+	bio->bi_css = css;
+	return __bio_associate_blkg_from_css(bio, css);
+}
+EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
+
+#ifdef CONFIG_MEMCG
+/**
+ * bio_associate_blkg_from_page - associate a bio with the page's blkg
+ * @bio: target bio
+ * @page: the page to lookup the blkcg from
+ *
+ * Associate @bio with the blkg from @page's owning memcg and the respective
+ * request_queue.  This works like every other associate function wrt
+ * references.
+ *
+ * Note: this must be called after bio has an associated device.
+ */
+int bio_associate_blkg_from_page(struct bio *bio, struct page *page)
+{
+	struct cgroup_subsys_state *css;
+
+	if (unlikely(bio->bi_css))
+		return -EBUSY;
+	if (!page->mem_cgroup)
+		return 0;
+	css = cgroup_get_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
+	bio->bi_css = css;
+
+	return __bio_associate_blkg_from_css(bio, css);
+}
+#endif /* CONFIG_MEMCG */
+
 /**
  * bio_associate_create_blkg - associate a bio with a blkg from q
  * @q: request_queue where bio is going
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d1435643f5b7..bd8e67c01aa1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -547,21 +547,26 @@ do {						\
 	disk_devt((bio)->bi_disk)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-int bio_associate_blkcg_from_page(struct bio *bio, struct page *page);
+int bio_associate_blkg_from_page(struct bio *bio, struct page *page);
 #else
-static inline int bio_associate_blkcg_from_page(struct bio *bio,
-						struct page *page) {  return 0; }
+static inline int bio_associate_blkg_from_page(struct bio *bio,
+					       struct page *page) { return 0; }
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
+int bio_associate_blkg_from_css(struct bio *bio,
+				struct cgroup_subsys_state *css);
 int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
 void bio_disassociate_task(struct bio *bio);
 void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
 #else	/* CONFIG_BLK_CGROUP */
 static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
+static inline int bio_associate_blkg_from_css(struct bio *bio,
+					      struct cgroup_subsys_state *css)
+{ return 0; }
 static inline int bio_associate_create_blkg(struct request_queue *q,
 					    struct bio *bio) { return 0; }
 static inline void bio_disassociate_task(struct bio *bio) { }
diff --git a/mm/page_io.c b/mm/page_io.c
index aafd19ec1db4..573d3663d846 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,7 +339,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
-	bio_associate_blkcg_from_page(bio, page);
+	bio_associate_blkg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.17.1

