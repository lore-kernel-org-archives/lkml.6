Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E9C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166ED25D31
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Ee3iv0A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166ED25D31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966288AbeF0TKI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:10:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35707 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965269AbeF0TJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:51 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so2638818qti.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bxA6cMGXvEe6N+gMDPkoHZMx5A3XRvMVyzrtT6Xehm8=;
        b=Ee3iv0A2vwt6tjAvoeTSBp/LJm5unNt/ZMaoIK32wUShvaCQpHSIttfuevPkQeusA9
         ie9q8bm581Xxy+ppauS1x08gdOFxvJv0MoU+N3WmpKGwwuGq1rf9lRwTUoWawUTF6mcl
         +tpEdIS4fVD3PPUj9RbIS5v0FIYMf0r4Bsc5dB37UF0qPSBta0MLG1sTGv7jObZ0LVyG
         o3iw5eQokSmmRIWYjg8+he77Ug5YeJlqw7Rk8lrbnT/PRl4FxWjIkgsvIzztQcWZrdai
         uPAwnsBWgtX5+vpkiAUOn+yGW/93Aqi1mVK+6ee5IFIr5LXCg67qIvtWtOiLyPOi83OB
         Zouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bxA6cMGXvEe6N+gMDPkoHZMx5A3XRvMVyzrtT6Xehm8=;
        b=KpRrBa2BrrGTEcps4xrTcUPBl9TDytmbJC9MxKO2hVJQzZ9z9v96bsluvDRLDqG8he
         rcPFLtblO0L4ADc55Rbg7GYkA4oPV4DjXkXy7vV9u5UySZBXDSCTqJNbLYrkEeD23Cvf
         LYUwTpaHwL+JDiFelylKcYFoTpZ3vrqX2Dc/pMEySVLclLIKeKkAdsaDgzXSLzqd0nND
         deaV6Ifbs+8UfL/Y+r343oczdN/wD0DOBXG6/g3Q6PHb8pAhQd8JSnQ5QnDXIj++8Mud
         4zPCC9k5Ezqm6s3uhYse/foZc1hjtyzdGFdIOk2zUOZe97VQZArdZC4d3S0zvrgAE5L2
         kFMQ==
X-Gm-Message-State: APt69E0wFv2KCTTWDu2cPOW5B8D2TXBW74sDfkMjBx44qEI7zO9HZg6I
        LmR4Jh0ArEzT+vCUjlT3x/nb4w==
X-Google-Smtp-Source: AAOMgpdYkGsTzYHP1GX6ogvZx6Me8KZXfVBbCMty7A+16gKYdUI94DrzUunMxFk0ArNtBSB749JLVw==
X-Received: by 2002:a0c:99df:: with SMTP id y31-v6mr6553526qve.156.1530126591041;
        Wed, 27 Jun 2018 12:09:51 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n21-v6sm4606075qkl.34.2018.06.27.12.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate context
Date:   Wed, 27 Jun 2018 15:09:31 -0400
Message-Id: <20180627190940.4696-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

For backcharging we need to know who the page belongs to when swapping
it out.  We don't worry about things that do ->rw_page (zram etc) at the
moment, we're only worried about pages that actually go to a block
device.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/bio.c         | 24 ++++++++++++++++++++++++
 include/linux/bio.h |  7 +++++++
 mm/page_io.c        |  1 +
 3 files changed, 32 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 57c4b1986e76..c77fe1b4caa8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2005,6 +2005,30 @@ EXPORT_SYMBOL(bioset_create);
 
 #ifdef CONFIG_BLK_CGROUP
 
+#ifdef CONFIG_MEMCG
+/**
+ * bio_associate_blkcg_from_page - associate a bio with the page's blkcg
+ * @bio: target bio
+ * @page: the page to lookup the blkcg from
+ *
+ * Associate @bio with the blkcg from @page's owning memcg.  This works like
+ * every other associate function wrt references.
+ */
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
+{
+	struct cgroup_subsys_state *blkcg_css;
+
+	if (unlikely(bio->bi_css))
+		return -EBUSY;
+	if (!page->mem_cgroup)
+		return 0;
+	blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
+				     &io_cgrp_subsys);
+	bio->bi_css = blkcg_css;
+	return 0;
+}
+#endif /* CONFIG_MEMCG */
+
 /**
  * bio_associate_blkcg - associate a bio with the specified blkcg
  * @bio: target bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f2f3f1428e81..eef1e8877048 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -545,6 +545,13 @@ do {						\
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_disk)
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page);
+#else
+static inline int bio_associate_blkcg_from_page(struct bio *bio,
+						struct page *page) {  return 0; }
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
diff --git a/mm/page_io.c b/mm/page_io.c
index a552cb37e220..aafd19ec1db4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,6 +339,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
+	bio_associate_blkcg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3

