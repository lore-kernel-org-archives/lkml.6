Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422756AbeE1MdU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164612AbeE1K7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:59:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 406/496] coresight: Use %px to print pcsr instead of %p
Date: Mon, 28 May 2018 12:03:11 +0200
Message-Id: <20180528100336.871242813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 831c326fcd0e8e2a6ece952f898a1ec9b1dc1004 ]

Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
printk specifier %p to hash all addresses before printing, this was
resulting in the high 32 bits of pcsr can only output zeros.  So
module cannot completely print pc value and it's pointless for debugging
purpose.

This patch fixes this by using %px to print pcsr instead.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -315,7 +315,7 @@ static void debug_dump_regs(struct debug
 	}
 
 	pc = debug_adjust_pc(drvdata);
-	dev_emerg(dev, " EDPCSR:  [<%p>] %pS\n", (void *)pc, (void *)pc);
+	dev_emerg(dev, " EDPCSR:  [<%px>] %pS\n", (void *)pc, (void *)pc);
 
 	if (drvdata->edcidsr_present)
 		dev_emerg(dev, " EDCIDSR: %08x\n", drvdata->edcidsr);
