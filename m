Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325084-2-7376946650401192295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325083; b=qaTb45INhyJ/RQaQEE1BWEGrCQP11fWSXmFXYeXAGMylE5X
    AN0h+J247VxlU8qq/3aOyclPFU7nnD8DJmeFx/xwgcJMQVDcB15bBUowV3nBt/EC
    TQb6CGp4uVt7cHTzcoz2CZavXKo35mANuai2xo6C9SPNsF07M4bgsvtadG6xVlWH
    Yvqf7/6wGlPN4gXDpRIU6Jl799u+W4V3GncS/4hE8Wd9cR+DKDOuEdzmAi3EuN5K
    CZOxvYZauA9Li2/xU2Uww8wpLPKRiDdB3Zti5EG/3wnLoClPT5PO3QTroDR/PeLm
    3QlhLC3e7K6khBlSy3rUADf8tHl0EMPiZq+L1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325083; bh=z9qQLk7jOs9Riu1rl7t
    VoycTvrJjRewTXKWPt0qVocs=; b=O9jshIDxO54uT2oO9yxgTV1fLcneKUfPefY
    H8v6lG9zVLVMzxsR9O5AC7RV5UQiW2aqf2s/9IVNLp3471Jk2gZPlvdqDlWTgidr
    kp2+B5MEna3KHGWvdDKL5pWHCR5DB4HVofdhGuHy/TbSrBIF4YpeMRExN3yjhZ0L
    tq9he0ohvdsG0hyUHs0H9CzbsWT7zDezTOHL5qxKzaqEObDYx/gNgkr0VvDDsWaj
    AS6vz6otrt5gx36CA6hMWb0k3PnZbNln+EPK5hnAKBCVNCPwsFcz71XAo3svxVMM
    jplc+/UKU2b+V68sSfHCSH4XZoC1k+A9AZNNmPtEDcinYf1So0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753295AbeBKEz4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:55:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41717 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752798AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.57179372@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 128/136] x86, vdso: Move the vvar area before the
 vdso text
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@amacapital.net>

commit e6577a7ce99a506b587bcd1d2cd803cb45119557 upstream.

Putting the vvar area after the vdso text is rather complicated: it
only works of the total length of the vdso text mapping is known at
vdso link time, and the linker doesn't allow symbol addresses to
depend on the sizes of non-allocatable data after the PT_LOAD
segment.

Moving the vvar area before the vdso text will allow is to safely
map non-allocatable data after the vdso text, which is a nice
simplification.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
Link: http://lkml.kernel.org/r/156c78c0d93144ff1055a66493783b9e56813983.1405040914.git.luto@amacapital.net
Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/vdso.h     | 18 ++++++++---------
 arch/x86/vdso/vdso-layout.lds.S | 44 ++++++++++++++++++-----------------------
 arch/x86/vdso/vdso2c.c          | 12 ++++++-----
 arch/x86/vdso/vdso2c.h          | 25 ++++++++++++++---------
 arch/x86/vdso/vma.c             | 20 ++++++++++---------
 5 files changed, 62 insertions(+), 57 deletions(-)

