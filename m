Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbeEIM6O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934795AbeEIM6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:58:11 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 0/2] uprobes: x86: Reject probing MOV SS
Date: Wed,  9 May 2018 21:57:44 +0900
Message-Id: <152587066475.17316.3035446966107675608.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the CVE-2018-1087 and CVE-2018-8897 should
be related to kprobes and uprobes too, since both
are using #DB for single stepping.

I decided to just reject probes on MOV SS and POP SS
because those are not recommended to use (Intel SDM
recommend to use LSS instead), thus it might be
rare case.

Oleg, could you review the uprobes patch?

Thank you,

---

Masami Hiramatsu (2):
      kprobes: x86: Prohibit probing on exception masking instructions
      uprobes: x86: Prohibit probing on MOV SS instruction


 arch/x86/include/asm/insn.h    |   18 ++++++++++++++++++
 arch/x86/kernel/kprobes/core.c |    4 ++++
 arch/x86/kernel/uprobes.c      |    4 ++++
 3 files changed, 26 insertions(+)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
