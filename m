Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBZRrh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbeBZRrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:47:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB3921772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: set readdir_ra by default
Date: Mon, 26 Feb 2018 09:47:29 -0800
Message-Id: <20180226174731.26679-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
In-Reply-To: <20180226174731.26679-1-jaegeuk@kernel.org>
References: <20180226174731.26679-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gives general readdir improvement.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9515c10eebad..425eb4f6654a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1297,6 +1297,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
 	sbi->whint_mode = WHINT_MODE_OFF;
 	sbi->alloc_mode = ALLOC_MODE_DEFAULT;
+	sbi->readdir_ra = 1;
 
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_XATTR);
-- 
2.15.0.531.g2ccb3012c9-goog
