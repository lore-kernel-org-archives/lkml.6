Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840387-2-7739019782462923619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840386; b=VYm/Hhg6FjFRuXKTEMJJcgNnzhctywmetQHYIl8pSplMkXJGiL
    mPcNJcIn0JjpUm9xKxRpPb264KHHUd8ibQw4FKoNPu/zrA0Lm+11ucV28nTr44HH
    kBvoELWedYFWnSdO+B0c7UJsy4LEWTYcjyyOyvDgrTSvlIrANmEoiCAjlHTUUgvl
    aOEQTxUlAVF61XJ4b6zrr+QlFvStah4FVkQBIQLpRLTTQhKa9eJ8q9i2ucKyVPqq
    h80WqQiavoZtD9EvQH+wWkUFrrnA2qzAzPLJ3ZhgSeaAI6NyYEPbOl7SEfBWjlxc
    QBLY9Y+8GZqP9hHLjEidMCM28bCb9A1cbqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840386; bh=QENMuo+tkAU/bX5rIzeEuVSiTHrQaq
    BlGv9YWRVh6uY=; b=PhY0whlsNCZE2x2Cn4kaFdBs9zgWcM1oBy/Py5DMDCYPTl
    Tp5ObcYEd50szb5cXVNSLJqg62VApXOhDZT9mOvvTzsj3eCYwFVtFhu2839k+gqS
    3iM6yTN+dtirN/9WmRlUquzhNdynJfMGPH9EPuPK4z/Gsu/020wDNILTv5aar5hV
    E+Vw1BB1SdAbhgBVrJ4fKs2H4VDnMipZJr/Cj+3xkOtzkY7veL+MyLJHNkPIeDnr
    PXtBn553PIoFYf2ZeI9y7MontjN6zKUY6PKYb80A+xSAJcHGwM76Q2tXDWvyJeT0
    EwYQQV2ccaueL5rv17FeZDlu8NG+oRTwKq5eE8pw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMh4uD4QFG4GZX8wdJvqyfMIx2dKcm3nCdRiBb4JuSzZq+y+t5K9vt2q5YPDdp/BFVnFA5A4u0nkG7WW7Bq/afaoyojF2QRddZX+950villGwfWD2dv1
    3ZmpAQ2XB7vkyiuNnR25R1oVzl3p2FxVcHthxiSkC8wtm7iaHTUKZTA+LmhetKnWj9e+bhwQHWFrRIsZ9CkAkCEpe1jY9Ipy09YhzQz3I9HxpgfphjHD8gvi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=Xq-SzLe9qOIIhLYwjLEA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934116AbeD0OqK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933960AbeD0OIG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878A721892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 55/80] s390: move nobp parameter functions to nospec-branch.c
Date: Fri, 27 Apr 2018 15:58:48 +0200
Message-Id: <20180427135735.731178755@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit b2e2f43a01bace1a25bdbae04c9f9846882b727a ]

Keep the code for the nobp parameter handling with the code for
expolines. Both are related to the spectre v2 mitigation.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/Makefile        |    4 ++--
 arch/s390/kernel/alternative.c   |   23 -----------------------
 arch/s390/kernel/nospec-branch.c |   27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 25 deletions(-)

--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -59,11 +59,11 @@ obj-y	+= debug.o irq.o ipl.o dis.o diag.
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o
 obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
+obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
-obj-$(CONFIG_EXPOLINE)		+= nospec-branch.o
-CFLAGS_REMOVE_expoline.o	+= $(CC_FLAGS_EXPOLINE)
+CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_SMP)		+= smp.o
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -14,29 +14,6 @@ static int __init disable_alternative_in
 
 early_param("noaltinstr", disable_alternative_instructions);
 
-static int __init nobp_setup_early(char *str)
-{
-	bool enabled;
-	int rc;
-
-	rc = kstrtobool(str, &enabled);
-	if (rc)
-		return rc;
-	if (enabled && test_facility(82))
-		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
-	else
-		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
-	return 0;
-}
-early_param("nobp", nobp_setup_early);
-
-static int __init nospec_setup_early(char *str)
-{
-	__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
-	return 0;
-}
-early_param("nospec", nospec_setup_early);
-
 struct brcl_insn {
 	u16 opc;
 	s32 disp;
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -3,6 +3,31 @@
 #include <asm/facility.h>
 #include <asm/nospec-branch.h>
 
+static int __init nobp_setup_early(char *str)
+{
+	bool enabled;
+	int rc;
+
+	rc = kstrtobool(str, &enabled);
+	if (rc)
+		return rc;
+	if (enabled && test_facility(82))
+		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
+	else
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nobp", nobp_setup_early);
+
+static int __init nospec_setup_early(char *str)
+{
+	__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nospec", nospec_setup_early);
+
+#ifdef CONFIG_EXPOLINE
+
 int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
 int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
 
@@ -99,3 +124,5 @@ void __init nospec_init_branches(void)
 	nospec_call_revert(__nospec_call_start, __nospec_call_end);
 	nospec_return_revert(__nospec_return_start, __nospec_return_end);
 }
+
+#endif /* CONFIG_EXPOLINE */
