Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11E7C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8959921902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="iwxFaX+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfAZDsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:48:53 -0500
Received: from sonic308-10.consmr.mail.gq1.yahoo.com ([98.137.68.34]:38207
        "EHLO sonic308-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbfAZDsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1548474531; bh=Tgbyy0+WYLxJuuJAf2PBnpKmvAK6d+QO2tpjFxA6IEo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iwxFaX+FV52fqcam5bMMqzTx2+PPBTXgQ1EwpmTBPuohmVQosyZ3vB3vyObORDlhAeYC56nqorBF8X4oLM8lLHcJuy91SWg/1JXAIRfiljedujPKgCugn5ADM+1wg7rpb+9vsq+sK/uTzHm+FxrA/P10RktJhBXM+Fw5ce80vrRFODVluPaiuw7CRwT4d+AmJLEuBqfp+PMWDnDDbkqRMky2/SKv3FTJdy5GEDuJYB/G9R9orYR+h2gaheFLPw22e6i691Y8DXFP5alREa8slSS88EO5qEb0iEqWbLdDDWBDWkmDhulI6UGhlptG7H3bCeipbGQbUY4CzTP/9U/NAg==
X-YMail-OSG: veSKDGwVM1kSAw_10r9NgN.R2xbglUZOAOSe0VrcAJDUR7xHwZdNrYcYrs7ND9q
 h8UmrC7oNi8NdISpBWp4kBkpwYnjTP_LjQOiIRwl7JBwrgmpTey6pWjlAasdFl78dup_sXunujfv
 7DuFeiqBuF7SgfDpa8OMbJhvfBYp0GUYhpx31s5uyViPYfKl0wriorVaUMfY1mGZmPKciZaWqBN3
 ImfrZiCU5ZOWcJoMIFKe5uKvIGHnRxHFZiuPfpQ.3Sgn.LaylJLq6w9PDJJf6HvjHkODWodzBfdu
 mCXUODq4vKhxXhIGYEFL.P0a6NKIWmnrLGw7NlW53xfzVKxw.he8QQNVQAQU.CBQD0DsZoLcEYo4
 imj42aSeinGFK1cJSN984RAzzeuV1O_xa9m.HhAw7xG6gOgQPHKuQ4q2C35sdEUStWjol74QkvbF
 5Obys17AMnqFudNwWXkCHmN2.8im63zN.STzKoflLuPd8vHrrap4TATiM9Q8TxbpDwbw8ShbirM2
 .3ZObOHR9dtPtP1h9SCKXpouRa.BfmdPIldp3Tx9XIf2a2etSkIAV7WIr8Uh.C.YsutMxNj.dVwa
 KfyE_FhD_6eWfiiwhplEnA3er8zr1KQLggvpC68dOIHafsvPZWIbIRDiI8G1QqN2QcnvbfdQ0zuz
 ybX0leJcm2PlxmHenh_48EN6szXCiGQJYRI1BcCvmEOCpigK_FgRl0ZsRolYUQ1bsT9btMUa.0_f
 p_XWJEE_6rFJAdk.p_STnappo9j1biHPpBRNleJq0oBzWS1UJ07tqyC9mYe9SC0M2G5KnQpsc_QX
 mIEXtbB3WUc5jHYGERBbwlR.HXboTsFQ1Rvp33Z7IsiIaEC0sS2cDve3C_ZM0_Rpn24wXnkbhgjJ
 lP_cDaO1KoQ630B9n3NFMC5JPIDE6rRy1rnMQZdSJ2RJx.Hu6.pI6xEi.3yVAo_EQ4qA3Cetm_ht
 HXHORWtN1kCOVjH9qjIdrwyOHSfsxjKaUgXlYfPl4KAivkmYMA14o0ODSb4cdTzRDz8Yb8GRd0OP
 BO4gxZk9DLbGEuBSBpW9eMTQQlpngJ1lxkfOuYN0OaAAVCvTYIuZU7kxNbUgCtCqy
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 26 Jan 2019 03:48:51 +0000
Received: from 125.120.85.115 (EHLO localhost.localdomain) ([125.120.85.115])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5574a3d7169bdadf60e8591b428ea179;
          Sat, 26 Jan 2019 03:48:48 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, chao@kernel.org,
        weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 2/2] staging: erofs: complete POSIX ACL support
Date:   Sat, 26 Jan 2019 11:48:29 +0800
Message-Id: <20190126034829.11586-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190126034829.11586-1-hsiangkao@aol.com>
References: <20190126034829.11586-1-hsiangkao@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

