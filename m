Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755221AbeDTNdN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:33:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40926 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754762AbeDTNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:06 -0400
X-Google-Smtp-Source: AIpwx485mWS5dbkF7UBYWIAb/YaqCb0yhTrFr9ejvqZNacDOyj8H52fbJBAq4Jila5k7L+wCyEgHhg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 3/9] nds32: Fix building error of crypto/xor.c by adding xor.h
Date: Fri, 20 Apr 2018 21:31:09 +0800
Message-Id: <bccb20f66f26cc8b9d17967266e0e2d8ebcc6f78.1524229038.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compiled with allmodconfig, it caused this building failed.
crypto/xor.c:25:21: fatal error: asm/xor.h: No such file or directory
 #include <asm/xor.h>
                     ^
compilation terminated.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 06bdf8167f5a..a64e87cc8b49 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -49,6 +49,7 @@ generic-y += switch_to.h
 generic-y += timex.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += xor.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
-- 
1.9.5
