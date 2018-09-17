Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97785ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F7F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="N6wKiEyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F7F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeIRBkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34913 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeIRBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id f62-v6so9745829qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AN23acl7MBlWbUdXlKJ9Ub8VMLUatWLEGH8rlJK2EFc=;
        b=N6wKiEyiW5H7Be8IKzBubf9LxL8a9CK2M+DEiHizSckc7egw4S/FD3EBQA56QjDH/V
         j3CM282jnsgOyVftt/wqzRaqJUuOyQxdX/i/jwB0VYD853950IeVaaskivQOEc9vxcOD
         DM9kPXztJP7Q1kNT+JYowmPPzm5m5u+YjvQa9DOmbdT5uP5bJAerwGvpWf74OCA6c+Tb
         CirbVHlhbPY0hvRP1lrleULAjWfg2RrrQct6kuv1vY1KodMFD26b4YxWgupjn4P76Djz
         a9/Ny+y6RlIQC1EZVN3AxOc9TlHbIt0K4ZL2cmZuvndsav1vFJV8iL9SEAXcImy0INa+
         eTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AN23acl7MBlWbUdXlKJ9Ub8VMLUatWLEGH8rlJK2EFc=;
        b=lHqoJhrXDxi92P9oB2tS1zcBX3yq96JFR6dTHHPsnAWnVbK824CsrXJXCVIWCzVgOC
         9RTLF+SPvLL0wlKE38rhQ8uTLmAbiRM/ij3GiOMYApc2QKrSdyC6BCYS64ke3D54Ju3l
         VerZXGt/OZ/p0WKoPeTgRX5VGO9k4BE+o2VSR4uVfdhn4/vSW6lc23GfW/CWQpx8g5rk
         7SIHYsd9QLo+yq2TptDHRxeiuKPv0rbhO3AhKkbaeeI4qpN690WR/CiwKtK1uFOs53Fm
         gkJBj7fSEIewHy8YC0qOo7+zBuHrXOJcftraqbIEYqlX8Guc7ML2gTMqEYvCbIe0cV0u
         tJIQ==
X-Gm-Message-State: APzg51BzvGJXYDH2uGWmzR0yrK2sllzd4qhkRxqeFvBYi3eDnV4qfoIj
        m+f2s20EsoWB1f8Nq37LhMxCDzMBHYct+j0L
X-Google-Smtp-Source: ANB0Vdak9pnBYpV09M8ox+zSVmamAStn6HMS6lV+NE/Pn7LpnVTC8zBFRn1zU4+YkItR/c3Jb0r55A==
X-Received: by 2002:ae9:e414:: with SMTP id q20-v6mr17860689qkc.305.1537215087199;
        Mon, 17 Sep 2018 13:11:27 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:26 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 16/17] orangefs: use kmem_cache for orangefs_write_request
Date:   Mon, 17 Sep 2018 20:10:53 +0000
Message-Id: <20180917201054.3530-17-martin@omnibond.com>
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
 fs/orangefs/inode.c           | 10 +++++-----
 fs/orangefs/orangefs-cache.c  | 24 ++++++++++++++++++++++--
 fs/orangefs/orangefs-kernel.h |  6 ++++--
 fs/orangefs/orangefs-mod.c    | 10 +++++-----
 4 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index efb00cd50b61..178734920e45 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -66,7 +66,7 @@ static int orangefs_writepage_locked(struct page *page,
 		ret = 0;
 		if (wr) {
 			ClearPagePrivate(page);
-			kfree(wr);
+			wr_release(wr);
 		}
 	}
 	end_page_writeback(page);
