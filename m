Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033108AbeCAQlc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:41:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41856 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032905AbeCAQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:41:31 -0500
X-Google-Smtp-Source: AG47ELugzjFvu3PX4GOLOTai55ZfiETivY7E/mF65Dm/KBIxSvhwOUsXMgdeyc7xfT01E/oxZApd2g==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com
Subject: [PATCH] nds32: fix building failed if using older version gcc.
Date: Fri,  2 Mar 2018 00:40:36 +0800
Message-Id: <20180301164036.10941-1-greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be built failed because these options are not supported by older
version gcc.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
index 54b4de9d48b6..91f933d5a962 100644
--- a/arch/nds32/Makefile
+++ b/arch/nds32/Makefile
@@ -5,7 +5,8 @@ KBUILD_DEFCONFIG := defconfig
 
 comma = ,
 
-KBUILD_CFLAGS	+=-mno-sched-prolog-epilog -mcmodel=large
+KBUILD_CFLAGS	+= $(call cc-option, -mno-sched-prolog-epilog)
+KBUILD_CFLAGS	+= -mcmodel=large
 
 KBUILD_CFLAGS	+=$(arch-y) $(tune-y)
 KBUILD_AFLAGS	+=$(arch-y) $(tune-y)
@@ -33,9 +34,9 @@ BUILTIN_DTB := n
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-KBUILD_CFLAGS   += -EL
+KBUILD_CFLAGS   += $(call cc-option, -EL)
 else
-KBUILD_CFLAGS   += -EB
+KBUILD_CFLAGS   += $(call cc-option, -EB)
 endif
 
 boot := arch/nds32/boot
-- 
2.16.1
