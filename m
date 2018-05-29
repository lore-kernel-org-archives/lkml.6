Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936676AbeE2Os2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:48:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34911 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936572AbeE2Oqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:50 -0400
X-Google-Smtp-Source: ADUXVKJ7TjIzpl97Gxbn49Mm6zyya8wMxAjPsZohL61MULuuvH65hEo7rAT29tw0WDDPgwVsmNfrDQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/28] ovl: Enable metadata only feature
Date: Tue, 29 May 2018 16:46:12 +0200
Message-Id: <20180529144612.16675-29-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivek Goyal <vgoyal@redhat.com>

All the bits are in patches before this.  So it is time to enable the
metadata only copy up feature.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index c31f198bed99..bdadedf73e51 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -689,9 +689,6 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 {
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
 
-	/* TODO: Will enable metacopy in last patch of series */
-	return false;
-
 	if (!ofs->config.metacopy)
 		return false;
 
-- 
2.14.3
