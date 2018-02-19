Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBSBRt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 20:17:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751884AbeBSBRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 20:17:48 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v3 0/3] jump_label: Robustify jump label patching
Date: Sun, 18 Feb 2018 19:17:18 -0600
Message-Id: <cover.1519002843.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Make init_kernel_text() global
- Use braces in multi-line 'for' statements

v2:
- Refine the warning so that it doesn't warn about __init entries
- (Do so by explicitly disabling __init entries)
- Drop v1 patches which removed __init tracepoints

Josh Poimboeuf (3):
  jump_label: Explicitly disable jump labels in __init code
  jump_label: Warn on failed jump_label patch
  extable: Make init_kernel_text() global

 arch/x86/kernel/unwind_orc.c |  3 +--
 include/linux/jump_label.h   |  3 +++
 include/linux/kernel.h       |  1 +
 init/main.c                  |  2 ++
 kernel/extable.c             |  2 +-
 kernel/jump_label.c          | 27 ++++++++++++++++++++++-----
 6 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.14.3
