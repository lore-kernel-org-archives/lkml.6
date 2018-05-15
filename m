Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeEOCx4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:53:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:48183 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOCxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:53:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w4F2qVSu002191
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
Subject: [PATCH 2/3] x86/build: vdso: remove unnecessary export in Makefile
Date: Tue, 15 May 2018 11:52:23 +0900
Message-Id: <1526352744-28229-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526352744-28229-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPPFLAGS_vdso.lds is assigned and referenced internally in each
Makefile.  No need to export it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/entry/vdso/Makefile | 2 +-
 arch/x86/um/vdso/Makefile    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 2988506..690df4c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -44,7 +44,7 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
 			-Wl,--no-undefined \
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 426681e..3af55cd 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -23,7 +23,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
 
-export CPPFLAGS_vdso.lds += -P -C
+CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
        -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
-- 
2.7.4
