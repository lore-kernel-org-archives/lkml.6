Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2517369-1527194977-2-2344292312382419544
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527194977; b=X1anvHSKjMlEM2TmLQzrlg74tYPOFDE1EJqlyZY6/2z+3AYX9a
    MaUW/Y5JJjupC2Te6cjUXymHVY7vt7S9alqLq0tl8Rhj/dPmzWe7FQ2fedLVLhwO
    Glc/Kc/7Hzfwd9tyGsR81vTspiYZXSafVCQkwMyjsf49Hd0UOtDtBzMoKmBUiRBS
    u49NYK9D11TeLVlyWa2buy0ajxz/bH02KnN3cA6ZO8SXZj+fJ1eUzP3/xix7VJ/L
    9f7Dd0taBej16Gw3kAxH+buKTiJSAGRMBWASWG8DweGZBPG1gS0KBebpxSW/u3WQ
    6vJFjq1j65TyZL7Wok+eMBSJyPJ1mGcH6LGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527194977; bh=Ur30lIrtt5+ssAtiJOkd1aFOxqdcMci3WSVSiIvsCE
    0=; b=BRpxruoi0ZCu1K7NMGwAzb2sUKC2FWlFuhUmRSB6VxvcoQD6WlzTPPJ883
    KFsOCvtRSw1jqYQdy+EuKOUsMXTJ+OxoW3bUtBQkL3w0jRI6MtYR3zFhpHsGzQEN
    7q7R23K9pIcpWUKy8/A+zxMirANEfXmnpp80T6UbA1M2NRg/9Rb0bD8KGkp0yM11
    SV2X7UtLTBssMltq0LG22t6t/M9GWJb/BEWLR9uDOHQISXh4WSChjvLK9tA/bzCJ
    t+0cJDcIgrkK5ZDDseGQW+izHlSPISZ9cPatCqYtbHXGPWBf7BMnsNGM47WjmwrK
    6BDFG+zhEZaUtwtc35rHbEVn5a4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXNrxtmDh/J8aAXtj0O4B5VKDwvEe8nJiR7afnEOi/FvGLBQargFGPKjXEkC7+l1DZRVkbjKsYsezGryXFu4eomCqlB+T2YVCebZ0LWBCVvMz0Rb4xq
    Jg4pJjKhqTdl852R0JS286dX5UpoKSflkfQpzxwxDR8COdMCT+x30f0/mgmxWV1fzVLz4Cnp01owME7Ax1gIfxE6bK6BlxZ0NwEEWpxuC/IpDD1516SRqf8J
    APFeG931DzTrNIskmiEnyw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=Hf9pux9KUHb8ATNw61MA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969351AbeEXUtd (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 16:49:33 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51139 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966945AbeEXUtb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 16:49:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 24 May 2018 15:49:15 -0500
In-Reply-To: <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
        (Mimi Zohar's message of "Thu, 24 May 2018 07:09:30 -0400")
Message-ID: <87po1k2304.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLxAu-0004wu-Rn;;;mid=<87po1k2304.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+L8W1WAKAHd5isPyRnG5M11o/40QIvxtk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 754 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.4%), b_tie_ro: 2.2 (0.3%), parse: 2.2 (0.3%),
        extract_message_metadata: 13 (1.8%), get_uri_detail_list: 10 (1.4%),
        tests_pri_-1000: 6 (0.7%), tests_pri_-950: 1.72 (0.2%), tests_pri_-900: 1.37
        (0.2%), tests_pri_-400: 59 (7.8%), check_bayes: 58 (7.6%), b_tokenize: 31
        (4.1%), b_tok_get_all: 14 (1.9%), b_comp_prob: 4.6 (0.6%), b_tok_touch_all: 6
        (0.7%), b_finish: 0.70 (0.1%), tests_pri_0: 647 (85.7%),
        check_dkim_signature: 0.86 (0.1%), check_dkim_adsp: 2.9 (0.4%),
        tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I already nacked this approach because the two cases don't
share a bit of code.  When I looked closer it was even crazier.

The way ima uses this hook and the post_load hook today is a travesty.

The way the security_kernel_file_read and security_kernel_file_post_read
are called today and are used by ima don't make the least little bit of
sense.

Abusing security_kernel_file_read in the module loader and then abusing
security_kernel_file_post_read in the firmware loader is insane.  The
loadpin lsm could not even figure this out and so it failed to work
because of these shenanighans.

Only implementing kernel_file_read to handle the !file case is pretty
much insane.   There is no way this should be expanded to cover kexec
until the code actually makes sense.  We need a maintainable kernel.

Below is where I suggest you start on sorting out these security hooks.
- Adding a security_kernel_arg to catch when you want to allow/deny the
  use of an argument to a syscall.  What security_kernel_file_read and
  security_kernel_file_post_read have been abused for.

- Removing ima_file_read because it is completely subsumed by the new
  call.

- Please note with adding this new hook there is no code shared between
  the cases, and the lsm code becomes simpler shorter when it can assume
  security_kernel_file_post_read always takes a struct file.  (Even with
  the addition of a new security hook).

Eric

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 358354148dec..04536ff81bd2 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -294,9 +294,7 @@ static ssize_t firmware_loading_store(struct device *dev,
 				dev_err(dev, "%s: map pages failed\n",
 					__func__);
 			else
-				rc = security_kernel_post_read_file(NULL,
-						fw_priv->data, fw_priv->size,
-						READING_FIRMWARE);
+				rc = security_kernel_arg(KARG_FIRMWARE);
 
 			/*
 			 * Same logic as fw_load_abort, only the DONE bit
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..9fb42736ba29 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 struct linux_binprm;
 
@@ -19,7 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
+extern int ima_kernel_arg(enum kernel_arg_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
@@ -49,7 +50,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+static inline int ima_kernel_arg(enum kernel_arg_id id)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9d0b286f3dba..7f8bc3030784 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -576,6 +576,10 @@
  *	userspace to load a kernel module with the given name.
  *	@kmod_name name of the module requested by the kernel
  *	Return 0 if successful.
+ * @kernel_arg:
+ *	Use a syscall argument
+ *	@id kernel argument identifier
+ *	Return 0 if permission is granted.
  * @kernel_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
@@ -1577,6 +1581,7 @@ union security_list_options {
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
+	int (*kernel_arg)(enum kernel_arg_id id);
 	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
 	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
 				     enum kernel_read_file_id id);
@@ -1866,6 +1871,7 @@ struct security_hook_heads {
 	struct hlist_head cred_getsecid;
 	struct hlist_head kernel_act_as;
 	struct hlist_head kernel_create_files_as;
+	struct hlist_head kernel_arg;
 	struct hlist_head kernel_read_file;
 	struct hlist_head kernel_post_read_file;
 	struct hlist_head kernel_module_request;
diff --git a/include/linux/security.h b/include/linux/security.h
index 200920f521a1..6cf1bd87f041 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -159,6 +159,32 @@ extern int mmap_min_addr_handler(struct ctl_table *table, int write,
 typedef int (*initxattrs) (struct inode *inode,
 			   const struct xattr *xattr_array, void *fs_data);
 
+#define __kernel_arg_id(id) \
+	id(UNKNOWN, unknown)		\
+	id(FIRMWARE, firmware)		\
+	id(MODULE, kernel-module)	\
+	id(MAX_ID, )
+
+#define __karg_enumify(ENUM, dummy) KARG_ ## ENUM,
+#define __karg_stringify(dummy, str) #str,
+
+enum kernel_arg_id {
+	__kernel_arg_id(__karg_enumify)
+};
+
+static const char * const kernel_arg_str[] = {
+	__kernel_arg_id(__karg_stringify)
+};
+
+static inline const char *kernel_arg_id_str(enum kernel_arg_id id)
+{
+	if ((unsigned)id >= KARG_MAX_ID)
+		return kernel_arg_str[KARG_UNKNOWN];
+
+	return kernel_arg_str[id];
+}
+
+
 #ifdef CONFIG_SECURITY
 
 struct security_mnt_opts {
@@ -326,6 +352,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
+int security_kernel_arg(enum kernel_arg_id id);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
@@ -923,6 +950,11 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
+static inline int security_kernel_arg(enum kernel_arg_id id)
+{
+	return 0;
+}
+
 static inline int security_kernel_read_file(struct file *file,
 					    enum kernel_read_file_id id)
 {
diff --git a/kernel/module.c b/kernel/module.c
index ce8066b88178..03a1dd21ad4a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_read_file(NULL, READING_MODULE);
+	err = security_kernel_arg(KARG_MODULE);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 74d0bd7e76d7..d51a8ca97238 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -421,32 +421,6 @@ void ima_post_path_mknod(struct dentry *dentry)
 		iint->flags |= IMA_NEW_FILE;
 }
 
-/**
- * ima_read_file - pre-measure/appraise hook decision based on policy
- * @file: pointer to the file to be measured/appraised/audit
- * @read_id: caller identifier
- *
- * Permit reading a file based on policy. The policy rules are written
- * in terms of the policy identifier.  Appraising the integrity of
- * a file requires a file descriptor.
- *
- * For permission return 0, otherwise return -EACCES.
- */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
-{
-	bool sig_enforce = is_module_sig_enforced();
-
-	if (!file && read_id == READING_MODULE) {
-		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		}
-		return 0;	/* We rely on module signature checking */
-	}
-	return 0;
-}
-
 static int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
@@ -474,21 +448,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
-	if (!file && read_id == READING_FIRMWARE) {
-		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		return 0;
-	}
-
-	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
-		return 0;
-
-	/* permit signed certs */
-	if (!file && read_id == READING_X509_CERTIFICATE)
-		return 0;
-
-	if (!file || !buf || size == 0) { /* should never happen */
+	if (!buf || size == 0) { /* should never happen */
 		if (ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
 		return 0;
@@ -500,6 +460,40 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				   MAY_READ, func, 0);
 }
 
+/**
+ * ima_kernel_arg - pre-measure/appraise hook decision based on policy
+ * @id: caller identifier
+ *
+ * Permit using an argument to a syscall based on policy. The policy
+ * rules are written in terms of the policy identifier.
+ *
+ * For permission return 0, otherwise return -EACCES.
+ */
+int ima_kernel_arg(enum kernel_arg_id id)
+{
+	if (id == KARG_MODULE) {
+		bool sig_enforce = is_module_sig_enforced();
+		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;	/* We rely on module signature checking */
+	}
+	else if (id == KARG_FIRMWARE) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		return 0;
+	}
+	else {
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			return -EACCES;
+		return 0;
+	}
+	return 0;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..f5333e5abac9 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -121,23 +121,24 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
-static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
+static int loadpin_read_data(enum kernel_read_data_id id)
 {
-	struct super_block *load_root;
-	const char *origin = kernel_read_file_id_str(id);
+	const char *origin = kernel_arg_id_str(id);
 
 	/* This handles the older init_module API that has a NULL file. */
-	if (!file) {
-		if (!enabled) {
-			report_load(origin, NULL, "old-api-pinning-ignored");
-			return 0;
-		}
-
-		report_load(origin, NULL, "old-api-denied");
-		return -EPERM;
+	if (!enabled) {
+		report_load(origin, NULL, "old-api-pinning-ignored");
+		return 0;
 	}
 
-	load_root = file->f_path.mnt->mnt_sb;
+	report_load(origin, NULL, "old-api-denied");
+	return -EPERM;
+}
+
+static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
+{
+	struct super_block *load_root;
+	const char *origin = kernel_read_file_id_str(id);
 
 	/* First loaded module/firmware defines the root for all others. */
 	spin_lock(&pinned_root_spinlock);
@@ -175,6 +176,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
+	LSM_HOOK_INIT(kernel_read_data, loadpin_read_data),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
 };
 
diff --git a/security/security.c b/security/security.c
index 7bc2fde023a7..9b5f43c24ee2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1033,14 +1033,19 @@ int security_kernel_module_request(char *kmod_name)
 	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+int security_kernel_arg(enum kernel_arg_id id)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id);
-	if (ret)
-		return ret;
-	return ima_read_file(file, id);
+	ret = call_int_hook(kernel_arg, 0, id);
+	if (!ret)
+		ret = ima_kernel_arg(id);
+	return ret;
+}
+
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+{
+	return call_int_hook(kernel_read_file, 0, file, id);
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..76843099fed6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4010,6 +4010,15 @@ static int selinux_kernel_module_request(char *kmod_name)
 			    SYSTEM__MODULE_REQUEST, &ad);
 }
 
