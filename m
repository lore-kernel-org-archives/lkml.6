Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeEOCxy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:53:54 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:48189 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbeEOCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:53:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w4F2qVSv002191
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        user-mode-linux-user@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Andy Lutomirski <luto@amacapital.net>, Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 3/3] x86/build: vdso: put generated linker scripts to $(obj)/
Date: Tue, 15 May 2018 11:52:24 +0900
Message-Id: <1526352744-28229-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's put generated files to $(obj)/ rather than $(src)/ although
this is just a matter of taste because both are the same.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/entry/vdso/Makefile | 4 ++--
 arch/x86/um/vdso/Makefile    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 690df4c..261802b 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -51,7 +51,7 @@ VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
 			$(DISABLE_LTO)
 
-$(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
@@ -119,7 +119,7 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg
 	$(call if_changed,objcopy)
 
-$(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
+$(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 3af55cd..822ccdb 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -30,7 +30,7 @@ VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 
 $(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
 
-$(obj)/vdso.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
 
 $(obj)/%.so: OBJCOPYFLAGS := -S
-- 
2.7.4
