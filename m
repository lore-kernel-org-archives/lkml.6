Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeFET0T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:26:19 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33788 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeFET0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:26:17 -0400
X-Google-Smtp-Source: ADUXVKKVBWvQRrUJ4FiWBrEkmleZJZclo3m8XaQn4nttfD1D472Teia3cCunr0nJQa87tSCY9vIt3Q==
Date: Tue, 5 Jun 2018 12:26:14 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v4.18-rc1
Message-ID: <20180605192614.GH1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

* Patches to make kworkers to report the workqueue it is executing or
  has executed most recently in /proc/PID/comm.

* CONFIG_SMP shuffle to move stuff which isn't necessary for UP builds
  inside CONFIG_SMP.

Thanks.

The following changes since commit e6506eb241871d68647c53cb6d0a16299550ae97:

  Merge tag 'trace-v4.17-rc4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2018-05-16 16:45:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-4.18

for you to fetch changes up to 66448bc274cadedb71fda7d914e7c29d8dead217:

  workqueue: move function definitions within CONFIG_SMP block (2018-05-23 11:16:58 -0700)

----------------------------------------------------------------
Mathieu Malaterre (1):
      workqueue: move function definitions within CONFIG_SMP block

Tejun Heo (6):
      workqueue: Replace pool->attach_mutex with global wq_pool_attach_mutex
      workqueue: Make worker_attach/detach_pool() update worker->pool
      workqueue: Set worker->desc to workqueue name by default
      proc: Consolidate task->comm formatting into proc_task_name()
      workqueue: Show the latest workqueue name in /proc/PID/{comm,stat,status}
      workqueue: Make sure struct worker is accessible for wq_worker_comm()

 fs/proc/array.c             |  33 ++++++-----
 fs/proc/base.c              |   5 +-
 fs/proc/internal.h          |   2 +
 include/linux/workqueue.h   |   1 +
 kernel/workqueue.c          | 139 +++++++++++++++++++++++++++++---------------
 kernel/workqueue_internal.h |   3 +-
 6 files changed, 119 insertions(+), 64 deletions(-)

-- 
tejun
