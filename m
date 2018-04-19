Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDSNUR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33869 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeDSNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:13 -0400
X-Google-Smtp-Source: AIpwx48M9h4x0pMglHjVCZ0kUpZISz7vtrs0KPzr4Ap/YllbFrCIp8YKbRKOdlz8qcuFXTKUAG14RQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 7/9] nds32: Fix the unknown type u8 issue.
Date: Thu, 19 Apr 2018 21:18:13 +0800
Message-Id: <73a61d707cb3a752a676f751e53d55850ad54d43.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It broke the 'allmodconfig' build.
We need to include <linux/types.h> to make sure the type is defined
before using it.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index 966e71b3c960..71cd226d6863 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -4,6 +4,8 @@
 #ifndef __ASM_NDS32_IO_H
 #define __ASM_NDS32_IO_H
 
+#include <linux/types.h>
+
 extern void iounmap(volatile void __iomem *addr);
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
-- 
1.9.5
