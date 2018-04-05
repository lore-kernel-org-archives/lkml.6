Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDEKvh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:51:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38348 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbeDEKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:51:23 -0400
X-Google-Smtp-Source: AIpwx48oJkd2m0ul6yy3HMNqNwhA6QuaCX3H5uoestRBHAmezBk8bMAbiEGw/78/7mpwXrVhNNZYbw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3 RESEND] nfsd: use follow_up_bind() helper
Date: Thu,  5 Apr 2018 12:51:03 +0200
Message-Id: <20180405105103.21572-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180405105103.21572-1-christian.brauner@ubuntu.com>
References: <20180405105103.21572-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/nfsd/vfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a3c9bfa77def..52e64036d2bd 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -141,8 +141,8 @@ static void follow_to_parent(struct path *path)
 {
 	struct dentry *dp;
 
-	while (path->dentry == path->mnt->mnt_root && follow_up(path))
-		;
+	follow_up_bind(path);
+
 	dp = dget_parent(path->dentry);
 	dput(path->dentry);
 	path->dentry = dp;
-- 
2.15.1
