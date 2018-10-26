Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDBDECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F5420834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F5420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeJ0Crv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:47:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38462 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeJ0Cru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:47:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gG6W1-0001L0-NT; Fri, 26 Oct 2018 18:07:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: fix spelling mistake, EACCESS -> EACCES
Date:   Fri, 26 Oct 2018 19:07:21 +0100
Message-Id: <20181026180721.5040-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to a spelling mistake of the error access name EACCESS,
rename to EACCES

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/file.c  | 2 +-
 fs/cifs/inode.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 84477e995246..6894d071850a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1003,7 +1003,7 @@ cifs_lock_add(struct cifsFileInfo *cfile, struct cifsLockInfo *lock)
  * Set the byte-range lock (mandatory style). Returns:
  * 1) 0, if we set the lock and don't need to request to the server;
  * 2) 1, if no locks prevent us but we need to request to the server;
- * 3) -EACCESS, if there is a lock that prevents us and wait is false.
+ * 3) -EACCES, if there is a lock that prevents us and wait is false.
  */
 static int
 cifs_lock_add_if(struct cifsFileInfo *cfile, struct cifsLockInfo *lock,
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 0945d40030eb..3685e2c25205 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1305,8 +1305,8 @@ cifs_drop_nlink(struct inode *inode)
 /*
  * If d_inode(dentry) is null (usually meaning the cached dentry
  * is a negative dentry) then we would attempt a standard SMB delete, but
- * if that fails we can not attempt the fall back mechanisms on EACCESS
- * but will return the EACCESS to the caller. Note that the VFS does not call
+ * if that fails we can not attempt the fall back mechanisms on EACCES
+ * but will return the EACCES to the caller. Note that the VFS does not call
  * unlink on negative dentries currently.
  */
 int cifs_unlink(struct inode *dir, struct dentry *dentry)
-- 
2.19.1

