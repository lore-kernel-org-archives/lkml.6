Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeDPJt1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:49:27 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34403 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeDPJtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:49:25 -0400
X-Google-Smtp-Source: AIpwx4/q5cUyX3v0vuK2z+BhGVjFO0oso5W935HFU6irQdgnlwgtkiNaaDDdrQkiCeRPokraFd4tvQ==
Date: Mon, 16 Apr 2018 11:49:20 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [GIT PULL] fuse update for 4.17
Message-ID: <20180416094920.GE19579@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-linus

Late pull request, sorry.  I just totally forgot about it, probably because fuse
updates are so rare these days (hoping to get back to regular fuse updates once
overlayfs is "finished").

This contains a few fixes and minor improvements, but the most interesting part
is user namespace support, mostly done by Eric Biederman.  This doesn't yet
enable unprivileged mounting of fuse filesystems, but that's now a really simple
step, since all support for that should be in place.

Thanks,
Miklos

---
Eric W. Biederman (3):
      fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
      fuse: Fail all requests with invalid uids or gids
      fuse: Support fuse filesystems outside of init_user_ns

Miklos Szeredi (4):
      fuse: atomic_o_trunc should truncate pagecache
      fuse: honor AT_STATX_DONT_SYNC
      fuse: honor AT_STATX_FORCE_SYNC
      fuse: add writeback documentation

Seth Forshee (1):
      fuse: Restrict allow_other to the superblock's namespace or a descendant

Szymon Lukasz (1):
      fuse: return -ECONNABORTED on /dev/fuse read after abort

---
 Documentation/filesystems/fuse-io.txt | 38 +++++++++++++++++++++++++++++
 fs/fuse/acl.c                         |  4 ++--
 fs/fuse/control.c                     |  2 +-
 fs/fuse/cuse.c                        | 11 ++++++---
 fs/fuse/dev.c                         | 40 +++++++++++++++----------------
 fs/fuse/dir.c                         | 45 +++++++++++++++++++++++++----------
 fs/fuse/fuse_i.h                      | 14 +++++++++--
 fs/fuse/inode.c                       | 40 +++++++++++++++++++------------
 include/uapi/linux/fuse.h             |  7 +++++-
 kernel/user_namespace.c               |  1 +
 10 files changed, 145 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/filesystems/fuse-io.txt
