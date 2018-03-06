Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296182-2-8040038451586871488
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
    t=1520296181; b=OycqUWtR6nuFtNzvolBGLckhPV2Ndp90u73jfipsKmf3feY
    y9CWSk3wniUeF+yqS+kP+rexYt62NYbAX93oNv37RoqWYXuCzxw+M581xhDLebL/
    jBaYZFCajwx/yL9pX9AyYLZWl+VepYu69fG4hStG2mLKeENAOJh3IwaLPtiRX0/x
    dsNcyM3MrKiOwy6vVSIdg3GN+iozJNILcSITEQg+eX+NEesVFee2J/iPa0Tj9Q4z
    WzLX60l9ZVlnc7GimoSoZtlI4fVlFuOvhtzwcarT+OYCU8Ak4Y9lw44D6xt72rn1
    T8EkHgxx3Hw38fTgDwRBadBPPeHSwvTRGmF/Ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296181;
    bh=puFjkvxLF9cZSX5HpLluI/8I8Rs2yWy8gF6Qt8iW1GQ=; b=sK3cws6pQeF3
    XrpfSt5vfitG0Zbi7whl2zdid4F6Kgsuf7gWi1zM4PV0/GqvM7TCw4AvB2KC5KaL
    zzdEqpGpUcQUIHimoEDHhz4TlN45W4oRlt/+JXldvseksbVh15qN7OM6o7UVsfMx
    M8yBRISyH3aAZCU/YpNp5SUSSEPoHxXpJsVO2xe7/w2zBc80tC/qWVU80waFcoMt
    kMMtxOG01N+UTSWmSARVyFVY3HO4sOvk4pRCx14CqLfuvotgZk06MDH56tWXcjir
    Q5fj9FyjrB2leygzqqNoiLgN3z07pXjN7rS7RRmvu0U0Qh7qspyyw+YZqvddm7i9
    CsasDOTWlA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=SmDv4Oug x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=SmDv4Oug x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933513AbeCFA04 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeCFA0y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:54 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 53/65] kaiser: use ALTERNATIVE instead of x86_cr3_pcid_noflush
Date: Mon,  5 Mar 2018 19:25:26 -0500
Message-Id: <20180306002538.1761-54-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Now that we're playing the ALTERNATIVE game, use that more efficient
method: instead of user-mapping an extra page, and reading an extra
cacheline each time for x86_cr3_pcid_noflush.

Neel has found that __stringify(bts $X86_CR3_PCID_NOFLUSH_BIT, %rax)
is a working substitute for the "bts $63, %rax" in these ALTERNATIVEs;
but the one line with $63 in looks clearer, so let's stick with that.

Worried about what happens with an ALTERNATIVE between the jump and
jump label in another ALTERNATIVE?  I was, but have checked the
combinations in SWITCH_KERNEL_CR3_NO_STACK at entry_SYSCALL_64,
and it does a good job.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 2dff99eb0335f9e0817410696a180dba25ca7371)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/include/asm/kaiser.h |  6 +++---
 arch/x86/kernel/entry_64.S    |  7 ++++---
 arch/x86/mm/kaiser.c          | 11 +----------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 96643a9c194c..906150d6094e 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -25,7 +25,8 @@
 .macro _SWITCH_TO_KERNEL_CR3 reg
 movq %cr3, \reg
 andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
-orq  x86_cr3_pcid_noflush, \reg
+/* If PCID enabled, set X86_CR3_PCID_NOFLUSH_BIT */
+ALTERNATIVE "", "bts $63, \reg", X86_FEATURE_PCID
 movq \reg, %cr3
 .endm
 
@@ -39,7 +40,7 @@ movq \reg, %cr3
 movq %cr3, \reg
 orq  PER_CPU_VAR(x86_cr3_pcid_user), \reg
 js   9f
-/* FLUSH this time, reset to NOFLUSH for next time (if PCID enabled) */
+/* If PCID enabled, FLUSH this time, reset to NOFLUSH for next time */
 movb \regb, PER_CPU_VAR(x86_cr3_pcid_user+7)
 9:
 movq \reg, %cr3
@@ -90,7 +91,6 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 */
 DECLARE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
 
-extern unsigned long x86_cr3_pcid_noflush;
 DECLARE_PER_CPU(unsigned long, x86_cr3_pcid_user);
 
 extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 71189e3d1073..f681e3bc6c22 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1332,7 +1332,8 @@ ENTRY(paranoid_entry)
 	jz	2f
 	orl	$2, %ebx
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
-	orq	x86_cr3_pcid_noflush, %rax
+	/* If PCID enabled, set X86_CR3_PCID_NOFLUSH_BIT */
+	ALTERNATIVE "", "bts $63, %rax", X86_FEATURE_PCID
 	movq	%rax, %cr3
 2:
 #endif
@@ -1568,7 +1569,7 @@ ENTRY(nmi)
 	/* %rax is saved above, so OK to clobber here */
 	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
 	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
-	orq	x86_cr3_pcid_noflush, %rax
+	ALTERNATIVE "", "bts $63, %rax", X86_FEATURE_PCID
 	pushq	%rax
 	/* mask off "user" bit of pgd address and 12 PCID bits: */
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
@@ -1807,7 +1808,7 @@ end_repeat_nmi:
 	/* %rax is saved above, so OK to clobber here */
 	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
 	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
-	orq	x86_cr3_pcid_noflush, %rax
+	ALTERNATIVE "", "bts $63, %rax", X86_FEATURE_PCID
 	pushq	%rax
 	/* mask off "user" bit of pgd address and 12 PCID bits: */
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 88b4526d57a5..a8ce2e4737e0 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -32,7 +32,6 @@ DEFINE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
  * This is also handy because systems that do not support PCIDs
  * just end up or'ing a 0 into their CR3, which does no harm.
  */
-unsigned long x86_cr3_pcid_noflush __read_mostly;
 DEFINE_PER_CPU(unsigned long, x86_cr3_pcid_user);
 
 /*
@@ -357,10 +356,6 @@ void __init kaiser_init(void)
 	kaiser_add_user_map_early(&debug_idt_table,
 				  sizeof(gate_desc) * NR_VECTORS,
 				  __PAGE_KERNEL);
-
-	kaiser_add_user_map_early(&x86_cr3_pcid_noflush,
-				  sizeof(x86_cr3_pcid_noflush),
-				  __PAGE_KERNEL);
 }
 
 /* Add a mapping to the shadow mapping, and synchronize the mappings */
@@ -434,18 +429,14 @@ pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
 
 void kaiser_setup_pcid(void)
 {
-	unsigned long kern_cr3 = 0;
 	unsigned long user_cr3 = KAISER_SHADOW_PGD_OFFSET;
 
-	if (this_cpu_has(X86_FEATURE_PCID)) {
-		kern_cr3 |= X86_CR3_PCID_KERN_NOFLUSH;
+	if (this_cpu_has(X86_FEATURE_PCID))
 		user_cr3 |= X86_CR3_PCID_USER_NOFLUSH;
-	}
 	/*
 	 * These variables are used by the entry/exit
 	 * code to change PCID and pgd and TLB flushing.
 	 */
-	x86_cr3_pcid_noflush = kern_cr3;
 	this_cpu_write(x86_cr3_pcid_user, user_cr3);
 }
 
-- 
2.16.2