Let's add .get_acl() to read the file's acl from its xattrs
to make POSIX ACL usable.

Here is the on-disk detail,
fullname: system.posix_acl_access
struct erofs_xattr_entry:
        .e_name_len = 0
        .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)

fullname: system.posix_acl_default
struct erofs_xattr_entry:
	.e_name_len = 0
	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v3:
 - kvmalloc -> erofs_kmalloc suggested by Chao;
 - update SB_POSIXACL for the remount case as well;

 .../erofs/Documentation/filesystems/erofs.txt      |  2 ++
 drivers/staging/erofs/inode.c                      |  3 ++
 drivers/staging/erofs/namei.c                      |  1 +
 drivers/staging/erofs/super.c                      | 10 ++++++
 drivers/staging/erofs/xattr.c                      | 37 ++++++++++++++++++++++
 drivers/staging/erofs/xattr.h                      |  6 ++++
 6 files changed, 59 insertions(+)

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
index 803988d74c21..961ec4da7705 100644
--- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
+++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
@@ -36,6 +36,8 @@ Here is the main features of EROFS:
 
  - Support xattr inline and tail-end data inline for all files;
 
+ - Support POSIX.1e ACLs by using xattrs;
+
  - Support transparent file compression as an option:
    LZ4 algorithm with 4 KB fixed-output compression for high performance;
 
diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 4f04f7c38cf2..924b8dfc7a8f 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -287,6 +287,7 @@ const struct inode_operations erofs_generic_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_symlink_iops = {
@@ -294,6 +295,7 @@ const struct inode_operations erofs_symlink_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_fast_symlink_iops = {
@@ -301,5 +303,6 @@ const struct inode_operations erofs_fast_symlink_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index 7fed1f996ab0..b1752adc5934 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -238,5 +238,6 @@ const struct inode_operations erofs_dir_iops = {
 #ifdef CONFIG_EROFS_FS_XATTR
 	.listxattr = erofs_listxattr,
 #endif
+	.get_acl = erofs_get_acl,
 };
 
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 176fca2af379..15c784fba879 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -398,6 +398,11 @@ static int erofs_read_super(struct super_block *sb,
 	if (!silent)
 		infoln("root inode @ nid %llu", ROOT_NID(sbi));
 
+	if (test_opt(sbi, POSIX_ACL))
+		sb->s_flags |= SB_POSIXACL;
+	else
+		sb->s_flags &= ~SB_POSIXACL;
+
 #ifdef CONFIG_EROFS_FS_ZIP
 	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
 #endif
@@ -646,6 +651,11 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto out;
 
+	if (test_opt(sbi, POSIX_ACL))
+		sb->s_flags |= SB_POSIXACL;
+	else
+		sb->s_flags &= ~SB_POSIXACL;
+
 	*flags |= SB_RDONLY;
 	return 0;
 out:
diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 7de46690d972..d2241f73a7b9 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -643,3 +643,40 @@ ssize_t erofs_listxattr(struct dentry *dentry,
 	return shared_listxattr(&it);
 }
 
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+struct posix_acl *erofs_get_acl(struct inode *inode, int type)
+{
+	struct posix_acl *acl;
+	int prefix, rc;
+	char *value = NULL;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		prefix = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	rc = erofs_getxattr(inode, prefix, "", NULL, 0);
+	if (rc > 0) {
+		value = erofs_kmalloc(EROFS_I_SB(inode), rc, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		rc = erofs_getxattr(inode, prefix, "", value, rc);
+	}
+
+	if (rc == -ENOATTR)
+		acl = NULL;
+	else if (rc < 0)
+		acl = ERR_PTR(rc);
+	else
+		acl = posix_acl_from_xattr(&init_user_ns, value, rc);
+	kfree(value);
+	return acl;
+}
+#endif
+
diff --git a/drivers/staging/erofs/xattr.h b/drivers/staging/erofs/xattr.h
index 634dae9aaa0b..35ba5ac2139a 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/drivers/staging/erofs/xattr.h
@@ -87,5 +87,11 @@ static ssize_t __maybe_unused erofs_listxattr(struct dentry *dentry,
 }
 #endif
 
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+struct posix_acl *erofs_get_acl(struct inode *inode, int type);
+#else
+#define erofs_get_acl	(NULL)
+#endif
+
 #endif
 
-- 
2.11.0

