Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEAF20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="of4I/hlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfAQWXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:23:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34066 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfAQWXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:23:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so2107857wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H8x8D9dg2M1V/4/JGFZB4+kEz2rrDwKTA8AE5JJnXHw=;
        b=of4I/hlcUg3r73DxO4CXSFKzmthzyaW0j4h2PaVFJhcbk0zRdvKZeeoOIcmNWxFVtk
         uAqz4clcsIGicsDAhhvT9dOq0MK+kLzZO6HdBF54IvyiUq1Dk0JorNND13QKGdxPwBNG
         mKNlqFjKptyAlOi/6+Vad9alG8W7H30IrCdN/0cOxpkZIGseFlF+7idn6N93M1iGh8ZO
         Qv6x7GyXqUeJEgjuEzvOgsyYe4khTyvPx3SlDpUmiN276xpy/c8EedCcVgnqHUNZmZHH
         fSrCFYPtip5m6cYtIZZNQevoSLs24E6DWw8rfarowIi+E8vprMPfd4XTk0cOkqxfIH2l
         nx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H8x8D9dg2M1V/4/JGFZB4+kEz2rrDwKTA8AE5JJnXHw=;
        b=m1NmIb/fbGlSQ1A3Nz4dMFT6elkJjXQH9uA3uLd1hS95biwmqg4gkxBs27mo+NzIBW
         POM5t8W3zNpC9V4u6ogCTJ2V12Vpe9YCJX302XZZs1WE1I/WdYZgGeF/Pdx0BLqklFHj
         MTMQj+BiEjO1oewU/w1cSLvzgWqmK8zkMaQkZc1oQyRmkpraqK+Gsb0Y4gTRq9Wrw+l1
         e4Xl5pRHlRhll0t69+RDepUIGs0fvqJ8snzvlY147NK5egK5x4MdPICrgQqMFggfe8wH
         +3YYHv8VHlH8jYc2FZ+1jqQrZ4KQ/gMl/sBP/85yx7jhecwcK8bwqGrMvEMyJD7/fGQB
         MuRA==
X-Gm-Message-State: AJcUukeVoDaTeAVLcPgpmaO40hiI2E3tyMmadK8sDrPES5/L3fzfXli4
        MwnZXaqVC6O/blTEyfHt1g==
X-Google-Smtp-Source: ALg8bN5hHweF3pU0mzJC9yybdlHQN+uKDVAE/aOeuqf+rBenS08oEhzYpa0h58Y4emETh7wA6FNO1Q==
X-Received: by 2002:a1c:a8d2:: with SMTP id r201mr12972001wme.81.1547763801360;
        Thu, 17 Jan 2019 14:23:21 -0800 (PST)
Received: from avx2 ([46.53.244.66])
        by smtp.gmail.com with ESMTPSA id p139sm78200455wmd.31.2019.01.17.14.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 14:23:20 -0800 (PST)
Date:   Fri, 18 Jan 2019 01:23:18 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: [PATCH v-1] x86_64: new and improved memset() + question
Message-ID: <20190117222318.GA10338@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current memset() implementation does silly things:
* multiplication to get wide constant:
	waste of cycles if filler is known at compile time,

* REP STOSQ followed by REP STOSB:
	this code is used when REP STOSB is slow but still it is used
	for small length (< 8) when setup overhead is relatively big,

* suboptimal calling convention:
	REP STOSB/STOSQ favours (rdi, rcx)

* memset_orig():
	it is hard to even look at it :^)

New implementation is based on the following observations:
* c == 0 is the most common form,
	filler can be done with "xor eax, eax" and pushed into memset()
	saving 2 bytes per call and multiplication

* len divisible by 8 is the most common form:
	all it takes is one pointer or unsigned long inside structure,
	dispatch at compile time to code without those ugly "lets fill
	at most 7 bytes" tails,

* multiplication to get wider filler value can be done at compile time
  for "c != 0" with 1 insn/10 bytes at most saving multiplication.

