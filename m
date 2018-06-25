Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA34C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631F225C50
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="bL2P2gsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631F225C50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934986AbeFYPQx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:16:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37989 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934795AbeFYPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:12:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id c5-v6so1453429qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bxA6cMGXvEe6N+gMDPkoHZMx5A3XRvMVyzrtT6Xehm8=;
        b=bL2P2gsrGxX12siwe4K0SsVcvczf7UXtTMEMIFRmceMxqv1VLJLEn20gcqnkgXWlTD
         RVwnlUHvVOUkUv89AcI9RfmTcywmr2YrnEMhwfRQNZy6NSCFzo9vCOjEiyiN9JCpVpLi
         j9BuhdH7HZoSoWGkm0N1knelelaBlxTYpqSud5tlmnnUG7L7lG5hn4pXbWKhz48AHb1O
         G/vHJ7BBREPCYT1Xni0Dos2EK7WuGMfE6cItNn0uQ5+RV/8A+dw+9joh4MeFIvP33J+g
         JIKo5R4kQWaHCS08TpvzwAopZ41/QoVS/YSHSPQa90NNcGkKKZ9giM/RuL8zQU8RPRSg
         xN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bxA6cMGXvEe6N+gMDPkoHZMx5A3XRvMVyzrtT6Xehm8=;
        b=FdFkCBzNBcfiGcpAb33+41BkV7dVL/Fv8V/ybqmPm76QRRbedKba+wXfRnktsne02W
         YiPpS7mmx7xkP+NlgChtj1SgyxERz/PRop/ufqon0yoyFBxWR4HXgYEp3wmVqP+SubAL
         c42bUAyJZ3TOay47dAmelaSl9JJUZL4Q411+aQFG39rbC6m16+taYGTwFrOScK1hnC6u
         oAEiHON/nl/LOADhNOBGDTKl0HOzI7A7uFFCSYJD+lUq+Lv+ohWXWuqD4QQvOHAAQmr6
         gx4Wj6cEPdT7zfxnZysBi9LxMleApl4VrhVi+XySkytGvyeomJBm3FvFlrOusO/o07XK
         1ODw==
X-Gm-Message-State: APt69E3zPqPVnDlyuAIdCZxfnjO+NJK3waD50ACYlo/uSU3WZnwjVlWV
        K9gKdagN7n9D+EuXtaniFtJO9w==
X-Google-Smtp-Source: AAOMgpeUwDBmm0RnQv57OStma35Ssd3jFAaopmuBrN29kbzEVlHr1DGi+5eHejAypMxyGTCQqhD0oA==
X-Received: by 2002:ac8:43ce:: with SMTP id w14-v6mr11232762qtn.137.1529939573290;
        Mon, 25 Jun 2018 08:12:53 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p13-v6sm240888qki.12.2018.06.25.08.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:12:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/15] swap,blkcg: issue swap io with the appropriate context
Date:   Mon, 25 Jun 2018 11:12:33 -0400
Message-Id: <20180625151243.2132-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
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

