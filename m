Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F90CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F328321872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTvPIgSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392231AbfBMWQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:16:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43575 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389341AbfBMWQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:16:35 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so2414438ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z25jVDYmO+w+/f6ByY2dZJg9+Np6snK+S0yiGmLPt3Y=;
        b=YTvPIgSk0diyeAhDTDxRSYcNzpNiSXNEHUa48i5w3PN/8q8xw31NWc4MrJb4QLLgkw
         Ye9VO9DT+bOZaVtH5g9cIDHo0+liLzosygtKMXDheLxJUzxfRmgcE7tsOXTl/9DnOyi7
         x6MoA96t7pWYOvkqy94wo6FzxzT1YtRKO8EYOoizK1Ee3q+ctocV+8YPyESHZKhYTZjm
         q6AJGWJt1NiB8CBBxcUdxtM5xHwcXAMYMrkAH4+bYSFSBs7L8YJJIWF698SZwJkjms1e
         YNkol4Eq84o9zs4pDaN5QBPDIs8Pk5BuThjNZlltILWOcPs7c3Tg7h2pWudOhhtla0NZ
         69rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z25jVDYmO+w+/f6ByY2dZJg9+Np6snK+S0yiGmLPt3Y=;
        b=Z2pfBUXXs3KBuDY7qOyKjQKK8hSekqpqnGIl75CNeDjEo6RjgQCN+w9oWqpCUOzCyx
         2reV0Zs2/kLp6ZIIKI3sqgyfYgyD68KT169jJTC4t2Xz78QSMJpgcJP2sUW1NsIfVltF
         ZTMRq4tcV53wHdxxpi1jCBs/UT0PL7maimyMH+sk0OIgBTwG8ORGakZLPyxSr52ah5sI
         H1rT6iGKchS2pXbmwrEbMWiVS0uBLZ/GhtOtHhjgwMOMCaRsHOVa4YkMMykz56kPZiq5
         nJ0Gr5z6o8RkJDHetpgfw1kms6OqrZ00SiUgLFSvWMq43lGSNUJd0NhQ5HKfKAntnOiN
         nngg==
X-Gm-Message-State: AHQUAubOcTqcROVUg1vlxEnugXrtAPUda55COR3wD2/omJH2U54Yv93k
        1wGAtwX3GkvCJuwuUCJRBCM+aQ==
X-Google-Smtp-Source: AHgI3IYRSWld9vGRdlBvSDFdpRt0wwN+16S6FlVOlLH8+d7Vn8OnxJ0LPqXMqAcwrU851D8dX02NrQ==
X-Received: by 2002:a2e:309:: with SMTP id 9-v6mr261726ljd.50.1550096191925;
        Wed, 13 Feb 2019 14:16:31 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id d25sm108687lji.9.2019.02.13.14.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:16:31 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 1/2] ima: fix build error redeclaration of enumerator
Date:   Wed, 13 Feb 2019 23:16:24 +0100
Message-Id: <20190213221625.7551-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a893ea15d764 ("tpm: move tpm_chip definition to
include/linux/tpm.h") introduced a build error when both ima and efi is
enabled. What happens is that both headers (ima.h and efi.h) defines the
same 'NONE' constant, and it broke when they started getting included
from the same file.

In file included from ../security/integrity/ima/ima_fs.c:30:
../security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator "NONE"
  hook(NONE)   \
       ^~~~
../security/integrity/ima/ima.h:188:34: note: in definition of macro "__ima_hook_enumify"
 #define __ima_hook_enumify(ENUM) ENUM,
                                  ^~~~
../security/integrity/ima/ima.h:191:2: note: in expansion of macro "__ima_hooks"
  __ima_hooks(__ima_hook_enumify)
  ^~~~~~~~~~~
In file included from ../arch/arm64/include/asm/acpi.h:15,
                 from ../include/acpi/acpi_io.h:7,
                 from ../include/linux/acpi.h:47,
                 from ../include/linux/tpm.h:26,
                 from ../security/integrity/ima/ima.h:25,
                 from ../security/integrity/ima/ima_fs.c:30:
../include/linux/efi.h:1723:2: note: previous definition of "NONE" was here
  NONE,
  ^~~~
make[4]: *** [../scripts/Makefile.build:277: security/integrity/ima/ima_fs.o] Error 1

Rework to prefix the ima enum with 'IMA_*'.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

No change since v2.

 security/integrity/ima/ima.h          | 24 +++----
 security/integrity/ima/ima_api.c      |  3 +-
 security/integrity/ima/ima_appraise.c | 40 ++++++------
 security/integrity/ima/ima_main.c     | 30 ++++-----
 security/integrity/ima/ima_policy.c   | 92 +++++++++++++--------------
 5 files changed, 95 insertions(+), 94 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..89ceb61f279c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -173,18 +173,18 @@ static inline unsigned long ima_hash_key(u8 *digest)
 }
 
 #define __ima_hooks(hook)		\
