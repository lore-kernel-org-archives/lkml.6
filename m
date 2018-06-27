Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D84FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2903F25C85
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nbRJyDLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2903F25C85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966439AbeF0TNy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:13:54 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46912 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934985AbeF0TJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:50 -0400
Received: by mail-qk0-f195.google.com with SMTP id o2-v6so1647365qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWOwbpIrK9XPYUY4yEH5tX1tHsTGl4xJAX1+6iwXdZU=;
        b=nbRJyDLumgeP/1WsbHEh1Olz6qoLNAqJsKESPZX7Dc7oqLGQmg5jF9CqnTpc+t4GoO
         +d2MtcOO49CbOHcnp1rbyfIpTO3xMmNxFjLBzPsSb6eiqO4b3UeG7AfrI8ngkm40UaKc
         9ZOSm7DQgPnzDlmG3l8OFshFjYOnolDIccPxBof0HAENcWyaXeRlXgk+TX9NK78rsedp
         yTuXAe4ioR+8VLoWIIa19h3rDwimr99K/jYVUjSaCSfGxhBk7aoQseIVVX0V631fcBvE
         pjHz0IySqXDoT77PMGE8B7Pw5+xky7YHR4u6Q9SHC/8HFYRpSby+HtZCefkI4ZIj0RfH
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWOwbpIrK9XPYUY4yEH5tX1tHsTGl4xJAX1+6iwXdZU=;
        b=TUwH4/KvcQzU2H4A10NFMDrf/P3K52v/OKZoacff/uDLeE+XBRM8S9qQWCK41F27No
         RGDhKVzwJCSdfDnuEK4mq1Rrh+Dq7U8VA0tKB2qRWNalszwlA/9JvO+/Tcr+PFbsW8eA
         vGNfpYbTXL2RkROMaPGnERf1AJrtGJX+zZD8ijQrj53oW7n6AKVzDp1A/tsKUinj3/Y2
         oQCoNXoF9BHb8oB6uKTLwFKI2nH/44Nz9bUjUr3L6BEfXKTzE2TvqwRFaXGLW3KSY7ve
         ELuJug8wwY9ELQTnpjcPWkYROTn69Mp7XlSThNrEJ4ofMRCCBFBr6zz7Pg/Hn0w07CMH
         a41w==
X-Gm-Message-State: APt69E3xqtwY14DBpF/5Ixcsa0xPFSoHVYLX99K2iAAZikvbCzzTDqGo
        JGJ7JzscAQIMyiYNgO+FOGNMPg==
X-Google-Smtp-Source: AAOMgpeBm93UBrlKhz1eNvInyIkOU9jyPMXGPnrljXvIVEnUqDlKuf/tK/lUXGaE5ffQeU3tJ8arDA==
X-Received: by 2002:a37:4f10:: with SMTP id d16-v6mr6347909qkb.323.1530126589706;
        Wed, 27 Jun 2018 12:09:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b14-v6sm3026210qtp.26.2018.06.27.12.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/14] blk: introduce REQ_SWAP
Date:   Wed, 27 Jun 2018 15:09:30 -0400
Message-Id: <20180627190940.4696-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
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

