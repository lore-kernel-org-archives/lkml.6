Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFCC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334B320661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107795;
	bh=yCUkOtuKCOToOJahy/cZBjNqQy/KvRsGXe3ywKYCTvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1yVI/Q967vuAvIUytH7EVkrRDjxNCrEuNv5J4bo8Pa7BpjPg4v0HCEBsNqJFSso1
	 DkBJwSEYBja5YQ/CscrWuRfJ7k6E3T0A7p0QadkxFssyRAtgNCVKfLxT8A8KfyyTc7
	 bmWzoDYDpx8ZqeCdC6nFgGE6n2sLjOB4bXPeO1oI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334B320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeLFOty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbeLFOri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7BA12082B;
        Thu,  6 Dec 2018 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107657;
        bh=yCUkOtuKCOToOJahy/cZBjNqQy/KvRsGXe3ywKYCTvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiTdPmRus5xylUR6aAPesM9WArhuVgY1JCctVYVsHaY/oC3QiMdEIWrDsxWQa1xnl
         ZdCionnos+PpXrVxVluibMGhoz3A/VP/OCap+vc8NFDnJUvfJbsgLS1LHiRPijmnLy
         JQHzjDQSDMuMCdrYJ0TsAXw8eifPfF80nuEYW0d4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 090/101] f2fs: clean up with is_valid_blkaddr()
Date:   Thu,  6 Dec 2018 15:39:29 +0100
Message-Id: <20181206143017.988430652@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

commit 7b525dd01365c6764018e374d391c92466be1b7a upstream.

- rename is_valid_blkaddr() to is_valid_meta_blkaddr() for readability.
- introduce is_valid_blkaddr() for cleanup.

No logic change in this patch.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    4 ++--
 fs/f2fs/data.c       |    6 +++---
 fs/f2fs/f2fs.h       |    9 ++++++++-
 fs/f2fs/file.c       |    2 +-
 fs/f2fs/inode.c      |    2 +-
 fs/f2fs/node.c       |    5 ++---
 fs/f2fs/recovery.c   |    6 +++---
 fs/f2fs/segment.c    |    4 ++--
 fs/f2fs/segment.h    |    2 +-
 9 files changed, 23 insertions(+), 17 deletions(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -118,7 +118,7 @@ struct page *get_tmp_page(struct f2fs_sb
 	return __get_meta_page(sbi, index, false);
 }
 
-bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
+bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
@@ -173,7 +173,7 @@ int ra_meta_pages(struct f2fs_sb_info *s
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
-		if (!is_valid_blkaddr(sbi, blkno, type))
+		if (!is_valid_meta_blkaddr(sbi, blkno, type))
 			goto out;
 
 		switch (type) {
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -267,7 +267,7 @@ void f2fs_submit_page_mbio(struct f2fs_i
 
 	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
 
-	if (fio->old_blkaddr != NEW_ADDR)
+	if (is_valid_blkaddr(fio->old_blkaddr))
 		verify_block_addr(fio, fio->old_blkaddr);
 	verify_block_addr(fio, fio->new_blkaddr);
 
@@ -723,7 +723,7 @@ next_dnode:
 next_block:
 	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
+	if (!is_valid_blkaddr(blkaddr)) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -1217,7 +1217,7 @@ retry_encrypt:
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (unlikely(fio->old_blkaddr != NEW_ADDR &&
+	if (unlikely(is_valid_blkaddr(fio->old_blkaddr) &&
 			!is_cold_data(page) &&
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode))) {
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1930,6 +1930,13 @@ static inline void *f2fs_kvzalloc(size_t
 	(pgofs - ADDRS_PER_INODE(inode) + ADDRS_PER_BLOCK) /	\
 	ADDRS_PER_BLOCK * ADDRS_PER_BLOCK + ADDRS_PER_INODE(inode))
 
+static inline bool is_valid_blkaddr(block_t blkaddr)
+{
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+		return false;
+	return true;
+}
+
 /*
  * file.c
  */
@@ -2115,7 +2122,7 @@ void f2fs_stop_checkpoint(struct f2fs_sb
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_tmp_page(struct f2fs_sb_info *, pgoff_t);
-bool is_valid_blkaddr(struct f2fs_sb_info *, block_t, int);
+bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
 int ra_meta_pages(struct f2fs_sb_info *, block_t, int, int, bool);
 void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
 long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -316,7 +316,7 @@ static bool __found_offset(block_t blkad
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			(blkaddr != NEW_ADDR && blkaddr != NULL_ADDR))
+			is_valid_blkaddr(blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -63,7 +63,7 @@ static bool __written_first_block(struct
 {
 	block_t addr = le32_to_cpu(ri->i_addr[0]);
 
-	if (addr != NEW_ADDR && addr != NULL_ADDR)
+	if (is_valid_blkaddr(addr))
 		return true;
 	return false;
 }
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -304,8 +304,7 @@ static void set_node_addr(struct f2fs_sb
 			new_blkaddr == NULL_ADDR);
 	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
 			new_blkaddr == NEW_ADDR);
-	f2fs_bug_on(sbi, nat_get_blkaddr(e) != NEW_ADDR &&
-			nat_get_blkaddr(e) != NULL_ADDR &&
+	f2fs_bug_on(sbi, is_valid_blkaddr(nat_get_blkaddr(e)) &&
 			new_blkaddr == NEW_ADDR);
 
 	/* increment version no as node is removed */
@@ -320,7 +319,7 @@ static void set_node_addr(struct f2fs_sb
 
 	/* change address */
 	nat_set_blkaddr(e, new_blkaddr);
-	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -236,7 +236,7 @@ static int find_fsync_dnodes(struct f2fs
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
+		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
@@ -468,7 +468,7 @@ retry_dn:
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (is_valid_blkaddr(sbi, dest, META_POR)) {
+		if (is_valid_meta_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
@@ -527,7 +527,7 @@ static int recover_data(struct f2fs_sb_i
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
+		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
 		ra_meta_pages_cond(sbi, blkaddr);
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -944,7 +944,7 @@ bool is_checkpointed_data(struct f2fs_sb
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(blkaddr))
 		return true;
 
 	mutex_lock(&sit_i->sentry_lock);
@@ -1668,7 +1668,7 @@ void f2fs_wait_on_encrypted_page_writeba
 {
 	struct page *cpage;
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -81,7 +81,7 @@
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (sbi->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	(((blk_addr == NULL_ADDR) || (blk_addr == NEW_ADDR)) ?		\
+	((!is_valid_blkaddr(blk_addr)) ?			\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define GET_SECNO(sbi, segno)					\


