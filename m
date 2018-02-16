Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x2240gyXV2GVOkq2o5kKvSbhCKKZ8xOzPMPkeixaTww3g8teKyBkEf3+rfDSudb0ZKunm6IPK
ARC-Seal: i=1; a=rsa-sha256; t=1518794997; cv=none;
        d=google.com; s=arc-20160816;
        b=YMsLSmcZ8pk8i/9zoDvANEIPnqkGcJgibSjItIKb3UnBqH4SWhY+SHWYVOUiuZyIcP
         nNEJ3AI/l3zjv3YvbEO4/LfOD2LJ0HIfPquMaH822iXaPmfqLU7UbeivrHAzrBdgOJid
         fFz57rrJid7fc/XPwps5YDR9T1QGzwtolCxV0pPyh2qilNm8ouV316PGULSE/en4/nMm
         B4Av/YNe0qgrhDCRfR+khRUMbguX0sRG2fLBy/hN9hTuMM+QypwujacSV2SI7sWPnOie
         35YrVkmqKoDuU52A7x2UwDNLBgJuSsFMTBUkAPHqiICCCDJkFxAq9QzSkwsb0cGLThAP
         Eo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=fG46ZNVLTgu7XmWopUFaxxygs0qO24oNykNurXwDdYY=;
        b=CzETWDSYUWxG4Chy1yvtw/rlrZ4r0l408LVPQg+w1i8SfDZocU1zSky9rP+S7Hgsv1
         mzO9dwpelg/7WJClXWGTHEo2bA1uf0rcX4YVBBIawXkJeCu87Qe5JCRT6VzcFVi/B2ne
         Foj6H8LzqJNA515R2S4YpGJpXjzTwEfbzg4gyqf3VisGOYSWkl/oHUNsSYoVEBbDP2nb
         J7VypFRHSpT7ersUtCLcAFYiZExxII/jdybwnONoArGAVpaXKIuFOv/r0WuUOLg4OrHS
         LoaH1/yyNtNFDFS4Edi+vkijuqSFrgpwTIM0Ur3GAT4W0jwS5T32yJBKnvRdrnsaWO+X
         t4Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [stable 4.14 patch] x86: fix KMEMCHECK warning about FRAME_POINTER
Date: Fri, 16 Feb 2018 16:29:10 +0100
Message-Id: <20180216152949.1630609-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:1vfeA7f9UEU8w7UR1pad+xMCyvjoFKyuLmb5ehOCEro28QEm1vV
 WNA2HIlsPTTNosDrL31VXwhzCbtBLqqdXNAdgyDK4c3JOlIfshK26RaW/wdvftlcnewpvsB
 Higk1tj0akCNa0ZLMSYEjfrSTVJ59glHTk7YiGWtyqwRXUVro1BTN4JcqVzKTvv8/y5BKPa
 iwznWvyJMbtWPIx5U9iqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PiZ/lR/ABgo=:lAvh9angW0CPQkj+Th1mvu
 X5+X69Cl4YObsa4Ecu2rNZBW0i5zgk4GJtaLBCwPW1C6g3n26/f/YYAdXePr4+OWZvivljB9+
 L5VQ8T6uhnm9yt+goZgOKKZJysKOKaj90eY2fibHERNGJ422mzDnQCszp2LIrh/EZfFXKOKeZ
 Mp49db5Wbf+CRLOEwCnKRQBshuCxFHptgNAb4hskWh+D2dkBuZCdxiKHO+Ei6LkUdX+vEalxo
 2UuyvpS7hZpJpDa615Lq6vsFrQxld6BsSPwZnqHWzFw3ngtJosIRSQPuK3YMxI70aOsK+7Vo1
 ELv2/iAU+IoSHtM6DkoIPistEHnAsKtgio7ac4aZRwJ9Ydkj2mbQKhXgKf1XYMrSwc1oTG17J
 svdVZg8zNvCTDPrx0XacYdmtz+7f03e6ObDNc6QPAuBQzTqf0kpmu0EU7tPVxJj1+f2FBPGIL
 H9NWzx3fxVGZP3cGNezcNFE4Z37/o0N3RlAkaOnMqdRUjCRX0H4bjFs2GaRMtoh1W6LlVDBKm
 nPU5c4rqinGYV8JyyS10QCAST+AKEDq8qpKFSRmgRFrwLbmV9N1eQg1T+nBNODw6UF4g6MgpU
 nVeMfRclK909oiy8j0ZHuCG8ZxNp28SiLchAyb+taXmZovEt2IjhHWNmzllGaBRF5iRHWw32G
 OXGhC1CMiEOAGivWm5vYuHSbTk6hPZYxMjW498iJXs4AHGtQx4igvss9rhLRvMerm2OLVHKt2
 bmr6glwUZbwLrtfF3Jyb/txj5WEv7W7+g08Tiw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592571982638496646?=
X-GMAIL-MSGID: =?utf-8?q?1592571982638496646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When KMEMCHECK is enabled without UNWINDER_FRAME_POINTER, we get a
Kconfig warning, presumably harmless:

warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && KMEMCHECK && LOCKDEP && UNWINDER_FRAME_POINTER) selects FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CRIS || M68K || FRV || UML || SUPERH || BLACKFIN || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS || !UNWINDER_ORC && !UNWINDER_GUESS)

In newer mainline kernels, the KMEMCHECK option has been removed, so
this no longer happens. Adding the unwinder as a direct dependency
for KMEMCHECK works for 4.14-stable as well and documents the
dependency better.

Fixes: 81d387190039 ("x86/kconfig: Consolidate unwinders into multiple choice selection")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 17de6acc0eab..3fc58c1a166b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -111,7 +111,7 @@ config X86
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KGDB
-	select HAVE_ARCH_KMEMCHECK
+	select HAVE_ARCH_KMEMCHECK		if !UNWINDER_ORC && !UNWINDER_GUESS
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
-- 
2.9.0
