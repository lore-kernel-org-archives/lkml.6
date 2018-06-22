Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06177C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09D024691
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="h9KhJEIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09D024691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933867AbeFVRQT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:16:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46154 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933691AbeFVRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:16:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so3775177pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X8oRFn2WsHOCIjr56251R7pQYV8m43bhYFOOqu4yP38=;
        b=h9KhJEIEk3HfqloznUDarL0zRTlmqBo6ifduFG/NiBLy85WeFWHCAiPV3/q/FdQAG6
         ohmBY2BWbKLQAq83BpnasOMUBgIxA0wLsS/eSEpjvxKXx3FtKm7HxqE0xq073/yEQC2X
         eSsTkE2AkhWIz8flZxZXUonxn0Zz5gowewsBv79GgKKQ1F3vndx/iKo3AjR2KpHxuvdq
         NUJD09+iSfEOfFn05mUGy8fRkr6wLESkrQr0+Yn5XNJMGkBAo1Gh4JmBEe5V4GWfs/09
         EK9JMMxfr8/B7bKkxuCWmWuOwWrenA3tpkmzUJo0xRxH4T5dNj5KXdSsP6DZ6TdoF8vE
         eCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X8oRFn2WsHOCIjr56251R7pQYV8m43bhYFOOqu4yP38=;
        b=hHo8yEN2Il9wn1d4a/jEXP+b5spe6ZZ/B+iFO0h0bwdYOrBkbMecYXMwzxe/7eGj+G
         LW815l2OZ+qpqmvX0wJ4pw3k6tSa5oh+3UDckgfRugFqh4Vll5fx/+3mEctvZKRsfYap
         bT7OzGV1xMsciIU80oAHo7ANC6pP0Elt8/phiDLuw7MJYWyrDfPtdUlsOeU19iavCv3Q
         KCP/7jjzn97xaXM+wzVCL5ggYpp3u2H2vi94cmMuWnbuGYbhv0XHArbsK+Pvqq+uiZSH
         nmvsfjBoBK3llTteeXSpou5r4TD0dTBxgcNGpRKgRBZDu462eIfTKxQNTxSs5PsEI4+U
         83rQ==
X-Gm-Message-State: APt69E1lZaI9vcWDjyJeTiKttGwaIXo2mCbxkjf5ARnoHDWWo8GetRul
        /7AH/dHUKw5DcdBsFJGvaoBxuV4S7wc=
X-Google-Smtp-Source: ADUXVKKHhNLzTtoo2n28+VawirGorg0eRb4cjHLP64AMzQQSJx5kkfSiUf2cLMMzt92C+Cxf9QFURw==
X-Received: by 2002:a17:902:7248:: with SMTP id c8-v6mr2598273pll.128.1529687775986;
        Fri, 22 Jun 2018 10:16:15 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id 9-v6sm19485824pfn.129.2018.06.22.10.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 10:16:15 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4] overlayfs: override_creds=off option bypass creator_cred
Date:   Fri, 22 Jun 2018 10:16:02 -0700
Message-Id: <20180622171605.52989-1-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
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
caller's credentials.  This option default is set in the CONFIG
OVERLAY_FS_OVERRIDE_CREDS or in the module option override_creds.

The module boolean parameter and mount option override_creds is also
added as a presence check for this "feature" by checking existence of
/sys/module/overlay/parameters/overlay_creds.  This will allow user
space to determine if the option can be supplied successfully to the
mount(2) operation.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
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

 Documentation/filesystems/overlayfs.txt | 17 +++++++++++++++++
 fs/overlayfs/Kconfig                    | 20 ++++++++++++++++++++
 fs/overlayfs/copy_up.c                  |  2 +-
 fs/overlayfs/dir.c                      |  9 +++++----
 fs/overlayfs/inode.c                    | 16 ++++++++--------
 fs/overlayfs/namei.c                    |  6 +++---
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/readdir.c                  |  4 ++--
 fs/overlayfs/super.c                    | 21 +++++++++++++++++++++
 fs/overlayfs/util.c                     | 12 ++++++++++--
 11 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
index 72615a2c0752..18e6d70ea4c9 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -106,6 +106,23 @@ Only the lists of names from directories are merged.  Other content
 such as metadata and extended attributes are reported for the upper
 directory only.  These attributes of the lower directory are hidden.
 
