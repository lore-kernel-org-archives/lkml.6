Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeDLPUF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:20:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36876 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753424AbeDLPIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:53 -0400
X-Google-Smtp-Source: AIpwx49R7H4VaSTMD5E/Z6jM6nPFYT2C+a7YtqWuBzGIDbnccP5gP6JRtJo8Rurny8wsA1JpBwdILw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 18/35] ovl: readd O_DIRECT support
Date: Thu, 12 Apr 2018 17:08:09 +0200
Message-Id: <20180412150826.20988-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index cc004ff1b05b..9670e160967e 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -110,6 +110,9 @@ static int ovl_open(struct inode *inode, struct file *file)
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
+	/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
+	file->f_mapping = realfile->f_mapping;
+
 	file->private_data = realfile;
 
 	return 0;
-- 
2.14.3
