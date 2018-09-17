Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F06ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D55E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="CJs15299"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D55E2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIRBkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37102 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeIRBkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id f17-v6so9734443qkh.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGYyVedwO3w6KnNhLC98dG+SgDExz6zEusY6F4HPlCE=;
        b=CJs15299ukjfn6R2Z8XW4Q/QWKpiLJauHDS5nb6/Yo+VM3mXC5P9DXAAYIayUu0Ib2
         Cc33W8jZ6ld3aoJW0l506vzcHBPHg40YNKeOBDah/L5amz73/gPFAWtHpixavz+Vkfr/
         aWQYXRJCNOkTDe9sSDtviKOx3HWOlv6/qKqqq8mc8vTz+QgZ/nGZjT2cn6E+Ym6+zXC8
         jQ5eawPA30cTNEDBbbNbadPd8AEA132V0tvPFPeVqBXKrPCISzo46L0QLYWYa3Ek6Epn
         0/+C/0B4BLQskee4xXFNkZ5RmyUC9Fvh9OWlJvXEjya9lDSm4zTIEC4GnJbkDXXVfF/r
         ChBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGYyVedwO3w6KnNhLC98dG+SgDExz6zEusY6F4HPlCE=;
        b=of7cq6hLwTYlXUP+ygBb8p6mSduBYNkyHrPUN5d9tNnpV1B3a/emo/snmG5PRg87Y2
         q3aGtw29flUnxGYF1SSe3avlVpPvXf8dwkbyWVKwgJ2iveDxKq0p2GUppiPZsLhwX7FZ
         lNiZFV0KACScTQ0rRwToBPKMiGxEPYVzh3x0Ors3uoCRuoGFb3rGzUq3GxbQR951ekgA
         6px98UhKu/fxnOt9IuXfuWpTWYzDJH1vqkvKnBNd6Tzylx8vvcFWw1GPgW6h1q2fQAv4
         go8aePDPNqTcg087iorfMV++WrK/X/mrHYMWpUlMob5x3yqGp20+587kHJ+p/5W5BEPj
         yULA==
X-Gm-Message-State: APzg51CB92OwhpeOkMpLBbklDRS6IFHJ5bzOxsSYwk+UBCHIMlzAmmnR
        kOaSNGwgkrs0gIfDjt0Tf81jhfOWjV6C1j4a
X-Google-Smtp-Source: ANB0VdZ1UdVIw/JZvL/nI1VlCyqpLS9/L2Qkt7fKnKna39YMn/hiHwMFrW+KxSQmnX8HgMVjMvDJKQ==
X-Received: by 2002:a37:d402:: with SMTP id l2-v6mr17993045qki.86.1537215081014;
        Mon, 17 Sep 2018 13:11:21 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:20 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 10/17] orangefs: service ops done for writeback are not killable
Date:   Mon, 17 Sep 2018 20:10:47 +0000
Message-Id: <20180917201054.3530-11-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/orangefs-kernel.h |  1 +
 fs/orangefs/orangefs-utils.c  |  2 +-
 fs/orangefs/waitqueue.c       | 18 ++++++++++--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 9fe60d086e2d..cdb08e51a4b1 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -441,6 +441,7 @@ extern const struct dentry_operations orangefs_dentry_operations;
 #define ORANGEFS_OP_CANCELLATION  4   /* this is a cancellation */
 #define ORANGEFS_OP_NO_MUTEX      8   /* don't acquire request_mutex */
 #define ORANGEFS_OP_ASYNC         16  /* Queue it, but don't wait */
+#define ORANGEFS_OP_WRITEBACK     32
 
 int service_operation(struct orangefs_kernel_op_s *op,
 		      const char *op_name,
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index a4fac527f85d..9221c4a3398e 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -430,7 +430,7 @@ int orangefs_inode_setattr(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 
 	ret = service_operation(new_op, __func__,
-	    get_interruptible_flag(inode));
+	    get_interruptible_flag(inode) | ORANGEFS_OP_WRITEBACK);
 	gossip_debug(GOSSIP_UTILS_DEBUG,
 	    "orangefs_inode_setattr: returning %d\n", ret);
 	if (ret)
diff --git a/fs/orangefs/waitqueue.c b/fs/orangefs/waitqueue.c
index 0729d2645d6a..beafc33d57be 100644
--- a/fs/orangefs/waitqueue.c
+++ b/fs/orangefs/waitqueue.c
@@ -19,7 +19,7 @@
 
 static int wait_for_matching_downcall(struct orangefs_kernel_op_s *op,
 		long timeout,
-		bool interruptible)
+		int flags)
 			__acquires(op->lock);
 static void orangefs_clean_up_interrupted_operation(struct orangefs_kernel_op_s *op)
 	__releases(op->lock);
@@ -143,9 +143,7 @@ int service_operation(struct orangefs_kernel_op_s *op,
 	if (!(flags & ORANGEFS_OP_NO_MUTEX))
 		mutex_unlock(&orangefs_request_mutex);
 
-	ret = wait_for_matching_downcall(op, timeout,
-					 flags & ORANGEFS_OP_INTERRUPTIBLE);
-
+	ret = wait_for_matching_downcall(op, timeout, flags);
 	gossip_debug(GOSSIP_WAIT_DEBUG,
 		     "%s: wait_for_matching_downcall returned %d for %p\n",
 		     __func__,
@@ -319,10 +317,12 @@ static void
  */
 static int wait_for_matching_downcall(struct orangefs_kernel_op_s *op,
 		long timeout,
-		bool interruptible)
+		int flags)
 			__acquires(op->lock)
 {
 	long n;
+	int writeback = flags & ORANGEFS_OP_WRITEBACK,
+	    interruptible = flags & ORANGEFS_OP_INTERRUPTIBLE;
 
 	/*
 	 * There's a "schedule_timeout" inside of these wait
@@ -330,10 +330,12 @@ static int wait_for_matching_downcall(struct orangefs_kernel_op_s *op,
 	 * user process that needs something done and is being
 	 * manipulated by the client-core process.
 	 */
-	if (interruptible)
+	if (writeback)
+		n = wait_for_completion_io_timeout(&op->waitq, timeout);
+	else if (!writeback && interruptible)
 		n = wait_for_completion_interruptible_timeout(&op->waitq,
-							      timeout);
-	else
+								      timeout);
+	else /* !writeback && !interruptible but compiler complains */
 		n = wait_for_completion_killable_timeout(&op->waitq, timeout);
 
 	spin_lock(&op->lock);
-- 
2.19.0

