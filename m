Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D2F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="O0XMgCRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D2F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLKKzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:01 -0500
Received: from mout02.posteo.de ([185.67.36.66]:44613 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeLKKzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:01 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 15A5B240102
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544525698; bh=JFYWYfjr1gRhG9jBvzeP8lZdyLQx694oz6629351v2U=;
        h=From:To:Cc:Subject:Date:From;
        b=O0XMgCRw3/wkaJNhRkhr1XNYivZh1VMc/EYmD5qhYoTtvE6GOOBFaTioT+vx+q4yn
         WCD48UyorDqQPNxP1vp/fRs/5W/hOh2Y8Bl7wMJWE8VxHRBjPDX3HmrmVr1DULS6QZ
         PggOxF17y42jUwvTuKJF+KTKpcsuPbq60CrdWrnEFXx+Qw08pcCCxCidzjendYduZW
         PUchuGaMxknCkGGt8s2v7s8pJnQLZrv1kEZfcQyB+D6pVKwulZZ2JBxt5nbG3GaJvj
         XmM+NVMfY5SI7QMFhMuJ3JeAN13Qb7cQyIkh94w80T78mYbQEwAjCVRU/kxPScPXxf
         GyS6wpAYbz+nQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43DcKB5vmRz9rxd;
        Tue, 11 Dec 2018 11:54:54 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH 1/5] drivers: staging: erofs: Fix alignment.
Date:   Tue, 11 Dec 2018 11:54:39 +0100
Message-Id: <20181211105443.21826-2-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211105443.21826-1-aaron.strahlberger@posteo.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of 17 `CHECK: Alignment should match open parenthesis` checkpatch.pl
issues.

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>

LocalWords:  Alighnment
---
 drivers/staging/erofs/data.c | 42 ++++++++++++++++++------------------
 drivers/staging/erofs/dir.c  |  8 +++----
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 6384f73e5418..d1c0a7be6eb8 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -40,7 +40,7 @@ static inline void read_endio(struct bio *bio)
 
 /* prio -- true is used for dir */
 struct page *__erofs_get_meta_page(struct super_block *sb,
-	erofs_blk_t blkaddr, bool prio, bool nofail)
+				   erofs_blk_t blkaddr, bool prio, bool nofail)
 {
 	struct inode *const bd_inode = sb->s_bdev->bd_inode;
 	struct address_space *const mapping = bd_inode->i_mapping;
@@ -76,7 +76,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 		}
 
 		__submit_bio(bio, REQ_OP_READ,
-			REQ_META | (prio ? REQ_PRIO : 0));
+			     REQ_META | (prio ? REQ_PRIO : 0));
 
 		lock_page(page);
 
@@ -107,8 +107,8 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
-	struct erofs_map_blocks *map,
-	int flags)
+				     struct erofs_map_blocks *map,
+				     int flags)
 {
 	int err = 0;
 	erofs_blk_t nblocks, lastblk;
@@ -151,7 +151,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 		map->m_flags |= EROFS_MAP_META;
 	} else {
 		errln("internal error @ nid: %llu (size %llu), m_la 0x%llx",
-			vi->nid, inode->i_size, map->m_la);
+		      vi->nid, inode->i_size, map->m_la);
 		DBG_BUGON(1);
 		err = -EIO;
 		goto err_out;
@@ -192,27 +192,26 @@ int erofs_map_blocks_iter(struct inode *inode,
 }
 
 int erofs_map_blocks(struct inode *inode,
-	struct erofs_map_blocks *map, int flags)
+		     struct erofs_map_blocks *map, int flags)
 {
 	if (unlikely(is_inode_layout_compression(inode))) {
 		struct page *mpage = NULL;
 		int err;
 
 		err = erofs_map_blocks_iter(inode, map, &mpage, flags);
-		if (mpage != NULL)
+		if (mpage)
 			put_page(mpage);
 		return err;
 	}
 	return erofs_map_blocks_flatmode(inode, map, flags);
 }
 
-static inline struct bio *erofs_read_raw_page(
-	struct bio *bio,
-	struct address_space *mapping,
-	struct page *page,
-	erofs_off_t *last_block,
-	unsigned int nblocks,
-	bool ra)
+static inline struct bio *erofs_read_raw_page(struct bio *bio,
+					      struct address_space *mapping,
+					      struct page *page,
+					      erofs_off_t *last_block,
+					      unsigned int nblocks,
+					      bool ra)
 {
 	struct inode *inode = mapping->host;
 	erofs_off_t current_block = (erofs_off_t)page->index;
@@ -307,7 +306,7 @@ static inline struct bio *erofs_read_raw_page(
 			nblocks = BIO_MAX_PAGES;
 
 		bio = erofs_grab_bio(inode->i_sb,
-			blknr, nblocks, read_endio, false);
+				     blknr, nblocks, read_endio, false);
 
 		if (IS_ERR(bio)) {
 			err = PTR_ERR(bio);
@@ -361,7 +360,7 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 	trace_erofs_readpage(page, true);
 
 	bio = erofs_read_raw_page(NULL, page->mapping,
-		page, &last_block, 1, false);
+				  page, &last_block, 1, false);
 
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
@@ -371,8 +370,9 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 }
 
 static int erofs_raw_access_readpages(struct file *filp,
-	struct address_space *mapping,
-	struct list_head *pages, unsigned int nr_pages)
+				      struct address_space *mapping,
+				      struct list_head *pages,
+				      unsigned int nr_pages)
 {
 	erofs_off_t last_block;
 	struct bio *bio = NULL;
@@ -389,13 +389,13 @@ static int erofs_raw_access_readpages(struct file *filp,
 
 		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
 			bio = erofs_read_raw_page(bio, mapping, page,
-				&last_block, nr_pages, true);
+						  &last_block, nr_pages, true);
 
 			/* all the page errors are ignored when readahead */
 			if (IS_ERR(bio)) {
 				pr_err("%s, readahead error at page %lu of nid %llu\n",
-					__func__, page->index,
-					EROFS_V(mapping->host)->nid);
+				       __func__, page->index,
+				       EROFS_V(mapping->host)->nid);
 
 				bio = NULL;
 			}
diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index d1cb0d78ab84..49a4e7730df0 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -24,8 +24,8 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
 };
 
 static int erofs_fill_dentries(struct dir_context *ctx,
-	void *dentry_blk, unsigned int *ofs,
-	unsigned int nameoff, unsigned int maxsize)
+			       void *dentry_blk, unsigned int *ofs,
+			       unsigned int nameoff, unsigned int maxsize)
 {
 	struct erofs_dirent *de = dentry_blk;
 	const struct erofs_dirent *end = dentry_blk + nameoff;
@@ -101,9 +101,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		nameoff = le16_to_cpu(de->nameoff);
 
 		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
-			nameoff >= PAGE_SIZE)) {
+			     nameoff >= PAGE_SIZE)) {
 			errln("%s, invalid de[0].nameoff %u",
-				__func__, nameoff);
+			      __func__, nameoff);
 
 			err = -EIO;
 			goto skip_this;
-- 
2.19.2

