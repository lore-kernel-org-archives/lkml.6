Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756195AbeCWKgk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 06:36:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45121 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbeCWKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 06:36:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180323103620euoutp01f96014e1ef3dc1e3ec28b7038410269e~ehkrzkWS-1597315973euoutp018
X-AuditID: cbfec7f2-1c1ff70000011644-8a-5ab4d8a28709
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        Karol Lewandowski <k.lewandowsk@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] ARM: decompressor: add a missing parameter to the addruart
 macro
Date: Fri, 23 Mar 2018 11:36:16 +0100
Message-id: <20180323103616.24426-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djPc7qLbmyJMnhy2cxi44z1rBaNn+Yy
        W9w8tILRYtPja6wWl3fNYbM4NHUvo8XaI3fZHdg9Ll+7yOyxeUm9R9+WVYwenzfJBbBEcdmk
        pOZklqUW6dslcGU8PTOduWAtf8WxDT8ZGxhvcHcxcnJICJhI9GxoYu1i5OIQEljBKPH18mVG
        COczo8S7pi52mKr7v1azQySWMUr8ezOFFSTBKyAo8WPyPZYuRg4OZgF5iSOXskHCzAKaElt3
        r4eq/8IoMWXuNBaQBJuAo0T/0hNgvSICARKnj/0AW80MUrTj/Ts2kISwQLDEhMWnwRpYBFQl
        etsfMkEss5Z4vPUiE8RF8hK72i6CDeIX0JJY03SdBWSQhMAKNokfOzdAFblI/Nv8gA3CFpZ4
        dXwL1DsyEp0dB6FqyiXezdkPFW9glPj8Sw/Ctpb4s2oiG8Q7fBKTtk1nBvlSQoBXoqNNCKLE
        Q2L5rClQrY4SX78dAisXEoiV6LtzhH0Co+wspDCahQijWUhhtICReRWjeGppcW56arFhXmq5
        XnFibnFpXrpecn7uJkZgYjj97/inHYxfLyUdYhTgYFTi4Z1xaHOUEGtiWXFl7iFGCQ5mJRHe
        73O3RAnxpiRWVqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJMnFwSjUwWgs/
        0FGXKRDYs23O/zOTXuQnbex7xrGL6e6rlF1xKa6cb0L11UX6Zl5XnyjQsmbqacGLsucFLhwQ
        690TH5Z6Neizqn9Nk9EVBfXl8+tfPS42jnji+nqD7vz458Vn3lx/L+D644ukVIVe2l3pqe8v
        ZMnN/ruv/FCuzfw/AvejvbVWVHjXa3z9r8RSnJFoqMVcVJwIAFjLN2AIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsVy+t/xy7qLbmyJMljXxW2xccZ6VovGT3OZ
        LW4eWsFosenxNVaLy7vmsFkcmrqX0WLtkbvsDuwel69dZPbYvKTeo2/LKkaPz5vkAliiuGxS
        UnMyy1KL9O0SuDKenpnOXLCWv+LYhp+MDYw3uLsYOTkkBEwk7v9azd7FyMUhJLCEUeL5maOM
        IAleAUGJH5PvsXQxcnAwC8hLHLmUDRJmFlCXmDRvETNE/TdGiaa5h8Hq2QQcJfqXnmAFsUUE
        /CTu/jnABNHwhVHi80o/EFtYIFhiwuLTLCA2i4CqRG/7QyaIXdYSj7deZII4SF5iV9tFsDn8
        AloSa5qus0xg5JuF5KRZCCfNQnLSAkbmVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFBuu3Y
        z807GC9tDD7EKMDBqMTDO+PQ5igh1sSy4srcQ4wSHMxKIrzf526JEuJNSaysSi3Kjy8qzUkt
        PsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cA4R1smd+LW/I/nvgUcNl8ddzdS54Wg
        1dPs+xyaL0oZDM24/dyOBZ7MnJvy87jd9K/PXDYslbEWdj2yRiB2l9WOHYv6rOawlbVsepF+
        T2lG1XvLpDb7hCe7F76VCHTcY/VLKGc6f2kXx7NI3m31n0X23t3/aKHnjZCJPjW/3C1EahJe
        Ps08KTpNiaU4I9FQi7moOBEAwL9ENU4CAAA=
X-CMS-MailID: 20180323103618eucas1p22b042fbfef32fb36d9723993ec749d1b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180323103618eucas1p22b042fbfef32fb36d9723993ec749d1b
X-RootMTR: 20180323103618eucas1p22b042fbfef32fb36d9723993ec749d1b
References: <CGME20180323103618eucas1p22b042fbfef32fb36d9723993ec749d1b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 639da5ee374b an additional temporary register was added
to the addruart macro, but the decompressor code wasn't updated.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/head.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 45c8823c3750..182bf6add0b9 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -29,19 +29,19 @@
 #if defined(CONFIG_DEBUG_ICEDCC)
 
 #if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c0, c5, 0
 		.endm
 #elif defined(CONFIG_CPU_XSCALE)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c8, c0, 0
 		.endm
 #else
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		.endm
 		.macro	writeb, ch, rb
 		mcr	p14, 0, \ch, c1, c0, 0
@@ -57,7 +57,7 @@
 		.endm
 
 #if defined(CONFIG_ARCH_SA1100)
-		.macro	loadsp, rb, tmp
+		.macro	loadsp, rb, tmp1, tmp2
 		mov	\rb, #0x80000000	@ physical base address
 #ifdef CONFIG_DEBUG_LL_SER3
 		add	\rb, \rb, #0x00050000	@ Ser3
@@ -66,8 +66,8 @@
 #endif
 		.endm
 #else
-		.macro	loadsp,	rb, tmp
-		addruart \rb, \tmp
+		.macro	loadsp,	rb, tmp1, tmp2
+		addruart \rb, \tmp1, \tmp2
 		.endm
 #endif
 #endif
@@ -1297,7 +1297,7 @@ phex:		adr	r3, phexbuf
 		b	1b
 
 @ puts corrupts {r0, r1, r2, r3}
-puts:		loadsp	r3, r1
+puts:		loadsp	r3, r2, r1
 1:		ldrb	r2, [r0], #1
 		teq	r2, #0
 		moveq	pc, lr
@@ -1314,8 +1314,8 @@ puts:		loadsp	r3, r1
 @ putc corrupts {r0, r1, r2, r3}
 putc:
 		mov	r2, r0
+		loadsp	r3, r1, r0
 		mov	r0, #0
-		loadsp	r3, r1
 		b	2b
 
 @ memdump corrupts {r0, r1, r2, r3, r10, r11, r12, lr}
-- 
2.11.0
