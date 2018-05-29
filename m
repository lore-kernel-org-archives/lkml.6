Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964968AbeE2QVi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935416AbeE2QVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:21:37 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: make __f2fs_write_data_pages() static
Date: Wed, 30 May 2018 00:20:39 +0800
Message-Id: <20180529162041.16005-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 fs/f2fs/f2fs.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97e6df852f37..10aa4d9a4b7c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2072,7 +2072,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-int __f2fs_write_data_pages(struct address_space *mapping,
+static int __f2fs_write_data_pages(struct address_space *mapping,
 						struct writeback_control *wbc,
 						enum iostat_type io_type)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c8e7f34ca290..18de7556dee8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2956,9 +2956,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
 bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
-int __f2fs_write_data_pages(struct address_space *mapping,
-						struct writeback_control *wbc,
-						enum iostat_type io_type);
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
-- 
2.16.2.17.g38e79b1fd
