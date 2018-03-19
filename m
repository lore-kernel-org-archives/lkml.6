Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030649AbeCSVNI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:13:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43776 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030487AbeCSVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:13:01 -0400
From: Stefan Agner <stefan@agner.ch>
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc: arnd@arndb.de, mka@chromium.org, geert@linux-m68k.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] kbuild: set no-integrated-as before incl. arch Makefile
Date: Mon, 19 Mar 2018 22:12:53 +0100
Message-Id: <20180319211253.3172-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure compiler flag detection for ARM works
correctly the no-integrated-as flags need to be set before
including the arch specific Makefile.

Fixes: cfe17c9bbe6a ("kbuild: move cc-option and cc-disable-warning after incl. arch Makefile")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 56f76a5cd006..0474803c65f7 100644
--- a/Makefile
+++ b/Makefile
@@ -487,6 +487,8 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
+KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
@@ -744,8 +746,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 else
 
 # These warnings generated too much noise in a regular build.
-- 
2.16.2
