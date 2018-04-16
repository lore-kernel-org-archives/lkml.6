Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDPOuw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:50:52 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64268 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPOur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:50:47 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqts017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] MIPS: boot: correct prerequisite image of vmlinux.*.its
Date: Mon, 16 Apr 2018 23:47:44 +0900
Message-Id: <1523890067-13641-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.*.its does not directly depend on $(VMLINUX) but
vmlinux.bin.*

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 6c7054e..30512ab 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -136,19 +136,19 @@ quiet_cmd_cpp_its_S = ITS     $@
 			-DADDR_BITS=$(ADDR_BITS) \
 			-DADDR_CELLS=$(itb_addr_cells)
 
-$(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin FORCE
 	$(call if_changed,cpp_its_S,none,vmlinux.bin)
 
-$(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,cpp_its_S,gzip,vmlinux.bin.gz)
 
-$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
+$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.bz2 FORCE
 	$(call if_changed,cpp_its_S,bzip2,vmlinux.bin.bz2)
 
-$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzma FORCE
 	$(call if_changed,cpp_its_S,lzma,vmlinux.bin.lzma)
 
-$(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(obj)/vmlinux.bin.lzo FORCE
 	$(call if_changed,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 quiet_cmd_itb-image = ITB     $@
-- 
2.7.4
