Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeFDUb1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:31:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44770 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeFDUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:30:46 -0400
X-Google-Smtp-Source: ADUXVKJEFpXIsmcScKDh7llcrMdJ/lSmpo8hIvaItNHHQ6839fjEQKDjRMScCZQHSKqjlEYuvyikDg==
Subject: [PATCH] riscv/ftrace: Export _mcount when FUNCTION_GRAPH_TRACER isn't set
Date: Mon,  4 Jun 2018 13:30:28 -0700
Message-Id: <20180604203028.13886-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180604203028.13886-1-palmer@sifive.com>
References: <1525749717-384-1-git-send-email-alankao@andestech.com>
 <20180604203028.13886-1-palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org, Greentime Hu <greentime@andestech.com>,
        Zong Li <zong@andestech.com>, Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alankao@andestech.com, linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Kao <alankao@andestech.com>

The EXPORT_SYMBOL(_mcount) for RISC-V ended up inside a
CONFIG_FUNCTION_GRAPH_TRACER ifdef.  If you enable modules without
enabling CONFIG_FUNCTION_GRAPH_TRACER then you'll get a build error
without this patch because the modules won't be able to find _mcount.

The new behavior is to export _mcount whenever CONFIG_FUNCTION_TRACER is
defined.  This matches what every other architecture is doing.

Signed-off-by: Alan Kao <alankao@andestech.com>
Cc: Greentime Hu <greentime@andestech.com>
Cc: Zong Li <zong@andestech.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
2.16.4
