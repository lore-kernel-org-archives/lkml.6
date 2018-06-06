Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C55B460555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeFFOLO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbeFFOLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:11:12 -0400
Date: Wed, 6 Jun 2018 10:11:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Changbin Du <changbin.du@intel.com>,
        kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] sparc/time: Add missing __init to init_tick_ops()
Message-ID: <20180606101110.1a309846@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Code that was added to force gcc not to inline any function that isn't
explicitly declared as inline uncovered that init_tick_ops() isn't
marked as "__init". It is only called by __init functions and more
importantly it too calls an __init function which would require it to be
__init as well.

Link: http://lkml.kernel.org/r/201806060444.hdHcKOBy%fengguang.wu@intel.com

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 2ef8cfa9677e..f0eba72aa1ad 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -814,7 +814,7 @@ static void __init get_tick_patch(void)
 	}
 }
 
-static void init_tick_ops(struct sparc64_tick_ops *ops)
+static void __init init_tick_ops(struct sparc64_tick_ops *ops)
 {
 	unsigned long freq, quotient, tick;
 
