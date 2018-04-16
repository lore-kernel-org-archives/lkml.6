Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDPOtA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:49:00 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62200 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeDPOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:48:57 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w3GElqtt017749
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] MIPS: boot: add missing targets for vmlinux.*.its
Date: Mon, 16 Apr 2018 23:47:45 +0900
Message-Id: <1523890067-13641-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523890067-13641-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build rule of vmlinux.*.its is invoked by $(call if_changed,...)
but it always rebuilds the target needlessly due to missing targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 30512ab..91d9fe8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,12 @@ quiet_cmd_its_cat = CAT     $@
 $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
 	$(call if_changed,its_cat)
 
+targets += vmlinux.its
+targets += vmlinux.gz.its
+targets += vmlinux.bz2.its
+targets += vmlinux.lzmo.its
+targets += vmlinux.lzo.its
+
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) -P -C -o $@ $< \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
-- 
2.7.4
