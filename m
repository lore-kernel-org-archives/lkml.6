Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeFANWs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:22:48 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47008 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeFANWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:22:46 -0400
X-Google-Smtp-Source: ADUXVKIE2xMdUM866M4qqr6Gvxt1+iZVPTGI+pFQg3FTh9RaZLOHpRM/bd82BqHSQsqTkR4yGJFnkA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 00/20] signal: refactor some functions
Date: Fri,  1 Jun 2018 15:22:22 +0200
Message-Id: <20180601132239.4421-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This series refactors a bunch of functions in signal.c to simplify parts
of the code.
As requested, v2 drops all 3 commits that were pure coding-style
changes. The only other coding-style change is the simplification of
rt_sigaction which seemed to be worth keeping.
The greatest single change is declaring the static do_sigpending()
helper as void which makes it possible to remove a bunch of unnecessary
checks in the syscalls later on.

Thanks!
Christian


Christian Brauner (17):
  signal: make force_sigsegv() void
  signal: make kill_as_cred_perm() return bool
  signal: make may_ptrace_stop() return bool
  signal: make do_sigpending() void
  signal: simplify rt_sigaction()
  signal: make kill_ok_by_cred() return bool
  signal: make sig_handler_ignored() return bool
  signal: make sig_task_ignored() return bool
  signal: make sig_ignored() return bool
  signal: make has_pending_signals() return bool
  signal: make recalc_sigpending_tsk() return bool
  signal: make unhandled_signal() return bool
  signal: make flush_sigqueue_mask() void
  signal: make wants_signal() return bool
  signal: make legacy_queue() return bool
  signal: make security_task_kill() return bool
  signal: make get_signal() return bool

 include/linux/sched/signal.h |   2 +-
 include/linux/signal.h       |   4 +-
 kernel/signal.c              | 200 +++++++++++++++++------------------
 3 files changed, 103 insertions(+), 103 deletions(-)

-- 
2.17.0
