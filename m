Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934435AbeE1V6D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 17:58:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39578 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933936AbeE1V6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 17:58:02 -0400
X-Google-Smtp-Source: ADUXVKI+NrK0/2MHmBZe1SKbT1BK99+2b7f4J+dPajnoXs7876/JwS7tWj0vkU9mNn61mcC/2ZBJoA==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 00/20] signal: refactor some functions
Date: Mon, 28 May 2018 23:53:35 +0200
Message-Id: <20180528215355.16119-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This series refactors a bunch of functions in signal.c to simplify parts
of the code.
The greatest single change is declaring the static do_sigpending()
helper as void which makes it possible to remove a bunch of unnecessary
checks in the syscalls later on.

Thanks!
Christian

Christian Brauner (20):
  signal: make force_sigsegv() void
  signal: make kill_as_cred_perm() return bool
  signal: make may_ptrace_stop() return bool
  signal: add copy_pending() helper
  signal: flatten do_send_sig_info()
  signal: drop else branch in do_signal_stop()
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
 kernel/signal.c              | 269 ++++++++++++++++++-----------------
 3 files changed, 140 insertions(+), 135 deletions(-)

-- 
2.17.0
