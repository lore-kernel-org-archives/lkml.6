Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755268AbeDTNd1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:33:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40608 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754762AbeDTNdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:18 -0400
X-Google-Smtp-Source: AIpwx48ahde4cXq3IdFZyRpkyA8XY68YpvP3LVP1NxeC/XTRN4jv2O8HqtwguFBTYPBxHSmTHxEbaA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 8/9] nds32: Fix build failed because arch_trace_hardirqs_off is changed to trace_hardirqs_off.
Date: Fri, 20 Apr 2018 21:31:14 +0800
Message-Id: <dd3fca8e531473946b4ec895b7045982ecbf0aaa.1524229040.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It broke the 'allmodconfig' build when CONFIG_TRACE_IRQFLAGS is enabled.

Signed-off-by: Nick Chun-Ming Hu <nickhu@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
