Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51130C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0A620989
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WeJxYMnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0A620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbeKFDnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:43:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42340 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbeKFDnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:43:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so4846589plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdfTX5Uy+nHzdW2/QCYHmzoBdIi3/wnGKU+6o1XnO9c=;
        b=WeJxYMnuln55CLUseHAHvs7OGRLQW18Q9LHg3EJk7Q4vrmWnp8oGLGB1ul8MoKNRP4
         /lPwHQjDMQdamlZEKPycLlTDBHI2banLKf5I0dS8472EFSL6dWcFUBGP29r1EOnbUDdF
         Eig9X1lJl58A/DokLATDIlM5eN/RkoP4ixvL37UGwsdr7vRwT1TMe49YQqS6eygRbtFz
         jyeKtzamNJRHISk1wFfTzJ+HEj0aNKK3I3wb0bXF6wx+1zKqfCMxoHett9LVlRGR2C8+
         qBEv9DIgAF0Kovro1YhZr9ja88wA7uKGcEyvawhTCCXXOZ4Mu0fdZJYJ1scztsAD27pM
         kaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdfTX5Uy+nHzdW2/QCYHmzoBdIi3/wnGKU+6o1XnO9c=;
        b=mtMvAJ3RJPtTpdhY0Eq0utCR7e8NjQvOFw1tthUMGQbajIhxFmufn4lfeT3anKF6+l
         WTp7G4el9QRSu7nL7X0a0Es6V65gpa6kBjn0BvaV/2sCAPZmLBVpJsc7teFaOwcEfUaA
         8OztyyC1vlIqmkJrNGRZfKSFqTwBg/tMVWGzigVodiPgSdE6CrMcRpC6k/J3y//Kp2ch
         ncJS3VgfKVRe+E12MIojlguH6OnZT7igTS1+n85Q2wrqWuPDyr81AcYtgDzNMZljyX+e
         gJVvyNUaVqRRcq+8fGsdtEcVPrLTnDsvRUqJCVazejvJbFCbhG1e8RrGRI4S5RsBUqUb
         +f7g==
X-Gm-Message-State: AGRZ1gJI90OUlKUtTuUsvNVYAJHgpBtwBWJs3hnRwvG0P8b1gaT3WBFG
        ReF43DvHome/t1oe8LZwDbmhyRo/yms=
X-Google-Smtp-Source: AJdET5djQXMHyw4gMdh//HLr8eQRUpoPi8PHy448C1GIYRUkUZulCjkGiZ+75Mvbo7XZgEca2qJsqQ==
X-Received: by 2002:a17:902:107:: with SMTP id 7-v6mr23350621plb.267.1541442134113;
        Mon, 05 Nov 2018 10:22:14 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id s184-v6sm53788626pfb.46.2018.11.05.10.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 10:22:13 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com
Subject: [PATCH v6 2/2] overlayfs: override_creds=off option bypass creator_cred
Date:   Mon,  5 Nov 2018 10:21:42 -0800
Message-Id: <20181105182146.233025-3-salyzyn@android.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181105182146.233025-1-salyzyn@android.com>
References: <20181105182146.233025-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, all access to the upper, lower and work directories is the
recorded mounter's MAC and DAC credentials.  The incoming accesses are
checked against the caller's credentials.

If the principles of least privilege are applied, the mounter's
credentials might not overlap the credentials of the caller's when
accessing the overlayfs filesystem.  For example, a file that a lower
DAC privileged caller can execute, is MAC denied to the generally
higher DAC privileged mounter, to prevent an attack vector.

We add the option to turn off override_creds in the mount options; all
subsequent operations after mount on the filesystem will be only the
caller's credentials.  The module boolean parameter and mount option
override_creds is also added as a presence check for this "feature",
existence of /sys/module/overlay/parameters/overlay_creds.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com

v2:
- Forward port changed attr to stat, resulting in a build error.
- altered commit message.

v3:
- Change name from caller_credentials / creator_credentials to the
  boolean override_creds.
- Changed from creator to mounter credentials.
- Updated and fortified the documentation.
- Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS

v4:
- spelling and grammar errors in text

v5:
- beefed up the caveats in the Documentation
- Is dependent on
  "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
  "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
- Added prwarn when override_creds=off

v6:
- Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
- Do better with the documentation.
- pr_warn message adjusted to report consequences.
---
 Documentation/filesystems/overlayfs.txt | 17 +++++++++++++++++
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/dir.c                      |  9 +++++----
 fs/overlayfs/inode.c                    | 16 ++++++++--------
 fs/overlayfs/namei.c                    |  6 +++---
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  4 ++--
 fs/overlayfs/super.c                    | 23 ++++++++++++++++++++++-
 fs/overlayfs/util.c                     | 12 ++++++++++--
 10 files changed, 70 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index eef7d9d259e8..5cc299df4436 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -102,6 +102,23 @@ Only the lists of names from directories are merged.  Other content
 such as metadata and extended attributes are reported for the upper
 directory only.  These attributes of the lower directory are hidden.
 
