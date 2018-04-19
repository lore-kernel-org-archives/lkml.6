Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeDSNUJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45782 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeDSNUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:06 -0400
X-Google-Smtp-Source: AIpwx49KnakEYSygUXvfRRJtPF5f+Z4ohqCjZUNLjGUd3i+mSjBAlvJKVGPKkghjp+I33XqRq5JUyw==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 3/9] nds32: Fix building error of crypto/xor.c by adding xor.h
Date: Thu, 19 Apr 2018 21:18:09 +0800
Message-Id: <7c7825953c7262fdbe5eeed124ed020701601a68.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I compiled with allmodconfig, it caused this building failed.
crypto/xor.c:25:21: fatal error: asm/xor.h: No such file or directory
 #include <asm/xor.h>
                     ^
compilation terminated.

Signed-off-by: Greentime Hu <greentime@andestech.com>
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
