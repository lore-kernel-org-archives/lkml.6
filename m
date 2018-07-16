Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07E5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89353208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CZO3lTCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89353208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbeGPSxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:53:02 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:39940
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729859AbeGPSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765463; bh=YT4XtPaYorTY1lx0k8H0Qyb4L8QIc4WROnciGp7eUwc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CZO3lTCG7X3PqDv0CnVYtVyJeRUdLrMR5OuJ+cOZW4cPelLPAcDZrBXy/YpJxn5x1hV8HZ0hP+V8QN8UiNOZd9bASGkPD3x8MvglBmxwrNvKWALW9IbChTL0jHcIc4SbymfmNYb2XqxjfIJVnAaOVu8Ik/uZcxsZs787eJn1gLMoN1i7FI9OioltfMGiu+sRZvn3BaPnfggiSkYXGoGQTwfCz2W362PfIhKbfsfqnjf9Bphm+bDE/NFjFFc+kovOnAJiGP6PXSw5XUpd316N7Gv/bH5d7CsVAOeVRtJbcN5Pxot4VoA5Ym1tlTE6jOv2AqL9HUIcUiMLMaaVuo/q7w==
X-YMail-OSG: SjmZeegVM1n2ICC7iSoOGPB6uUMnE_FZMLVtMuKkxZSD69Wuf.TO1e4ux5WrtKV
 DyGUJv_49MW0Z6N92AM8rSG5DuN65_qNbRBn73esqdi06TNeAPNdrgSZTf4lh8zlw_eRRmiOmygK
 kbc6S8JeYFzKxz7v7E35wDhYj4bSGBZA_RcJN3mBJxVmRTTilYH22aoY0jFrH1yP1qioMbkTh_Dn
 Ul.v9je7REmeewa_4rHO6HOoRfRgpLwEliWMnlTlXa3yI28oH3azJmm0uoI73530dmHqcmkR4XFO
 rhe8VBwjICYDdgjLxeu_nc2traOsKciZusyRY1s33Ze.XsoNDConG.2d6wU70gxQS6mG7.b1UT3D
 eIo_8B6j1q9P4am4l2FIaZ2HFm1I_WC04y29lYmfdHwFxcE5LsMjhOzfPEsR9_AaAiuTjaKtu4BC
 RkqEJS_HiVmlOiSfPTgNrJzbZx5Rhv8cjgyskip5Zo2xcMZgdPm00FnlKEZNZhXJQDF2cjSM21CW
 v7_uY1h5T3zGOKwoCipSJJZqqcdfFSS_ToCLq0lNH5Eh1AozeLhweNhBE9mraoUM4ckb83GpUKlL
 LMqkMFokKxhTux2KnJCOTSHdLHPF10h7F0H_YjfSxwVjbORrzZvm5fGIqemyYRvPUfoRv8Od7nio
 Kz1aL_HChFHWSEg9LIluGiUx_lj161SdvfnRvWueM2A7xdyORDMglSyO6E_i0buAqLXbMx4zqeuk
 S9S6AcGPRjkVVa3.WBWMzrTJvv2oewTRHyed096z_NCcpsWHtkF1_nnOHrycJjInG2HYbeJn87Au
 UTAV8G7xgxTwAUwS2ZwXegJ4jneCJRBkX4LuXH45mXYPiRNmtjAkAp8pbB0VGWum1pAuDxnvSia3
 pbRn_CnLzoBQO6.73YN7kDjLaKSslxY95KDdcOR_FxlhBKjOjWRZjZpBRp10mK9Ap4cLbTiRq.hi
 Spz9X7CegU7N_3qAAECKa6eLSAbpTyqfV3d4ikVW7YpUfDOFuxKj9dJCMws9TBkre5Y4MNZUMPHk
 Cua3YG_5G6ivTh_irLPw9_tIR6TGSitc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:24:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fd4c14c77ada1fa0657ebb2422e4f129;
          Mon, 16 Jul 2018 18:24:21 +0000 (UTC)
Subject: [PATCH v1 17/22] LSM: Allow mount options from multiple security
 modules
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3e09ee96-6d54-bceb-e780-06e3244b7f2b@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:24:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LSM: Allow mount options from multiple security modules

Both SELinux and Smack use mount options that apply to
filesystems generally. Remove the failure case where the
security modules don't recognize an option. SELinux does
not recognize Smack's options, and vis versa.

