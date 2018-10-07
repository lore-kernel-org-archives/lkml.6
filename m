Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC87C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098E82087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="tEHcIO7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098E82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeJHGhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43013 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeJHGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id 12-v6so4211955qkj.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGYyVedwO3w6KnNhLC98dG+SgDExz6zEusY6F4HPlCE=;
        b=tEHcIO7n2j/0dlyy9yWr4H8XGcndtbl7u0NjzrTcQIgM14NJLGPCduDm87AerokqL6
         wioti9rNkC22iCzlOzh8eGvRKmPJ79J6C+00xHz6N0bBY7FuA7UwHvGzahJnRgXQZc0Y
         QMulUasJVmgZRr9gLGO46/fuhRPri3LR0ULnxCQsilzqf8FJTduBkTuejUcLvsV/Fcy7
         qVJljNy5xdyx3R8L3PIJz3KmSYKYqwNJu2QQqfnSS4zEl0fTwwm6H0eIE56oY9epombK
         xbu0dWuuozAIJCRVCmYF0f3Izn1R5cHJAe2uS9ZHfW0mUNtb5PKUmSrxVH7EAKvLutd6
         2I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGYyVedwO3w6KnNhLC98dG+SgDExz6zEusY6F4HPlCE=;
        b=uWMC/usKMn6tdDY0zUp0hjnM1hTxBvzeZ45YTEQNnM0+PWT5SaJDe7RNkp74O3cZY1
         UjMNGCCwWnbt/x39pVeh2ZDMzTlqExpMagifMseTwvg2/RG2QiQB6j+xTTruSQqBIbms
         6izmzVYGwP8gSDZi0UAQYPeirJU+3VDZvMOQDJ0DkOTZ+SneguSyHYCXFFhvXyjBjij+
         F/UhRXThYMua3kgYzC9ppNg5MQOcQBqz4UKNq+2ES7E6cQHYhEuoqmGFQhhiwckHxZYa
         kqTvNegTLBOip0DEDwJpbKqe3yY2uUvbOY1LTQpOwKOq+HBrzt/GbJ8Wtc56LzfQXqbz
         BbfA==
X-Gm-Message-State: ABuFfoiAerjci48zG+FvgV+9eFgasjKXLQcF7gI8hC1+OhhrWDzWOi6p
        CAU6ps3nkzHWd9IeIsEOj98vyA==
X-Google-Smtp-Source: ACcGV61mL3r3mo4mOuGzYkFbPl8YcHsnTF8VL5OqTmTU4GY14KYGPLFVDgJ4ghTYcGKREJ8/O0w34w==
X-Received: by 2002:a37:b201:: with SMTP id b1-v6mr16847583qkf.158.1538954887706;
        Sun, 07 Oct 2018 16:28:07 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:06 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 10/19] orangefs: service ops done for writeback are not killable
Date:   Sun,  7 Oct 2018 23:27:27 +0000
Message-Id: <20181007232736.3780-11-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
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

