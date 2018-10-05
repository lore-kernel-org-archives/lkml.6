Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F119C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C652084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C652084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeJFAnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:43:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729119AbeJFAnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:43:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95HdNoL001896
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 13:43:55 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxaevp5db-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:43:55 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 18:43:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 18:43:50 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95HhmZR61079676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 17:43:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 718D511C058;
        Fri,  5 Oct 2018 20:43:24 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA13911C04C;
        Fri,  5 Oct 2018 20:43:20 +0100 (BST)
Received: from swastik.in.ibm.com (unknown [9.124.221.60])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 20:43:20 +0100 (BST)
From:   Nayna Jain <nayna@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        Eric Richter <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v5 5/5] x86/ima: define arch_get_ima_policy() for x86
Date:   Fri,  5 Oct 2018 23:10:15 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
References: <20181005174015.21939-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100517-0008-0000-0000-0000027B88DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100517-0009-0000-0000-000021E4B4D4
Message-Id: <20181005174015.21939-6-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Richter <erichte@linux.ibm.com>

On x86, there are two methods of verifying a kexec'ed kernel image
signature being loaded via the kexec_file_load syscall - an architecture
specific implementaton or a IMA KEXEC_KERNEL_CHECK appraisal rule. Neither
of these methods verify the kexec'ed kernel image signature being loaded
via the kexec_load syscall.

Secure boot enabled systems require kexec images to be signed. Therefore,
this patch loads an IMA KEXEC_KERNEL_CHECK policy rule on secure boot
enabled systems not configured with CONFIG_KEXEC_VERIFY_SIG enabled.

When IMA_APPRAISE_BOOTPARAM is configured, different IMA appraise modes
(eg. fix, log) can be specified on the boot command line, allowing unsigned
or invalidly signed kernel images to be kexec'ed. This patch permits
enabling IMA_APPRAISE_BOOTPARAM or IMA_ARCH_POLICY, but not both.

Signed-off-by: Eric Richter <erichte@linux.ibm.com>
- Removed the policy KEXEC_ORIG_KERNEL_CHECK which was defined to
  disable the kexec_load syscall.
- arch_get_ima_policy() uses arch_ima_get_secureboot() to get secureboot
  state
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/x86/kernel/ima_arch.c     | 18 ++++++++++++++++++
 include/linux/ima.h            |  4 ++++
 security/integrity/ima/Kconfig | 10 +++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index bb5a88d2b271..245976e49a55 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -15,3 +15,21 @@ bool arch_ima_get_secureboot(void)
 	else
 		return false;
 }
+
+/* arch rules for audit and user mode */
+static const char * const sb_arch_rules[] = {
+#ifndef CONFIG_KEXEC_VERIFY_SIG
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
+#endif /* CONFIG_KEXEC_VERIFY_SIG */
+	"measure func=KEXEC_KERNEL_CHECK",
+	NULL
+};
+
+#ifdef CONFIG_IMA_ARCH_POLICY
+const char * const *arch_get_ima_policy(void)
+{
+	if (arch_ima_get_secureboot())
+		return sb_arch_rules;
+	return NULL;
+}
+#endif
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 350fa957f8a6..dabd3abdf671 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -39,10 +39,14 @@ static inline bool arch_ima_get_secureboot(void)
 }
 #endif
 
+#if defined(CONFIG_X86) && defined(CONFIG_IMA_ARCH_POLICY)
+extern const char * const *arch_get_ima_policy(void);
+#else
 static inline const char * const *arch_get_ima_policy(void)
 {
 	return NULL;
 }
+#endif
 
 #else
 static inline int ima_bprm_check(struct linux_binprm *bprm)
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 13b446328dda..a18f8c6d13b5 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -157,6 +157,14 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_ARCH_POLICY
+        bool "Enable loading an IMA architecture specific policy"
+        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+        default n
+        help
+          This option enables loading an IMA architecture specific policy
+          based on run time secure boot flags.
+
 config IMA_APPRAISE_BUILD_POLICY
 	bool "IMA build time configured policy rules"
 	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
@@ -217,7 +225,7 @@ config IMA_APPRAISE_REQUIRE_POLICY_SIGS
 
 config IMA_APPRAISE_BOOTPARAM
 	bool "ima_appraise boot parameter"
-	depends on IMA_APPRAISE
+	depends on IMA_APPRAISE && !IMA_ARCH_POLICY
 	default y
 	help
 	  This option enables the different "ima_appraise=" modes
-- 
2.13.6

