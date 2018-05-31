Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1650533-1527780251-2-5437494082978407802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527780251; b=RP3CHHUcX3buO1UCPfDe8g4HAOmc6hOxC5KFJ2FD5NrCZ4XZCi
    WzHcl3nm/N785bcRtl3QYwFCXRchue7HnDbKAi36I1/Bx0JSdRPdlKz8lrNfl12B
    /l7pHmCXhTp4aF+G8oHm6eEhFk7/1EtMT5tLpIlmbNRVojDD2EnoKIqVPCH1XDfB
    skGL8ZssW5xMDseztxffwKnSHek+3bMp8Qv0vsZGCK9EVsxe8Bf9Hxn7j7G+S1Oo
    PaY2mrvpGs/cQ1joBH6/j4Vmdyvv3LXveApLgd1TZ0AeTy+5/MduLQqL/W1f4L33
    0OXZrCWoFe7e6VF+hMNcAbxR/dYyY6PPVv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527780251; bh=x2M6bbXnpm8u
    /TgK7UR5bQMVs40C4BYHvDJDSDCozxc=; b=Cs33IrEYTBaAwbeU3N4pxoV+h8GU
    PDA/ajQ3PK2AQzRsDc5WW5yoKQoL/LTw0+68UYB5L9PpSR0b+OGjYgz0SJbBa01J
    xCIjePDAb3l0/4N43Pml7eagk2tQm8hbS7L2GZaOdG6bcq0NGFcwrMbLoti6mZFx
    srj2CK3skllmld/bny9XtmvpuAZbkBGpWFIEKRTFv1rMfmM9fs6OMOlCN1KfiUIh
    hm0Q9PMj8sgh+hkNbBn2xgcoSkkJhKJIoBZAmXLgOYD/r0GcEhphGiAFYxe6HNF4
    tE0UyjiydzZAFybUfqv1KE1Mg3ys2IG+0Wm54EiZ53i2vXZsV/BLtdPDHA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLQaPKLRA7iZzoEUMPHeK/fApn6DuNxtMEQn7FUFlBTuYTcVoIw+C//wa4il+83R/qktphCH+q60yvUhdz1ftBtFjkI4BZ1tkVI/IVGieEL5nIaFM7f9
    4JZ8AEzqXuwAknQcNFDQ/mDOiqBlO9So/T2KgHkwMmA9nb/gaSKoQpqo5EZFq1nX1HdwRKB32GI2Ge/UdNwbsIVy4J/wLO3mxxE4Wtn9fRzn8yWwoDHDoroz
    G27SAiCSU6M68JZ9poeAFw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=xVhDTqbCAAAA:8 a=vpqfxihKAAAA:8
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=3PX-g79-tcRU_4lHhisA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=GrmWmAYt4dzCMttCBZOh:22 a=AULIiLoY-XQsE5F6gcqX:22
    a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755441AbeEaPYJ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 11:24:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755369AbeEaPYH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 11:24:07 -0400
Subject: [PATCH v4a 8/8] module: replace the existing LSM hook in init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 31 May 2018 11:23:46 -0400
In-Reply-To: <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
         <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
         <1527635645.3534.39.camel@linux.vnet.ibm.com>
         <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18053115-0008-0000-0000-000002426B2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053115-0009-0000-0000-000021A818FC
Message-Id: <1527780226.3427.20.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310171
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both the init_module and finit_module syscalls call either directly
or indirectly the security_kernel_read_file LSM hook.  This patch
replaces the direct call in init_module with a call to the new
security_kernel_load_data hook and makes the corresponding changes
in SELinux, LoadPin, and IMA.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>

---
Changelog:
- For SELinux, have both the security_kernel_read_file and
security_kernel_load_data LSM hooks call selinux_kernel_read_file().
- LoadPin: replace existing init_module LSM hook support with
new security_kernel_load_data hook.

 kernel/module.c                   |  2 +-
 security/integrity/ima/ima_main.c | 24 ++++++++++--------------
 security/loadpin/loadpin.c        | 15 +++++++++++++++
 security/selinux/hooks.c          | 15 +++++++++++++++
 4 files changed, 41 insertions(+), 15 deletions(-)

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
index 5a7696152982..cd33a2eff496 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -438,17 +438,6 @@ static int read_idmap[READING_MAX_ID] = {
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
@@ -487,9 +476,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
-		return 0;
-
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -518,6 +504,8 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id)
 {
+	bool sig_enforce;
+
 	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
 		return 0;
 
@@ -533,6 +521,14 @@ int ima_load_data(enum kernel_load_data_id id)
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
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 5fa191252c8f..a9c07bfbc338 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -173,9 +173,24 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 	return 0;
 }
 
+static int loadpin_load_data(enum kernel_load_data_id id)
+{
+	int rc = 0;
+
+	switch (id) {
+	case LOADING_MODULE:
+		rc = loadpin_read_file(NULL, READING_MODULE);
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
+	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
 void __init loadpin_add_hooks(void)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 02ebd1585eaf..475aed9ee2c7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4059,6 +4059,20 @@ static int selinux_kernel_read_file(struct file *file,
 	return rc;
 }
 
+static int selinux_kernel_load_data(enum kernel_load_data_id id)
+{
+	int rc = 0;
+
+	switch (id) {
+	case LOADING_MODULE:
+		rc = selinux_kernel_module_from_file(NULL);
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return avc_has_perm(&selinux_state,
@@ -6950,6 +6964,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
 	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
-- 
2.7.5

