Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527160290-2-17422933601619584792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160289; b=niuAPHrPyZMQuCO1GhM9SEfOqwryhXf98gzPyRL1Td4nsvDkG5
    xlt6Wa3+vGCZG0wOScknb6k758P0uHIYomDO68zcyw4dmlkUVvIQeD+r0GLUG0Mw
    IvPweOjb7wX4LBMVGm7xNRtD/AvpZVIW5VLrsto19OT5X7N/soFTEJITdCsKHI7+
    euKSI5WvvPHzRCXoacZXlsqr0BN2QoxHxoScvRXkedQsuvOYAcLURFxAZKACDmLk
    BM3VRsOwG4wY6XOfDfBYjeSjnxj+VwaOyokkY6j2YL2dBHSepIq2F1+gnFGG+q/f
    pIkEXPgRPSFBefVXLStu9Y2/Zr91PidIdW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1527160289; bh=J
    TOWBWNSEi65ZZr24Lo47sfy1ALil1dWymohHyMtgo4=; b=BZgtZ2J4kFoL3CT7d
    +ZKGNjzReh3PIu4/DewQK1brLL3ihb4Q2G+mDHhx2iBH9ntbqkQobszZ35C1TgeX
    kkkYy4cAFzRPaH8QjJdeEaDwSs/D59tpwQRXHBNBZPrnEDke6YwXdtjfjDswRLlf
    bMMi1bMjBgEB1YM3iU+AGkQmwqy/RgGebo9p/ve8quOBxgRNgGzoGLASEAtV5oKz
    CwFxtBJbAetoroGp7/jVD1ABj1VMlRGnHDpf9Uk4+DjQ0NtKEc9nKpcuXsuPs9OK
    aHsS40xbv65063gpbjrxTmrxAWpV0uC8jkfCEk1+fMOhFzksYVK+JExxpGvBrCwc
    llsbw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJELV6TBW0IDZuc05WFtXHkTNyuFbQT7bTT/ZdnIOdYI9T6yVCEUOZZf/XCh6DcpEQyPEsOJceO39ACmGvebR2nl0RCAzUdOuYTzLPVqVMT346rsJj00
    X+tmQZqsmwUtC1GULug5LxbEsvGbcD+tEP+gsaTxPRDp1m5qCzFRS2Tq8AauzmtOWD51I1BXQo2CjKUH2vthXW297I1vwtZpwiB/AaAmky546XXo+hyC1Rsa
    FxmDUxPVqdzXa5oxDT3mAA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=FP58Ms26AAAA:8 a=VwQbUJbxAAAA:8 a=8RqDXDEII9YSNXipYuUA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968143AbeEXLL1 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 07:11:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033067AbeEXLKq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 07:10:46 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 6/7] ima: add build time policy
Date: Thu, 24 May 2018 07:09:35 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052411-0012-0000-0000-000005DA20ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052411-0013-0000-0000-000019576FA0
Message-Id: <1527160176-29269-7-git-send-email-zohar@linux.vnet.ibm.com>
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

IMA by default does not measure, appraise or audit files, but can be
enabled at runtime by specifying a builtin policy on the boot command line
or by loading a custom policy.

This patch defines a build time policy, which verifies kernel modules,
firmware, kexec image, and/or the IMA policy signatures.  This build time
policy is automatically enabled at runtime.  The build time policy rules
persist after loading a custom policy.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/Kconfig      | 58 +++++++++++++++++++++++++++++++++++++
 security/integrity/ima/ima_policy.c | 46 +++++++++++++++++++++++++++--
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 6a8f67714c83..004919d9bf09 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -156,6 +156,64 @@ config IMA_APPRAISE
 	  <http://linux-ima.sourceforge.net>
 	  If unsure, say N.
 
