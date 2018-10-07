Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFD4C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA0D2087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="KyCV5qsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA0D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeJHGhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42284 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbeJHGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id j46-v6so3580026qtc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7Crupj61UmuuSM0+beUoP1NrKbaLR4fj0CCVbUH5+Y=;
        b=KyCV5qsaYktSF9DhIZiWNYwNiP8exS4IHx0i4gTS3dWM4uEsHbQ3/FB4wR7+nbRbQV
         UVlN38H3ycU0xWhqrVQRrqzYvF4iIny/3rP4Lu9wA6decELZSZErfKcOTTrEnAcofwX+
         A3doQ8OF/sUd1A3DQ2rn4QM0ZzOF1lDMYKj6SND5kvii7AC+7LhtU4X0C7+4eR7a+lcf
         wA7BJEpxJWnZNLO2+SJRdpO6tyOZksj00M5G0Q6nm5Ojb65DJPt4nqWpkhfn0xg0ClQP
         EqhOArEDe+PhXudDErunJMOwQiwqGfs5RCF+9xxHZcNDRFFiSDcx0pF1mcz9uNdKYG2u
         +A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7Crupj61UmuuSM0+beUoP1NrKbaLR4fj0CCVbUH5+Y=;
        b=WE3fMszumnLZ6OlO9ZelKVYJfxsoeiWQLr5JBVGb45zGTXRW4H43phdtPXbxPU4gES
         N614WcyIMGoK+huLMFm88NzEapav0chLES7rZdr3MrE08orXXz6bzTHVg+xNKsk3uCoK
         WaF2vNY9dY9PDqgDW8nXKljjBCaB6NQJD5o1EXNXPIlitSrm2zll4nFnE13k3Fn/V9uG
         Nwo0qWK8J2aMgUm2mKqU1LMwamEV6YkZ/lnk2CIfMNIyrx9TAmDNAtW6EeWsTVOa087R
         EQ77wgRPvxKVxVZlFH9mPs+2QFCdy5R606jCMP6CE1bd0J0q5W24EFE+9PvIAYDarJX3
         XG5g==
X-Gm-Message-State: ABuFfoh54nxX6FOuv82nQhehukOUt7IbKqS69o068nKENhmyv9O09DIi
        UDzanBEeXcmJ6AimtZ6MDs70GA==
X-Google-Smtp-Source: ACcGV60I7cfgWbeFKspXgMZokE4KMdXh9C5bcgkTYSJ+D09N8upEyMONrNR0KBcXyzhsD+eUpsUiaA==
X-Received: by 2002:ac8:148b:: with SMTP id l11-v6mr17664477qtj.27.1538954896004;
        Sun, 07 Oct 2018 16:28:16 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:14 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 16/19] orangefs: use kmem_cache for orangefs_write_request
Date:   Sun,  7 Oct 2018 23:27:33 +0000
Message-Id: <20181007232736.3780-17-martin@omnibond.com>
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
 fs/orangefs/inode.c           | 10 +++++-----
 fs/orangefs/orangefs-cache.c  | 24 ++++++++++++++++++++++--
 fs/orangefs/orangefs-kernel.h |  6 ++++--
 fs/orangefs/orangefs-mod.c    | 10 +++++-----
 4 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 5c155b259b13..f53d768acdd9 100644
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

