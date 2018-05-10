Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966494AbeEJPqk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:46:40 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:46048 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966316AbeEJPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:36 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:69:355:379:541:800:960:966:968:973:988:989:1260:1345:1359:1437:1534:1543:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2894:2910:3138:3139:3140:3141:3142:3354:3867:4321:4385:4419:4605:5007:6119:6261:6642:8603:9040:10004:10848:11026:11658:11914:12043:12296:12438:12555:12895:12986:13142:13230:14181:14394:14721:21080:21433:21451:21627:30045:30051:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: roof93_1c46e0fd4fa3a
X-Filterd-Recvd-Size: 4483
From: Joe Perches <joe@perches.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] security: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:41 -0700
Message-Id: <799f2558f37c5480d42c03e3465754aa8bb30e70.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 security/selinux/selinuxfs.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c0cadbc5f85c..be8f186a6256 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -515,19 +515,19 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi)
 
 	ret = sel_make_bools(fsi);
 	if (ret) {
-		pr_err("SELinux: failed to load policy booleans\n");
+		pr_err("failed to load policy booleans\n");
 		return ret;
 	}
 
 	ret = sel_make_classes(fsi);
 	if (ret) {
-		pr_err("SELinux: failed to load policy classes\n");
+		pr_err("failed to load policy classes\n");
 		return ret;
 	}
 
 	ret = sel_make_policycap(fsi);
 	if (ret) {
-		pr_err("SELinux: failed to load policy capabilities\n");
+		pr_err("failed to load policy capabilities\n");
 		return ret;
 	}
 
@@ -570,7 +570,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	length = security_load_policy(fsi->state, data, count);
 	if (length) {
-		pr_warn_ratelimited("SELinux: failed to load policy\n");
+		pr_warn_ratelimited("failed to load policy\n");
 		goto out;
 	}
 
@@ -620,8 +620,8 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
+		pr_err("%s:  context size (%u) exceeds payload max\n",
+		       __func__, len);
 		goto out;
 	}
 
@@ -956,8 +956,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
+		pr_err("%s:  context size (%u) exceeds payload max\n",
+		       __func__, len);
 		goto out;
 	}
 
@@ -1147,8 +1147,8 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 
 	length = -ERANGE;
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
-			"payload max\n", __func__, len);
+		pr_err("%s:  context size (%u) exceeds payload max\n",
+		       __func__, len);
 		goto out;
 	}
 
@@ -1389,8 +1389,8 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
-			pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
-					   page);
+			pr_warn_ratelimited("no sid found, defaulting to security isid for %s\n",
+					    page);
 			sid = SECINITSID_SECURITY;
 		}
 
@@ -1996,8 +1996,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
 		goto err;
 	return 0;
 err:
-	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
-		__func__);
+	pr_err("%s:  failed while creating inodes\n", __func__);
 
 	selinux_fs_info_free(sb);
 
@@ -2046,7 +2045,7 @@ static int __init init_sel_fs(void)
 
 	selinux_null.mnt = selinuxfs_mount = kern_mount(&sel_fs_type);
 	if (IS_ERR(selinuxfs_mount)) {
-		printk(KERN_ERR "selinuxfs:  could not mount!\n");
+		pr_err("selinuxfs:  could not mount!\n");
 		err = PTR_ERR(selinuxfs_mount);
 		selinuxfs_mount = NULL;
 	}
-- 
2.15.0
