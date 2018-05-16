Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeEPX5D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 19:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751830AbeEPX5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 19:57:01 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH -tip v3 0/7] kprobes: x86: Cleanup jprobe implementation on x86
Date: Thu, 17 May 2018 08:56:36 +0900
Message-Id: <152651499561.25583.14488389770693278906.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since we decided to remove jprobe from kernel last year,
its APIs are disabled and we worked on moving in-kernel
jprobe users to kprobes or trace-events. And now no jprobe
users are here anymore.

This is the 3rd version of the series for removing jprobe
from x86 and generic code. V2 is here;

 http://lkml.org/lkml/2018/3/12/558

Changes from v2 are;
 - [1/7] Imported from another series. Just a documentation
   fix.
 - [6/7] Imported from another series. Simplifying execution
   path modifying behavior.
 - [7/7] Modified based on [6/7], because it has done a half
   of changes what this patch does.

I am preparing other series which removes jprobe from
each arch. After all those patches are merged, I will remove
jprobes APIs and data structures, since changing those
definitions will break build on other archs.

Thank you,

---

Masami Hiramatsu (7):
      Documentation/kprobes: Fix to remove remaining jprobe
      kprobes: Remove jprobe API implementation
      x86: kprobes: Remove jprobe implementation
      kprobes: Ignore break_handler
      x86: kprobes: Ignore break_handler
      bpf: error-inject: x86: Fix unbalanced preempt-count for function override
      x86: kprobes: Do not disable preempt on int3 path


 Documentation/kprobes.txt        |   15 ++---
 arch/x86/include/asm/kprobes.h   |    3 -
 arch/x86/kernel/kprobes/common.h |   10 ---
 arch/x86/kernel/kprobes/core.c   |  116 ++------------------------------------
 arch/x86/kernel/kprobes/ftrace.c |   31 +++-------
 arch/x86/kernel/kprobes/opt.c    |    1 
 include/linux/kprobes.h          |    3 -
 kernel/fail_function.c           |    3 -
 kernel/kprobes.c                 |  115 ++------------------------------------
 kernel/test_kprobes.c            |   94 -------------------------------
 kernel/trace/trace_kprobe.c      |   11 +---
 11 files changed, 32 insertions(+), 370 deletions(-)

--
Masami Hiramatsu (Linaro)
