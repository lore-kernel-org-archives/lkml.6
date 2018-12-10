Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B48C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25AE20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSSraoC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25AE20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeLJTmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:42:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLJTmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:42:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so11720644wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=pUI2btvaQ6bU91kWAU8Ygm9aidJu1bNCWzvE684NGyY=;
        b=JSSraoC3zK54Aus7egLXZmQ+vSGaiHZwFARjylxyMt7jSK/WjPUPPLTrQmce+sKY8U
         ZuxfpU1H7S96aRWVT52xT1XolLo/KizfGVSHoAIMqeG/R84N4rl4ZoiOLjSeR8vU/bKM
         Mkjf9es2k3mCJgnJUBV+/mC0OzuQ9OQn9nsFh7ol5jNXzfCgBq3Vc9KdHD0LjX3kUZOc
         ygu3dTJL/EqPKX+SUqGwFnKPjHcoYRkveOOcOTjYZg6fPw0SZ1jwS5eRC8R7QKdTcvUW
         NW2P3i2aHOhk0HzjmJILzA+XmWtfvX5Uh7c9huKTS/lugEDcVbYJLDh7iR1N2oaLOl/r
         zklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=pUI2btvaQ6bU91kWAU8Ygm9aidJu1bNCWzvE684NGyY=;
        b=s7f2G6jctyY4VqcUWJ064TYGYtqxibhnk3k9H8149dgq0H8WPRKV0xVuCNLMnC0cfc
         4ZnqaWQCl6yhzl20wO636ZzfyMM6laRpclQVJKd1J6UGmKJM5DuG396fhSN4gPQwSan6
         ijfDeR03M7mZAl2eHueqBrmfgPyzhshXPil45Q2paoTHdFPAMJnoGCbQhc04kpyKPjQl
         nb+5/lLrHeutZJ6g89hOZVMmIA7XSLKy7jA66NN31lsBSFehhugnibYFsDLkrUg4XnYg
         vFkyAKa4xjw2YiZZdWQI3WB7o7Ry9WXTOf1lTtylmOvfrGgPAKnxk/8mZOqwe5jvBg9C
         HFkQ==
X-Gm-Message-State: AA+aEWan8WrMgdig2QuLl9gkO39HQKu+BSGAEQL6fbZXtCTDctc6y53+
        1lgWPWzSdVTLnQa1edkS7Q4=
X-Google-Smtp-Source: AFSGD/VIVuu/eCBHhZW0vo1kp82xaMRPkCzlRGlz6dEz+EvcV0c2C3Q5DZaiguIyTfMfC4yZgyBU7g==
X-Received: by 2002:adf:e383:: with SMTP id e3mr10777027wrm.31.1544470953117;
        Mon, 10 Dec 2018 11:42:33 -0800 (PST)
Received: from osboxes.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id t4sm14565082wrm.6.2018.12.10.11.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:42:32 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     hirofumi@mail.parknet.co.jp, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        axboe@kernel.dk, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, carmeli.tamir@gmail.com
Subject: [PATCH 1/2] fat: Moved macros that won't work without fat.h
Date:   Mon, 10 Dec 2018 14:41:56 -0500
Message-Id: <1544470917-6443-2-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both FAT_FIRST_ENT and MAX_FAT are useless in msdos_fs.h, since they need the
MSDOS_SB function that is defined in fat.h. So really, both can be only called
from code that already includes fat.h.

Hence, this patch moves them to fat.h, right after MSDOS_SB is defined.
This patch is required for the next in the series, in which the variant (whether
this is FAT12, FAT16 or FAT32) checks are replaced with new macros.


Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/fat/fat.h                  | 22 +++++++++++++++++-----
 include/uapi/linux/msdos_fs.h |  5 -----
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 4e1b2f6..e06fdd3 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -106,6 +106,23 @@ struct msdos_sb_info {
 
 #define FAT_CACHE_VALID	0	/* special case for valid cache */
 
+static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+/*
+ * Definitions that depend on the variant of the FAT file system (i.e., whether
+ * this is FAT12, FAT16 or FAT32.
+ */
+
+#define FAT_FIRST_ENT(s, x)     ((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
+	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
+
+/* maximum number of clusters */
+#define MAX_FAT(s)      (MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
+	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
+
 /*
  * MS-DOS file system inode data in memory
  */
@@ -137,11 +154,6 @@ struct fat_slot_info {
 	struct buffer_head *bh;
 };
 
-static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
-{
-	return sb->s_fs_info;
-}
-
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
 {
 	return container_of(inode, struct msdos_inode_info, vfs_inode);
diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
index 1216e6c..a577389 100644
--- a/include/uapi/linux/msdos_fs.h
+++ b/include/uapi/linux/msdos_fs.h
@@ -58,9 +58,6 @@
 #define MSDOS_DOT	".          "	/* ".", padded to MSDOS_NAME chars */
 #define MSDOS_DOTDOT	"..         "	/* "..", padded to MSDOS_NAME chars */
 
-#define FAT_FIRST_ENT(s, x)	((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
-	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
-
 /* start of data cluster's entry (number of reserved clusters) */
 #define FAT_START_ENT	2
 
@@ -68,8 +65,6 @@
 #define MAX_FAT12	0xFF4
 #define MAX_FAT16	0xFFF4
 #define MAX_FAT32	0x0FFFFFF6
-#define MAX_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
-	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
 
 /* bad cluster mark */
 #define BAD_FAT12	0xFF7
-- 
2.7.4

