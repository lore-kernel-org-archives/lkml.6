Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755991AbeDXGZf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:25:35 -0400
Received: from hs01.dk-sys.de ([173.249.23.66]:40986 "EHLO hs01.dk-sys.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbeDXGZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:25:34 -0400
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH resend] vfs: namei: use path_equal() in follow_dotdot()
Date: Tue, 24 Apr 2018 08:25:31 +0200
Message-Id: <20180424062531.14600-1-danilokrummrich@dk-develop.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use path_equal() to detect whether we're already in root.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 fs/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 186bd2464fd5..6f0dc40f88c5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1438,10 +1438,8 @@ static int path_parent_directory(struct path *path)
 static int follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
-		if (nd->path.dentry == nd->root.dentry &&
-		    nd->path.mnt == nd->root.mnt) {
+		if (path_equal(&nd->path, &nd->root))
 			break;
-		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			int ret = path_parent_directory(&nd->path);
 			if (ret)
-- 
2.17.0
