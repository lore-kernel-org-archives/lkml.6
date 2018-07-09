Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E81C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDDA2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDDA2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbeGIEzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:55:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754457AbeGIEyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBo-0003gn-LY; Mon, 09 Jul 2018 04:54:20 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 26/27] make alloc_file() static
Date:   Mon,  9 Jul 2018 05:54:16 +0100
Message-Id: <20180709045417.13988-26-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c      | 3 +--
 include/linux/file.h | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index fb7c3b007630..ffb0036a24f6 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -155,7 +155,7 @@ struct file *get_empty_filp(void)
  * @mode: the mode with which the new file will be opened
  * @fop: the 'struct file_operations' for the new file
  */
-struct file *alloc_file(const struct path *path, fmode_t mode,
+static struct file *alloc_file(const struct path *path, fmode_t mode,
 		const struct file_operations *fop)
 {
 	struct file *file;
@@ -180,7 +180,6 @@ struct file *alloc_file(const struct path *path, fmode_t mode,
 		i_readcount_inc(path->dentry->d_inode);
 	return file;
 }
-EXPORT_SYMBOL(alloc_file);
 
 struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 				const char *name, fmode_t mode,
diff --git a/include/linux/file.h b/include/linux/file.h
index c2e38ec2ee7f..233780fec647 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -19,8 +19,6 @@ struct vfsmount;
 struct dentry;
 struct inode;
 struct path;
-extern struct file *alloc_file(const struct path *, fmode_t mode,
-	const struct file_operations *fop);
 extern struct file *alloc_file_pseudo(struct inode *, struct vfsmount *,
 	const char *, fmode_t, const struct file_operations *);
 extern struct file *alloc_file_clone(struct file *, fmode_t,
-- 
2.11.0

