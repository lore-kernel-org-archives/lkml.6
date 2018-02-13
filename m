Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeBMFmQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:42:16 -0500
Received: from exmail.andestech.com ([59.124.169.137]:7431 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeBMFmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:42:15 -0500
From: Alan Kao <alankao@andestech.com>
To: Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        "Steven Rostedt" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        <patches@groups.riscv.org>, <linux-kernel@vger.kernel.org>,
        <greentime@andestech.com>
CC: Alan Kao <alankao@andestech.com>
Subject: [PATCH v4 0/6] Add dynamic ftrace support for RISC-V platforms
Date: Tue, 13 Feb 2018 13:13:15 +0800
Message-ID: <1518498801-677-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w1D5Ft9P046186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set includes the building blocks of dynamic ftrace features
for RISC-V machines.

Changes in v4:
 - Organize code structure according to changes in v3
 - Rebase onto the riscv-linux-4.15 branch at github's 
   riscv/riscv-linux repo.  Note that this set is based on the previous
   ftrace patch, which provided basic support.

Changes in v3:
 - Replace the nops at the tracer call sites into "call ftrace_stub"
   instructions for better understanding (1/6, 2/6 and 5/6)

Changes in v2:
 - Fix the return value as writing to kernel text goes wrong (2/6)
 - Replace manual comparisons by calling memcmp (2/6)
 - Simplify the conditional assignment in the Makefile (1/6)

Alan Kao (6):
  riscv/ftrace: Add RECORD_MCOUNT support
  riscv/ftrace: Add dynamic function tracer support
  riscv/ftrace: Add dynamic function graph tracer support
  riscv/ftrace: Add ARCH_SUPPORTS_FTRACE_OPS support
  riscv/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
  riscv/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support

 arch/riscv/Kconfig              |   3 +
 arch/riscv/Makefile             |   3 +
 arch/riscv/include/asm/ftrace.h |  56 ++++++++++
 arch/riscv/kernel/Makefile      |   5 +-
 arch/riscv/kernel/ftrace.c      | 175 ++++++++++++++++++++++++++++-
 arch/riscv/kernel/mcount-dyn.S  | 239 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/mcount.S      |  22 ++--
 arch/riscv/kernel/stacktrace.c  |   6 +
 scripts/recordmcount.pl         |   5 +
 9 files changed, 501 insertions(+), 13 deletions(-)
 create mode 100644 arch/riscv/kernel/mcount-dyn.S

-- 
2.15.1