The btrfs code had some misconceptions about the generality
of security modules and mount options. That has been
corrected.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/btrfs/super.c           | 10 ++---
 include/linux/security.h   | 45 ++++++++++++++-----
 security/security.c        | 14 ++++--
 security/selinux/hooks.c   | 90 +++++++++++++++++++-------------------
 security/smack/smack_lsm.c | 54 ++++++++++++-----------
 5 files changed, 122 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 81107ad49f3a..100cd32d5e16 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1490,15 +1490,15 @@ static int setup_security_options(struct btrfs_fs_info *fs_info,
 		return ret;
 
 #ifdef CONFIG_SECURITY
-	if (!fs_info->security_opts.num_mnt_opts) {
+	if (fs_info->security_opts.selinux.num_mnt_opts != 0 ||
+	    fs_info->security_opts.smack.num_mnt_opts != 0) {
 		/* first time security setup, copy sec_opts to fs_info */
 		memcpy(&fs_info->security_opts, sec_opts, sizeof(*sec_opts));
 	} else {
 		/*
-		 * Since SELinux (the only one supporting security_mnt_opts)
-		 * does NOT support changing context during remount/mount of
-		 * the same sb, this must be the same or part of the same
-		 * security options, just free it.
+		 * Since no modules support changing context during
+		 * remount/mount of the same sb, this must be the same
+		 * or part of the same security options, just free it.
 		 */
 		security_free_mnt_opts(sec_opts);
 	}
diff --git a/include/linux/security.h b/include/linux/security.h
index 9bdb23799b03..ea875e761d14 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -161,34 +161,55 @@ typedef int (*initxattrs) (struct inode *inode,
 
 #ifdef CONFIG_SECURITY
 
-struct security_mnt_opts {
+struct lsm_mnt_opts {
 	char **mnt_opts;
 	int *mnt_opts_flags;
 	int num_mnt_opts;
 };
 
+
+struct security_mnt_opts {
+#ifdef CONFIG_SECURITY_STACKING
+	struct lsm_mnt_opts     selinux;
+	struct lsm_mnt_opts     smack;
+#else
+	union {
+		struct lsm_mnt_opts     selinux;
+		struct lsm_mnt_opts     smack;
+	};
+#endif
+};
+
 int call_lsm_notifier(enum lsm_event event, void *data);
 int register_lsm_notifier(struct notifier_block *nb);
 int unregister_lsm_notifier(struct notifier_block *nb);
 
 static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
 {
-	opts->mnt_opts = NULL;
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+	memset(opts, 0, sizeof(*opts));
 }
 
 static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 {
 	int i;
-	if (opts->mnt_opts)
-		for (i = 0; i < opts->num_mnt_opts; i++)
-			kfree(opts->mnt_opts[i]);
-	kfree(opts->mnt_opts);
-	opts->mnt_opts = NULL;
-	kfree(opts->mnt_opts_flags);
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+
+	if (opts->selinux.mnt_opts)
+		for (i = 0; i < opts->selinux.num_mnt_opts; i++)
+			kfree(opts->selinux.mnt_opts[i]);
+	kfree(opts->selinux.mnt_opts);
+	opts->selinux.mnt_opts = NULL;
+	kfree(opts->selinux.mnt_opts_flags);
+	opts->selinux.mnt_opts_flags = NULL;
+	opts->selinux.num_mnt_opts = 0;
+
+	if (opts->smack.mnt_opts)
+		for (i = 0; i < opts->smack.num_mnt_opts; i++)
+			kfree(opts->smack.mnt_opts[i]);
+	kfree(opts->smack.mnt_opts);
+	opts->smack.mnt_opts = NULL;
+	kfree(opts->smack.mnt_opts_flags);
+	opts->smack.mnt_opts_flags = NULL;
+	opts->smack.num_mnt_opts = 0;
 }
 
 /* prototypes */
diff --git a/security/security.c b/security/security.c
index 878f0848b3f4..eea36930f6f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -782,9 +782,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-				opts->num_mnt_opts ? -EOPNOTSUPP : 0, sb,
-				opts, kern_flags, set_kern_flags);
+	int nobody = 0;
+
+	/*
+	 * Additional security modules that use mount options
+	 * need to be added here.
+	 */
+	if (opts->selinux.num_mnt_opts != 0 || opts->smack.num_mnt_opts != 0)
+		nobody = -EOPNOTSUPP;
+
+	return call_int_hook(sb_set_mnt_opts, nobody, sb, opts, kern_flags,
+				set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ab8a134d9945..fcdf1ea3c438 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -568,21 +568,23 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	/* count the number of mount options for this sb */
 	for (i = 0; i < NUM_SEL_MNT_OPTS; i++) {
 		if (tmp & 0x01)
-			opts->num_mnt_opts++;
+			opts->selinux.num_mnt_opts++;
 		tmp >>= 1;
 	}
 	/* Check if the Label support flag is set */
 	if (sbsec->flags & SBLABEL_MNT)
-		opts->num_mnt_opts++;
+		opts->selinux.num_mnt_opts++;
 
-	opts->mnt_opts = kcalloc(opts->num_mnt_opts, sizeof(char *), GFP_ATOMIC);
-	if (!opts->mnt_opts) {
+	opts->selinux.mnt_opts = kcalloc(opts->selinux.num_mnt_opts,
+						sizeof(char *), GFP_ATOMIC);
+	if (!opts->selinux.mnt_opts) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
 
-	opts->mnt_opts_flags = kcalloc(opts->num_mnt_opts, sizeof(int), GFP_ATOMIC);
-	if (!opts->mnt_opts_flags) {
+	opts->selinux.mnt_opts_flags = kcalloc(opts->selinux.num_mnt_opts,
+						sizeof(int), GFP_ATOMIC);
+	if (!opts->selinux.mnt_opts_flags) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
@@ -593,8 +595,8 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = FSCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = FSCONTEXT_MNT;
 	}
 	if (sbsec->flags & CONTEXT_MNT) {
 		rc = security_sid_to_context(&selinux_state,
@@ -602,16 +604,16 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = CONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = CONTEXT_MNT;
 	}
 	if (sbsec->flags & DEFCONTEXT_MNT) {
 		rc = security_sid_to_context(&selinux_state, sbsec->def_sid,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = DEFCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = DEFCONTEXT_MNT;
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
 		struct dentry *root = sbsec->sb->s_root;
@@ -621,15 +623,15 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 					     &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
 	}
 	if (sbsec->flags & SBLABEL_MNT) {
-		opts->mnt_opts[i] = NULL;
-		opts->mnt_opts_flags[i++] = SBLABEL_MNT;
+		opts->selinux.mnt_opts[i] = NULL;
+		opts->selinux.mnt_opts_flags[i++] = SBLABEL_MNT;
 	}
 
-	BUG_ON(i != opts->num_mnt_opts);
+	BUG_ON(i != opts->selinux.num_mnt_opts);
 
 	return 0;
 
@@ -675,9 +677,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
-	char **mount_options = opts->mnt_opts;
-	int *flags = opts->mnt_opts_flags;
-	int num_opts = opts->num_mnt_opts;
+	char **mount_options = opts->selinux.mnt_opts;
+	int *flags = opts->selinux.mnt_opts_flags;
+	int num_opts = opts->selinux.num_mnt_opts;
 
 	mutex_lock(&sbsec->lock);
 
@@ -1038,7 +1040,7 @@ static int selinux_parse_opts_str(char *options,
 	char *fscontext = NULL, *rootcontext = NULL;
 	int rc, num_mnt_opts = 0;
 
-	opts->num_mnt_opts = 0;
+	opts->selinux.num_mnt_opts = 0;
 
 	/* Standard string-based options. */
 	while ((p = strsep(&options, "|")) != NULL) {
@@ -1105,41 +1107,39 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_labelsupport:
 			break;
 		default:
-			rc = -EINVAL;
 			printk(KERN_WARNING "SELinux:  unknown mount option\n");
-			goto out_err;
-
+			break;
 		}
 	}
 
 	rc = -ENOMEM;
-	opts->mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *), GFP_KERNEL);
-	if (!opts->mnt_opts)
+	opts->selinux.mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *), GFP_KERNEL);
+	if (!opts->selinux.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
+	opts->selinux.mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
 				       GFP_KERNEL);
-	if (!opts->mnt_opts_flags)
+	if (!opts->selinux.mnt_opts_flags)
 		goto out_err;
 
 	if (fscontext) {
-		opts->mnt_opts[num_mnt_opts] = fscontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = fscontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
 	}
 	if (context) {
-		opts->mnt_opts[num_mnt_opts] = context;
-		opts->mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = context;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
 	}
 	if (rootcontext) {
-		opts->mnt_opts[num_mnt_opts] = rootcontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = rootcontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
 	}
 	if (defcontext) {
-		opts->mnt_opts[num_mnt_opts] = defcontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = defcontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
 	}
 
-	opts->num_mnt_opts = num_mnt_opts;
+	opts->selinux.num_mnt_opts = num_mnt_opts;
 	return 0;
 
 out_err:
@@ -1184,15 +1184,15 @@ static void selinux_write_opts(struct seq_file *m,
 	int i;
 	char *prefix;
 
-	for (i = 0; i < opts->num_mnt_opts; i++) {
+	for (i = 0; i < opts->selinux.num_mnt_opts; i++) {
 		char *has_comma;
 
-		if (opts->mnt_opts[i])
-			has_comma = strchr(opts->mnt_opts[i], ',');
+		if (opts->selinux.mnt_opts[i])
+			has_comma = strchr(opts->selinux.mnt_opts[i], ',');
 		else
 			has_comma = NULL;
 
-		switch (opts->mnt_opts_flags[i]) {
+		switch (opts->selinux.mnt_opts_flags[i]) {
 		case CONTEXT_MNT:
 			prefix = CONTEXT_STR;
 			break;
@@ -1218,7 +1218,7 @@ static void selinux_write_opts(struct seq_file *m,
 		seq_puts(m, prefix);
 		if (has_comma)
 			seq_putc(m, '\"');
-		seq_escape(m, opts->mnt_opts[i], "\"\n\\");
+		seq_escape(m, opts->selinux.mnt_opts[i], "\"\n\\");
 		if (has_comma)
 			seq_putc(m, '\"');
 	}
@@ -2807,10 +2807,10 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	if (rc)
 		goto out_free_secdata;
 
-	mount_options = opts.mnt_opts;
-	flags = opts.mnt_opts_flags;
+	mount_options = opts.selinux.mnt_opts;
+	flags = opts.selinux.mnt_opts_flags;
 
-	for (i = 0; i < opts.num_mnt_opts; i++) {
+	for (i = 0; i < opts.selinux.num_mnt_opts; i++) {
 		u32 sid;
 
 		if (flags[i] == SBLABEL_MNT)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index feff5290c839..2d1a3fba40eb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -601,7 +601,7 @@ static int smack_parse_opts_str(char *options,
 	int num_mnt_opts = 0;
 	int token;
 
-	opts->num_mnt_opts = 0;
+	opts->smack.num_mnt_opts = 0;
 
 	if (!options)
 		return 0;
@@ -651,43 +651,45 @@ static int smack_parse_opts_str(char *options,
 				goto out_err;
 			break;
 		default:
-			rc = -EINVAL;
 			pr_warn("Smack:  unknown mount option\n");
-			goto out_err;
+			break;
 		}
 	}
 
-	opts->mnt_opts = kcalloc(NUM_SMK_MNT_OPTS, sizeof(char *), GFP_KERNEL);
-	if (!opts->mnt_opts)
+	opts->smack.mnt_opts = kcalloc(NUM_SMK_MNT_OPTS, sizeof(char *),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
-			GFP_KERNEL);
-	if (!opts->mnt_opts_flags)
+	opts->smack.mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts_flags) {
+		kfree(opts->smack.mnt_opts);
 		goto out_err;
+	}
 
 	if (fsdefault) {
-		opts->mnt_opts[num_mnt_opts] = fsdefault;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSDEFAULT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsdefault;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSDEFAULT_MNT;
 	}
 	if (fsfloor) {
-		opts->mnt_opts[num_mnt_opts] = fsfloor;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSFLOOR_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsfloor;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSFLOOR_MNT;
 	}
 	if (fshat) {
-		opts->mnt_opts[num_mnt_opts] = fshat;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSHAT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fshat;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSHAT_MNT;
 	}
 	if (fsroot) {
-		opts->mnt_opts[num_mnt_opts] = fsroot;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSROOT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsroot;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSROOT_MNT;
 	}
 	if (fstransmute) {
-		opts->mnt_opts[num_mnt_opts] = fstransmute;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSTRANS_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fstransmute;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSTRANS_MNT;
 	}
 
-	opts->num_mnt_opts = num_mnt_opts;
+	opts->smack.num_mnt_opts = num_mnt_opts;
 	return 0;
 
 out_opt_err:
@@ -726,7 +728,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct inode_smack *isp;
 	struct smack_known *skp;
 	int i;
-	int num_opts = opts->num_mnt_opts;
+	int num_opts = opts->smack.num_mnt_opts;
 	int transmute = 0;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -760,33 +762,33 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	sp->smk_flags |= SMK_SB_INITIALIZED;
 
 	for (i = 0; i < num_opts; i++) {
-		switch (opts->mnt_opts_flags[i]) {
+		switch (opts->smack.mnt_opts_flags[i]) {
 		case FSDEFAULT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_default = skp;
 			break;
 		case FSFLOOR_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_floor = skp;
 			break;
 		case FSHAT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_hat = skp;
 			break;
 		case FSROOT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_root = skp;
 			break;
 		case FSTRANS_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_root = skp;
-- 
2.17.1


