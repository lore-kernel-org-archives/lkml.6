Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05541C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD892087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUYAewH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD892087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIKXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:43:20 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:37300 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIKXmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:25 -0400
Received: by mail-yb1-f169.google.com with SMTP id f145-v6so9731542ybg.4;
        Tue, 11 Sep 2018 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wxEqMCKwjjKDgqsi2Aa/uNaLSYyWsKKaIQb8WIwFgtw=;
        b=vUYAewH7ZEmPcMGBMl4qTvyNbL8xLHId0YuiBzMs1dGoIRoAqw5SqDK51+j3O7HfEH
         J7Ul9kqlzE9AJ3tgMNzaEgVALdpfYoTPQcLwh0jq2vq3FhkaIPmc6uyD6j81H92MnD33
         xmLz9j9VZJKJeDD1l9XJxTbWrIbZ6ZrplKu+Rr0/+h8lkqNWG8tsE85o7cmUHqSpUnsQ
         4Z7MzxBDRbWgU2hymPl6U7jxLvAQNMqjLomw1edZaXtjCNvRw0lrep/Xy+s3tVyA+bNG
         D/DAApaFbFncIEc3Bx/pcuhmRWlLTj2/w2aYjqthid4cUAYx+hqIWk1BIFrHJwp+BAyj
         Ff7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wxEqMCKwjjKDgqsi2Aa/uNaLSYyWsKKaIQb8WIwFgtw=;
        b=EVmQPF5PO1sW6z/CtXSp68XvUwS5emacDhyZI8p8e5OvOzXfUQ7UYJUNIqr4/TZJRp
         NwOiy6/AjF1aiMP4aMSsmH7ll9bTdI+o35I1VTHbfw7+5/EVp7rqkNIYcwknuc+o5ilu
         G0F6SboPB2pGja2sc2d9m0tACP14Dit9P5cY+XimTNYDN/QOpWV+QdN8UZDLM70JqeUg
         3Yw+yfPMrgRoCPmR9mXqBEQMMNtrGCDun6X8zKRD+/rpMVforDBW54rCVxPQhYgbAVcX
         A8wzaFGww8q5ehRMIVyKTqlIfamPoFn3giBC/w7Wa9xYPbY0k87maL/4N9DrCXzoHi7I
         oHUg==
X-Gm-Message-State: APzg51D/vVIBeD1k+MLXZiq+kOsBocxTrGa6TswEgCepqVsD+27x8SXw
        8QMUGsbvMAQjXXPWJAxOENU=
X-Google-Smtp-Source: ANB0VdY0tqdgpSu3HPtCDngUPBSSlsETMQgYvgEQg2kPo4gI5Kww+xxveKlCywE72r7BQuyX2YlMpg==
X-Received: by 2002:a25:2c03:: with SMTP id s3-v6mr13061628ybs.378.1536691309818;
        Tue, 11 Sep 2018 11:41:49 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:49 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 06/12] blkcg: associate a blkg for pages being evicted by swap
Date:   Tue, 11 Sep 2018 14:41:31 -0400
Message-Id: <20180911184137.35897-7-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
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
index 1d28d7ad2342..897c8ed9e572 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1957,30 +1957,6 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
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
@@ -2031,6 +2007,65 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
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
index 829cd0bb407d..c73a870ebc0e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -533,21 +533,26 @@ do {						\
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