+credentials
+-----------
+
+By default, all access to the upper, lower and work directories is the
+recorded mounter's MAC and DAC credentials.  The incoming accesses are
+checked against the caller's credentials.
+
+override_creds mount flag turned off is reserved for when mounter and
+caller MAC or DAC credentials do not overlap.  Several unintended side
+effects will occur.  The caller with a lower privilege will not be
+able to delete files or directories, create nodes, or search some
+directories.  The caller with higher privilege can perform unexpected
+or unsecured operations.  The uneven security model where upperdir
+and workdir are opened at privilege, but accessed without, should only
+be used with strict understanding of the side effects and of the
+security policies.
+
 whiteouts and opaque directories
 --------------------------------
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 9e62dcf06fc4..dfab62ce7504 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -860,7 +860,7 @@ int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index c6289147c787..b7052e23c467 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -566,7 +566,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		override_cred->fsgid = inode->i_gid;
 		if (!attr->hardlink) {
 			err = security_dentry_create_files_as(dentry,
-					attr->mode, &dentry->d_name, old_cred,
+					attr->mode, &dentry->d_name,
+					old_cred ? old_cred : current_cred(),
 					override_cred);
 			if (err) {
 				put_cred(override_cred);
@@ -582,7 +583,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -842,7 +843,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1212,7 +1213,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 out_drop_write:
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 6bcc9dedc342..192f5508ed45 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -64,7 +64,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = notify_change(upperdentry, attr, NULL);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -260,7 +260,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -303,7 +303,7 @@ int ovl_permission(struct inode *inode, int mask)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	err = inode_permission(realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -320,7 +320,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return p;
 }
 
@@ -363,7 +363,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		WARN_ON(flags != XATTR_REPLACE);
 		err = vfs_removexattr(realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	/* copy c/mtime */
 	ovl_copyattr(d_inode(realdentry), inode);
@@ -384,7 +384,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_getxattr(realdentry, name, value, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return res;
 }
 
@@ -408,7 +408,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -443,7 +443,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return acl;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index aa012b6bd46e..b73e5f7aea2e 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1074,7 +1074,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			goto out_free_oe;
 	}
 
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (origin_path) {
 		dput(origin_path->dentry);
 		kfree(origin_path);
@@ -1101,7 +1101,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1155,7 +1155,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 5e45cb3630a0..6f8b6f9ff357 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -208,6 +208,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(const struct cred *oldcred);
 struct super_block *ovl_same_sb(struct super_block *sb);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index ec237035333a..e38eea8104be 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -20,6 +20,7 @@ struct ovl_config {
 	bool nfs_export;
 	int xino;
 	bool metacopy;
+	bool override_creds;
 };
 
 struct ovl_sb {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index cc8303a806b4..ec591b49e902 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -289,7 +289,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 		}
 		inode_unlock(dir->d_inode);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -921,7 +921,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0116735cc321..1669d4fa7ad8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -56,6 +56,11 @@ module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
 MODULE_PARM_DESC(ovl_xino_auto_def,
 		 "Auto enable xino feature");
 
+static bool __read_mostly ovl_default_override_creds = true;
+module_param_named(override_creds, ovl_default_override_creds, bool, 0644);
+MODULE_PARM_DESC(ovl_default_override_creds,
+		 "Use mounter's credentials for accesses");
+
 static void ovl_entry_stack_free(struct ovl_entry *oe)
 {
 	unsigned int i;
@@ -362,6 +367,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	if (ofs->config.metacopy != ovl_metacopy_def)
 		seq_printf(m, ",metacopy=%s",
 			   ofs->config.metacopy ? "on" : "off");
+	seq_show_option(m, "override_creds",
+			ofs->config.override_creds ? "on" : "off");
 	return 0;
 }
 
@@ -401,6 +408,8 @@ enum {
 	OPT_XINO_AUTO,
 	OPT_METACOPY_ON,
 	OPT_METACOPY_OFF,
+	OPT_OVERRIDE_CREDS_ON,
+	OPT_OVERRIDE_CREDS_OFF,
 	OPT_ERR,
 };
 
@@ -419,6 +428,8 @@ static const match_table_t ovl_tokens = {
 	{OPT_XINO_AUTO,			"xino=auto"},
 	{OPT_METACOPY_ON,		"metacopy=on"},
 	{OPT_METACOPY_OFF,		"metacopy=off"},
+	{OPT_OVERRIDE_CREDS_ON,		"override_creds=on"},
+	{OPT_OVERRIDE_CREDS_OFF,	"override_creds=off"},
 	{OPT_ERR,			NULL}
 };
 
@@ -477,6 +488,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
 		return -ENOMEM;
+	config->override_creds = ovl_default_override_creds;
 
 	while ((p = ovl_next_opt(&opt)) != NULL) {
 		int token;
@@ -557,6 +569,14 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->metacopy = false;
 			break;
 
+		case OPT_OVERRIDE_CREDS_ON:
+			config->override_creds = true;
+			break;
+
+		case OPT_OVERRIDE_CREDS_OFF:
+			config->override_creds = false;
+			break;
+
 		default:
 			pr_err("overlayfs: unrecognized mount option \"%s\" or missing value\n", p);
 			return -EINVAL;
@@ -1549,7 +1569,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		       ovl_dentry_lower(root_dentry), NULL);
 
 	sb->s_root = root_dentry;
-
+	if (!ofs->config.override_creds)
+		pr_warn("overlayfs: override_creds=off, caller credentials may not be enough to delete file or directories, create nodes, or search directories.\n");
 	return 0;
 
 out_free_oe:
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7c01327b1852..484d7f76ac9c 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -40,9 +40,17 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
 
+	if (!ofs->config.override_creds)
+		return NULL;
 	return override_creds(ofs->creator_cred);
 }
 
+void ovl_revert_creds(const struct cred *old_cred)
+{
+	if (old_cred)
+		revert_creds(old_cred);
+}
+
 struct super_block *ovl_same_sb(struct super_block *sb)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
@@ -782,7 +790,7 @@ int ovl_nlink_start(struct dentry *dentry)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 out:
 	if (err)
@@ -800,7 +808,7 @@ void ovl_nlink_end(struct dentry *dentry)
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 		ovl_cleanup_index(dentry);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);
-- 
2.19.1.930.g4563a0d9d0-goog

