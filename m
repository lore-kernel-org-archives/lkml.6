Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816600-1525939995-2-5244871689111648528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525939995; b=JBLoDtKsXbPIIgSn8PiwhZDVyixx8ZAqENmA2vlNBxg1wLd1Eq
    x6c0OSgmQxR+JHHCPKPY6oXDVaXkJNWPtvK+vPqc28ULR24eBCTvcafGtRU4OBtL
    JlqdSdPDlm7vV1DOM9yvsmWlxHgB0gzileBPsGbBz38v7SRYs12IkkSDrzKWVfWb
    8plnNmh8fNome+Tq/QBE4pvC5rHcdBfHN4Hnfb6q6sqcusSXCUNRmdWGKeYd4zu5
    e01srE/E6FwZbuupc0wUmSMaoyoLvEbpul7vdLFU4x3Fqd8hAg7biZ1QMI28+zL9
    y08AsGGiY8X1yW3v8zgOhA4tpmBl0eCthuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525939995; bh=
    i5F4/swcoIth4L/6WUqXN53eMNbh8ym9CXj5IKdH61Q=; b=Xf8X1WtFurTwcqKG
    xBJag471JjLhFA2JPL9YToR2bCn08VeMZkBYrFEfb90DEDeTeAtCaidNXibHOuZh
    rIr4UWnleEpIrnGglGfHkfW0mkrrN6w1WptW+6lBeFEyGmMHL5LouyU5/M7d4Nbb
    SsBhAtzcHrDxlXMNtaDIYsb5RfjleqGDYLXfo2wEFmQ5ohL1DTBW/a5or0z/99r/
    fBb1X82y5PtuuOIfjKrQgtkwkDELvVdtZ4YtRCzBT+A9NxWp/SllquQjSTgMCHm3
    rM+HwS+n99m++5o6wnc+oExHDL0wrSOP+cn9jZknVLrl2Yr6MTzhqj9EZt2/VS89
    CGYCxg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNObFSpv0UGLqssxGzFOScbCU8FOzOQqcBrwpZ88MxSDMd2jRuw6dEbSoWYKsERdT3fq4Op0fVED0+yBXAnBaN79wed7SUoUyWmjOtd5RMBLIpR5gbQ+
    ISRlQl8u3q+QYH+39s3bptkx5FRZiL4asbyMaO/eRf261178RzV5eb5Z7DuSJhTYQ+5fRHsj/jdze1DXGDyKQR57YoUVBOlhFsDept+PMl8SiR2l+QZaRGwH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=oGMlB6cnAAAA:8
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=6kfwl7NHpHrI6RXzbgYA:9
    a=NdAtdrkLVvyUPsUoGJp4:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934891AbeEJINL (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 04:13:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:51891 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756773AbeEJIHC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 04:07:02 -0400
From: Jiri Slaby <jslaby@suse.cz>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH -resend 11/27] x86: boot, annotate data appropriatelly
Date: Thu, 10 May 2018 10:06:28 +0200
Message-Id: <20180510080644.19752-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END* macros for data.

Now, the data in the object file look sane:
Value   Size Type    Bind   Vis      Ndx Name
  0000    10 OBJECT  GLOBAL DEFAULT    3 efi32_boot_gdt
  000a    10 OBJECT  LOCAL  DEFAULT    3 save_gdt
  0014     8 OBJECT  LOCAL  DEFAULT    3 func_rt_ptr
  001c    48 OBJECT  GLOBAL DEFAULT    3 efi_gdt64
  004c     0 OBJECT  LOCAL  DEFAULT    3 efi_gdt64_end

  0000    48 OBJECT  LOCAL  DEFAULT    3 gdt
  0030     0 OBJECT  LOCAL  DEFAULT    3 gdt_end
  0030     8 OBJECT  LOCAL  DEFAULT    3 efi_config
  0038    49 OBJECT  GLOBAL DEFAULT    3 efi32_config
  0069    49 OBJECT  GLOBAL DEFAULT    3 efi64_config

All have correct size and type now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/efi_thunk_64.S | 21 ++++++++++++---------
 arch/x86/boot/compressed/head_64.S      | 29 ++++++++++++++---------------
 arch/x86/boot/compressed/mem_encrypt.S  |  6 ++----
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index bff9ab7c6317..d66000d23921 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -176,16 +176,19 @@ ENDPROC(efi_enter32)
 
 	.data
 	.balign	8
-	.global	efi32_boot_gdt
-efi32_boot_gdt:	.word	0
-		.quad	0
+SYM_DATA_START(efi32_boot_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_gdt)
+
+SYM_DATA_START_LOCAL(save_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(save_gdt)
 
-save_gdt:	.word	0
-		.quad	0
-func_rt_ptr:	.quad	0
+SYM_DATA_LOCAL(func_rt_ptr, .quad 0)
 
-	.global efi_gdt64
-efi_gdt64:
+SYM_DATA_START(efi_gdt64)
 	.word	efi_gdt64_end - efi_gdt64
 	.long	0			/* Filled out by user */
 	.word	0
@@ -194,4 +197,4 @@ efi_gdt64:
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 	.quad	0x0080890000000000	/* TS descriptor */
 	.quad   0x0000000000000000	/* TS continued */
-efi_gdt64_end:
+SYM_DATA_END_LABEL(efi_gdt64, SYM_L_LOCAL, efi_gdt64_end)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 614dc4868915..a1a92f6fc8e4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -599,12 +599,13 @@ SYM_FUNC_END(no_longmode)
 #include "../../kernel/verify_cpu.S"
 
 	.data
-gdt64:
+SYM_DATA_START_LOCAL(gdt64)
 	.word	gdt_end - gdt
 	.long	0
 	.word	0
 	.quad   0
-gdt:
+SYM_DATA_END(gdt64)
+SYM_DATA_START_LOCAL(gdt)
 	.word	gdt_end - gdt
 	.long	gdt
 	.word	0
@@ -613,25 +614,24 @@ gdt:
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 	.quad	0x0080890000000000	/* TS descriptor */
 	.quad   0x0000000000000000	/* TS continued */
-gdt_end:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_STUB
-efi_config:
-	.quad	0
+SYM_DATA_LOCAL(efi_config, .quad 0)
 
 #ifdef CONFIG_EFI_MIXED
-	.global efi32_config
-efi32_config:
+SYM_DATA_START(efi32_config)
 	.fill	5,8,0
 	.quad	efi64_thunk
 	.byte	0
+SYM_DATA_END(efi32_config)
 #endif
 
-	.global efi64_config
-efi64_config:
+SYM_DATA_START(efi64_config)
 	.fill	5,8,0
 	.quad	efi_call
 	.byte	1
+SYM_DATA_END(efi64_config)
 #endif /* CONFIG_EFI_STUB */
 
 /*
@@ -639,16 +639,15 @@ efi64_config:
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
-boot_stack:
+SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
+
+SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
-boot_stack_end:
+SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 
 /*
  * Space for page tables (not in .bss so not zeroed)
  */
 	.section ".pgtable","a",@nobits
 	.balign 4096
-pgtable:
-	.fill BOOT_PGT_SIZE, 1, 0
+SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index eaa843a52907..fabed28d2edd 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -113,11 +113,9 @@ ENTRY(set_sev_encryption_mask)
 ENDPROC(set_sev_encryption_mask)
 
 	.data
-enc_bit:
-	.int	0xffffffff
+SYM_DATA_LOCAL(enc_bit, .int 0xffffffff)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
-GLOBAL(sme_me_mask)
-	.quad	0
+SYM_DATA(sme_me_mask, .quad 0)
 #endif
-- 
2.16.3
