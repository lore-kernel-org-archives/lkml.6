Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756328AbeEIHcP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:32:15 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:17152 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756285AbeEIHcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:32:14 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w497UkBw011283
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:30:43 +0900
Message-Id: <1525851043-11570-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for ARM-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will put this patch into Russell's patch tracker.
This is for reviewing.


 arch/arm/kernel/vmlinux.lds.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 71281e0..ae5fdff 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -27,24 +27,24 @@
 
 #define PROC_INFO							\
 		. = ALIGN(4);						\
-		VMLINUX_SYMBOL(__proc_info_begin) = .;			\
+		__proc_info_begin = .;					\
 		*(.proc.info.init)					\
-		VMLINUX_SYMBOL(__proc_info_end) = .;
+		__proc_info_end = .;
 
 #define HYPERVISOR_TEXT							\
-		VMLINUX_SYMBOL(__hyp_text_start) = .;			\
+		__hyp_text_start = .;					\
 		*(.hyp.text)						\
-		VMLINUX_SYMBOL(__hyp_text_end) = .;
+		__hyp_text_end = .;
 
 #define IDMAP_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__idmap_text_start) = .;			\
+		__idmap_text_start = .;					\
 		*(.idmap.text)						\
-		VMLINUX_SYMBOL(__idmap_text_end) = .;			\
+		__idmap_text_end = .;					\
 		. = ALIGN(PAGE_SIZE);					\
-		VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;		\
+		__hyp_idmap_text_start = .;				\
 		*(.hyp.idmap.text)					\
-		VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
+		__hyp_idmap_text_end = .;
 
 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
-- 
2.7.4
