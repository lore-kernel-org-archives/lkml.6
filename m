Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeCGKMG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:12:06 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41539 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeCGKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:12:03 -0500
X-Google-Smtp-Source: AG47ELv7LD70KxSifBBy3JShhP06RnEE6j+HhkqvGTnDpnwsWmvu5u26IqocfWL3A9pdldgHpeEpdQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com
Subject: [PATCH] nds32: fix building failed if using elf toolchain.
Date: Wed,  7 Mar 2018 18:11:03 +0800
Message-Id: <20180307101103.28742-1-greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OUTPUT_FORMAT is not necessary here and the elf toolchain doesn't
support these formats. Since kernel should be built pass with elf
or Linux toolchain. This can be removed from vdso.ld.S

These are the built failed messages.
  VDSOL   arch/nds32/kernel/vdso/vdso.so.dbg
  /home/users/greentime/tmp/nds32le-elf-newlib-v3-upstream-b224/bin/../lib/gcc/nds32le-elf/8.0.1/../../../../nds32le-elf/bin/ld:
  target elf32-nds32le-linux not found
  collect2: error: ld returned 1 exit status
  make[1]: *** [arch/nds32/kernel/vdso/vdso.so.dbg] Error 1
  make: *** [vdso_prepare] Error 2

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/vdso/vdso.lds.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/kernel/vdso/vdso.lds.S b/arch/nds32/kernel/vdso/vdso.lds.S
index 36630352ee02..1f2b16004594 100644
--- a/arch/nds32/kernel/vdso/vdso.lds.S
+++ b/arch/nds32/kernel/vdso/vdso.lds.S
@@ -8,7 +8,6 @@
 #include <asm/page.h>
 #include <asm/vdso.h>
 
-OUTPUT_FORMAT("elf32-nds32le-linux", "elf32-nds32be-linux", "elf32-nds32le-linux")
 OUTPUT_ARCH(nds32)
 
 SECTIONS
-- 
2.16.1
