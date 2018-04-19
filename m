Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDSNUm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35530 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeDSNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:15 -0400
X-Google-Smtp-Source: AIpwx4+zIh17lToE9KCbu8ieNbRVVF8cbdDnKXJKJtA0ch2+Dqc9wXuOpupmk/W0wO942+Xf1T93sQ==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 8/9] nds32: Fix build failed because arch_trace_hardirqs_off is changed to trace_hardirqs_off.
Date: Thu, 19 Apr 2018 21:18:14 +0800
Message-Id: <7e2d53a7f23e6ad4100e9744c798460437d6a113.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It broke the 'allmodconfig' build when CONFIG_TRACE_IRQFLAGS is enabled.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/ex-entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/ex-entry.S b/arch/nds32/kernel/ex-entry.S
index a72e83d804f5..b8ae4e9a6b93 100644
--- a/arch/nds32/kernel/ex-entry.S
+++ b/arch/nds32/kernel/ex-entry.S
@@ -118,7 +118,7 @@ common_exception_handler:
 	/* interrupt */
 2:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	jal     arch_trace_hardirqs_off
+	jal     trace_hardirqs_off
 #endif
 	move	$r0, $sp
 	sethi	$lp, hi20(ret_from_intr)
-- 
1.9.5
