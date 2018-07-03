Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E105423EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E105423EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeGCIf6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:35:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeGCIfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:35:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w638Z7om214130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 01:35:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w638Z7NN214126;
        Tue, 3 Jul 2018 01:35:07 -0700
Date:   Tue, 3 Jul 2018 01:35:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-a7bea8308933aaeea76dad7d42a6e51000417626@git.kernel.org>
Cc:     dvlasenk@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
        luto@kernel.org, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, bp@alien8.de, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        jbeulich@suse.com, JBeulich@suse.com, mingo@kernel.org,
        akataria@vmware.com
Reply-To: tglx@linutronix.de, bp@alien8.de, jpoimboe@redhat.com,
          brgerst@gmail.com, jgross@suse.com, luto@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          dvlasenk@redhat.com, mingo@kernel.org, akataria@vmware.com,
          jbeulich@suse.com, JBeulich@suse.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
References: <5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm/64: Use 32-bit XOR to zero registers
Git-Commit-ID: a7bea8308933aaeea76dad7d42a6e51000417626
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a7bea8308933aaeea76dad7d42a6e51000417626
Gitweb:     https://git.kernel.org/tip/a7bea8308933aaeea76dad7d42a6e51000417626
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 2 Jul 2018 04:31:54 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:59:29 +0200

x86/asm/64: Use 32-bit XOR to zero registers

Some Intel CPUs don't recognize 64-bit XORs as zeroing idioms. Zeroing
idioms don't require execution bandwidth, as they're being taken care
of in the frontend (through register renaming). Use 32-bit XORs instead.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: davem@davemloft.net
Cc: herbert@gondor.apana.org.au
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
Link: http://lkml.kernel.org/r/5B39FF1A02000078001CFB54@prv1-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/crypto/aegis128-aesni-asm.S     | 2 +-
 arch/x86/crypto/aegis128l-aesni-asm.S    | 2 +-
 arch/x86/crypto/aegis256-aesni-asm.S     | 2 +-
 arch/x86/crypto/aesni-intel_asm.S        | 8 ++++----
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 4 ++--
 arch/x86/crypto/morus1280-avx2-asm.S     | 2 +-
 arch/x86/crypto/morus1280-sse2-asm.S     | 2 +-
 arch/x86/crypto/morus640-sse2-asm.S      | 2 +-
 arch/x86/crypto/sha1_ssse3_asm.S         | 2 +-
 arch/x86/kernel/head_64.S                | 2 +-
 arch/x86/kernel/paravirt_patch_64.c      | 2 +-
 arch/x86/lib/memcpy_64.S                 | 2 +-
 arch/x86/power/hibernate_asm_64.S        | 2 +-
 13 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
index 9254e0b6cc06..d5c5e2082ae7 100644
--- a/arch/x86/crypto/aegis128-aesni-asm.S
+++ b/arch/x86/crypto/aegis128-aesni-asm.S
@@ -75,7 +75,7 @@
  *   %r9
  */
 __load_partial:
-	xor %r9, %r9
+	xor %r9d, %r9d
 	pxor MSG, MSG
 
 	mov LEN, %r8
diff --git a/arch/x86/crypto/aegis128l-aesni-asm.S b/arch/x86/crypto/aegis128l-aesni-asm.S
index 9263c344f2c7..0fbdf5f00bda 100644
--- a/arch/x86/crypto/aegis128l-aesni-asm.S
+++ b/arch/x86/crypto/aegis128l-aesni-asm.S
@@ -66,7 +66,7 @@
  *   %r9
  */
 __load_partial:
-	xor %r9, %r9
+	xor %r9d, %r9d
 	pxor MSG0, MSG0
 	pxor MSG1, MSG1
 
diff --git a/arch/x86/crypto/aegis256-aesni-asm.S b/arch/x86/crypto/aegis256-aesni-asm.S
index 1d977d515bf9..a49f58e2a5dd 100644
--- a/arch/x86/crypto/aegis256-aesni-asm.S
+++ b/arch/x86/crypto/aegis256-aesni-asm.S
@@ -59,7 +59,7 @@
  *   %r9
  */
 __load_partial:
-	xor %r9, %r9
+	xor %r9d, %r9d
 	pxor MSG, MSG
 
 	mov LEN, %r8
diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e762ef417562..9bd139569b41 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -258,7 +258,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 .macro GCM_INIT Iv SUBKEY AAD AADLEN
 	mov \AADLEN, %r11
 	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
-	xor %r11, %r11
+	xor %r11d, %r11d
 	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
 	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
 	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
@@ -286,7 +286,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	movdqu HashKey(%arg2), %xmm13
 	add %arg5, InLen(%arg2)
 
-	xor %r11, %r11 # initialise the data pointer offset as zero
+	xor %r11d, %r11d # initialise the data pointer offset as zero
 	PARTIAL_BLOCK %arg3 %arg4 %arg5 %r11 %xmm8 \operation
 
 	sub %r11, %arg5		# sub partial block data used
