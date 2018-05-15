Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeEOFXw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 01:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752089AbeEOFXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 01:23:49 -0400
Date: Tue, 15 May 2018 01:23:47 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: add the flag -fno-reorder-blocks-and-partition
Message-ID: <alpine.LRH.2.02.1805150121340.30961@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 8 turns on -freorder-blocks-and-partition by default, the ORC unwinder 
can't deal with it and it results in a lot of warnings "sibling call from 
callable instruction with modified stack frame". This patch adds the 
-fno-reorder-blocks-and-partition option to KBUILD_CFLAGS.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 arch/x86/Makefile |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/arch/x86/Makefile
===================================================================
--- linux-2.6.orig/arch/x86/Makefile	2018-05-15 07:19:40.000000000 +0200
+++ linux-2.6/arch/x86/Makefile	2018-05-15 07:19:40.000000000 +0200
@@ -59,6 +59,7 @@ endif
 #
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
 KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
+KBUILD_CFLAGS += $(call cc-option,-fno-reorder-blocks-and-partition,)
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
