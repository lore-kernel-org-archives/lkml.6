Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD524C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B1B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B1B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbeJNXgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:36:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36068 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727728AbeJNXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:55 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLi-0004cI-V1; Sun, 14 Oct 2018 16:30:35 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000i1-Um; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Chris Metcalf" <cmetcalf@ezchip.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.14036807@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 326/366] Make asm/word-at-a-time.h available on all
 architectures
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Metcalf <cmetcalf@ezchip.com>

commit a6e2f029ae34f41adb6ae3812c32c5d326e1abd2 upstream.

Added the x86 implementation of word-at-a-time to the
generic version, which previously only supported big-endian.

Omitted the x86-specific load_unaligned_zeropad(), which in
any case is also not present for the existing BE-only
implementation of a word-at-a-time, and is only used under
CONFIG_DCACHE_WORD_ACCESS.

Added as a "generic-y" to the Kbuilds of all architectures
that didn't previously have it.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
[bwh: Backported to 3.16:
 - Drop change in arch/nios2
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -49,4 +49,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -20,4 +20,5 @@ generic-y += sections.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -46,4 +46,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += user.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -58,4 +58,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -15,4 +15,5 @@ generic-y += module.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += hash.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -58,4 +58,5 @@ generic-y += types.h
 generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
+generic-y += word-at-a-time.h
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += mcs_spinlock.h
 generic-y += module.h
 generic-y += preempt.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -54,4 +54,5 @@ generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += syscalls.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -15,4 +15,5 @@ generic-y += segment.h
 generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += hash.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += trace_clock.h
 generic-y += vtime.h
+generic-y += word-at-a-time.h
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += hash.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -10,3 +10,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += xor.h
+generic-y += word-at-a-time.h
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -40,4 +40,5 @@ generic-y += termbits.h
 generic-y += termios.h
 generic-y += trace_clock.h
 generic-y += types.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -25,4 +25,5 @@ generic-y += sections.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -62,4 +62,5 @@ generic-y += ucontext.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -29,4 +29,5 @@ generic-y += statfs.h
 generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += word-at-a-time.h
 generic-y += xor.h
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -1,15 +1,10 @@
 #ifndef _ASM_WORD_AT_A_TIME_H
 #define _ASM_WORD_AT_A_TIME_H
 
-/*
- * This says "generic", but it's actually big-endian only.
- * Little-endian can use more efficient versions of these
- * interfaces, see for example
- *	 arch/x86/include/asm/word-at-a-time.h
- * for those.
- */
-
 #include <linux/kernel.h>
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN
 
 struct word_at_a_time {
 	const unsigned long high_bits, low_bits;
@@ -53,4 +48,73 @@ static inline bool has_zero(unsigned lon
 #define zero_bytemask(mask) (~1ul << __fls(mask))
 #endif
 
+#else
+
+/*
+ * The optimal byte mask counting is probably going to be something
+ * that is architecture-specific. If you have a reliably fast
+ * bit count instruction, that might be better than the multiply
+ * and shift, for example.
+ */
+struct word_at_a_time {
+	const unsigned long one_bits, high_bits;
+};
+
+#define WORD_AT_A_TIME_CONSTANTS { REPEAT_BYTE(0x01), REPEAT_BYTE(0x80) }
+
+#ifdef CONFIG_64BIT
+
+/*
+ * Jan Achrenius on G+: microoptimized version of
+ * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
+ * that works for the bytemasks without having to
+ * mask them first.
+ */
+static inline long count_masked_bytes(unsigned long mask)
+{
+	return mask*0x0001020304050608ul >> 56;
+}
+
+#else	/* 32-bit case */
+
+/* Carl Chatfield / Jan Achrenius G+ version for 32-bit */
+static inline long count_masked_bytes(long mask)
+{
+	/* (000000 0000ff 00ffff ffffff) -> ( 1 1 2 3 ) */
+	long a = (0x0ff0001+mask) >> 23;
+	/* Fix the 1 for 00 case */
+	return a & mask;
+}
+
+#endif
+
+/* Return nonzero if it has a zero */
+static inline unsigned long has_zero(unsigned long a, unsigned long *bits, const struct word_at_a_time *c)
+{
+	unsigned long mask = ((a - c->one_bits) & ~a) & c->high_bits;
+	*bits = mask;
+	return mask;
+}
+
+static inline unsigned long prep_zero_mask(unsigned long a, unsigned long bits, const struct word_at_a_time *c)
+{
+	return bits;
+}
+
+static inline unsigned long create_zero_mask(unsigned long bits)
+{
+	bits = (bits - 1) & ~bits;
+	return bits >> 7;
+}
+
+/* The mask we created is directly usable as a bytemask */
+#define zero_bytemask(mask) (mask)
+
+static inline unsigned long find_zero(unsigned long mask)
+{
+	return count_masked_bytes(mask);
+}
+
+#endif /* __BIG_ENDIAN */
+
 #endif /* _ASM_WORD_AT_A_TIME_H */

