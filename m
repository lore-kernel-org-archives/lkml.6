Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeDPOtL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:49:11 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62357 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeDPOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:49:05 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtu017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] MIPS: boot: merge build rules of vmlinux.*.itb by using pattern rule
Date: Mon, 16 Apr 2018 23:47:46 +0900
Message-Id: <1523890067-13641-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the build rule of vmlinux.{gz,bz2,lzma,lzo}.itb, and also move
'targets' close to the related code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 91d9fe8..d102d53 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -105,12 +105,6 @@ $(obj)/uImage: $(obj)/uImage.$(suffix-y)
 # Flattened Image Tree (.itb) images
 #
 
-targets += vmlinux.itb
-targets += vmlinux.gz.itb
-targets += vmlinux.bz2.itb
-targets += vmlinux.lzma.itb
-targets += vmlinux.lzo.itb
-
 ifeq ($(ADDR_BITS),32)
 	itb_addr_cells = 1
 endif
@@ -157,6 +151,12 @@ $(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzma FORCE
 $(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
+targets += vmlinux.itb
+targets += vmlinux.gz.itb
+targets += vmlinux.bz2.itb
+targets += vmlinux.lzma.itb
+targets += vmlinux.lzo.itb
+
 quiet_cmd_itb-image = ITB     $@
       cmd_itb-image = \
 		env PATH="$(objtree)/scripts/dtc:$(PATH)" \
@@ -169,14 +169,5 @@ quiet_cmd_itb-image = ITB     $@
 $(obj)/vmlinux.itb: $(obj)/vmlinux.its $(obj)/vmlinux.bin FORCE
 	$(call if_changed,itb-image,$<)
 
-$(obj)/vmlinux.gz.itb: $(obj)/vmlinux.gz.its $(obj)/vmlinux.bin.gz FORCE
-	$(call if_changed,itb-image,$<)
-
-$(obj)/vmlinux.bz2.itb: $(obj)/vmlinux.bz2.its $(obj)/vmlinux.bin.bz2 FORCE
-	$(call if_changed,itb-image,$<)
-
-$(obj)/vmlinux.lzma.itb: $(obj)/vmlinux.lzma.its $(obj)/vmlinux.bin.lzma FORCE
-	$(call if_changed,itb-image,$<)
-
-$(obj)/vmlinux.lzo.itb: $(obj)/vmlinux.lzo.its $(obj)/vmlinux.bin.lzo FORCE
+$(obj)/vmlinux.%.itb: $(obj)/vmlinux.%.its $(obj)/vmlinux.bin.% FORCE
 	$(call if_changed,itb-image,$<)
-- 
2.7.4
