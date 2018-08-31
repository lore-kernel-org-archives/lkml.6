Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1735C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AD92082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtgK3CJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AD92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHaF71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:27 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:41769 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeHaF7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:25 -0400
Received: by mail-yw1-f45.google.com with SMTP id q129-v6so4522223ywg.8;
        Thu, 30 Aug 2018 18:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q26zPLlJMQz/P301NVTgMQxmRy+StVgpKtoXVBZh7MI=;
        b=PtgK3CJMnoDN7zWMlDBQxMoVWliItSylMvpCKSvlGSbiuysVpyqMCBH/XW/ohrHEkl
         3DPwIoDnslddba9uYsyueNq8BRxRNqenC7BueMnyplS70xQEk4QBGmqmJo77TKuZyAr/
         ZMsSnW5G0WseF5ihvX1diwxlMYKBwXq8XRMvlnEmzHQ7o0vcfq1f6/qCx9bbHMP2MW9v
         jckVawYKvAhtLRi/b0vqRgoO5IFtd5iXwSAPKEwnAO0vnysFdAej54zyjSBOVFwgXEXF
         KIDbpwQG+Df3NoSmi7OK2DaSASWSRKyX1WmUW/5blYsp9PAe8rjR0ofaggAUOXno0CpV
         1Yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q26zPLlJMQz/P301NVTgMQxmRy+StVgpKtoXVBZh7MI=;
        b=UoYa7SWcQKKEvpzuWd8/gSdX1wRZ8M1IHwf19c6/WQf/Kzm75BZk7+h4i+fYMBLwUk
         x2VDgo5UScEVkqOabFi0KjjXtxXibPL7sfodzXljnowI3J1pGhD6wjfbHh8jXywiWYeL
         udNpWHKgM64XG/loVgif3VL94U7zmzoCuXoa8BP3SCsnhEQVpP1A4RyjcD1vWUdl9H5Q
         NYrsFWj6cD9soJBZYocCZAGFMMJkysSMzkfHEhlynfptHU/pw0OmDkhTAAaQWx+tSSPM
         hfXTMoOLbbieTypXKLM0IaUzG5HGIpZgtcPA00xgTpQ1ef1EDKwAbqQovkz3pftPYQFT
         dAmQ==
X-Gm-Message-State: APzg51CGYhgWmztC2RR3/UVjyJNXzcjigKgdz4jHM7mlpcJei7lgU2qP
        q9O3c978Yix7z8PJS8wLnns=
X-Google-Smtp-Source: ANB0VdbX55aienlN1y7d9dxpG1kNy5lu4AECgnl9aAp3kZXAz8mGH8qe6kBfuRDlGaSmemc9TAwQcQ==
X-Received: by 2002:a81:2c07:: with SMTP id s7-v6mr5011609yws.302.1535680462639;
        Thu, 30 Aug 2018 18:54:22 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:22 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 08/15] blkcg: associate a blkg for pages being evicted by swap
Date:   Thu, 30 Aug 2018 21:53:49 -0400
Message-Id: <20180831015356.69796-9-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
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
---
 block/bio.c         | 83 ++++++++++++++++++++++++++++++++-------------
 include/linux/bio.h | 11 ++++--
 mm/page_io.c        |  2 +-
 3 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ab41f5b7eb1f..97ef994a08b6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1930,30 +1930,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
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
@@ -2001,6 +1977,65 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
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
index d4626108b9d7..81530d11d34d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -547,15 +547,17 @@ do {						\
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
@@ -564,6 +566,9 @@ static inline int bio_associate_blkcg(struct bio *bio,
 			struct cgroup_subsys_state *blkcg_css) { return 0; }
 static inline int bio_associate_blkg(struct bio *bio,
 				     struct blkcg_gq *blkg) { return 0; }
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

