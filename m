Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbeE1Ntp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:49:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43372 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755244AbeE1Ntd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:49:33 -0400
X-Google-Smtp-Source: AB8JxZpsvY8AHqW5EFYS1fMdgVycN9MFNKNNBjZlxrfpRBDZwfT4x9mOH99JzLHEUQJ92AhihHv3Zg==
From: Christian Brauner <christian@brauner.io>
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/8] signal: refactor some functions
Date: Mon, 28 May 2018 15:49:08 +0200
Message-Id: <20180528134916.7568-1-christian@brauner.io>
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

Christian Brauner (8):
  signal: make force_sigsegv() void
  signal: make kill_as_cred_perm() return bool
  signal: make may_ptrace_stop() return bool
  signal: add copy_pending() helper
  signal: flatten do_send_sig_info()
  signal: drop else branch in do_signal_stop()
  signal: make do_sigpending() void
  signal: simplify rt_sigaction()

 include/linux/sched/signal.h |   2 +-
 kernel/signal.c              | 154 +++++++++++++++++------------------
 2 files changed, 78 insertions(+), 78 deletions(-)

-- 
2.17.0
