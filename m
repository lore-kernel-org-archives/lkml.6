Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425410AbeE1Q3R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:29:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53941 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425368AbeE1Q3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:29:10 -0400
X-Google-Smtp-Source: AB8JxZr3BEuhVzWIURq/Qx6JbOH/Rbv2wRIj1mZM4yoeSg7y4uge01f/FYWcikhN+Xg8mjEfQ4k/ew==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] nds32: define __NDS32_E[BL]__ for sparse
Date: Mon, 28 May 2018 18:29:02 +0200
Message-Id: <20180528162902.15358-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nds32 depends on the macros '__NDS32_E[BL]__' to correctly
select or define endian-specific macros, structures or pieces
of code.

These macros are predefined by the compiler but sparse knows nothing
about them and thus may pre-process files differently from what
GCC would.

Fix this by adding '-D__NDS32_E[BL]__' to CHECKFLAGS.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/nds32/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 513bb2e9b..031c67682 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -34,10 +34,12 @@ ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CFLAGS   += $(call cc-option, -EL)
 KBUILD_AFLAGS   += $(call cc-option, -EL)
 LDFLAGS         += $(call cc-option, -EL)
+CHECKFLAGS      += -D__NDS32_EL__
 else
 KBUILD_CFLAGS   += $(call cc-option, -EB)
 KBUILD_AFLAGS   += $(call cc-option, -EB)
 LDFLAGS         += $(call cc-option, -EB)
+CHECKFLAGS      += -D__NDS32_EB__
 endif
 
 boot := arch/nds32/boot
-- 
2.17.0