@@ -126,7 +126,7 @@ static int update_wr(struct page *page, loff_t pos, unsigned len, int mwrite)
 		else
 			wr->len = wr->pos + wr->len - wr->pos;
 	} else {
-		wr = kmalloc(sizeof *wr, GFP_KERNEL);
+		wr = wr_alloc();
 		if (wr) {
 			wr->pos = pos;
 			wr->len = len;
@@ -272,7 +272,7 @@ static void orangefs_invalidatepage(struct page *page,
 /* XXX prove */
 		if (offset == 0 && length == PAGE_SIZE) {
 			ClearPagePrivate(page);
-			kfree(wr);
+			wr_release(wr);
 		} else if (wr->pos - page_offset(page) < offset &&
 		    wr->pos - page_offset(page) + wr->len > offset + length) {
 			wbc.range_start = page_file_offset(page);
@@ -284,7 +284,7 @@ static void orangefs_invalidatepage(struct page *page,
 					return;
 			} else {
 				ClearPagePrivate(page);
-				kfree(wr);
+				wr_release(wr);
 			}
 		} else if (wr->pos - page_offset(page) < offset &&
 		    wr->pos - page_offset(page) + wr->len <= offset + length) {
@@ -299,7 +299,7 @@ static void orangefs_invalidatepage(struct page *page,
 			 * entire write range is to be invalidated.
 			 */
 			ClearPagePrivate(page);
-			kfree(wr);
+			wr_release(wr);
 		}
 	}
 	return;
diff --git a/fs/orangefs/orangefs-cache.c b/fs/orangefs/orangefs-cache.c
index 3b6982bf6bcf..cfb405ca8aa5 100644
--- a/fs/orangefs/orangefs-cache.c
+++ b/fs/orangefs/orangefs-cache.c
@@ -16,8 +16,9 @@ static DEFINE_SPINLOCK(next_tag_value_lock);
 
 /* a cache for orangefs upcall/downcall operations */
 static struct kmem_cache *op_cache;
+static struct kmem_cache *wr_cache;
 
-int op_cache_initialize(void)
+int orangefs_caches_initialize(void)
 {
 	op_cache = kmem_cache_create("orangefs_op_cache",
 				     sizeof(struct orangefs_kernel_op_s),
@@ -34,12 +35,21 @@ int op_cache_initialize(void)
 	spin_lock(&next_tag_value_lock);
 	next_tag_value = 100;
 	spin_unlock(&next_tag_value_lock);
+
+	wr_cache = kmem_cache_create("orangefs_wr_cache",
+	    sizeof(struct orangefs_write_request), 0, ORANGEFS_CACHE_CREATE_FLAGS, NULL);
+	if (!wr_cache) {
+		gossip_err("Cannot create orangefs_wr_cache\n");
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
-int op_cache_finalize(void)
+int orangefs_caches_finalize(void)
 {
 	kmem_cache_destroy(op_cache);
+	kmem_cache_destroy(wr_cache);
 	return 0;
 }
 
@@ -162,3 +172,13 @@ void op_release(struct orangefs_kernel_op_s *orangefs_op)
 		gossip_err("NULL pointer in op_release\n");
 	}
 }
+
+struct orangefs_write_request *wr_alloc(void)
+{
+	return kmem_cache_zalloc(wr_cache, GFP_KERNEL);
+}
+
+void wr_release(struct orangefs_write_request *wr)
+{
+	kmem_cache_free(wr_cache, wr);
+}
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 2e9726d1de7d..256851bab7a5 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -311,11 +311,13 @@ static inline int match_handle(struct orangefs_khandle resp_handle,
 /*
  * defined in orangefs-cache.c
  */
-int op_cache_initialize(void);
-int op_cache_finalize(void);
+int orangefs_caches_initialize(void);
+int orangefs_caches_finalize(void);
 struct orangefs_kernel_op_s *op_alloc(__s32 type);
 void orangefs_new_tag(struct orangefs_kernel_op_s *op);
 char *get_opname_string(struct orangefs_kernel_op_s *new_op);
+struct orangefs_write_request *wr_alloc(void);
+void wr_release(struct orangefs_write_request *);
 
 int orangefs_inode_cache_initialize(void);
 int orangefs_inode_cache_finalize(void);
diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 85ef87245a87..c7373e682653 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -87,13 +87,13 @@ static int __init orangefs_init(void)
 		slot_timeout_secs = 0;
 
 	/* initialize global book keeping data structures */
-	ret = op_cache_initialize();
+	ret = orangefs_caches_initialize();
 	if (ret < 0)
 		goto out;
 
 	ret = orangefs_inode_cache_initialize();
 	if (ret < 0)
-		goto cleanup_op;
+		goto cleanup_caches;
 
 	orangefs_htable_ops_in_progress =
 	    kcalloc(hash_table_size, sizeof(struct list_head), GFP_KERNEL);
@@ -172,8 +172,8 @@ static int __init orangefs_init(void)
 cleanup_inode:
 	orangefs_inode_cache_finalize();
 
-cleanup_op:
-	op_cache_finalize();
+cleanup_caches:
+	orangefs_caches_finalize();
 
 out:
 	return ret;
@@ -194,7 +194,7 @@ static void __exit orangefs_exit(void)
 		BUG_ON(!list_empty(&orangefs_htable_ops_in_progress[i]));
 
 	orangefs_inode_cache_finalize();
-	op_cache_finalize();
+	orangefs_caches_finalize();
 
 	kfree(orangefs_htable_ops_in_progress);
 
-- 
2.19.0

