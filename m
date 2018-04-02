Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeDBKXy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:23:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37914 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbeDBKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:23:53 -0400
X-Google-Smtp-Source: AIpwx49AOjzKJ8D1wqrI3zO+YUVRibxYQJvI7BRza7E210u6JkD3lh4xC6S3JBhApJPvREQvoR7knw==
Date: Mon, 2 Apr 2018 12:23:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] sched/wait changes for v4.17
Message-ID: <20180402102349.iakrkipurlale2oc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-wait-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-wait-for-linus

   # HEAD: b3fc5c9bb373661224906bf434c09ca0de032e82 sched/wait: Improve __var_waitqueue() code generation

NOTE: this tree depends on the sched/core tree - if you have not pulled that tree 
      then please disregard this pull request.

This tree introduces the new wait_var_event() API, which is a more flexible 
waiting primitive than wait_on_atomic_t(). All wait_on_atomic_t() users are 
migrated over to the new API and wait_on_atomic_t() is removed. The migration 
fixes one bug and should result in no functional changes for the other usecases.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (11):
      sched/wait: Introduce wait_var_event()
      sched/wait, drivers/drm: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, drivers/media: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, fs/afs: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, fs/btrfs: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, fs/fscache: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, fs/nfs: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, fs/ocfs2: Convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait, arch/mips: Fix and convert wait_on_atomic_t() usage to the new wait_var_event() API
      sched/wait: Remove the wait_on_atomic_t() API
      sched/wait: Improve __var_waitqueue() code generation


 arch/mips/kernel/process.c                         |   2 +
 arch/mips/kernel/traps.c                           |   4 +-
 drivers/gpu/drm/drm_dp_aux_dev.c                   |  13 +--
 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  14 +--
 drivers/media/platform/qcom/venus/hfi.c            |   8 +-
 fs/afs/cell.c                                      |   6 +-
 fs/afs/rxrpc.c                                     |   6 +-
 fs/afs/server.c                                    |   6 +-
 fs/btrfs/extent-tree.c                             |  14 ++-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/fscache/cookie.c                                |   7 +-
 fs/nfs/inode.c                                     |   5 -
 fs/nfs/pagelist.c                                  |   6 +-
 fs/nfs/pnfs_nfs.c                                  |   2 +-
 fs/nfs/write.c                                     |   6 +-
 fs/ocfs2/filecheck.c                               |   9 +-
 include/linux/fscache-cache.h                      |   2 +-
 include/linux/wait_bit.h                           |  95 +++++++++++++-----
 kernel/sched/wait_bit.c                            | 110 +++++----------------
 19 files changed, 147 insertions(+), 170 deletions(-)