@@ -702,7 +702,7 @@ _no_extra_mask_1_\@:
 
 	# GHASH computation for the last <16 Byte block
 	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-	xor	%rax,%rax
+	xor	%eax, %eax
 
 	mov	%rax, PBlockLen(%arg2)
 	jmp	_dec_done_\@
@@ -737,7 +737,7 @@ _no_extra_mask_2_\@:
 
 	# GHASH computation for the last <16 Byte block
 	GHASH_MUL \AAD_HASH, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xmm6
-	xor	%rax,%rax
+	xor	%eax, %eax
 
 	mov	%rax, PBlockLen(%arg2)
 	jmp	_encode_done_\@
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index faecb1518bf8..1985ea0b551b 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -463,7 +463,7 @@ _get_AAD_rest_final\@:
 
 _get_AAD_done\@:
 	# initialize the data pointer offset as zero
-	xor     %r11, %r11
+	xor     %r11d, %r11d
 
 	# start AES for num_initial_blocks blocks
 	mov     arg5, %rax                     # rax = *Y0
@@ -1770,7 +1770,7 @@ _get_AAD_rest_final\@:
 
 _get_AAD_done\@:
 	# initialize the data pointer offset as zero
-	xor     %r11, %r11
+	xor     %r11d, %r11d
 
 	# start AES for num_initial_blocks blocks
 	mov     arg5, %rax                     # rax = *Y0
diff --git a/arch/x86/crypto/morus1280-avx2-asm.S b/arch/x86/crypto/morus1280-avx2-asm.S
index 37d422e77931..c3f74913476c 100644
--- a/arch/x86/crypto/morus1280-avx2-asm.S
+++ b/arch/x86/crypto/morus1280-avx2-asm.S
@@ -113,7 +113,7 @@ ENDPROC(__morus1280_update_zero)
  *   %r9
  */
 __load_partial:
-	xor %r9, %r9
+	xor %r9d, %r9d
 	vpxor MSG, MSG, MSG
 
 	mov %rcx, %r8
diff --git a/arch/x86/crypto/morus1280-sse2-asm.S b/arch/x86/crypto/morus1280-sse2-asm.S
index 1fe637c7be9d..b3f4d103ba06 100644
--- a/arch/x86/crypto/morus1280-sse2-asm.S
+++ b/arch/x86/crypto/morus1280-sse2-asm.S
@@ -235,7 +235,7 @@ ENDPROC(__morus1280_update_zero)
  *   %r9
  */
 __load_partial:
-	xor %r9, %r9
+	xor %r9d, %r9d
 	pxor MSG_LO, MSG_LO
 	pxor MSG_HI, MSG_HI
 
diff --git a/arch/x86/crypto/morus640-sse2-asm.S b/arch/x86/crypto/morus640-sse2-asm.S
index 71c72a0a0862..d2958a47fccc 100644
--- a/arch/x86/crypto/morus640-sse2-asm.S
+++ b/arch/x86/crypto/morus640-sse2-asm.S
@@ -113,7 +113,7 @@ ENDPROC(__morus640_update_zero)
  *   %r9
  */
 __load_partial:
-	xor %r9, %r9
+	xor %r9d, %r9d
 	pxor MSG, MSG
 
 	mov %rcx, %r8
diff --git a/arch/x86/crypto/sha1_ssse3_asm.S b/arch/x86/crypto/sha1_ssse3_asm.S
index 6204bd53528c..613d0bfc3d84 100644
--- a/arch/x86/crypto/sha1_ssse3_asm.S
+++ b/arch/x86/crypto/sha1_ssse3_asm.S
@@ -96,7 +96,7 @@
 	# cleanup workspace
 	mov	$8, %ecx
 	mov	%rsp, %rdi
-	xor	%rax, %rax
+	xor	%eax, %eax
 	rep stosq
 
 	mov	%rbp, %rsp		# deallocate workspace
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 8344dd2f310a..15ebc2fc166e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -235,7 +235,7 @@ ENTRY(secondary_startup_64)
 	 *		address given in m16:64.
 	 */
 	pushq	$.Lafter_lret	# put return address on stack for unwinder
-	xorq	%rbp, %rbp	# clear frame pointer
+	xorl	%ebp, %ebp	# clear frame pointer
 	movq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
 	pushq	%rax		# target address in negative space
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 9edadabf04f6..9cb98f7b07c9 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -20,7 +20,7 @@ DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %rax, %rax");
+DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 298ef1479240..3b24dc05251c 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -256,7 +256,7 @@ ENTRY(__memcpy_mcsafe)
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
-	xorq %rax, %rax
+	xorl %eax, %eax
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index ce8da3a0412c..fd369a6e9ff8 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -137,7 +137,7 @@ ENTRY(restore_registers)
 	/* Saved in save_processor_state. */
 	lgdt	saved_context_gdt_desc(%rax)
 
-	xorq	%rax, %rax
+	xorl	%eax, %eax
 
 	/* tell the hibernation core that we've just restored the memory */
 	movq	%rax, in_suspend(%rip)
