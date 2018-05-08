Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeEHDWj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:22:39 -0400
Received: from exmail.andestech.com ([59.124.169.137]:63688 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753869AbeEHDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:22:37 -0400
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
CC: Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>, Zong Li <zong@andestech.com>
Subject: [PATCH] riscv/ftrace: Fix the problem modules cannot find _mcount
Date: Tue, 8 May 2018 11:21:57 +0800
Message-ID: <1525749717-384-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w483E771024497
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling ftrace and module support at the same time fails the kernel
build process, because modules cannot find the _mcount symbol.  This
patch fixes this issue.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/mcount.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index ce9bdc57a2a1..5721624886a1 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -126,5 +126,5 @@ do_trace:
 	RESTORE_ABI_STATE
 	ret
 ENDPROC(_mcount)
-EXPORT_SYMBOL(_mcount)
 #endif
+EXPORT_SYMBOL(_mcount)
-- 
2.17.0
