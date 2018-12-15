Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA966C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA43C2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVbiGdqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbeLONFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 08:05:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52060 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLONFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 08:05:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so8134466wmh.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6cwNqOIPLzV5syj450EHVkSSWEQYIlI0tsNGnGOC2Po=;
        b=ZVbiGdqjzWbo2NXkTs1ntj7m5ihvJqRoo9zZxxgPJ0aUp64OAL0DNYXcIySCsFFLdG
         gawKxrDxHjFolC+uX7wAVh53j+Ap/gkeubnD40xvhLMTuVHwTc/P9zwFhK4t7cq1tX7E
         1EPwpLB4oayyxYh+raPf8joirk9BaRMH2+muCF/jhAj7mlew08xX2UFkMeitOU/mrNtH
         a0P2gS+YV4VK/kQtnaAzGcMCJEBxuWzxRS3a5wzAjlXKsAYPK7e4+rgXi+HIHC7zxubB
         xSm+KlO9lOgwm3h1IUTo2ENdswki5YZ4PZ7JK+HWC1MuqErSsjWnMSL8HqTU4JnR+AIG
         I4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6cwNqOIPLzV5syj450EHVkSSWEQYIlI0tsNGnGOC2Po=;
        b=QRrn53bL9PkJOetSHMjAYJtIwTMsQZWNqseDc1RJQNiCtDf/YLmb78bKIKp9PdUq46
         ma4X2hxJffPVQuAAoYuIBBTCl6iRYyBxGMkc4fZUm86QDr7HkZKU3rRUhllImeDjARhJ
         vR5WOeK9nuMjQHdqGHhO1+Bw5LhhfRs7WrFwU9osUUFGPmVtVTebyxB8I+3PLfPnqO9q
         tHncHai9xRNPFL7YjZfNbM0AwnkPBbApm3rDZo/dssKYYgR8YYlIeCNG2OyD4LbJorkw
         3DN4rGZR3Te9A+uwlk4cXteZHxMixc3fcTAujvpUUGJ4gPIfvuipfDaLjUc+KCH9T0IG
         YVmw==
X-Gm-Message-State: AA+aEWZ+qZ4XLJhGLjl/dSf0sfgItKozzXCTmxosCmntMiDrdIRSmvea
        cl6JgOTVCdMOmFKaVI2HDEA=
X-Google-Smtp-Source: AFSGD/XJp5/BalZd/vvNj/294TnRB+WISqXoUFsqK1ajT3Er4EbEGTCo6g3NugRq/E6sNW/9W8nKhw==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr4500635wmj.129.1544879108172;
        Sat, 15 Dec 2018 05:05:08 -0800 (PST)
Received: from localhost.localdomain (bzq-109-67-225-236.red.bezeqint.net. [109.67.225.236])
        by smtp.googlemail.com with ESMTPSA id s1sm9589159wro.9.2018.12.15.05.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Dec 2018 05:05:07 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: [PATCH v2 2/3] fat: Moved MAX_FAT to fat.h and changed it to inline function
Date:   Sat, 15 Dec 2018 08:04:31 -0500
Message-Id: <1544879072-4251-3-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
References: <1544879072-4251-1-git-send-email-carmeli.tamir@gmail.com>
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
 include/uapi/linux/msdos_fs.h | 2 --
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 4e1b2f6..11bc4a2 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -142,6 +142,15 @@ static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+/* Maximum number of clusters */
+static inline u32 MAX_FAT(struct super_block *sb)
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