+static int selinux_kernel_module_arg(void)
+{
+	/* init_module */
+	u32 sid = current_sid();
+	return avc_has_perm(&selinux_state,
+			    sid, sid, SECCLASS_SYSTEM,
+			    SYSTEM__MODULE_LOAD, NULL);
+}
+
 static int selinux_kernel_module_from_file(struct file *file)
 {
 	struct common_audit_data ad;
@@ -4018,12 +4027,6 @@ static int selinux_kernel_module_from_file(struct file *file)
 	u32 sid = current_sid();
 	int rc;
 
-	/* init_module */
-	if (file == NULL)
-		return avc_has_perm(&selinux_state,
-				    sid, sid, SECCLASS_SYSTEM,
-					SYSTEM__MODULE_LOAD, NULL);
-
 	/* finit_module */
 
 	ad.type = LSM_AUDIT_DATA_FILE;
@@ -4043,6 +4046,20 @@ static int selinux_kernel_module_from_file(struct file *file)
 				SYSTEM__MODULE_LOAD, &ad);
 }
 
+static int selinux_kernel_arg(enum kernel_arg_id id)
+{
+	int rc = 0;
+
+	switch (id) {
+	case KARG_MODULE:
+		rc = selinux_kernel_module_arg();
+		break;
+	default:
+		break;
+	}
+	return rc;
+}
+
 static int selinux_kernel_read_file(struct file *file,
 				    enum kernel_read_file_id id)
 {
@@ -6938,6 +6955,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_arg, selinux_kernel_arg),
 	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),

