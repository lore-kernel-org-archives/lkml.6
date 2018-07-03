Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F321A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="UneJiFCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F321A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbeGCPTT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:19:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36314 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933986AbeGCPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:15:12 -0400
Received: by mail-qt0-f196.google.com with SMTP id f1-v6so1870032qti.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvnAokgK4iqwm/rj6v3ejnikhDRvUCn1RQ4MZFK+fOU=;
        b=UneJiFCSgllHfNoq3SBSWbxqlsCTGD7Vq1q/HnoyhX1Rj8Rw3h4kcfnnVJVa3x+OUG
         h3O5AMRTc8mA4GMtig3ViBH7TUbmug9fAX8wFJEbBTGmYB93Wzerd6O9lAYVGSA9kxSj
         C1irkQOWVI5gywjo6XBkyhvZMQa9i/NI2OPgTK8r50d97W2PlXoMgQYfg9SdlHB0js9E
         ykvd3TKAQOUDlNxHxfMnjEM7Jo18Z+eY+Kfh66E+SrNL4xQOPoYJ1otSRBf7Xhl9vcEi
         sRvz0+21IaQl6HruhZ93VScGriGepDoqPCo0DNqyxGKoYb94DKo+ju18JwH8c/73c2gu
         vo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvnAokgK4iqwm/rj6v3ejnikhDRvUCn1RQ4MZFK+fOU=;
        b=c0GMLzFELB+LLlz1oyCLQZHOj0fbs4aE020J/JxtEVKDJViAh7i7b7kxdc9t6pqgB2
         cOHeEQxQuP6ND7mDfuOH+CF2Yo8iBr1jm2Q+vGhPZCGv3N4wM12+zFJ+MthgNC4N8NCT
         1uz4AywgaAj985Nhn9KpfY0YcnDSduUSi4ZV9kfk3HxpZNSwb0j8MqNeevgjLkmwAEaB
         ph8UoAgsCjx1x+OaviFWIgjWmGz+yFatjPfm9Xaqr8gXu3vaCVUgU+zRAGtjjCQ/SrY2
         +tx5FQXpUlIjVMmUi/+PNbkokqCtUSONDJCdw0XTHeT/bNGRHUct3YoGEAzimmNAjUrx
         o6/A==
X-Gm-Message-State: APt69E1OQRxrfl2LrvZw2zQnm/nazg79OsKCyYon2IKa4byDsdayFALe
        6y2zZnt+vq/4u/ZIcSvNnFKjKg==
X-Google-Smtp-Source: AAOMgpdViDv2aD+Zcf0Q7Y4Gpw8vcBZXufmeYIXNw2r27ZfT0T1n18INllGIqDb0UehlIgfsyl+h7A==
X-Received: by 2002:a0c:98a7:: with SMTP id f36-v6mr26671142qvd.81.1530630912181;
        Tue, 03 Jul 2018 08:15:12 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1043619qth.10.2018.07.03.08.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:15:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/14] blk: introduce REQ_SWAP
Date:   Tue,  3 Jul 2018 11:14:53 -0400
Message-Id: <20180703151503.2549-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Just like REQ_META, it's important to know the IO coming down is swap
in order to guard against potential IO priority inversion issues with
cgroups.  Add REQ_SWAP and use it for all swap IO, and add it to our
bio_issue_as_root_blkg helper.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 2 +-
 include/linux/blk_types.h  | 3 ++-
 mm/page_io.c               | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b41292726c0f..a8f9ba8f33a4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -254,7 +254,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
  */
 static inline bool bio_issue_as_root_blkg(struct bio *bio)
 {
-	return (bio->bi_opf & REQ_META);
+	return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
 }
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3364d42ebe08..0ffc34c5cc83 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -329,7 +329,7 @@ enum req_flag_bits {
 
 	/* for driver use */
 	__REQ_DRV,
-
+	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -351,6 +351,7 @@ enum req_flag_bits {
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
+#define REQ_SWAP		(1ULL << __REQ_SWAP)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/mm/page_io.c b/mm/page_io.c
index b41cf9644585..a552cb37e220 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -338,7 +338,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		ret = -ENOMEM;
 		goto out;
 	}
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3

