Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A019208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A019208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeFTIbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:31:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:44227 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753321AbeFTIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:20 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M1ohG-1gJn650fLG-00tobA; Wed, 20 Jun 2018 10:06:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Sheng Yong <shengyong1@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Yunlei He <heyunlei@huawei.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Yunlong Song <yunlong.song@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: use timespec64 for inode timestamps
Date:   Wed, 20 Jun 2018 10:02:19 +0200
Message-Id: <20180620080603.4156809-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:euVe48uQ7fhYAIxYwhwLE6D+Tm69XWN5ugITgY1lJG6DmUF1JmC
 fqUy2OCFPhzpnZw5JzadZXGdyok3p+7UA0cqqadOSSyVLmkGNPRbhLsEwtX4qwBwDMk3mGf
 /DH7UcOj1B4opuZaM1DtrDeNiOC09M91pb+Rkg54DU6UmAJ6VvFUpFX168jZ2Kg3+I4Q33x
 any73YonO0E2mrreBjAnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VFI5UkHt4h4=:r4gn/Eq0oyx+oBAsLr5h+5
 Si7qxy+T5xk26czEPnIM7R2+kINPPtn6YRXCIxgLahLNQGIXZLQxpIon7qPUWDdH+NwPHyt85
 r88dYvyzyxU5nfqMAta/NGN9RDRD+QVJph8Ou9NGhASxeRP3vVaji1f2FTuIglF2K/RHnmvmv
 kcopTPddtD+FEbRPZDBnaSO+vPvICRDFzg6LIsqJT3Tf1RV1akHHj173nwSDBjKO/TzCnsh/M
 hLneW3CSzfteGC/3LP8an1sFwlkSO4qdNVNqhbCKPcXfDQ0/NPB1xMw+1AdtgoHhisuYcxe87
 J1H/ye7kigHHdaW3YYOpuWLlPC2TdEMJTrXLs0SjNSF6RZt57EhcWfQ995RlhvKGAMkHBz8hq
 hspayxyAR7vYAianjYz9T4B30xTaG0Z2Gp+lHngqJzn1MDpwgMvLl4MRRncAQ+LPkNeXZumdj
 YeVAhg7GgCcqyX8iBO2PUt8l/ISujOadqKSqm3UpujF9soHhIdPgJTPRcRB5/l8q6CnRZXybT
 KG+dwr5TkcyMguqtn0/D9LqcY9th/e3XWlq7UI7b5MDn3GqZNVUlWfD8RiVj6oCRkyf0+GvQv
 2XqNBh3VLtHpVFV5vNRYg4Ip7B75RdhDZ/Gd2+s6m4hH2r8JSJughpEuRHsPyIB5NpKwtK7xH
 fZ9PMSxf9WzYf7jxA1XDSIXM4XCUH1eFukbohUx0kiiuwNY+CKsH8wngTR9lR+q6pSl4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The on-disk representation and the vfs both use 64-bit tv_sec values,
so let's change the last missing piece in the middle.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/f2fs.h  | 16 ++++++----------
 fs/f2fs/inode.c | 12 ++++++------
 fs/f2fs/namei.c |  2 +-
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de83143..8b519707433b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -669,8 +669,8 @@ struct f2fs_inode_info {
 	int i_extra_isize;		/* size of extra space located in i_addr */
 	kprojid_t i_projid;		/* id for project quota */
 	int i_inline_xattr_size;	/* inline xattr size */
-	struct timespec i_crtime;	/* inode creation time */
-	struct timespec i_disk_time[4];	/* inode disk times */
+	struct timespec64 i_crtime;	/* inode creation time */
+	struct timespec64 i_disk_time[4];/* inode disk times */
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -2518,7 +2518,6 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
-	struct timespec ts;
 	bool ret;
 
 	if (dsync) {
@@ -2534,16 +2533,13 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 			i_size_read(inode) & ~PAGE_MASK)
 		return false;
 
-	ts = timespec64_to_timespec(inode->i_atime);
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time, &ts))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
 		return false;
-	ts = timespec64_to_timespec(inode->i_ctime);
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 1, &ts))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
 		return false;
-	ts = timespec64_to_timespec(inode->i_mtime);
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 2, &ts))
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
 		return false;
-	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 3,
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
 						&F2FS_I(inode)->i_crtime))
 		return false;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f121c864f4c0..30a777369d2b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -297,9 +297,9 @@ static int do_read_inode(struct inode *inode)
 		fi->i_crtime.tv_nsec = le32_to_cpu(ri->i_crtime_nsec);
 	}
 
-	F2FS_I(inode)->i_disk_time[0] = timespec64_to_timespec(inode->i_atime);
-	F2FS_I(inode)->i_disk_time[1] = timespec64_to_timespec(inode->i_ctime);
-	F2FS_I(inode)->i_disk_time[2] = timespec64_to_timespec(inode->i_mtime);
+	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
+	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
+	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 	f2fs_put_page(node_page, 1);
 
@@ -470,9 +470,9 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	if (inode->i_nlink == 0)
 		clear_inline_node(node_page);
 
-	F2FS_I(inode)->i_disk_time[0] = timespec64_to_timespec(inode->i_atime);
-	F2FS_I(inode)->i_disk_time[1] = timespec64_to_timespec(inode->i_ctime);
-	F2FS_I(inode)->i_disk_time[2] = timespec64_to_timespec(inode->i_mtime);
+	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
+	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
+	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 231b7f3ea7d3..2ea0de4cbe76 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -51,7 +51,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
-	F2FS_I(inode)->i_crtime = timespec64_to_timespec(inode->i_mtime);
+	F2FS_I(inode)->i_crtime = inode->i_mtime;
 	inode->i_generation = sbi->s_next_generation++;
 
 	if (S_ISDIR(inode->i_mode))
-- 
2.9.0

