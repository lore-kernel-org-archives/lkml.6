Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2473614-1527616982-2-6390358731940272760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527616982; b=bJ/JPT/EAqWWQYAF1wuUOB3+lGKAzKLmgadLF6ETl90zBn0/pi
    DiLkKk1qTEnm60bFEfvdDeZwP38H+6lNG1jEFWUWLlVQ3UOMov0qp7egiQMrNzDU
    qL8C+IjJ4FSjeqvLGz9EJUkWCHFNGNwknp6yzClFFf5fs/6j+Cz6ZlS7cZVVu5yT
    BmGQWgJ2+HKAb9dp02UYn68wpscu1DwhBank0UjqQiYVr8tp/nV71bCYudTzHfeH
    qG1vO2GMm9dHT27x1sgweBVyEp8nBQWGPDPKSLINqMl41V/A4DVg09YDvig85oMf
    oyHgPBmY7OeWmXi+tzniHMXiuo752GI5s5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527616982; bh=f
    EfwzyU6nPh8x7I2Nnn4h0UGuIAH3vG4vdXv96s9ujw=; b=QcmvShOf7QqU3rcbV
    bTKpfkEH00GlMEPCseSZcgOfzGkakn8Kbwu3Tz6dlwKYhMwb/nbr6K1KOHLXY+pc
    fGXcDxgl9eu7IdmuzTIYnIorV0yuXY9Ss322ZNUoO2GgKTMwC95dpvMD/opnuLYs
    FufReMA8CJZc1K4bBnGEyy2bvN7vr6a9SGJCTzBi/PDkQ4WOLJg2kUL+5zsCzGnh
    R+seTHMD2W9oKE7MyhPXk9f7/UcH/ux1pXFdEeWmPNYuWUGZtYf0dPneepfwkfeG
    oBScP0ZFpgnzpBSjxw6yCICnumAaiEvpH84GumgaZedUkrQ63q5lLReVWVOhJtg5
    Vsgjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD9Y/5wDGzaztvf0WGAPJxdmQjiANsMMmXuftX0kNetdvFo2JgRSk78OFr7sMOHAFJONB+vp3h/pFZVEHNQejMgXYPAEsqTQVWueBGLlq2FsxVz39/gr
    Mc59UjmLYXfJmwxDI7jMyy5NnfiXmUTcRhIyAGpl7kJE9PdTcSW0szUd1UPLJ9aGkdo2loYbObowJWKtE4daUSdYlGoY9UjmyEjmZmtJm+10rk/DMBgfBMNw
    9vAIHHkAiM4v05Wx0eqPFg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=1XWaLZrsAAAA:8 a=xVhDTqbCAAAA:8 a=vpqfxihKAAAA:8 a=VwQbUJbxAAAA:8
    a=wXcipsOM8ntSdkT-vb8A:9 a=x8gzFH9gYPwA:10 a=GrmWmAYt4dzCMttCBZOh:22
    a=AULIiLoY-XQsE5F6gcqX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965540AbeE2SC6 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:02:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965857AbeE2SCh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 14:02:37 -0400
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
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v4 8/8] module: replace the existing LSM hook in init_module
Date: Tue, 29 May 2018 14:02:00 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052918-0008-0000-0000-000004FC48D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052918-0009-0000-0000-00001E906786
Message-Id: <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290195
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both the init_module and finit_module syscalls call either directly
or indirectly the security_kernel_read_file LSM hook.  This patch
replaces the direct call in init_module with a call to the new
security_kernel_load_data hook and makes the corresponding changes in
SELinux and IMA.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/module.c                   |  2 +-
 security/integrity/ima/ima_main.c | 24 ++++++++++--------------
 security/selinux/hooks.c          | 26 ++++++++++++++++++++------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index ce8066b88178..b97c642b5b4d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2879,7 +2879,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_read_file(NULL, READING_MODULE);
+	err = security_kernel_load_data(LOADING_MODULE);
 	if (err)
 		return err;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 3dae605a1604..0ff1d8152f6e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -441,17 +441,6 @@ static int read_idmap[READING_MAX_ID] = {
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
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
-
 	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
@@ -490,9 +479,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
-		return 0;
-
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -521,6 +507,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id)
 {
+	bool sig_enforce;
+
 	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
 		return 0;
 
@@ -536,6 +524,14 @@ int ima_load_data(enum kernel_load_data_id id)
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
+		break;
+	case LOADING_MODULE:
+		sig_enforce = is_module_sig_enforced();
+
+		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
+			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 	default:
 		break;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 02ebd1585eaf..e02186470fc5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4018,12 +4018,6 @@ static int selinux_kernel_module_from_file(struct file *file)
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
@@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
 				SYSTEM__MODULE_LOAD, &ad);
 }
 
+static int selinux_kernel_load_data(enum kernel_load_data_id id)
+{
+	u32 sid;
+	int rc = 0;
+
+	switch (id) {
+	case LOADING_MODULE:
+		sid = current_sid();
+
+		/* init_module */
+		return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
+				    SYSTEM__MODULE_LOAD, NULL);
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 static int selinux_kernel_read_file(struct file *file,
 				    enum kernel_read_file_id id)
 {
@@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
 	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
-- 
2.7.5

