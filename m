Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9F20672
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF791YFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbeLPUEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:04:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46576 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbeLPUE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:04:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so10180627wrt.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Q+hqS7cpOSw+1VfYGA2msdA/eCF/gAAZquYRfrl7MNg=;
        b=MF791YFsiX9Z2fWlSyvyDsAo9DOcHSmGFf4jW+O9nAnwYBbE/cYJg577Dr9DNffdCr
         FU6RRWxqmQThWggDXWCy8lk346/c+V2zMv3kPNaBcSZf3fZePt0RvMKGWirOJRNfTp1r
         HzBvluRHWikyDwaM54+x/2gucVYbVVyOo55iUp9gyYca7KxL3jSYo10fJ77MoEM0TS2x
         X/rhQd9iJK5nQvxJKeACtFF0rSUdW80/gSvQmC4Vlm2fjlXxkCrmR/MYXmxJChXq1xJy
         SGxjqy5/pO2g3noba0T9QimdPm1wxj3mEyzutJpFd4s/QMqnzNBApn4oLUPy/6H8BlpM
         xOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Q+hqS7cpOSw+1VfYGA2msdA/eCF/gAAZquYRfrl7MNg=;
        b=bX3Xe4JxMkJyMCkRec7xO+8JvpO4PLdx4P/VTjJeU0ILG/RTkm0KUYBFm35Moj6+/2
         +eerC8XRm4KMVaMqFKzcwJpIYob9/XmegVGUfgZ4oPX6UDtPabzVRu7E0m4Wj8aORk89
         Qe1469OESoc3g8Mz/mn/KSImOy7t1hNnOAXp5tzcjc9E+JeCA1V+QBJjEbPtjjU8MmN/
         p8pwm/jjEyNMeoxY3HIVuj4Q3C0jGU/WGtVsye/GW47pQnKZXH1dfq+ijz2vQYOrUAHQ
         2EH54EWjoW334kinXx35AstrzN+5uGf+3rEqROqdYVD3GpgR0ochQLE/6PSeNLIhLKyQ
         8nAA==
X-Gm-Message-State: AA+aEWaSek+I/g8NbSazY6EkeaLOGM61N+HkSaZPkvNZm1pwqIJD18pi
        Bp2tcLOjcie2D9KNBeCsJHdTjg9ERiE=
X-Google-Smtp-Source: AFSGD/Ve6HyMSsfxgAT2dWdvxoLB5atQFiYXXV4CkzoFdwjxTFbasuVkFy34CoxDkcbKLCf21acE5Q==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr9349902wru.154.1544990666007;
        Sun, 16 Dec 2018 12:04:26 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id v5sm10535150wrn.71.2018.12.16.12.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 12:04:25 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v3 2/3] fat: Moved MAX_FAT to fat.h and changed it to inline function
Date:   Sun, 16 Dec 2018 15:03:59 -0500
Message-Id: <1544990640-11604-3-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_FAT is useless in msdos_fs.h, since it uses the MSDOS_SB function
that is defined in fat.h. So really, this macro can be only called
from code that already includes fat.h.

Hence, this patch moves it to fat.h, right after MSDOS_SB is defined.
I also changed it to an inline function in order to save the double call
to MSDOS_SB. This was suggested by joe@perches.com in the previous
version.

This patch is required for the next in the series, in which the variant
(whether this is FAT12, FAT16 or FAT32) checks are replaced with new
macros.


Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/fat/fat.h                  | 9 +++++++++
 fs/fat/inode.c                | 2 +-
 include/uapi/linux/msdos_fs.h | 2 --
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 4e1b2f6..979bb11 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -142,6 +142,15 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+/* Maximum number of clusters */
+static inline u32 max_fat(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	return sbi->fat_bits == 32 ? MAX_FAT32 :
+		sbi->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12;
+}
+
 static inline struct msdos_inode_info *MSDOS_I(struct inode *inode)
 {
 	return container_of(inode, struct msdos_inode_info, vfs_inode);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 708de6d..7ede9db 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1782,7 +1782,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	/* check that FAT table does not overflow */
 	fat_clusters = calc_fat_clusters(sb);
 	total_clusters = min(total_clusters, fat_clusters - FAT_START_ENT);
-	if (total_clusters > MAX_FAT(sb)) {
+	if (total_clusters > max_fat(sb)) {
 		if (!silent)
 			fat_msg(sb, KERN_ERR, "count of clusters too big (%u)",
 			       total_clusters);
diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
index 833c707..a577389 100644
--- a/include/uapi/linux/msdos_fs.h
+++ b/include/uapi/linux/msdos_fs.h
@@ -65,8 +65,6 @@
 #define MAX_FAT12	0xFF4
 #define MAX_FAT16	0xFFF4
 #define MAX_FAT32	0x0FFFFFF6
-#define MAX_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
-	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
 
 /* bad cluster mark */
 #define BAD_FAT12	0xFF7
-- 
2.7.4