+credentials
+-----------
+
+By default, all access to the upper, lower and work directories is the
+recorded mounter's MAC and DAC credentials.  The incoming accesses are
+checked against the caller's credentials.
+
+If the principles of least privilege are applied, the mounter's
+credentials might not overlap the credentials of the caller's when
+accessing the overlayfs filesystem.  For example, a file that a lower
+DAC privileged caller can execute, is MAC denied to the generally
+higher DAC privileged mounter, to prevent an attack vector.  One
+option is to turn off override_creds in the mount options; all
+subsequent operations after mount on the filesystem will be only the
+caller's credentials.  This option default is set in the CONFIG
+OVERLAY_FS_OVERRIDE_CREDS or in the module option override_creds.
+
 whiteouts and opaque directories
 --------------------------------
 
diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index 9384164253ac..d21dde046b8d 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -103,3 +103,23 @@ config OVERLAY_FS_XINO_AUTO
 	  For more information, see Documentation/filesystems/overlayfs.txt
 
 	  If unsure, say N.
+
+config OVERLAY_FS_OVERRIDE_CREDS
+	bool "Overlay filesystem override credentials"
+	depends on OVERLAY_FS
+	default y
+	help
+	  If set, all access to the upper, lower and work directories is the
+	  recorded mounter's MAC and DAC credentials.  The incoming accesses
+	  are checked against the caller's credentials.
+
+	  If the principles of least privilege are applied, the mounter's
+	  credentials might not overlap the credentials of the caller's when
+	  accessing the overlayfs filesystem.  The mount option
+	  "override_creds=off" drops the mounter's credential check, so that
+	  all subsequent operations, after mount, on the filesystem will only
+	  be the caller's credentials.  This option sets the default for the
+	  module option override_creds, and thus the default for all mounts
+	  that do not specify this option.
+
+	  For more information see Documentation/filesystems/overlayfs.txt
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index ddaddb4ce4c3..7a841718ff2e 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -790,7 +790,7 @@ int ovl_copy_up_flags(struct dentry *dentry, int flags)
 		dput(parent);
 		dput(next);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f480b1a2cd2e..a9f10cd38e32 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -561,7 +561,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		override_cred->fsgid = inode->i_gid;
 		if (!attr->hardlink) {
 			err = security_dentry_create_files_as(dentry,
-					attr->mode, &dentry->d_name, old_cred,
+					attr->mode, &dentry->d_name,
+					old_cred ? old_cred : current_cred(),
 					override_cred);
 			if (err) {
 				put_cred(override_cred);
@@ -577,7 +578,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			err = ovl_create_over_whiteout(dentry, inode, attr);
 	}
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return err;
 }
 
@@ -824,7 +825,7 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 		err = ovl_remove_upper(dentry, is_dir, &list);
 	else
 		err = ovl_remove_and_whiteout(dentry, &list);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);
@@ -1150,7 +1151,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 out_unlock:
 	unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	ovl_nlink_end(new, locked);
 out_drop_write:
 	ovl_drop_write(old);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ed16a898caeb..afb0af1a24e9 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -49,7 +49,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
 		err = notify_change(upperdentry, attr, NULL);
-		revert_creds(old_cred);
+		ovl_revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
@@ -208,7 +208,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 		stat->nlink = dentry->d_inode->i_nlink;
 
 out:
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -242,7 +242,7 @@ int ovl_permission(struct inode *inode, int mask)
 		mask |= MAY_READ;
 	}
 	err = inode_permission(realinode, mask);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return err;
 }
@@ -259,7 +259,7 @@ static const char *ovl_get_link(struct dentry *dentry,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return p;
 }
 
@@ -302,7 +302,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		WARN_ON(flags != XATTR_REPLACE);
 		err = vfs_removexattr(realdentry, name);
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 out_drop_write:
 	ovl_drop_write(dentry);
@@ -320,7 +320,7 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_getxattr(realdentry, name, value, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return res;
 }
 
@@ -344,7 +344,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	res = vfs_listxattr(realdentry, list, size);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 
@@ -379,7 +379,7 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type)
 
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return acl;
 }
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index c993dd8db739..c53e0b127332 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1024,7 +1024,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		OVL_I(inode)->redirect = upperredirect;
 	}
 
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	dput(index);
 	kfree(stack);
 	kfree(d.redirect);
