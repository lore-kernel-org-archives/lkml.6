Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031885AbeBPQbZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:31:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031559AbeBPQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:31:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2 0/2] jump_label: Robustify jump label patching
Date: Fri, 16 Feb 2018 10:31:13 -0600
Message-Id: <cover.1518798288.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Refine the warning so that it doesn't warn about __init entries
- (Do so by explicitly disabling __init entries)
- Drop v1 patches which removed __init tracepoints

Josh Poimboeuf (2):
  jump_label: Explicitly disable jump labels in __init code
  jump_label: Warn on failed jump_label patch

 include/linux/jump_label.h |  3 +++
 init/main.c                |  2 ++
 kernel/jump_label.c        | 31 ++++++++++++++++++++++++-------
 3 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.14.3
