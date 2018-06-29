Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BEDC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136C82577A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="IgEUcjjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136C82577A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936929AbeF2T2l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:28:41 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44568 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934805AbeF2TZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:25:51 -0400
Received: by mail-qk0-f193.google.com with SMTP id i188-v6so5550094qkc.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWOwbpIrK9XPYUY4yEH5tX1tHsTGl4xJAX1+6iwXdZU=;
        b=IgEUcjjG8m/nHxptQa4T5DqguJCKB/FAHQDgPwnmvfmtuSR1cY9RL0+N/Hoj7YmRkO
         ZjK9OjhH50K/1k2v1miUxx0mM4MS7UPaMunWhdbLXWom8TWftkkQCkuc1hkMRmzQzQWm
         PqndHzJ2gSEmvyTiFuQhGEfA18q8E1sFxHdLNbBSOMAmSn4pRlQNyw5G7VXLuwkSv+1W
         GIBB2BGUmnWgrE3Jbc2Zuwpk8MKr1UloWbcOlLlMWd+hH8nkR4Zy12UwWprPYWzgQSgo
         Qv7iCiKem18njra5jjVRAFmRr6pW/gVbPJQ17cYF3DL4+uVMZox6/jxAo0HUlXJLis91
         JYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWOwbpIrK9XPYUY4yEH5tX1tHsTGl4xJAX1+6iwXdZU=;
        b=WNCWYLBi7ZT3JipRybtFpiV+TGsvNYsimq1uJGavcpmQATaP3k72rvsk7DnoU4yTV+
         8mJ1Ff3QdeR32j0giP/o3o4D2QTG8EmcbM+PnjWGUtAhibTyXB9pzF+s0rhlMjfrGBF0
         ld21kzTal4gG+beymNMGQZ1ro/WIUnzdqu9EK/pZcaKZj9c8tR6CLuU0Vj+3QJfeSR/M
         vaKkSW1KoIK5Qq7oUFltoedCu0oq1oJqZBzon4x3EdIrsxB08yIb2jy7hR0Nd8WPbvDK
         mcORYlZClDTt98htZ8feGTXr/L/ghXBmhkhENGBSyUaDpfPRajYA979RSQOqViQBe7/4
         uS3Q==
X-Gm-Message-State: APt69E3wkQWQDeapwboumArLj9RtstlTze/guNqFS48KsgAFUKsrzhvD
        CP94mw9eu9GMVl+HZbIUDgA85rfgAxA=
X-Google-Smtp-Source: AAOMgpcz8rHYaON0DoYuAoTIR4aMT6TXuSunTZDdVR3rRTthKPoYd3JwZaljKyAPAUAtV8sGhBlFJA==
X-Received: by 2002:a37:b281:: with SMTP id b123-v6mr13471761qkf.377.1530300350814;
        Fri, 29 Jun 2018 12:25:50 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b188-v6sm6503276qkf.71.2018.06.29.12.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:25:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/14] blk: introduce REQ_SWAP
Date:   Fri, 29 Jun 2018 15:25:32 -0400
Message-Id: <20180629192542.26649-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180629192542.26649-1-josef@toxicpanda.com>
References: <20180629192542.26649-1-josef@toxicpanda.com>
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
index ff181df8c195..4f7ba397d37d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -327,7 +327,7 @@ enum req_flag_bits {
 
 	/* for driver use */
 	__REQ_DRV,
-
+	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -349,6 +349,7 @@ enum req_flag_bits {
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

