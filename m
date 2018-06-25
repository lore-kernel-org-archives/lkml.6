Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9643BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4A825C56
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="jB7fSr07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4A825C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935016AbeFYPRN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:17:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34618 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934789AbeFYPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:12:52 -0400
Received: by mail-qt0-f196.google.com with SMTP id b20-v6so3009249qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sWOwbpIrK9XPYUY4yEH5tX1tHsTGl4xJAX1+6iwXdZU=;
        b=jB7fSr070T/e0zFuxECRud4VZ+8zDAPRJEb3hS+/Cm34D7/SF1tDfIxisVNmvCi98N
         FlwutMCXmBs4wBN358HgNxbVGvCbUntmJR6/4R3S6Ngl1aaNK2ff/RVpB9zqu7uz+I4Q
         rebUl6lPndZCBaA50iXj7FQ9YMbU9VNlPXJrxT53AAgQ/XqPll29V6zf1A6AZBO9zMbz
         IM3qkQqEq6mu6NxkpACYiBTLNlxuU6EaWfrKxuSnqlm/SGBJkIN1hKFelbdQQqhw7X+r
         F+YGD2lhBmJMRgU0DyZX+1rsidPC3LDUOMrdLvLpllFQvgkjiWDyRSzia+Ya75IEW9o+
         U0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sWOwbpIrK9XPYUY4yEH5tX1tHsTGl4xJAX1+6iwXdZU=;
        b=dK+uaQS1qualoodf8NKVI7VAXggqxdm6I+njL0mTGgdzD6LzhOSZEMJDo7YHROSumN
         1JqjDL+mjG++ErMdEm0h2EbQQ3lwWVc4ncRSC0fKi7hqD9a6lSTUQ4kslmdlsPuHOfuz
         kFOTp1/7hQ36fBHK8EeLVRjB3LScPR9qcd060/9FjViNHNmiRMhtKVBp+2+dc83u3F/5
         pkoO/oyUsIu5Yom++DOwpHirOOzEhdJ6urXrDdnz0qp/oTjxEuPK1LynswqEV8MEu2WV
         dDk/B9twPZQrMJJhBTZHS3aiZhvjzkUeL/8Oq0u2Y2sm+Y9UDQK3WvIskj1tPox3NKW0
         5cog==
X-Gm-Message-State: APt69E1vpwrzQYFc1atI2cwPg9UBp7Dkyo5kXdgcNU7AcEvV3EvLA/iL
        gu5qNvmjCSaQLqXNylzpErQSSA==
X-Google-Smtp-Source: AAOMgpe2d+/Ghp1LBzUVajrorN9niV1WexKuHUqjRId7Oa7vuRQRyGo6rkmcHF9NfuYWxgORg119pA==
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr11152738qta.83.1529939571778;
        Mon, 25 Jun 2018 08:12:51 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a197-v6sm6383888qkb.67.2018.06.25.08.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:12:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/15] blk: introduce REQ_SWAP
Date:   Mon, 25 Jun 2018 11:12:32 -0400
Message-Id: <20180625151243.2132-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625151243.2132-1-josef@toxicpanda.com>
References: <20180625151243.2132-1-josef@toxicpanda.com>
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

