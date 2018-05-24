Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527160358-2-13875577318810317252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160358; b=clT3h+cWLYGHRvnUz6SVKjASo1BeJJ+BxhcC3aSTgK2Znc8p+d
    VdUN2Pb6kX8UIoYpWbbRLmYgURKJMXzRd28XCsKXew7R9vzNS2jIM25Qxy4rZWgO
    2le2d8Y1zWCGwL2YzjM+kl+WVSpDk26qmSDstw7La4M/IhyReFhsd4WBUyWB53Pb
    ZUIq5Bx2jZAJ8AOXISI5haAIMK0n0GtnuyEl9QopHSG6SuT4iBkLclYRg7DHdHhb
    +hBpOLSLYnVibR67fhVBQ/lqyvtXdkCBu1lWWTAxdomjB0oSxGI7ZTH82YIWq0Py
    Ql+fVYHT7KOaOupPNswWkfz9G5jkkoTfRr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527160358; bh=1
    ZsSNe4PnthRQNE4VGmCvbNNYOfqPp6x5peqQ5tHKXU=; b=HW8Iezm+u1k0E5eKU
    mhDuZczwBZgI67RsvgjCERDXwno/Hr6KwHTIaxMzsw2Jbr8rUl9kMLJgME5lzq1I
    NtbUm9tMaBHYS0Yh4qCJe2wXmgTwOspkc+aHKkmS9O4B2Y/MtsEMMKvWDnMdTC9S
    nC35zflVnNTDb57NyQbh/0OexfNHzHEOSoI6RLApHRzithfb6wGQs/xEPG13z06X
    FUzPp61OOxUkwdEzwSpZhNs8M/+jURmwT7Q38mMenYPHLHGDTEWeEFrbdTjTOfLu
    Ab+4a+KxHV+qYEY9BaCAnpGuIcTyk40C6IUHx9sRCOWnzcKkZ98UiQx0WBWdf6TK
    um5bQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOfFhkdmfWwnuWeQzzU3zBe/GiwDqoGLDuQ9p84m1pI4Ff4WDkYLGKfpV5ZqGcgyMt5zvwdgaPR9mgQ4tkEU55EXRY0euWWKTJr+3Hw1+Ygen/ekCbiI
    Ufblu4wV6lxgpv3q81Xsc3pww1MZ5/grasU+wNsao6kHAQ35DM8CC+cJsdJ5x5UOmL+MsR6PJyuQOD03iEuVfVZdcRwE3mXtxDBlghEGqZGGckYnS3moVKgO
    Rb4l8SP268poJ1aXcDv+GA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=20KFwNOVAAAA:8
    a=vpqfxihKAAAA:8 a=Dmy2OI2MgNBEkvBz55oA:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
    a=AULIiLoY-XQsE5F6gcqX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968260AbeEXLMM (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 07:12:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033017AbeEXLKb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 07:10:31 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
Date: Thu, 24 May 2018 07:09:30 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052411-0008-0000-0000-000004FAA7BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052411-0009-0000-0000-00001E8EAFCD
Message-Id: <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240132
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order for LSMs and IMA-appraisal to differentiate between the original
and new syscalls (eg. kexec, kernel modules, firmware), both the original
and new syscalls must call an LSM hook.

Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
introduced calling security_kernel_module_from_file() in both the original
and new syscalls.  Commit a1db74209483 ("module: replace
copy_module_from_fd with kernel version") replaced these LSM calls with
security_kernel_read_file().

Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
with kernel version") and commit b804defe4297  ("kexec: replace call to
copy_file_from_fd() with kernel version") replaced their own version of
reading a file from the kernel with the generic
kernel_read_file_from_path/fd() versions, which call the pre and post
security_kernel_read_file LSM hooks.

Missing are LSM calls in the original kexec syscall and firmware sysfs
fallback method.  Instead of defining a new LSM hook or wrapper for
security_kernel_read_file(), this patch renames the original
security_kernel_read_file() hook to security_kernel_read_data(), and
updates LSM usage of the hook (eg. loadpin, init_module, IMA).

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>

Changelog v3:
- Rename security_kernel_read_file to security_kernel_read_data().

Changelog v2:
- Define a generic wrapper named security_kernel_read_blob() for
security_kernel_read_file().

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().
---
 fs/exec.c                         | 2 +-
 include/linux/ima.h               | 4 ++--
 include/linux/security.h          | 4 ++--
 kernel/module.c                   | 2 +-
 security/integrity/ima/ima_main.c | 4 ++--
 security/loadpin/loadpin.c        | 2 +-
 security/security.c               | 6 +++---
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..0c832b4c6a22 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -904,7 +904,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id);
+	ret = security_kernel_read_data(file, id);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..423aaf88f8c6 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -19,7 +19,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
+extern int ima_read_data(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
@@ -49,7 +49,7 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+static inline int ima_read_data(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..836a9081b2f3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -320,7 +320,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
+int security_kernel_read_data(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -909,7 +909,7 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
-static inline int security_kernel_read_file(struct file *file,
+static inline int security_kernel_read_data(struct file *file,
 					    enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/kernel/module.c b/kernel/module.c
index ce8066b88178..cb84a0b7fbe9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_read_file(NULL, READING_MODULE);
+	err = security_kernel_read_data(NULL, READING_MODULE);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 83f84928ad76..eeb7075868db 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -420,7 +420,7 @@ void ima_post_path_mknod(struct dentry *dentry)
 }
 
 /**
- * ima_read_file - pre-measure/appraise hook decision based on policy
+ * ima_read_data - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
  * @read_id: caller identifier
  *
@@ -430,7 +430,7 @@ void ima_post_path_mknod(struct dentry *dentry)
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
+int ima_read_data(struct file *file, enum kernel_read_file_id read_id)
 {
 	bool sig_enforce = is_module_sig_enforced();
 
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..8d7db638fdeb 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -175,7 +175,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
-	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
+	LSM_HOOK_INIT(kernel_read_data, loadpin_read_file),
 };
 
 void __init loadpin_add_hooks(void)
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..fc7a2bcf3177 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1033,16 +1033,16 @@ int security_kernel_module_request(char *kmod_name)
 	return call_int_hook(kernel_module_request, 0, kmod_name);
 }
 
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+int security_kernel_read_data(struct file *file, enum kernel_read_file_id id)
 {
 	int ret;
 
 	ret = call_int_hook(kernel_read_file, 0, file, id);
 	if (ret)
 		return ret;
-	return ima_read_file(file, id);
+	return ima_read_data(file, id);
 }
-EXPORT_SYMBOL_GPL(security_kernel_read_file);
+EXPORT_SYMBOL_GPL(security_kernel_read_data);
 
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
-- 
2.7.5

