Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A75ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5D7208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5D7208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeGMOxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:53:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbeGMOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:53:21 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LvBCM-1g4plT46SY-010Pa4; Fri, 13 Jul 2018 16:38:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Sheng Yong <shengyong1@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        Yunlei He <heyunlei@huawei.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Yunlong Song <yunlong.song@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] f2fs: use timespec64 for inode timestamps
Date:   Fri, 13 Jul 2018 16:37:46 +0200
Message-Id: <20180713143800.3146610-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Z6Zh4VCFSo189KkkCfjGr3ttTdjM9kmCX64Pr2CAM/m2hRwEhxU
 zp0NiSSgP7A0Sfly1Xmw2R3q/EIPD0XFD+Le/s5z4dPk9aSeBHocMQBnUEwA53/t7bKWess
 q6Ta4AhyaE4SzqDR5U9F7MmWzT/xk5BB4m0EimOmwr2PyHiFyPCzvi6aRdclapMMaDR7FnJ
 fT+Dk7iFzfSgE+m4u2S1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jz1PbfiZg84=:5xazyNrN2zfB7OzJdHdYTj
 Ri/NQbMgtK3hKC3v5UQW/zwCRV312+92gpdMS/2lhIM4MA6kHHPGBfhjoyxuzt3pR7N4NhfKx
 0C+C9dK1TM0dfpKsC9rRMLt9GdLihh7BJLkMR1rveE1XFCVqAV7u/g2oYp7Z/BJJTN+tVNohA
 TaOIOYRFtiXMvq1sCJrCNq2uen1ewYS4KJ0xiw9k5YXlM2bwf82Dx3bIKA8bCFj5VYyXyi6WV
 O385Cg4RT2VouZZTaYA9rugzL/q91zvONrUwM6cVodCO6mbKXREvfRJG6WZJaNjDbfTtKLHwj
 KxIR6Hk6L4FpQpAJ7MilVKqWwE4G8pmRNH4BT47/zg9anQXVkjM9aGoHxAJ/QJMYSZSZjzWDB
 7d+rB/l6NgDSkhQGbOwVyy/dWHrpEQWfkim7r5yoxRBvNsewrW74NsoszfqET/ceN/kPDwoY8
 OcmgwGSjfP+M+MnGuvkL3ThNuQunNSNL+9XBv1qgpwq2lusB3dnbBbzozn71iBmcfr9/Gxszl
 1uv4/EvPNXXBdmI8Re/NRT7URlLsvC8Mx7oJ2IyoOPSHI04VuzhLZI8/45cb7SHWPTiyyIz9l
 XXrrmhn5qbA/8v0275x5sSjOaYtO9FpYGjNPj7SuBaxIfUq3z7SVenhJMSCGDpDfHs8sQDc4B
 gTNU7ocO4EmX0S2WDeHgmbWBrBY5qJk+6A3C0VQrRgreA1zc4AvC+P39fmnIe3YrlshE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The on-disk representation and the vfs both use 64-bit tv_sec values,
so let's change the last missing piece in the middle.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this on Jun 20 and got an Ack, but nobody picked up the patch
into linux-next.

Could you merge this for 4.19?
---
 fs/f2fs/f2fs.h  | 16 ++++++----------
 fs/f2fs/inode.c | 12 ++++++------
 fs/f2fs/namei.c |  2 +-
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6fe7db8d914c..1e49b896e211 100644
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
@@ -2519,7 +2519,6 @@ static inline void clear_file(struct inode *inode, int type)
 
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
-	struct timespec ts;
 	bool ret;
 
 	if (dsync) {
@@ -2535,16 +2534,13 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
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
index f91dd017a65c..f9d1bccebcb6 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -300,9 +300,9 @@ static int do_read_inode(struct inode *inode)
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
 
@@ -473,9 +473,9 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
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