* those leaner forms of memset can be done withing 3/4 registers (RDI,
  RCX, RAX, [RSI]) saving the rest from clobbering.

Note: "memset0" name is chosen because "bzero" is officially deprecated.
Note: memset(,0,) form is interleaved into memset(,c,) form to save
space.

QUESTION: is it possible to tell gcc "this function is semantically
equivalent to memset(3) so make high level optimizations but call it
when it is necessary"? I suspect the answer is "no" :-\

TODO:
	CONFIG_FORTIFY_SOURCE is enabled by distros
	benchmarks
	testing
	more comments
	check with memset_io() so that no surprises pop up

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	lightly boot tested by you get the idea where it is going...

 arch/x86/boot/compressed/Makefile |    1 
 arch/x86/include/asm/string_64.h  |  101 ++++++++++++++++++++++++++++++++++++++
 arch/x86/lib/Makefile             |    1 
 arch/x86/lib/memset0_64.S         |   86 ++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+)

--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
+KBUILD_CFLAGS += -D_ARCH_X86_BOOT
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -30,7 +30,108 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMSET
+#if defined(_ARCH_X86_BOOT) || defined(CONFIG_FORTIFY_SOURCE)
 void *memset(void *s, int c, size_t n);
+#else
+#include <asm/alternative.h>
+#include <asm/cpufeatures.h>
+
+/* Internal, do not use. */
+static __always_inline void memset0(void *s, size_t n)
+{
+	/* Internal, do not use. */
+	void _memset0_mov(void);
+	void _memset0_rep_stosq(void);
+	void memset0_mov(void);
+	void memset0_rep_stosq(void);
+	void memset0_rep_stosb(void);
+
+	if (__builtin_constant_p(n) && n == 0) {
+	} else if (__builtin_constant_p(n) && n == 1) {
+		*(uint8_t *)s = 0;
+	} else if (__builtin_constant_p(n) && n == 2) {
+		*(uint16_t *)s = 0;
+	} else if (__builtin_constant_p(n) && n == 4) {
+		*(uint32_t *)s = 0;
+	} else if (__builtin_constant_p(n) && n == 8) {
+		*(uint64_t *)s = 0;
+	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
+		alternative_call_2(
+			_memset0_mov,
+			_memset0_rep_stosq, X86_FEATURE_REP_GOOD,
+			memset0_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"0" (s), "1" (n)
+			: "rax", "cc", "memory"
+		);
+	} else {
+		alternative_call_2(
+			memset0_mov,
+			memset0_rep_stosq, X86_FEATURE_REP_GOOD,
+			memset0_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"0" (s), "1" (n)
+			: "rax", "rsi", "cc", "memory"
+		);
+	}
+}
+
+/* Internal, do not use. */
+static __always_inline void memsetx(void *s, int c, size_t n)
+{
+	/* Internal, do not use. */
+	void _memsetx_mov(void);
+	void _memsetx_rep_stosq(void);
+	void memsetx_mov(void);
+	void memsetx_rep_stosq(void);
+	void memsetx_rep_stosb(void);
+
+	const uint64_t ccc = (uint8_t)c * 0x0101010101010101ULL;
+
+	if (__builtin_constant_p(n) && n == 0) {
+	} else if (__builtin_constant_p(n) && n == 1) {
+		*(uint8_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && n == 2) {
+		*(uint16_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && n == 4) {
+		*(uint32_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && n == 8) {
+		*(uint64_t *)s = ccc;
+	} else if (__builtin_constant_p(n) && (n & 7) == 0) {
+		alternative_call_2(
+			_memsetx_mov,
+			_memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
+			memsetx_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"0" (s), "1" (n), "a" (ccc)
+			: "cc", "memory"
+		);
+	} else {
+		alternative_call_2(
+			memsetx_mov,
+			memsetx_rep_stosq, X86_FEATURE_REP_GOOD,
+			memsetx_rep_stosb, X86_FEATURE_ERMS,
+			ASM_OUTPUT2("=D" (s), "=c" (n)),
+			"0" (s), "1" (n), "a" (ccc)
+			: "rsi", "cc", "memory"
+		);
+	}
+}
+
+static __always_inline void *memset(void *s, int c, size_t n)
+{
+	if (__builtin_constant_p(c)) {
+		if (c == 0) {
+			memset0(s, n);
+		} else {
+			memsetx(s, c, n);
+		}
+		return s;
+	} else {
+		return __builtin_memset(s, c, n);
+	}
+}
+#endif
 void *__memset(void *s, int c, size_t n);
 
 #define __HAVE_ARCH_MEMSET16
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -47,6 +47,7 @@ else
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
         lib-y += clear_page_64.o copy_page_64.o
         lib-y += memmove_64.o memset_64.o
+	lib-y += memset0_64.o
         lib-y += copy_user_64.o
 	lib-y += cmpxchg16b_emu.o
 endif
new file mode 100644
--- /dev/null
+++ b/arch/x86/lib/memset0_64.S
@@ -0,0 +1,86 @@
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+.intel_syntax noprefix
+
+ENTRY(memset0_rep_stosb)
+	xor	eax, eax
+.globl memsetx_rep_stosb
+memsetx_rep_stosb:
+	rep stosb
+	ret
+ENDPROC(memset0_rep_stosb)
+ENDPROC(memsetx_rep_stosb)
+EXPORT_SYMBOL(memset0_rep_stosb)
+EXPORT_SYMBOL(memsetx_rep_stosb)
+
+ENTRY(_memset0_rep_stosq)
+	xor	eax, eax
+.globl _memsetx_rep_stosq
+_memsetx_rep_stosq:
+	shr	rcx, 3
+	rep stosq
+	ret
+ENDPROC(_memset0_rep_stosq)
+ENDPROC(_memsetx_rep_stosq)
+EXPORT_SYMBOL(_memset0_rep_stosq)
+EXPORT_SYMBOL(_memsetx_rep_stosq)
+
+ENTRY(memset0_rep_stosq)
+	xor	eax, eax
+.globl memsetx_rep_stosq
+memsetx_rep_stosq:
+	lea	rsi, [rdi + rcx]
+	shr	rcx, 3
+	rep stosq
+	cmp	rdi, rsi
+	je	1f
+2:
+	mov	[rdi], al
+	add	rdi, 1
+	cmp	rdi, rsi
+	jne	2b
+1:
+	ret
+ENDPROC(memset0_rep_stosq)
+ENDPROC(memsetx_rep_stosq)
+EXPORT_SYMBOL(memset0_rep_stosq)
+EXPORT_SYMBOL(memsetx_rep_stosq)
+
+ENTRY(_memset0_mov)
+	xor	eax, eax
+.globl _memsetx_mov
+_memsetx_mov:
+	add	rcx, rdi
+	cmp	rdi, rcx
+	je	1f
+2:
+	mov	[rdi], rax
+	add	rdi, 8
+	cmp	rdi, rcx
+	jne	2b
+1:
+	ret
+ENDPROC(_memset0_mov)
+ENDPROC(_memsetx_mov)
+EXPORT_SYMBOL(_memset0_mov)
+EXPORT_SYMBOL(_memsetx_mov)
+
+ENTRY(memset0_mov)
+	xor	eax, eax
+.globl memsetx_mov
+memsetx_mov:
+	lea	rsi, [rdi + rcx]
+	cmp	rdi, rsi
+	je	1f
+2:
+	mov	[rdi], al
+	add	rdi, 1
+	cmp	rdi, rsi
+	jne	2b
+1:
+	ret
+ENDPROC(memset0_mov)
+ENDPROC(memsetx_mov)
+EXPORT_SYMBOL(memset0_mov)
+EXPORT_SYMBOL(memsetx_mov)
