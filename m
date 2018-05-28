Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937724AbeE1Nrg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:47:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53940 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937436AbeE1Nra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:47:30 -0400
X-Google-Smtp-Source: ADUXVKIHjdfc2VWwhFXBb03lJkgD2UmIdivZCdbzYy22G2JPu3XYAS4T0c4aam+ayAKRaZmR0vAcWQ==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] kbuild: $(CHECK) doesnt need NOSTDINC_FLAGS twice
Date: Mon, 28 May 2018 15:47:22 +0200
Message-Id: <20180528134722.11358-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, $(CHECK) receives NOSTDINC_FLAGS twice:
* first directly in the main Makefile via CHECKFLAGS,
* then indirectly in scripts/Makefile.build via c_flags.

Since once is enough, leave the occurence via c_flags and
remove the one via CHECKFLAGS.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 56ba070df..3140ab1db 100644
--- a/Makefile
+++ b/Makefile
@@ -808,7 +808,6 @@ endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC) -print-file-name=include)
-CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
-- 
2.17.0
