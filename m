Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0589EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B049B208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B049B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933951AbeFLILn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:11:43 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:6045 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933714AbeFLIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:09:54 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 07/13] selinux: Cleanup printk logging in selinuxfs
Date:   Tue, 12 Jun 2018 10:09:06 +0200
Message-ID: <20180612080912.7827-8-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180612080912.7827-1-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk with pr_* to avoid checkpatch warnings.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/selinuxfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c0cadbc5f85c..2adfade99945 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -620,7 +620,7 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -956,7 +956,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -1147,7 +1147,7 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+		pr_err("SELinux: %s:  context size (%u) exceeds "
 			"payload max\n", __func__, len);
 		goto out;
 	}
@@ -1996,7 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 	return 0;
 err:
-	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
+	pr_err("SELinux: %s:  failed while creating inodes\n",
 		__func__);
 
 	selinux_fs_info_free(sb);
@@ -2046,7 +2046,7 @@ static int __init init_sel_fs(void)
 
 	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
 	if (IS_ERR(selinuxfs_mount)) {
-		printk(KERN_ERR "selinuxfs:  could not mount!\n");
+		pr_err("selinuxfs:  could not mount!\n");
 		err = PTR_ERR(selinuxfs_mount);
 		selinuxfs_mount = NULL;
 	}
-- 
2.15.1