-	hook(NONE)			\
-	hook(FILE_CHECK)		\
-	hook(MMAP_CHECK)		\
-	hook(BPRM_CHECK)		\
-	hook(CREDS_CHECK)		\
-	hook(POST_SETATTR)		\
-	hook(MODULE_CHECK)		\
-	hook(FIRMWARE_CHECK)		\
-	hook(KEXEC_KERNEL_CHECK)	\
-	hook(KEXEC_INITRAMFS_CHECK)	\
-	hook(POLICY_CHECK)		\
-	hook(MAX_CHECK)
+	hook(IMA_NONE)			\
+	hook(IMA_FILE_CHECK)		\
+	hook(IMA_MMAP_CHECK)		\
+	hook(IMA_BPRM_CHECK)		\
+	hook(IMA_CREDS_CHECK)		\
+	hook(IMA_POST_SETATTR)		\
+	hook(IMA_MODULE_CHECK)		\
+	hook(IMA_FIRMWARE_CHECK)	\
+	hook(IMA_KEXEC_KERNEL_CHECK)	\
+	hook(IMA_KEXEC_INITRAMFS_CHECK)	\
+	hook(IMA_POLICY_CHECK)		\
+	hook(IMA_MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
 enum ima_hooks {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..81e705423894 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -168,7 +168,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
- *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
+ *	func: IMA_FILE_CHECK | IMA_BPRM_CHECK | IMA_CREDS_CHECK \
+ *	      | IMA_MMAP_CHECK | IMA_MODULE_CHECK
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a2baa85ea2f5..c527cf3f37d3 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -86,16 +86,16 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   enum ima_hooks func)
 {
 	switch (func) {
-	case MMAP_CHECK:
+	case IMA_MMAP_CHECK:
 		return iint->ima_mmap_status;
-	case BPRM_CHECK:
+	case IMA_BPRM_CHECK:
 		return iint->ima_bprm_status;
-	case CREDS_CHECK:
+	case IMA_CREDS_CHECK:
 		return iint->ima_creds_status;
-	case FILE_CHECK:
-	case POST_SETATTR:
+	case IMA_FILE_CHECK:
+	case IMA_POST_SETATTR:
 		return iint->ima_file_status;
-	case MODULE_CHECK ... MAX_CHECK - 1:
+	case IMA_MODULE_CHECK ... IMA_MAX_CHECK - 1:
 	default:
 		return iint->ima_read_status;
 	}
@@ -106,19 +106,19 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
 				 enum integrity_status status)
 {
 	switch (func) {
-	case MMAP_CHECK:
+	case IMA_MMAP_CHECK:
 		iint->ima_mmap_status = status;
 		break;
-	case BPRM_CHECK:
+	case IMA_BPRM_CHECK:
 		iint->ima_bprm_status = status;
 		break;
-	case CREDS_CHECK:
+	case IMA_CREDS_CHECK:
 		iint->ima_creds_status = status;
-	case FILE_CHECK:
-	case POST_SETATTR:
+	case IMA_FILE_CHECK:
+	case IMA_POST_SETATTR:
 		iint->ima_file_status = status;
 		break;
-	case MODULE_CHECK ... MAX_CHECK - 1:
+	case IMA_MODULE_CHECK ... IMA_MAX_CHECK - 1:
 	default:
 		iint->ima_read_status = status;
 		break;
@@ -129,20 +129,20 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
 			     enum ima_hooks func)
 {
 	switch (func) {
-	case MMAP_CHECK:
+	case IMA_MMAP_CHECK:
 		iint->flags |= (IMA_MMAP_APPRAISED | IMA_APPRAISED);
 		break;
-	case BPRM_CHECK:
+	case IMA_BPRM_CHECK:
 		iint->flags |= (IMA_BPRM_APPRAISED | IMA_APPRAISED);
 		break;
-	case CREDS_CHECK:
+	case IMA_CREDS_CHECK:
 		iint->flags |= (IMA_CREDS_APPRAISED | IMA_APPRAISED);
 		break;
-	case FILE_CHECK:
-	case POST_SETATTR:
+	case IMA_FILE_CHECK:
+	case IMA_POST_SETATTR:
 		iint->flags |= (IMA_FILE_APPRAISED | IMA_APPRAISED);
 		break;
-	case MODULE_CHECK ... MAX_CHECK - 1:
+	case IMA_MODULE_CHECK ... IMA_MAX_CHECK - 1:
 	default:
 		iint->flags |= (IMA_READ_APPRAISED | IMA_APPRAISED);
 		break;
@@ -298,7 +298,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			break;
 		}
 		if (IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING) && rc &&
-		    func == KEXEC_KERNEL_CHECK)
+		    func == IMA_KEXEC_KERNEL_CHECK)
 			rc = integrity_digsig_verify(INTEGRITY_KEYRING_PLATFORM,
 						     (const char *)xattr_value,
 						     xattr_len,
@@ -400,7 +400,7 @@ void ima_inode_post_setattr(struct dentry *dentry)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(inode, MAY_ACCESS, IMA_POST_SETATTR);
 	if (!action)
 		__vfs_removexattr(dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..1ddbe39cba8a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -193,7 +193,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
-	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
+	violation_check = ((func == IMA_FILE_CHECK || func == IMA_MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
 		return 0;
@@ -202,7 +202,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	/*  Is the appraise rule hook specific?  */
 	if (action & IMA_FILE_APPRAISE)
-		func = FILE_CHECK;
+		func = IMA_FILE_CHECK;
 
 	inode_lock(inode);
 
@@ -340,7 +340,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, IMA_MMAP_CHECK);
 	}
 
 	return 0;
@@ -366,13 +366,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_task_getsecid(current, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+				  MAY_EXEC, IMA_BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+				   MAY_EXEC, IMA_CREDS_CHECK);
 }
 
 /**
@@ -392,7 +392,7 @@ int ima_file_check(struct file *file, int mask)
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), IMA_FILE_CHECK);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
@@ -409,7 +409,7 @@ void ima_post_create_tmpfile(struct inode *inode)
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	must_appraise = ima_must_appraise(inode, MAY_ACCESS, IMA_FILE_CHECK);
 	if (!must_appraise)
 		return;
 
@@ -436,7 +436,7 @@ void ima_post_path_mknod(struct dentry *dentry)
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	must_appraise = ima_must_appraise(inode, MAY_ACCESS, IMA_FILE_CHECK);
 	if (!must_appraise)
 		return;
 
@@ -474,12 +474,12 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 }
 
 static const int read_idmap[READING_MAX_ID] = {
-	[READING_FIRMWARE] = FIRMWARE_CHECK,
-	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
-	[READING_MODULE] = MODULE_CHECK,
-	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
-	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_FIRMWARE] = IMA_FIRMWARE_CHECK,
+	[READING_FIRMWARE_PREALLOC_BUFFER] = IMA_FIRMWARE_CHECK,
+	[READING_MODULE] = IMA_MODULE_CHECK,
+	[READING_KEXEC_IMAGE] = IMA_KEXEC_KERNEL_CHECK,
+	[READING_KEXEC_INITRAMFS] = IMA_KEXEC_INITRAMFS_CHECK,
+	[READING_POLICY] = IMA_POLICY_CHECK
 };
 
 /**
@@ -520,7 +520,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	func = read_idmap[read_id] ?: FILE_CHECK;
+	func = read_idmap[read_id] ?: IMA_FILE_CHECK;
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
 				   MAY_READ, func);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 26fa9d9723f6..6b39b835861b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -112,31 +112,31 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
 };
 
 static struct ima_rule_entry original_measurement_rules[] __ro_after_init = {
-	{.action = MEASURE, .func = MMAP_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .func = IMA_MMAP_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = BPRM_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .func = IMA_BPRM_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	{.action = MEASURE, .func = IMA_FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
 	 .flags = IMA_FUNC | IMA_MASK | IMA_UID},
-	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = IMA_MODULE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = IMA_FIRMWARE_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_measurement_rules[] __ro_after_init = {
-	{.action = MEASURE, .func = MMAP_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .func = IMA_MMAP_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = BPRM_CHECK, .mask = MAY_EXEC,
+	{.action = MEASURE, .func = IMA_BPRM_CHECK, .mask = MAY_EXEC,
 	 .flags = IMA_FUNC | IMA_MASK},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	{.action = MEASURE, .func = IMA_FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
 	 .flags = IMA_FUNC | IMA_INMASK | IMA_EUID},
-	{.action = MEASURE, .func = FILE_CHECK, .mask = MAY_READ,
+	{.action = MEASURE, .func = IMA_FILE_CHECK, .mask = MAY_READ,
 	 .uid = GLOBAL_ROOT_UID, .uid_op = &uid_eq,
 	 .flags = IMA_FUNC | IMA_INMASK | IMA_UID},
-	{.action = MEASURE, .func = MODULE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .func = FIRMWARE_CHECK, .flags = IMA_FUNC},
-	{.action = MEASURE, .func = POLICY_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = IMA_MODULE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = IMA_FIRMWARE_CHECK, .flags = IMA_FUNC},
+	{.action = MEASURE, .func = IMA_POLICY_CHECK, .flags = IMA_FUNC},
 };
 
 static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
@@ -155,7 +155,7 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_APPRAISE, .fsmagic = CGROUP2_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 #ifdef CONFIG_IMA_WRITE_POLICY
-	{.action = APPRAISE, .func = POLICY_CHECK,
+	{.action = APPRAISE, .func = IMA_POLICY_CHECK,
 	.flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 #endif
 #ifndef CONFIG_IMA_APPRAISE_SIGNED_INIT
@@ -170,31 +170,31 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 #ifdef CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS
-	{.action = APPRAISE, .func = MODULE_CHECK,
+	{.action = APPRAISE, .func = IMA_MODULE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 #endif
 #ifdef CONFIG_IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
-	{.action = APPRAISE, .func = FIRMWARE_CHECK,
+	{.action = APPRAISE, .func = IMA_FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 #endif
 #ifdef CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS
-	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
+	{.action = APPRAISE, .func = IMA_KEXEC_KERNEL_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 #endif
 #ifdef CONFIG_IMA_APPRAISE_REQUIRE_POLICY_SIGS
-	{.action = APPRAISE, .func = POLICY_CHECK,
+	{.action = APPRAISE, .func = IMA_POLICY_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 #endif
 };
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
-	{.action = APPRAISE, .func = MODULE_CHECK,
+	{.action = APPRAISE, .func = IMA_MODULE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
-	{.action = APPRAISE, .func = FIRMWARE_CHECK,
+	{.action = APPRAISE, .func = IMA_FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
-	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
+	{.action = APPRAISE, .func = IMA_KEXEC_KERNEL_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
-	{.action = APPRAISE, .func = POLICY_CHECK,
+	{.action = APPRAISE, .func = IMA_POLICY_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
@@ -292,13 +292,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	int i;
 
 	if ((rule->flags & IMA_FUNC) &&
-	    (rule->func != func && func != POST_SETATTR))
+	    (rule->func != func && func != IMA_POST_SETATTR))
 		return false;
 	if ((rule->flags & IMA_MASK) &&
-	    (rule->mask != mask && func != POST_SETATTR))
+	    (rule->mask != mask && func != IMA_POST_SETATTR))
 		return false;
 	if ((rule->flags & IMA_INMASK) &&
-	    (!(rule->mask & mask) && func != POST_SETATTR))
+	    (!(rule->mask & mask) && func != IMA_POST_SETATTR))
 		return false;
 	if ((rule->flags & IMA_FSMAGIC)
 	    && rule->fsmagic != inode->i_sb->s_magic)
@@ -373,16 +373,16 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 		return IMA_FILE_APPRAISE;
 
 	switch (func) {
-	case MMAP_CHECK:
+	case IMA_MMAP_CHECK:
 		return IMA_MMAP_APPRAISE;
-	case BPRM_CHECK:
+	case IMA_BPRM_CHECK:
 		return IMA_BPRM_APPRAISE;
-	case CREDS_CHECK:
+	case IMA_CREDS_CHECK:
 		return IMA_CREDS_APPRAISE;
-	case FILE_CHECK:
-	case POST_SETATTR:
+	case IMA_FILE_CHECK:
+	case IMA_POST_SETATTR:
 		return IMA_FILE_APPRAISE;
-	case MODULE_CHECK ... MAX_CHECK - 1:
+	case IMA_MODULE_CHECK ... IMA_MAX_CHECK - 1:
 	default:
 		return IMA_READ_APPRAISE;
 	}
@@ -468,13 +468,13 @@ void ima_update_policy_flag(void)
 
 static int ima_appraise_flag(enum ima_hooks func)
 {
-	if (func == MODULE_CHECK)
+	if (func == IMA_MODULE_CHECK)
 		return IMA_APPRAISE_MODULES;
-	else if (func == FIRMWARE_CHECK)
+	else if (func == IMA_FIRMWARE_CHECK)
 		return IMA_APPRAISE_FIRMWARE;
-	else if (func == POLICY_CHECK)
+	else if (func == IMA_POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
-	else if (func == KEXEC_KERNEL_CHECK)
+	else if (func == IMA_KEXEC_KERNEL_CHECK)
 		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
@@ -500,7 +500,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 		}
 		if (entries[i].action == APPRAISE)
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-		if (entries[i].func == POLICY_CHECK)
+		if (entries[i].func == IMA_POLICY_CHECK)
 			temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	}
 }
@@ -846,29 +846,29 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				result = -EINVAL;
 
 			if (strcmp(args[0].from, "FILE_CHECK") == 0)
-				entry->func = FILE_CHECK;
+				entry->func = IMA_FILE_CHECK;
 			/* PATH_CHECK is for backwards compat */
 			else if (strcmp(args[0].from, "PATH_CHECK") == 0)
-				entry->func = FILE_CHECK;
+				entry->func = IMA_FILE_CHECK;
 			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
-				entry->func = MODULE_CHECK;
+				entry->func = IMA_MODULE_CHECK;
 			else if (strcmp(args[0].from, "FIRMWARE_CHECK") == 0)
-				entry->func = FIRMWARE_CHECK;
+				entry->func = IMA_FIRMWARE_CHECK;
 			else if ((strcmp(args[0].from, "FILE_MMAP") == 0)
 				|| (strcmp(args[0].from, "MMAP_CHECK") == 0))
-				entry->func = MMAP_CHECK;
+				entry->func = IMA_MMAP_CHECK;
 			else if (strcmp(args[0].from, "BPRM_CHECK") == 0)
-				entry->func = BPRM_CHECK;
+				entry->func = IMA_BPRM_CHECK;
 			else if (strcmp(args[0].from, "CREDS_CHECK") == 0)
-				entry->func = CREDS_CHECK;
+				entry->func = IMA_CREDS_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_KERNEL_CHECK") ==
 				 0)
-				entry->func = KEXEC_KERNEL_CHECK;
+				entry->func = IMA_KEXEC_KERNEL_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_INITRAMFS_CHECK")
 				 == 0)
-				entry->func = KEXEC_INITRAMFS_CHECK;
+				entry->func = IMA_KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
-				entry->func = POLICY_CHECK;
+				entry->func = IMA_POLICY_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
@@ -1194,7 +1194,7 @@ void ima_policy_stop(struct seq_file *m, void *v)
  */
 static void policy_func_show(struct seq_file *m, enum ima_hooks func)
 {
-	if (func > 0 && func < MAX_CHECK)
+	if (func > 0 && func < IMA_MAX_CHECK)
 		seq_printf(m, "func=%s ", func_tokens[func]);
 	else
 		seq_printf(m, "func=%d ", func);
-- 
2.20.1

