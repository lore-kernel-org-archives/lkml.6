Return-Path: <paulmcquad@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523126874; cv=none;
        d=google.com; s=arc-20160816;
        b=H5wB1iOgpSHOg/HTrvD2lIlG0gZbxbV00Vu9v5E3LkcNN2FYtWWbkEbS63aN0dAWQE
         JpTn+h5AkgZldvmtvDDXETf1qmV/4qLMS8YCez2WdxooZ2JKwMalawY3az1PxlosLOZH
         akXtlduKFQLMfefOidHUbv8p3W29A00Nw9GhfHRdQ+UAkBEgnGIFvSMQ1FMfjAn2cTaX
         pacy/2TcDb6SSnpTc+o3adhXg3d00UsB90Z9Qg8oYcHOw3/LGkG0g0j78K3Io8WMSY/8
         fX3j8mxCEwsWn904vhNWMjmGfWNZJVdWZuByzfiotzCITl9lHsS+A4NJXsNQEhHMSg30
         cKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9C+sIhYgUd1V+aOu/sCv8Wkqazx/5p5yXUByivhAodw=;
        b=vlX1dF4f+0HhhmchyuQzi/mRIn9eDSQV/F3LM84G/E0NabB3uKVCWPGWSaalhwtBeP
         gcBl29XPKMWNSTPj0vBFvMsSBgxSEZqGlyz+szZWH3uuaYfPcwHDxcEwqB6kJ3h6u4pD
         g0kvIZMDVxCQxyAqFHlHRu+WGD5lyNU60udYSohQZqy5PBc10hvPp91lMualu5/VPM7L
         W6Wk44vTJhC66U3RxmSSxNxV9wXWYVwQ5iz0FJbImsTYZvwWRt2FUROxzsE5dI7wdJhj
         SWGusWVpTLfPJyGd2U0yNMFpe5R2ykAQgmCv08RQCiivq7OdNUS07dF/rvp0dzaVyJaX
         mZPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g+81DAnF;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g+81DAnF;
       spf=pass (google.com: domain of paulmcquad@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paulmcquad@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx494g9OSD8RXf6ItOlxnJ9gjhnv3Mnlw66YCQmaSqa1sUcGXCdGmTDKwbYYGmeUrTMKBsZFdjQ==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: konrad.wilk@oracle.com,
	labbott@redhat.com,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	guptap@codeaurora.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rppt@linux.vnet.ibm.com,
	dave@stgolabs.net,
	hmclauchlan@fb.com,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm: replace S_IRUGO with 0444
Date: Sat,  7 Apr 2018 19:47:24 +0100
Message-Id: <20180407184726.8634-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597114285663933591?=
X-GMAIL-MSGID: =?utf-8?q?1597114285663933591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix checkpatch warnings about S_IRUGO being less readable than
providing the permissions octal as '0444'.

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 mm/cleancache.c |  8 ++++----
 mm/cma_debug.c  | 12 ++++++------
 mm/dmapool.c    |  2 +-
 mm/frontswap.c  |  8 ++++----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index f7b9fdc79d97..90d259e69496 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -307,11 +307,11 @@ static int __init init_cleancache(void)
 	struct dentry *root = debugfs_create_dir("cleancache", NULL);
 	if (root == NULL)
 		return -ENXIO;
-	debugfs_create_u64("succ_gets", S_IRUGO, root, &cleancache_succ_gets);
-	debugfs_create_u64("failed_gets", S_IRUGO,
+	debugfs_create_u64("succ_gets", 0444, root, &cleancache_succ_gets);
+	debugfs_create_u64("failed_gets", 0444,
 				root, &cleancache_failed_gets);
-	debugfs_create_u64("puts", S_IRUGO, root, &cleancache_puts);
-	debugfs_create_u64("invalidates", S_IRUGO,
+	debugfs_create_u64("puts", 0444, root, &cleancache_puts);
+	debugfs_create_u64("invalidates", 0444,
 				root, &cleancache_invalidates);
 #endif
 	return 0;
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 275df8b5b22e..6494c7a7d257 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -178,17 +178,17 @@ static void cma_debugfs_add_one(struct cma *cma, int idx)
 	debugfs_create_file("free", S_IWUSR, tmp, cma,
 				&cma_free_fops);
 
-	debugfs_create_file("base_pfn", S_IRUGO, tmp,
+	debugfs_create_file("base_pfn", 0444, tmp,
 				&cma->base_pfn, &cma_debugfs_fops);
-	debugfs_create_file("count", S_IRUGO, tmp,
+	debugfs_create_file("count", 0444, tmp,
 				&cma->count, &cma_debugfs_fops);
-	debugfs_create_file("order_per_bit", S_IRUGO, tmp,
+	debugfs_create_file("order_per_bit", 0444, tmp,
 				&cma->order_per_bit, &cma_debugfs_fops);
-	debugfs_create_file("used", S_IRUGO, tmp, cma, &cma_used_fops);
-	debugfs_create_file("maxchunk", S_IRUGO, tmp, cma, &cma_maxchunk_fops);
+	debugfs_create_file("used", 0444, tmp, cma, &cma_used_fops);
+	debugfs_create_file("maxchunk", 0444, tmp, cma, &cma_maxchunk_fops);
 
 	u32s = DIV_ROUND_UP(cma_bitmap_maxno(cma), BITS_PER_BYTE * sizeof(u32));
-	debugfs_create_u32_array("bitmap", S_IRUGO, tmp, (u32*)cma->bitmap, u32s);
+	debugfs_create_u32_array("bitmap", 0444, tmp, (u32 *)cma->bitmap, u32s);
 }
 
 static int __init cma_debugfs_init(void)
diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4d90a64b2fdc..6d4b97e7e9e9 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -105,7 +105,7 @@ show_pools(struct device *dev, struct device_attribute *attr, char *buf)
 	return PAGE_SIZE - size;
 }
 
-static DEVICE_ATTR(pools, S_IRUGO, show_pools, NULL);
+static DEVICE_ATTR(pools, 0444, show_pools, NULL);
 
 /**
  * dma_pool_create - Creates a pool of consistent memory blocks, for dma.
diff --git a/mm/frontswap.c b/mm/frontswap.c
index fec8b5044040..3b41425d34cd 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -486,11 +486,11 @@ static int __init init_frontswap(void)
 	struct dentry *root = debugfs_create_dir("frontswap", NULL);
 	if (root == NULL)
 		return -ENXIO;
-	debugfs_create_u64("loads", S_IRUGO, root, &frontswap_loads);
-	debugfs_create_u64("succ_stores", S_IRUGO, root, &frontswap_succ_stores);
-	debugfs_create_u64("failed_stores", S_IRUGO, root,
+	debugfs_create_u64("loads", 0444, root, &frontswap_loads);
+	debugfs_create_u64("succ_stores", 0444, root, &frontswap_succ_stores);
+	debugfs_create_u64("failed_stores", 0444, root,
 				&frontswap_failed_stores);
-	debugfs_create_u64("invalidates", S_IRUGO,
+	debugfs_create_u64("invalidates", 0444,
 				root, &frontswap_invalidates);
 #endif
 	return 0;
-- 
2.16.2
