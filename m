Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeCCEXW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 23:23:22 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35895 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeCCEXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 23:23:21 -0500
X-Google-Smtp-Source: AG47ELvdDxMEyvPBrDjJtq0z/TYW6OajhJhN/Pu+pkprgn2YZ4FbZ2vnYOogS4V/IVScwBQCRw8cuw==
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] coresight: use %px to print pcsr instead of %p
Date: Sat,  3 Mar 2018 12:23:01 +0800
Message-Id: <1520050981-17129-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
printk specifier %p to hash all addresses before printing, this was
resulting in the high 32 bits of pcsr can only output zeros.  So
module cannot completely print pc value and it's pointless for debugging
purpose.

This patch fixes this by using %px to print pcsr instead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 6ea62c6..9cdb3fb 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -315,7 +315,7 @@ static void debug_dump_regs(struct debug_drvdata *drvdata)
 	}
 
 	pc = debug_adjust_pc(drvdata);
-	dev_emerg(dev, " EDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
+	dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
 
 	if (drvdata->edcidsr_present)
 		dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);
-- 
2.7.4
