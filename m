Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296046-2-7965803250276781252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296045; b=VIYFd2s4FGYKuHDokBFu+PYmbCxFCFRabpEn1h5DqeLsWx4
    AFwW/3a6wMZM4ef0HdF+dyRlUK++sDJiGNRnxqhIL40IglmALl2ZAM2DzueUnloq
    Mz2UXg8FtM+gV2G0mfyIwUo9O0Bxl+LUjBD7RCsl44uCwNecuBdPYXce41LCCB9/
    fa25CmXz4odAAjz6d592hEZo0ovfuAz+ySumxIUxYPsBDQa2nbau7GI/P2ogXqv1
    sobObfsRDkzeREwUH8WPlkXUKjT1jhEDjUYv5aRNNe0KQh4cg1bRTTOrZ7A9mI4K
    Se4YT5wwmBBukxwtSs8Hmc8pJ+SweW8Wqvvxwsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296045;
    bh=Gsan5jcrZEXiIwOa3d7zS8zuvKw9MOGaBuVME/FjE+c=; b=RGyBvLcrnBsU
    6sWNKMzOKFnoMK1R5Ca/LESFaqs1iio/xF0us3FUwiVwh3qr5uwpiYtVw79ungvs
    POvP75BWusPtwTH7CzZo/9b4ZehX0ua/x5txGuM84c7Kzb9vHND5rBI5uPuXtdU+
    GHJkl3Wx/xKE+gMYVxKSu+W1MOYyDlsD9zPBgXl0De+e85tP8AS3fIOuIaJF+Vjf
    JO2NKvRGEgApMJ3Shcy8aN0riA/uFS/aOhsqINgeO+CacdZaeXYPvHWpTiYZjqpM
    NJ8rZL9P/AEFvbCtPaXTVroSz/WI4IPiyOSy50s9iNOj/d+ieaEOb5lle/QEQ+QA
    75fQ6MIoJA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ucf2i9ZZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ucf2i9ZZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933495AbeCFA1F (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:27:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56728 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeCFA1D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:03 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 65/65] x86/pti/efi: broken conversion from efi to kernel page table
Date: Mon,  5 Mar 2018 19:25:38 -0500
Message-Id: <20180306002538.1761-66-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In entry_64.S we have code like this:

    /* Unconditionally use kernel CR3 for do_nmi() */
    /* %rax is saved above, so OK to clobber here */
    ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
    /* If PCID enabled, NOFLUSH now and NOFLUSH on return */
    ALTERNATIVE "", "bts $63, %rax", X86_FEATURE_PCID
    pushq   %rax
    /* mask off "user" bit of pgd address and 12 PCID bits: */
    andq    $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
    movq    %rax, %cr3
2:

    /* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
    call    do_nmi

With this instruction:
    andq    $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax

We unconditionally switch from whatever our CR3 was to kernel page table.
But, in arch/x86/platform/efi/efi_64.c We temporarily set a different page
table, that does not have the kernel page table with 0x1000 offset from it.

Look in efi_thunk() and efi_thunk_set_virtual_address_map().

So, while CR3 points to the other page table, we get an NMI interrupt,
and clear 0x1000 from CR3, resulting in a bogus CR3 if the 0x1000 bit was
set.

The efi page table comes from realmode/rm/trampoline_64.S:

arch/x86/realmode/rm/trampoline_64.S

141 .bss
142 .balign PAGE_SIZE
143 GLOBAL(trampoline_pgd) .space PAGE_SIZE

Notice: alignment is PAGE_SIZE, so after applying KAISER_SHADOW_PGD_OFFSET
which equal to PAGE_SIZE, we can get a different page table.

But, even if we fix alignment, here the trampoline binary is later copied
into dynamically allocated memory in reserve_real_mode(), so we need to
fix that place as well.

Fixes: 8a43ddfb93a0 ("KAISER: Kernel Address Isolation")

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 7ec5d87df34a90758cf2aaf6824bb748454a8f35)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/kaiser.h        | 10 ++++++++++
 arch/x86/realmode/init.c             |  4 +++-
 arch/x86/realmode/rm/trampoline_64.S |  3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 5d85ddf26166..620619d8de57 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -19,6 +19,16 @@
 
 #define KAISER_SHADOW_PGD_OFFSET 0x1000
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+/*
+ *  A page table address must have this alignment to stay the same when
+ *  KAISER_SHADOW_PGD_OFFSET mask is applied
+ */
+#define KAISER_KERNEL_PGD_ALIGNMENT (KAISER_SHADOW_PGD_OFFSET << 1)
+#else
+#define KAISER_KERNEL_PGD_ALIGNMENT PAGE_SIZE
+#endif
+
 #ifdef __ASSEMBLY__
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 0b7a63d98440..805a3271a137 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -4,6 +4,7 @@
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 #include <asm/realmode.h>
+#include <asm/kaiser.h>
 
 struct real_mode_header *real_mode_header;
 u32 *trampoline_cr4_features;
@@ -15,7 +16,8 @@ void __init reserve_real_mode(void)
 	size_t size = PAGE_ALIGN(real_mode_blob_end - real_mode_blob);
 
 	/* Has to be under 1M so we can execute real-mode AP code. */
-	mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
+	mem = memblock_find_in_range(0, 1 << 20, size,
+				     KAISER_KERNEL_PGD_ALIGNMENT);
 	if (!mem)
 		panic("Cannot allocate trampoline\n");
 
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index dac7b20d2f9d..781cca63f795 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -30,6 +30,7 @@
 #include <asm/msr.h>
 #include <asm/segment.h>
 #include <asm/processor-flags.h>
+#include <asm/kaiser.h>
 #include "realmode.h"
 
 	.text
@@ -139,7 +140,7 @@ tr_gdt:
 tr_gdt_end:
 
 	.bss
-	.balign	PAGE_SIZE
+	.balign	KAISER_KERNEL_PGD_ALIGNMENT
 GLOBAL(trampoline_pgd)		.space	PAGE_SIZE
 
 	.balign	8
-- 
2.16.2
