Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeEHNgu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932095AbeEHNgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:36:49 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: mhiramat@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH -tip 0/4] kprobes: x86: Remove jprobes related code
Date: Tue,  8 May 2018 22:36:24 +0900
Message-Id: <152578658468.31022.8952561651556318637.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a core part of removing jprobes related
code from generic part and x86 tree. This also simplifies
the preparation code for function override by balancing
preempt count and current kprobe setting inside
kprobe_int3_handler and kprobe_ftrace_handler.

 [1/4]: Trivial cleanup, remove a remaining "jps" word
        from document.
 [2/4]: Remove arch-independent jprobe code from
        kernel/kprobes.c. This prevents link errors
        after removing arch dependent jprobe ports.
 [3/4]: Remove x86 jprobe port.
 [4/4]: Simplify preempt count and current kprobe setting
        inside kprobe_int3_handler and kprobe_ftrace_handler.

I'm preparing similar patches for other archs. But I think
this series can be (and should be) merged first, since
the function override feature (which is the only in-tree
component affected by this change) is implemented on x86.

Thank you,

---

Masami Hiramatsu (4):
      Documentation/kprobes: Fix to remove remaining jprobe
      kprobes: Remove jprobe generic code
      kprobes: x86: Remove jprobe x86 port
      bpf: error-inject: x86: Fix unbalanced preempt-count for function override


 Documentation/kprobes.txt        |    2 -
 arch/x86/include/asm/kprobes.h   |    3 -
 arch/x86/kernel/kprobes/core.c   |  113 ++++----------------------------------
 arch/x86/kernel/kprobes/ftrace.c |   16 +++--
 kernel/fail_function.c           |    3 -
 kernel/kprobes.c                 |   76 --------------------------
 kernel/trace/trace_kprobe.c      |   11 +---
 7 files changed, 24 insertions(+), 200 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
