Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3090366-1526002668-2-11880205784381225425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526002667; b=RIGogSNnv8Jx2inuQUPYj+yBOoA2Rx4KIPAfPM4ZE0xtBxePy9
    KFa2AIY1GkvRZft2DPuPuNcNdJFi0Q9aHk5LRacVm/JOiO3xGy9QgRwt483gMz92
    5VNd9rAlEqRkW0GqHk84K6fRns6aDURAmLBeGAtubUmXIzjiyiSu2T/BRlCDrKeo
    A0nDU5zvbtSjMiOMGc7wgE0mVQRtkEGy6gcICg+5DzBuxRPTSZS9oS7zPAsM3yhr
    MjU1sDaqr6f/kuQHztypw34GoB1CFnknsUpfO78memDlLx+bn5A5Ai67tc+B0KD5
    mkRv1oRs8Yymth1SCcIrtzXpIIqUW4v5187g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1526002667; bh=f
    l69Fsg9B3NRDDeyoIvlVLSTN4p2PuZWlG9jnDQLbVI=; b=dkqPHStnpKn7mGHMN
    M3tgyW66EV69w6F4tVn9WKoEODsknkJtp4JVNprN4Ta/iFdtR7EqQQUBdNqSLjr5
    pqjS9m4lwml4XY43An1hFmQXHL224dpmq0fmKJ4iisQ1Cn1pba+d/av5bjQhV786
    NgLr9vN6+nROsNiiYVdPp60bhnjE3pXgn5U/I2aTrPZz7yFz+UUKnVBsJq34dLZA
    zSuXTnplvPWDtd0tvEhds048DR1w4EW1w9HUHfn0Ube3i4MTCEDyFfE2RzRraEpR
    WDOBjyTLSyiWmkwf/HyxU0pp2tv2cFjf3JQmFT7KkXutUpFQAHTF+Yqq/nRMiy8X
    7MxpA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfN76XwDDiTuoWdbZinclgL34Gu9+PBbKDK0uaL1AHhCaTdGiUfNI4rp2l8fk1nhwkfPgjcWAx5XORB3+kc/6KbwgA25lk1/ch2omzmVK8BXTvnnqGnqJ
    dzQFalW1g+QKlatyhgKDskRDGDUw4n0UN1V+h1OhO75F41PJPMEXwktupImwIQ+NYXmnfg8kG/95lJuLq3MtA54bhDmoW65KcwB8DzBEn2r7RZQRoxD7xvQD
    CiQ4T9lDW8okiSsHdGO5XQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=gcgLhCrLNEnsWC2q02QA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeEKBhq (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 21:37:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752052AbeEKBhF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 21:37:05 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ima: based on the "secure_boot" policy limit syscalls
Date: Thu, 10 May 2018 21:36:46 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051101-0020-0000-0000-0000041C145A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051101-0021-0000-0000-000042B114E5
Message-Id: <1526002608-27474-2-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110009
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The builtin "secure_boot" policy adds IMA appraisal rules requiring kernel
modules (finit_module syscall), direct firmware load, kexec kernel image
(kexec_file_load syscall), and the IMA policy to be signed, but did not
prevent the other syscalls/methods from working.  Loading an equivalent
custom policy containing these same rules would have prevented the other
syscalls/methods from working.

This patch refactors the code to load custom policies, defining a new
function named ima_appraise_flag().  The new function is called either
when loading the builtin "secure_boot" or custom policies.

Fixes: 503ceaef8e2e ("ima: define a set of appraisal rules requiring file signatures")
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 03cbba423e59..df3e45878a87 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -440,6 +440,17 @@ void ima_update_policy_flag(void)
 		ima_policy_flag &= ~IMA_APPRAISE;
 }
 
+static int ima_appraise_flag(enum ima_hooks func)
+{
+	if (func == MODULE_CHECK)
+		return IMA_APPRAISE_MODULES;
+	else if (func == FIRMWARE_CHECK)
+		return IMA_APPRAISE_FIRMWARE;
+	else if (func == POLICY_CHECK)
+		return IMA_APPRAISE_POLICY;
+	return 0;
+}
+
 /**
  * ima_init_policy - initialize the default measure rules.
  *
@@ -478,9 +489,12 @@ void __init ima_init_policy(void)
 	 * Insert the appraise rules requiring file signatures, prior to
 	 * any other appraise rules.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
+	for (i = 0; i < secure_boot_entries; i++) {
 		list_add_tail(&secure_boot_rules[i].list,
 			      &ima_default_rules);
+		temp_ima_appraise |=
+		    ima_appraise_flag(secure_boot_rules[i].func);
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
@@ -934,12 +948,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	}
 	if (!result && (entry->action == UNKNOWN))
 		result = -EINVAL;
-	else if (entry->func == MODULE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_MODULES;
-	else if (entry->func == FIRMWARE_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
-	else if (entry->func == POLICY_CHECK)
-		temp_ima_appraise |= IMA_APPRAISE_POLICY;
+	else if (entry->action == APPRAISE)
+		temp_ima_appraise |= ima_appraise_flag(entry->func);
+
 	audit_log_format(ab, "res=%d", !result);
 	audit_log_end(ab);
 	return result;
-- 
2.7.5

