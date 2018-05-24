Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527160247-2-3429427516658199394
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160247; b=i5hA1GAsxSATL3trez1BLJc2e586E5GGtT0Jvti3s3UREt0seg
    z8dB1epjvTzDgvwKYivxgWwH88FMzlCYElhfAnaOmsfdZLuU9xEX8qQhdmNnuOOd
    EBIIWXYR1Zjqthtbx9EF9760OQg8cD9Jj9PGPR63eicT70x4LQFWimV7vE+USd6V
    rNlz0qNY7gQLlDZXZ78YPZ+F3tVXJfnBD+Akd+EV1dle1CIjzTG2vi+07S5O765M
    bICIRypNaZA20X/TAeh0n9E3LdNACb6rlzYrBL+Eln8aPssX3fuNScADQRggEfbi
    CpCB5M6CRbgb8iuc+5nvMk+5z23xjJ8v8Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527160247; bh=D
    21EqZBR1fzuRi2qnMDctRKMU8TCs9nPUndFz/HNRw4=; b=l4nYDF5e2aBrMTvNf
    lpgcjwqzyL6OHcV6KSFb9UgiJgy2Lxd3y/x6efx7zyJ3AaVk1WQieTBNCPA1FM0j
    deJJKHV2AubM8ap/OQuyswEkjNCQFUJxUMobUr95tf+MfTyPKFgDVCWXPZK5pnAK
    UnXn9S0rc1Bi2S5RbxP+X103vVc8z4AWctZ0/kxGKnfuX8Qc6Q5FB3yLAF3OpiUx
    gjk104PHeFxINytUAuMRiX2qNU6f1QONFw2zkxKwmgiwxjdCGvwk7F9R60WKoxPB
    UBznlttZj5BxXay27od7WsN9l4+ADNW0mdMPm2DlokGsM6g47Aqo9NPbcUI9POca
    vDc6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfM/FCJZOTV5YIZHgskfKBse63b50b8xgnuE55IgMB8/HHmymtHJjYnlzbrPMtJ4P8PLQm/NnBjaPTlchkONWSHX+oaUisxVcM8/MNQTFJUW951aiuVp7
    +0qHnHiDg2ZVtdDvuvAeJtFVDHQkgcE3Ws3Ys/VtBlzTaGqHskOu4XmySj8X+PNp8OPEceKoHR1Kd7Ok1YR4zeO7qR3fmyv2MbjtsOWESA4vlZ4Wgh2GLEJm
    Ejxq5ZRESh1QlMk/kJ/14Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=20KFwNOVAAAA:8
    a=lCymfdQyKLSz-83n_N0A:9 a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033060AbeEXLKl (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 07:10:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032946AbeEXLKh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 07:10:37 -0400
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
Subject: [PATCH v3 3/7] ima: based on policy require signed kexec kernel images
Date: Thu, 24 May 2018 07:09:32 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052411-0008-0000-0000-000004FAA7C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052411-0009-0000-0000-00001E8EAFD2
Message-Id: <1527160176-29269-4-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240132
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The original kexec_load syscall can not verify file signatures.  This
patch differentiates between the kexec_load and kexec_file_load
syscalls.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>

Changelog v3:
- use switch/case
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_main.c   | 22 +++++++++++++++++-----
 security/integrity/ima/ima_policy.c |  2 ++
 3 files changed, 20 insertions(+), 5 deletions(-)

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
index eeb7075868db..fbbcc02a1380 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -432,15 +432,27 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_data(struct file *file, enum kernel_read_file_id read_id)
 {
-	bool sig_enforce = is_module_sig_enforced();
+	bool sig_enforce;
 
-	if (!file && read_id == READING_MODULE) {
-		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
+		return 0;
+
+	switch (read_id) {
+	case READING_MODULE:
+		sig_enforce = is_module_sig_enforced(); /* appended sig */
+		if (!file && !sig_enforce &&
+		    (ima_appraise & IMA_APPRAISE_MODULES)) {
 			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
-		return 0;	/* We rely on module signature checking */
+		break;
+	case READING_KEXEC_IMAGE:
+		if (!file && (ima_appraise & IMA_APPRAISE_KEXEC)) {
+			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file syscall.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+	default:
+		break;
 	}
 	return 0;
 }
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
 
-- 
2.7.5