--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -18,15 +18,15 @@ struct vdso_image {
 
 	unsigned long alt, alt_len;
 
-	unsigned long sym_end_mapping;  /* Total size of the mapping */
+	long sym_vvar_start;  /* Negative offset to the vvar area */
 
-	unsigned long sym_vvar_page;
-	unsigned long sym_hpet_page;
-	unsigned long sym_VDSO32_NOTE_MASK;
-	unsigned long sym___kernel_sigreturn;
-	unsigned long sym___kernel_rt_sigreturn;
-	unsigned long sym___kernel_vsyscall;
-	unsigned long sym_VDSO32_SYSENTER_RETURN;
+	long sym_vvar_page;
+	long sym_hpet_page;
+	long sym_VDSO32_NOTE_MASK;
+	long sym___kernel_sigreturn;
+	long sym___kernel_rt_sigreturn;
+	long sym___kernel_vsyscall;
+	long sym_VDSO32_SYSENTER_RETURN;
 };
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/vdso/vdso-layout.lds.S
+++ b/arch/x86/vdso/vdso-layout.lds.S
@@ -18,6 +18,25 @@
 
 SECTIONS
 {
+	/*
+	 * User/kernel shared data is before the vDSO.  This may be a little
+	 * uglier than putting it after the vDSO, but it avoids issues with
+	 * non-allocatable things that dangle past the end of the PT_LOAD
+	 * segment.
+	 */
+
+	vvar_start = . - 2 * PAGE_SIZE;
+	vvar_page = vvar_start;
+
+	/* Place all vvars at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
+#define __VVAR_KERNEL_LDS
+#include <asm/vvar.h>
+#undef __VVAR_KERNEL_LDS
+#undef EMIT_VVAR
+
+	hpet_page = vvar_start + PAGE_SIZE;
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
@@ -74,31 +93,6 @@ SECTIONS
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
 
-	/*
-	 * The remainder of the vDSO consists of special pages that are
-	 * shared between the kernel and userspace.  It needs to be at the
-	 * end so that it doesn't overlap the mapping of the actual
-	 * vDSO image.
-	 */
-
-	. = ALIGN(PAGE_SIZE);
-	vvar_page = .;
-
-	/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
-#define __VVAR_KERNEL_LDS
-#include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
-#undef EMIT_VVAR
-
-	. = vvar_page + PAGE_SIZE;
-
-	hpet_page = .;
-	. = . + PAGE_SIZE;
-
-	. = ALIGN(PAGE_SIZE);
-	end_mapping = .;
-
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
--- a/arch/x86/vdso/vdso2c.c
+++ b/arch/x86/vdso/vdso2c.c
@@ -20,9 +20,9 @@ const char *outfilename;
 
 /* Symbols that we need in vdso2c. */
 enum {
+	sym_vvar_start,
 	sym_vvar_page,
 	sym_hpet_page,
-	sym_end_mapping,
 	sym_VDSO_FAKE_SECTION_TABLE_START,
 	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
@@ -38,9 +38,9 @@ struct vdso_sym {
 };
 
 struct vdso_sym required_syms[] = {
+	[sym_vvar_start] = {"vvar_start", true},
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_hpet_page] = {"hpet_page", true},
-	[sym_end_mapping] = {"end_mapping", true},
 	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
 		"VDSO_FAKE_SECTION_TABLE_START", false
 	},
@@ -96,9 +96,11 @@ extern void bad_put_le(void);
 
 #define NSYMS (sizeof(required_syms) / sizeof(required_syms[0]))
 
-#define BITSFUNC3(name, bits) name##bits
-#define BITSFUNC2(name, bits) BITSFUNC3(name, bits)
-#define BITSFUNC(name) BITSFUNC2(name, ELF_BITS)
+#define BITSFUNC3(name, bits, suffix) name##bits##suffix
+#define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
+#define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
+
+#define INT_BITS BITSFUNC2(int, ELF_BITS, _t)
 
 #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
 #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
--- a/arch/x86/vdso/vdso2c.h
+++ b/arch/x86/vdso/vdso2c.h
@@ -132,7 +132,7 @@ static void BITSFUNC(go)(void *addr, siz
 		*alt_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
 	const char *secstrings;
-	uint64_t syms[NSYMS] = {};
+	INT_BITS syms[NSYMS] = {};
 
 	struct BITSFUNC(fake_sections) fake_sections = {};
 
@@ -209,6 +209,13 @@ static void BITSFUNC(go)(void *addr, siz
 					fail("duplicate symbol %s\n",
 					     required_syms[k].name);
 				}
+
+				/*
+				 * Careful: we use negative addresses, but
+				 * st_value is unsigned, so we rely
+				 * on syms[k] being a signed type of the
+				 * correct width.
+				 */
 				syms[k] = GET_LE(&sym->st_value);
 			}
 		}
