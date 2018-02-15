Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032618AbeBOCdX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:33:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032437AbeBOCdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:33:22 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH] namei: fix hardlink speeling error
Date: Wed, 14 Feb 2018 21:28:54 -0500
Message-Id: <68d4b8c4ad6b85d4336f2a2893e3ea04ffdc7794.1518661649.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix handlink to hardlink.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf1c046b..bbfb21d3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4258,7 +4258,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	/*
 	 * To use null names we require CAP_DAC_READ_SEARCH
 	 * This ensures that not everyone will be able to create
-	 * handlink using the passed filedescriptor.
+	 * hardlink using the passed filedescriptor.
 	 */
 	if (flags & AT_EMPTY_PATH) {
 		if (!capable(CAP_DAC_READ_SEARCH))
-- 
1.8.3.1
