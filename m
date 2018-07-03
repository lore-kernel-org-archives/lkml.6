Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43240C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EF3208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wAkgEA/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EF3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934110AbeGCPPX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:15:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41907 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934052AbeGCPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so1863955qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=oSxJY9mwciDlY+E9u4mBJG+KFwRc/m0dXBd2CisLtoA=;
        b=wAkgEA/nr+ah21G4REFDCubB0hqNngKs74q75b1ct+Y9QXJZh1o25LXM1++oHxqn12
         rZDOREnq7CaN9jXTnmmczZMWlm8N/drxJZ0QQm10RMMwSx/yAhbsneyijjRYc4CuXKtF
         i66GRwLQ1qdVUX9HoQygpZj8tn6Gji74E69PUpasvHXLKFWKMhuR2T06ML+0ClGRZjHq
         w8Y8dMv71Bp1Vve3eXR11W6j1ZWcT9MKxvhQxt8qW9M/RG17le600/F+T7JPDgfV59M7
         k5UN27p+gKFzCVAR1dNLNMttivJw29zuiuybSbCKiPpzZRpNTqTR29eCKW0/TtnisxsR
         /eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=oSxJY9mwciDlY+E9u4mBJG+KFwRc/m0dXBd2CisLtoA=;
        b=FosHIFeGAkhV7wgHt9Z1ipVGlF1tJ/3HQmTZqgJwcnKtXUWY5TM//1f/XiZoJ98GPS
         WCEciDpzxXsSMq94SSwQJx7w1rJGoFO24Lr8OcW1wTcCvd4+mrjePE+hGD5fbv+Z979G
         xaLXv/vu2VkMpJvmJf35xUDKLfB/2iV7MWK73hyH3CLphSbWZUPdUzNhZWmyFgxEPF2B
         hZwAgRdQrqtt6eNPMV+hWcicU8AlZMfHeUQefVQ+7XBG4rmEe0atdbKHV8FBu73i5nEN
         0FTCjjqL2R3YZRzBj70A0oNvO4j24vU8YQXFfE45NOxWh/DT6u25EP1D8yj+TmQnop7G
         T+dQ==
X-Gm-Message-State: APt69E3hdEwH0XjX/+CXxjgNJpzeWxXw8ZVzKkd9jkLuFAZvJV1rl1GQ
        V6RFtKJVcyo2nMt7xB6qoL53qw==
X-Google-Smtp-Source: AAOMgpeFY3I63tE6ogi2tzBRByKLOJFZ0YeTzxoiCAcmcsMbHrRniVfpjO/HVwsdaXatNLrkqM9r+g==
X-Received: by 2002:ac8:16a5:: with SMTP id r34-v6mr27606011qtj.62.1530630914109;
        Tue, 03 Jul 2018 08:15:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r62-v6sm934381qkl.85.2018.07.03.08.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate context
Date:   Tue,  3 Jul 2018 11:14:54 -0400
Message-Id: <20180703151503.2549-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
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
cked-by: Andrew Morton <akpm@linux-foundation.org>
---
 block/bio.c         | 24 ++++++++++++++++++++++++
 include/linux/bio.h |  7 +++++++
 mm/page_io.c        |  1 +
 3 files changed, 32 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c9072a54395e..e09f3626ab5b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2015,6 +2015,30 @@ EXPORT_SYMBOL(bioset_init_from_src);
 
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
index a279ba384da9..a00dfff51aa5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -553,6 +553,13 @@ do {						\
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