+config IMA_APPRAISE_BUILD_POLICY
+	bool "IMA build time configured policy rules"
+	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+	default n
+	help
+	  This option defines an IMA appraisal policy at build time, which
+	  is enforced at run time without having to specify a builtin
+	  policy name on the boot command line.  The build time appraisal
+	  policy rules persist after loading a custom policy.
+
+	  Depending on the rules configured, this policy may require kernel
+	  modules, firmware, the kexec kernel image, and/or the IMA policy
+	  to be signed.  Unsigned files might prevent the system from
+	  booting or applications from working properly.
+
+config IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
+	bool "Appraise firmware signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  This option defines a policy requiring all firmware to be signed,
+	  including the regulatory.db.  If both this option and
+	  CFG80211_REQUIRE_SIGNED_REGDB are enabled, then both signature
+	  verification methods are necessary.
+
+config IMA_APPRAISE_REQUIRE_KEXEC_SIGS
+	bool "Appraise kexec kernel image signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require all kexec'ed kernel images to
+	  be signed and verified by a public key on the trusted IMA
+	  keyring.
+
+	  Kernel image signatures can not be verified by the original
+	  kexec_load syscall.  Enabling this rule will prevent its
+	  usage.
+
+config IMA_APPRAISE_REQUIRE_MODULE_SIGS
+	bool "Appraise kernel modules signatures"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require all kernel modules to be signed
+	  and verified by a public key on the trusted IMA keyring.
+
+	  Kernel module signatures can only be verified by IMA-appraisal,
+	  via the finit_module syscall. Enabling this rule will prevent
+	  the usage of the init_module syscall.
+
+config IMA_APPRAISE_REQUIRE_POLICY_SIGS
+	bool "Appraise IMA policy signature"
+	depends on IMA_APPRAISE_BUILD_POLICY
+	default n
+	help
+	  Enabling this rule will require the IMA policy to be signed and
+	  and verified by a key on the trusted IMA keyring.
+
 config IMA_APPRAISE_BOOTPARAM
 	bool "ima_appraise boot parameter"
 	depends on IMA_APPRAISE
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c27f6993b07a..3c0bc8a1a88e 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -49,6 +49,7 @@
 
 int ima_policy_flag;
 static int temp_ima_appraise;
+static int build_ima_appraise __ro_after_init;
 
 #define MAX_LSM_RULES 6
 enum lsm_rule_types { LSM_OBJ_USER, LSM_OBJ_ROLE, LSM_OBJ_TYPE,
@@ -162,6 +163,25 @@ static struct ima_rule_entry default_appraise_rules[] __ro_after_init = {
 #endif
 };
 
+static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS
+	{.action = APPRAISE, .func = MODULE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_FIRMWARE_SIGS
+	{.action = APPRAISE, .func = FIRMWARE_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS
+	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+#ifdef CONFIG_IMA_APPRAISE_REQUIRE_POLICY_SIGS
+	{.action = APPRAISE, .func = POLICY_CHECK,
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+#endif
+};
+
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
@@ -435,7 +455,7 @@ void ima_update_policy_flag(void)
 			ima_policy_flag |= entry->action;
 	}
 
-	ima_appraise |= temp_ima_appraise;
+	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
@@ -488,8 +508,8 @@ void __init ima_init_policy(void)
 	}
 
 	/*
-	 * Insert the appraise rules requiring file signatures, prior to
-	 * any other appraise rules.
+	 * Insert the builtin "secure_boot" policy rules requiring file
+	 * signatures, prior to any other appraise rules.
 	 */
 	for (i = 0; i < secure_boot_entries; i++) {
 		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
@@ -497,6 +517,26 @@ void __init ima_init_policy(void)
 		    ima_appraise_flag(secure_boot_rules[i].func);
 	}
 
+	/*
+	 * Insert the build time appraise rules requiring file signatures
+	 * for both the initial and custom policies, prior to other appraise
+	 * rules.
+	 */
+	for (i = 0; i < ARRAY_SIZE(build_appraise_rules); i++) {
+		struct ima_rule_entry *entry;
+
+		if (!secure_boot_entries)
+			list_add_tail(&build_appraise_rules[i].list,
+				      &ima_default_rules);
+
+		entry = kmemdup(&build_appraise_rules[i], sizeof(*entry),
+				GFP_KERNEL);
+		if (entry)
+			list_add_tail(&entry->list, &ima_policy_rules);
+		build_ima_appraise |=
+			ima_appraise_flag(build_appraise_rules[i].func);
+	}
+
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
 			      &ima_default_rules);
-- 
2.7.5

