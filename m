Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2486798-1527617068-3-7449315546352259404
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527617067; b=N6c61V3pwq32pJ6LwzyTLmgu9uc4CQWGPlQpuba4lnmkh0ZahL
    8XUIS9bxmS2AMHP2wB1ggVgF4bzLCrjq4danIBSiib3YWzEUWYkuWA9trIcDEDDQ
    UiuFuAG9a7VT8r7GLwiqgBgjmewNl35A2UqFkOecrbAkHgDNyJukZSkfZbvNeHm9
    jKz/USflaJysMZmi/nEHKakCHEt7QAwc86VrCBfVUYLZ7ivUQuZw1Lq2vK9hCVur
    bU4N+i5OR7GLeGhMB1ZRTbKUrEDIZyukh8h05IlzjkHaeunCGB764kl7c7awNcLT
    4ntemHNH/NFhO3qNq4YprEifPhjTh2AiJv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527617067; bh=d
    PTAoryNhaWvjzzUqwlZ49f0suAaPwEMQjFFLGpdktY=; b=MqcqmkHgx1p/AXSQ1
    jVQsDBkCmFdV08S7MYajXCPFrcgJTWfUSwVju9abmk5j3umSAkV6xC9nNPv18Ld9
    IQVQaxPbdSGPeRLQBA8GwnjzXmunNAAxQTQpW+hdeEHWTUMdc1r+oJkVeBfdpspu
    xJq9mTknA7ycKvDqSscdBEKHUeqUOmOeOyMkwiYR+l5mVH+OE9ZWyHdy5Kfawoi5
    wicVOnnF7sKU3wWT7LAOSdiREF60pf+MPasioeuNdHPfywq8Zh+OCezNxRr6VoJa
    E48ip2dKWKKlB8U2PUSYPOaGWjn8bIqDinUsd3brrFQal6m/cvVmgUzve9VpSMo0
    W7hUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJOKH4VGBEgMZictiRTbzFW1ER4FGTpoGUsFQsADQgNHegJDtinLh2G0QDACRMo/xkFpIMa0hFFL2k1xGIY9ksnKNaIFbAwFxR3xnG3VDSC+3GN0LtcA
    MHA9G+Kd5+iRNCPFpd3ucv6F9bWFdD+bi25qFTLJwn+mgESCm2CIfa2XMqEj92dgfVstEnkkIC3TwmlTnq58CkUlJuDGjqUWlS5dNfs9UR/CFVqLqe7SPQeE
    yKGHpmJLF4IPgw9yrSSouw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=20KFwNOVAAAA:8
    a=I-O41KUAw5RL40b06IQA:9 a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965720AbeE2SEX (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 14:04:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965658AbeE2SCZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 14:02:25 -0400
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 3/8] ima: based on policy require signed kexec kernel images
Date: Tue, 29 May 2018 14:01:55 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052918-0012-0000-0000-000005DBC336
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052918-0013-0000-0000-000019592842
Message-Id: <1527616920-5415-4-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290195
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The original kexec_load syscall can not verify file signatures, nor can
the kexec image be measured.  Based on policy, deny the kexec_load
syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>

Changelog v3:
- use switch/case
---
 include/linux/ima.h                 |  7 +++++++
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 27 +++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c |  2 ++
 security/security.c                 |  7 ++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..84806b54b50a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #define _LINUX_IMA_H
 
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 struct linux_binprm;
 
@@ -19,6 +20,7 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask, int opened);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
+extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
@@ -49,6 +51,11 @@ static inline int ima_file_mmap(struct file *file, unsigned long prot)
 	return 0;
 }
 
+static inline int ima_load_data(enum kernel_load_data_id id)
+{
+	return 0;
+}
+
 static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
 {
 	return 0;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..78c15264b17b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -232,6 +232,7 @@ int ima_policy_show(struct seq_file *m, void *v);
 #define IMA_APPRAISE_MODULES	0x08
 #define IMA_APPRAISE_FIRMWARE	0x10
 #define IMA_APPRAISE_POLICY	0x20
+#define IMA_APPRAISE_KEXEC	0x40
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise_measurement(enum ima_hooks func,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 83f84928ad76..a565d46084c2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -499,6 +499,33 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 				   MAY_READ, func, 0);
 }
 
+/**
+ * ima_load_data - appraise decision based on policy
+ * @id: kernel load data caller identifier
+ *
+ * Callers of this LSM hook can not measure, appraise, or audit the
+ * data provided by userspace.  Enforce policy rules requring a file
+ * signature (eg. kexec'ed kernel image).
+ *
+ * For permission return 0, otherwise return -EACCES.
+ */
+int ima_load_data(enum kernel_load_data_id id)
+{
+	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
+		return 0;
+
+	switch (id) {
+	case LOADING_KEXEC_IMAGE:
+		if (ima_appraise & IMA_APPRAISE_KEXEC) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bbc18eb07eb..c27f6993b07a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -448,6 +448,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 		return IMA_APPRAISE_FIRMWARE;
 	else if (func == POLICY_CHECK)
 		return IMA_APPRAISE_POLICY;
+	else if (func == KEXEC_KERNEL_CHECK)
+		return IMA_APPRAISE_KEXEC;
 	return 0;
 }
 
diff --git a/security/security.c b/security/security.c
index c2de2f134854..4927e7cc7d96 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1058,7 +1058,12 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
 int security_kernel_load_data(enum kernel_load_data_id id)
 {
-	return call_int_hook(kernel_load_data, 0, id);
+	int ret;
+
+	ret = call_int_hook(kernel_load_data, 0, id);
+	if (ret)
+		return ret;
+	return ima_load_data(id);
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
-- 
2.7.5

