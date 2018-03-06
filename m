Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296009-2-13101228526690510830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296009; b=qVtCY1OQEr7jjPbhNEa4znABV7tFS7Crqyu4R/4V13mk9do
    CpIiFbxCS1ZzL1QpNM5/8nzR8H04YgTuTak4Wb6YHeVDLj6FSeRrcNo4TsFLcRgL
    CIbU6Z9l79UeU9MLYngWRkjcOr9R7pO4zl8nYGJti+kB4o5L6+gcxdVt8yK00JpQ
    7NvtEqg48BnY3j2FjnygZzxwAW+7wojyeC/cbEXDrwqmyikjuSHCDurLPggkwWxD
    +Zb/zmR8KMto96LLze5oqxkTomLFvp2tOdBMMmNm1Hh6oYQ2kGi5HNKuRMo2BD2y
    /vev1Xe4ixUhzNHftQcx3iAmxcGHEXV8jmjhnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296009;
    bh=Loqnia0F1/gDzfa78590XFtH3yC1OyR6AtW5jtJGkB8=; b=sqZ0/j2DWv8q
    vGcbjm0c1lP57l0qlVOD+V3pHC/l2ZVwcXIr9gx4NUqRjmNVzRVNL+HJRRLjVrTj
    OsTp9PjugkRap1X20mwiDKIK5nUEzqpx/5EFNUQF5mN9DfuQfHlIuT6uK7lMtVum
    +QUxDmHzHF0PYB2Pmczhcmu4fj0aUrZ5PItrs8ISRm3pUcr4OMmxeD8lJjLtVbLW
    suFTcmJNvQnDlAXFRpTS+rstN9VIjuDdRRMzEftU8YPltXMmhkH9eGavqb9SRYIM
    k75HL6PmBLx+Tqo6ne++Gi269ytiF8yeqczXbJnv0nUz7w0J0r15SyPoMyoDcIJW
    RKvV91TsxA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=HbgVLnTU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=HbgVLnTU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbeCFA0q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeCFA0k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:40 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 40/65] kaiser: delete KAISER_REAL_SWITCH option
Date: Mon,  5 Mar 2018 19:25:13 -0500
Message-Id: <20180306002538.1761-41-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=865
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

We fail to see what CONFIG_KAISER_REAL_SWITCH is for: it seems to be
left over from early development, and now just obscures tricky parts
of the code.  Delete it before adding PCIDs, or nokaiser boot option.

(Or if there is some good reason to keep the option, then it needs
a help text - and a "depends on KAISER", so that all those without
KAISER are not asked the question.)

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit b9d2ccc54e17b5aa50dd0c036d3f4fb4e5248d54)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/include/asm/kaiser.h | 4 ----
 arch/x86/kernel/entry_64.S    | 4 ----
 security/Kconfig              | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 051acf678cda..e0fc45e77aee 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -21,17 +21,13 @@
 
 .macro _SWITCH_TO_KERNEL_CR3 reg
 movq %cr3, \reg
-#ifdef CONFIG_KAISER_REAL_SWITCH
 andq $(~KAISER_SHADOW_PGD_OFFSET), \reg
-#endif
 movq \reg, %cr3
 .endm
 
 .macro _SWITCH_TO_USER_CR3 reg
 movq %cr3, \reg
-#ifdef CONFIG_KAISER_REAL_SWITCH
 orq $(KAISER_SHADOW_PGD_OFFSET), \reg
-#endif
 movq \reg, %cr3
 .endm
 
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 5c6c11d9d779..d2b2372e01c6 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1541,9 +1541,7 @@ ENTRY(nmi)
 	/* %rax is saved above, so OK to clobber here */
 	movq	%cr3, %rax
 	pushq	%rax
-#ifdef CONFIG_KAISER_REAL_SWITCH
 	andq	$(~KAISER_SHADOW_PGD_OFFSET), %rax
-#endif
 	movq	%rax, %cr3
 #endif
 	call	do_nmi
@@ -1779,9 +1777,7 @@ end_repeat_nmi:
 	/* %rax is saved above, so OK to clobber here */
 	movq	%cr3, %rax
 	pushq	%rax
-#ifdef CONFIG_KAISER_REAL_SWITCH
 	andq	$(~KAISER_SHADOW_PGD_OFFSET), %rax
-#endif
 	movq	%rax, %cr3
 #endif
 	DEFAULT_FRAME 0				/* XXX: Do we need this? */
diff --git a/security/Kconfig b/security/Kconfig
index 5f4b656bfa4c..9d63046e4794 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -41,10 +41,6 @@ config KAISER
 
 	  If you are unsure how to answer this question, answer Y.
 
-config KAISER_REAL_SWITCH
-	bool "KAISER: actually switch page tables"
-	default y
-
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
-- 
2.16.2