@@ -1043,7 +1043,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	kfree(upperredirect);
 out:
 	kfree(d.redirect);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	return ERR_PTR(err);
 }
 
@@ -1097,7 +1097,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			dput(this);
 		}
 	}
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 	return positive;
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7538b9b56237..81968e574264 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -195,6 +195,7 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
+void ovl_revert_creds(const struct cred *oldcred);
 struct super_block *ovl_same_sb(struct super_block *sb);
 int ovl_can_decode_fh(struct super_block *sb);
 struct dentry *ovl_indexdir(struct super_block *sb);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 41655a7d6894..ee4cc3802147 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -19,6 +19,7 @@ struct ovl_config {
 	bool index;
 	bool nfs_export;
 	int xino;
+	bool override_creds;
 };
 
 struct ovl_sb {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index ef1fe42ff7bb..150c7ee2f7f7 100644
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
@@ -906,7 +906,7 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 
 	old_cred = ovl_override_creds(dentry->d_sb);
 	err = ovl_dir_read_merged(dentry, list, &root);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 704b37311467..9f1e0cc85d27 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -56,6 +56,12 @@ module_param_named(xino_auto, ovl_xino_auto_def, bool, 0644);
 MODULE_PARM_DESC(ovl_xino_auto_def,
 		 "Auto enable xino feature");
 
+static bool __read_mostly ovl_default_override_creds =
+	IS_ENABLED(CONFIG_OVERLAY_FS_OVERRIDE_CREDS);
+module_param_named(override_creds, ovl_default_override_creds, bool, 0644);
+MODULE_PARM_DESC(ovl_default_override_creds,
+		 "Use mounter's credentials for accesses");
+
 static void ovl_entry_stack_free(struct ovl_entry *oe)
 {
 	unsigned int i;
@@ -376,6 +382,8 @@ static int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 						"on" : "off");
 	if (ofs->config.xino != ovl_xino_def())
 		seq_printf(m, ",xino=%s", ovl_xino_str[ofs->config.xino]);
+	seq_show_option(m, "override_creds",
+			ofs->config.override_creds ? "on" : "off");
 	return 0;
 }
 
@@ -413,6 +421,8 @@ enum {
 	OPT_XINO_ON,
 	OPT_XINO_OFF,
 	OPT_XINO_AUTO,
+	OPT_OVERRIDE_CREDS_ON,
+	OPT_OVERRIDE_CREDS_OFF,
 	OPT_ERR,
 };
 
@@ -429,6 +439,8 @@ static const match_table_t ovl_tokens = {
 	{OPT_XINO_ON,			"xino=on"},
 	{OPT_XINO_OFF,			"xino=off"},
 	{OPT_XINO_AUTO,			"xino=auto"},
+	{OPT_OVERRIDE_CREDS_ON,		"override_creds=on"},
+	{OPT_OVERRIDE_CREDS_OFF,	"override_creds=off"},
 	{OPT_ERR,			NULL}
 };
 
@@ -485,6 +497,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 	config->redirect_mode = kstrdup(ovl_redirect_mode_def(), GFP_KERNEL);
 	if (!config->redirect_mode)
 		return -ENOMEM;
+	config->override_creds = ovl_default_override_creds;
 
 	while ((p = ovl_next_opt(&opt)) != NULL) {
 		int token;
@@ -555,6 +568,14 @@ static int ovl_parse_opt(char *opt, struct ovl_config *config)
 			config->xino = OVL_XINO_AUTO;
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
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 6f1078028c66..0a59de9b4088 100644
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
@@ -630,7 +638,7 @@ int ovl_nlink_start(struct dentry *dentry, bool *locked)
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
 	err = ovl_set_nlink_upper(dentry);
-	revert_creds(old_cred);
+	ovl_revert_creds(old_cred);
 
 out:
 	if (err)
@@ -650,7 +658,7 @@ void ovl_nlink_end(struct dentry *dentry, bool locked)
 
 			old_cred = ovl_override_creds(dentry->d_sb);
 			ovl_cleanup_index(dentry);
-			revert_creds(old_cred);
+			ovl_revert_creds(old_cred);
 		}
 
 		mutex_unlock(&OVL_I(d_inode(dentry))->lock);
-- 
2.18.0.rc2.346.g013aa6912e-goog