@@ -263,15 +270,15 @@ static void BITSFUNC(go)(void *addr, siz
 		if (syms[i] % 4096)
 			fail("%s must be a multiple of 4096\n",
 			     required_syms[i].name);
-		if (syms[i] < data_size)
-			fail("%s must be after the text mapping\n",
+		if (syms[sym_vvar_start] > syms[i] + 4096)
+			fail("%s underruns begin_vvar\n",
 			     required_syms[i].name);
-		if (syms[sym_end_mapping] < syms[i] + 4096)
-			fail("%s overruns end_mapping\n",
+		if (syms[i] + 4096 > 0)
+			fail("%s is on the wrong side of the vdso text\n",
 			     required_syms[i].name);
 	}
-	if (syms[sym_end_mapping] % 4096)
-		fail("end_mapping must be a multiple of 4096\n");
+	if (syms[sym_vvar_start] % 4096)
+		fail("vvar_begin must be a multiple of 4096\n");
 
 	if (!name) {
 		fwrite(addr, load_size, 1, outfile);
@@ -311,8 +318,8 @@ static void BITSFUNC(go)(void *addr, siz
 	}
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
-			fprintf(outfile, "\t.sym_%s = 0x%" PRIx64 ",\n",
-				required_syms[i].name, syms[i]);
+			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
+				required_syms[i].name, (int64_t)syms[i]);
 	}
 	fprintf(outfile, "};\n");
 }
--- a/arch/x86/vdso/vma.c
+++ b/arch/x86/vdso/vma.c
@@ -106,7 +106,7 @@ static int map_vdso(const struct vdso_im
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long addr;
+	unsigned long addr, text_start;
 	int ret = 0;
 	static struct page *no_pages[] = {NULL};
 	static struct vm_special_mapping vvar_mapping = {
@@ -116,26 +116,28 @@ static int map_vdso(const struct vdso_im
 
 	if (calculate_addr) {
 		addr = vdso_addr(current->mm->start_stack,
-				 image->sym_end_mapping);
+				 image->size - image->sym_vvar_start);
 	} else {
 		addr = 0;
 	}
 
 	down_write(&mm->mmap_sem);
 
-	addr = get_unmapped_area(NULL, addr, image->sym_end_mapping, 0, 0);
+	addr = get_unmapped_area(NULL, addr,
+				 image->size - image->sym_vvar_start, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret = addr;
 		goto up_fail;
 	}
 
-	current->mm->context.vdso = (void __user *)addr;
+	text_start = addr - image->sym_vvar_start;
+	current->mm->context.vdso = (void __user *)text_start;
 
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
 	vma = _install_special_mapping(mm,
-				       addr,
+				       text_start,
 				       image->size,
 				       VM_READ|VM_EXEC|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
@@ -147,8 +149,8 @@ static int map_vdso(const struct vdso_im
 	}
 
 	vma = _install_special_mapping(mm,
-				       addr + image->size,
-				       image->sym_end_mapping - image->size,
+				       addr,
+				       -image->sym_vvar_start,
 				       VM_READ,
 				       &vvar_mapping);
 
@@ -159,7 +161,7 @@ static int map_vdso(const struct vdso_im
 
 	if (image->sym_vvar_page)
 		ret = remap_pfn_range(vma,
-				      addr + image->sym_vvar_page,
+				      text_start + image->sym_vvar_page,
 				      __pa_symbol(&__vvar_page) >> PAGE_SHIFT,
 				      PAGE_SIZE,
 				      PAGE_READONLY);
@@ -170,7 +172,7 @@ static int map_vdso(const struct vdso_im
 #ifdef CONFIG_HPET_TIMER
 	if (hpet_address && image->sym_hpet_page) {
 		ret = io_remap_pfn_range(vma,
-			addr + image->sym_hpet_page,
+			text_start + image->sym_hpet_page,
 			hpet_address >> PAGE_SHIFT,
 			PAGE_SIZE,
 			pgprot_noncached(PAGE_READONLY));
