Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032803AbeBNQlU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:41:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032470AbeBNQlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:41:16 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 0/3] jump_label: Robustify jump label patching
Date: Wed, 14 Feb 2018 10:40:40 -0600
Message-Id: <cover.1518626149.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warn if a jump_label fails to patch, and fix up a couple of issues found
by the warning.

Josh Poimboeuf (3):
  jump_label: Warn on failed jump_label patch
  x86/xen: Remove inert tracepoint in __init code
  percpu: Remove inert tracepoint in __init code

 arch/x86/xen/enlighten_pv.c | 2 --
 kernel/jump_label.c         | 8 ++++++--
 mm/percpu.c                 | 1 -
 3 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.14.3
